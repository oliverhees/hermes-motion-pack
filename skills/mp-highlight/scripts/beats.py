#!/usr/bin/env python3
"""beats.py <audio> --out beats.json [--bpm N] — onset/energy-based beat grid. Pure ffmpeg + numpy (no librosa).
Outputs: bpm, beats[] (s), downbeats[] (every 4th), energy[] per beat (0-1), drop (s of max energy rise), duration."""
import argparse, json, subprocess, numpy as np
ap=argparse.ArgumentParser(); ap.add_argument('audio'); ap.add_argument('--out',required=True); ap.add_argument('--bpm',type=float,default=None)
a=ap.parse_args(); SR=22050
raw=subprocess.run(['ffmpeg','-v','error','-i',a.audio,'-ac','1','-ar',str(SR),'-f','f32le','-'],capture_output=True).stdout
y=np.frombuffer(raw,dtype=np.float32); dur=len(y)/SR
hop=512; frames=np.lib.stride_tricks.sliding_window_view(y,2048)[::hop]
env=np.sqrt((frames**2).mean(1)); onset=np.maximum(0,np.diff(env,prepend=env[0])); onset/= (onset.max() or 1)
fps=SR/hop
if a.bpm: bpm=a.bpm
else:  # autocorrelation of onset envelope, 60-200 bpm
    ac=np.correlate(onset,onset,'full')[len(onset)-1:]; lags=np.arange(len(ac))
    lo,hi=int(fps*60/200),int(fps*60/60); seg=ac[lo:hi]; lag=lo+int(seg.argmax()); bpm=round(60*fps/lag,1)
    # prefer 90-160 range by octave folding
    while bpm<90: bpm*=2
    while bpm>170: bpm/=2
period=60/bpm
# phase: align grid to strongest onsets
cands=np.arange(0,period,period/32); best=(0,-1)
for ph in cands:
    grid=np.arange(ph,dur,period); idx=np.clip((grid*fps).astype(int),0,len(onset)-1); s=onset[idx].sum()
    if s>best[1]: best=(ph,s)
beats=[round(float(t),3) for t in np.arange(best[0],dur,period)]
energy=[]
for b in beats:
    i0,i1=int(b*fps),int((b+period)*fps); energy.append(float(env[i0:i1].mean()) if i1>i0 and i0<len(env) else 0.0)
e=np.array(energy); e=(e-e.min())/((e.max()-e.min()) or 1)
win=4; rise=[float(e[i:i+win].mean()-e[max(0,i-win):i].mean()) if i>=win else 0 for i in range(len(e))]
drop=beats[int(np.argmax(rise))] if beats else 0
json.dump({'audio':a.audio,'duration':round(dur,3),'bpm':bpm,'period':round(period,4),'beats':beats,
  'downbeats':beats[::4],'energy':[round(float(x),3) for x in e],'drop':drop},open(a.out,'w'),indent=1)
print(f"{a.audio}: {dur:.1f}s, {bpm} bpm, {len(beats)} beats, drop at {drop}s")

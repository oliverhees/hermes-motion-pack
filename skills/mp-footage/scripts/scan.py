#!/usr/bin/env python3
"""scan.py <video> --out scan.json [--intent action|emotion|recap] [--scene 0.3] [--top 12]
Per-second motion / loudness / speech scores + scene cuts + top moments. ffmpeg only, no ML."""
import argparse, json, math, re, subprocess
ap = argparse.ArgumentParser(); ap.add_argument('video'); ap.add_argument('--out', required=True)
ap.add_argument('--intent', default='action'); ap.add_argument('--scene', type=float, default=0.3); ap.add_argument('--top', type=int, default=12)
a = ap.parse_args()
def run(cmd): return subprocess.run(cmd, capture_output=True, text=True).stderr
dur = float(subprocess.run(['ffprobe','-v','error','-show_entries','format=duration','-of','csv=p=0',a.video],capture_output=True,text=True).stdout.strip())
N = max(1, int(math.ceil(dur)))
# motion
err = run(['ffmpeg','-v','info','-i',a.video,'-vf',"fps=2,scale=160:-1,format=gray,tblend=all_mode=difference,signalstats,metadata=print",'-f','null','-'])
motion=[0.0]*N; cnt=[0]*N
for t,v in re.findall(r'pts_time:([\d.]+)[^\n]*\n(?:[^\n]*\n)*?[^\n]*YAVG=([\d.]+)', err):
    i=min(int(float(t)),N-1); motion[i]+=float(v); cnt[i]+=1
motion=[m/c if c else 0 for m,c in zip(motion,cnt)]
# loudness (momentary, ebur128 log lines)
err = run(['ffmpeg','-v','info','-i',a.video,'-af','ebur128','-f','null','-'])
loud=[-70.0]*N
for t,v in re.findall(r't:\s*([\d.]+)\s+TARGET[^\n]*?M:\s*(-?[\d.]+)', err):
    i=min(int(float(t)),N-1); loud[i]=max(loud[i],float(v))
# speech-likelihood
def rms(filt):
    e=run(['ffmpeg','-v','info','-i',a.video,'-af',f"{filt}asetnsamples=48000,astats=metadata=1:reset=1,ametadata=print:key=lavfi.astats.Overall.RMS_level",'-ar','48000','-f','null','-'])
    out=[-90.0]*N
    for t,v in re.findall(r'pts_time:([\d.]+)[^\n]*\n[^\n]*RMS_level=(-?[\d.]+|-inf)', e):
        i=min(int(float(t)),N-1); out[i]=-90.0 if v=='-inf' else float(v)
    return out
full=rms(''); band=rms('highpass=f=300,lowpass=f=3000,')
speech=[max(0,min(1,1-(f-b)/12)) if f>-60 else 0 for f,b in zip(full,band)]
# scene cuts
err = run(['ffmpeg','-v','info','-i',a.video,'-vf',f"select='gt(scene,{a.scene})',showinfo",'-f','null','-'])
cuts=[round(float(t),2) for t in re.findall(r'pts_time:([\d.]+)', err)]
def norm(x):
    lo,hi=min(x),max(x); return [(v-lo)/(hi-lo) if hi>lo else 0 for v in x]
m,l=norm(motion),norm([max(v,-50) for v in loud])
W={'action':(.5,.4,.1),'emotion':(.2,.3,.5),'recap':(.35,.35,.3)}[a.intent]
total=[W[0]*m[i]+W[1]*l[i]+W[2]*speech[i] for i in range(N)]
order=sorted(range(N),key=lambda i:-total[i]); top=[]
for i in order:
    if all(abs(i-j)>=4 for j in top): top.append(i)
    if len(top)>=a.top: break
if a.intent=='recap' and len(top)>3:  # spread across timeline: keep best per bucket
    k=len(top); buckets={}
    for i in order:
        b=int(i*k/N)
        if b not in buckets: buckets[b]=i
    top=sorted(buckets.values())
top.sort()
json.dump({'video':a.video,'duration':dur,'intent':a.intent,'cuts':cuts,
  'seconds':[{'t':i,'motion':round(m[i],3),'loud':round(l[i],3),'speech':round(speech[i],3),'total':round(total[i],3)} for i in range(N)],
  'top':[{'t':i,'total':round(total[i],3),'suggest_in':round(max(0,i-1.0),2),'suggest_out':round(min(dur,i+2.0),2)} for i in top]},open(a.out,'w'),indent=1)
print(f"{a.video}: {dur:.1f}s, {len(cuts)} cuts, top moments at {top}")

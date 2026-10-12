#!/usr/bin/env python3
"""assemble_edit.py EDIT.json --out base.mp4 [--preview]
Base cut: trims, speed, reframe (crop_x for vertical), global grade, grain, letterbox, flash frames. Audio stripped (mp-audio adds it)."""
import argparse, json, os, subprocess, tempfile
ap=argparse.ArgumentParser(); ap.add_argument('edit'); ap.add_argument('--out',required=True); ap.add_argument('--preview',action='store_true')
a=ap.parse_args(); E=json.load(open(a.edit)); W,H,FPS=E['format']['w'],E['format']['h'],E['format']['fps']
GRADES={'none':'', 'teal-amber':'colorbalance=rs=.08:gs=0:bs=-.1:rm=0:gm=0:bm=0:rh=-.05:gh=0:bh=.12,eq=contrast=1.08:saturation=.92',
 'bleach':'eq=contrast=1.25:saturation=.55:brightness=.02', 'warm-film':'colorbalance=rs=.1:bs=-.08,curves=preset=vintage,eq=saturation=1.05',
 'cold-noir':'colorbalance=bs=.12:rs=-.05,eq=contrast=1.2:saturation=.7', 'vivid':'eq=saturation=1.3:contrast=1.1'}
grade=GRADES.get(E.get('grade','none'),E.get('grade',''))
tmp=tempfile.mkdtemp(); parts=[]; crf='28' if a.preview else '18'; scale_h= 540 if a.preview and H>540 else H; scale_w=int(W*scale_h/H)//2*2
for i,s in enumerate(sorted(E['shots'],key=lambda x:x['at'])):
    speed=float(s.get('speed',1.0)); dur_src=s['out']-s['in']; cx=float(s.get('crop_x',0.5))
    vf=[f"fps={FPS}"]
    if speed!=1.0: vf.append(f"setpts={1/speed:.4f}*PTS")
    # reframe: scale so the short side fills, then crop around crop_x
    vf.append(f"scale='if(gt(a,{W}/{H}),-2,{scale_w})':'if(gt(a,{W}/{H}),{scale_h},-2)'")
    vf.append(f"crop={scale_w}:{scale_h}:'(iw-{scale_w})*{cx}':'(ih-{scale_h})/2'")
    if grade: vf.append(grade)
    g=float(E.get('grain',0))
    if g>0: vf.append(f"noise=alls={int(g*60)}:allf=t")
    lb=float(E.get('letterbox',0))
    if lb>0: bar=int(scale_h*lb)//2*2; vf.append(f"drawbox=0:0:iw:{bar}:black:fill,drawbox=0:ih-{bar}:iw:{bar}:black:fill")
    if s.get('flash'): vf.append("fade=t=in:st=0:d=0.07:color=white")
    out=os.path.join(tmp,f"p{i:03d}.mp4")
    subprocess.run(['ffmpeg','-v','error','-y','-ss',str(s['in']),'-t',str(dur_src),'-i',s['src'],'-an','-vf',','.join(vf),
                    '-c:v','libx264','-preset','veryfast' if a.preview else 'medium','-crf',crf,'-pix_fmt','yuv420p',out],check=True)
    parts.append(out)
lst=os.path.join(tmp,'list.txt'); open(lst,'w').write(''.join(f"file '{p}'\n" for p in parts))
subprocess.run(['ffmpeg','-v','error','-y','-f','concat','-safe','0','-i',lst,'-c','copy',a.out],check=True)
d=subprocess.run(['ffprobe','-v','error','-show_entries','format=duration','-of','csv=p=0',a.out],capture_output=True,text=True).stdout.strip()
print(f"base cut: {a.out} · {len(parts)} shots · {float(d):.2f}s · grade={E.get('grade','none')}")

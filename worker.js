const GROUND_BASES=[40,160,640,2560,10240]

class Track{
constructor(g,m){
this.ground_index=g
this.multiplier=m
this.sin_amp=0
this.cos_amp=0
this.missed=0
}
}

function decodeFreq(g,m){
return GROUND_BASES[g]*m
}

function encodeFrequency(f){
if(f<20 || f>20000) return null

for(let i=0;i<GROUND_BASES.length;i++){
let g=GROUND_BASES[i]
if(f>=g/2 && f<g*2){
return{
ground_index:i,
multiplier:f/g
}
}
}
return null
}

self.onmessage=async function(e){

const {
data,
sampleRate,
maxPartials,
frameDt,
fftSize,
matchHz,
ampThreshold
}=e.data

let sr=sampleRate

let hop=Math.floor(frameDt*sr)
let window=hannWindow(fftSize)

let tracks=[]
let frames=[]

for(let start=0,frameIndex=0; start+fftSize<data.length; start+=hop,frameIndex++){

let segment=new Float32Array(fftSize)
for(let i=0;i<fftSize;i++)
segment[i]=data[start+i]*window[i]

let spectrum=fft(segment,sr)
let peaks=findPeaks(spectrum.mag,maxPartials)

let detections=[]

for(let i of peaks){

let A=spectrum.mag[i]/fftSize
if(A<ampThreshold) continue

let p=spectrum.phase[i]
let encoded=encodeFrequency(spectrum.freqs[i])
if(!encoded) continue

detections.push({
ground_index:encoded.ground_index,
multiplier:encoded.multiplier,
sin_amp:A*Math.cos(p),
cos_amp:A*Math.sin(p)
})
}

for(let t of tracks) t.missed++

for(let d of detections){

let best=null
let bestDf=matchHz

for(let t of tracks){

let f1=decodeFreq(t.ground_index,t.multiplier)
let f2=decodeFreq(d.ground_index,d.multiplier)

let df=Math.abs(f1-f2)

if(df<bestDf){
best=t
bestDf=df
}
}

if(best){
best.ground_index=d.ground_index
best.multiplier=d.multiplier
best.sin_amp=d.sin_amp
best.cos_amp=d.cos_amp
best.missed=0
}else{
let t=new Track(d.ground_index,d.multiplier)
t.sin_amp=d.sin_amp
t.cos_amp=d.cos_amp
tracks.push(t)
}
}

tracks=tracks.filter(t=>t.missed<3)

let frame=[]

for(let t of tracks){

let q
if(Math.sign(t.sin_amp)>=0 && Math.sign(t.cos_amp)>=0) q=1
else if(Math.sign(t.sin_amp)<0 && Math.sign(t.cos_amp)>=0) q=2
else if(Math.sign(t.sin_amp)<0 && Math.sign(t.cos_amp)<0) q=3
else q=4

frame.push({
q:q,
g:t.ground_index,
m:Math.fround(t.multiplier),
s:Math.fround(Math.abs(t.sin_amp)),
c:Math.fround(Math.abs(t.cos_amp))
})
}

frames.push(frame)

// 讓出執行權 + 進度
if(frameIndex % 50 === 0){
self.postMessage({progress:start/data.length})
await new Promise(r=>setTimeout(r,0))
}
}

normalizeAmplitudes(frames)

self.postMessage({
done:true,
frames:frames
})
}

function normalizeAmplitudes(frames){

let maxAmp=0

for(let f of frames){
for(let p of f){
let a=Math.sqrt(p.s*p.s+p.c*p.c)
if(a>maxAmp) maxAmp=a
}
}

if(maxAmp===0) return

for(let f of frames){
for(let p of f){
p.s/=maxAmp
p.c/=maxAmp
}
}
}

function findPeaks(arr,n){
let idx=[...arr.keys()]
idx.sort((a,b)=>arr[b]-arr[a])
return idx.slice(0,n)
}

function hannWindow(N){
let w=new Float32Array(N)
for(let i=0;i<N;i++)
w[i]=0.5*(1-Math.cos(2*Math.PI*i/(N-1)))
return w
}

function fft(signal,sr){

let N=signal.length
let re=signal.slice()
let im=new Float32Array(N)

let levels=Math.log2(N)

for(let i=0;i<N;i++){
let j=reverseBits(i,levels)
if(j>i){
let tr=re[i]
re[i]=re[j]
re[j]=tr
}
}

for(let size=2;size<=N;size*=2){

let half=size/2
let step=N/size

for(let i=0;i<N;i+=size){

for(let j=i,k=0;j<i+half;j++,k+=step){

let l=j+half
let angle=2*Math.PI*k/N

let tpre=re[l]*Math.cos(angle)+im[l]*Math.sin(angle)
let tpim=-re[l]*Math.sin(angle)+im[l]*Math.cos(angle)

re[l]=re[j]-tpre
im[l]=im[j]-tpim

re[j]+=tpre
im[j]+=tpim
}
}
}

let mag=[],phase=[],freqs=[]

for(let i=0;i<N/2;i++){
mag.push(Math.hypot(re[i],im[i]))
phase.push(Math.atan2(im[i],re[i]))
freqs.push(i*sr/N)
}

return{mag,phase,freqs}
}

function reverseBits(x,bits){
let y=0
for(let i=0;i<bits;i++){
y=(y<<1)|(x&1)
x>>=1
}
return y
}

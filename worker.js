const GROUND_BASES=[40,160,640,2560,10240]
const MAX_LEN=32500

class Track{
constructor(g,m){
this.ground_index=g
this.multiplier=m
this.sin_amp=0
this.cos_amp=0
this.missed=0
}
}

function floatToBase64(x){
let buf=new ArrayBuffer(4)
let dv=new DataView(buf)
dv.setFloat32(0,x,true)

let bytes=new Uint8Array(buf)
let bin=""
for(let b of bytes) bin+=String.fromCharCode(b)

return btoa(bin).replace(/==$/,"")
}

function encodeFrequency(f){
if(f<20||f>20000)return null
for(let i=0;i<GROUND_BASES.length;i++){
let g=GROUND_BASES[i]
if(f>=g/2&&f<g*2){
return{ground_index:i,multiplier:f/g}
}
}
return null
}

function decodeFreq(g,m){
return GROUND_BASES[g]*m
}

self.onmessage=async function(e){

let {data,sampleRate}=e.data

let fftSize=2048
let frameDt=0.05
let maxPartials=60
let matchHz=15
let ampThreshold=0.001

let sr=sampleRate
let hop=Math.floor(frameDt*sr)
let window=hannWindow(fftSize)

let tracks=[]

let current=""
let first=true

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
let enc=encodeFrequency(spectrum.freqs[i])
if(!enc) continue

detections.push({
ground_index:enc.ground_index,
multiplier:enc.multiplier,
sin_amp:A*Math.cos(p),
cos_amp:A*Math.sin(p)
})
}

for(let t of tracks) t.missed++

for(let d of detections){

let best=null
let bestDf=matchHz

for(let t of tracks){
let df=Math.abs(
decodeFreq(t.ground_index,t.multiplier)-
decodeFreq(d.ground_index,d.multiplier)
)
if(df<bestDf){
best=t
bestDf=df
}
}

if(best){
Object.assign(best,d,{missed:0})
}else{
let t=new Track(d.ground_index,d.multiplier)
Object.assign(t,d)
tracks.push(t)
}
}

tracks=tracks.filter(t=>t.missed<3)

let frameStr=""

if(tracks.length===0){
frameStr="empty"
}else{

for(let t of tracks){

let q
if(Math.sign(t.sin_amp)>=0 && Math.sign(t.cos_amp)>=0) q=1
else if(Math.sign(t.sin_amp)<0 && Math.sign(t.cos_amp)>=0) q=2
else if(Math.sign(t.sin_amp)<0 && Math.sign(t.cos_amp)<0) q=3
else q=4

frameStr +=
q.toString()+
t.ground_index.toString()+
floatToBase64(Math.fround(t.multiplier))+
floatToBase64(Math.fround(Math.abs(t.sin_amp)))+
floatToBase64(Math.fround(Math.abs(t.cos_amp)))
}
}

let addition = first ? `"${frameStr}"` : `,"${frameStr}"`

if(current.length + addition.length > MAX_LEN){

self.postMessage({segment:current})
current = `"${frameStr}"`
first=false

}else{

current += addition
first=false
}

// ⭐不卡 UI
if(frameIndex % 50 === 0){
self.postMessage({progress:start/data.length})
await new Promise(r=>setTimeout(r,0))
}
}

if(current.length>0){
self.postMessage({segment:current})
}

self.postMessage({done:true})
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
let t=re[i]; re[i]=re[j]; re[j]=t
}
}

for(let size=2;size<=N;size*=2){
let half=size/2
let step=N/size

for(let i=0;i<N;i+=size){
for(let j=i,k=0;j<i+half;j++,k+=step){

let l=j+half
let ang=2*Math.PI*k/N

let tr=re[l]*Math.cos(ang)+im[l]*Math.sin(ang)
let ti=-re[l]*Math.sin(ang)+im[l]*Math.cos(ang)

re[l]=re[j]-tr
im[l]=im[j]-ti

re[j]+=tr
im[j]+=ti
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

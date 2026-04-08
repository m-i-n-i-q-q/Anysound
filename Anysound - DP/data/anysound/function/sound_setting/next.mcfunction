tellraw @s {translate:"anysound.notice.analyzing",color:"yellow",fallback:"Analyzing..."}
$data modify storage anysound_:analyzer raw set value [$(data)]
$data modify storage anysound_:analyzer done_flag set value $(df)
#execute unless data storage anysound_:analyzer loop run data modify storage anysound_:analyzer loop set value [0,1]
data modify storage anysound_:analyzer output set value []
#execute store result storage anysound_:analyzer index int -1 run data get storage anysound_:analyzer raw
function anysound:sound_setting/next/loop
# with storage anysound_:analyzer



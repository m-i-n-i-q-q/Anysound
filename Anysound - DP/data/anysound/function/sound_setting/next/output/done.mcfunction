tellraw @s {translate:"anysound.analyze_done",color:"dark_aqua",fallback:"Analysis complete."}
execute if data storage anysound_:analyzer {done_flag:0} run return run dialog show @s anysound:data_set

$data modify storage anysound:temp disc.uuid set from storage anysound:player data[{UUID:$(UUID)}].uuid
function anysound:sound_setting/next/output/done/disc with storage anysound:temp
function anysound:sound_setting/next/output/give_disc with storage anysound:temp disc
tellraw @s {translate:"anysound.setting_end",color:"green",fallback:"Sound settings complete."}

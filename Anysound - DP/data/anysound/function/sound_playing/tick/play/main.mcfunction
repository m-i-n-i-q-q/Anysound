$execute if score @s anysound.playing.delayflag matches 3 run return run function anysound:sound_playing/tick/play/d3$(q) {g:$(g),m:$(m),s:$(s),c:$(c)}
$execute if score @s anysound.playing.delayflag matches 2 run return run function anysound:sound_playing/tick/play/d2$(q) {g:$(g),m:$(m),s:$(s),c:$(c)}
$execute if score @s anysound.playing.delayflag matches 1 run return run function anysound:sound_playing/tick/play/d1$(q) {g:$(g),m:$(m),s:$(s),c:$(c)}
$execute if score @s anysound.playing.delayflag matches 0 run return run function anysound:sound_playing/tick/play/d0$(q) {g:$(g),m:$(m),s:$(s),c:$(c)}

#$function anysound:sound_playing/tick/play/$(q) {g:$(g),m:$(m),s:$(s),c:$(c)}

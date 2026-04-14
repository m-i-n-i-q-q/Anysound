$execute if score @s anysound.playing.delayflag matches ..0 run return run function anysound:sound_playing/tick/play/d$(q) {g:$(g),m:$(m),s:$(s),c:$(c)}
$function anysound:sound_playing/tick/play/$(q) {g:$(g),m:$(m),s:$(s),c:$(c)}

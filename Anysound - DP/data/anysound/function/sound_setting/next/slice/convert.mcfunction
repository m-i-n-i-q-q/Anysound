$data modify storage anysound_:analyzer slice.output.q set value "$(q)"
$data modify storage anysound_:analyzer slice.output.g set value "$(g)"
$data modify storage base64_decoder:input value set value "$(m)"
function base64_decoder:main
function anysound:sound_setting/next/slice/convert/m with storage base64_decoder:output
$data modify storage base64_decoder:input value set value "$(s)"
function base64_decoder:main
function anysound:sound_setting/next/slice/convert/s with storage base64_decoder:output
$data modify storage base64_decoder:input value set value "$(c)"
function base64_decoder:main
function anysound:sound_setting/next/slice/convert/c with storage base64_decoder:output

function anysound:sound_setting/next/slice/convert/store with storage anysound_:analyzer slice.output

function anysound:sound_setting/next/slice
$execute unless data storage anysound_$(uuid):sound data run data merge storage anysound_$(uuid):sound {data:[]}
$data modify storage anysound_$(uuid):sound data append value {name:"$(name)",author:"$(author)",data:[]}
dialog show @s anysound:data_set
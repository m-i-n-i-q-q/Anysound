data merge storage base64_decoder:temp {input:{0:"",1:"",2:"",3:"",4:"",5:""},output:{0:"",1:"",2:"",3:"",4:"",5:"",raw:"",little_endian:{a:"",b:"",c:"",d:""}}}
data modify storage base64_decoder:temp input.0 set string storage base64_decoder:input value 0 1
data modify storage base64_decoder:temp input.1 set string storage base64_decoder:input value 1 2
data modify storage base64_decoder:temp input.2 set string storage base64_decoder:input value 2 3
data modify storage base64_decoder:temp input.3 set string storage base64_decoder:input value 3 4
data modify storage base64_decoder:temp input.4 set string storage base64_decoder:input value 4 5
data modify storage base64_decoder:temp input.5 set string storage base64_decoder:input value 5
function base64_decoder:main/mapping with storage base64_decoder:temp input
function base64_decoder:main/connecting with storage base64_decoder:temp output
#data modify storage base64_decoder:temp output.raw set string storage base64_decoder:temp output.raw 0 32
data modify storage base64_decoder:temp output.little_endian.a set string storage base64_decoder:temp output.raw 0 8
data modify storage base64_decoder:temp output.little_endian.b set string storage base64_decoder:temp output.raw 8 16
data modify storage base64_decoder:temp output.little_endian.c set string storage base64_decoder:temp output.raw 16 24
data modify storage base64_decoder:temp output.little_endian.d set string storage base64_decoder:temp output.raw 24 32
function base64_decoder:main/little_endian with storage base64_decoder:temp output.little_endian
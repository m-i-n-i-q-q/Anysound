import struct
import nbtlib
import base64
import json
input_data = {"data":{"contents":{"sound":{"data":[]}}},"DataVersion":4671}
input_name=str(input("enter the sound name:"))
input_author=str(input("enter the sound author:"))
main_data = {"name":input_name,"author":input_author,"data":[]}
with open("example data.txt","r") as f:
  k=f.read().replace("\"","")
  v=[]
  for i in [j.split(",") for j in k.split("\n\n")]:
    v+=i
  v.pop()
  for l in v:
    if l == 'empty':
      main_data["data"].append([])
    else:
      p=[]
      l+= "="
      t=l
      s=0
      while t[s] != "=":
        a=t[s:s+20]
        b={
            "q":a[0],
            "g":a[1],
            "m":struct.unpack('<f', base64.b64decode(a[2:8]+ "=="))[0],
            "s":struct.unpack('<f', base64.b64decode(a[8:14]+"=="))[0],
            "c":struct.unpack('<f', base64.b64decode(a[14:]+"=="))[0]
          }
        p.append(b)
        s+=20
      main_data["data"].append(p)
input_data["data"]["contents"]["sound"]["data"].append(main_data)

# Your JSON data
json_data = json.dumps(input_data)

# Parse the JSON string directly into NBT tags
nbt_data = nbtlib.parse_nbt(json_data)

# Save as a compressed .nbt file
nbt_file = nbtlib.File(nbt_data, gzipped=True)
nbt_file.save('command_storage.dat')
print("Done!")
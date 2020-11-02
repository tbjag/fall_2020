verbose = False

"""
spoke about the solution with Kurt Von Autenried
references:
https://samwho.dev/blog/toying-with-cryptography-crib-dragging/
https://lzutao.github.io/cribdrag/
http://travisdazell.blogspot.com/2012/11/many-time-pad-attack-crib-drag.html
"""

#first conver the strings from hex into integers. learned that converting to ascii values gives worthless symbols
def convert_from_hex(a):
    res = []
    for x in range(0,len(a),2):
        res.append(int(a[x:x+2], 16))
    if verbose:
        print("hex_to_string: {" + a + "} --> " + str(res))
    return res

#XOR the strings, do not need to worry about the sizes since they are all the same
def xor_strings(a, b):
    res = []
    for x in range(len(a)):
        res.append(a[x] ^ b[x]) #xor
    if verbose:
      print("xor_strings: {" + str(a) + " , " + str(b) + "} --> " + str(res))
    return res

#crib based on a place in the string
def da_crib(xored_string, test_key, place):
    cribAscii = []
    for i in range(0, len(test_key)):
        cribAscii.append(ord(test_key[i]))
    shortenedWord = []
    for j in range(place, place + len(test_key)):
        shortenedWord.append(xored_string[j])
    res = xor_strings(shortenedWord, cribAscii)
    output = ""
    for k in range(0, len(res)):
        output += chr(int(res[k]))
    if verbose:
        print("try_crib: {" + str(xored_string) + "," + test_key + "," + str(place) + "} --> {" + output + "}") 
    return output

messages = ["testing testing can you read this","yep can read you perfectly fine", "awesome one time pad is working  ", " can make fun of Nikos now "]

msg1 = "2d0a0612061b0944000d161f0c1746430c0f0952181b004c1311080b4e07494852"
encrypted_messages = [ "200a054626550d051a48170e041d011a001b470204061309020005164e15484f44", \
						"3818101500180b441b06004b11104c064f1e0616411d064c161b1b04071d460101",\
						"200e0c4618104e071506450604124443091b09520e125522081f061c4e1d4e5601",\
						"304f1d091f104e0a1b48161f101d440d1b4e04130f5407090010491b061a520101", \
						"2d0714124f020111180c450900595016061a02520419170d1306081c1d1a4f4601",\
						"351a160d061917443b3c354b0c0a01130a1c01170200191541070c0c1b01440101",\
						"3d0611081b55200d1f07164b161858431b0602000454020d1254084f0d12554249",\
						"340e0c040a550c1100482c4b0110450d1b4e1713185414181511071b071c4f0101",\
						"2e0a5515071a1b081048170e04154d1a4f020e0115111b4c151b492107184e5201",\
						"370e1d4618104e05060d450f0a104f044f080e1c04540205151c061a1a5349484c"]

#run on every index
def crib_drag():
	crib = messages[0]
	for x in range(0, 34 - len(crib)):
		print(str(x) + ":" + da_crib(xor_strings(convert_from_hex(encrypted_messages[0]),convert_from_hex(msg1)), crib, x) + ":")

#crib_drag()
one_key = "testing testing can you read this"

#go through 
def print_all_msgs():
  print(one_key)
  #go through every message and use 1 whole key to decrypt the rest
  for i in encrypted_messages:
    for x in range(0, 34 - len(one_key)):
      print(da_crib(xor_strings(convert_from_hex(msg1),convert_from_hex(i)),one_key,x))

print_all_msgs()

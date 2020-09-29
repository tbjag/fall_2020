def hex_to_string(input):
	res = ""
	while len(input) > 0:
		curr = input[0:2]
		output = int(curr, 16)
		res += str(output) + " "
		input = input[2:]
	return res

def xor_strings(string1, string2):
    arr1 = string1.split(" ")
    arr2 = string2.split(" ")
    output = ""
    for i in range(0, len(arr1) - 1):
        output += str(int(arr1[i]) ^ int(arr2[i])) + " "
    return output

def try_crib(xorString, cribword, index):
	arr = xorString.split(" ")
	cribAscii = ""
	for i in range(0, len(cribword)):
		cribAscii += str(ord(cribword[i])) + " "
	shortenedWord = ""
	for j in range(index, index + len(cribword)):
		shortenedWord += arr[j] + " "
	res = xor_strings(shortenedWord, cribAscii)
	output = ""
	arr2 = res.split(" ")
	for k in range(0, len(arr2) - 1):
		output += chr(int(arr2[k]))
	return output

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
						

one_key = "testing testing can you read this"

messages = ["testing testing can you read this","yep can read you perfectly fine", "awesome one time pad is working  ", " can make fun of Nikos now "]

def crib_drag():
	crib = messages[0]
	for x in range(0, 34 - len(crib)):
		print(str(x) + ":" + try_crib(xor_strings(hex_to_string(encrypted_messages[0]),hex_to_string(msg1)), crib, x) + ":")

#i crib dragged the first 4 messages with this function to get one key as seen above

def print_all_msgs():
	print(one_key)
	for i in encrypted_messages:
		for x in range(0, 34 - len(one_key)):
			print(try_crib(xor_strings(hex_to_string(msg1),hex_to_string(i)),one_key,x))

print_all_msgs()


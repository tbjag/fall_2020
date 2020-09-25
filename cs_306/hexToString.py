def hexToString(input):
	res = ""
	while len(input) > 0:
		curr = input[0:2]
		output = int(curr, 16)
		res += str(output) + " "
		input = input[2:]
	return res


def analyze(input):
    d = {}
    arr = input.split(" ")
    for i in range(0, len(arr) - 1):
        if d.get(arr[i]):
            d[arr[i]] += 1
        else:
            d[arr[i]] = 1
    freq = sorted(d.items(), key = lambda x: x[1], reverse = True)
    return freq

def xorStrings(string1, string2):
    arr1 = string1.split(" ")
    arr2 = string2.split(" ")
    output = ""
    for i in range(0, len(arr1) - 1):
        output += str(int(arr1[i]) ^ int(arr2[i])) + " "
    return output

def tryCrib(xorString, cribword, index):
	arr1 = xorString.split(" ")
	cribAscii = ""
	for i in range(0, len(cribword)):
		cribAscii += str(ord(cribword[i])) + " "
	shortenedWord = ""
	for j in range(index, index + len(cribword)):
		shortenedWord += arr1[j] + " "
	res = xorStrings(shortenedWord, cribAscii)
	output = ""
	arr2 = res.split(" ")
	for k in range(0, len(arr2) - 1):
		output += chr(int(arr2[k]))
	return output

msg1 = "2d0a0612061b0944000d161f0c1746430c0f0952181b004c1311080b4e07494852"
msg2 = "200a054626550d051a48170e041d011a001b470204061309020005164e15484f44"
msg3 = "3818101500180b441b06004b11104c064f1e0616411d064c161b1b04071d460101"
msg4 = "200e0c4618104e071506450604124443091b09520e125522081f061c4e1d4e5601"
msg5 = "304f1d091f104e0a1b48161f101d440d1b4e04130f5407090010491b061a520101"
msg6 = "2d0714124f020111180c450900595016061a02520419170d1306081c1d1a4f4601"
msg7 = "351a160d061917443b3c354b0c0a01130a1c01170200191541070c0c1b01440101"
msg8 = "3d0611081b55200d1f07164b161858431b0602000454020d1254084f0d12554249"
msg9 = "340e0c040a550c1100482c4b0110450d1b4e1713185414181511071b071c4f0101"
msg10 = "2e0a5515071a1b081048170e04154d1a4f020e0115111b4c151b492107184e5201"
msg11 = "370e1d4618104e05060d450f0a104f044f080e1c04540205151c061a1a5349484c"

#print(hexToString(msg1))
#print(hexToString(msg2))
# print(hexToString(msg3))
# print(hexToString(msg4))
# print(hexToString(msg5))
# print(hexToString(msg6))
# print(hexToString(msg7))
# print(hexToString(msg8))
# print(hexToString(msg9))
# print(hexToString(msg10))
# print(hexToString(msg11))
# print()
# print(xorStrings(hexToString(msg1),hexToString(msg2)))

messages = ["testing testing can you read this","can read you perfectly fine", "e one time pad is working  ", " can make fun of Nikos now "]

crib = messages[0]
for x in range(0, 34 - len(crib)):
    print(str(x) + ":" + tryCrib(xorStrings(hexToString(msg3),hexToString(msg1)), crib, x) + ":")

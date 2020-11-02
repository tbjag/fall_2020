# Problem 9

#read stop file
stop_words = open('stopwords_en.txt','r')
data=[]
#put words into list
for line in stop_words:
    parts = line.strip().split()
    data+=parts

#read ai file
ai_file=open('ai_trends.txt','r')
result = []

#remove all stop words from file
for line in ai_file:
    parts = line.strip().split()
    data = []
    for word in parts:
        if word not in data:
            data.append(word)
    result += data

#part A
occurences = {}
#count all occurences
for word in result:
    if word in occurences:
        occurences[word] += 1
    else:
        occurences[word] = 1
#find avg.
number_o_words = len(occurences) 
total_a = 0
for i in occurences:
    total_a += occurences[i] / number_o_words

print(total_a)

#part B
longest_num = 0
longest = ""
for i in occurences:
    temp_l = len(i)
    if temp_l > longest_num:
        longest = i
        longest_num = temp_l

print(longest)

#part C
#im guessing find avg length based on unique words only, wording for this question stupid
total_c = 0

for i in occurences:
    total_c += len(i)

avg_len = total_c / len(occurences)

print(avg_len)
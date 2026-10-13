tjohej = 'hello world'
print (tjohej)


hej=1
hej=3
print(hej)

#variabler =siffror
tal1=1
tal2=3
print(tal1+tal2)



#sträng'=lägg ihop text
tal1='1'
tal2='3'
print(tal1+tal2)

tal1='hej'
tal2='då'
print(tal1+tal2)

tal1=3
tal2=4
summa=tal1+tal2
print(summa)



hej=input('mata in text:')
print('du skrev')
print(hej)

#snyggare med,
hej=input('mata in text:')
print('du skrev',hej)


namn=input('vad heter du')
print (namn,'är ett fint namn')



hej=['banan','klementin','äpple']
print(hej[1])#visar klementin position 1


hej=['banan','klementin','äpple']
hej .append('kiwi')
print(hej[3])

mat= ['kebab','pizza','kyckling']
mat.append(input('lägg till en maträtt'))


#random
import random
slump=random.randint(1,6)
print(slump)

import random
hej=['banan','kiwi','apelsin']
urval=random.choice(hej)
print(urval)

import random
mat=['köttbullar','korv','blodpudding']
urval=random.choice(mat)
print('idag ska du äta',urval)
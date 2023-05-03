import sys
import os

my_path = os.path.abspath(os.path.dirname(__file__))
f = open(os.path.join(my_path, '%TL%TextListWithExtendedAscii.json'), 'r')
data = f.read()
print(data)
f.close()
test = data.encode().decode('utf-8')
print(test)

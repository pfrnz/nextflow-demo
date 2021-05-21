import sys
import os
import ex2_module.foo as foo

print('Hello from Python: ', sys.version)
print('working in:', os.getcwd())
print ('run from:', os.path.abspath(__file__))
foo.show()

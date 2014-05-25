# Filename : installer.py

import sys
import os
import yaml

f = open('request.yaml')
request = yaml.load(f)

if request['Order'][0] == 'install_problem':
    name = str(request['Name'][0])
    package = str(request['Package'][0])
    os.system('tar zxf ' + package)
    os.system('rm data/' + name + ' -r')
    os.system('mv ' + name + ' data/')
    os.system('rm ' + package)
    print 'install problem:', name, '[done]'

else:
    name = str(request['Name'][0])
    source = str(request['SourceFile'][0])
    os.system('mkdir src/' + name)
    os.system('mv ' + source + ' src/' + name)
    print 'install participator:', name, '[done]'



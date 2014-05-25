# Filename : test.py

import yaml
import os
import sys
import subprocess

f = open('request.yaml')
request = yaml.load(f)

ID = str(request['Name'][0])
ProblemID = str(request['ProblemName'][0])
Language = str(request['Language'][0])
Time = str(request['TimeLimit'][0])
Mem = str(request['MemoryLimit'][0])
Out = str(request['OutputLimit'][0])
CaseNum = request['CaseNum'][0]
Score = request['ScoreForEachCase'][0]
Check = request['CheckMode'][0]		# Only support line-compare at present
Code = request['Code'][0]

order = "cp ./src/" + ID + "/" + ProblemID + "." + Language
code_file = open("./src/" + ID + "/" + ProblemID + "." + Language, 'w')
code_file.write(Code)
code_file.close()
order = order + " ."
os.system(order)

finalResult = { 'totalScore' : 0 }

def check_answer(mode):

	returnValue = 1

	if mode == 'line':

		f1 = open("_.out")
		f2 = open(".out")

		while returnValue == 1:
			line1 = f1.readline()
			line2 = f2.readline()
			if len(line1) == 0 and len(line2) == 0: break

			if line1 != line2: returnValue = 0

	return returnValue

for i in range(0, CaseNum):
	order = "cp ./data/" + ProblemID + "/" + ProblemID + str(i) + ".in ./_.in"
	os.system(order)

	order = "./executor " + ProblemID + "." + Language + " " + Language
	order = order + " --time_limit=" + Time
	order = order + " --memory_limit=" + Mem
	order = order + " --output_limit=" + Out
	os.system(order)

	f = open("log")
	result = yaml.load(f)

	finalResult['Case ' + str(i)] = {}

	if result['Result'][0] == "No_Error":
		os.system("cp ./data/" + ProblemID + "/" + ProblemID + str(i) + ".out ./.out")
		os.system(order)

		if check_answer(Check):
			finalResult['totalScore'] += Score
			finalResult['Case ' + str(i)]['Result'] = ['Right']
		else:
			finalResult['Case ' + str(i)]['Result'] = ['Wrong_Answer']

	else:
		finalResult['Case ' + str(i)]['Result'] = result['Result']

	try:
		finalResult['Case ' + str(i)]['Time'] = result['Time']
	except:
		finalResult['Case ' + str(i)]['Time'] = '0'

	try:
		finalResult['Case ' + str(i)]['Memory'] = result['Memory']
	except:
		finalResult['Case ' + str(i)]['Memory'] = '0'

	print "Case " + str(i) + ": " + str(finalResult['Case ' + str(i)]['Result'])

os.system("rm " + ProblemID + "." + Language)
os.system("rm " + "_.in " + ".out " + "_.out " + "log " + "Main")
os.system("rm request.yaml")

f = file("result.yaml", "w")
print yaml.dump(finalResult, f)
print 'test:', ID, ProblemID, '[done]'

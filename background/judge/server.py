# Filename : server.py

import yaml
import os
import sys
import SocketServer
import subprocess
import string
import time

def file_extension(path):
    return os.path.splitext(path)[1]

class MyTcpServer(SocketServer.BaseRequestHandler):
    def recvfile(self, filename):
        print "starting recv file!"
        f = open(filename, 'wb')
        self.request.send('ready')
        while True:
            data = self.request.recv(4096)
            if data == 'EOF':
                self.request.send('ready')
                print "recv file success!"
                break
            f.write(data)
        f.close()

        if file_extension(filename) == '.yaml':
            order = "mv " + filename + " request.yaml"
            os.system(order)

            f = open("request.yaml")
            request = yaml.load(f)

            if request['Order'][0] == 'test':
                os.system("python tester.py")
                self.request.send('ready')
            elif request['Order'][0] == 'install_problem' or \
                 request['Order'][0] == 'install_participator':
                os.system("python installer.py")
            else:
                print 'bad request'

    def sendfile(self, filename):
        print "starting send file!"
        self.request.send('ready')
        time.sleep(1)
        f = open(filename, 'rb')
        while True:
            data = f.read(4096)
            if not data:
                break
            self.request.send(data)
        f.close()
        time.sleep(1)
        self.request.send('EOF')
        print "send file success!"

    def handle(self):
        print "get connection from :",self.client_address
        while True:
            try:
                data = self.request.recv(4096)
                print "get data:", data
                if not data:
                    print "break the connection!"
		    break
                else:
                    action, filename = data.split()
                    if action == "put":
                        self.recvfile(filename)
                    elif action == 'get':
                        self.sendfile(filename)
                    else:
                        print "get error!"
                        continue
            except Exception,e:
                print "get error at:",e


if __name__ == "__main__":
    host = ''
    port = 60000
    s = SocketServer.ThreadingTCPServer((host,port), MyTcpServer)
    s.serve_forever()

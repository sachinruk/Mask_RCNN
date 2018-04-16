import os
import sys
import subprocess
from subprocess import call

print('Build process started')
out = subprocess.check_output("git diff --name-only HEAD~1 HEAD".split())
out = out.decode('ascii').split('\n')[:-1]
dockerfiles = [files for files in out if "Dockerfile" in files]

def call_cmd(cmd):
    ret_code = call(cmd.split())
    if ret_code != 0:
        print("The following command failed: " + cmd)
        sys.exit(ret_code)

TAG = str(sys.argv[1])
if len(dockerfiles)>0:
    tagged_version = "sachinruk/mask_rcnn:" + TAG
    call_cmd("docker build -t sachinruk/mask_rcnn .")
    call_cmd("docker tag sachinruk/mask_rcnn " + tagged_version)
    call_cmd("docker push sachinruk/mask_rcnn")
    print("="*50)
    print(" built!")
    print("="*50)

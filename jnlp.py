#!/usr/bin/python

import sys
import requests
import argparse
import subprocess


def_user="ADMIN"
def_pass="ADMIN"

parser = argparse.ArgumentParser(description='Get IPMI JNLP file.')
parser.add_argument('--host', required=True)
parser.add_argument('--username', default=def_user, help='The username to login to the IPMI host, (default: %(default)s)')
parser.add_argument('--password', default=def_pass, help='The password to login to the IPMI host, (default: %(default)s)')

args = parser.parse_args()

#print("HOST: " + args.host)
#print("ADMIN: " + args.username)
#print("PASS: " + args.password)

if args.host.endswith('cgi'):
    print("ERROR! Hostname should not end with cgi")
    exit(1)

loginurl = str(args.host + "/cgi/login.cgi")
ipmiurl = str(args.host + "/cgi/url_redirect.cgi?url_name=ikvm&url_type=jwsk")

s = requests.Session()
s.headers.update({'referer': "http://localhost"})
getcookie = s.post(loginurl, data={"name": args.username, "pwd": args.password})

jnlp=s.get(ipmiurl, allow_redirects=True)

with open("/ipmi.jnlp", mode='wb') as localfile:
    localfile.write(jnlp.content)

subprocess.call(["javaws", "/ipmi.jnlp", "&"])

exit()

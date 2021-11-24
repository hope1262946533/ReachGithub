import os
import  re, urllib.request

os.system('sudo chmod 777 /etc/hosts')

url = 'https://websites.ipaddress.com/github.com'
html = urllib.request.urlopen(url).read().decode('utf-8')

ip = re.findall(r"<tr><th>IP Address</th><td><ul class=\"comma-separated\"><li>(.+?)</li></ul></td></tr>", html)[0]

filepath = '/etc/hosts'
fp = open(filepath)
content = fp.read()
has_github_address = content.find(" github.com", 0, len(content))

if has_github_address == -1: #github doesn't exist
    cmd_line = "echo -n '\n" + ip + " github.com' >> /etc/hosts"
    os.system(cmd_line)
else:
    cmd_line = "sed \"/ github.com/s/.*/" + ip + " github.com/\" /etc/hosts"
    os.system(cmd_line)

os.system('sudo chmod 644 /etc/hosts')
print("Github address is update to:" + ip)
import urllib.parse
import urllib.request

url = 'http://offended.orgfree.com/hsealarm/main.php'

para = input("Input para: ")
day = input("Input day: ")
month = input("Input month: ")
year = input("Input year: ")

date = year+"-"+month+"-"+day;
 
values = {'Date':date,'Para' : para }
data = urllib.parse.urlencode(values)
data = data.encode('utf-8')
req = urllib.request.Request(url,data)
with urllib.request.urlopen(req) as response:
	the_pagen = response.read()
the_pagen = the_pagen.decode('utf-8')	
print (the_pagen)

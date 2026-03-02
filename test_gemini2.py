import urllib.request
import json
import ssl

url = "https://generativelanguage.googleapis.com/v1beta/models?key=AIzaSyCqWoMA0-oXeqwQ24xMFQpK73S-535xtfI"
req = urllib.request.Request(url)
ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE
try:
    with urllib.request.urlopen(req, context=ctx) as response:
        models = json.loads(response.read().decode('utf-8'))
        for m in models.get('models', []):
            if 'flash' in m['name']:
                print(m['name'])
except Exception as e:
    print(e)

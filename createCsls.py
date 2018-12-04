from urllib import request
import json
from subprocess import check_output

def curl(url): return json.loads(request.urlopen(request.Request(url)).read().decode("utf-8"))
def github(path): return curl("https://api.github.com/repos/citation-style-language/styles/" + path)

latestCommit = github("git/refs/heads/master")['object']['sha']

def contentUrl(path): return "https://raw.githubusercontent.com/citation-style-language/styles/{0}/{1}".format(latestCommit, path)
def nixPrefetchUrl(path): return check_output(["nix-prefetch-url", contentUrl(path)]).decode("utf-8").strip() 
def toEntry(prefix, f): return { 'name': f, 'url': contentUrl(prefix + f), 'sha256': nixPrefetchUrl(prefix + f) }

def toJson(name, prefix, tree):    
    print("creating", name, "with prefix", prefix)
    files = [ f['path'] for f in tree if f['path'].endswith('.csl') ]
    entries = [ toEntry(prefix, f) for f in files ]
    with open(name, 'w') as outfile:
        json.dump(entries, outfile, indent=2)

tree = github("git/trees/" + latestCommit)['tree']
dependentUrl = next(f['url'] for f in tree if f['path'] == "dependent")
dependent = curl(dependentUrl)['tree']

toJson("csls-dependent.json", "dependent/", dependent)
toJson("csls.json", "", tree)


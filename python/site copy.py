import sys
import re
import cherrypy
import urllib
from BeautifulSoup import BeautifulSoup 
from BeautifulSoup import BeautifulStoneSoup
import eyeD3

class Root:
        @cherrypy.expose
        def index(self):
                # Get a file-like object for the Python Web site's home page.
                f = urllib.urlopen("http://thefmly.com/")
                # Read from the object, storing the page's contents in 's'.
                s = f.read()
                f.close()
                soup = BeautifulStoneSoup(s)
                # locallinks = soup.findAll(url=re.compile(".mp3$"))
                locallinks = soup.findAll(text=re.compile("^http://thefmly.com/"))
                # print str(locallinks)
                mp3s = {}
                print len(locallinks)
                for link in locallinks:
                    if(not link in mp3s):
                        ff = urllib.urlopen(link)
                        ss = ff.read()
                        ff.close()
                        # print ss
                        thissoup = BeautifulSoup(ss)
                        # print thissoup
                        mp3 = thissoup.findAll(href=re.compile(".mp3$"))[0]['href']
                        # if mp3
                        mp3s[link] = mp3
                        print mp3
                
                # return str(mp3s)

root = Root()
app = cherrypy.tree.mount(root, script_name='/')
cherrypy.quickstart(app, config = 'cherrypy.cfg')
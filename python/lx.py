import sys
import re
import cherrypy
import urllib
# from lxml import etree
import lxml.html
from lxml.etree import fromstring
from lxml.cssselect import CSSSelector
# from BeautifulSoup import BeautifulSoup 
# from BeautifulSoup import BeautifulStoneSoup
import eyeD3

class Root:
        @cherrypy.expose
        def index(self):
                # Get a file-like object for the Python Web site's home page.
                f = urllib.urlopen("http://www.imposemagazine.com/bytes/")
                # Read from the object, storing the page's contents in 's'.
                s = f.read()
                f.close()
                print s
                h = lxml.html.fromstring(s)
                # print lxml.html.tostring(h)
                sel = CSSSelector("a")
                # [url$='mp3']
                urls = [e.get('href') for e in sel(h)]
                
                p = re.compile()
                m = p.match( 'string goes here' )
                if m:
                    print urls.match("/bytes")
                # [href$='mp3']
                # print elements.css
                # for el in elements:
                    # print lxml.html.toString(el)
                
                # soup = BeautifulStoneSoup(s)
                # # locallinks = soup.findAll(url=re.compile(".mp3$"))
                # locallinks = soup.findAll(text=re.compile("^http://www.imposemagazine.com"))
                # # print str(locallinks)
                # mp3s = {}
                # print len(locallinks)
                # for link in locallinks:
                #     if(not link in mp3s):
                #         ff = urllib.urlopen(link)
                #         ss = ff.read()
                #         ff.close()
                #         # print ss
                #         thissoup = BeautifulSoup(ss)
                #         # print thissoup
                #         mp3 = thissoup.findAll(href=re.compile(".mp3$"))[0]['href']
                #         # if mp3
                #         mp3s[link] = mp3
                #         print mp3
                
                # return str(mp3s)

root = Root()
app = cherrypy.tree.mount(root, script_name='/')
cherrypy.quickstart(app, config = 'cherrypy.cfg')
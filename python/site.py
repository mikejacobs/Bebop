import sys
import re
import cherrypy
import feedparser
import urllib
import cherrypy_tools
from BeautifulSoup import BeautifulSoup 
from BeautifulSoup import BeautifulStoneSoup
import eyeD3

def getKeyValue(s, key):
    t=s.find(name='key', text=key)
    if t is None:
        return None
    val=t.parent.nextSibling
    return val.string

class Root:
        @cherrypy.expose
        @cherrypy.tools.mako(template='index')
        def index(self):
                # Get a file-like object for the Python Web site's home page.
                f = urllib.urlopen("http://thefmly.com/feed")
                # Read from the object, storing the page's contents in 's'.
                s = f.read()
                f.close()
                soup = BeautifulStoneSoup(s)
                posts = soup.findAll('item')
                bundles = []
                for post in posts:
                    content = str(post.contents).replace("<![CDATA[", "")
                    postsoup = BeautifulStoneSoup(content)
                    # print postsoup.prettify()
                    mp3s = postsoup.findAll(url=re.compile(".mp3$"))
                    # mp3s = postsoup.findAll(text=re.compile(".mp3$"))
                    encoded = postsoup.findAll(re.compile(":encoded$"))
                    # print encoded
                    contentsoup = BeautifulSoup(str(encoded))
                    # print contentsoup 
                    mp3s = contentsoup.findAll('a', href=re.compile(".mp3$"))
                    print len(mp3s)
                    if(len(mp3s)):
                        songs = []
                        for song in mp3s:
                            # print song.contents
                            songs.append([song.get('href').encode('utf8'), song.string.encode('utf8')])
                        bundles.append({"date": post.pubdate, "description": post.description.string.encode('utf8'), "link": post.link.string.encode('utf8'), "title": post.title.string.encode('utf8'), "mp3s": songs})
                    
                return dict(songs=bundles)
        
root = Root()
app = cherrypy.tree.mount(root, script_name='/')
cherrypy.quickstart(app, config = 'cherrypy.cfg')
import sys
import re
import cherrypy
import feedparser
import urllib
import cherrypy_tools
from BeautifulSoup import BeautifulSoup 
from BeautifulSoup import BeautifulStoneSoup
import eyeD3

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
                    print post.pubdate
                    postsoup = BeautifulSoup(str(post.contents))
                    mp3s = postsoup.findAll(url=re.compile(".mp3$"))
                    if(len(mp3s)):
                        songs = []
                        for song in mp3s:
                            songs.append(song.get('url').encode('utf8'))
                        bundles.append({"date": post.pubdate, "description": post.description.string.encode('utf8'), "link": post.link.string.encode('utf8'), "title": post.title.string.encode('utf8'), "mp3s": songs})
                    
                return dict(songs=bundles)

root = Root()
app = cherrypy.tree.mount(root, script_name='/')
cherrypy.quickstart(app, config = 'cherrypy.cfg')
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
                d = feedparser.parse("http://feedparser.org/docs/examples/atom10.xml")
                # f = urllib.urlopen("http://www.visitation-rites.com/audio/")
                # Read from the object, storing the page's contents in 's'.
                s = f.read()
                f.close()
                e = d.entries[0].date
                print e
                #IF XML
                soup = BeautifulStoneSoup(s)
                posts = soup.findAll('item')
                bundles = []
                print soup
                print soup.findAll("pubdate")
                for post in posts:
                    print post.pubdate
                    postsoup = BeautifulSoup(str(post.contents))
                    mp3s = postsoup.findAll(url=re.compile(".mp3$"))# [0]['href']
                    # if post.has_key('pubDate'):
                    #                  print post['pubDate']
                    #              else:
                    #                  print "nope"
                    # print postsoup.find("link")# [0]['href']
                    if(len(mp3s)):
                        # print post.get("pubDate")
                        songs = []
                        for song in mp3s:
                            songs.append(song.get('url').encode('utf8'))
                        bundles.append({"link": post.link.string.encode('utf8'), "title": post.title.string.encode('utf8'), "mp3s": songs})
                    
                return dict(songs=bundles)

root = Root()
app = cherrypy.tree.mount(root, script_name='/')
cherrypy.quickstart(app, config = 'cherrypy.cfg')
import cherrypy
import simplejson
from mako.template import Template as MakoTemplate
from mako.lookup import TemplateLookup

jenc = simplejson.JSONEncoder()

mako_module_dir = '/tmp/mako_module'
mylookup = TemplateLookup(directories=['.'], module_directory=mako_module_dir, output_encoding='utf8')

def mako_tool_callback (template):
    args = cherrypy.response.body
    if isinstance(args, dict):
        t = mylookup.get_template(template+'.mak')
        cherrypy.response.body = t.render(**args)
cherrypy.tools.mako = cherrypy.Tool('before_finalize', mako_tool_callback, priority=30)

def jsonify_tool_callback(*args, **kwargs):
    response = cherrypy.response
    if isinstance(response.body, dict):
        response.headers['Content-Type'] = 'text/javascript'
        response.body = jenc.iterencode(response.body)
cherrypy.tools.json = cherrypy.Tool('before_finalize', jsonify_tool_callback, priority=30)

def jsonp_tool_callback(*args, **kwargs):
    response = cherrypy.response
    callback = cherrypy.request.params['callback']
    if isinstance(response.body, dict):
        response.headers['Content-Type'] = 'text/javascript'
        json_str = simplejson.dumps(response.body)
        rstr = '%s(%s)' % (callback, json_str)
        response.body = rstr
cherrypy.tools.jsonp = cherrypy.Tool('before_finalize', jsonp_tool_callback, priority=30)

def session_close_tool():
    models.base.session.close()
cherrypy.tools.session_close = cherrypy.tools.session_close = cherrypy.Tool('on_end_request', session_close_tool, priority=30)
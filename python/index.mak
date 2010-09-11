<!-- Read http://molecularvoices.molecular.com/standards/ first -->
<!doctype html>
<html lang="en" class="no-js">
<head>
  <meta charset="utf-8">

  <!-- www.phpied.com/conditional-comments-block-downloads/ -->
  <!--[if IE]><![endif]-->

  <!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame 
       Remove this if you use the .htaccess -->
  <!--[if IE]><meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"><![endif]-->

  <title></title>
  <meta name="description" content="music and video blog gator">
  <meta name="author" content="Maki">

  <!--  Mobile Viewport Fix
        j.mp/mobileviewport & davidbcalhoun.com/2010/viewport-metatag 
  device-width : Occupy full width of the screen in its current orientation
  initial-scale = 1.0 retains dimensions instead of zooming out if page height > device height
  maximum-scale = 1.0 retains dimensions instead of zooming in if page width < device width
  -->
  <meta name="viewport" content="width=device-width; initial-scale=1.0; maximum-scale=1.0;">


  <!-- Place favicon.ico and apple-touch-icon.png in the root of your domain and delete these references -->
  <link rel="shortcut icon" href="static/favicon.ico">
  <link rel="apple-touch-icon" href="static/apple-touch-icon.png">


  <!-- CSS : implied media="all" -->
  <link rel="stylesheet" href="static/css/style.css?v=1">
  <link rel="stylesheet" href="static/css/bebop.css?v=1">
  <link rel="stylesheet" href="static/js/soundmanager/demo/page-player/css/page-player.css">

  <!-- For the less-enabled mobile browsers like Opera Mini -->
  <link rel="stylesheet" media="handheld" href="static/css/handheld.css?v=1">

 
  <!-- All JavaScript at the bottom, except for Modernizr which enables HTML5 elements & feature detects -->
  <script src="static/js/modernizr-1.5.min.js"></script>
  <script src="static/js/soundmanager/script/soundmanager2.js"></script>
  <script src="static/js/soundmanager/demo/page-player/script/page-player.js"></script>
  <script type="text/javascript">
  var is_shiny = false;
  function setTheme(sTheme) {
    var o = pagePlayer.getElementsByClassName('playlist','ul');
    for (var i=o.length; i--;) {
      o[i].className = 'playlist'+(pagePlayer.cssBase?' '+pagePlayer.cssBase:'')+(sTheme?' '+sTheme:'')+(is_shiny?' shiny':'');
    }
    return false;
  }
  function setShiny(bShiny) {
    is_shiny = bShiny;
    var o = pagePlayer.getElementsByClassName('playlist','ul');
    var sClass = 'shiny';
    for (var i=o.length; i--;) {
      if (!bShiny) {
  	  pagePlayer.removeClass(o[i],sClass);
  	} else {
  	  pagePlayer.addClass(o[i],sClass);
  	}
    }
  }
  </script>
  

</head>

<!-- paulirish.com/2008/conditional-stylesheets-vs-css-hacks-answer-neither/ -->

<!--[if lt IE 7 ]> <body class="ie6"> <![endif]-->
<!--[if IE 7 ]>    <body class="ie7"> <![endif]-->
<!--[if IE 8 ]>    <body class="ie8"> <![endif]-->
<!--[if IE 9 ]>    <body class="ie9"> <![endif]-->
<!--[if gt IE 9]>  <body>             <![endif]-->
<!--[if !IE]><!--> <body>         <!--<![endif]-->


  <div id="container">
    <header>

    </header>
    
    <div id="main">

         <ul class="playlist">
        %for song in songs:
        <!-- ${song} -->
            <!-- <a href="${song['link']}">${song['title']}</a><br>${song['description']}<br> -->
            %for mp3 in song['mp3s']:
            <li>
                <a href="${mp3[0]}" class="sm2_link">${mp3[1]}</a>
            </li>
            %endfor
        
        %endfor
        </ul>

    </div>
    <div id="sm2-container">
     <!-- SM2 flash goes here -->
    </div>
    <div id="control-template">
     <!-- control markup inserted dynamically after each link -->
     <div class="controls">
      <div class="statusbar">
       <div class="loading"></div>
       <div class="position"></div>
      </div>
     </div>
     <div class="timing">
      <div id="sm2_timing" class="timing-data">
       <span class="sm2_position">%s1</span> / <span class="sm2_total">%s2</span>
      </div>
     </div>
     <div class="peak">
      <div class="peak-box"><span class="l"></span><span class="r"></span></div>
     </div>
    </div>

    <div id="spectrum-container" class="spectrum-container">
     <div class="spectrum-box">
      <div class="spectrum"></div>
     </div>
    </div>
    
    <footer>

    </footer>
  </div> <!--! end of #container -->


  <!-- Javascript at the bottom for fast page loading -->

  <!-- Grab Google CDN's jQuery. fall back to local if necessary -->
  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
  <script>!window.jQuery && document.write('<script src="static/js/jquery-1.4.2.min.js"><\/script>')</script>

  <!-- configure it for your use -->
  <script type="text/javascript">

  soundManager.url = 'static/js/soundmanager/swf'; // directory where SM2 .SWFs live

  // Note that SoundManager will determine and append the appropriate .SWF file to the URL,
  // eg. /path/to/sm2-flash-movies/soundmanager2.swf automatically.

  // Beta-ish HTML5 audio support (force-enabled for iPad), flash-free sound for Safari + Chrome. Enable if you want to try it!
  soundManager.useHTML5Audio = true;

  // do this to skip flash block handling for now. See the flashblock demo when you want to start getting fancy.
  soundManager.useFlashBlock = false;

  // disable debug mode after development/testing..
  // soundManager.debugMode = false;

  // Option 3 (best): onready() + createSound() methods, handle load/failure together:

  soundManager.onready(function() {
    // check if SM2 successfully loaded..
    if (soundManager.supported()) {
      // SM2 has loaded - now you can create and play sounds!
      var mySound = soundManager.createSound({
        id: 'aSound',
        url: 'static/test.mp3'
        // onload: [ event handler function object ],
        // other options here..
      });
      mySound.play();
    } else {
      // (Optional) Hrmm, SM2 could not start. Show an error, etc.?
    }
  });

  </script>
  <script src="static/js/plugins.js?v=1"></script>
  <script src="static/js/script.js?v=1"></script>
  <!-- // <script src="static/js/id3/binaryajax/binaryajax.js" ></script> -->
  <!-- // <script src="static/js/id3/id3.js" ></script> -->

  <!--[if lt IE 7 ]>
    <script src="static/js/dd_belatedpng.js?v=1"></script>
  <![endif]-->


  <!-- yui profiler and profileviewer - remove for production -->
  <!-- // <script src="static/js/profiling/yahoo-profiling.min.js?v=1"></script> -->
  <!-- // <script src="static/js/profiling/config.js?v=1"></script> -->
  <!-- end profiling code -->


  <!-- asynchronous google analytics: mathiasbynens.be/notes/async-analytics-snippet 
       change the UA-XXXXX-X to be your site's ID -->
  <script>
   var _gaq = [['_setAccount', 'UA-XXXXX-X'], ['_trackPageview']];
   (function(d, t) {
    var g = d.createElement(t),
        s = d.getElementsByTagName(t)[0];
    g.async = true;
    g.src = '//www.google-analytics.com/ga.js';
    s.parentNode.insertBefore(g, s);
   })(document, 'script');
  </script>
  
</body>
</html>
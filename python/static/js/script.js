$(function() {
    //namespace
    var bebop = {}
    
    //media element
    bebop.player = new MediaElementPlayer($("#audio_element").get(0));
    console.log(bebop.player)
    
    //hook up media links
    $(".playable").click(function(){
        bebop.media_swap(this)
        return false;
    })
    
    bebop.media_swap = function(o){
        this.player.pause()
        $(this.player).attr("src", $(o).attr("href"));
        this.player.play()
        return false;
    }
});
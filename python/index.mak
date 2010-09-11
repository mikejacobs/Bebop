<!-- /*${songs}*/ -->
<ul>
%for song in songs:
<!-- ${song} -->
<li>
    <a href="${song['link']}">${song['title']}</a><br>${song['description']}<br>
    %for mp3 in song['mp3s']:
        <a href="${mp3}">Song</a>
    %endfor
</li>
%endfor
</ul>
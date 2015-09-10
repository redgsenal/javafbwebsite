<%@include file="includes/header.jsp"%>
<div class="page">
	<div class="content">
		<div id="ytplayer"></div>
		<a class="buttonstyle graybutton center joincontest" href="fblogin.jsp">Join Our Facebook Contest</a>
	</div>
</div>


<script>
  // Load the IFrame Player API code asynchronously.
  var tag = document.createElement('script');
  tag.src = "https://www.youtube.com/player_api";
  var firstScriptTag = document.getElementsByTagName('script')[0];
  firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

  // Replace the 'ytplayer' element with an <iframe> and
  // YouTube player after the API code downloads.
  var player;
  function onYouTubePlayerAPIReady() {
    player = new YT.Player('ytplayer', {
      height: '390',
      width: '100%',
      videoId: '_wlAlvidrVs',
      playerVars:{
    	  'autoplay' : 1,
    	  'rel'  : 0
      }
    });
  }
</script>
<%@include file="includes/footer.jsp"%>
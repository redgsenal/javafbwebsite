<%@include file="includes/header.jsp"%>
	<div class="page">
		<div class="content">
			<h1>Welcome</h1>
			<div class="defaulthidden notfblogin">
				<button class="button login btnfblogin">Please login to your Facebook account and join in our Facebook page.</button>
				<!-- <fb:login-button scope="public_profile,email"></fb:login-button> -->
			</div>
			<div class="defaulthidden notapplogin">
				<button class="button login btnjoinlogin">Please join to our Facebook page app here.</button>
			</div>
			<div class="defaulthidden fbapplogin">
				<p>You're ready to send your feedback.</p>
			</div>
				
			<div id="status"></div>
		</div>
	</div>
<%@include file="includes/scripts.jsp"%>
<script src="js/fblogin.js"></script>
<%@include file="includes/footer.jsp"%>
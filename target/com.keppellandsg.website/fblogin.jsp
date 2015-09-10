<%@include file="includes/header.jsp"%>
	<div class="page">
		<div class="content">
			<fb:login-button scope="public_profile,email" onlogin="checkLoginState();"></fb:login-button>
			<div id="status"></div>
		</div>
	</div>
<%@include file="includes/footer.jsp"%>
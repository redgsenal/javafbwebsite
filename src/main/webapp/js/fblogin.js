function setFBLogin(_fblogin, _applogin){
	console.log('set fb');
	var notfblogin = $('.notfblogin');
	var notapplogin = $('.notapplogin');
	var fbapplogin = $('.fbapplogin');
	
	
	fblogin = _fblogin;
	applogin = _applogin;
	console.log('fblogin :', fblogin);
	console.log('applogin :', applogin);
	
	if (!fblogin) {
		notfblogin.show();
	}else if (!applogin){
		notapplogin.show();
	}
	if (fblogin && applogin){
		fbapplogin.show(function(){
			FB.api('/me', function(response) {
				$('.greeting').text("Hello " + response.name);
				$('input:text[name=fullname]').val(response.name);
			});
		});
		
	}
}

function loginFB(){
	FB.login(function(response){
		console.log(response);
		if (response.status === 'connected') // status login and accepted
			location.reload();
	});
}

$(function(){
	$('.btnjoinlogin, .btnfblogin').on('click', function(){
		console.log('join to fb or app');
		loginFB();
	});
});
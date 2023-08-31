<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- Caps Lock의 이벤트 핸들러 DOM 기능 추가 -->
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<title>이용자 로그인</title>
<style type="text/css">
 main{width:fit-content; margin:2em auto;}
 main h3{text-align:center;}
 form{border:1px solid black; padding:1em;}
 form label {display:inline-block; width:3em; padding:0.2em 0.5em; font-weight:bold;}
 form div:last-child {text-align: right; margin:0.5em;}
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
</head>
<body>
<main>
	<h3>이용자 로그인</h3>
	<form id="loginForm">
 		<div><label for="id">아이디</label>
			<input type="text" id="userid" name="userid" required>
		</div>
		<div><label for="pass">암호</label>
			<input type="password" id="pass" name="pass" required>
		</div>
		<div id="caps-lock-warning" style="display: none; color: red;">Caps Lock이 켜져 있습니다.</div>
		<div>
			<button type="reset">취소</button>
			<button type="button" onclick="login()">로그인</button>
		</div>
	</form>
</main>

<script type="text/javascript">
function login(){
	
	var info = $('#loginForm').serialize();
	$.ajax({
		url:'/fairy/login',
		method:'post',
		data:info,
		cache:false,
		dataType:'json',
		success:function(res){
			 if (res.login) {
                 alert('로그인 성공.\n오늘도 행복하세요^^');
                 location.href = '/book/list/page/1';
             } else {
                 if (res.signupRequired) {
                     if (confirm('회원가입이 필요합니다. 회원가입 하시겠습니까?')) {
                         location.href = '/fairy/joinForm';
                     }
                 } else {
                     alert('아이디와 비밀번호가 일치하지 않습니다.\n다시 입력해주세요.');
                 }
             }
         },
		error:function(xhr,status,err){
		      alert('로그인에 실패하였습니다.\n관리자에게 문의 바랍니다.'+err);
			console.log(xhr.responseText);
		}
	});
	return false;
}	




var passwordInput = document.getElementById('pass');
var capsLockWarning = document.getElementById('caps-lock-warning');

passwordInput.addEventListener('keydown', function(event) {
  if (event.getModifierState && event.getModifierState('CapsLock')) {
    capsLockWarning.style.display = 'block';
  } else {
    capsLockWarning.style.display = 'none';
  }
});


function login2(){
	var info = $('#loginForm').serialize();
	$.ajax({
		url:'/fairy/login',
		method:'post',
		data:info,
		cache:false,
		dataType:'json',
		success:function(res){
			 if (res.login) {
                 alert('로그인 성공.\n오늘도 행복하세요^^');
                 location.href = '/book/list/page/1';
             } else {
                 if (res.signupRequired) {
                     if (confirm('회원가입이 필요합니다. 회원가입 하시겠습니까?')) {
                         location.href = '/fairy/joinForm';
                     }
                 } else {
                     alert('아이디와 비밀번호가 일치하지 않습니다.\n다시 입력해주세요.');
                 }
             }
         },
		error:function(xhr,status,err){
		      alert('로그인에 실패하였습니다.\n관리자에게 문의 바랍니다.'+err);
			console.log(xhr.responseText);
		}
	});
	return false;
}	
</script>
</body>
</html>
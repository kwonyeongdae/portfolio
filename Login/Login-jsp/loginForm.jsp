<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- Caps Lock의 이벤트 핸들러 DOM 기능 추가 애니메이션 추가 -->
<!DOCTYPE html>
<html> 
<meta name="viewport" content="width=device-width, initial-scale=1.0"> <!--모바일 이용시 애니메이션 원활 위함. 아예 없었던 부분 -->
<head>
<meta charset="utf-8">
<title>이용자 로그인</title>
<style type="text/css">

 main { width:fit-content; margin:1.5em auto;}
 main p { margin-bottom:1.5em;}
 main h3 { text-align:center; margin-top:-4em;}
 form { border:1px solid black; margin-top:1.9em; padding:1em 1em 1em; width: 400px; box-sizing: border-box; margin: 1.9em auto; }
 form label { display:inline-block; width:3em; padding:0.2em 0.5em; font-weight:bold;}
 form div:last-child { text-align:right; margin:0.5em;}
 .find_link:hover{color: red; font-size:18px;} 
 .find_link{color:#484848; font-size:12px; margin-left:6px; text-decoration:none;}
 
  /* 왼쪽에서 오른쪽으로 이동하는 애니메이션 */
 body {
  margin: 0;
  overflow: hidden;
 }

 .scrolling-text {
   position: absolute;
   top: 18px;
   white-space: nowrap;
   transform: translateY(-50%);
   animation: scrolling 40s linear infinite;
 }
  
 .scrolling-text.second {animation-delay: 20s; opacity: 0; }

 @keyframes scrolling {
   0% { transform: translateY(-50%) translateX(-300%); opacity: 1; }
   100% { transform: translateY(-50%) translateX(500%); opacity: 1; }
 }
  
 #background-image {
   position: fixed;
   bottom: 0; /* 이미지를 바닥에 두려면 이 부분을 top:0에서 bottom으로 해서 바닥 기준으로 해둬야 함*/
   left: 0;
   z-index: -1; /* 기존의 요소들 아래에 이미지가 위치하도록 설정 */
   width: 100%; /* 이미지를 화면 폭에 맞춤 */
   opacity: 0.5;  /* 원하는 투명도(0.0 - 1.0 사이)로 설정 */
   object-fit: cover; /* 이미지를 배경 크기에 맞게 조절 */
   height: 20%; /* 높이를 원하는 만큼 퍼센티지 조절 */
  
 }
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
</head>
<body>
   <h2 class="scrolling-text">안녕하세요. 오늘도 fairy's books입니다.</h2>
   <h2 class="scrolling-text second">안녕하세요. 오늘도 fairy's books입니다.</h2>
 <main>
    <p> <img src="/files/fRabbit.gif" alt="슬라이딩 이미지"></p>
    <img id="background-image" src="/files/flower_meadow.jpg" alt="배경 이미지">
	<h3>이용자 로그인</h3>
	<form id="loginForm">
		<div><label for="userid">아이디</label>
			<input type="text" id="userid" name="userid" required>
			<a href="/fairy/find/ID" class="find_link">아이디 찾기</a>
		</div>
		<div><label for="pass">암호</label>
			<input type="password" id="pass" name="pass" required>
			<a href="/fairy/find/pass" class="find_link">암호 찾기</a>
		</div>
		<div id="caps-lock-warning" style="display: none; color: red;">Caps Lock이 켜져 있습니다.</div>
		<div style="display:flex; justify-content: space-between;"> <!-- flex 레이아웃 이용 -->
		    <div style="position:relative; top:13px;"> <!-- 아이디 저장 문구를 조금 더 아래로 이동 -->
			    <input type="checkbox" id="rememberID"/> 
			    <span style="color:#484848; font-size:14px; margin-right:120px; margin-top:12px"><b>아이디 저장</b></span>
	   	    </div>
		    <div>
				<button type="reset">취소</button>
				<button type="submit">로그인</button>
			</div> 
		</div>
		    <div>
		       <a href="/fairy/joinForm" ><b>회원가입이 필요하시다면? Click!</b></a>
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
				// 로그인 성공 시점에 아이디 저장
                 rememberID();
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


$('#loginForm').on('submit', function(event) {
  event.preventDefault();
  login();
 })

var passwordInput = document.getElementById('pass');
var capsLockWarning = document.getElementById('caps-lock-warning');

passwordInput.addEventListener('keydown', function(event) {
  if (event.getModifierState && event.getModifierState('CapsLock')) {
    capsLockWarning.style.display = 'block';
  } else {
    capsLockWarning.style.display = 'none';
  }
});


function rememberID() {
    var userIDField = document.getElementById("userid");
    var rememberID = document.getElementById("rememberID");
    
    if (rememberID.checked) {
        // 아이디 저장을 체크한 경우, 입력한 아이디를 저장
        var userID = userIDField.value;
        localStorage.setItem("savedUserID", userID);
    } else {
        // 아이디 저장을 해제한 경우, 저장된 아이디 정보를 삭제
        localStorage.removeItem("savedUserID");
    }
}

// 페이지 로드 시 저장된 아이디를 입력 필드에 채워 넣기
window.onload = function() {
    var userIDField = document.getElementById("userid");
    var rememberCheckbox = document.getElementById("rememberID");
    var savedUserID = localStorage.getItem("savedUserID"); /* savedUserID는 localStorage의 객체 */
    
    if (savedUserID) {
        userIDField.value = savedUserID;
        rememberCheckbox.checked = true;  // 체크박스 상태 복구
    }
};
  
</script>

</body>
</html>
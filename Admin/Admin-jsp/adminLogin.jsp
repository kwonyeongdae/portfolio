<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!-- Caps Lock의 이벤트 핸들러 DOM 기능 추가 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>관리자 로그인</title>
<style type="text/css">
 main{width:fit-content; margin:2em auto;}
 main h3{text-align:center;}
 form{border:1px solid black; padding:1em;}
 form label {display:inline-block; width:5.5em; padding:0.2em 0.5em; font-weight:bold;}
 form div:last-child {text-align: right; margin:0.5em;}
 input{width:130px;}
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
</head>
<body>
<main>
 <h3>관리자 로그인</h3>
    <form id="adminLoginForm" onsubmit="return adminLogin();">
       <div style="margin-bottom: 0.5em; display: inline-block;">
        <span style="color:#e21111; font-size:12px; padding:0 0 12px 14px;">
             ※관리자 번호를 기부여 받으신 분만 이용 가능합니다.
         </span>
       </div>      
       <div>
           <label for="number">관리자 번호</label>
            <input type="password" id="number" name="number" required>
        </div>
      <div><label for="id">아이디</label>
         <input type="text" id="userid" name="userid" required>
      </div>
      <div><label for="pass">암호</label>
         <input type="password" id="pass" name="pass" required>
      </div>
      <div id="caps-lock-warning" style="display: none; color: red;">Caps Lock이 켜져 있습니다.</div>
      <div>
         <button type="reset">취소</button>
         <button type="submit">로그인</button>
      </div>
   </form>
</main>

<script type="text/javascript">
function adminLogin(){
   var info = $('#adminLoginForm').serialize();
   $.ajax({
      url:'/fairy/adminLogin',
      method:'post',
      data:info,
      cache:false,
      dataType:'json',
      success:function(res){
         alert(res.adminLogin ? '로그인 성공.\n오늘도 행복하세요^^':'아이디와 비밀번호가 일치하지 않습니다.\n다시 입력해주세요.')
         if(res.adminLogin) location.href='/fairy/admin';
      },
      error:function(xhr,status,err){
         alert('에러:'+err)
         console.log(xhr.responseText);
      }
   });
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
</script>

</body>
</html>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<meta name="viewport" content="width=device-width, initial-scale=1.0"> <!--모바일 이용시 애니메이션 원활 위함. -->
<head>
<meta charset="utf-8">
<title>회원가입 폼</title>
<style type="text/css">
    
	main {width:fit-content; margin:0.5em auto; }
	main > h3 { text-align: center;}
	form { border:1px solid black; padding:2em; }
	form>div:last-child { margin-top:0.5em; text-align:center; }
	div { margin-bottom:0.5em;}
	form>div>label {display:inline-block; width:6em; text-align: left; padding-right:1em;}
    #pass-confirm {margin-top:0.9em;}
    .address { margin-left:0.8em;}
    #postal_code { margin-left: -1em; width:100px;}
    #contact_address { margin-left:7.8em; margin-top:0.9em; width:250px;}
    #detailed_address  { margin-top:0.5em; width:350px;}
    #br-label {display:inline-block; width:5.2em; margin-left:0.7em;}
	#age-label {display:inline-block; width:auto; margin-left:0.1em; margin-top:0.5em;}
	#age {margin-left:0.4em; width:25px;}
	fieldset {width: 7em;}
	form>div:last-child { margin-top:1em;} 
	
	.fairy-text {
	  position: absolute;
	  top: 0.2px;
	  left: 180px;
	  animation: moveUpDown 3s infinite alternate;
	 }

    .fairy-text.second  {
	  position: absolute;
	  top: 10px;
	  right: 50px;;
	  animation: moveUpDown 10s infinite alternate;
	 }
    
    @keyframes moveUpDown {
	  0% { transform: translateY(-100) translateX(-10%);}
	  100% { transform: translateY(20px) translateX(-10%);}
    }
    
    .fairy-text-right {
      position: absolute;
      top: 10px;
      right: 10px;
      animation: moveUpDownRight 10s infinite alternate;
      z-index: 2;
    }
  
    #bear-moving {
      position: absolute;
      top: 10px;
      right: 8px;
      animation: moveUpDownRight 10s infinite alternate;
      z-index: 1;
      animation-delay: 2.5s; /* 시간 차 주기 */
      witdh:200px;
      height:150px;
    }


    @keyframes moveUpDownRight {
      0% { transform: translateY(500px) translateX(10px);}
      100% { transform: translateY(50px) translateX(10px);}
    }
  
    #background-image {
      position: fixed;
      top: 0;
      left: 0;
      z-index: -1; /* 기존의 요소들 아래에 이미지가 위치하도록 설정 */
      width: 100%; /* 이미지를 화면 폭에 맞춤 */
      opacity: 0.5;  /* 원하는 투명도(0.0 - 1.0 사이)로 설정 */
      object-fit: cover; /* 이미지를 배경 크기에 맞게 조절 */
      height: 100vh; /* View Height 약자*/
    }
 
    .balloon {
      position: absolute;
      opacity: 0.2;
      witdh: 130px;
      height: 130px;
      animation-name: moveBalloon;
      animation-timing-function: linear;
      animation-iteration-count: infinite;
      animation-direction: alternate;
      top: calc(100% + 50px);
      left: calc((1% + (95% * var(--i) / 18)) - (5% * var(--i) / 18)); /* 양쪽 끝 1% 여유 주고 95% 차지 , 풍선 개수 18개, 5%를 조절하여 조금씩 왼쪽으로 밀기 */
      animation-duration: calc(15s + var(--i) * 3s);   
    }

    .moveBalloon {
      0% { transform: translate(0, 100%) translateX(0); }
      100% { transform: translateY(-50%) translateX(50vw); }
    }

    @keyframes moveBalloon {
       0% { transform: translateY(100%) translateX(0); }
       100% { transform: translateY(-500%) translateX(0); }
    }


</style>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
var isIdChecked = false;
var isEmailChecked = false;

function form_check() {
	  
  var userid = document.getElementById("userid").value;
  var pass = document.getElementById("pass").value;
  var passconfirm  = document.getElementById("pass-confirm").value;
  var name = document.getElementById("name").value;
  var phone1 = document.getElementById("phone1").value;
  var phone2 = document.getElementById("phone2").value;
  var phone3 = document.getElementById("phone3").value;
  var phone = phone1 + '-' + phone2 + '-' + phone3;
  var email = document.getElementById("email").value;
  var postal_code = document.getElementById("postal_code").value;
  var contact_address= document.getElementById("contact_address").value;
  var detailed_address = document.getElementById("detailed_address").value;
  var genderInput = document.querySelector('input[name="gender"]:checked');
  var birth = document.getElementById("birth").value;
  var age = document.getElementById("age").value;
  var agrStipulation1 = document.getElementById("agrStipulation1").checked;
  var agrStipulation2 = document.getElementById("agrStipulation2").checked;
  var agrStipulation3 = document.getElementById("agrStipulation3").checked;
   
  if (userid == "") {
    alert("'아이디' 입력은 필수입니다");
    return false;
    
  } else if (pass == ""||passconfirm == "") {
    alert("'암호' 입력은 필수입니다");
    return false;
  } else if (name == "") {
    alert("'이름' 입력은 필수입니다");
    return false;
  } else if (phone1 == "" || phone2 == "" || phone3 == "") {
    alert("'전화' 입력은 필수입니다");
    return false;
  } else if (!/^\d{3}$/.test(phone1) || !/^\d{4}$/.test(phone2) || !/^\d{4}$/.test(phone3)) {
    alert("'전화' 형식이 올바르지 않습니다");
    return false;
  } else if (email == "") {
    alert("'이메일' 입력은 필수입니다");
    return false;
  } else if (age == "") {
	alert("'나이' 입력은 필수입니다");
	return false;
  } else if (!genderInput) {
	alert("'성별' 선택은 필수입니다");
	return false;
  } else if (!agrStipulation1) {
    alert("'이용약관'에 동의해야 합니다");
    return false;
  } else if (!agrStipulation2) {
    alert("'개인 정보 수집 및 이용'에 동의해야 합니다");
    return false;
  }
  /* if (!gender) {
		alert("'성별' 선택은 필수입니다");
		return false;
	  } 
      gender = gender.value; */
  var gender = genderInput.value;
  if (!isIdChecked) {
	    alert("'아이디 중복체크'를 확인해주세요");
	    return false;
	  }
  
  if (!isEmailChecked) {
	    alert("'이메일 중복체크'를 확인해주세요");
	    return false;
	  }
  
  // 아이디 검증
  var userIdRegex = /^(?=.*[a-zA-Z])(?=.*[0-9])[a-zA-Z0-9]{4,12}$/;
  if (!userIdRegex.test(userid)) {
    alert("아이디는 4자~12자의 영문자와 숫자로 입력해주세요.");
    return false;
  }

  // 비밀번호 검증
  var passwordRegex = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%/\\\-_])[a-zA-Z0-9!@#$%/\\\-_]{8,16}$/;
  if (!passwordRegex.test(pass)) {
    alert("영문 대소문자/숫자/특수문자를 혼용하여 8~16자 입력해주세요. 특수문자는 !@#$%-_만 가능합니다.");
    return false;
  }
  
  if (!confirm("가입을 완료할까요?")) {
    alert("취소했습니다");
    return false;

  }

 
  var formdata = {
		    userid: userid,
		    pass: pass,
		    name: name,
		    phone: phone,
		    email: email,
		    postal_code: postal_code,
		    contact_address: contact_address,
		    detailed_address: detailed_address,
		    birth: birth,
		    age: age,
		    gender: gender,
		    agrStipulation1: agrStipulation1,
		    agrStipulation2: agrStipulation2,
		    agrStipulation3: agrStipulation3
		  };

 $.ajax({
    url: '/fairy/join',
    method: 'post',
    data: formdata,

   cache: false,
    dataType: 'json',
    success: function (res) {
      alert(res.addedJoin ? '가입을 환영합니다. ♡.♡' : '가입에 실패하였습니다. 관리자에게 문의해주세요.');
      if (res.addedJoin) {

       location.href = '/fairy/login';
        //가입 환영 이메일을 보내기 등
      }
    },
   error: function (xhr, status, err) {
    	alert('가입 실패. 관리자에게 문의바랍니다.');
        console.log(xhr.responseText);
    }

 });

  return false;
}

document.addEventListener('DOMContentLoaded', function() {
 var userIdInput = document.getElementById('userid');
 var userIdValidationMessage = document.getElementById('userIdValidationMessage');
  userIdInput.addEventListener('input', function() {
    var userId = userIdInput.value;

    var regex = /^(?=.*[a-zA-Z])(?=.*[0-9])[a-zA-Z0-9]{4,12}$/;

    if (!regex.test(userId)) {
      userIdValidationMessage.style.display = 'block';
    } else {
      userIdValidationMessage.style.display = 'none';
    }
  });

  var passwordInput = document.getElementById('pass');
  var confirmPasswordInput = document.getElementById('pass-confirm');

  passwordInput.addEventListener('input', checkPasswordMatch);
  confirmPasswordInput.addEventListener('input', checkPasswordMatch);

  function checkPasswordMatch() {
    var password = passwordInput.value;
    var confirmPassword = confirmPasswordInput.value;
    var mismatchMessage = document.getElementById('password-mismatch');

    var passwordRegex = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%/\\\-_])[a-zA-Z0-9!@#$%/\\\-_]{8,16}$/;
    //^는 정규식 문자열의 시작을 의미
   // 정규식은 특정한 패턴을 정의하는 문자열 패턴. 순서에 따라 패턴이 일치하거나 일치하지 않을 수 있지만, 순서가 강제되는 것은 아님
    //^는 문자열의 시작을 나타내는 메타문자(meta-character)
    //정규식에서 '/'는 정규식 패턴을 감싸는 구분자(delimiter) 역할
    //$는 문자열의 끝을 의미
    //(?=.*[0-9])는 전방 탐색을 사용하여 해당 위치 뒤에 최소한 하나 이상의 숫자가 포함되어야 함
    //(?= )는 전방 탐색(lookahead) 기호로 (?= ) 뒤에 오는 패턴은 해당 위치 뒤에 일치해야 하는 조건을 지정
   //'-'과 '\'은 특수기호로 이용시 '\'을 한 번 더 써줘야함 또는 '-'은 조건에 맨 뒤에 써주면 범위를 나타내는 것이 아님을 알려줄 수 있어 특수기호로 사용 가능
    if (password !== confirmPassword) {
      mismatchMessage.textContent = '비밀번호가 일치하지 않습니다.';
      mismatchMessage.style.display = 'block';
    } else if (!passwordRegex.test(password)) {
      mismatchMessage.textContent = '영문 대소문자/숫자/특수문자를 혼용하여 8~16자 입력해주세요.';
      mismatchMessage.style.display = 'block';
    } else {
      mismatchMessage.style.display = 'none';
    }
  }
});

function checkAllStipulations() {
  var checkAll = document.getElementById('agrStipulationAll');
  var stipulation1 = document.getElementById('agrStipulation1');
  var stipulation2 = document.getElementById('agrStipulation2');
  var stipulation3 = document.getElementById('agrStipulation3');

  stipulation1.checked = checkAll.checked;
  stipulation2.checked = checkAll.checked;
  stipulation3.checked = checkAll.checked;
  
}

function checkDuplicateId() {
	  var userid = document.getElementById("userid").value;
	  if (userid.trim() == "") {
		    alert("아이디를 입력해주세요.");
		    return;
		  }
	  $.ajax({
		    url: '/fairy/join', 
		    method: 'GET', 
		    data: {userid: userid},
		    dataType: 'json',
		    success: function(res) {
		      if (res.isDuplicateId) {
		        alert("이미 사용 중인 아이디입니다.\n다른 아이디를 입력해주세요.");
		        isIdChecked = false;
		      } else {
		        alert("사용 가능한 아이디입니다.");
		        isIdChecked = true;
		      }
		    },
		    error: function(xhr, status, error) {
		      alert("중복 체크에 실패하였습니다. 잠시 후 다시 시도해주세요.");
		      console.log(xhr.responseText);
		    }
	  });
}

function checkDuplicateEmail() {
	  var email = document.getElementById("email").value;
	  if (email.trim() === "") {
		    alert("이메일 주소를 입력해주세요.");
		    return;
		  }
	  $.ajax({
	    url: '/fairy/join', 
	    method: 'GET', 
	    data: {email: email},
	    dataType: 'json',
	    success: function(res) {
	      if(res.isDuplicateEmail) {
	        alert("이미 사용 중인 이메일입니다.\n다른 이메일을 입력해주세요.");
	        isEmailChecked = false;
	      } else {
	        alert("사용 가능한 이메일입니다.");
	        isEmailChecked = true;
	      }
	    },
	    error: function(xhr, status, error) {
	      alert("중복 체크에 실패하였습니다. 잠시 후 다시 시도해주세요.");
	      console.log(xhr.responseText);
	    }
	  });
}

function findAddr(){
	new daum.Postcode({
        oncomplete: function(data) 
        {
           	console.log(data);
            var roadAddr = data.roadAddress; 
            var jibunAddr = data.jibunAddress; 
            document.getElementById('postal_code').value = data.zonecode;
            if(roadAddr !== ''){
                document.getElementById("contact_address").value = roadAddr;
            } 
            else if(jibunAddr !== ''){
                document.getElementById("contact_address").value = jibunAddr;
            }
        }
    }).open();
}

</script>
</head>
<body>
<main>
  <h3>회원 가입</h3>
  <h5 class="fairy-text">fairy's books</h5>
  <h5 class="fairy-text second">fairy's books</h5>
  <h5 class="fairy-text-right">fairy's books</h5>
  <img id="bear-moving" src="/files/fbear.png" alt="잠자는 곰 이미지">
  <img id="background-image" src="/files/child_book.jpg" alt="배경 이미지">
  <form id="joinForm" onsubmit="return form_check();">
   <div>
     <font color="#e21111"><strong>* 항목은 필수 항목입니다.</strong></font>
    </div>
    <div>
      <label for="userid">* 아이디</label>
      <input type="text" name="userid" id="userid">
      <button type="button" onclick="checkDuplicateId();">중복체크</button> 
         <span style="color:#282828; font-size:12px; padding:0 0 0 14px;">(4자~12자리의 영문자, 숫자 혼합/@#$%등 특수문자는 제외)</span>
         <span style="color:#e21111; font-size:12px; padding:0 0 0 14px;"><b>※ 아이디는 대소문자 구분/가입 후 변경이 불가합니다.</b></span>
         <div id="userIdValidationMessage" style="color: red; display: none;">아이디는 4자~12자의 영문자와 숫자로 입력해주세요.</div>
    </div>
    <div class="password-group">
      <label for="pass">* 암호</label>
      <input type="password" name="pass" id="pass"> <br>
      <label for="pass-confirm">* 암호 확인</label>
      <input type="password" name="pass" id="pass-confirm">
        <span style="color:#282828; font-size:12px; padding:0 0 0 14px;">(영문 대소문자/숫자/특수문자를 혼용하여 8~16자 입력 / 특수문자는 !@#$%\-_ 만 가능)</span>
      <div id="password-mismatch" style="color: red; display: none;"></div>
    </div>
    <div>
      <label for="name">* 이름</label>
      <input type="text" name="name" id="name">
    </div>
    <div>
	  <label for="phone1">* 전화</label>
	  <input type="text" name="phone" id="phone1" style="width:2.7em;"> -
	  <input type="text" name="phone" id="phone2" style="width:2.7em;"> -
	  <input type="text" name="phone" id="phone3" style="width:2.7em;">
    </div>
    <div>
      <label for="email">* 이메일</label>
      <input type="text" name="email" id="email">
      <button type="button" onclick="checkDuplicateEmail();">중복체크</button> 
    </div>
    
    <div class="address">
	    <label for="postal_code">주소</label>
		<input name="postal_code" id="postal_code"  type="text" placeholder="우편번호" readonly onclick="findAddr()">
		<span style="color:#484848; font-size:12px; padding:0 0 0 14px;"><b>(클릭하시면 검색 주소 선택시 자동 입력됩니다. 입력하신 주소는 이벤트 참여시에 활용됩니다.)</b></span>
		<br>
		<input name="contact_address" id="contact_address" type="text" placeholder="기본 주소" readonly> 
		<input name="detailed_address" id="detailed_address" type="text" placeholder="상세 주소">
    </div>
    <div>
     <label for="birth" id="br-label">생년월일</label>
     <input type="text" name="birth" id="birth"> 
    <span style="color:#787878; font-size:12px; padding:0 0 0 14px;">(생년월일이 85년 1월 1일인 경우: 850101)</span>
  </div> 
  <div>
      <fieldset>
        <legend>* 성별</legend>
        남자<input type="radio" name="gender" value="m">
        여자<input type="radio" name="gender" value="f">
      </fieldset>
    </div>
   <div>
     <label for="age" id="age-label">* 자녀 혹은 주이용 아동 나이</label>
     <span style="color: blue;">만</span><input type="text" name="age" id="age">세
    <span style="color:#282828; font-size:12px; padding:0 0 0 14px;">(<span style="color: red;"><b>아동의 나이</b></span>를 입력해주세요. 도서를 추천해드립니다.)</span>
  </div>
    
<table width="905" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td style="width:193px; font:20px malgun gothic; vertical-align:top; letter-spacing:-1px; padding:25px 0 0 10px">* 약관 동의</td>
    <td style="padding:25px 0 0 0">
      <div class="join_agrCheckAll">
        <input type="checkbox" id="agrStipulationAll" onclick="checkAllStipulations()"/>
        <label for="agrStipulationAll">모든 약관에 동의합니다.</label>
      </div>
       <span style="color:#00ffff; font-size:14px;">필수 동의 항목</span>
      <div class="join_agrCheck join_agrCheck01">
        <input type="checkbox" name="agrStipulation1" id="agrStipulation1" />
        <label for="agrStipulation1">이용약관</label>
        <a href="#" class="join_agrCheckBtn">자세히보기</a>
      </div>
      <div class="join_agrCheck join_agrCheck02">
        <input type="checkbox" name="agrStipulation2" id="agrStipulation2"/>
        <label for="agrStipulation2">개인 정보 수집 및 이용</label>
        <a href="#" class="join_agrCheckBtn">자세히보기</a>
      </div>
      <span style="color:#00ffff; font-size:14px;">선택 동의 항목</span><br>
      <span style="font-size:12px;"> 동의시 다양한 혜택을 제공해드립니다.</span>
      <div class="join_agrCheck join_agrCheck03" style="margin-top: 10px;">
        <input type="checkbox" name="agrStipulation3" id="agrStipulation3"/>
        <label for="agrStipulation3">마케팅 정보 동의</label>
        <a href="#" class="join_agrCheckBtn">자세히보기</a>
      </div>
    </td>
  </tr>
</table>
   <div>
        <button type="submit">회원 가입하기</button>
      	<button type="reset">다시 작성</button>
    </div>
  </form> 
    <img class="balloon" style="--i:1" src="/files/balloon1.png" alt="풍선 1">
	<img class="balloon" style="--i:2" src="/files/balloon2.png" alt="풍선 2">
	<img class="balloon" style="--i:3" src="/files/balloon3.png" alt="풍선 3">
	<img class="balloon" style="--i:4" src="/files/balloon4.png" alt="풍선 4">
	<img class="balloon" style="--i:5" src="/files/balloon5.png" alt="풍선 5">
	<img class="balloon" style="--i:6" src="/files/balloon6.png" alt="풍선 6">
	<img class="balloon" style="--i:7" src="/files/balloon7.png" alt="풍선 7">
	<img class="balloon" style="--i:8" src="/files/balloon8.png" alt="풍선 8">
	<img class="balloon" style="--i:9" src="/files/balloon9.png" alt="풍선 9">
	<img class="balloon" style="--i:10" src="/files/balloon10.png" alt="풍선 10">
	<img class="balloon" style="--i:11" src="/files/balloon11.png" alt="풍선 11">
	<img class="balloon" style="--i:12" src="/files/balloon12.png" alt="풍선 12">
	<img class="balloon" style="--i:13" src="/files/balloon13.png" alt="풍선 13">
	<img class="balloon" style="--i:14" src="/files/balloon14.png" alt="풍선 14">
	<img class="balloon" style="--i:15" src="/files/balloon15.png" alt="풍선 15">
	<img class="balloon" style="--i:16" src="/files/balloon16.png" alt="풍선 16">
	<img class="balloon" style="--i:17" src="/files/balloon17.png" alt="풍선 17">
	<img class="balloon" style="--i:18" src="/files/balloon18.png" alt="풍선 18">
</main>
</body>
</html>
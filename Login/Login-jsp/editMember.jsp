<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>회원 정보 수정</title>
<style type="text/css">
  main {width:fit-content; margin:0.5em auto; }
  main > h3 { text-align: center;}
  label{font-weight:bold;}
  form { border:1px solid black; padding:2em; }
  form>div:last-child { margin-top:2em; text-align:center; }
  div { margin-bottom:0.5em;}
  #newPostal_code { margin-left: 0.2em; width:100px;}
  #newContact_address { margin-left:6.8em; margin-top:0.9em; width:250px;}
  #newDetailed_address  { margin-top:0.5em; width:350px;}
</style>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">

var isEmailChecked = false;

function form_check() {
	  var fnum = document.getElementById("fnum").value;
	  var userid = $('#userid').text();
	  var pass = document.getElementById("pass").value;
	  var newPass = document.getElementById("newPass").value;
	  var passconfirm = document.getElementById("pass-confirm").value;
	  var mismatchMessage = document.getElementById("password-mismatch");
	  var passwordRequirements = document.getElementById("password-requirements");
	  var phone1 = document.getElementById("newPhone1").value;
	  var phone2 = document.getElementById("newPhone2").value;
	  var phone3 = document.getElementById("newPhone3").value;
	  var phone = phone1 + '-' + phone2 + '-' + phone3;
	  var email = document.getElementById("newEmail").value;
	  
	  var postal_code = document.getElementById("newPostal_code").value;
	  var contact_address= document.getElementById("newContact_address").value;
	  var detailed_address = document.getElementById("newDetailed_address").value;
	  
	  var originalPostalCode = "${member.postal_code}";
	  var originalContactAddress = "${member.contact_address}";
	  var originalDetailedAddress = "${member.detailed_address}";
	  
	  var agrStipulation3 = document.querySelector('input[name="agrStipulation3"]:checked');
	  
	  if (agrStipulation3) {
	    agrStipulation3 = agrStipulation3.value;
	  } else {
	    agrStipulation3 = "false"; 
	  }

	  if (newPass !== "" && passconfirm !== "") {
	    if (mismatchMessage.style.display === "block" || passwordRequirements.style.display === "block") {
	      return false;
	    }
	    pass = newPass;
	  }else {
			  pass = "${member.pass}";
		}

	  if (phone1 !== "" && phone2 !== "" && phone3 !== "") {
	    if (!/^\d{3}$/.test(phone1) || !/^\d{4}$/.test(phone2) || !/^\d{4}$/.test(phone3)) {
	      alert("'전화' 형식이 올바르지 않습니다");
	      return false;
	    }
	    phone = phone1 + '-' + phone2 + '-' + phone3;
	  }else{
		      phone = "${member.phone}";
	  }

	  if(email === "") {
		    email = "${member.email}";
	  }else{
	    if (!isEmailChecked) {
		     alert("'이메일 중복체크'를 확인해주세요");
		     return false;
		  }
	  }
	  
	    if (
	      pass === "${member.pass}" &&
	      phone === "${member.phone}" &&
	      email === "${member.email}" &&
	      
	      postal_code === originalPostalCode &&
	      contact_address === originalContactAddress &&
	      detailed_address === originalDetailedAddress &&
	      
	      agrStipulation3 === "${member.agrStipulation3}" 
	    ) {
	      alert("변경된 정보가 없습니다. 수정 후 다시 시도해주세요.");
	      return false;
	    }

	  var formdata = {
	    fnum: fnum,
	    userid: userid,
	    pass: pass,
	    phone: phone,
	    email: email,
	    
	    postal_code: postal_code,
	    contact_address: contact_address,
	    detailed_address: detailed_address,
	    
	    agrStipulation3: agrStipulation3
	  };
	
	    
	 $.ajax({
	    url: '/fairy/updateMem/${userid}',
	    method: 'post',
	    data: formdata,
      	cache: false,
	    dataType: 'json',
	    success: function (res) {
	      alert(res.updated ? '정보 수정 성공' : '정보 수정에 실패하였습니다. 관리자에게 문의해주세요.');
	      if (res.updated) {

	       location.href = '/fairy/cart/index';
	      
	      }
	    },
	   error: function (xhr, status, err) {
	    	alert('수정 실패. 관리자에게 문의바랍니다.');
	        console.log(xhr.responseText);
	    }

	 });

	  return false;
	}


document.addEventListener("DOMContentLoaded", function () {
	  var passwordInput = document.getElementById("newPass");
	  var confirmPasswordInput = document.getElementById("pass-confirm");

	  passwordInput.addEventListener("input", checkPasswordConditions);
	  confirmPasswordInput.addEventListener("input", checkPasswordConditions);

	  function checkPasswordConditions() {
	    var password = passwordInput.value;
	    var confirmPassword = confirmPasswordInput.value;
	    var mismatchMessage = document.getElementById("password-mismatch");
	    var passwordRequirements = document.getElementById("password-requirements");
	    var passwordRegex = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%/\\-_])[a-zA-Z0-9!@#$%/\\-_]{8,16}$/;

	    var isNewPasswordEmpty = password === "" && confirmPassword === "";
	    var isPasswordMismatch = password !== confirmPassword;
	    var isPasswordInvalid = !passwordRegex.test(password);

	    if (isNewPasswordEmpty) {
	      mismatchMessage.style.display = "none";
	      passwordRequirements.style.display = "none";
	    } else if (isPasswordMismatch) {
	      mismatchMessage.textContent = "비밀번호가 일치하지 않습니다.";
	      mismatchMessage.style.display = "block";
	      passwordRequirements.style.display = "none";
	    } else {
	      if (isPasswordInvalid && confirmPassword !== "") {
	        mismatchMessage.style.display = "none";
	        passwordRequirements.textContent = "영문 대소문자/숫자/특수문자를 혼용하여 8~16자 입력해주세요.";
	        passwordRequirements.style.display = "block";
	      } else {
	        mismatchMessage.style.display = "none";
	        passwordRequirements.style.display = "none";
	      }
	    }
	  }
	});



  function checkDuplicateEmail() {
		  var email = document.getElementById("newEmail").value;
		  if (email == "") {
			    alert("변경할 이메일을 먼저입력해주세요.");
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

	
  var isRadioUpdated = false; 

    document.getElementById("submitButton").addEventListener("click", function () {
      if (isRadioUpdated) {
       
        updateAgrStipulation3();
      }
      form_check(); 
    });

	  
  function updateAgrStipulation3() {
    var spanElement = document.getElementById("agrStipulation3");
    var radioElements = document.querySelectorAll('input[name="agrStipulation3"]');
    var radioElement = document.querySelector('input[name="agrStipulation3"]:checked');
    var originalValue = "${member.agrStipulation3}";

    
    if (!radioElement) {
      spanElement.innerHTML = originalValue === "true" ? "동의" : "비동의";
      return;
    }

  
    var submitButton = document.getElementById("submitButton");
    submitButton.addEventListener("click", function() {
    
      if (radioElement.value !== originalValue) {
        spanElement.innerHTML = (radioElement.value === "true" ? "동의" : "비동의");
      }
    });

    
    radioElements.forEach(element => {
      if (originalValue === "true") {
     
        element.disabled = element.value === "true";
        if (element.value === "false") {
          element.checked = true; 
        }
      } else {
       
        element.disabled = element.value === "false";
        if (element.value === "true") {
          element.checked = true;
        }
      }
    });
  }
  
  
  function deleteMember(fnum) {
		if(!confirm('정말로 회원 탈퇴하시겠어요?')) return false;
	   
		$.ajax({
			url:'/fairy/deleteMem',
			method:'post',
			data:{fnum:fnum},
			cache:false,
			dataType:'json',
			success:function(res){
			     alert(res.deleted ? '탈퇴 처리되었습니다.' : '회원 탈퇴에 실패하였습니다.\n관리자에게 문의 바랍니다.');
	             if (res.deleted) {
   	               location.href = '/fairy/cart/index'; 
		         }
			},
			error:function(xhr,status,err){
				alert('에러:'+status+"/"+err);
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

	            document.getElementById('newPostal_code').value = data.zonecode;
	            if(roadAddr !== ''){
	                document.getElementById("newContact_address").value = roadAddr;
	            } 
	            else if(jibunAddr !== ''){
	                document.getElementById("newDetailed_address").value = jibunAddr;
	            }
	        }
	    }).open();
	}

  
</script>
</head>
<body>
<main>
  <h3>개인 정보 수정</h3>
  <form id="editMemberForm" onsubmit="return form_check();">
  <input type="hidden" name="fnum" id="fnum" value="${member.fnum}">
  
    <div>
	    <label for="userid">* 아이디</label>
	    <span id="userid">${member.userid}</span>
    </div>
    <div class="password-group">
     <div>
      <label for="pass">* 암호</label> 
      <input type="password" id="pass" name="pass" value="${member.pass}" readonly style="width:100px;"> 
     </div> 
     <div>
      <label  for="newPass">* 암호 변경 <input type="password" name="pass" id="newPass" style="width:100px;"></label>
      <label  style="padding-left: 10px;" for="pass-confirm">* 변경 확인</label>
      <input type="password" name="pass" id="pass-confirm" style="width:100px;">
     </div> 
        <span style="color:#787878; font-size:12px; padding:0 0 0 14px; margin-top:-5px; display:block;">(영문 대소문자/숫자/특수문자를 혼용하여 8~16자 입력 / 특수문자는 !@#$%\-_ 만 가능)</span>
      <div id="password-mismatch" style="color: red; display: none;"></div>
      <div id="password-requirements" style="color: red; display: none;">
       영문 대소문자/숫자/특수문자를 혼용하여 8~16자 입력해주세요.
      </div>
    </div> 
     <div>
      <label for="name">* 이름</label>
      <span id="name">${member.name}</span>
    </div>
    <div>
	  <label for="phone1">* 전화</label>
	  <span id="name" style="margin-right:10px;">${member.phone}</span>
	  <label for="newPhone1">* 전화번호 수정</label>
	  <input type="text" name="phone" id="newPhone1" style="width:2.7em;"> -
	  <input type="text" name="phone" id="newPhone2" style="width:2.7em;"> -
	  <input type="text" name="phone" id="newPhone3" style="width:2.7em;">
    </div>
    <div>
      <label for="email">* 이메일</label>
      <span id="email" style="margin-right:10px;">${member.email}</span>
      <label for="newEmail">* 이메일 수정</label>
      <input type="text" name="email" id="newEmail">
      <button type="button" onclick="checkDuplicateEmail();">중복체크</button> 
    </div>
    <div>
	  <label>* 주소</label>
		<span id="full_address" style="margin-right:10px; ${empty member.postal_code ? 'color: red' : ''}">
		       ${empty member.postal_code ? '미입력' : member.contact_address.concat(', ').concat(member.detailed_address)}
		</span>
    </div>
	<div>
	  <label for="newAdress">* 주소 수정</label>
		<input name="postal_code" id="newPostal_code"  type="text" placeholder="우편번호" readonly onclick="findAddr()">
		<span style="color:#787878; font-size:12px; padding:0 0 0 14px;"> (클릭하시면 검색 주소 선택시 자동 입력됩니다. 입력하신 주소는 이벤트 참여시에 활용됩니다.)</span>
		<br>
		<input name="contact_address" id="newContact_address" type="text" placeholder="기본 주소" readonly> 
		<input name="detailed_address" id="newDetailed_address" type="text" placeholder="상세 주소">
    </div> 
    
   <div>
     <label for="birth" id="br-label" >* 생년월일</label>
     <span id="birth" style="${empty member.birth ? 'color: red' : ''}">${empty member.birth ? '미입력' : member.birth}</span>
     <span style="color:#e21111; font-size:12px; padding:0 0 0 14px;">※ 잘못 입력된 경우 관리자에게 문의 바랍니다.</span>
  </div>
  <div>
	 <label>* 성별</label>
	    <c:choose>
	        <c:when test="${member.gender == 'm'}">
	            <span id="gender" style="margin-right:10px;">남자</span>
	        </c:when>
	        <c:when test="${member.gender == 'f'}">
	            <span id="gender" style="margin-right:10px;">여자</span>
	        </c:when>
	    </c:choose>
  </div>
  <div>
	 <label for="agrStipulation1">* 이용약관(필수)</label>
       <span id="agrStipulation1" style="margin-right:10px;">
	      <c:if test="${member.agrStipulation1 == 'true'}">동의</c:if>
	      <c:if test="${member.agrStipulation1 == 'false'}">비동의</c:if>
       </span>
	      <a href="#" class="join_agrCheckBtn">자세히보기</a>
   </div>
   <div>
	 <label for="agrStipulation2">* 개인 정보 수집 및 이용(필수)</label>
	   <span id="agrStipulation2" style="margin-right:10px;">
	      <c:if test="${member.agrStipulation2 == 'true'}">동의</c:if>
	      <c:if test="${member.agrStipulation2 == 'false'}">비동의</c:if>
       </span>
	      <a href="#" class="join_agrCheckBtn">자세히보기</a>
   </div>
   <div>
	 <label for="agrStipulation3">* 마케팅 정보 동의(선택)</label>
	   <span id="agrStipulation3" style="margin-right:10px;">
		  <c:if test="${member.agrStipulation3 == 'true'}">동의</c:if>
		  <c:if test="${member.agrStipulation3 == 'false'}">비동의</c:if>
	   </span>
	 <label>* 선택 변경</label>
		<input type="radio" name="agrStipulation3" value="true" id="agrStipulation3_true" onchange="updateAgrStipulation3()" ${member.agrStipulation3 == 'true' ? 'disabled' : ''}/>동의
		<input type="radio" name="agrStipulation3" value="false" id="agrStipulation3_false" onchange="updateAgrStipulation3()" ${member.agrStipulation3 == 'false' ? 'disabled' : ''}/>비동의
  		<span style="margin-right:10px;"></span>
  		<a href="#" class="join_agrCheckBtn">자세히보기</a>
   </div>
	 <p>
	   <div>
	        <button type="submit">정보 수정하기</button>
	      	<button type="reset">취소</button>
	        <button type="button" onclick="deleteMember(${member.fnum})">회원 탈퇴</button>
	    </div>
 </form>
</main>
</body>
</html>
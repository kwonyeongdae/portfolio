<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>인덱스 페이지(테스트용)</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function modifyMem(){
 var requester='${sessionScope.userid}';
 if (requester == null || requester.trim().length == 0) 
     {
	    alert('로그인이 필요한 기능입니다. 먼저 로그인해주세요.');
	    location.href = '/fairy/login';
	   }else{
		  location.href = '/fairy/editMem/${userid}';
	   } 
}

function mypagego(){
	 var requester='${sessionScope.userid}';
	 if (requester == null || requester.trim().length == 0) 
	     {
		    alert('로그인이 필요한 기능입니다. 먼저 로그인해주세요.');
		    location.href = '/fairy/login';
		   }else{
			  location.href = '/fairy/mypage/${userid}';
		   } 
	}

function logout(){
	if(!confirm('로그아웃할까요?')) return;
	
	$.ajax({
		url:'/fairy/logout',
		method:'get',
		cache:false,
		dataType:'json',
		success:function(res){
			alert(res.logout ? '로그아웃 되었습니다.\n다음에 또 만나요~^^':'로그아웃 실패\n관리자에게 문의 바랍니다.'); 
			if(res.logout) location.href="/fairy/";
		},
		error:function(xhr,status,err){
			alert('에러:'+err);
		}
	});
	
}

</script>
</head>

<body>
  <!-- <h2>메인화면(임시용)</h2> -->
  <c:choose>
   <c:when test="${empty userid}">
   <div><h1>방문해주셔서 감사합니다</h1></div>
   </c:when>
   <c:otherwise>
 <div> <h1>😊${user.name}님 환영합니다</h1></div>
  </c:otherwise>
    </c:choose>
  <p>
	    <c:choose>
	      <c:when test="${empty userid}">
	        <div>	
				[<a href="/fairy/login">로그인</a>]
				[<a href="/fairy/joinForm">회원가입</a>]
				[<a href="/book/list/page/1">책 목록 보기</a>]
				
			</div>
		  </c:when>
		  <c:otherwise>
		 
		    <div>
			    <c:if test="${user.number eq 9}">
				    [<a href="javascript:admin();">관리자페이지</a>]
			    </c:if>
		    	[<a href="/book/list/page/1">시작하기</a>]
		    	[<a href="javascript:mypagego()">마이페이지</a>]
	    	    [<a href="javascript:modifyMem();">개인정보수정</a>]
	    	    [<a href="javascript:logout();">로그아웃</a>]
	        </div>	
	      
	      </c:otherwise>
	   </c:choose>
	   
   
</body>
</html>
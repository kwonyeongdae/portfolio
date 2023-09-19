<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<style>

h3 {
        text-align: center;
        font-size: 36px;
        background-color: #333;
        color: #fff;
        padding: 10px;
        border-radius: 10px;
        margin-top: 20px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        width:80%;
    
    }


/* Slideshow container */
.slideshow-container {
position: relative;
  max-width: 1000px;
  
  margin: auto;
  margin-top: 10px;
}

/* effect */
.fade {
  -webkit-animation-name: fade;
  -webkit-animation-duration: 1.5s;
  animation-name: fade;
  animation-duration: 1.5s;
}

@-webkit-keyframes fade {
  from {opacity: .4} 
  to {opacity: 1}
}

@keyframes fade {
  from {opacity: .4} 
  to {opacity: 1}
}

/* Next & previous buttons */
.prev, .next {
  cursor: pointer;
  position: absolute;
  top: 50%;	
  width: auto;
  padding: 16px;
  margin-top: -22px;
  color: white;
  font-weight: bold;
  font-size: 18px;
  transition: 0.6s ease;
  border-radius: 0 3px 3px 0;
}
.prev
{
 left: 0;
}
/* Position the "next button" to the right */
.next {

  right:0;
}
th {
	margin-top:200px;
}

/* On hover, add a black background color with a little bit see-through */
.prev:hover, .next:hover {
  background-color: rgba(0,0,0,0.8);
}

 .mySlideDiv img {
  width: 100%;
  height: auto;
  display: block;
  text-align: center;
}

 body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f7f7f7;
  }
  header {
    background-color: #333;
    color: #fff;
    padding: 10px;
    text-align: center;
  }
  table {
    width:80%;
    border-collapse: collapse;
    margin-top: 20px;
   
  }
  table th, table td {
    padding: 10px;
    border: 1px solid #ccc;
    text-align: center;
  }
  table th {
    background-color: #f7f7f7;
  }


	    .container {
    border: 1px solid #ccc;
    background-color: #fff;
    padding: 20px;
    border-radius: 5px;
    width: 80%;
  }
  ul.tabs {
    margin: 0; /* 위에 태그바  */
    padding: 0;
    list-style: none;
  }
  ul.tabs li {
    display: inline-block;
    background: #898989;
    color: white;
    padding: 10px 15px;
    cursor: pointer;
  }
  ul.tabs li.current {
    background: #e0e0e0;
    color: #222;
  }
  .tab-content {
    display: none;
    background: #e0e0e0;
    padding: 12px;
  }
  .tab-content.current {
    display: block;
  }
  .tab-content a {
    font-size: 20px; /* 원하는 크기로 조절 (예: 20px) */
  }

</style>


<meta charset="utf-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
$(document).ready(function(){
	  $('ul.tabs li').click(function(){
	    var tab_id = $(this).attr('data-tab');
	    $('ul.tabs li').removeClass('current');
	    $('.tab-content').removeClass('current');
	    $(this).addClass('current');
	    $("#" + tab_id).addClass('current');
	  });
	});



$(document).ready(function () {
	$(".mySlideDiv").not(".active").hide(); //화면 로딩 후 첫번째 div를 제외한 나머지 숨김
	
	//setInterval(nextSlide, 4000); //4초(4000)마다 다음 슬라이드로 넘어감
	
});

//이전 슬라이드
function prevSlide() {
	$(".mySlideDiv").hide(); //모든 div 숨김
	var allSlide = $(".mySlideDiv"); //모든 div 객체를 변수에 저장
	var currentIndex = 0; //현재 나타난 슬라이드의 인덱스 변수
	
	//반복문으로 현재 active클래스를 가진 div를 찾아 index 저장
	$(".mySlideDiv").each(function(index,item){ 
		if($(this).hasClass("active")) {
			currentIndex = index;
		}
        
	});
	
	//새롭게 나타낼 div의 index
	var newIndex = 0;
    
	if(currentIndex <= 0) {
		//현재 슬라이드의 index가 0인 경우 마지막 슬라이드로 보냄(무한반복)
		newIndex = allSlide.length-1;
	} else {
		//현재 슬라이드의 index에서 한 칸 만큼 뒤로 간 index 지정
		newIndex = currentIndex-1;
	}

	//모든 div에서 active 클래스 제거
	$(".mySlideDiv").removeClass("active");
    
	//새롭게 지정한 index번째 슬라이드에 active 클래스 부여 후 show()
	$(".mySlideDiv").eq(newIndex).addClass("active");
	$(".mySlideDiv").eq(newIndex).show();

}

//다음 슬라이드
function nextSlide() {
	$(".mySlideDiv").hide();
	var allSlide = $(".mySlideDiv");
	var currentIndex = 0;
	
	$(".mySlideDiv").each(function(index,item){
		if($(this).hasClass("active")) {
			currentIndex = index;
		}
        
	});
	
	var newIndex = 0;
	
	if(currentIndex >= allSlide.length-1) {
		//현재 슬라이드 index가 마지막 순서면 0번째로 보냄(무한반복)
		newIndex = 0;
	} else {
		//현재 슬라이드의 index에서 한 칸 만큼 앞으로 간 index 지정
		newIndex = currentIndex+1;
	}

	$(".mySlideDiv").removeClass("active");
	$(".mySlideDiv").eq(newIndex).addClass("active");
	$(".mySlideDiv").eq(newIndex).show();
	
}



</script>


</head>
<body>
<h3> fairy book's </h3>
<c:set var="userid" value="${sessionScope.userid}"/>
 

	<div class="container">
		<ul class="tabs">

				<li class="tab-link current" data-tab="tab-1">내정보</li>

				<li class="tab-link" data-tab="tab-2">상품 카테고리</li>

				<li class="tab-link" data-tab="tab-3">문의</li>

			</ul>
		<div id="tab-1" class="tab-content current">
			 <h2></h2>
		<c:choose>
			<c:when test="${empty userid}">
			
			
			[<a href="/fairy/login">로그인</a>]
			[<a href="/fairy/adminLogin">관리자 로그인</a>]
			[<a href="/fairy/joinForm">회원가입</a>]
			
			</c:when>
			<c:otherwise>
			[<a href="/fairy/cart/buylist/${userid}"> 구매목록 </a>]
			[<a href=javascript:logout();>로그아웃</a>]
			[<a href="/fairy/editMem/${userid}"> 회원정보 수정</a>]
			
			</c:otherwise>
		
		
		</c:choose>
		</div>
		<div id="tab-2" class="tab-content">
			<h2> [<a href="/book/listcate/a"> 동물 </a>] [<a href="/book/listcate/b"> 공주 </a>][<a href="/book/listcate/c"> 사물 </a>] </h2>
		</div>
		<div id="tab-3" class="tab-content">
			
		</div>
	
	</div>



<table>
   <tr>
     <th> 책읽기 </th>
   </tr>
   <tr>
      <td>
         <div class="slideshow-container">
            <div class="mySlideDiv fade active">
               <img src="/files/lol.jpg" alt="Image 1" style="max-width: 1000px; max-height: 400px;">
            </div>
            <div class="mySlideDiv fade">
               <img src="/files/loia.jpg" alt="Image 2" style="max-width: 1000px; max-height: 400px;">
            </div>
            <div class="mySlideDiv fade">
               <img src="/files/loiai.jpg" alt="Image 3" style="max-width: 1000px; max-height: 400px;">
            </div>
            <a class="prev" onclick="prevSlide()">&#10094;</a>
            <a class="next" onclick="nextSlide()">&#10095;</a>
         </div>
      </td>
   </tr>
</table>
[<a href="/book/list/page/1"> 메인으로 </a>]
[<a href="javascript:window.history.back();">구매목록으로 돌아가기 </a>]
</body>
</html>
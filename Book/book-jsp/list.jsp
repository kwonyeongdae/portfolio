<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<c:forEach  var="item" items="${users}">
<script type="text/javascript">
window.onload = function() {
    buyuser(); // 함수 실행
};

function buyuser(){
    var loggedInUserId = '${userid}';  // 현재 로그인한 유저의 ID를 가져옵니다.

    var purchasedUserId = '${item.userid}';  // 구매한 유저의 ID를 가져옵니다.

    var state = '${item.state}';

    
    if (loggedInUserId === purchasedUserId && state === '판매자확인중') {
        alert("누군가 물건을 구매했습니다.");
        location.href ="/fairy/mypage/${userid}"
    }
}
</script>
</c:forEach>
<meta charset="utf-8">
<title>책 리스트</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<style type="text/css">

  .contex {
    width: 80%;
    margin: 0 auto; /* To center the container horizontally on the page */
  }

 .divss {
    width: calc(33.33% - 40px); /* 3개의 데이터가 옆으로 나란히 배치되도록 너비를 설정합니다. */
    float: left; /* float를 사용하여 옆으로 정렬합니다. */
    margin: 20px;
    padding: 20px;
    box-sizing: border-box; /* padding 영역까지 포함하여 크기를 계산합니다. */
    border: 1px solid #ccc; /* 추가적으로 각 셀에 테두리를 추가합니다. */
    text-align: center; /* 내용을 가운데 정렬합니다. */
  }
  .clear {
    clear: both; /* float 된 요소들을 모두 해제하여 다음 요소가 정상적으로 배치되도록 합니다. */
  }

.cool{clear: left;} 

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
     h1 {
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
  .small-links span a {
    font-size: 12px; /* 작은 크기로 조절 (예: 12px) ////// 로그인 태그  */
    margin-right: 10px; /* 링크 사이의 간격을 줄입니다. */
    color: #333; /* 링크 색상 변경 (선택 사항) */
    text-decoration: none; /* 밑줄 제거 (선택 사항) */
  }
  main {
    padding: 20px;
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
  
  table {
    width: 30%; /* 변경된 너비로 인해 한 행에 3개의 셀이 쌓입니다. */
    border-collapse: collapse;
    margin-top: 20px;
  }

  table th,
  table td {
    padding: 10px;
    border: 1px solid #ccc;
    text-align: center;
  }

  table th {
    background-color: #f7f7f7;
  }

  /* 셀을 세로로 쌓기 위한 스타일 */
  table td {
    display: block;
  }
  #search {
    margin-top: 20px;
    display: flex;
    align-items: center;
  }
  #search label, #search select, #search input, #search button {
    margin-right: 10px;
  }
  #pagenation {
    margin-top: 20px;
    text-align: center;
  }
  #pagenation a {
    margin: 0 5px;
    padding: 5px 10px;
    border: 1px solid #ccc;
    text-decoration: none;
  }
  #pagenation span {
    margin: 0 5px;
    padding: 5px 10px;
    background-color: #e0e0e0;
    color: #222;
  }
        .floating-wrapper {
       
      position: fixed;
      right: 10px; /* 오른쪽 위치 조정///////  최근본 박스 */
      top: 10px; /* 위쪽 위치 조정 */
      width: 200px; /* 플로팅 요소의 너비 */
      padding: 10px; /* 내부 여백 */
      background-color: #f1f1f1; /* 배경색 */
      border: 1px solid #ddd; /* 테두리 스타일 */
      border-radius: 5px; /* 테두리 둥글게 */
    }

    .floating-wrapper .item {
      margin-bottom: 10px; /* 각 요소 사이의 간격 */
    }

    .floating-wrapper .item img {
   max-width: 50%;
  max-height: 100px; /* 이미지의 최대 높이를 150px로 조정 */
  object-fit: contain; /* 이미지가 비율을 유지하면서 컨테이너에 맞게 조정되도록 함 */
    }
  
  
</style>
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




$(document).ready(function(){
  $('ul.tabs li').click(function(){
    var tab_id = $(this).attr('data-tab');
    $('ul.tabs li').removeClass('current');
    $('.tab-content').removeClass('current');
    $(this).addClass('current');
    $("#" + tab_id).addClass('current');
  });
});


$(document).ready(function() {
     var storedValues = JSON.parse(localStorage.getItem("myValues")) || [];
     var $cookieValueWrapper = $("#cookieValueWrapper");
     $cookieValueWrapper.empty();
      
     console.log(storedValues);
     
     for (var i = storedValues.length - 1; i >= 0; i--) {
       var value = storedValues[i];
       var $itemWrapper = $("<div>").addClass("item");
       var $valueElement = $("<div>").text(value.bname);
       var $imageElement = $("<img>").attr("src", value.image);
       var $linkElement = $("<a>").attr("href","/book/book/"+value.bnum);
       

       $linkElement.append($valueElement);
       $linkElement.append($imageElement);
       $itemWrapper.append($linkElement);
       
       $cookieValueWrapper.append($itemWrapper);
       
      // $cookieValueWrapper.append($valueElement);
   //    $cookieValueWrapper.append($imageElement);
       
     //  $cookieValueWrapper.append($itemWrapper);
     }
     
     
     
     
     
   });

function deleteDataAfterInterval() {
     var deleteInterval = 300000; // 300초 (5분) 
     
     setTimeout(function() {
       localStorage.removeItem("myValues");
       location.reload(); // 페이지 새로고침
     }, deleteInterval);
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
         if(res.logout) location.href="/book/list/page/1";
      },
      error:function(xhr,status,err){
         alert('에러:'+err);
      }
   });
   
}
</script>
<script type="text/javascript">
function add_cart(bnum,bname)
{   
	  var usernum = '${rest.number}';
	  var setnum = 5;
	  if(usernum==setnum){
		  alert("휴먼계정을 먼저 해체하세요");
		  location.href = "/fairy/";
		  return;
	  }
	
   var obj = {};
   obj.bnum = bnum;
   obj.bname = bname;
   obj.quantity = 1;
   obj.userid = '${sessionScope.userid}';
   
   if(!confirm("장바구니에 추가합니까?")){
      return false;
   }
   $.ajax(
         {
            url:'/fairy/cart/add/'+bnum,
            method:'post',
            data: obj,
            cache:false,
            dataType:'json',
            success:function(res) {
               if (res.added) {
                  alert('장바구니에 담았습니다');
               } else {
                  alert(res.quanti ? '장바구니에 담았습니다' : '장바구니 추가실패');
               }
            },
            error:function(xhr,status,err){
               alert(status + "/" + err);
            }
         }      
      );
   
}

function admin(){
	var realAuthor = '${user.number}';

	var requester = 9;
	if (realAuthor != requester) {
	  alert('관리자만 볼 수 있어요~');
	  return;
	}else{
		location.href = "/admin/";
	}
	}

</script>
</head>
<body>
<main>
   <h3> fairy book's </h3>

   <div class="container">
      <ul class="tabs">

            <li class="tab-link current" data-tab="tab-1">로그인 </li>

            <li class="tab-link" data-tab="tab-2">상품 카테고리</li>

            <li class="tab-link" data-tab="tab-3">문의</li>

         </ul>
      <div id="tab-1" class="tab-content current">
         
      <h2>
      
          <c:choose>
      <c:when test="${sessionScope.isAdmin eq 9}">
         관리자님 어서오세요^^
      </c:when>
      
      <c:when test="${sessionScope.userid eq null}">
      어서오세요 fairy's book 입니다
      
      </c:when>
      
      <c:otherwise>
         ${user.name}님 어서오세요 ^^
      </c:otherwise>
   </c:choose>
</h2>
<c:choose>
   <c:when test="${empty sessionScope.userid}">
      [<a href="/fairy/login">로그인</a>]
      [<a href="/fairy/joinForm">회원가입</a>]
   </c:when>
   
   <%--07.25 추가 된 부분    book  >>> list.jsp --%>
   <c:when test="${user.number eq 9}">
   [<a href="javascript:admin();">관리자페이지</a>]
   [<a href="/fairy/cart/buylist/${userid}"> 구매목록 </a>]
      [<a href="/carrot/list/page/1">당근마켓</a>]
      [<a href="/fairy/cart/list">장바구니</a>]
      [<a href="/fairy/cart/buy">결제창</a>]
      [<a href="javascript:mypagego()">마이페이지</a>]
      [<a href="javascript:logout();">로그아웃</a>]
   </c:when>
   
   
   
   
   <%-- 장바구니 url 추가  --%>
   <c:otherwise>
      [<a href="/fairy/cart/buylist/${userid}"> 구매목록 </a>]
      [<a href="/carrot/list/page/1">당근마켓</a>]
      [<a href="/fairy/cart/list">장바구니</a>]
      [<a href="/fairy/cart/buy">결제창</a>]
      [<a href="javascript:mypagego()">마이페이지</a>]
      [<a href=javascript:logout();>로그아웃</a>]
   </c:otherwise>
</c:choose>
      </div>
      <div id="tab-2" class="tab-content">
         [<a href="/book/listcate/a"> 동물 </a>] [<a href="/book/listcate/b"> 공주 </a>][<a href="/book/listcate/c"> 사물 </a>]
      </div>
      <div id="tab-3" class="tab-content">
         <a href="/board/board/list/page/1" style="text-decoration:none;">[문의하기]</a>
      </div>
   
   </div>
   
   <div class="floating-wrapper" >
    <div class="title">[최근본 상품]</div>
       <div id="cookieValueWrapper">
    
       </div>
    </div>

    <h1>이달의 베스트셀러</h1> 
   
      <c:forEach var="best" items="${best}">
      <div class="divss">
      <div>
         <a href="/book/book/${best.bnum}"><img src="/img/${best.cvrimg}" style="max-width: 100px; max-height: 100px;"></a>
      </div>
      <div>
         <a href="/book/book/${best.bnum}">${best.bname}</a>
      </div>
      <div>
         <fmt:formatNumber value="${best.price}"/>원
      </div>
      </div>
      </c:forEach>
	<div class="clear"></div>









   
<h1>도서 목록</h1>
  <c:set var="bnum" value="${0}" />
  
  <c:forEach var="book" items="${pageInfo.list}" varStatus="loop">
    <c:if test="${book.bnum != bnum}">
     <div class="divss">
      <div>
      <a href="/book/book/${book.bnum}"><img src="/img/${book.cvrimg}" style="max-width: 100px; max-height: 100px;"></a>
     </div>
      <div>
        <a href="/book/book/${book.bnum}">${book.bname}</a>
      </div>
      <div>
        <fmt:formatNumber value="${book.price}" />원
      </div>
      <div>
        <button type="button" onclick="add_cart(${book.bnum},'${book.bname}')">장바구니추가</button>
       </div>
    </div>
    <c:if test="${loop.index % 3 == 2}">
      <div class="clear"></div>
    </c:if> 
    </c:if>
    
    <c:set var="bnum" value="${book.bnum}" />
    
  </c:forEach>




<div class= "cool"></div><hr>
   <div id= "search">
      <form id ="searchForm" action="/book/search" method="post">
         <label>검색</label>
         <select name="category">
            <option value="bname"> 제 목 </option>
            <option value="publisher"> 출판사 </option>
            <option value="author"> 저 자 </option>
         
         
         </select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         <label>검색어</label>
         <input type="text" name="keyword">
         <button type="submit">검색</button>
      
      </form>

   </div>
   
   <nav id= "pagenation">
      <c:forEach var = "pn" items="${pageInfo.navigatepageNums}">
         <c:choose>
            <c:when test="${pn==pageInfo.pageNum}">
               <span id="pageNum">${pn}</span>
            </c:when>
            <c:otherwise>
            <c:url value="/book/list/page/${pn}" var="pgURL">
            <c:if test="${category!=null}">
               <c:param name="category" value="${category}"/>
               <c:param name="keyword" value="${keyword}"/>
            </c:if>
            
            
            
            </c:url>
            <a href="${pgURL}">${pn}</a>
            <a href="/book/list/page/${pn+1}" style="float:right"> <button> > </button> </a>
            <a href="/book/list/page/${pn-1}" style="float:left"> <button> < </button></a>
            <c:if test="${pn<PageInfo.totalpages }">
            
            </c:if>         
            
            </c:otherwise>

         </c:choose>

      </c:forEach>

   </nav>


</main>

</body>
</html>
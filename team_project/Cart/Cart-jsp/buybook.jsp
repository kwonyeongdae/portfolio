<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Book Box</title>
<style type="text/css">
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

</script>

</head>
<body>
<h3> <a href="/book/list/page/1">fairy book's </a></h3>

<c:set var="userid" value="${sessionScope.userid}"/>


	<div class="container">
		<ul class="tabs">

				<li class="tab-link current" data-tab="tab-1">내정보</li>

				<li class="tab-link" data-tab="tab-2">상품 카테고리</li>

				<li class="tab-link" data-tab="tab-3">문의</li>

			</ul>
		<div id="tab-1" class="tab-content current">
			 
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
			 [<a href="/book/listcate/a"> 동물 </a>] [<a href="/book/listcate/b"> 공주 </a>][<a href="/book/listcate/c"> 사물 </a>] 
		</div>
		<div id="tab-3" class="tab-content">
			
		</div>
	
	</div>
<h1>${userid}님의 구매품목</h1><div>보유한 마일리지: ${mileage.mileage}</div>
<h4> 책을 읽으시려면 이미지를 클릭하세요</h4>
<table>
<tr>
	<th>이름</th> <th></th>
</tr>
<c:set var = "bnum" value="${0}"></c:set>
<c:forEach var="book" items="${buy}">
		<tr>
			<td>${book.bname}</td>
			<td> 
			<a href="/fairy/cart/slideshow"> <img src="/img/${book.cvrimg}" style="max-width: 100px; max-height: 100px;"> </a>
			 
			 </td>
		</tr>
</c:forEach>
</table>
</body>
</html>
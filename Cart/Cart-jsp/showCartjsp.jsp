<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">

main{width: 80 margin: 0.5em auto; border: 1px black;}
tr{ border: 1px black;}
h1{width: fit-content; margin: 0.5em auto; border-bottom: 3px double black ;}
#aa{width: fit-content; margin: 1em auto; }
th{background-color: #E7E7E7; width: 8em; text-align: center; padding: 0.3em 0.3em;}
td{text-align: center;padding: 0.3em 0.3em;}
table{border-spacing:0; border-collapse:collapse; padding: 200px; border: 1px solid black; margin-left: 300px; }

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
.button{background-color: transparent; color: black; border: 1px solid black; width: 70px; height: 30px;font-size: 18px;}
#button{background-color: transparent; color: black; border: 1px solid black; width: 90px; height: 30px;font-size: 18px; margin-left: 350px;}
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
  #button1{
  			margin-left: 300px;
 		  }
    
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">

function selectAll(source) {
	  var checkboxes = document.getElementsByName("selectedBooks");
	  for (var i = 0;
	  i < checkboxes.length; i++) {
	    checkboxes[i].checked = source.checked;
	  }
	}
	
function deleted(bnum) {
	
	  var checkboxes = document.getElementsByName("selectedBooks");
	  var selectedItems = [];
	  for (var i = 0; i < checkboxes.length; i++) {
	    if (checkboxes[i].checked) {
	      selectedItems.push(checkboxes[i].value);
	    }
	  }
	  if (selectedItems.length === 0) {
	    alert("선택된 항목이 없습니다.");
	    return;
	  }
	  if (!confirm("선택한 항목을 삭제하시겠습니까?")) {
	    return;
	  }
	  // 선택된 항목들을 서버로 전달하여 삭제 작업을 수행합니다.
	  
	  var obj = {};
	  obj.bname = selectedItems; 
	 
	  $.ajax({
	    url: '/fairy/cart/delete',
	    method: 'post',
	    data: obj,
	    cache: false,
	    dataType: 'json',
	    
	    success: function (res) {
	      alert(res.deleted ? '삭제완료' : '삭제실패');
	      location.reload();
	    },
	    error: function (xhr, status, err) {
	      alert(status + "/" + err);
	    }
	  });
	}
	
function buy_cart(){
	location.href = '/fairy/cart/buy';
}


function buy_cart() {
	  var checkboxes = document.querySelectorAll('input[type="checkbox"][name="selectedBooks"]');
	  var selectedItems = [];
	  for (var i = 0; i < checkboxes.length; i++) {
	    if (checkboxes[i].checked) {
	      selectedItems.push(checkboxes[i].value);
	    }
	  }
	  if (selectedItems.length == 0) {
	    alert("선택된 항목이 없습니다.");
	    return;
	  }
	  if (!confirm("선택한 항목을 주문하시겠습니까?")) {
	    return;
	  }

	  var formData = new FormData();
	  for (var i = 0; i < selectedItems.length; i++) {
	    formData.append("bname[]", selectedItems[i]);
	  }
	
	  $.ajax({
	    url: '/fairy/cart/buy',
	    method: 'post',
	    data: formData,
	    cache: false,
	    processData: false,
	    contentType: false,
	    success: function (res) {
	      location.href = "/fairy/cart/buy";
	    },
	    error: function (xhr, status, err) {
	      alert(status + "/" + err);
	    }
	  });
	}


function remove_All(){
	if (!confirm("전체삭제 하시겠습니까?")) {
	    return;
	  }
	$.ajax({
	    url: '/fairy/cart/remove',
	    method: 'post',
	    cache: false,
	    dataType:'json',
	    success: function (res) {
	    	alert(res.remove ? '삭제완료' : '삭제실패');
		      location.reload();
	    },
	    error: function (xhr, status, err) {
	      alert(status + "/" + err);
	    }
	  });
	}
	
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
</script>
<script type="text/javascript">
function update_Quantity() {

		  var checkboxes = document.querySelectorAll('input[type="checkbox"][name="selectedBooks"]');
		  var selectedItems = [];
		  var quantityArray = []; // New array to store selected items' quantities

		  for (var i = 0; i < checkboxes.length; i++) {
		    if (checkboxes[i].checked) {
		      selectedItems.push(checkboxes[i].value);

		      // Find the corresponding quantity input for the selected item
		      var quantityInput = checkboxes[i].closest('tr').querySelector('.quantity');
		      quantityArray.push(quantityInput.value); // Store the selected item's quantity
		    }
		  }

		  if (selectedItems.length === 0) {
		    alert("선택된 항목이 없습니다.");
		    return;
		  }
		  
		  if (!confirm("수량변경 하시겠습니까?")) {
		    return;
		  }

		  var data = {
		    'bname[]': selectedItems,
		    'quantity[]': quantityArray
		  };

	  $.ajax({
	    url: "/fairy/cart/qupdate",
	    method: "post",
	    dataType: 'json',
	    data: data,
	    cache: false,
	    success: function(res) {
	      alert(res.update ? "수량이 변경되었습니다." : "수량변경 실패");
	      location.reload();
	    },
	    error: function(xhr, status, err) {
	      alert(status + "/" + err);
	    }
	  });
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
</script>

<meta charset="utf-8">
<title>장바구니</title>
</head>
<body>
<main>
<h3> <a href="/book/list/page/1" style ="color: white;">fairy book's</a> </h3>
<div class="container">
      <div id="tab-1" class="tab-content current">
         
         <h1>${user.name}님의 장바구니</h1>
<c:choose>
   <c:when test="${empty sessionScope.userid}">
      [<a href="/fairy/login">로그인</a>]
      [<a href="/fairy/joinForm">회원가입</a>]
   </c:when>
   
   <%--07.25 추가 된 부분    book  >>> list.jsp --%>
   <c:when test="${user.number eq 9}" >
	   <div style="margin-left: 300px; ">
		   [<a href="javascript:admin();" >관리자페이지</a>]
		   [<a href="/fairy/cart/buylist/${userid}"> 구매목록 </a>]
		   [<a href="/carrot/list/page/1">당근마켓</a>]
		   [<a href="/fairy/cart/buy">결제창</a>]
		   [<a href="javascript:mypagego()">마이페이지</a>]
	       [<a href="javascript:logout();">로그아웃</a>]
	   </div>
   </c:when>
   
   
   
   
   <%-- 장바구니 url 추가  --%>
   <c:otherwise>
	   <div style="margin-left: 300px; ">
	      [<a href="/fairy/cart/buylist/${userid}"> 구매목록 </a>]
	      [<a href="/carrot/list/page/1">당근마켓</a>]
		  [<a href="/fairy/cart/buy">결제창</a>]
	      [<a href="javascript:mypagego()">마이페이지</a>]
	      [<a href=javascript:logout();>로그아웃</a>]
	   </div>
   </c:otherwise>
</c:choose>
      </div>
 
   
   </div><br>
   <div></div><hr>
<table>
	<tr>
	<th style="width: 60px; height: 30px;"><input type="checkbox" name="selectAll" onclick="selectAll(this)">선택</th>
	<th>이미지</th>
	<th>상품명</th>
	<th>가격</th>
	<th style="width: 35px; height: 30px;">수량</th>
	<th>오늘구매시</th>
	
	</tr>
	<form id="showform" >
<c:forEach var="list" items="${book}">	
<input type="hidden" class="bname" name="bname" value="${list.bname}">
	<tr>
	<td><input type="checkbox"  name="selectedBooks" value="${list.bname}"></td>
	<td><img src="/img/${list.cvrimg}" style="max-width: 100px; max-height: 100px;"></td>
	<td>${list.bname}</td>
	
	<td><fmt:formatNumber value="${list.totalPrice}" pattern="##,##0"/></td>
	<td><input type="number" class="quantity" value="${list.totalQuantity}" min="1" max="100" style="width: 30px;"></td>
	<td>배송시스템<br> 미등록</td>
</c:forEach>
</tr>
<div class="floating-wrapper" >
	 <div class="title">[최근본 상품]</div>
		 <div id="cookieValueWrapper">
	 
		 </div>
	 </div>
<div id = "button1">
	<button type="button" class ="button" onclick="buy_cart();" style="width: 50px; height: 30px">주문</button>
	<button type = "button" class ="button" onclick="deleted(${list.bnum});" style="width: 50px; height: 30px">삭제</button>
	<button type = "button" class ="button" onclick="update_Quantity();" style="width: 100px; height: 30px">수량변경</button>
	<button type = "button"  id ="button" onclick="remove_All();">전체삭제</button><br>
</div>

</form>
	</table> 

</main>
</body>
</html>
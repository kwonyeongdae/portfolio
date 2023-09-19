<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        var userNumber = ${user.number};
        if (userNumber !== 9) {
            alert("잘못된 페이지 요청입니다.");
            window.history.back();
        }
    });
</script>
<style type="text/css">
main{width: fit-content; margin: 0.5em auto; border: 1px black;}
tr{ border: 1px black;}
h1{width: fit-content; margin: 0.5em auto; border-bottom: 3px double black ;}
#aa{width: fit-content; margin: 1em auto; }
th{background-color: #E7E7E7; width: 8em; text-align: center; padding: 0.3em 0.3em;}
td{text-align: center;padding: 0.3em 0.3em;}
table{border-spacing:0; border-collapse:collapse; padding: 200px; border: 1px solid black; margin: 0 auto; }
#div{text-align: center;}
#divv{text-align: center;}
</style>
<meta charset="utf-8">
<title>TOTAL LIST</title>
</head>

<body>
<c:choose>
   <c:when test="${not empty param.category}">
      <!-- 카테고리로 검색한 경우 총 매출 부분 숨김 -->
   </c:when>
   <c:otherwise>
      <h1>총 판매내역</h1><hr>
      <table>
         <tr>
            <th>구매날짜</th>
            <th>구매품목</th>
            <th>구매수량</th>
            <th>구매금액</th>
            <th>구매회원</th>
         </tr>
         <c:forEach var="list" items="${alist}">
            <tr>
               <td>${list.buyday}</td>
               <td>${list.bname}</td>
               <td>${list.quantity}</td>
               <td>${list.price}</td>
               <td>${list.userid}</td>
            </tr>
         </c:forEach>
      </table>
   </c:otherwise>
</c:choose>

<!-- ================================여기서부터 일 매출 출력======================================================================= -->
<!-- ================================여기서부터 일 매출 출력======================================================================= -->
<c:choose>
   <c:when test="${param.category eq 'day'}">
      <h1>${daylist[0].day}일 매출액</h1>
      <form id="day" action="/admin/list/data" method="get">
         <table>
            <tr>
             	<th>구매자</th>
               <th>판매품목</th>
               <th>판매수량</th>
               <th>판매금액</th>
            </tr>
            <c:forEach var="dlist" items="${daylist}">
               <tr>
               	  <td>${dlist.userid}</td>
                  <td>${dlist.bname}</td>
                  <td>${dlist.quantity}권</td>
                  <td>${dlist.price}원</td>
               </tr>
            </c:forEach>
         </table>
      </form>
   </c:when>
</c:choose>
<!-- ================================여기까지 일 매출 출력======================================================================= -->
<!-- ================================여기까지 일 매출 출력======================================================================= -->

<!-- ================================여기서부터 월 매출 출력======================================================================= -->
<!-- ================================여기서부터 월 매출 출력======================================================================= -->
<c:choose>
   <c:when test="${param.category eq 'month'}">
      <h1>${daylist[0].month}월 매출액</h1>
      <form id="day" action="/admin/list/data" method="get">
         <table>
            <tr>
            	<th>판매일</th>
            	<th>구매자</th>
               <th>판매품목</th>
               <th>판매수량</th>
               <th>판매금액</th>
            </tr>
            <c:set var="totalPrice" value="0" />
		<c:forEach var="dlist" items="${daylist}">
		   <tr>
		      <td>${dlist.day}일</td>
		      <td>${dlist.userid}</td>
		      <td>${dlist.bname}</td>
		      <td>${dlist.quantity}개</td>
		      <td class="price">${dlist.price}원</td>
		   </tr>
		   <c:set var="totalPrice" value="${totalPrice + dlist.price}" />
		</c:forEach>
		</table>
		<div id="divv" style="color: red;">*총매출액 = ${totalPrice}원*</div>
         
      </form>
   </c:when>
</c:choose>
<!-- ================================여기까지 월 매출 출력======================================================================= -->
<!-- ================================여기까지 월 매출 출력======================================================================= -->

<!-- ================================여기서부터 연도 매출 출력======================================================================= -->
<!-- ================================여기서부터 연도 매출 출력======================================================================= -->
<c:choose>
   <c:when test="${param.category eq 'year'}">
      <h1>${daylist[0].year}년도 매출액</h1>
      <form id="day" action="/admin/list/data" method="get">
         <table>
            <tr>
               <th>판매품목</th>
               <th>판매수량</th>
               <th>판매총액</th>
            </tr>
            
               <tr>
                  
                  <td>${daylist[0].month}월</td>
                  <td>총${daylist[0].totalquantity}개</td>
                  <td>${daylist[0].total}원</td>
                  
               </tr>
               
           
            
         </table>
      </form>
   </c:when>
</c:choose>
<!-- ================================여기까지 연도 매출 출력======================================================================= -->
<!-- ================================여기까지 연도 매출 출력======================================================================= -->

<!-- ================================여기서부터 이용자 매출 출력======================================================================= -->
<!-- ================================여기서부터 이용자 매출 출력======================================================================= -->
<c:choose>
   <c:when test="${param.category eq 'userid'}">
      <h1>${daylist[0].userid}님의 총구매액</h1>
      <form id="day" action="/admin/list/data" method="get">
         <table>
            <tr>
               <th>구매날짜</th>
               <th>구매품목</th>
               <th>구매수량</th>
               <th>구매총액</th>
            </tr>
            <c:set var="totalPrice" value="0" />
		<c:forEach var="dlist" items="${daylist}">
		   <tr>
		      <td>${dlist.buyday}</td>
		      <td>${dlist.bname}</td>
		      <td>${dlist.quantity}개</td>
		      <td class="price">${dlist.price}원</td>
		   </tr>
		   <c:set var="totalPrice" value="${totalPrice + dlist.price}" />
		</c:forEach>
		</table>
		<div id="divv" style="color: red;">*${daylist[0].userid}님의 총구매액 = ${totalPrice}원*</div>
      </form>
   </c:when>
</c:choose>
<!-- ================================여기까지 이용자 매출 출력======================================================================= -->
<!-- ================================여기까지 이용자 매출 출력======================================================================= -->
<div></div><br>
<form id="div" action="/admin/list/data" method="get">
   <select id="category" name="category">
    <option value="day">일</option>
    <option value="month">월</option>
    <option value="year">연도</option>
    <option value="userid">아이디</option>
</select>
<input type="text" name="key">
<input type="submit" value="검색">
<div class="ca">**검색예시**</div>

<script>
    var categorySelect = document.getElementById("category");
    var caDiv = document.querySelector(".ca");

    categorySelect.addEventListener("change", function() {
        var selectedOption = categorySelect.value;
        var exampleText = "";

        if (selectedOption === "day") {
            exampleText = "2023-01-01";
        } else if (selectedOption === "month") {
            exampleText = "2023-01";
        } else if (selectedOption === "year") {
            exampleText = "2023";
        }else if (selectedOption === "userid") {
            exampleText = "아이디를 입력하세요";
        }

        caDiv.textContent = "ex) " + exampleText;
        caDiv.style.color = "red";
    });
</script>

</form>
</body>
</html>
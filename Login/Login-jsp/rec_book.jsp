<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>책 추천 AI</title>
<style type="text/css">
 main {
  width:fit-content;
  
  min-width: 700px; /* 최소 너비 설정 */
  min-height: 350px; /* 최소 높이 설정 */
  padding: 110px; /* 패딩 추가 */
  
  margin:8em auto;
  
  background-color: white; /* 흰색 배경 */
  border-radius:50%; /* 동그랗게 만들기 위해 */
 
 }

 body {
  background-image: url('/files/street.jpg');
  background-repeat: no-repeat;
  background-size: cover; /*이미지가 화면 전체를 채우도록 설정*/
  background-position: center; /* 배경 이미지 위치를 중앙으로 설정 */
  
 }

 .right-align {text-align:right;}
 .highlight {color:mediumPurple;}
</style>
</head>
<body>
<main>
	<h2><span class="highlight">${userid}</span>님의 취향에 꼭 맞는 동화책 Top 5</h2>
	<hr>
	<%--  테스트용 <c:out value="${recommendations}" /> --%>
	<p>
		<c:forEach var="bookName" items="${recommendations}" varStatus="status"> 
		     ${status.index + 1}. ${bookName}<br>   <%-- br 태그를 써서 플라스크의 쉼표가 사라졌음. 플라스크를 공백으로 join해도 되나 쉼표 쓸 수도 있어서 플라스크 쉼표는 그냥 남김--%>
		<%-- 링크로 만들 떄 쓸 용도 bnum 끌고 오는 걸 안 써서 일단 패스
		    <a href="/book/book/{bnum}${bookName}">${bookName}</a><br/>--%>
		</c:forEach> 
	 <hr>
	  <div class="right-align">
        <a href="/book/list/page/1">메인으로 돌아가기</a><br/>
      </div>
</main>
</body>
</html>

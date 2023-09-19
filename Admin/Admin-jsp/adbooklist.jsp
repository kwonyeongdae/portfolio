<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
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
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">

function deleted(bnum)
{	
	var cvrimg;
	  $('#cvrimg').each(function() {
	    cvrimg = $(this).val();
	  });
	  
	  var contentimg;
	  $('#contentimg').each(function() {
		  contentimg = $(this).val();
	  });

	var obj = {};
	obj.bnum = bnum;
	obj.cvrimg = cvrimg;
	obj.contentimg = contentimg;
	
	if(!confirm("책을 삭제합니까?")){
		return false;
	}

	$.ajax({
			url:'/admin/delete/'+bnum,
			method:'post',
			data: obj,
			cache:false,
			dataType:'json',
			success:function(res) {
				alert(res.deleted ? '삭제완료':'삭제실패');
				location.reload();
			},
			error:function(xhr,status,err){
				alert(status + "/" + err);
			}
		});
	
}

 function updateform(bnum){
	 
	 location.href = "/book/updateform/" + bnum;
 }
 
 function addform(){
	 location.href= "/book/add";
	 
 }
 
</script>
<meta charset="utf-8">
<title>도서 정보 목록</title>

<style type="text/css">
	h1{text-align: center;}
 body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        th, td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: center;
        }

        th {
            background-color: #f2f2f2;
            font-weight: bold;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        img {
            max-width: 100px;
            max-height: 100px;
        }

        button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 8px 12px;
            cursor: pointer;
            font-size: 14px;
            margin-right: 5px;
            border-radius: 3px;
        }

        button:hover {
            background-color: #45a049;
        }
        #pagenation,#search{text-align: center;}  
</style>

</head>
<body>
<main>
	<h1>도서 목록</h1>
	<table>
	<tr>
            <th>도서번호</th>
            <th>도서명</th>
            <th>저자</th>
            <th>출판사</th>
            <th>가격</th>
            <th>이미지</th>
            <th></th>
            </tr>
<c:forEach var ="atb" items="${att}">
<input type="hidden" id="contentimg" name ="contentimg" value="${atb.contentimg}">
	</c:forEach>
	<c:set var = "bnum" value="${0}"></c:set>
	
	<c:forEach var ="book" items="${pageInfo.list}">
	
		<c:if test="${book.bnum != bnum}">
			<input type="hidden" id="cvrimg" name ="cvrimg" value="${book.cvrimg}">
			
               <tr>
              
               	  <td>${book.bnum}</td>
                  <td>${book.bname}</td>
                  <td>${book.author}</td>
                  <td>${book.publisher}</td>
                  <td><fmt:formatNumber value="${book.price}"/>원</td>
                  <td><img src="/img/${book.cvrimg}" style="max-width: 100px; max-height: 100px;"></td>
                  <td>
                  <button type = "button" onclick='updateform(${book.bnum});'>수정</button>
                  <button type = "button" onclick="deleted(${book.bnum});">삭제</button>
                  </td>
               </tr>
		
		</c:if>
	
		<c:set var = "bnum" value ="${book.bnum}"></c:set>
	</c:forEach>
	
	</table>
	<div id= "search">
		<form id ="searchForm" action="/admin/search" method="post">
			<label>검색</label>
			<select name="category">
				<option value="bname"> 제 목 </option>
				<option value="author"> 저 자 </option>
			
			
			</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<label>검색어</label>
			<input type="text" name="keyword">
			<button type="submit">검색</button>
		<button type = "button" onclick="addform()">도서 추가</button>
		</form>

	</div>
	
	<nav id= "pagenation">
		<c:forEach var = "pn" items="${pageInfo.navigatepageNums}">
			<c:choose>
				<c:when test="${pn==pageInfo.pageNum}">
					<span id="pageNum">${pn}</span>
				</c:when>
				<c:otherwise>
				<c:url value="/admin/adbooklist/${pn}" var="pgURL">
				<c:if test="${category!=null}">
					<c:param name="category" value="${category}"/>
					<c:param name="keyword" value="${keyword}"/>
				</c:if>
				</c:url>
				<a href="${pgURL}">${pn}</a>
					</c:otherwise>
			</c:choose>
		</c:forEach>
				
				<a href="/admin/adbooklist/${pn+1}" style="float:right"> <button> > </button> </a>
				<a href="/admin/adbooklist/${pn-1}" style="float:left"> <button> < </button></a>
				<c:if test="${pn<PageInfo.totalpages }">
				</c:if>			
	</nav>

</main>
</body>
</html>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<style type="text/css">
h1{text-align: center; margin-right: 80px;}
h3{text-align: center; margin-right: 80px;}
table{
  width: 600px;
  margin: 0 auto;
  padding: 20px;
  
}
th{text-align: center; border: 1px solid black;
      padding: 1px; background-color: lightgray;}
td{text-align: center; border: 1px solid black;
      padding: 1px;}
div,#page,#page1,#div{text-align: center;}  
</style>
<style type="text/css">
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        h1 {
            text-align: center;
            margin: 20px;
            color: #333;
            font-size: 36px;
        }

        table {
            width: 80%;
            margin: 0 auto;
            border-collapse: collapse;
            text-align: center;
            background-color: #f2f2f2;
        }

        th, td {
            border: 1px solid #ccc;
            padding: 10px;
            font-size: 16px;
        }

        th {
            background-color: #4CAF50;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        #page, #page1 {
            text-align: center;
            margin-top: 20px;
            font-size: 18px;
        }

        #page a {
            margin: 0 5px;
            color: #4CAF50;
            text-decoration: none;
        }

        #div {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
            text-align: center;
        }

        #vib {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
        }

        /* Password Modal Styles */
        #passwordModal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
        }

        .modal-content {
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: 20px;
  background-color: #fff;
  border-radius: 5px;
  box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.2);
  width: 300px;
  margin: 0 auto;
}

.modal-content h2 {
  text-align: center;
  margin-bottom: 20px;
  color: black;
}

.modal-content input[type="password"] {
  width: 100%;
  padding: 10px;
  margin-bottom: 10px;
  border: 1px solid #ccc;
  border-radius: 3px;
}

.modal-content button {
  width: 100%;
  padding: 10px;
  background-color: buttonface;
  border: none;
  color: black;
  border-radius: 3px;
  cursor: pointer;
  transition: background-color 0.3s;
}

.modal-content button:hover {
  background-color: #45a049;
}

    </style>
<meta charset="utf-8">
<title>SEARCH</title>
</head>
<body>
<table style="border-collapse: collapse;">
  <h1>LIST</h1> <hr>
  <h3>category=${param.category},key=${param.key}로 검색 결과</h3>
        <tr>
            <th>NO</th>
            <th>NAME</th>
            <th>TITLE</th>
            <th>CONTENT</th>
            <th>DATA</th>
            <th>HIT</th>
            <th>ATTACH</th>
  
        </tr>
       <c:forEach var="search" items="${pageinfo.list}">
            <tr>
                <td>${search.bnum}</td>
                <td>${search.bname}</td>
                <td><a href="/board/board/detail/${search.bnum}">${search.title}</td>
                <td>${search.content}</td>
                <td><fmt:formatDate value="${search.date}" pattern="yyyy-MM-dd"/></td>
                <td>${search.hitnum}</td>
                <td><c:if test="${search.fnames!=null}">있음</c:if></td>
            </tr>
        </c:forEach>
    </table>
     <form id="div" action="/board/board/search/page/1" method="get">
    <select name="category">
        <option value="번호">번호</option>
        <option value="이름">이름</option>
         <option value="내용">내용</option>
    </select>
    <input type="text" name="key">
    <input type="submit" value="검색">
</form>
    <div id="page">
    <c:if test="${pageinfo.hasPreviousPage}">
   	 [<a href="/board/board/search/page/${pageinfo.prePage}?category=${param.category}&amp;key=${param.key}">Previous</a>]
    </c:if>
    
  	<c:forEach var="pageNum" items="${pageinfo.navigatepageNums}">
  	    <c:choose>
  	    
  			<c:when test="${pageNum eq pageinfo.pageNum}">
            <strong style="color: red">${pageNum}</strong>
        	</c:when>
        	
	        <c:otherwise>
	        [<a href="/board/board/search/page/${pageNum}?category=${param.category}&amp;key=${param.key}">${pageNum}</a>]
	        </c:otherwise>
	        
         </c:choose>
  	</c:forEach>
  	
  	<c:if test="${pageinfo.hasNextPage}">
   	 [<a href="/board/board/search/page/${pageinfo.nextPage}?category=${param.category}&amp;key=${param.key}">Next</a>]
    </c:if>
	</div>
	
  	<div id = "page1">
  	<c:if test="${pageinfo.pages gt 1}">
    [<a href="/board/board/search/page/1?category=${param.category}&amp;key=${param.key}">FirstPage</a>]
    [<a href="/board/board/search/page/${pageinfo.pages}?category=${param.category}&amp;key=${param.key}">LastPage</a>]
  </c:if>
	</div>
   <div>
        <a href="/board/board/list/page/1">BOARDLIST</a>
        </div>
     
</body>
</html>
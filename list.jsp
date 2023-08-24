<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
function showPasswordModal(bnum,pass) {
	  const modal = document.getElementById('passwordModal');
	  modal.style.display = 'block';

	  // 확인 버튼을 클릭했을 때 처리하는 함수
	  function checkPassword() {
	    const passwordInput = document.getElementById('passwordInput').value;
	    if (passwordInput.trim() === pass.toString()) {
	      // 비밀번호가 일치하면 해당 페이지로 이동합니다.
	      const detailURL = '/board/board/detail/' + bnum;
	      window.location.href = detailURL;
	    } else {
	      alert('비밀번호가 일치하지 않습니다.');
	    }
	    modal.style.display = 'none';
	  }
	  window.onclick = function(event) {
		    if (event.target === modal) {
		      modal.style.display = 'none';
		    }
		  };

		  // 사용자가 'Esc' 키를 누르면 대화상자를 닫습니다.
		  document.onkeydown = function(event) {
		    if (event.key === 'Escape' || event.key === 'Esc') {
		      modal.style.display = 'none';
		    }
		  };
	  // 확인 버튼 클릭 이벤트를 추가합니다.
	  const confirmButton = modal.querySelector('button');
	  confirmButton.onclick = function() {
	    checkPassword('${list.pass}');
	  };
	}
</script>

    <meta charset="utf-8">
    <title>LIST</title>
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
</head>
<body>
<h1>문의사항</h1>
<hr>
<table>
    <thead>
    <div id ="vib"><a href="/board/board/add">추가</a></div>
    
    <tr>
        <th>NO</th>
        <th>ID</th>
        <th>TITLE</th>
        <th>DATA</th>
        <th>HIT</th>

    </tr>
    </thead>

    <tbody>
    <c:set var="bnum" value="${0}"></c:set>
  
    <c:forEach var="list" items="${pageinfo.list}">
        <c:if test="${list.bnum != bnum}">
            <tr>
                <td>${list.bnum}</td>
                <td>${list.bname}</a></td>
                
<div id="passwordModal" style="display: none;">
  <div class="modal-content">
  <h2>비밀번호 입력</h2>
  <input type="text" id="passwordInput">
  <button onclick="checkPassword()">확인</button>
  </div>
</div>

<c:choose>
  <c:when test="${user.number == 9 || list.pass == 0}">
    <td><a href="/board/board/detail/${list.bnum}">${list.title}</a></td>
  </c:when>
  <c:otherwise>
    <td><a href="javascript:void(0);" onclick="showPasswordModal(${list.bnum},${list.pass})">비밀글 입니다</a></td>
  </c:otherwise>
</c:choose>


				
                <td>
                    <fmt:formatDate value="${list.date}" pattern="yyyy-MM-dd"/>
                </td>
                <td>${list.hitnum}</td>
                
            </tr>
        </c:if>
        <c:set var="bnum" value="${list.bnum}"></c:set>
    </c:forEach>
    
    </tbody>
</table>
<div id="page">
    <c:if test="${pageinfo.hasPreviousPage}">
        [<a href="/board/board/list/page/${pageinfo.prePage}">Previous</a>]
    </c:if>
    <c:forEach var="pageNum" items="${pageinfo.navigatepageNums}">
        <c:choose>
            <c:when test="${pageNum eq pageinfo.pageNum}">
                <strong style="color: red">${pageNum}</strong>
            </c:when>
            <c:otherwise>
                [<a href="/board/board/list/page/${pageNum}">${pageNum}</a>]
            </c:otherwise>
        </c:choose>
    </c:forEach>
    <c:if test="${pageinfo.hasNextPage}">
        [<a href="/board/board/list/page/${pageinfo.nextPage}">Next</a>]
    </c:if>
</div>
<div id="page1">
    <c:if test="${pageinfo.pages gt 1}">
        [<a href="/board/board/list/page/1">FirstPage</a>]
        [<a href="/board/board/list/page/${pageinfo.pages}">LastPage</a>]
    </c:if>
</div>
<form id="div" action="/board/board/search/page/1" method="get">
    <select name="category">
        <option value="번호">번호</option>
        <option value="이름">이름</option>
        <option value="내용">내용</option>
    </select>
    <input type="text" name="key">
    <input type="submit" value="검색">
</form>
</body>
</html>

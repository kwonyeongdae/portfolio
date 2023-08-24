<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>DETAIL</title>
  <style type="text/css">
      body {
      font-family: 'Arial', sans-serif;
      margin: 0;
      padding: 0;
      background-color: #f3f3f3;
    }

    /* Main Content Styles */
    .container {
      max-width: 800px;
      margin: 0 auto;
      padding: 20px;
      background-color: #fff;
      box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
    }

    h1 {
      text-align: center;
      color: #333;
      margin-bottom: 30px;
      border-bottom: 2px solid #333;
      padding-bottom: 10px;
    }

    table {
      width: 100%;
      margin-top: 20px;
      border-collapse: collapse;
    }

    th, td {
      border: 1px solid #ccc;
      padding: 10px;
    }

    th {
      background-color: #f2f2f2;
      text-align: center;
    }

    /* Button Styles */
    .btn {
      display: inline-block;
      padding: 10px 20px;
      background-color: #4CAF50;
      border: none;
      border-radius: 3px;
      text-decoration: none;
      color: white;
      transition: background-color 0.3s;
    }

    .btn:hover {
      background-color: #45a049;
    }

    /* Comment Styles */
    .comment-list {
      margin-top: 20px;
    }

    .comment-item {
      display: flex;
      justify-content: space-between;
      padding: 10px;
      border-bottom: 1px solid #ccc;
      font-size: 13px;
    }

    .comment-content {
      flex: 1;
      padding-left: 10px;
    }

    /* Form Styles */
    .comment-form {
      margin-top: 20px;
    }

    .comment-form label {
      display: block;
      font-weight: bold;
      margin-bottom: 5px;
    }

    .comment-form input[type="text"] {
      width: 100%;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 3px;
      margin-bottom: 10px;
    }

    .comment-form button {
      padding: 10px 20px;
      background-color: #4CAF50;
      border: none;
      border-radius: 3px;
      cursor: pointer;
      color: white;
      transition: background-color 0.3s;
    }

    .comment-form button:hover {
      background-color: #45a049;
    }

    /* Navigation Styles */
    .navigation {
      margin-top: 20px;
      text-align: center;
    }

    .navigation a {
      margin-right: 10px;
      text-decoration: none;
      color: #333;
      padding: 5px 10px;
      background-color: #f2f2f2;
      border-radius: 3px;
      transition: background-color 0.3s;
    }

    .navigation a:hover {
      background-color: #ddd;
    }
  </style>
  <script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
  <script type="text/javascript">
    function remove(bnum) {
      var realAuthor = '${detail[0]['bname']}';
      var requester = '${userid}';
      if (realAuthor != requester) {
        alert('글 작성자만 삭제할 수 있어요~');
        return;
      }
      if (!confirm("정말로 삭제하시겠습니까?")) {
        return false;
      }
      
      
      $.ajax({
        url: '/board/board/remove/' + bnum,
        data: { "bnum": bnum },
        method: 'post',
        cache: false,
        dataType: 'json',
        success: function(res) {
          var message = res.remove ? "삭제 성공" : "삭제 실패";
          alert(message);
          location.href = "/board/board/list/page/1";
          if (!res.remove) {
            alert("작성자만 삭제할 수 있습니다.");
          }
        },
        error: function(err) {
          alert('에러: ' + err);
        }
      });
    }

    function goBack() {
      history.back();
    }

    function added(bnum) {
      if (!confirm("댓글 저장하시겠습니까?")) {
        return false;
      }
      $('#btnUpload').prop('disabled', true);
      var form = $('#addform').serialize();
      $.ajax({
        url: '/board/comment/' + bnum,
        data: form,
        method: 'post',
        cache: false,
        dataType: 'json',
        success: function(res) {
          var message = res.added ? "댓글 성공" : "댓글 실패";
          alert(message);
          if (res.added) {
        	  location.reload();
          }
        },
        error: function(err) {
          alert('에러: ' + err);
          $('#btnUpload').prop('disabled', false);
        }
      });
      return false;
    }
  </script>
   <script type="text/javascript">
   function updateform(bnum) {
	      var realAuthor = '${detail[0]['bname']}';
	      var requester = '${userid}';
	      if (realAuthor != requester) {
	        alert('글 작성자만 삭제할 수 있어요~');
	        return;
	      }
	      if (realAuthor = requester) {
	    	  location.href = "/board/board/update/"+bnum;
		      }
	     
	    }
   </script>
</head>
<body>
  <table>
    <h1>문의사항</h1>
    <hr>
    <div id="com">
      <a href="javascript:updateform(${detail[0].bnum})" class="btn">수정</a>
      <a href="javascript:remove(${detail[0].bnum});" class="btn">삭제</a>
    </div>
    <tr>
      <th>NO</th>
      <td>${detail[0]['bnum']}</td>
    </tr>
    <tr>
      <th>NAME</th>
      <td>${detail[0]['bname']}</td>
    </tr>
    <tr>
      <th>TITLE</th>
      <td>${detail[0]['title']}</td>
    </tr>
    <c:choose>
    <c:when test="${not empty detail[0]['fname']}">
        <tr>
            <th>ATTACH</th>
            <td class="attach">
                <c:forEach var="detailItem" items="${detail}">
                    <a href='/board/download/${detailItem.num}'>${detailItem.fname}
                        <c:if test="${not empty detailItem.fname}">(${detailItem.fsize}k)</c:if>
                    </a><br>
                </c:forEach>
            </td>
        </tr>
    </c:when>
    <c:otherwise>
        <!-- If you want to handle the 'otherwise' case, you can add the content here -->
    </c:otherwise>
</c:choose>

    <tr>
      <th>CONTENT</th>
      <td class="content">${detail[0]['content']}</td>
    </tr>
    <tr>
      <th>DATA</th>
      <td><fmt:formatDate value="${detail[0]['date']}" pattern="yyyy-MM-dd"/></td>
    </tr>
    <tr>
      <th>HIT</th>
      <td>${detail[0]['hitnum']}</td>
    </tr>
  </table>

  <table>
    <c:forEach var="com" items="${comlist}">
      <tr class="divcom" style="width: 200px;">
        <th style="width: 100px; background-color: white; font-size: 13px;">${com.name}</th>
        <th style="width: 400px; padding: 5px; background-color: white; font-size: 13px;">${com.comcontent}</th>
        <th style="width: 100px; background-color: white; font-size: 13px;">${com.data}</th>
      </tr>
    </c:forEach>
  </table>
  
<c:if test="${user.number eq 9}">
  <form id="addform" class="comment-form">
    <input type="hidden" id="name" name="name" value="관리자">
    <div>
      <label for="content">댓글</label>
      <input type="text" id="comcontent" name="comcontent">
      <button id="btnUpload" type="button" onclick="added(${detail[0]['bnum']});" class="btn">확인</button>
    </div>
  </form>
</c:if>

  <div class="navigation">
    <c:set var="previousPage" value="${header.referer}" />
    <c:set var="category" value="" />
    <c:set var="key" value="" />
    <c:set var="pn" value="" />

    <c:if test="${not empty previousPage}">
      <c:set var="category" value="${fn:split(fn:substringAfter(previousPage, 'category='), '&')[0]}" />
      <c:set var="key" value="${fn:split(fn:substringAfter(previousPage, 'key='), '&')[0]}" />
      <c:set var="pageNum" value="${fn:substringAfter(previousPage, 'page/')}" />
      <c:set var="pn" value="${pageNum != null ? fn:substring(pageNum, 0, 1) : '0'}" />
    </c:if>

    <c:url value="/board/board/list/page/${pn}" var="page" />
    <c:url value="/board/board/search/page/${pn}" var="spage" />

    <c:choose>
      <c:when test="${previousPage==null||previousPage==''||previousPage.endsWith(page)}">
        <a href="${page}" class="btn">목록</a>
      </c:when>
      <c:otherwise>
        <a href="${spage}?category=${category}&amp;key=${key}" class="btn">목록</a>
      </c:otherwise>
    </c:choose>

    <a href="javascript:goBack();" class="btn">이전페이지</a>
  </div>
</body>
</html>

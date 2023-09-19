<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
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

   h3 {
        text-align: center;
        font-size: 36px;
        background-color: #333;
        color: #fff;
        padding: 10px;
        border-radius: 10px;
        margin-top: 20px;
         margin: 0 auto;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        width:80%;
    
    }
button {
    background-color: #444;
    color: #fff;
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
    margin: 0 auto;
    text-align: center;
    display: block;
}

button:hover {
    background-color: #555;
}
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function delreview(count){
   
   
   
   if(!confirm('이 리뷰를 삭제할까요?')) return;
   
   $.ajax({
      url:"/book/book/review/del/"+count,
      method:'post',
      data: { count: count },
      cache:false,
      dataType:'json',
      success:function(res){
         alert(res.del ? '삭제 완료' : '삭제 실패');
         location.reload();
      },
      error:function(xhr,status,err){
         console.error("XHR Status:", status);
           console.error("Error:", err);
           console.error("Response:", xhr.responseText);
         alert(status + "/" + err);
      }
      
      
      
      
      
      
      
   });
   
   return false;
}

</script>



</head>
<body>
<h3>전체리뷰</h3><hr>
<c:choose>
   <c:when test="${user.number eq 9}">
   <table>
   <tr><th>아이디</th> <th>리뷰</th> <th>평점</th> <th>삭제</th></tr>
      <c:forEach var="re" items="${pageInfo.list}">
         
         <tr>
         
         <td>${re.userid}</td>
         
         <td>${re.reviewcontents }</td>
      
         <td>${re.score}</td>
         
         <td><button onclick="return delreview(${re.count})"> 삭제  </button></td>
         
         </tr>
         
         
      </c:forEach>
    
   </table>
   
   
   
   
   </c:when>



   <c:otherwise>
   <table>
   <tr><th>아이디</th> <th>리뷰</th> <th>평점</th></tr>
      <c:forEach var="re" items="${pageInfo.list}">
         
         <tr><td>${re.userid}</td>
         
         <td>${re.reviewcontents }</td>
      
         <td>${re.score}</td></tr>
      </c:forEach>
   
   </table>
   </c:otherwise>
   
</c:choose>
<button onclick="history.back()">책 상세정보로 돌아가기</button>

</body>
</html>

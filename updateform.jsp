<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>

<head>
<style type="text/css">
h1{text-align: center; margin-right: 80px;}
table,div {
  width: 400px;
  margin: 0 auto;
  padding: 20px;
  width: 350px
}
th{text-align: center; border: 1px solid black;
      background-color: lightgray;}
td{text-align: center; border: 1px solid black;
      }
input#content{padding-top: 20px;
  padding-bottom: 20px;}
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function attremove(num,fname){
if (!confirm("파일을 삭제겠습니까?")) {
    return false;
}
var obj = {};
obj.num = num;
obj.fname = fname;

alert(num);
alert(fname);
$.ajax({
    url: '/board/board/attremove',// URL에 변수 값을 추가합니다.
    data:obj,
    method: 'post',
    cache: false,
    dataType: 'json',  // dataType을 'html'로 변경
    success: function(res) {
    	var message = res.attremove ? "삭제 성공" : "삭제 실패";
        alert(message);
        location.href ="/board/board/update/" + ${alist[0].bnum};
        if(!res.update){
        	location.reload();
        }
    },
    error: function(err) {
        alert('에러: ' + err);
    }
});
}

function update() {
	 $('#btnUpload').prop('disabled', true);
	var realAuthor = '${alist[0].bname}';
	var requester = '${userid}';

	if(realAuthor!=requester) {
		alert('글 작성자만 글을 수정할 수 있어요~');
		return;
	}
	
	if (!confirm("정말로 수정하시겠습니까?")) {
        return false;
    }
	var form = $('#updateform')[0];
	var formData = new FormData(form);
	$.ajax({
        url: '/board/board/updatedd', // URL에 변수 값을 추가합니다.
        data: formData,
        method: 'post',
        enctype:'multipart/form-data',
        cache: false,
        dataType: 'json',  // dataType을 'html'로 변경
        processData:false,//파일이 들어가니까 폼필드처럼 취급하지 말라 라는 뜻
		contentType:false,//파일이 들어가니까 폼필드처럼 취급하지 말라 라는 뜻
		timeout:3600,
        success: function(res) {
        	var message = res.update ? "수정 성공" : "수정 실패";
            alert(message);
            location.href = "/board/board/detail/${alist[0].bnum}";
            if(!res.update){
            	location.href ="/board/board/update/" + '${alist[0].bnum}';
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
<meta charset="utf-8">
<title>UPDATEFORM</title>
</head>
<body>

<h1>회원정보 수정</h1><hr>
<div>
<form id="updateform" onsubmit="return update();">
<input type="hidden" name="bnum" value ="${alist[0].bnum}">
<table>
<tr><th>NO</th><td>${alist[0].bnum}</td></tr>
<tr><th>NAME</th><td>${alist[0].bname}</td></tr>
<tr><th>TITLE</th><td><input type="text" id="title" name="title" value ="${alist[0].title}"></td></tr>
<tr><th>CONTENT</th><td><input  type="text" id="content" name="content" value ="${alist[0].content}"></td></tr>
<tr><th>DATE</th><td><fmt:formatDate value="${alist[0].date}" pattern="yyyy-MM-dd"/></td></tr>
<tr><th>HIT</th><td>${alist[0].hitnum}</td></tr>
<tr><th>ATTACH</th><td>
<c:forEach var="atb" items="${alist}">
${atb.fname}
<a href="javascript:attremove('${atb.num}','${atb.fname}');" title="첨부파일 삭제">
<c:if test="${not empty atb.fname}">[X] <br>
</c:if>
</a>
<c:if test="${empty atb.fname}">
<input type="file" name="files" multiple="multiple" >
</c:if>

</c:forEach></td></tr>

</table>
<td><div><button id="btnUpload" type="submit">ENTER</button></div></td>
</form>
</div>

</body>

</html>

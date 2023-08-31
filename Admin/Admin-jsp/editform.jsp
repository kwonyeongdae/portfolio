<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
<meta charset="utf-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function update() {
	
	if (!confirm("수정 할까요?")) return;
    
	var form = $('#update')[0];
    var formData = new FormData(form);
    
    $.ajax({
        url: '/admin/update',
        method: 'post',
        enctype: 'multipart/form-data',
        cache: false,
        data: formData,
        dataType: 'json',
        processData: false, // 데이터를 처리하지 않도록 설정
        contentType: false, // 컨텐츠 타입을 설정하지 않도록 설정
        timeout: 3600,
        success: function (res) {
            alert(res.update ? '수정완료' : '수정 실패'); 
            location.href = "/admin/adbooklist/1"; 
        },
        error: function (xhr, status, err) {
            alert('에러:' + err);
        }
    });
    return false;
}

function attremove(bnum,contentimg){
	if (!confirm("파일을 삭제겠습니까?")) {
	    return false;
	}
	var obj = {};
	obj.bnum = bnum;
	alert(bnum);
	obj.contentimg = contentimg;
	alert(contentimg);

	$.ajax({
	    url: '/book/attremove',// URL에 변수 값을 추가합니다.
	    data:obj,
	    method: 'post',
	    cache: false,
	    dataType: 'json',  // dataType을 'html'로 변경
	    success: function(res) {
	    	var message = res.attremove ? "삭제 성공" : "삭제 실패";
	        alert(message);
	        	location.reload();
	        
	    },
	    error: function(err) {
	        alert('에러: ' + err);
	    }
	});
	}

</script>
<script type="text/javascript">

function handleImageSelect(event) {
    var input = event.target;
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            $('#img-preview').attr('src', e.target.result);
        };
        reader.readAsDataURL(input.files[0]);
    }
}

function preview(evt) {
    var reader = new FileReader();

    reader.onload = function (event) {
        var thumbnailContainer = document.getElementById("thumbnail_view");
        thumbnailContainer.innerHTML = "";

        var img = document.createElement("img");
        img.src = event.target.result;
        thumbnailContainer.appendChild(img);
    };

    reader.readAsDataURL(evt.target.files[0]);
}

$(document).ready(function () {
    $('#img-file').on('change', handleImageSelect);
});

</script>
<style type="text/css">
  body {
            font-family: Arial, sans-serif;
            background-color: #f7f7f7;
            margin: 0;
            padding: 0;
        }

        h1 {
            text-align: center;
            margin-top: 20px;
        }

        #update {
            width: 40%;
            margin: 20px auto;
            background-color: #fff;
            border: 1px solid #ccc;
            padding: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table th,
        table td {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: center;
        }

        table th {
            background-color: #f7f7f7;
        }

        #img-preview {
            max-width: 200px;
            max-height: 200px;
        }

        input[type="text"],
        input[type="submit"] {
            padding: 8px 12px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        input[type="submit"] {
            background-color: #007BFF;
            color: #fff;
            cursor: pointer;
            text-align: center;
        }

</style>




</head>
<body>
<h1>책 정보 수정</h1>
<form  id="update" onsubmit="return update();">
    <input type="hidden" name="bnum" value="${book[0].bnum}">
    <table>
        <tr>
            <th>번호</th>
            <td>${book[0].bnum}</td>
        </tr>
        <tr>
            <th>책명</th>
            <td><input type="text" id="bname" name="bname" value="${book[0].bname}" readonly></td>
        </tr>
        <tr>
            <th>출판사</th>
            <td><input type="text" id="publisher" name="publisher" value="${book[0].publisher}" readonly></td>
        </tr>
        <tr>
            <th>저자</th>
            <td><input type="text" id="author" name="author" value="${book[0].author}" readonly></td>
        </tr>
        <tr>
            <th>가격</th>
            <td><input type="text" id="price" name="price" value="${book[0].price}"></td>
        </tr>
        <tr>
            <th>이미지</th>
            <td>
                <img id="img-preview" src="/img/${book[0].cvrimg}" alt="이미지 미리보기" style="max-width: 200px; max-height: 200px;">
      			
            </td>
        </tr>
        <tr>
            <th>책소개</th>
             <td>
            <div>
            
            <c:if test="${book[0].contentimg != null}">
            <img src="/img/${book[0].contentimg}" alt="이미지 미리보기" style="max-width: 200px; max-height: 200px;">
            </c:if>
            <a href="javascript:attremove('${book[0].bnum}','${book[0].contentimg}');" title="첨부파일 삭제">
				<c:if test="${not empty book[0].contentimg}">[X] <br>
				</c:if>
			</a>
            </div>
           
             <div>
      	 <label>추가할 이미지 선택<br><a style="color: red; font-size: 5px;"></a></label>
        <input type="file" id="conimg" name="conimg" onchange="preview(event);">
        </div>
      <div id="thumbnail_view">
                <span>Preview Image</span>
            </div>
            <textarea id="content" name="content" style="width: 600px; padding: 100px;">${book[0].content}</textarea>
            </td>
        </tr>

    </table>
    <input type="submit" value="수정">
</form>
</body>
</html>
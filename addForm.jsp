<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.concurrent.atomic.AtomicInteger" %>
<%java.util.Date currentDate = new java.util.Date();%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        padding: 0;
        background-color: #f3f3f3;
    }

    h1 {
        text-align: center;
        margin: 20px;
        color: #333;
    }

    label {
        display: block;
        margin-bottom: 5px;
        color: #333;
    }

    input[type="text"], input[type="file"] {
        border: 1px solid #ccc;
        padding: 10px;
        width: 100%;
        box-sizing: border-box;
        margin-bottom: 10px;
    }

    #form-container {
        width: 500px;
        margin: 0 auto;
        padding: 20px;
        text-align: center;
        background-color: #fff;
        box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
    }

    fieldset {
        margin-bottom: 20px;
        border: none;
    }

    legend {
        font-weight: bold;
        margin-bottom: 10px;
        color: #555;
    }

    button {
        padding: 10px 20px;
        background-color: #4CAF50;
        border: none;
        color: white;
        cursor: pointer;
        margin-right: 10px;
    }

    #thumbnail_view {
        width: 100%;
        height: 200px;
        border: 2px dashed #ccc;
        display: flex;
        justify-content: center;
        align-items: center;
        margin-bottom: 20px;
    }

    #thumbnail_view img {
        max-width: 100%;
        max-height: 100%;
        object-fit: contain;
    }
</style>
<meta charset="utf-8">
<title>ADDFORM</title>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function limitPasswordLength(input, maxLength) {
	  // 입력값의 길이를 확인하여 maxLength를 넘어서면 입력을 제한합니다.
	  if (input.value.length > maxLength) {
	    input.value = input.value.slice(0, maxLength); // 최대 길이만큼 잘라냅니다.
	  }
	}   

function added() {
	if (!confirm("추가 할까요?")) {
	    return false;
	}
    	  var title = document.getElementById("title").value;
    	  var content  = document.getElementById("content").value;

    	  if (title == "") {
    	    alert("'제목' 입력은 필수입니다");
    	    return false;
    	  } else if (content == "") {
    	    alert("'내용' 입력은 필수입니다");
    	    return false;
    	  } 
    	
        $('#btnUpload').prop('disabled', true);
        var form = $('#addform')[0];
        var formData = new FormData(form);
        $.ajax({
            url: '/board/board/add',
            data: formData,
            enctype: 'multipart/form-data',
            method: 'post',
            cache: false,
            dataType: 'json',
            processData: false,
            contentType: false,
            timeout: 3600,
            success: function (res) {
                var message = res.added ? "추가 성공" : "추가 실패";
                alert(message);
                if (res.added) {
                    location.href = "/board/board/list/page/1";
                }

            },
            error: function (err) {
                alert('에러: ' + err);
                $('#btnUpload').prop('disabled', false);
            }
        });
        return false;
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
</script>
</head>
<body>
<h1>ADDFORM</h1>
<hr>
<div id="form-container">
    <form id="addform" enctype="multipart/form-data" onsubmit="return added();">
        <input type="hidden" id="data" name="data" value="<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" />">

        <fieldset>
            <legend>TEXT FIELD</legend>
            <label for="bname">비밀번호*4자리까지*</label>
            <input type="text" id="pass" name="pass" oninput="limitPasswordLength(this, 4)">
            
            <label for="bname">아이디</label>
            <input type="text" id="bname" name="bname" value="${userid}">

            <label for="title">제목</label>
            <input type="text" id="title" name="title">

            <label for="content">내용</label>
            <input type="text" id="content" name="content">
        </fieldset>

        <fieldset>
            <legend>첨부파일</legend>
            <label for="file">Upload an Image</label>
            <input type="file" id="file" name="files" onchange="preview(event);">

            <div id="thumbnail_view">
                <span>Preview Image</span>
            </div>
        </fieldset>

        
            <button type="reset">취소</button>
            <button id="btnUpload" type="submit">확인</button>
        
    </form>
</div>
</body>
</html>

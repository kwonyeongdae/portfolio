<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 20px;
            padding: 0;
        }

        h1 {
        text-align :center;
            font-size: 24px;
        }

        form {
            max-width: 600px;
            margin: auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        form div {
            margin-bottom: 10px;
        }

        label {
            display: block;
            font-weight: bold;
        }

        input[type="text"],
        input[type="file"] {
            width: 100%;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
         #content,#content1,#content2 {
        width: 590px;
        height: 150px; /* 높이를 조절하여 보여질 줄의 개수를 설정합니다. */
        padding: 10px; /* 원하는 여백을 설정합니다. */
        border: 1px solid #ccc;
        border-radius: 4px;
        resize: none; /* 사용자가 크기를 조절하지 못하도록 설정합니다. */
    }

        input[type="file"] {
            padding-top: 10px;
        }

        #thumbnail_view {
            display: inline-block;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-bottom: 10px;
        }

        #thumbnail_view img {
            max-width: 100%;
            max-height: 150px;
        }

        button {
            background-color: gray;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        button:disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }

        button:hover {
            background-color: #45a049;
        }

        .error-message {
            color: red;
        }
    </style>
<meta charset="utf-8">
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function add(){
   var bname = document.getElementById("bname").value;
   var publisher  = document.getElementById("publisher").value;
   var author = document.getElementById("author").value;
   var price  = document.getElementById("price").value;
   var pdate = document.getElementById("pdate").value;
   var cate = document.getElementById("content").value;
   var cate = document.getElementById("cate").value;

     if (bname == "") {
       alert("'책명' 입력은 필수입니다");
       return false;
     } else if (publisher == "") {
       alert("'출판사' 입력은 필수입니다");
       return false;
     }else if (author == "") {
      alert("'저자' 입력은 필수입니다");
       return false;
     } else if (price == "") {
       alert("'가격' 입력은 필수입니다");
       return false;
       } else if (pdate == "") {
       alert("'출판일' 입력은 필수입니다");
       return false;
       } else if (content == "") {
      alert("'줄거리' 입력은 필수입니다");
      return false;
     } else if (cate == "") {
       alert("'카테고리' 입력은 필수입니다");
       return false;
       } 
   
   if (!confirm("책을 추가할까요?")) {
       return false;
   }
   $('#btnUpload').prop('disabled', true);
   var form = $('#addform')[0];
    var formData = new FormData(form);
   $.ajax({
      url:'/book/add',
       data: formData,
       enctype: 'multipart/form-data',
         method: 'post',
         cache: false,
         dataType: 'json',
         processData: false,
         contentType: false,
         timeout: 3600,
      success:function(res) {
         alert(res.added ? '저장 성공':' 저장 실패');
         if(res.added) location.href='/book/list/page/1';
      },
      error:function(xhr,status,err) {
         alert('에러:' + err);
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

function preview1(evt) {
    var reader = new FileReader();

    reader.onload = function (event) {
        var thumbnailContainer = document.getElementById("thumbnail_view1");
        thumbnailContainer.innerHTML = "";

        var img = document.createElement("img");
        img.src = event.target.result;
        thumbnailContainer.appendChild(img);
    };

    reader.readAsDataURL(evt.target.files[0]);
}
</script>
<title>도서 추가</title>
</head>
<body>
<h1>도서 추가</h1>
<form id="addform" onsubmit="return add();">
    <div>
        <label for="img">이미지</label>
        <input type="file" id="file" name="file" onchange="preview(event);">
    </div>
        </div>
   <div id="thumbnail_view">
                <span>Preview Image</span>
            </div>
    <div>
        <label>도서명</label>
        <input type="text" id="bname" name="bname">
    </div>
    <div>
        <label>출판사</label>
        <input type="text" id="publisher" name="publisher">
    </div>
    <div>
        <label>저자</label>
        <input type="text" id="author" name="author">
    </div>
    <div>
        <label>가격</label>
        <input type="text" id="price" name="price">
    </div>
    <div>
        <label>출판일</label>
        <input type="text" id="pdate" name="pdate">
    </div>
    <div>
       <label for="img">이미지<a style="color: red; font-size: 5px;">*이미지파일이 존재하지 않으면 텍스트가 나옵니다*</a></label>
        <input type="file" id="conimg" name="conimg" onchange="preview1(event);">
        </div>
      <div id="thumbnail_view1">
                <span>Preview Image</span>
            </div>
        <label>줄거리 <a style="color: red; font-size: 5px;">*이미지파일이 존재하면 이미지파일이 먼저 나옵니다*</a></label>
        <textarea id="content" name="content"></textarea>
    <div>
        <label>카테고리</label>
        <select id="cate" name="cate">
           <option value="">카테고리 선택</option>
           <option value="a">동물</option>
           <option value="b">공주</option>
           <option value="c">사물</option>
        </select>
    </div>
    <div>
        <button id="btnUpload" type="submit">확인</button>
    </div>
</form>
</body>
</html>
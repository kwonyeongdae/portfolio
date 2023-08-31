<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

    .container {
      max-width: 800px;
      margin: 0 auto;
      padding: 20px;
      background-color: #fff;
      box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
      border-radius: 4px;
    }

    table {
      width: 120%;
      margin-bottom: 20px;
    }

    th {
    
      background-color: #f9f9f9;
      text-align: left;
      padding: 10px;
      
    }

    td {
    
      padding: 10px;
      border-bottom: 1px solid #ddd;
     
    }

    .info-label {
      font-weight: bold;
      width: 30%;
    }

    .book-info {
      padding-top: 10px;
      margin-top: 10px;
    }

    .even-row {
      background-color: #f7f7f7;
    }

    .odd-row {
      background-color: #ffffff;
    }
    th.info-label {
    width: calc(30% + 10px);
  }
  td.book-price {
    width: calc(70% - 10px);
  }
   button {
    margin-left: 10px;
    padding: 8px 15px;
    background-color: #333;
    color: #fff;
    border: none;
    border-radius: 5px;
    cursor: pointer;
  }
  #a1{float: left;}
  #a2{clear: left;}
  div{ font-size: 20px;}
   .center-table {
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
  }
</style>

<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function clickTrans(num){
	if(!confirm("교환/반품을 신청하시겠습니까?"))return;
	 
	 var obj = {};
		obj.num = num;
		
	$.ajax({
		url:'/fairy/cart/changebook',
		method:'post',
		data: obj,
		cache:false,
		dataType:'json',
		success:function(res) {
			if (res.point) {
				location.href = "/fairy/mypage/${userid}";
		}	
		},
		error:function(xhr,status,err){
			alert(status + "/" + err);
		}
	});
}
</script>
<meta charset="utf-8">
<title>교환/반품</title>
<h1>교환/반품</h1><hr>
</head>
<body>
<div class="center-table">
<div id="a1"><img src="/img/${book.cvrimg}" style="max-width: 200px; max-height: 300px;"></div><br>
<div>제목 : ${book.bname}</div><br>
<div>가격 : <fmt:formatNumber value="${book.price}"/></div><br>
<div>수량 : ${book.quantity}</div><br>
<div id ="a2"></div>
</div>

<table>
<tr>
        <td class="info-label">아이디:</td>
        <td>${member.userid}</td>
      </tr>
      <tr>
        <td class="info-label">이름:</td>
        <td>${member.name}</td>
      </tr>
      <tr>
        <td class="info-label">휴대전화:</td>
        <td>${member.phone}</td>
      </tr>
      <tr>
        <td class="info-label">주소:</td>
        <td>${member.contact_address}&nbsp; ${member.detailed_address}</td>
      </tr>
<tr>
<td>교환/반품</td>
<td>
<label><input type ="radio" name = "change" value ="a">교환</label>
 <label><input type ="radio" name = "change" value ="b">반품</label>  
</select>
</td>
</tr>
<tr>
<button type="button" onclick ="clickTrans(${book.num})">신청</button>
</tr>
</table>
</body>
</html>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>MYPAGE</title>
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
      max-width: 1000px;
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
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function clickTrans(num){
	if(!confirm("교환/반품을 신청하시겠습니까?"))return;
	location.href = "/fairy/cart/change/" + num;
	
}

function restfalse(fnum){
	  
	 if(!confirm("휴먼계정을 해체하시겠습니까?"))return;
	 
	 var obj = {};
		obj.fnum = fnum;
		
	 $.ajax({
			url:'/fairy/restesc',
			method:'post',
			data: obj,
			cache:false,
			dataType:'json',
			success:function(res) {
				if (res.restout) {
					alert('휴먼계정이 해제되었습니다');
					location.href = "/book/list/page/1";
				}
			},
			error:function(xhr,status,err){
				alert(status + "/" + err);
			}
		});
	}
	
function Transfer(){
	if(!confirm("포인트를 모두 환전하시겠습니까?"))return;

	var carrotpoint = parseInt($('#carrotpoint').val());

    var obj = {
            'userid': '${userid}',
            'carrotpoint': carrotpoint,
        };
	
    $.ajax({
		url:'/fairy/pointout',
		method:'post',
		data: obj,
		cache:false,
		dataType:'json',
		success:function(res) {
			if (res.point) {
				alert('환전이 완료 되었습니다(계좌이체 미구현)');
				location.reload();
			}
		},
		error:function(xhr,status,err){
			alert(status + "/" + err);
		}
	});
}
</script>
<script type="text/javascript">
function Delivery(cnum){
	if(!confirm("택배신청 하시겠어요?"))return;
    var obj = {
         'userid' : '${userid}',
         'cnum' : cnum
	};
    $.ajax({
		url:'/fairy/state',
		method:'post',
		data: obj,
		cache:false,
		dataType:'json',
		success:function(res) {
			if (res.Deli) {
				alert('택배신청이 완료되었습니다(택배시스템 미구현)');
				location.reload();
			}
		},
		error:function(xhr,status,err){
			alert(status + "/" + err);
		}
	});
}


function trade(cnum,carrotpoint,uid){
	if(!confirm("상품에 만족 하셧나요?"))return;
    var obj = {
         'userid' : '${userid}',
         'cnum' : cnum,
         'carrotpoint' : carrotpoint,
         'uid' : uid
	};
    $.ajax({
		url:'/fairy/trade',
		method:'post',
		data: obj,
		cache:false,
		dataType:'json',
		success:function(res) {
			if (res.tra) {
				alert('최종거래가 완료되었습니다(택배시스템 미구현)');
				location.reload();
			}
		},
		error:function(xhr,status,err){
			alert(status + "/" + err);
		}
	});
    
}

function tradehid(cnum,carrotpoint,uid){
    var obj = {
         'userid' : '${userid}',
         'cnum' : cnum,
         'carrotpoint' : carrotpoint,
         'uid' : uid
	};
    $.ajax({
		url:'/fairy/trade',
		method:'post',
		data: obj,
		cache:false,
		dataType:'json',
		success:function(res) {
		},
		error:function(xhr,status,err){
			alert(status + "/" + err);
		}
	});
    
}

	
function okbuy(num){
    var obj = {
         'num' : num,
	};
    
    $.ajax({
		url:'/fairy/cart/ok',
		method:'post',
		data: obj,
		cache:false,
		dataType:'json',
		success:function(res) {
		},
		error:function(xhr,status,err){
			alert(status + "/" + err);
		}
	});
    
}


function modifyMem(){
	 var requester='${sessionScope.userid}';
	 if (requester == null || requester.trim().length == 0) 
	     {
		    alert('로그인이 필요한 기능입니다. 먼저 로그인해주세요.');
		    location.href = '/fairy/login';
		   }else{
			  location.href = '/fairy/editMem/${userid}';
		   } 
	}
</script>
</head>
<body>
  <h1>마이페이지</h1>
  <div class="container">
    <table style="width: 100%;">
    <a href="javascript:modifyMem()" style ="font-size:20px;">회원정보 수정</a>
      <tr>
      <c:if test="${member.number eq 5}">
        <th colspan="2" class="info-label"><button type="button" onclick="restfalse(${member.fnum})" >휴면해제</button></th>
        </c:if>
      </tr>
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
        <td class="info-label">이메일:</td>
        <td>${member.email}</td>
      </tr>
      <tr>
        <td class="info-label"> 자녀 혹은 주이용 아동 나이:</td>
        <td>${member.age}</td>
      </tr>
      <tr>
        <td class="info-label">보유포인트</td>
        <td>${member.mileage}P</td>
      </tr>
      <tr>
        <td class="info-label">carrot판매금액:</td>
        <td><fmt:formatNumber value="${member.carrotpoint}"/>원</td>
        </tr>
        <tr>
        <td>
        <select id = "cate" name = "cate">
    		 <option value="hyundai">국민은행</option>
		     <option value="samsung">우리은행</option>
		     <option value="woori">농협</option>
		     <option value="lotte">신한은행</option>
		     <option value="kookmin">새마을금고</option>
    		 <option value="kakao">카카오뱅크</option>
    	</select>
    	</td>
        <td>계좌번호<input type="text" id="bank" name ="bank" >
        출금 금액<input type="text" id="carrotpoint" name ="carrotpoint" ></td>
        <td><button type="button" onclick="Transfer()" style="width: 70px;">환전</button></td>
        
      </tr>
    </table>
<!-----------------------------------------여기서부터 구매내역---------------------------------------------------------->
<!-----------------------------------------여기서부터 구매내역---------------------------------------------------------->
    <table style="width: 100%;">
      <tr>
        <th colspan="4" class="info-label" style="text-align: center;">구매내역</th>
      </tr>
      <tr>
        <th class="info-label">날짜</th>
        <th class="info-label">책 제목</th>
        <th class="info-label">수량</th>
        <th class="info-label">가격</th>
        <th class="info-label">교환/반품</th>
      </tr>
      <c:forEach var="book" items="${book}" varStatus="loop">
        <tr>
          <td>${book.buyday}</td>
          <td>${book.bname}</td>
          <td>${book.quantity}권</td>
          <td>${book.price}원</td>
          <td>
	          <c:if test="${book.statu == 0 }">
	          	<button type="button" id="changeButton" onclick="clickTrans(${book.num})">교환/환불</button>
	          	<button type="button" id="okButton" onclick="okbuy(${book.num})" style="display: none;"></button>
	          </c:if>
	          
	          <c:if test="${book.statu == 1 }">
	          	<div id="statusText">수령완료</div>
	          </c:if>
          </td>
        </tr>
      </c:forEach>
    </table>
 <!-----------------------------------------여기서부터 중고판매내역---------------------------------------------------------->
 <!-----------------------------------------여기서부터 중고판매내역---------------------------------------------------------->
     <table style="width: 100%;">
      <tr>
        <th colspan="6" class="info-label" style="text-align: center;">carrot 판매내역</th>
      </tr>
      <tr>
        <th class="info-label">날짜</th>
        <th class="info-label">상품</th>
        <th class="info-label">가격</th>
        <th class="info-label">판매상태</th>
        <th class="info-label">택배</th>
      </tr>
      <c:forEach var="carrot" items="${carrot}">
        <tr>
          <td><fmt:formatDate value="${carrot.cdata}" pattern="yyyy-MM-dd"/></td>
          <td>${carrot.title}</td>
          <td><fmt:formatNumber value="${carrot.price}"/>원</td>
          
          <td>${carrot.state}</td>
          <td>	
          <c:choose>
	          <c:when test="${carrot.state == '판매자확인중'}">
				<button type="button" onclick="Delivery(${carrot.cnum})">택배신청</button>
	          </c:when>
	          <c:when test="${carrot.state == '거래중'}">
	          	<td>택배발송</td>
	          </c:when>
	          <c:when test="${carrot.state == '판매완료'}">
	          	<td>수령완료</td>
	          </c:when>
          </c:choose>
          </td>
        </tr>
      </c:forEach>
    </table>
<!-----------------------------------------여기서부터 중고구매내역---------------------------------------------------------->
<!-----------------------------------------여기서부터 중고구매내역---------------------------------------------------------->   
    <table style="width: 100%;">
      <tr>
        <th colspan="6" class="info-label" style="text-align: center;">carrot 구매내역</th>
      </tr>
      <tr>
        <th class="info-label">날짜</th>
        <th class="info-label">상품</th>
        <th class="info-label">가격</th>
        <th class="info-label">판매자</th>
        <th class="info-label">거래상태</th>
      </tr>
     
      <c:forEach var="carrot" items="${bougthcarrot}">
        <tr>
          <td><fmt:formatDate value="${carrot.cdata}" pattern="yyyy-MM-dd"/></td>
          <td>${carrot.title}</td>
          <td><fmt:formatNumber value="${carrot.price}"/>원</td>
          <td>${carrot.saleuserid}</td>
          <td><c:if test="${carrot.state == 0}">
          	  <button type="button" id="tradeButton" onclick="trade(${carrot.cnum},${carrot.price*0.9},'${carrot.saleuserid }')">거래완료</button>
          	  <button type="button" id="tradehid" onclick="tradehid(${carrot.cnum},${carrot.price*0.9},'${carrot.saleuserid }')" style="display: none;"></button>
          	  </c:if>
          	  <c:if test="${carrot.state == 1}">
          	  거래완료	
          	  </c:if>
          </td>
        </tr>
      </c:forEach>
      
    </table>
  </div>
<!---------------아래의 로직은 거래완료를 누르지 않으면 1주일뒤에 자동으로 실행시켜 판매자의 carrotpoint가 쌓이게 만드는 로직---------------------->
<!---------------아래의 로직은 거래완료를 누르지 않으면 1주일뒤에 자동으로 실행시켜 판매자의 carrotpoint가 쌓이게 만드는 로직---------------------->	
<script type="text/javascript">
function simulateOkButtonClick() {
    var okButton = document.getElementById('okButton');
    okButton.click(); // 클릭 동작을 수행
}
document.addEventListener('DOMContentLoaded', function() {
    setTimeout(simulateOkButtonClick, 24 * 60 * 60 * 1000);//1일 뒤 수령하는로직
});
</script>

<script type="text/javascript">
function simulateTradehidClick() {
    var tradehid = document.getElementById('tradehid');
    tradehid.click(); // 클릭 동작을 수행
}
document.addEventListener('DOMContentLoaded', function() {
    setTimeout(simulateTradehidClick, 24 * 60 * 60 * 1000);//1일뒤 거래완료로 바뀜
});
</script>
<!-- 5초로 시험해볼결과 성공적임 객체가 많으면 맨 위에 것부터 순차적으로 5초간격으로 실행됨 -->
</body>
</html>

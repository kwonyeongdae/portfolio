<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<style type="text/css">

    .content,
    .content1,
    .content2,
    .content3 {
      display: none; /* 처음에는 content와 content1 요소를 모두 숨김 */
    }

main{width: fit-content; margin: 0.5em auto; border: 1px black;}
tr{ border: 1px black;}
h1,h3{width: fit-content; margin: 0.5em auto; border-bottom: 3px double black ;}
#aa{width: fit-content; margin: 1em auto; }
th{background-color: #E7E7E7; width: 8em; text-align: center; padding: 0.3em 0.3em;}
td{text-align: center; padding: 0.3em 0.3em;}
table{border-spacing:0; border-collapse:collapse; padding: 200px; border: 1px solid black; margin: 0 auto; }
#div,#bougth{text-align: center; }
#divv{text-align: center; border-top: 1px solid black; border-bottom: 1px solid black; background-color: #E7E7E7; margin: 0 360px; width: 800px;}
#divv::before,
#divv::after {
  content: "";
  display: inline-block;
  vertical-align: middle;
 
  margin: 0 100px; /* 선의 양쪽 여백을 조정하세요 */
}
#divv1{text-align: center; border-top: 1px solid black; border-bottom: 1px solid black; background-color: #E7E7E7; margin: 0 360px; width: 800px; float: left;}
#divv1::before,
#divv1::after {
  content: "";
  display: inline-block;
  vertical-align: middle;
  margin: 0 100px; /* 선의 양쪽 여백을 조정하세요 */
}
#divv2{clear: left;}
#mo button {
  font-size: 15px; /* 원하는 폰트 크기로 조정 */
  width: 100px; /* 원하는 너비로 조정 */
  height: 30px; /* 원하는 높이로 조정 */
  background-color: transparent; color: black; border: 1px solid black;
}

  .container {
  	text-align:center;
    border: 1px solid #ccc;
    background-color: #fff;
    padding: 20px;
    border-radius: 5px;
    width: 100%;
  }


  .tab-content {
    display: none;
    background: #e0e0e0;
    padding: 12px;
  }
  .tab-content.current {
    display: block;
  }
  .tab-content a {
    font-size: 20px; /* 원하는 크기로 조절 (예: 20px) */
  }
 #h3 {
        text-align: center;
        font-size: 36px;
        background-color: #333;
        color: #fff;
        padding: 10px;
        border-radius: 10px;
        margin-top: 20px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        width:80%;
    
    }
 #bougth{
	 width: 50px;
	 height: 30px;
	 text-align: center;
	 display: inline-block;
	 margin: 0 auto;
	 font-size: 15px;
 }
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
	function pointdown() {
	    var selectedPoint = document.querySelector('input[name="point"]:checked');
	    var pointValueInput = document.getElementById('pointValue');
	    
	    var pointType = selectedPoint.value; // 'a' 또는 'b'
	    var pointValue = parseFloat(pointValueInput.value); // 입력한 포인트 값
	    
	
	    var dataToSend = {
	        'carrotpoint': pointType === 'b' ? pointValue : 0,
	        'mileage': pointType === 'a' ? pointValue : 0,
	        'userid': '${userid}'
	    };

	    // 서버로 데이터 전송
	    $.ajax({
	        url: '/fairy/cart/pointdown',
	        method: 'post',
	        data: dataToSend,
	        dataType: 'json',
	        success: function (res) {
	        },
	        error: function (xhr, status, err) {
	            alert(status + "/" + err);
	        }
	    });
	}
</script>
<script type="text/javascript">
function bought() {
    if (!confirm("구매할까요?")) {
        return;
    }
    
    var selectedpayment = document.querySelector('input[name="pay"]:checked');
    var paymentType = selectedpayment.value; 

    var bnumArray = [];
    $('.bname').each(function () {
        bnumArray.push($(this).val());
    });

    var quantityArray = [];
    $('.quantity').each(function () {
        quantityArray.push($(this).val());
    });

    var uid;
    $('.userid').each(function () {
        uid = $(this).val();
    });
    var age;
    $('.age').each(function () {
        age = $(this).val();
    });
    
    
    var bnumAjaxComplete = false;
    var titleyAjaxComplete = false;
   
    if (bnumArray.length !== 0) {
        var data = {
            'bname[]': bnumArray,
            'userid': uid,
            'quantity[]': quantityArray,
            'payment': paymentType,
            'age':age,
        };
        $.ajax({
            url: '/fairy/cart/bought',
            method: 'post',
            data: data,
            dataType: 'json',
            success: function (res) {
                bnumAjaxComplete = true;
                checkBothAjaxComplete();

            },
            error: function (xhr, status, err) {
                alert(status + "/" + err);
            }
        });
    } else {
        bnumAjaxComplete = true;
        checkBothAjaxComplete();
    }

    var titleyArray = [];
    $('.title').each(function () {
        titleyArray.push($(this).val());
    });

    var priceyArray = [];
    $('.price').each(function () {
        priceyArray.push(parseInt($(this).val()));
    });
    
    var cnumArray = [];
    $('.cnum').each(function () {
    	cnumArray.push(parseInt($(this).val()));
    });

    var useridArray = [];
    $('.userid').each(function () {
        useridArray.push($(this).val());
    });

    if (titleyArray.length === 0) {
        titleyAjaxComplete = true;
        checkBothAjaxComplete();
        return;
    }

    var carrot = {
        'title[]': titleyArray,
        'saleuserid[]': useridArray,
        'price[]': priceyArray,
        'cnum[]' : cnumArray,
        'payment': paymentType,
    };

    $.ajax({
        url: '/carrot/odercarrot',
        method: 'post',
        data: carrot,
        dataType: 'json',
        success: function (res) {
            titleyAjaxComplete = true;
            checkBothAjaxComplete();
        },
        error: function (xhr, status, err) {
            alert(status + "/" + err);
        }
    });

    function checkBothAjaxComplete() {
        if (bnumAjaxComplete && titleyAjaxComplete) {
            alert("구매완료(결제시스템미등록)");
            location.href = '/fairy/cart/payment/${userid}';
        }
    }
}


//--------------------------------------------------------------------------------------



	function show_cart(){
		location.href = '/fairy/cart/list';
	}
	
	function deleteItem(bname) {
		  if (!confirm("삭제할까요?")) {
		    return;
		  }
		  $.ajax({
		    url: '/fairy/buy/del',
		    method: 'post',
		    data: {bname:bname},
		    dataType: 'json',
		    success: function(res) {
		      alert(res.remove ? '삭제완료' : '삭제실패');
		      location.href = '/fairy/cart/buy';
		    },
		    error: function(xhr, status, err) {
		      alert(status + "/" + err);
		    }
		  });
		  return false;
		}

	
	function cartdel(cnum) {
		  if (!confirm("삭제할까요?")) {
		    return;
		  }
		  $.ajax({
		    url: '/carrot/carrot/del',
		    method: 'post',
		    data: {cnum:cnum},
		    dataType: 'json',
		    success: function(res) {
		      alert(res.remove ? '삭제완료' : '삭제실패');
		      location.href = '/fairy/cart/buy';
		    },
		    error: function(xhr, status, err) {
		      alert(status + "/" + err);
		    }
		  });
		  return false;
		}
	
	function admin(){
		var realAuthor = '${user.number}';

		var requester = 9;
		if (realAuthor != requester) {
		  alert('관리자만 볼 수 있어요~');
		  return;
		}else{
			location.href = "/admin/";
		}
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

	function mypagego(){
		 var requester='${sessionScope.userid}';
		 if (requester == null || requester.trim().length == 0) 
		     {
			    alert('로그인이 필요한 기능입니다. 먼저 로그인해주세요.');
			    location.href = '/fairy/login';
			   }else{
				  location.href = '/fairy/mypage/${userid}';
			   } 
		}
</script>


<meta charset="utf-8">
<title>결제창</title>
</head>
<body>
<h3 id ="h3"><a href="/book/list/page/1" style ="color: white;">fairy book's</a></h3>
<div class="container">
      
         
         <h1>${user.name}님의 결제창</h1>
<c:choose>
   <c:when test="${empty sessionScope.userid}">
      [<a href="/fairy/login">로그인</a>]
      [<a href="/fairy/joinForm">회원가입</a>]
   </c:when>
   
   <%--07.25 추가 된 부분    book  >>> list.jsp --%>
   <c:when test="${user.number eq 9}" >
	   <div style="margin-left: 10px; ">
	   	  [<a href="javascript:admin();" >관리자페이지</a>]
	   	  [<a href="/fairy/cart/buylist/${userid}"> 구매목록 </a>]
	      [<a href="/carrot/list/page/1">당근마켓</a>]
	      [<a href="/fairy/cart/list">장바구니</a>]
	      [<a href="javascript:mypagego()">마이페이지</a>]
	      [<a href="javascript:logout();">로그아웃</a>]
	   </div>
   </c:when>
   
   
   
   
   <%-- 장바구니 url 추가  --%>
   <c:otherwise>
	   <div style="margin-left: 10px; ">
	      [<a href="/fairy/cart/buylist/${userid}"> 구매목록 </a>]
	      [<a href="/carrot/list/page/1">당근마켓</a>]
	      [<a href="/fairy/cart/list">장바구니</a>]
	      [<a href="javascript:mypagego()">마이페이지</a>]
	      [<a href=javascript:logout();>로그아웃</a>]
	   </div>
   </c:otherwise>
</c:choose>
      
 
   
   </div><br>

<table>
<div id = "div">*상품변경을 원하신다면<button type = "button" onclick="show_cart();">장바구니</button></div><br>


	<tr>
	<th></th>
	<th>상품명</th>
	<th>정가</th>
	<th>합계</th>
	<th>오늘구매시</th>
	</tr>
<c:forEach var="book" items="${sessionScope.selectedBooks}">
    <input type="hidden" class="bname" value="${book.bname}">
    <input type="hidden" class="userid" value="${book.userid}">
    <input type="hidden" class="quantity" value="${book.totalQuantity}">
    <input type="hidden" class="age" value="${user.age}">
    <tr>
        <td><img src="/img/${book.cvrimg}" style="max-width: 100px; max-height: 100px;"></td>
        <td>${book.bname}</td>
        <td><fmt:formatNumber value="${book.totalPrice}"/></td>
        <td>${book.totalQuantity}</td>
        <td>배송시스템<br> 미등록</td>
        <td><button type="button" onclick="deleteItem('${book.bname}')">삭제</button></td>
    </tr>
</c:forEach>
</table>
<table>
<div id="divv" style="font-size: 20px;">
    총 상품금액 :
<c:forEach var="book" items="${sessionScope.selectedBooks}">
  <c:set var="totalAmount" value="${totalAmount + book.totalPrice}" />
</c:forEach>
<fmt:formatNumber value="${totalAmount}"/>원
</div>
	</table><br>
	
<!-------------------------------------여기부턴 carrot관련 -------------------------------------------------->	
<table>

	<tr>
		<th></th>
		<th>중고상품</th>
		<th>가격</th>
		<th>판매자ID</th>
		<th>오늘구매시</th>
	</tr>

	<c:forEach var="carrot" items="${sessionScope.cartbuy}">
	    <tr>
	    <input type="hidden" class="title" value="${carrot.title}">
    	<input type="hidden" class="carrotpoint" value="${carrot.price}">
    	<input type="hidden" class="price" value="${carrot.price}">
    	<input type="hidden" class="userid" value="${carrot.userid}">
    	<input type="hidden" class="cnum" value="${carrot.cnum}">
	        <td><img src="/carrot/${carrot.cvrimg}" style="max-width: 100px; max-height: 100px;"></td>
	        <td>${carrot.title}</td>
	        <td><fmt:formatNumber value="${carrot.price}"/>원</td>
	        <td>${carrot.userid}</td>
	        <td>배송시스템<br> 미등록</td>
	        <td><button type="button" onclick="cartdel('${carrot.cnum}')">삭제</button></td>
	    </tr>
    </c:forEach>
</table>
<!-------------------------------------여기부턴 carrot관련 -------------------------------------------------->		
	
	<table>
	<div id="divv" style="font-size: 20px;">
    총 carrot상품금액 :
<c:forEach var="carrot" items="${sessionScope.cartbuy}">
  <c:set var="totalAmount1" value="${totalAmount1 + carrot.price}" />
</c:forEach>
<fmt:formatNumber value="${totalAmount1}"/>원
    
</div>
</table><br>
	<div style="text-align: center;">
    <label><input type="radio" class="mileage" name="point" value="a"><th>보유한 마일리지-></th><td>${user.mileage}P</td></label>
</div>
<div style="text-align: center;">
    <label><input type="radio" class="carrotpoint" name="point" value="b"><th>판매포인트 -></th><td>${user.carrotpoint}P</td></label>
</div>

<div style="text-align: center;">
    <td><input type="text" id="pointValue" placeholder="사용하실 포인트 값을 입력하세요" style="width: 200px;"></td>
    <td><button onclick="processPayment()">사용</button></td>
</div>
<table>
<div id="divv1" style="font-size: 20px;">
    총 상품 결제할 금액 : <span id="totalAmount2"><fmt:formatNumber value="${totalAmount + totalAmount1}"/>원</span>
    <button type="button" id="bougth" onclick="bought(); pointdown();">결제</button>
</div>

<script>
function processPayment() {
    var selectedPoint = document.querySelector('input[name="point"]:checked');
    var pointValueInput = document.getElementById('pointValue');
    var availablePoints = {
        'a': ${user.mileage},    // 보유 A 포인트 수
        'b': ${user.carrotpoint} // 보유 B 포인트 수
    };

    var totalAmount2 = parseFloat(document.getElementById('totalAmount2').textContent.replace('원', '').replace(',', ''));

    if (selectedPoint && pointValueInput.value !== '') {
        var pointType = selectedPoint.value;
        var pointValue = parseFloat(pointValueInput.value);

        if (isNaN(pointValue)) {
            alert('유효한 숫자를 입력하세요.');
            return;
        }


        if (pointValue > availablePoints[pointType]) {
            alert('보유하신 포인트를 초과해서 입력하셨습니다.');
            return;
        }
        
        var remainingAmount = totalAmount2 - pointValue;
        document.getElementById("divv1").textContent = "총 상품 결제할 금액 : " + remainingAmount.toLocaleString() + "원";
    } else {
        alert('포인트와 값을 모두 입력하세요.');
    }
}
</script>

<div id ="divv2"></div>
    <tr>
    	<div style ="color:red; font-size:5px; text-align: center;">*선택후 결제 진행해 주세요</div><h3>결제방법</h3>
	    <th><input type="radio" class ="payment1" name ="pay" value ='신용카드'>신용카드</button></th>
	    <th><input type="radio" class ="payment2" name ="pay" value ='네이버페이'>네이버페이<img src="/img/ne.jpg" style="max-width: 200px; max-height: 30px;"></button></th>
	    <th><input type="radio" class ="payment3" name ="pay" value ='카카오페이'>카카오페이<img src="/img/kA.jpg" style="max-width: 200px; max-height: 30px;"></button></th>
	    <th><input type="radio" class ="payment4" name ="pay" value ='휴대폰결제'>휴대폰결제</button></th>
    </tr>
    <tr>	
    <td colspan="4" class="content">
    카드사선택 
    &nbsp;&nbsp;&nbsp;&nbsp;<select id = "cate" name = "cate">
    		 <option value="hyundai">현대카드</option>
		     <option value="samsung">삼성카드</option>
		     <option value="woori">우리카드</option>
		     <option value="lotte">롯데카드</option>
		     <option value="kookmin">국민카드</option>
    		 <option value="kakao">카카오뱅크</option>
    		 <option value="bc">BC카드</option>
   			 <option value="bh">NH카드</option>
    	   </select>
    	   <hr>
         결제수단 신용카드 선택시 (간편결제제외)<br><br>

		BC카드 (7/1~7/31)
		무이자할부 2~6개월 / 카드 결제금액 5만원 이상 / Non-BC,법인,기프트카드 제외<br><br>
		
		신한카드 (7/1~7/31)
		무이자할부 2~3개월 / 카드 결제금액 5만원 이상 / 법인,체크,선불,기프트,BC카드 제외<br><br>
	
		현대카드 (7/1~7/31)
		무이자할부 2~3개월 / 카드 결제금액 5만원 이상 / 법인,체크,기프트,선불카드 제외 / 무이자할부 이용시 포인트,마일리지 적립 불가<br><br>
		
		KB국민카드 (7/1~7/31)
		무이자할부 2~3개월 / 카드 결제금액 5만원 이상 / 법인,체크,비씨,선불카드 제외 / 무이자할부 이용시 포인트,마일리지 적립 불가<br><br>
		
		삼성카드 (7/1~7/31)
		무이자할부 2~3개월 / 카드 결제금액 5만원 이상 / 법인,체크,선불,올앳,기프트카드 제외<br><br>
		
		하나카드 (7/1~7/31)
		무이자할부 2~3개월 / 카드 결제금액 5만원 이상 / 법인,체크,선불,기프트,은행계열카드 제외<br><br>
		
		NH농협카드 (7/1~7/31)
		무이자할부 2~4개월 / 카드 결제금액 5만원 이상<br><br>
      </td>
    
    
    </tr>
    <tr>
    <td colspan="4" class="content1">
    네이버페이결제 안내<br><br>
	네이버페이는 네이버ID로 별도 앱 설치 없이 신용카드 또는 은행계좌 정보를 등록하여 네이버페이 비밀번호로 결제할 수 있는 간편결제 서비스입니다.<br><br>
	결제 가능한 신용카드 : 신한, 삼성, 현대, BC, 국민, 하나, 롯데, NH농협, 씨티<br><br>
	결제 가능한 은행 : NH농협, 국민, 신한, 우리, 기업, SC제일, 부산, 경남, 수협, 우체국<br><br>
	네이버페이 카드 간편결제는 네이버페이에서 제공하는 카드사 별 무이자, 청구할인 혜택을 받을 수 있습니다.<br><br>
	주문 변경 시 카드사 혜택 및 할부 적용 여부는 해당 카드사 정책에 따라 변경될 수 있습니다.<br><br>
	네이버페이는 예스24 무이자 할부 및 제휴카드 혜택 내용과 관계가 없으며, 별도의 네이버페이 기준에 따라 적용되니,<br><br>
	네이버페이 결제화면 내 무이자할부 안내를 통해 확인해주시기 바랍니다.<br><br>
	ezen 현대카드 결제시, YES포인트 추가적립 카드혜택은 결제금액의 1%로 적용됩니다. (외부 가맹점)<br><br>
    </td>
    </tr>
	<tr>
    <td colspan="4" class="content2">
	    카카오페이 결제 안내	<br><br>
	카카오톡에서 신용/체크카드 연결하고, 결제도 지문으로 쉽고 편리하게 이용하세요!<br><br>
	본인명의 스마트폰에서 본인명의 카드 등록 후 사용 가능<br><br>
	(카드등록 : 카카오톡 > 더보기 > 카카오페이 > 카드)
	30만원 이상 결제, ARS 추가 인증 필요<br><br>
	이용가능 카드사 : 모든 국내 신용/체크카드
	카카오페이는 무이자할부 및 제휴카드 혜택 내용과 관계가 없으며, 자세한 사항은 카카오페이 공지사항에서 확인하실 수 있습니다.
	ezen 현대카드 결제시, YES포인트 추가적립 카드혜택은 결제금액의 1%로 적용됩니다. (외부 가맹점)<br><br>
    </td>
    </tr>
    <tr>
    <td colspan="4" class="content3">
    	휴대폰결제 안내	<br><br>
		휴대폰 결제를 사용할수 없는 경우 안내<br>
		미성년자 명의의 휴대폰 (단, KT와 LGU+는 가입자가 성인인 경우 가능)
		사업자 폰, 미납상태인 폰, 정액요금제 가입폰, 외국인 폰
		LGU+의 경우 번호이동 및 신규 가입한 경우 가입일로부터 60일 간 월 한도 5만원
		휴대폰 결제 취소는 주문한 달의 말일까지만 가능
		익월 취소시에는 예스24 예치금으로 환불(통신사 정책에 따라 승인취소가 불가능)
		단, 환불시기는 결제 익월 28일 이후<br><br>
		휴대폰 결제시 현금영수증 발급 안내<br>
		휴대폰 요금을 현금으로 납부하는 경우에만 해당 이동통신사에서 발급 가능
		문의 : 이니시스 고객센터 1588-4954<br><br>
		휴대폰 요금 납부 방식에 따라 이동통신사 또는 카드사에서 발급 가능
		문의 : KG모빌리언스 고객센터 : 1800-0678
    </td>
    
    </tr>
    </table>


    
</div>
 <script>
    // jQuery를 사용하여 버튼 클릭 이벤트를 감지합니다.
    $('.payment1').click(function () {
      // 신용카드 버튼 클릭 시, content 클래스를 가진 요소만 보이고 나머지 요소들은 숨깁니다.
      $('.content').show();
      $('.content1, .content2, .content3').hide();
    });

    $('.payment2').click(function () {
      // 네이버페이 버튼 클릭 시, content1 클래스를 가진 요소만 보이고 나머지 요소들은 숨깁니다.
      $('.content1').show();
      $('.content, .content2, .content3').hide();
    });

    $('.payment3').click(function () {
      // 카카오뱅크 버튼 클릭 시, content2 클래스를 가진 요소만 보이고 나머지 요소들은 숨깁니다.
      $('.content2').show();
      $('.content, .content1, .content3').hide();
    });

    $('.payment4').click(function () {
      // 휴대폰결제 버튼 클릭 시, content3 클래스를 가진 요소만 보이고 나머지 요소들은 숨깁니다.
      $('.content3').show();
      $('.content, .content1, .content2').hide();
    });
  </script>
  </main>
</body>
</html>
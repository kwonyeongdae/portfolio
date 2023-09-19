<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
textarea {
    resize: none;
  }
	.revi{
	float: left;
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

  h3 {
        text-align: center;
        font-size: 36px;
        background-color: #333;
        color: #fff;
        padding: 10px;
        border-radius: 10px;
        margin-top: 20px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        width:95%;
    
    }
body {
    font-family: Arial, sans-serif;
    line-height: 1.6;
    margin: 20px;
    padding: 0;
    background-color: #f7f7f7;
}

main {
    max-width: 1000px;
    margin: 0 auto;
    padding: 20px;
    border: 1px solid #ccc;
    border-radius: 5px;
    background-color: #fff;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

h1 {
    margin: 0 auto 20px;
    padding-bottom: 5px;
    border-bottom: 2px solid #444;
    text-align: center;
    font-size: 24px;
    color: #444;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
}
 table th {
    background-color: #f7f7f7;
    width:
  }
  th { width:50px;
  }
  
th, td {

    padding: 10px;
    border: 1px solid #ccc;
    text-align: center;
}

img {
    max-width: 100%;
    display: block;
    margin: 0 auto;
    box-shadow: 0 0 5px rgba(0, 0, 0, 0.2);
}

nav {
    display: flex;
    justify-content: center;
    align-items: center;
    margin-top: 20px;
}

input[type="number"] {
    width: 40px;
    padding: 5px;
    text-align: center;
}

button {
    background-color: #444;
    color: #fff;
    padding: 10px 20px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
    margin: 0 5px;
}

button:hover {
    background-color: #555;
}
.container {
    border: 1px solid #ccc;
    background-color: #fff;
    padding: 20px;
    border-radius: 5px;
    width: 95%;
  }
  ul.tabs {
    margin: 0; /* 위에 태그바  */
    padding: 0;
    list-style: none;
  }
  ul.tabs li {
    display: inline-block;
    background: #898989;
    color: white;
    padding: 10px 15px;
    cursor: pointer;
  }
  ul.tabs li.current {
    background: #e0e0e0;
    color: #222;
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
  
/* 반응형 스타일링 */
@media screen and (max-width: 768px) {
    main {
        padding: 10px;
    }

    h1 {
        font-size: 20px;
    }

    img {
        max-height: 200px;
    }
}
#search {
    margin-top: 20px;
    display: flex;
    align-items: center;
  }
  #search label, #search select, #search input, #search button {
    margin-right: 10px;
  }
  #pagenation {
    margin-top: 20px;
    text-align: center;
  }
  #pagenation a {
    margin: 0 5px;
    padding: 5px 10px;
    border: 1px solid #ccc;
    text-decoration: none;
  }
  #pagenation span {
    margin: 0 5px;
    padding: 5px 10px;
    background-color: #e0e0e0;
    color: #222;
  }
        .floating-wrapper {
       
      position: fixed;
      right: 10px; /* 오른쪽 위치 조정///////  최근본 박스 */
      top: 10px; /* 위쪽 위치 조정 */
      width: 200px; /* 플로팅 요소의 너비 */
      padding: 10px; /* 내부 여백 */
      background-color: #f1f1f1; /* 배경색 */
      border: 1px solid #ddd; /* 테두리 스타일 */
      border-radius: 5px; /* 테두리 둥글게 */
    }

    .floating-wrapper .item {
      margin-bottom: 10px; /* 각 요소 사이의 간격 */
    }

    .floating-wrapper .item img {
   max-width: 50%;
  max-height: 100px; /* 이미지의 최대 높이를 150px로 조정 */
  object-fit: contain; /* 이미지가 비율을 유지하면서 컨테이너에 맞게 조정되도록 함 */
    }
    #item{float: left;}
    #item2{clear: left;}
  	.tr_qna {
    width: 200px; margin: 0 auto; 
  }
  .review-summary {
    margin-bottom: 20px;
}

.review-summary h4,
.review-summary button {
    margin-bottom: 10px;
}

.recent-review {
    margin-bottom: 20px;
}

.review-item {
    margin-bottom: 10px;
}

.review-item input {
    width: 50px;
    text-align: center;
}

.review-content {
    width: 100%;
    padding: 10px;
}

.review-form {
    margin-bottom: 10px;
}

.review-form select {
    width: 80px;
}
    
    
</style>
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
$(document).ready(function(){
	  $('ul.tabs li').click(function(){
	    var tab_id = $(this).attr('data-tab');
	    $('ul.tabs li').removeClass('current');
	    $('.tab-content').removeClass('current');
	    $(this).addClass('current');
	    $("#" + tab_id).addClass('current');
	  });
	});

$(document).ready(function() {
     // 데이터 가져오기
     var storedValues = JSON.parse(localStorage.getItem("myValues")) || [];
     var bname = "${book[0].bname}";
    var image = "/img/${book[0].cvrimg}";
     var bnum = "${book[0].bnum}";
   

       
     // 데이터가 4개 이상일때만 가장 오래된 데이터를 삭제 
     if (storedValues.length >4) {
        
        storedValues.shift();
       
     }
     
     storedValues = storedValues.filter(function(value) {
          return value.bname !== bname;
        });
     var newdata= {
           bname: bname,
           image: image,
           bnum: bnum
     };
     
     
     storedValues.push(newdata);
     localStorage.setItem("myValues", JSON.stringify(storedValues));
      });//새로운 데이터 추가 

      
function add_cart(bnum)
{	
    	  var usernum = '${user.number}';
    	  var setnum = 5;
    	  if(usernum==setnum){
    		  alert("휴먼계정을 먼저 해체하세요");
    		  location.href = "/fairy/";
    		  return;
    	  }
    	  
	var obj = {};
	obj.bnum = bnum;
	obj.bname = $('#bname').val();
	obj.quantity = $('#quantity').val();
	obj.userid = '${sessionScope.userid}';
	if(!confirm("장바구니에 추가합니까?")){
		return false;
	}
	
	$.ajax(
			{
				url:'/fairy/cart/add/'+bnum,
				method:'post',
				data: obj,
				cache:false,
				dataType:'json',
				success:function(res) {
					if (res.added) {
						alert('장바구니에 담았습니다');
					} 
				},
				error:function(xhr,status,err){
					alert(status + "/" + err);
				}
			}		
		);
	
}
</script>
<script type="text/javascript">
function addreview()
{
	 var formdata = {
		        "bnum": $("#bnum").val(),
		        "bname": $("#bname").val(),
		        "userid": $("#userid").val(),
		        "score": parseInt($("#score").val()),
		        "reviewcontents": $("#reviewcontents").val()
		    };
	
		    
		    
	if(!confirm("리뷰를 작성할까요?")){return false;}
	$.ajax({
		url:'/book/book/review',
		method:'post',
		data :  JSON.stringify(formdata),
		cache: false,
		dataType:'json',
		contentType: 'application/json',
		success: function(res){
			alert(res.added ? "리뷰 작성 완료" : "리뷰 작성 실패");
			location.reload();
		},
		error: function(xhr,status,err){
			alert("에러"+err);
		}
		
		
	});
	
	return false;
	
	
}



</script>
<script type="text/javascript">
function show_cart(){
	location.href = '/fairy/cart/list';
}

function qnaadd(){
	if(!confirm('Q&A등록할까요?')) return;
	
	var obj = {};
		obj.qnum = '${book[0].bnum}';
		obj.userid = $('#userid').val();
		obj.qcontent =	$('#qcontent').val();

	  	
	$.ajax(
			{
				url:'/book/addqna',
				method:'post',
				data: obj,
				cache:false,
				dataType:'json',
				success:function(res) {
					if (res.qna) {
						alert('등록 되었습니다.');
						location.reload();
					}
				},
				error:function(xhr,status,err){
					alert(status + "/" + err);
				}
			}		
		);
	return false;
}
</script>
<script type="text/javascript">
	if (storedValues.length >4) {
		  
		  storedValues.shift();
		 
	}
	
	storedValues = storedValues.filter(function(value) {
		    return value.bname !== bname;
		  });
	var newdata= {
			  bname: bname,
			  image: image,
			  bnum: bnum
	};


	storedValues.push(newdata);
	localStorage.setItem("myValues", JSON.stringify(storedValues));
		});//새로운 데이터 추가 
	

	
	$(document).ready(function() {
		  var storedValues = JSON.parse(localStorage.getItem("myValues")) || [];
		  var $cookieValueWrapper = $("#cookieValueWrapper");
		  $cookieValueWrapper.empty();
			
		  console.log(storedValues);
		  
		  for (var i = storedValues.length - 1; i >= 0; i--) {
		    var value = storedValues[i];
		    var $itemWrapper = $("<div>").addClass("item");
		    var $valueElement = $("<div>").text(value.bname);
		    var $imageElement = $("<img>").attr("src", value.image);
		    var $linkElement = $("<a>").attr("href","/fairy/book/"+value.bnum);
		    

		    $linkElement.append($valueElement);
		    $linkElement.append($imageElement);
		    $itemWrapper.append($linkElement);
		    
		    $cookieValueWrapper.append($itemWrapper);
		    
		   // $cookieValueWrapper.append($valueElement);
		//    $cookieValueWrapper.append($imageElement);
		    
		  //  $cookieValueWrapper.append($itemWrapper);
		  }
		  
		  
		  
		  
		  
		});
	
</script>
<script type="text/javascript">
$(document).ready(function() {
    $('#qnaToggle').click(function() {
        console.log("Q&A 테이블 토글");
        $('#QnA').toggle(); // #QnA 테이블의 표시/감춤을 토글
    });
});

function reviewlist()
{
	   location.href="/book/book/reviewlist/${book[0].bnum}/1"
}


</script>
<script type="text/javascript">
function logout(){
   if(!confirm('로그아웃할까요?')) return;
   
   $.ajax({
      url:'/fairy/logout',
      method:'get',
      cache:false,
      dataType:'json',
      success:function(res){
         alert(res.logout ? '로그아웃 되었습니다.\n다음에 또 만나요~^^':'로그아웃 실패\n관리자에게 문의 바랍니다.'); 
         if(res.logout) location.href="/book/list/page/1";
      },
      error:function(xhr,status,err){
         alert('에러:'+err);
      }
   });
   
}
</script>
<script type="text/javascript">
  function qnacomment(num) {
    if (!confirm('답글을 등록할까요?')) return;

    var obj = {};
    obj.qnum = num;
    obj.name = '관리자'; // 관리자로 하드코딩되었습니다. 원하는 값을 넣어주세요.
    obj.qcomment = $('#qcomment'+num).val();

    $.ajax({
      url: '/book/qnacomment',
      method: 'post',
      data: obj,
      cache: false,
      dataType: 'json',
      success: function(res) {
        if (res.qnacomment) {
          alert('등록 되었습니다.');
          location.reload();
        }
      },
      error: function(xhr, status, err) {
        alert(status + "/" + err);
      }
    });
  }
</script>
<meta charset="utf-8">
<title>도서 정보 목록</title>
</head>
<body>

<main>
<h3 id ="h3"><a href="/book/list/page/1" style ="color: white;">fairy book's</a></h3>

	<div class="container">
		<ul class="tabs">

				<li class="tab-link current" data-tab="tab-1">로그인 </li>

				<li class="tab-link" data-tab="tab-2">Q&A</li>

			</ul>
		
		<div id="tab-1" class="tab-content current">
			 <h2>
		
			 <c:choose>
		<c:when test="${sessionScope.isAdmin eq 9}">
			관리자님 어서오세요^^
		</c:when>
		<c:otherwise>
			${user.name}님 어서오세요 ^^
		</c:otherwise>
	</c:choose>
</h2>
<c:choose>
	<c:when test="${empty sessionScope.userid}">
		[<a href="/fairy/login">로그인</a>]
		[<a href="/fairy/adminLogin">관리자 로그인</a>]
		[<a href="/fairy/joinForm">회원가입</a>]
	</c:when>
	<c:when test="${user.number eq 9}">
		[<a href="/admin/list">매출관리</a>]
		[<a href="/admin/adbooklist/1" > 상품관리 </a>]
		[<a href="/fairy/cart/list" style="text-decoration:none;">장바구니</a>]
		[<a href="/fairy/memlist">회원 목록</a>]
		[<a href="javascript:logout();">로그아웃</a>]
	</c:when>
	<c:otherwise>
		[<a href="/fairy/cart/buylist/${userid}"> 구매목록 </a>]
		[<a href=javascript:logout();>로그아웃</a>]
		[<a href="/fairy/editMem/${userid}"> 회원정보 수정</a>]
	</c:otherwise>
</c:choose>
		</div>
		
		<div id="tab-2" class="tab-content">
			
		</div>
	
	</div>


<h1>도서 정보</h1>
<table>
<input type="hidden" id ="bname" name="bname" value ="${book[0].bname}">
	<h2 style="text-align: center;">${book[0].bname}</h2>
	<div id = "item" ><img src="/img/${book[0].cvrimg}"></div>
	<br><br>
	
	<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>출판사 &nbsp; : &nbsp; ${book[0].publisher}</strong></div>
	<br>
	<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>저자 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : &nbsp; ${book[0].author}</strong></div>
	<br>
	<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>가격 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : &nbsp;&nbsp;<fmt:formatNumber value="${book[0].price}"/>원</strong></div>
	<br>
	<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>출판일 &nbsp; : &nbsp; ${book[0].pdate}</strong></div>
	<br>
	<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<strong>수량 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : &nbsp;</strong> 
	<input type="number" id = "quantity" value="1" min="1" max="100" style="width: 40px;">
	<button type = "button" onclick="add_cart(${book[0].bnum});">장바구니 추가</button>
	<button type = "button" onclick="show_cart();">장바구니 보기</button></div>
	<br>
</table>	
<!------------------------------------------------ 이부분부터 리뷰와 Q&A가 시작됨 --------------------------------------------------->
<!------------------------------------------------ 이부분부터 리뷰와 Q&A가 시작됨 --------------------------------------------------->
<div style="text-align: center; font-size: 30px;">최근 리뷰</div>
<hr>

<div class="recent-review">
    <c:choose>
        <c:when test="${empty review}">
            <p>아직 등록된 리뷰가 없습니다.</p>
        </c:when>
        <c:otherwise>
            <c:forEach var="re" items="${review}" begin="0" end="1">
                <div class="review-item">
                    <label>아이디: </label>
                    <input type="text" class="userid" name="userid" value="${re.userid}" readonly>
                    <label>평점: </label>
                    <input type="text" class="score" name="score" value="${re.score}" readonly>
                </div>
                <label>사용평: </label>
                <div class="review-content" cols="54" rows="10" readonly>${re.reviewcontents}</div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>

<div class="review-summary">
    <h4>평점은 5점 만점입니다.</h4>
    <a href="/book/book/reviewlist/${book[0].bnum}/1">
        <button type="button">전체 리뷰 보기</button>
    </a>
    <h4>평균 평점: ${score}</h4>
</div>

<hr>

<c:choose>
    <c:when test="${empty sessionScope.userid}">
        <!-- Display login or registration message if the user is not logged in -->
        <p>리뷰를 작성하려면 로그인이 필요합니다.</p>
        <p>로그인 또는 회원가입을 해주세요.</p>
    </c:when>
    <c:otherwise>
        <h4>리뷰 작성</h4>
        <form id="rev" onsubmit="return addreview()">
            <div class="review-form">
                <input type="hidden" id="bnum" name="bnum" value="${book[0].bnum}">
                <input type="hidden" id="bname" name="bname" value="${book[0].bname}">
                <input type="hidden" id="userid" name="userid" value="${sessionScope.userid}">

                <label>평점: </label>
                <select id="score" name="score">
                    <option value="">평점 선택</option>
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                </select>
            </div>
            <label>사용평: </label>
            <textarea class="review-contents" cols="80" rows="10" id="reviewcontents" name="reviewcontents" ></textarea>
            <input type="submit">
        </form>
    </c:otherwise>
</c:choose>

<div style="text-align: center; font-size: 30px;"><a id="qnaToggle" href="javascript:void(0);" >Q&A</a></div><hr>

<form id = "QnA" style="display: none;">
        <c:forEach var="qna" items="${qnalist}">

       <table id = "tr_qna" style="width: 500px; margin: 0 auto;">
       <input type="hidden" id="qnum" name="qnum" value="${qna.qnum}">
  <tr >
    <th>${qna.userid}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${qna.qcontent}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${qna.qnadate}</th>
  </tr>
 <c:forEach var="qnacom" items="${qnacom}">
 <c:if test="${qna.num == qnacom.qnum}">
      <tr>
      <td>${qnacom.name}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      	  ${qnacom.qcomment}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
      	  ${qnacom.comdate}</td> 
	  </tr>
	  </c:if>
 </c:forEach>
 
  <c:if test="${user.number == 9}">
      <div>  
      <form class="comment-form" >
	    <input type="hidden" id="qnum" name="qnum" value="${qna.num}">
	    <div>
	      <input type="text" id="qcomment${qna.num}" name="qcomment" style="width: 500px; padding: 8px;">
	      <button type="button" onclick="qnacomment(${qna.num})">등록</button>
	    </div>
	  </form>
	  </div>
	  </c:if>
</table>

        </c:forEach>
  <br>
  
	<form id = "QnAadd">
	<c:if test="${user.number == 0}">
	<input type="hidden" id="userid" name ="userid" value="${sessionScope.userid}">
	<input type="text" id="qcontent" name ="qcontent" style="width: 500px; padding: 8px;">
	<button type="button" onclick="javascript:qnaadd()">등록</button>
	</c:if>
	</form>
</form>
<!------------------------------------------------ 이부분부터 리뷰와 Q&A가 끝남 --------------------------------------------------->
<!------------------------------------------------ 이부분부터 리뷰와 Q&A가 끝남 --------------------------------------------------->
	
	<div id = "item2"></div><hr>
	
	
	<div style="text-align: center; font-size: 30px;">책 소개</div><hr>
	<div style="width: 80%; text-align: center; margin: 0 auto;"><c:if test="${book[0].contentimg!=null}"><img src="/img/${book[0].contentimg}"></c:if>
	${book[0].content}</div><hr>


<div class="floating-wrapper" >
	 <div class="title">[최근본 상품]</div>
		 <div id="cookieValueWrapper">
	 
		 </div>
	 </div>


<!------------------------------------------------ 이부분부터 택배관련 --------------------------------------------------->
<!------------------------------------------------ 이부분부터 택배관련 --------------------------------------------------->
<div style="font-size: 23px; "><strong>교환/반품/품절 안내</strong></div><hr><br>
<div style="font-size: 18px; ">반품/교환방법</div><br>
<div>
마이룸 > 주문관리 > 주문/배송내역 > 주문조회 > 반품/교환 신청, [1:1 상담 > 반품/교환/환불] 또는 고객센터 (1544-0000)
* 오픈마켓, 해외배송 주문, 기프트 주문시 [1:1 상담>반품/교환/환불] 또는 고객센터 (1544-0000)</div><hr>

<div style="font-size: 18px; ">반품/교환가능 기간</div><br>
<div>
변심반품의 경우 수령 후 7일 이내,
상품의 결함 및 계약내용과 다를 경우 문제점 발견 후 30일 이내</div><hr>

<div style="font-size: 18px; ">반품/교환비용</div><br>
<div>
변심 혹은 구매착오로 인한 반품/교환은 반송료 고객 부담</div><hr>

<div style="font-size: 18px; ">반품/교환 불가 사유</div><br>
<div>
1) 소비자의 책임 있는 사유로 상품 등이 손실 또는 훼손된 경우<br>
(단지 확인을 위한 포장 훼손은 제외)<br>
2) 소비자의 사용, 포장 개봉에 의해 상품 등의 가치가 현저히 감소한 경우<br>
예) 화장품, 식품, 가전제품(악세서리 포함) 등<br>
3) 복제가 가능한 상품 등의 포장을 훼손한 경우<br>
예) 음반/DVD/비디오, 소프트웨어, 만화책, 잡지, 영상 화보집<br>
4) 소비자의 요청에 따라 개별적으로 주문 제작되는 상품의 경우 ((1)해외주문도서)<br>
5) 디지털 컨텐츠인 eBook, 오디오북 등을 1회 이상 다운로드를 받았을 경우<br>
6) 시간의 경과에 의해 재판매가 곤란한 정도로 가치가 현저히 감소한 경우<br>
7) 전자상거래 등에서의 소비자보호에 관한 법률이 정하는 소비자 청약철회 제한 내용에 해당되는 경우</div><hr>

<div style="font-size: 18px; ">상품 품절</div><br>
<div>
공급사(출판사) 재고 사정에 의해 품절/지연될 수 있으며, 품절 시 관련 사항에 대해서는 이메일과 문자로 안내드리겠습니다.</div><hr>

</main>
</body>
</html>
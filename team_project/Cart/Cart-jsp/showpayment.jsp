<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<style>
   h1{text-align: center;}
   h3{text-align: center;}
   table {
        border-collapse: collapse;
        width: 100%;
        border: 1px solid #ddd;
        font-family: Arial, sans-serif;
    }

    th, td {
        padding: 12px 15px;
    }

    th {
        background-color: #f2f2f2;
    }

    tr:nth-child(even) {
        background-color: #f2f2f2;
    }

    .details {
        font-size: 14px;
    }
</style>
<meta charset="utf-8">
<title>최종결제창</title>
</head>
<body>
<h1>결제내역</h1><hr>
<table>
<h3>상품결제 내역</h3>
    <c:forEach var="pay" items="${payment}">
        <tr>
            <th>도서명</th><td>${pay.bname}</td>
        </tr>
        <tr>
            <th>수량</th><td>${pay.quantity}</td>
        </tr>
        <tr>
            <th>가격</th><td><fmt:formatNumber value="${pay.price}"/>원</td>
        </tr>
        <tr>
            <th>구매자</th><td>${user.name}</td>
        </tr>
        <tr>
            <th>주소</th><td>${user.contact_address}&nbsp;${user.detailed_address}</td>
        </tr>
        <tr>
            <th>배송</th><td>준비중</td>
        </tr>
        <tr>
            <th>결제수단</th><td>${pay.payment}</td>
        </tr>
    </c:forEach>
</table>

<table>
<h3>carrot결제 내역</h3>
    <c:forEach var="car" items="${paycarrot}">
        <tr>
            <th>도서명</th><td>${car.title}</td>
        </tr>
        <tr>
            <th>판매자</th><td>${car.saleuserid}</td>
        </tr>
        <tr>
            <th>가격</th><td><fmt:formatNumber value="${car.price}"/>원</td>
        </tr>
        <tr>
            <th>구매자</th><td>${user.name}</td>
        </tr>
        <tr>
            <th>주소</th><td>${user.contact_address}&nbsp;${user.detailed_address}</td>
        </tr>
        <tr>
            <th>배송</th><td>준비중</td>
        </tr>
        <tr>
            <th>결제수단</th><td>${car.payment}</td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
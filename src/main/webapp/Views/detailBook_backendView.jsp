<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Thông tin chi tiết sách</title>
</head>
<body>
	<jsp:include page="_header_backend.jsp"></jsp:include>
	<jsp:include page="_menu_backend.jsp"></jsp:include>
	<div align="center">
		<h3>Thông tin chi tiết cuốn sách</h3>
		<p style="color: red">${errors }</p>
		<c:if test="${not empty book }">
			<form id="detailBookForm" action="cartBook/addToCart" method="post">
				<input type="hidden" name="bookId" value="${book.bookId }">
				<table style="width: 30%;" border="1">
					<tr>
						<td width="25%">Tiêu đề</td>
						<td>${book.title}</td>
					</tr>
					<tr>
						<td>Tác giả</td>
						<td>${book.author}</td>
					</tr>
					<tr>
						<td>Giá tiền</td>
						<td><fmt:formatNumber type="number" value="${book.price }" /><sup>đ</sup></td>
					</tr>
					<tr>
						<td>Số lượng có sẵn</td>
						<td>${book.quantityInStock}</td>
					</tr>
					<tr>
						<td colspan="2">
							<div
								style="text-align: justify; text-justify: inner-word; margin: 5px;display: flex;">
								<div>
									<img style=" margin-right: 5px" alt="Book Image"
										src="${book.imagePath}" width="150">
								</div>
								${book.detail }
							</div>
						</td>
					<tr>
				</table>
			</form>
		</c:if>
	</div>
</body>
</html>
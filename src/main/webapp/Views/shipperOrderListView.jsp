<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="vnua.fita.bookstore.util.Constant"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/css/bookstore_style.css">
<title>Trang chủ phía admin</title>
</head>
<body>
	<table border="1">
		<tr>
			<th>Mã hóa đơn</th>
			<th>Tên khách</th>
			<th>Số điện thoại</th>
			<th>Ngày đặt mua</th>
			<th>Ngày xác nhận</th>
			<th>Địa chỉ nhận sách</th>
			<th>Phương thức thanh toán</th>
			<th>Trạng thái đơn hàng</th>
			<th>Thao tác</th>
		</tr>
		<tbody>
			<c:forEach items="${orderListOfCustomer }" var="orderOfCustomer">
				<tr>
					<td>${orderOfCustomer.orderNo}</td>
					<td>${orderOfCustomer.customer.fullname}</td>
					<td>${orderOfCustomer.customer.mobile}</td>
					<td><fmt:formatDate value="${orderOfCustomer.orderDate }"
							pattern="dd-MM-yyyy HH:mm" /></td>
					<td><fmt:formatDate
							value="${orderOfCustomer.orderApproveDate }"
							pattern="dd-MM-yyyy HH:mm" /></td>
					<td>${orderOfCustomer.deliveryAddress }</td>
					<td>${orderOfCustomer.deliveryAddress}</td>
					<td>${orderOfCustomer.paymentModeDescription}<c:if
							test="${orderOfCustomer.paymentMode eq Constant.TRANSFER_PAYMENT_MODE}">
							<br />
							<button
								onclick="document.getElementById('divImg${orderOfCustomer.orderId}').style.display='block'">Xem
								chi tiết</button>
							<button
								onclick="document.getElementById('divImg${orderOfCustomer.orderId}').style.display='none'">Ẩn</button>
							<div id="divImg${orderOfCustomer.orderId}"
								style="display: none; padding-top: 5px;">
								<img alt="Transfer Image"
									src="${orderOfCustomer.paymentImagePath}" width="150" />
							</div>
						</c:if>
					</td>
					<td>${orderOfCustomer.orderStatusDescription}<c:if
							test="${Constant.WAITING_CONFIRM_ORDER_STATUS ne orderOfCustomer.orderStatus}">
            &nbsp;-&nbsp;${orderOfCustomer.paymentStatusDescription}
        </c:if>
					</td>
					<td>
						<button
							onclick="document.getElementById('div${orderOfCustomer.orderId}').style.display='block'">Xem
							chi tiết</button>
						<button
							onclick="document.getElementById('div${orderOfCustomer.orderId}').style.display='none'">Ẩn</button>
						<div id="div${orderOfCustomer.orderId}" style="display: none;">
							<h3>Các cuốn sách trong hóa đơn</h3>
							<table border="1">
								<tr style="background: yellow;">
									<th>Tiêu đề</th>
									<th>Tác giả</th>
									<th>Giá tiền</th>
									<th>Số lượng mua</th>
									<th>Tổng thành phần</th>
								</tr>
								<c:forEach items="${orderOfCustomer.orderBookList}"
									var="cartItem">
									<tr>
										<td>${cartItem.selectedBook.title}</td>
										<td>${cartItem.selectedBook.author}</td>
										<td>${cartItem.selectedBook.price}<sup>đ</sup></td>
										<td>${cartItem.quantity}</td>
										<td>${cartItem.selectedBook.price * cartItem.quantity}<sup>đ</sup></td>
									</tr>
								</c:forEach>
							</table>
							<br />Tổng số tiền: <b>${orderOfCustomer.totalCost}<sup>đ</sup></b>
							<c:if
								test="${Constant.WAITING_CONFIRM_ORDER_STATUS eq orderOfCustomer.orderStatus}">
                &nbsp;&nbsp;&nbsp;&nbsp;
                <button
									onclick="onClickAdminOrderConfirm(${orderOfCustomer.orderId},${Constant.DELEVERING_ORDER_STATUS},'${Constant.WAITING_APPROVE_ACTION}')">Xác
									nhận đơn</button>
							</c:if>
							<c:if
								test="${Constant.DELEVERING_ORDER_STATUS eq orderOfCustomer.orderStatus}">
								<br />
								<br />
								<img alt="" src="" id="bookImage${orderOfCustomer.orderId}"
									width="150">&nbsp;
                <input type="file" name="file" accept="image/*"
									onchange="loadImageFailure(event,'bookImage${orderOfCustomer.orderId}')" />
								<br />
								<button
									onclick="onClickAdminOrderConfirm(${orderOfCustomer.orderId},${Constant.DELEVERED_ORDER_STATUS},'${Constant.DELEVERING_ACTION}')">Xác
									nhận đã giao đơn hàng</button>
								<button
									onclick="onClickAdminOrderConfirm(${orderOfCustomer.orderId},${Constant.FAILURE_ORDER_STATUS},'${Constant.FAILURE_ACTION}')">Xác
									nhận khách trả hàng</button>
							</c:if>
							<c:if
								test="${Constant.FAILURE_ORDER_STATUS eq orderOfCustomer.orderStatus}">
                &nbsp;&nbsp;&nbsp;&nbsp;
                <img src="${orderOfCustomer.failureImagePath}"
									width="150" height="150" />
							</c:if>
							<c:if
								test="${Constant.DELEVERED_ORDER_STATUS eq orderOfCustomer.orderStatus}">
                &nbsp;&nbsp;&nbsp;&nbsp;
                <img src="${orderOfCustomer.failureImagePath}"
									width="150" height="150" />
							</c:if>
						</div>
					</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</body>
</html>
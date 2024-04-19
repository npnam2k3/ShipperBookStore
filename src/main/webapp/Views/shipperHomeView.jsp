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
	<div>
		<jsp:include page="_header_shipper.jsp"></jsp:include>
		<jsp:include page="_menu_shipper.jsp"></jsp:include>
		<div align="center">
			<h3>DANH SÁCH ĐƠN HÀNG ${listType }</h3>

			<input type="text" name="keyword" id="keyword" value="${keyword }"
				placeholder="Tìm mã hóa đơn" onkeyup="searchOrder(this)" />

			<form id="shipperOrderForm" method="POST" action=""
				enctype="multipart/form-data">
				<input type="hidden" name="orderId" id="orderIdOfAction" /> <input
					type="hidden" name="confirmType" id="confirmTypeOfAction" /> <input
					type="file" name="file" id="fileImage" hidden />
			</form>
			<p style="color: red;">${errors }</p>
			<p style="color: blue;">${message }</p>
			<div  id="data-container">
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
			</div>
		</div>
	<jsp:include page="_footer.jsp"></jsp:include>
	</div>
	<script type="text/javascript">
	console.log("Load")
	function onClickAdminOrderConfirm(orderId, confirmType, action) {
	    var form = document.getElementById("shipperOrderForm");
	    
	    // Gán giá trị orderId và confirmType vào các input hidden trong form
	    document.getElementById("orderIdOfAction").value = orderId;
	    document.getElementById("confirmTypeOfAction").value = confirmType;
	    
	    // Lấy ra input chứa file
	    var fileInput = document.getElementById("fileImage");
	    
	    // Kiểm tra xem có file đã được chọn chưa
	    if (fileInput.files.length > 0) {
	        // Gán file đã chọn vào form
	        form.append("file", fileInput.files[0]);
	    }
	    
	    // Gán giá trị action cho form
	    form.action = action;
	    
	    // Gửi form đi
	    form.submit();
	}

	function loadImageFailure(event,id) {
	    let output = document.getElementById(id);
	    output.src = URL.createObjectURL(event.target.files[0]);
	    output.onload = function() {
	        URL.revokeObjectURL(output.src)
	    }
	    document.getElementById("fileImage").files = event.target.files;
	}
	
	var request;
	function getInfoTable() {
		if (request.readyState == 4) {
			var val = request.responseText;
			document.getElementById('data-container').innerHTML = val;
		}
	}
	
	function searchOrder(element) {
	    let keyword = element.value; // Chuyển đổi keyword thành chữ thường để so sánh không phân biệt hoa thường
	    const pathname=window.location.pathname;
	    let urlArray = pathname.split('/');
	    urlArray.splice(2, 0, "search");

		var url = urlArray.join('/')+"?keyword=" + keyword;  
		
        // Thay đổi URL mà không tải lại trang
        if (window.XMLHttpRequest) {
			request = new XMLHttpRequest();
		} else if (window.ActiveXObject) {
			request = new ActiveXObject("Microsoft.XMLHTTP");
		}
		try {
			request.onreadystatechange = getInfoTable;
			request.open("GET", url, true);
			request.send();
		} catch (e) {
			alert("Unable to connect to server");
		}
	}
	
	</script>
</body>
</html>
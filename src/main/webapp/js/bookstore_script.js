var request;
function activeAsLink(link) {
	window.location = link;
}

function plusValue(elementId, maxQuantity) {
	let quantity = parseInt(document.getElementById(elementId).value);
	if (quantity + 1 <= maxQuantity) {
		document.getElementById(elementId).value = quantity + 1;
	} else {
		alert('Giá trị không được vượt quá: ' + maxQuantity);
	}
}

function minusValue(elementId) {
	let quantity = parseInt(document.getElementById(elementId).value);
	if (quantity - 1 >= 1) {
		document.getElementById(elementId).value = quantity - 1;
	}
}

function validateValue(element, maxQuantity) {
	if (element.value > maxQuantity) {
		alert('Giá trị không được vượt quá: ' + maxQuantity);
	}
	if (element.value <= 0) {
		alert('Giá trị không được âm');
	}
}

function checkQuantityAndSubmit(elementId, bookId, maxQuantity) {
	let quantity = parseInt(document.getElementById(elementId).value);
	if (quantity <= 0) {
		alert('Nhập số lượng!');
		return;
	} else if (quantity > maxQuantity) {
		alert('Giá trị không được vượt quá: ' + maxQuantity);
		return;
	} else {
		document.getElementById("detailBookForm").submit();
	}
}

function updateQuantityOfCartItem(newQuantity, bookId) {
	//url nay se goi den servlet hien tai(CartServlet) voi tham so kem theo
	var url = 'addToCart?bookId=' + bookId + '&quantityPurchased=' + newQuantity;
	if (window.XMLHttpRequest) {
		request = new XMLHttpRequest();
	} else if (window.ActiveXObject) {
		request = new ActiveXObject("Microsoft.XMLHTTP")
	}
	try {
		request.onreadystatechange = getInfo;
		request.open("GET", url, true);
		request.send();
	} catch (e) {
		alert("Unable to connect to server");
	}
}

function getInfo() {
	if (request.readyState == 4) {
		var val = request.responseText;
	}
}

//ham dc goi ung voi su kien onchange, khi so luong mua thay doi
function validateValueAndUpdateCart(element, maxQuantity, bookId, price) {
	var newQuantity = element.value;
	if (newQuantity > maxQuantity) {
		alert('Giá trị không được vượt quá ' + maxQuantity);
	} else if (newQuantity > 0) {
		//ajax gửi request đến server để update cart
		updateQuantityOfCartItem(newQuantity, bookId);

		//update subtotal
		document.getElementById("subtotal" + bookId).innerText = toComma(newQuantity * price);
		let subtotalList = document.querySelectorAll('[id^="subtotal"]');
		let total = 0;
		for (let i = 0; i < subtotalList.length; i++) {
			total += parseInt(subtotalList[i].innerText.replace(/,/g, ""));
		}
		document.getElementById("total").innerText = toComma(total);
	}
}

//định dạng số tiền: phân cách hàng nghìn bởi dấu phẩy
function toComma(n) {
	return n.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function minusValueAndUpdateCart(elementId) {
	var quantity = parseInt(document.getElementById(elementId).value);
	if (quantity - 1 >= 1) {
		document.getElementById(elementId).value = quantity - 1;
		//hàm validate được gọi ứng với sự kiện onchange
		document.getElementById(elementId).onchange();
	}
}

function plusValueAndUpdateCart(elementId, maxQuantity) {
	var quantity = parseInt(document.getElementById(elementId).value);
	if (quantity + 1 <= maxQuantity) {
		document.getElementById(elementId).value = quantity + 1;
		//hàm validate được gọi ứng với sự kiện onchange
		document.getElementById(elementId).onchange();
	} else {
		alert('Giá trị không được vượt quá ' + maxQuantity);
	}
}

function onClickRemoveBook(bookTitle, bookId) {
	let c = confirm('Bạn chắc chắn muốn xóa cuốn sách ' + bookTitle + ' khỏi giỏ hàng');
	if (c) {
		document.getElementById("removedBookFromCart").value = bookId;
		document.getElementById("removedBookFromCartForm").submit();
	}
}

function loadImage(event) {
	let output = document.getElementById('bookImage');
	output.src = URL.createObjectURL(event.target.files[0]);
	output.onload = function() {
		URL.revokeObjectURL(output.src)
	}
}
function onClickDeleteBook(bookTitle, bookId) {
	let c = confirm('Bạn chắc chắn muốn xóa cuốn sách ' + bookTitle + '?');
	if (c) {
		document.getElementById("deleteBookFromAdmin").value = bookId;
		document.getElementById("deleteBookFromAdminForm").submit();
	}
}
function onClickAdminOrderConfirm(orderId,confirmType,action){
	document.getElementById("orderIdOfAction").value=orderId;
	document.getElementById("confirmTypeOfAction").value=confirmType;
	document.getElementById("adminOrderForm").action=action.substring(0);
	document.getElementById("adminOrderForm").submit();
}

var header = document.getElementById("myDIV");
var btns = header.getElementsByClassName("item");
for (var i = 0; i < btns.length; i++) {
  btns[i].addEventListener("click", function() {
  var current = document.getElementsByClassName("active");
  current[0].className = current[0].className.replace(" active", "");
  this.className += " active";
  });
}

	function getInfoTable() {
		if (request.readyState == 4) {
			var val = request.responseText;
			document.getElementById('data-container').innerHTML = val;
		}
	}
	
	function searchOrder(element) {
	    let keyword = element.value; // Chuyển đổi keyword thành chữ thường để so sánh không phân biệt hoa thường
		var url = window.location.pathname + '?keyword=' + keyword;
	    console.log("url: ",url)
        
        // Thay đổi URL mà không tải lại trang
        history.pushState({}, '', url);
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

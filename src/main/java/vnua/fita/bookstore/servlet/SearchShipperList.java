package vnua.fita.bookstore.servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import vnua.fita.bookstore.bean.Order;
import vnua.fita.bookstore.model.OrderDAO;
import vnua.fita.bookstore.util.Constant;
import vnua.fita.bookstore.util.MyUtil;

@WebServlet(urlPatterns = { "/search/shipperOrderList/delivering", "/search/shipperOrderList/delivered",
		"/search/shipperOrderList/failure" })
public class SearchShipperList extends HttpServlet {
	private OrderDAO orderDAO;

	public void init() {
		String jdbcURL = getServletContext().getInitParameter("jdbcURL");
		String jdbcPassword = getServletContext().getInitParameter("jdbcPassword");
		String jdbcUsername = getServletContext().getInitParameter("jdbcUsername");
		orderDAO = new OrderDAO(jdbcURL, jdbcUsername, jdbcPassword);
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String servletPath = req.getServletPath();
		String pathInfo = MyUtil.getPathInfoFromServletPath(servletPath);
		String keyword = req.getParameter("keyword");
		String context = req.getContextPath();
		List<Order> orders = new ArrayList<Order>();
		if (Constant.DELEVERING_ACTION.equals(pathInfo)) {
			orders = orderDAO.getOrderList(Constant.DELEVERING_ORDER_STATUS, keyword, context);
			req.setAttribute("listType", "ĐANG CHỜ GIAO");
		} else if (Constant.DELEVERED_ACTION.equals(pathInfo)) {
			orders = orderDAO.getOrderList(Constant.DELEVERED_ORDER_STATUS, keyword, context);
			req.setAttribute("listType", "ĐÃ GIAO");
		} else if (Constant.FAILURE_ACTION.equals(pathInfo)) {
			orders = orderDAO.getOrderList(Constant.FAILURE_ORDER_STATUS, keyword, context);
			req.setAttribute("listType", "BỊ HỎNG");
		}
		req.setAttribute(Constant.ORDER_LIST_OF_CUSTOMER, orders);
		RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/Views/shipperOrderListView.jsp");
		dispatcher.forward(req, resp);
	}
}

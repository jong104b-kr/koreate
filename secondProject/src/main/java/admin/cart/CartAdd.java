package admin.cart;

import java.io.IOException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CartDAO;
import model.Cart;

@WebServlet("/admin/cart/add")
public class CartAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CartAdd() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		/* 아이템-상세보기-장바구니,바로구매 */
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		
		String sessionCart = (String)session.getAttribute("cateId");
		String sessionId = (String)session.getAttribute("id");
		
		/* 오늘 날짜를 입력받기 위한 함수 */
		java.util.Date today = new java.util.Date();
		SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String cartSignDate = cal.format(today);
		
		Cart c = new Cart(); // **
		
		c.setOrderCode(sessionCart);
		c.setId(sessionId);
		c.setItemCode(request.getParameter("itemCode"));
		c.setItemPrice(Integer.parseInt(request.getParameter("itemPrice")));
		c.setItemQuantity(Integer.parseInt(request.getParameter("qty"))); //구매수량
		c.setCartStatus("준비");
		c.setCartSignDate(cartSignDate);
		
		CartDAO dao = new CartDAO(); // **
		
		dao.addCart(c);
		
		response.sendRedirect("list");
	}
}
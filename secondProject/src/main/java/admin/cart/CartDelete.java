package admin.cart;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CartDAO;

@WebServlet("/admin/cart/delete")
public class CartDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CartDelete() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		int cartNo = Integer.parseInt(request.getParameter("cartNo"));
		
		CartDAO dao = new CartDAO();
		dao.deleteCart(cartNo);
		
		response.sendRedirect("list");
	}
}

package admin.cart;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CartDAO;

@WebServlet("/admin/cart/qtyUpdate")
public class CartQtyUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CartQtyUpdate() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		int cartNo = Integer.parseInt(request.getParameter("cartNo"));
		String str = request.getParameter("str");
		
		CartDAO dao = new CartDAO();
		dao.cartQtyUpdate(cartNo,str);
	}
}

package admin.item;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ItemDAO;
import model.Category;
import model.Item;

@WebServlet("/admin/item/view")
public class ItemView extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ItemView() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		int itemCode = Integer.parseInt(request.getParameter("itemCode"));
		
		ItemDAO dao = new ItemDAO();
		Item i = dao.viewItem(itemCode);
		
		request.setAttribute("item", i);
		
		ArrayList<Category> v = dao.getCategory();
		
		request.setAttribute("v", v);
		
		RequestDispatcher view = request.getRequestDispatcher("view.jsp");
		view.forward(request, response);
	}
}
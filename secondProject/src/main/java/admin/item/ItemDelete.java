package admin.item;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ItemDAO;

@WebServlet("/admin/item/delete")
public class ItemDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ItemDelete() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		int itemCode = Integer.parseInt(request.getParameter("itemCode"));
		
		ItemDAO dao = new ItemDAO();
		
		dao.deleteItem(itemCode);
		
		response.sendRedirect("list");
	}
}
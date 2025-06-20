package admin.category;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CategoryDAO;

@WebServlet("/admin/category/delete")
public class CategoryDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CategoryDelete() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String cateId = request.getParameter("cateId");
		
		CategoryDAO dao = new CategoryDAO();
		dao.deleteCategory(cateId);
		
		response.sendRedirect("list");
	}
}
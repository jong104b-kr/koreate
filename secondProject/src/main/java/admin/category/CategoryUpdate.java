package admin.category;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CategoryDAO;
import model.Category;

@WebServlet("/admin/category/update")
public class CategoryUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CategoryUpdate() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		request.setCharacterEncoding("utf-8"); // 한글로 자료를 수정할 때 자료형 선언
		
		String number = request.getParameter("number");
		String cateId = request.getParameter("cateId");
		String cateName = request.getParameter("cateName");
		String cateUse = request.getParameter("cateUse["+number+"]");
		
		Category c = new Category();
		
		c.setCateId(cateId);
		c.setCateName(cateName);
		c.setCateUse(cateUse);
		
		CategoryDAO dao = new CategoryDAO();
		dao.updateCategory(c);
		
		response.sendRedirect("list");
	}
}
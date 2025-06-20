package admin.category;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CategoryDAO;
import model.Category;

@WebServlet("/admin/category/add")
public class CategoryAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CategoryAdd() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		RequestDispatcher view = request.getRequestDispatcher("add.jsp");
		view.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		request.setCharacterEncoding("utf-8"); // 한글로 자료를 입력받을 경우 자료형 결정
		
		Category c = new Category(); // 캐터고리 모델 클래스 생성
		
		/* 모델에 삽입할 자료 호출 및 저장 */
		c.setCateId(request.getParameter("cateId"));
		c.setCateName(request.getParameter("cateName"));
		c.setCateUse(request.getParameter("cateUse"));
		
		CategoryDAO dao = new CategoryDAO(); // 캐터고리에 자료를 삽입할 클래스 생성
		dao.addCategory(c);
		
		response.sendRedirect("list");
	}
}
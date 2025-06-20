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

@WebServlet("/admin/item/subCategory")
public class ItemAddSubCategory extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ItemAddSubCategory() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String cateId = request.getParameter("cateId"); // 중분류와 연결하기 위한 매개변수 대분류 호출
		String cateSubId = request.getParameter("cateSubId");
		
		ItemDAO dao = new ItemDAO(); // DB에 입력하기 위한 클래스 선언
		
		ArrayList<Category> v = dao.getSubCategory(cateId); // 대분류 캐터고리를 매개변수로 중분류를 구한다
		
		request.setAttribute("v", v);
		request.setAttribute("cateSubId", cateSubId);
		
		RequestDispatcher view = request.getRequestDispatcher("subCategory.jsp");
		view.forward(request, response);
	}
}
package admin.category;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CategoryDAO;
import model.Category;

@WebServlet("/admin/category/list")
public class CategoryList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CategoryList() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		/* 목록을 보여주므로 페이징 처리를 시작함 */
		int pagingSize = 10; // 한 페이지에 보여줄 목록 수
		
		/* 페이징 변수 초기화 및 request객체로 호출하여 저장 */
		int pagingNumber = 1;
		if(request.getParameter("pagingNumber") != null) {
			pagingNumber = Integer.parseInt(request.getParameter("pagingNumber"));
		}
		
		int count = 0; // 전체 게시글 갯수 초기화
		int number = 0; // 페이지 내에서 보여질 넘버링 변수 초기화
		
		CategoryDAO dao = new CategoryDAO();
		
		/* 검색어 추가 */
		String field = request.getParameter("field");
		String search = request.getParameter("search");
		
		/* 전체 게시글 수 - 검색어 매개변수 추가 */
		count = dao.getAllNumbers(field,search);
		
		/* 현재 보여지는 페이지에서 시작과 끝값 설정 */
		int startRow = (pagingNumber-1)*pagingSize; // 처음은 이전 목록만큼 게시물이 보여야 하므로 (페이징변수-1)한 값에 페이징 사이즈를 곱하여 결정
		int endRow = pagingSize; // 끝은 페이징 사이즈값
		
		/* 넘버링 처리 */
		number = count - (pagingNumber-1)*pagingSize;
		
		/* 물품 총수를 구할 객체배열을 컬렉션 프레임워크로 선언 - 페이징, 검색 매개변수로 전달 */
		ArrayList<Category> v = dao.getAllMembers(startRow,endRow,field,search);
		
		request.setAttribute("v", v);
		request.setAttribute("number", number);
		request.setAttribute("pagingSize", pagingSize);
		request.setAttribute("count", count);
		request.setAttribute("pagingNumber", pagingNumber);
		
		request.setAttribute("field", field);
		request.setAttribute("search", search);
		
		RequestDispatcher view = request.getRequestDispatcher("list.jsp");
		view.forward(request, response);
	}
}
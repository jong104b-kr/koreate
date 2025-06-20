package admin.cart;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CartDAO;
import model.Cart;

@WebServlet("/admin/cart/list")
public class CartList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CartList() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		/* 한 페이지에 보여줄 카트수 */
		int pagingSize = 10;
		
		/* 현재 보여지는 페이지 숫자처리 */
		int pagingNumber = 1;
		if(request.getParameter("pagingNumber")!=null) {
			pagingNumber = Integer.parseInt(request.getParameter("pagingNumber"));
		}
		
		int count = 0; // 전체 카트갯수 초기화
		int number = 0; // 페이지 내에서 보여질 넘버링 변수 초기화
		
		CartDAO dao = new CartDAO(); // 카트 클래스 인스턴스로 생성
		
		/* 검색어 처리 */
		String field = request.getParameter("field");
		String search = request.getParameter("search");
		
		/* 전체 카트수 */
		count = dao.getAllNumbers(field,search);
		
		/* 현재 보여질 페이지 시작과 끝값 */
		int startRow = (pagingNumber-1)*pagingSize;
		int endRow = pagingSize;
		
		/* 카트 출력 목록수 */
		ArrayList<Cart> v = dao.getAllMembers(startRow,endRow,field,search);
		
		number = count - (pagingNumber-1)*pagingSize; // 넘버링 숫자
		
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

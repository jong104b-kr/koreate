package controller.item;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ItemDAO;
import model.Item;

@WebServlet("/item/list")
public class ItemListBoard extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ItemListBoard() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		/* 페이징 기능 - 한 페이지에 보여줄 상품수 */
		int pagingSize = 4;
		
		/* 페이지 번호 초기화 및 지금 보여주는 페이지 순번 처리 */
		int pagingNumber = 1;
		if(request.getParameter("pagingNumber")!=null) {
			pagingNumber = Integer.parseInt(request.getParameter("pagingNumber"));
		}
		
		int count = 0; // 전체상품수 초기화
		int number = 0; // 넘버링변수 초기화, 한 페이지에 출력하는 상품수
		
		ItemDAO dao = new ItemDAO(); // 상품 클래스 생성 및 인스턴스화
		
		/* 검색기능 변수추가 */
		String field = request.getParameter("field");
		String search = request.getParameter("search");
		
		count = dao.getAllNumbers(field, search); // 전체 상품수 구하기
		
		/* 보여줄 페이지 처음과 마지막값 변수 추가 */
		int startRow = (pagingNumber-1)*pagingSize;
		int endRow = pagingSize;
		
		number = count - (pagingNumber-1)*pagingSize; // 넘버링 변수 구하는 식
		
		/* 상품수 목록을 구할 객체배열을 컬렉션 프레임워크로 선언 - 페이징,검색 매개변수 전달 */
		ArrayList<Item> v = dao.getAllMembers(startRow, endRow, field, search);
		
		/* 구한 값들을 request객체 속성에 담아 전달 */
		request.setAttribute("v", v); // 목록들
		request.setAttribute("number", number); // 넘버링
		request.setAttribute("pagingSize", pagingSize); // 한페이지 목록수
		request.setAttribute("count", count); // 전체상품수
		request.setAttribute("pagingNumber", pagingNumber); // 페이징 변수
		
		request.setAttribute("field", field); // 검색영역
		request.setAttribute("search", search); // 검색어
		
		RequestDispatcher view = request.getRequestDispatcher("list.jsp");
		view.forward(request, response);
	}
}

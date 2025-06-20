package admin.member;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AdminMemberDAO;
import model.Member;

@WebServlet("/admin/member/list")
public class List extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public List() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int pagingSize = 5; // 한 페이지당 출력 게시물수
		
		int pagingNumber = 1; // 첫번째 페이징값 초기화
		
		/* pagingNumber를 request객체로 호출하여 페이징 변수 저장함, 다시 request객체로 호출함. */
		if(request.getParameter("pagingNumber") != null){
			pagingNumber = Integer.parseInt(request.getParameter("pagingNumber"));
		}
		
		/* 검색 필드와 값를 request 객체로 받아서 저장 */
		String field = request.getParameter("field");
		String search = request.getParameter("search");
				
		AdminMemberDAO dao = new AdminMemberDAO(); // 관리자로 회원정보에 접근할 클래스 생성
		
		int count = dao.getAllNumbers(field,search); // 전체 게시글 수, 검색어 변수 매개변수로 추가함
		
		int number = count-(pagingNumber-1)*pagingSize; // 넘버링
		
		/* 현재 보여질 페이지 시작과 끝 설정값 */
		int startRow = (pagingNumber-1)*pagingSize;
		int endRow = pagingSize;
		
		/* 객체배열(컬렉션 프레임워크)로 모든 회원정보를 받음. 페이징,검색 매개변수 추가 */
		ArrayList<Member> v = dao.getAllMembers(startRow,endRow,field,search);
		
		request.setAttribute("v", v); // 객체배열을 request객체의 속성으로 저장함
		
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
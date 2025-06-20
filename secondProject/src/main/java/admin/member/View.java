package admin.member;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AdminMemberDAO;
import model.Member;

@WebServlet("/admin/member/view")
public class View extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public View() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String id = request.getParameter("id");
		
		AdminMemberDAO dao = new AdminMemberDAO(); // 선택한 회원객체에 접근하기 위한 클래스 선언
		Member member = dao.findMember(id);
		
		request.setAttribute("m", member); // setAttribute에서 "m"으로 매개변수를 주는 의미는?
		RequestDispatcher view = request.getRequestDispatcher("view.jsp");
		view.forward(request, response);
	}
}

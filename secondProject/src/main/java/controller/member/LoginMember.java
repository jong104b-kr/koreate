package controller.member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MemberDAO;
import model.Member;

@WebServlet("/member/login")
public class LoginMember extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LoginMember() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		RequestDispatcher view = request.getRequestDispatcher("login.jsp");
		view.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		String id = request.getParameter("id");
		String passwd = request.getParameter("passwd");
		
		MemberDAO dao = new MemberDAO(); // 회원정보를 불러올 클래스 생성
		
		int check = dao.checkId(id); // 아이디가 있는지 확인
		
		/* 출력구문을 사용하기 위한 클래스 선언 */
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		if(check==1) { // 아이디가 있는 경우
		
			Member m = dao.memberLogin(id, passwd); // 회원정보를 담은 객체
			
			if(m.getId() != null) { // 아이디, 비밀번호가 일치하는지 확인하는 조건문
			/* 로그인에 성공하면 세션 생성하기 */
			HttpSession session = request.getSession();
			
			session.setAttribute("id", m.getId());
			session.setAttribute("passwd", m.getPasswd());
			session.setAttribute("level", m.getLevel());
			
			response.sendRedirect("/");
			}
			
			else {
				out.print("<script>");
				out.print("alert('비밀번호를 잘못 입력하였습니다.');");
				out.print("history.back();");
				out.print("</script>");
			}
		}
		
		else { // 아이디가 없는 경우
			out.print("<script>");
			out.print("alert('없는 아이디입니다.');");
			out.print("history.back();");
			out.print("</script>");
		}
	}
}
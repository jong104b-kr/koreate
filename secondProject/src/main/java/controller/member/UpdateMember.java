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

@WebServlet("/member/update")
public class UpdateMember extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public UpdateMember() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
		
		String sessionId = (String)session.getAttribute("id");
		
		if(sessionId == null) { // 로그인을 하지 않았을 경우
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			
			out.print("<script>");
			out.print("alert('잘못된 경로입니다.');");
			out.print("location.href='/'");
			out.print("</script>");
		}
		else {
			MemberDAO dao = new MemberDAO(); // 멤버 DB에 접속할 클래스 생성
			Member m = dao.findMember(sessionId); // 찾은 세션값을 객체로 저장
			
			request.setAttribute("update", m); // 객체 m을 update.jsp로 forward한다.
			
			RequestDispatcher view = request.getRequestDispatcher("update.jsp");
			view.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8"); // 수정할 정보에 한글이 있을 경우를 위해 인코딩값 설정
		
		Member m = new Member(); // 수정할 정보를 담을 객체 생성
		
		/* form에서 넘어온 변수들을 담는다 */
		m.setId(request.getParameter("id"));
		m.setPasswd(request.getParameter("passwd"));
		m.setName(request.getParameter("name"));
		m.setPhone(request.getParameter("phone"));
		m.setEmail(request.getParameter("email"));
		m.setZipcode(request.getParameter("zipcode"));
		m.setAddressNew(request.getParameter("addressNew"));
		m.setAddressOld(request.getParameter("addressOld"));
		m.setAddressDetail(request.getParameter("addressDetail"));
		m.setComment(request.getParameter("comment"));
		MemberDAO dao = new MemberDAO(); // 수정한 정보를 삽입할 객체 생성
		dao.updateMember(m);
		
		response.sendRedirect("/"); // 수정(doGet) 서블릿으로 이동
	}
}

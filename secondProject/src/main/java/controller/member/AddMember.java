package controller.member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.MemberDAO;
import model.Member;

@WebServlet("/member/add")
public class AddMember extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AddMember() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		RequestDispatcher view = request.getRequestDispatcher("add.jsp");
		view.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		
		/* 새로운 멤버정보 생성 */
		Member m = new Member();
		
		m.setId(request.getParameter("id"));
		m.setPasswd(request.getParameter("passwd"));
		m.setName(request.getParameter("name"));
		m.setPhone(request.getParameter("phone"));
		m.setEmail(request.getParameter("email"));
		m.setZipcode(request.getParameter("zipcode"));
		m.setAddressNew(request.getParameter("addressNew"));
		m.setAddressOld(request.getParameter("addressOld"));
		m.setAddressDetail(request.getParameter("addressDetail"));
		m.setAddressRef(request.getParameter("addressRef"));
		m.setComment(request.getParameter("comment"));
		m.setLevel(1); // 레벨은 1로 자동설정
		
		/* 기존에 아이디가 있는지 확인 (???검사) */
		MemberDAO dao = new MemberDAO();

		String checkId = request.getParameter("id");
		
		int check = dao.checkId(checkId);
		
		if(check == 1) { // 기존 아이디가 있다면 출력하는 조건문 
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			
			out.print("<script>");
			out.print("alert('이미 사용하고 있는 아이디입니다.');");
			out.print("history.back();");
			out.print("</script>");
		}
		else { // 없을 경우 생성한 아이디 DB삽입
			dao.addMember(m);
			response.sendRedirect("/");
		}
	}
}

package admin.member;

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

@WebServlet("/admin/member/add")
public class Add extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Add() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		RequestDispatcher view = request.getRequestDispatcher("add.jsp");
		view.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		request.setCharacterEncoding("utf-8");
		
		String id = request.getParameter("id"); // 아이디가 이미 있는지 확인할 때 쓸 변수
		Member m = new Member(); // 새로 생성할 아이디를 저장할 객체
		
		m.setId(request.getParameter("id"));
		m.setPasswd(request.getParameter("passwd"));
		m.setName(request.getParameter("name"));
		m.setEmail(request.getParameter("email"));
		m.setZipcode(request.getParameter("zipcode"));
		m.setAddressNew(request.getParameter("addressNew"));
		m.setAddressOld(request.getParameter("addressOld"));
		m.setAddressDetail(request.getParameter("addressDetail"));
		m.setAddressRef(request.getParameter("addressRef"));
		m.setComment(request.getParameter("comment"));
		m.setLevel(1);
		
		/* 아이디가 이미 있는지 확인, 클래스 선언 */
		MemberDAO dao = new MemberDAO();
		
		int number = dao.checkId(id); // 아이디가 있는지 확인
		
		if(number == 1) {
			/* 아이디가 있을 경우 출력할 구문 */
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			
			out.print("<script>");
			out.print("alert('이미 사용하고 있는 아이디입니다.');");
			out.print("history.back();");
			out.print("</script>");
		}
		else {
			/* 아이디가 없을 경우 생성 */
			dao.addMember(m);
			response.sendRedirect("list");
		}
	}
}
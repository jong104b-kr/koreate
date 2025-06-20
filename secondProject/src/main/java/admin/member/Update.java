package admin.member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AdminMemberDAO;
import model.Member;

@WebServlet("/admin/member/update")
public class Update extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Update() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		String id = request.getParameter("id");
		
		AdminMemberDAO dao = new AdminMemberDAO();
		
		/* 찾은 한명의 회원을 저장할 객체 */
		Member m = dao.findMember(id);
		
		request.setAttribute("m", m);
		
		RequestDispatcher view = request.getRequestDispatcher("update.jsp");
		view.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/* 한글이 입력될 경우 */
		request.setCharacterEncoding("utf-8");
		
		Member m = new Member();
		
		m.setId(request.getParameter("id"));
		m.setPasswd(request.getParameter("passwd"));
		m.setName(request.getParameter("name"));
		m.setPhone(request.getParameter("phone"));
		m.setEmail(request.getParameter("email"));
		m.setAddressNew(request.getParameter("addressNew"));
		m.setAddressOld(request.getParameter("addressOld"));
		m.setAddressDetail(request.getParameter("addressDetail"));
		m.setAddressRef(request.getParameter("addressRef"));
		m.setComment(request.getParameter("comment"));
		
		AdminMemberDAO dao = new AdminMemberDAO();
		
		dao.updateMember(m);
		
		PrintWriter out = response.getWriter();
		
		out.print("<script>");
		out.print("opener.location.reload();");
		out.print("self.close();");
		out.print("</script>");
	}
}
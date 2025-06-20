package admin.item;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dao.ItemDAO;
import model.Category;
import model.Item;

@WebServlet("/admin/item/add")
public class ItemAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ItemAdd() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		ItemDAO dao = new ItemDAO(); // item DB입력 클래스 선언
		
		ArrayList<Category> v = dao.getCategory(); // 대분류 캐터고리 값 가져오기
		
		request.setAttribute("v", v);
		
		RequestDispatcher view = request.getRequestDispatcher("add.jsp");
		view.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		request.setCharacterEncoding("utf-8");
		
		/* 저장경로, 파일 업로드 최대크기 지정하기 */
		String uploadPath = "c:\\jsp\\my2ndProject\\src\\main\\webapp\\uploadItem";
		int size = 10*1024*1024;
		
		MultipartRequest multi = new MultipartRequest(request,uploadPath,size,"utf-8",new DefaultFileRenamePolicy());
		
		Item item = new Item();
		
		item.setItemCategory(multi.getParameter("itemCategory"));
		item.setItemSubCategory(multi.getParameter("itemSubCategory"));
		item.setId(multi.getParameter("id"));
		item.setItemName(multi.getParameter("itemName"));
		item.setItemPrice(Integer.parseInt(multi.getParameter("itemPrice")));
		item.setItemQuantity(Integer.parseInt(multi.getParameter("itemQuantity")));
		item.setItemOnSale(multi.getParameter("itemOnSale"));
		
		Enumeration files=multi.getFileNames();
		
		String itemImage1 = (String)files.nextElement();
		String itemImage1rename = multi.getFilesystemName(itemImage1);
		if(itemImage1rename == null) { itemImage1rename = ""; }
		
		String thumbNail = ""; // 썸네일 파일명 미구현
		item.setThumbNail(thumbNail); //썸네일 명 
		
		item.setItemImage1(itemImage1rename);
		item.setThumbNail(multi.getParameter("thumbNail"));
				
		/* item 객체에 대입한 내용 삽입 */
		ItemDAO dao = new ItemDAO();
		dao.addItem(item);
		
		response.sendRedirect("list");
	}
}
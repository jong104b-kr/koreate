package admin.item;

import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.imageio.ImageIO;
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

@WebServlet("/admin/item/update")
public class ItemUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ItemUpdate() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		int itemCode = Integer.parseInt(request.getParameter("itemCode"));
		
		ItemDAO dao = new ItemDAO();
		Item i = dao.viewItem(itemCode);
		
		request.setAttribute("item", i);
		
		ArrayList<Category> v = dao.getCategory();
		
		request.setAttribute("v", v);
		
		RequestDispatcher view = request.getRequestDispatcher("update.jsp");
		view.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		request.setCharacterEncoding("utf-8"); // 수정시 한글처리
		
		/* 저장경로설정 */
		String uploadPath = "C:\\jsp\\my2ndProject\\src\\main\\webapp\\uploadItem";
		int size = 10*1024*1024;
		
		/* 첨부파일이 있으므로 MultipartRequest 객체 사용 */
		MultipartRequest multi = new MultipartRequest(request, uploadPath, size, "utf-8", new DefaultFileRenamePolicy());
		
		/* 페이징변수 처리 */
		String pagingNumber = ""; // 선언 및 초기화
		if(multi.getParameter("pagingNumber")!=null) {
			pagingNumber = multi.getParameter("pagingNumber");
		}
		
		/* 필드값 처리 - 반환시 사용, 변수로 값이 설정되어 있음 */
		String field = "";
		if(multi.getParameter("field")!=null) {
			field = multi.getParameter("field");
		}
		
		/* 검색어 처리 - 반환시 사용 - 입력값을 그대로 처리 */
		String search = "";
		if(multi.getParameter("search")!=null) {
			search = URLEncoder.encode(multi.getParameter("search"), "utf-8"); // 한글전달함
		}
		
		Item item = new Item(); // 수정할 변수를 담을 클래스 생성
		
		item.setItemCode(Integer.parseInt(multi.getParameter("itemCode")));
		item.setItemCategory(multi.getParameter("itemCategory"));
		item.setItemSubCategory(multi.getParameter("itemSubCategory"));
		item.setId(multi.getParameter("id"));
		item.setItemName(multi.getParameter("itemName"));
		item.setItemPrice(Integer.parseInt(multi.getParameter("itemPrice")));
		item.setItemQuantity(Integer.parseInt(multi.getParameter("itemQuantity")));
		item.setItemOnSale(multi.getParameter("itemOnSale"));
		item.setItemImage1(multi.getParameter("itemImage1"));
		item.setThumbNail(multi.getParameter("thumbNail"));
		
		Enumeration files = multi.getFileNames();
		
		String itemImage = (String)files.nextElement();
		String itemImageRename = multi.getFilesystemName(itemImage);
		if(itemImageRename == null) {
			itemImageRename = "";
		}
		
		item.setItemImage1(itemImageRename);
		
		/* 썸네일 구현 코드 */
		String thumbNail = ""; // 썸네일 파일명 미구현
		if(!itemImageRename.equals("")) { // 첨부파일이 있다면,
			String oPath = uploadPath + "/" + itemImageRename; // 원본 경로
			File oFile = new File(oPath);
			int index = oPath.lastIndexOf(".");
			String ext = oPath.substring(index + 1); // 파일 확장자
			thumbNail = "thumb_" + oFile.getName(); // 썸네일 파일명
			String tPath = oFile.getParent() + File.separator + thumbNail; // 썸네일 저장경로 및 파일명
			File tFile = new File(tPath);
			double ratio = 2; // 이미지 축소 비율
			
			try {
				BufferedImage oImage = ImageIO.read(oFile);
				int tWitdh = (int)(oImage.getWidth()/ratio); // 생성할 썸네일 이미지의 너비
				int tHeight = (int)(oImage.getHeight()/ratio); // 생성할 썸네일 이미지의 높이
				BufferedImage tImage = new BufferedImage(tWitdh, tHeight,BufferedImage.TYPE_3BYTE_BGR); // 썸네일 이미지
				Graphics2D graphic = tImage.createGraphics();
				Image image = oImage.getScaledInstance(tWitdh, tHeight, Image.SCALE_SMOOTH);
				graphic.drawImage(image, 0, 0, tWitdh, tHeight, null);
				graphic.dispose(); // 리소스를 모두 해제
				ImageIO.write(tImage, ext, tFile); // 썸네일을 저장함
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		item.setThumbNail(thumbNail); // 썸네일명
		
		/* item 객체에 대입한 내용 수정 */
		ItemDAO dao = new ItemDAO();
		dao.updateItem(item);
		
		response.sendRedirect("list?pagingNumber="+pagingNumber+"&field="+field+"&search="+search);
	}
}
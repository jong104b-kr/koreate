<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/common.jsp" %>

<%
request.setCharacterEncoding("utf-8");

//파일 저장 폴더 생성 경로(프로젝트 안에 upload 폴더 생성 및 지정 추천) 
//String uploadPath=request.getRealPath("/upload");
String uploadPath="C:\\jsp\\my1stProject\\src\\main\\webapp\\upload"; //window 폴더 내 upload 경로
int size=10*1024*1024; //파일 최대 사이즈 (10메가)

MultipartRequest multi=new MultipartRequest(request,uploadPath,size,"utf-8",new DefaultFileRenamePolicy());

String code = multi.getParameter("code");
String no = multi.getParameter("no");
String title = multi.getParameter("title");
String field=multi.getParameter("field");
String search=multi.getParameter("search");
String page_now = multi.getParameter("page_now");

Enumeration files=multi.getFileNames();

//첨부파일1
String attach=(String)files.nextElement(); //첨부파일1 존재한다면
String attach_name=multi.getOriginalFileName(attach); //사용자가 올린 파일명
String attach_rename=multi.getFilesystemName(attach); //중복된 파일명을 새로운 파일명으로 변경

if(attach_name == null){ //첨부파일1 없다면
	attach_name = ""; //null 값이 아닌 비어있는 값으로 대체
	attach_rename = ""; //null 값이 아닌 비어있는 값으로 대체
}

String attach_thumb = ""; //썸네일 파일명

////썸네일 ////
if(!attach_rename.equals("")){ //첨부가 있다면
	String oPath = uploadPath+"/"+attach_rename; // 원본 경로
	File oFile = new File(oPath);
	
	int index = oPath.lastIndexOf(".");
	String ext = oPath.substring(index + 1); // 파일 확장자
	attach_thumb = "thumb_" + oFile.getName(); //썸네일 파일명
	String tPath = oFile.getParent() + File.separator + attach_thumb; // 썸네일 저장 경로 및 파일명
	File tFile = new File(tPath);
	double ratio = 2; // 이미지 축소 비율
	
		try {
			BufferedImage oImage = ImageIO.read(oFile); // 원본이미지
			int tWidth = (int) (oImage.getWidth() / ratio); // 생성할 썸네일이미지의 너비
			int tHeight = (int) (oImage.getHeight() / ratio); // 생성할 썸네일이미지의 높이
			
			BufferedImage tImage = new BufferedImage(tWidth, tHeight, BufferedImage.TYPE_3BYTE_BGR); // 썸네일이미지
			Graphics2D graphic = tImage.createGraphics();
			Image image = oImage.getScaledInstance(tWidth, tHeight, Image.SCALE_SMOOTH);
			graphic.drawImage(image, 0, 0, tWidth, tHeight, null);
			graphic.dispose(); // 리소스를 모두 해제
			
			ImageIO.write(tImage, ext, tFile); //썸네일 저장
		} catch (IOException e) {
			e.printStackTrace();
		}
}

//오늘 날짜
java.util.Date today = new java.util.Date();
SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String issueDate = cal.format(today);

// db 삽입하기
String sql_modify;
if(attach_name != null && attach_name != "") { // 첨부파일이 있다면
	sql_modify = "update "+code+" set title='"+title+"',attachRe='"+attach_name+"',attach='"+attach_rename+"',thumbNail='"+attach_thumb+"' where no='"+no+"'";
}
else {
	sql_modify = "update code set title='"+title+"' where no='"+no+"'";
}

Connection con_modify = DriverManager.getConnection(url, user, password);
Statement stmt_modify = con_modify.createStatement();
stmt_modify.executeUpdate(sql_modify);

stmt_modify.close();
con_modify.close();
%>

<script>
	location.href="list.jsp?code=<%=code%>&field=<%=field%>&search=<%=search%>&page_now=<%=page_now%>";
</script>

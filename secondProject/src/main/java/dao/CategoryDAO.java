package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import model.Category;

public class CategoryDAO {

	/* 사용할 객체를 먼저 선언함 */
	Statement stmt;
	PreparedStatement pstmt;
	ResultSet rs;
	
	DAO d = new DAO(); // d.getCon(), d.con을 사용하기 위해 생성함
	
	/* 물품 총수 구하기 - 검색을 매개변수로 추가 */
	public int getAllNumbers(String field, String search) {
		
		d.getCon();
		
		int count = 0;
		
		try {
			String sql = "";
			
			/* 검색을 할 경우와 그렇지 않을 경우 나누어 쿼리문 호출 */
			if(search!=null && !search.equals("")) {
				sql = "select count(*) from category where "+field+" like '%"+search+"%'";
			}
			else {
				sql = "select count(*) from category";
			}
			
			stmt = d.con.createStatement();
			rs = stmt.executeQuery(sql);
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
			rs.close();
			stmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
	/* 물품 목록 - 페이징과 검색을 매개변수로 추가 */
	public ArrayList<Category> getAllMembers(int startRow,int endRow,String field,String search){
		d.getCon();
		
		ArrayList<Category> v = new ArrayList<Category>();
		
		try {
			String sql = "";
			
			/* 검색어가 있을 경우 구분하여 쿼리문 호출 */
			if(search != null && !search.equals("")) {
				sql = "select * from category where "+field+" like '%"+search+"%' order by cateId asc limit ?,?";
			}
			else {
				sql = "select * from category order by cateId asc limit ?,?";
			}
			
			pstmt = d.con.prepareStatement(sql);
			
			pstmt.setInt(1,startRow); // 첫번째 매개변수에 시작열 대입 
			pstmt.setInt(2,endRow); // 두번째 매개변수에 끝열 대입
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Category c = new Category();
				
				c.setCateId(rs.getString("cateId"));
				c.setCateName(rs.getString("cateName"));
				c.setCateUse(rs.getString("cateUse"));
				
				v.add(c);
			}
			
			rs.close();
			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return v;
	}
	
	/* 물품 등록 */
	public void addCategory(Category c) {
		d.getCon();
		
		try {
			String sql = "insert into category values (?,?,?)";
			pstmt = d.con.prepareStatement(sql);
			
			pstmt.setString(1, c.getCateId());
			pstmt.setString(2, c.getCateName());
			pstmt.setString(3, c.getCateUse());
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/* 물품 수정 */
	public void updateCategory(Category c) {
		d.getCon();
		
		try {
			String sql = "update category set cateName=?,cateUse=? where cateId=?";
			pstmt = d.con.prepareStatement(sql);
			
			pstmt.setString(1, c.getCateName()); // 1은 첫번째 매개변수
			pstmt.setString(2, c.getCateUse()); // 2는 두번째 매개변수
			pstmt.setString(3, c.getCateId()); // 3은 세번째 매개변수
			
			pstmt.executeUpdate();
			
			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/* 물품 삭제 */
	public void deleteCategory(String cateId) {
		d.getCon();
		
		try {
			String sql = "delete from category where cateId=?";
			pstmt = d.con.prepareStatement(sql);
			
			pstmt.setString(1, cateId);
			
			pstmt.executeUpdate();
			
			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
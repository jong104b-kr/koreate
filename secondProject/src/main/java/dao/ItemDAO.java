package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import model.Category;
import model.Item;

public class ItemDAO {

	Statement stmt;
	PreparedStatement pstmt;
	ResultSet rs;
	
	DAO d = new DAO(); // DB에 접근하기 위한 클래스 생성
	
	/* 전체 상품수 구하기 */
	public int getAllNumbers(String field,String search) {
		d.getCon();
		
		int count = 0; // 상품수 선언 및 초기화
		
		try {
			String sql = "";
			if(search!=null && !search.equals("")) {
				sql = "select count(*) from item where "+field+" like '%"+search+"%'";
			}
			else {
				sql = "select count(*) from item";
			}
			
			pstmt = d.con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1); // rs객체 첫번째 매개변수를 카운트 변수에 대입
			}
			rs.close();
			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
	/* 상품목록 구하기 - 객체배열, 컬렉션 프레임워크 이용 */
	public ArrayList<Item> getAllMembers(int startRow,int endRow,String field,String search){
		d.getCon();
		
		ArrayList<Item> v = new ArrayList<Item>(); // 상품목록에 관한 배열을 담기 위한 객체배열 클래스 생성
		
		try {
			String sql = "";
			/* 검색어가 있을 경우 목록을 구하기 위한 쿼리문 새로 호출 */
			if(search!=null && !search.equals("")) {
				sql = "select * from item where "+field+" like '%"+search+"%' order by itemCode asc limit ?,?";
			}
			else {
				sql = "select * from item order by itemCode asc limit ?,?";
			}
			
			pstmt = d.con.prepareStatement(sql);
			
			pstmt.setInt(1, startRow); // pstmt 객체의 첫번째 매개변수를 시작값으로 대입
			pstmt.setInt(2, endRow); // pstmt 객체의 두번째 매개변수를 마지막값으로 대입
			
			rs = pstmt.executeQuery();  // limit값을 1,2에 넣은대로 rs객체 쿼리문 실행을 통해 생성
			
			while(rs.next()) {
				Item i = new Item(); // 쿼리문을 통해 생성한 객체를 활용할 클래스 선언
				
				i.setItemCode(rs.getInt("itemCode"));
				i.setItemCategory(rs.getString("itemCategory"));
				i.setItemSubCategory(rs.getString("itemSubCategory"));
				i.setId(rs.getString("id"));
				i.setItemName(rs.getString("itemName"));
				i.setItemPrice(rs.getInt("itemPrice"));
				i.setItemQuantity(rs.getInt("itemQuantity"));
				i.setItemOnSale(rs.getString("itemOnSale"));
				i.setItemImage1(rs.getString("itemImage1"));
				i.setThumbNail(rs.getString("thumbNail"));
				
				v.add(i);
			}
			
			rs.close();
			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return v;
	}
	
	/* 대분류 캐터고리 구하기 */
	public ArrayList<Category> getCategory(){
		d.getCon();
		
		ArrayList<Category> v = new ArrayList<Category>(); // 객체배열을 컬렉션 프레임워크로 생성
		
		try {
			String sql = "select * from category where length(cateId)=2 and cateUse='Y'";
			pstmt = d.con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Category c = new Category();
				
				c.setCateId(rs.getString("cateId"));
				c.setCateName(rs.getString("cateName"));
				
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
	
	/* 중분류 캐터고리 구하기 */
	public ArrayList<Category> getSubCategory(String cateId){
		d.getCon();
		
		ArrayList<Category> v = new ArrayList<Category>();
		
		try {
			String sql = "select * from category where left(cateId,2)=? and length(cateId)=4 and cateUse='Y'";
			pstmt = d.con.prepareStatement(sql);
			pstmt.setString(1, cateId);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Category c = new Category();
				
				c.setCateId(rs.getString("cateId"));
				c.setCateName(rs.getString("cateName"));
				
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
	
	/* 상품 등록하기 */
	public void addItem(Item i) {
		d.getCon();
		
		try {
			String sql = "insert into item values (null,?,?,?,?,?,?,?,?,?)";
			pstmt = d.con.prepareStatement(sql);
			
			pstmt.setString(1, i.getItemCategory());
			pstmt.setString(2, i.getItemSubCategory());
			pstmt.setString(3, i.getId());
			pstmt.setString(4, i.getItemName());
			pstmt.setInt(5, i.getItemPrice());
			pstmt.setInt(6, i.getItemQuantity());
			pstmt.setString(7, i.getItemOnSale());
			pstmt.setString(8, i.getItemImage1());
			pstmt.setString(9, i.getThumbNail());
			
			pstmt.executeUpdate();
			
			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/* 상품 상세보기 */
	public Item viewItem(int itemCode) {
		d.getCon();
		
		Item item = new Item();
		
		try {
			String sql = "select * from item where itemCode=?";
			pstmt = d.con.prepareStatement(sql);
			pstmt.setInt(1, itemCode);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				item.setItemCode(rs.getInt("itemCode"));
				item.setItemCategory(rs.getString("itemCategory"));
				item.setItemSubCategory(rs.getString("itemSubCategory"));
				item.setId(rs.getString("id"));
				item.setItemName(rs.getString("itemName"));
				item.setItemPrice(rs.getInt("itemPrice"));
				item.setItemQuantity(rs.getInt("itemQuantity"));
				item.setItemOnSale(rs.getString("itemOnSale"));
				item.setItemImage1(rs.getString("itemImage1"));
				item.setThumbNail(rs.getString("thumbNail"));
			}
			rs.close();
			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return item;
	}
	
	/* 상품 수정하기 */
	public void updateItem(Item i) {
		d.getCon();
		
		try {
			String itemImage1, thumbNail;
			if(i.getItemImage1() != null && !i.getItemImage1().equals("")) {
				itemImage1 = ",itemImage='"+i.getItemImage1()+"'";
			}
			else {
				itemImage1 = "";
			}
			if(i.getThumbNail() != null && !i.getThumbNail().equals("")) {
				thumbNail = ",thumbNail='"+i.getThumbNail()+"'";
			}
			else {
				thumbNail = "";
			}
			
			String sql = "update item set itemCategory=?,itemSubCategory=?,id=?,itemName=?,itemPrice=?,itemQuantity=?";
					sql += ",itemOnSale=?"+itemImage1+thumbNail+" where itemCode=?";
			
			pstmt = d.con.prepareStatement(sql);
			
			pstmt.setString(1, i.getItemCategory());
			pstmt.setString(2, i.getItemSubCategory());
			pstmt.setString(3, i.getId());
			pstmt.setString(4, i.getItemName());
			pstmt.setInt(5, i.getItemPrice());
			pstmt.setInt(6, i.getItemQuantity());
			pstmt.setString(7, i.getItemOnSale());
			pstmt.setInt(8, i.getItemCode()); // 첨부파일?
			
			pstmt.executeUpdate();
			
			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/* 상품 삭제하기 */
	public void deleteItem(int itemCode) {
		d.getCon();
		
		try {
			String sql = "delete from item where itemCode=?";
			pstmt = d.con.prepareStatement(sql);
			
			pstmt.setInt(1, itemCode);
			
			pstmt.executeUpdate();
			
			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
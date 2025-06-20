package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import model.Cart;

public class CartDAO {

	Statement stmt;
	PreparedStatement pstmt;
	ResultSet rs;
	
	DAO d = new DAO();
	
	/* 카트 총수 구하기 */
	public int getAllNumbers(String field,String search) {
		d.getCon();
		
		int count = 0;
		
		try {
			String sql = "select count(*) from cart";
			/* 검색어가 있을 경우 검색된 총수를 구하는 쿼리문 */
			if(search!=null && !search.equals("")) {
				sql = "select count(*) from cart where "+field+" like '%"+search+"%'";
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
	
	/* 카트목록 구하기 */
	public ArrayList<Cart> getAllMembers(int startRow,int endRow,String field,String search){
		d.getCon();
		
		ArrayList<Cart> v = new ArrayList<Cart>(); // 카트목록을 담을 객체배열을 선언
		
		try {
			String sql = "select *,(select itemImage1 from item where item.itemCode=cart.itemCode) as itemImage1 from ";
					sql += "cart order by cartNo desc limit ?,?";
			/* 검색어가 있을 경우 목록을 구하는 쿼리문 */
			if(search!=null && !search.equals("")) {
				sql = "select *,(select itemImage1 from item where item.itemCode=cart.itemCode) as itemImage1 from cart ";
					sql	+= "where "+field+" like '%"+search+"%' order by cartNo desc limit ?,?";
			}
			
			pstmt = d.con.prepareStatement(sql);
			
			/* 게시물 시작과 끝을 객체에 대입 */
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Cart c = new Cart(); // 카트 클래스를 인스턴스로 생성
				
				String cartSignDate = rs.getString("cartSignDate").substring(0, 10); // 카트등록일 받기
				
				c.setCartNo(rs.getInt("cartNo"));
				c.setOrderCode(rs.getString("orderCode"));
				c.setId(rs.getString("id"));
				c.setItemCode(rs.getString("itemCode"));
				c.setItemPrice(rs.getInt("itemPrice"));
				c.setItemQuantity(rs.getInt("itemQuantity"));
				c.setCartStatus(rs.getString("cartStatus"));
				c.setItemImage1(rs.getString("itemImage1"));
				c.setCartSignDate(cartSignDate);
				
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
	
	/* 카트에 물품 추가 */
	public void addCart(Cart c) {
		d.getCon();
		
		try {
			String sql = "insert into cart values (null,?,?,?,?,?,?,?)";
			
			pstmt = d.con.prepareStatement(sql);
			
			pstmt.setString(1, c.getOrderCode());
			pstmt.setString(2, c.getId());
			pstmt.setString(3, c.getItemCode());
			pstmt.setInt(4, c.getItemPrice());
			pstmt.setInt(5, c.getItemQuantity());
			pstmt.setString(6, c.getCartStatus());
			pstmt.setString(7, c.getCartSignDate());
			
			pstmt.executeUpdate();
			
			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/* 장바구니에 상품이 있는지 확인 */
	public int findItem(Cart c) {
		d.getCon();
		
		int number = 0;
		
		try {
			String sql = "select count(*) from cart where orderCode=? and itemCode=?";
			
			pstmt = d.con.prepareStatement(sql);
			
			pstmt.setString(1, c.getOrderCode());
			pstmt.setString(2, c.getItemCode());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				number = rs.getInt(1);
			}
			
			rs.close();
			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return number;
	}
	
	/* 상품이 있을 경우 수량 업데이트 */
	public void updateCart(Cart c) {
		d.getCon();
		
		try {
			String sql = "update cart set itemQuantity=itemQuantity+? where orderCode=? and itemCode=?";
			
			pstmt = d.con.prepareStatement(sql);
			
			pstmt.setInt(1, c.getItemQuantity());
			pstmt.setString(2, c.getOrderCode());
			pstmt.setString(3, c.getItemCode());
			
			pstmt.executeUpdate();
			
			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/* 장바구니 삭제 */
	public void deleteCart(int cartNo) {
		d.getCon();
		
		try {
			String sql = "delete from cart where cartNo=?";
			
			pstmt = d.con.prepareStatement(sql);
			pstmt.setInt(1, cartNo);
			
			pstmt.executeUpdate();
			
			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/* 장바구니 수량변경 */
	public void cartQtyUpdate(int cartNo,String str) {
		d.getCon();
		
		try {
			String sql = "update cart set itemQuantity = itemQuantity-1 where cartNo=?"; // 감소버튼을 누를 때 처리할 쿼리문
			/* 증가버튼을 눌렀을 때 */
			if(str.equals("p")) {
				sql = "update cart set itemQuantity = itemQuantity+1 where cartNo=?"; // 증가버튼을 누를 때 처리할 쿼리문
			}
			
			pstmt = d.con.prepareStatement(sql);
			pstmt.setInt(1, cartNo);
			
			pstmt.executeUpdate();
			
			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import model.Member;

public class AdminMemberDAO {

	/* 사용할 객체를 미리 선언한다 */
	Statement stmt;
	PreparedStatement pstmt;
	ResultSet rs;
	
	DAO d = new DAO(); // DB에 접근할 때 사용할 클래스 생성
	
	/* 회원 총수 구하기 */
	public int getAllNumbers(String field, String search) {
		d.getCon();
		
		int count = 0;
		
		try {
			String sql = "select count(*) from member";
			
			pstmt = d.con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
			
			rs.close();
			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
	/* 회원목록 - 페이징 매개변수로 추가 */
	public ArrayList<Member> getAllMembers(int startRow, int endRow, String field, String search){
		d.getCon();
		
		ArrayList<Member> v = new ArrayList<Member>(); // 회원관리를 하기 위한 객체배열
		
		try {
			String sql = "select * from member";
			pstmt = d.con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Member m = new Member();
				
				m.setId(rs.getString("id"));
				m.setPasswd(rs.getString("passwd"));
				m.setName(rs.getString("name"));
				m.setPhone(rs.getString("phone"));
				m.setEmail(rs.getString("email"));
				m.setZipcode(rs.getString("zipcode"));
				m.setAddressNew(rs.getString("addressNew"));
				m.setAddressOld(rs.getString("addressOld"));
				m.setAddressDetail(rs.getString("addressDetail"));
				m.setAddressRef(rs.getString("addressRef"));
				m.setLevel(Integer.parseInt(rs.getString("level")));
				
				v.add(m); // 객체배열(컬렉션 프레임워크)에 하나씩 더한다.
			}
			
			rs.close();
			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return v;
	}
	
	/* 회원정보 찾기 */
	public Member findMember(String id) {
		d.getCon();
		
		Member m = new Member();
		
		try {
			String sql = "select * from member where id=?";
			pstmt = d.con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				m.setId(rs.getString("id"));
				m.setPasswd(rs.getString("passwd"));
				m.setName(rs.getString("name"));
				m.setPhone(rs.getString("phone"));
				m.setEmail(rs.getString("email"));
				m.setZipcode(rs.getString("zipcode"));
				m.setAddressNew(rs.getString("addressNew"));
				m.setAddressOld(rs.getString("addressOld"));
				m.setAddressDetail(rs.getString("addressDetail"));
				m.setAddressRef(rs.getString("addressRef"));
			}
			rs.close();
			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return m;
	}
	
	/* 회원정보 수정 */
	public void updateMember(Member m) {
		d.getCon();
		
		try {
			String sql = "update member set passwd=?,name=?,phone=?,email=?,zipcode=?,addressNew=?,addressOld=?,addressDetail=?,";
					sql += "addressRef=?,comment=? where id=?";
			
			pstmt = d.con.prepareStatement(sql);
			
			pstmt.setString(1, m.getPasswd());
			pstmt.setString(2, m.getName());
			pstmt.setString(3, m.getPhone());
			pstmt.setString(4, m.getEmail());
			pstmt.setString(5, m.getZipcode());
			pstmt.setString(6, m.getAddressNew());
			pstmt.setString(7, m.getAddressOld());
			pstmt.setString(8, m.getAddressDetail());
			pstmt.setString(9, m.getAddressRef());
			pstmt.setString(10, m.getComment());
			pstmt.setString(11, m.getId());
			
			pstmt.executeUpdate();
			
			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/* 회원 삭제 */
	public void deleteMember(String id) {
		d.getCon();
		
		try {
			String sql = "delete from member where id=?";
			pstmt = d.con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			pstmt.executeUpdate();
			
			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import model.Member;

public class MemberDAO {

	/* 사용할 객체를 미리 선언함 */
	Statement stmt;
	PreparedStatement pstmt;
	ResultSet rs;
	
	DAO d = new DAO(); // d.getCon(), d.con을 사용하기 위해 생성함
	
	/* 아이디가 있는지 확인 */
	public int checkId(String checkId) {
		
		d.getCon();
		
		int check = 0; // 아이디가 있을 경우 1을 반환할 변수
		
		try {
			String sql = "select count(*) from member where id=?";
			pstmt = d.con.prepareStatement(sql);
			
			pstmt.setString(1, checkId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				check = rs.getInt(1);
			}
			
			rs.close();
			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return check;
	}
	
	/* 회원가입 */
	public void addMember(Member member) {
	
		d.getCon();
		
		try {
			String sql = "insert into member values (?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = d.con.prepareStatement(sql);
			
			pstmt.setString(1,member.getId());
			pstmt.setString(2,member.getPasswd());
			pstmt.setString(3,member.getName());
			pstmt.setString(4,member.getPhone());
			pstmt.setString(5,member.getEmail());
			pstmt.setString(6,member.getZipcode());
			pstmt.setString(7,member.getAddressNew());
			pstmt.setString(8,member.getAddressOld());
			pstmt.setString(9,member.getAddressDetail());
			pstmt.setString(10,member.getAddressRef());
			pstmt.setString(11,member.getComment());
			pstmt.setString(12,"1");
			
			pstmt.executeUpdate();
			
			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/* 로그인 */
	public Member memberLogin(String id, String passwd) {
	
		d.getCon();
		
		Member m = new Member();
		
		try {
			String sql = "select * from member where id=? and passwd=?";
			pstmt = d.con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			pstmt.setString(2, passwd);
			
			rs = pstmt.executeQuery();
			
			/* 아이디, 이름, 레벨 설정 */
			if(rs.next()) {
				m.setId(rs.getString("id"));
				m.setName(rs.getString("name"));
				m.setLevel(rs.getInt("level"));
			}
			
			rs.close();
			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return m;
	}
	
	/* 회원찾기 */
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
				m.setComment(rs.getString("comment"));
				m.setLevel(Integer.parseInt(rs.getString("level")));
			}
			rs.close();
			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return m;
	}
	
	/* 회원수정 */
	public void updateMember(Member m) {
		d.getCon();
		
		try {
			String sql = "update member set passwd=?,name=?,phone=?,email=?,zipcode=?,addressNew=?,addressOld=?,";
				sql += "addressDetail=?,addressRef=?,comment=? where id=?";
				
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
}
package member;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.AES;
import bean.DBConn;

public class MemberDao {
	public static String uploadPath = 
			"C:\\Users\\pooh3\\eclipse-workspace\\WebProject\\src\\main\\webapp\\upload/";
	
	Page page;
	Connection conn;
	PreparedStatement ps;
	String sql;
	ResultSet rs;
	
	public MemberDao() {
		try {
			conn = new DBConn().getConn();
		}catch(Exception ex) {
			ex.printStackTrace();
		}
	}
	
	public MemberVo login(String mid, String pwd) {
		MemberVo vo = new MemberVo();
		String newPwd = "";
		AES aes = new AES();
		try {
			sql="select * from member where mid=? and pwd=?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, mid);
			newPwd= aes.encrypt(pwd);
			ps.setString(2, newPwd);
			rs=ps.executeQuery();
			if(rs.next()) {
				vo.setMid(mid);
				vo.setIrum(rs.getString("irum"));
			}
			
			/*
			sql="select * from member where mid=? ";
			ps = conn.prepareStatement(sql);
			ps.setString(1, mid);
			
			rs=ps.executeQuery();
			if(rs.next()) {								
				newPwd = aes.decrypt(rs.getString("pwd"));
				
				if(pwd.equals(newPwd)) {
					vo.setMid(mid);
					vo.setIrum(rs.getString("irum"));
				}
			}
			*/
			conn.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return vo;
	}
	
	public List<MemberVo> select(String n, String f){
		int nowPage = Integer.parseInt(n);
		List<MemberVo> list = new ArrayList<MemberVo>();
		try {
			//totSize
			sql = "select count(mid) totSize from member "
				+ "where mid=? or phone like ? or irum like ? or address like ? or address2 like ? ";
			ps = conn.prepareStatement(sql);
			ps.setString(1, f);
			ps.setString(2, "%"+f+"%");
			ps.setString(3, "%"+f+"%");
			ps.setString(4, "%"+f+"%");
			ps.setString(5, "%"+f+"%");
			
			rs = ps.executeQuery();
			if(rs.next()) {
				int totSize = rs.getInt("totsize");
				page = new Page(totSize,nowPage);
			}
			
			//memberVo
			sql = "select * from member "
				+ "where mid=? or phone like ? or irum like ? or address like ? or address2 like ? "
				+ "limit ?, ? ";
			ps = conn.prepareStatement(sql);
			ps.setString(1, f);
			ps.setString(2, "%"+f+"%");
			ps.setString(3, "%"+f+"%");
			ps.setString(4, "%"+f+"%");
			ps.setString(5, "%"+f+"%");
			ps.setInt(6, page.getStartNo()-1);
			ps.setInt(7, page.getListSize());
			
			rs = ps.executeQuery();
			while(rs.next()) {
				MemberVo vo = new MemberVo();
				vo.setAddress(rs.getString("address"));
				vo.setAddress2(rs.getString("address2"));
				vo.setIrum(rs.getString("irum"));
				vo.setMid(rs.getString("mid"));
				vo.setPhone(rs.getString("phone"));
				vo.setPhoto(rs.getString("photo"));
				
				list.add(vo);
			}
			conn.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public MemberVo view(String mid) {
		MemberVo vo = new MemberVo();
		try {
			sql = "select * from member where mid=? ";
			ps = conn.prepareStatement(sql);
			ps.setString(1, mid);
			
			rs=ps.executeQuery();
			if(rs.next()) {
				vo.setAddress(rs.getString("address"));
				vo.setAddress2(rs.getString("address2"));
				vo.setIrum(rs.getString("irum"));
				vo.setMid(rs.getString("mid"));
				vo.setZip(rs.getString("zip"));
				vo.setPhone(rs.getString("phone"));
				vo.setPhoto(rs.getString("photo"));
				
			}
			conn.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return vo;
	}
	//table삭제 file 삭제
	public String delete(String mid, String pwd, String delFile) {
		String msg = "";
		AES aes = new AES();
		String newPwd="";
		
		try {
			conn.setAutoCommit(false);
			
			//기존 암호를 갖고와 복호화
			sql="select pwd from member where mid=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, mid);
			rs=ps.executeQuery();
			if(rs.next()) {
				newPwd = rs.getString("pwd");//암호화된 암호
			}
			newPwd = aes.decrypt(newPwd);//암호가 복호화됨.1111
			if(! pwd.equals(newPwd)) {
				msg="삭제중 오류 발생";
				throw new Exception();
			}
			
			
			sql = "delete from member where mid=? ";
			ps = conn.prepareStatement(sql);
			ps.setString(1, mid);			
			
			int c = ps.executeUpdate();
			if(c>0) {
				File file = new File(MemberDao.uploadPath + delFile);
				if(file.exists()) file.delete();
				conn.commit();
				msg="자료가 삭제되었습니다.";
			}else {
				conn.rollback();
				msg="삭제중 오류가 발생하였습니다.";
			}
			conn.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return msg;
	}
	
	public String insert(MemberVo vo) {
		String msg="회원정보가 저장되었습니다.";
		try {
			sql = "insert into member(mid,irum,pwd,phone,zip,address,address2,photo) values(?,?,?,?,?,?,?,?)";
			conn.setAutoCommit(false);
			ps=conn.prepareStatement(sql);
			ps.setString(1, vo.getMid());
			ps.setString(2, vo.getIrum());
			ps.setString(3, vo.getPwd());
			ps.setString(4, vo.getPhone());
			ps.setString(5, vo.getZip());
			ps.setString(6, vo.getAddress());
			ps.setString(7, vo.getAddress2());
			ps.setString(8, vo.getPhoto());
			
			int c = ps.executeUpdate();
			if(c>0) {
				conn.commit();
			}else {
				conn.rollback();
				File file = new File(uploadPath+vo.getPhoto());
				if(file.exists()) file.delete();
				msg="회원 정보 저장중 오류가 발생하였습니다.";
			}
			conn.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return msg;
	}
	
	//첨부파일 유무에 따른 조회 > table 정보를 수정 > 파일 삭제
	public String update(MemberVo vo) {
		String msg="회원 정보가 수정되었습니다.";
		int c=0;
		try {
			conn.setAutoCommit(false);
			if(vo.getPhoto()==null) {
				sql = "update member set "
					+ "irum=?, phone=?, zip=?, address=?, address2=? "
					+ "where pwd=? and mid=? ";
				ps = conn.prepareStatement(sql);
				ps.setString(1, vo.getIrum());
				ps.setString(2, vo.getPhone());
				ps.setString(3, vo.getZip());
				ps.setString(4, vo.getAddress());
				ps.setString(5, vo.getAddress2());
				
				ps.setString(6, vo.getPwd());
				ps.setString(7, vo.getMid());
				
				c = ps.executeUpdate();
				
			}else {
				sql = "update member set "
						+ "irum=?, phone=?, zip=?, address=?, address2=?, photo=? "
						+ "where pwd=? and mid=? ";
				ps = conn.prepareStatement(sql);
				ps.setString(1, vo.getIrum());
				ps.setString(2, vo.getPhone());
				ps.setString(3, vo.getZip());
				ps.setString(4, vo.getAddress());
				ps.setString(5, vo.getAddress2());
				ps.setString(6, vo.getPhoto());
					
				ps.setString(7, vo.getPwd());
				ps.setString(8, vo.getMid());
					
				c = ps.executeUpdate();
			}
			if(c>0) {
				conn.commit();
				if(vo.getPhoto() != null) {//사용자가 이미지를 변경한 경우
					File file = new File(uploadPath + vo.getDelFile()); //삭제할 파일을 찾아라
					if(file.exists()) file.delete();
				}
				
			}else {
				conn.rollback();
				if(vo.getPhoto() != null) {
					File file = new File(uploadPath + vo.getPhoto()); //
					if(file.exists()) file.delete();
				}
				msg="회원 정보 수정중 오류가 발생하였습니다.";
			}
			conn.close();
		}catch(Exception e) {
			e.printStackTrace();
			msg= e.toString();
		}
		return msg;
	}
	
	public boolean idCheck(String checkId) {
		boolean b = true;
		try {
			sql = "select mid from member where mid=? ";
			ps = conn.prepareStatement(sql);
			ps.setString(1, checkId);
			rs = ps.executeQuery();
			if(rs.next()) {
				b=false;
			}
		}catch(Exception e) {
			e.printStackTrace();
			b = false;
		}
		return b;
	}
	
	
	public Page getPage() {return page;}
	public void setPage(Page page) {this.page = page;}
	
}

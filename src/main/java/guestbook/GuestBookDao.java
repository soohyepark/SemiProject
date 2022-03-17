package guestbook;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.DBConn;

public class GuestBookDao {
	Page page;
	Connection conn;
	PreparedStatement ps;
	ResultSet rs;
	
	public GuestBookDao() {
		conn = new DBConn().getConn();
		
		if(conn != null) {
			System.out.println("connection...ok");
		}
	}
	public boolean insert(GuestBookVo vo) {
		boolean b = false;
		String sql = "insert into guestbook(mid,mdate,doc,pwd) values(?,?,?,?)";
		try {
			conn.setAutoCommit(false);
			ps = conn.prepareStatement(sql);
			ps.setString(1, vo.getMid());
			ps.setString(2, vo.getMdate());
			ps.setString(3, vo.getDoc());
			ps.setString(4, vo.getPwd());
			
			int cnt = ps.executeUpdate();
			if(cnt>0) {
				b=true;
				conn.commit();
			}
			conn.close();
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return b;
	}
	
	public List<GuestBookVo> select(String findStr, String n){
		int ts = 0;
		int np = Integer.parseInt(n);
		List<GuestBookVo> list = new ArrayList<GuestBookVo>();
		try {
			//totSize를 가져오기 위한 검색 쿼리 실행
			String sql = "select count(num) totSize from guestbook where mid=? or doc like ? ";
			ps = conn.prepareStatement(sql);
			ps.setString(1, findStr);
			ps.setString(2, "%"+findStr+"%");
			
			rs = ps.executeQuery();
			
			if(rs.next()) {
				//System.out.println(rs.getInt("totSize"));
				ts = rs.getInt("totSize");
			}
			page = new Page(ts, np);
			
			//page 객체에서 계산된 startNo,endNo까지 리스트 처리
			sql = "select * from guestbook where mid=? or doc like ? limit ?,? ";
			ps = conn.prepareStatement(sql);
			ps.setString(1, findStr);
			ps.setString(2, "%"+findStr+"%");
			ps.setInt(3, page.getStartNo()-1);
			ps.setInt(4, page.getListSize());
			
			rs = ps.executeQuery();
			while(rs.next()) {
				GuestBookVo vo = new GuestBookVo();
				vo.setNum(rs.getInt("num"));
				vo.setMid(rs.getString("mid"));
				vo.setMdate(rs.getString("mdate"));
				vo.setDoc(rs.getString("doc"));
				vo.setPwd(rs.getString("pwd"));
				
				list.add(vo);
			}
			conn.close();
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return list;
	}
	
	public boolean update(GuestBookVo vo) {
		boolean b = false;
		String sql = "update guestbook set doc=? where num=?";
		try {
			conn.setAutoCommit(false);
			ps = conn.prepareStatement(sql);
			ps.setString(1, vo.getDoc());
			ps.setInt(2, vo.getNum());
			
			int cnt = ps.executeUpdate();
			if(cnt>0) {
				b=true;
				conn.commit();
			}
			conn.close();
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return b;
	}
	
	public boolean delete(String delValue) {
		boolean b = false;
		try {
			String sql = String.format("delete from guestbook where num in(%s) ", delValue);
			conn.setAutoCommit(false);
			ps = conn.prepareStatement(sql);
			
			int cnt = ps.executeUpdate();
			if(cnt>0) {
				b=true;
				conn.commit();
			}
			conn.close();
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return b;
	}
	
	public Page getPage() {return page;}
	public void setPage(Page page) {this.page = page;}
	
	
}

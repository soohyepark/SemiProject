package guestbookMybatis;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import mybatis.MybaFactory;

public class GuestBookDao {
	Page page;
	
	SqlSession session;
	
	public GuestBookDao() {
		session = MybaFactory.getFactory().openSession();
		
	}
	public boolean insert(GuestBookVo vo) {
		boolean b = false;
		try {
			int cnt = session.insert("guestbook.insert",vo);
			if(cnt>0) {
				session.commit();
				b=true;
			}else {
				session.rollback();
			}
			session.close();
		
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return b;
	}
	
	public List<GuestBookVo> select(String findStr, String n){
		int ts = 0;
		int np = Integer.parseInt(n);
		String sql="";
		List<GuestBookVo> list = new ArrayList<GuestBookVo>();
		try {
			page = new Page();
			page.setFindStr(findStr);
			ts = session.selectOne("guestbook.totSize", findStr); //dbconn연결 selectone:select된 건수가 하나다.
			
			page.setTotSize(ts);
			page.setNowPage(np);
			page.pageCompute();
			
			list = session.selectList("guestbook.search", page); //dbconn연결 selectList select하는데 List타입
			
			session.close();
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return list;
	}
	
	public boolean update(GuestBookVo vo) {
		boolean b = false;
		try {
			int cnt = session.update("guestbook.update",vo);
			
			if(cnt>0) {
				session.commit();
				b=true;
			}else {
				session.rollback();
			}
			session.close();
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return b;
	}
	
	public boolean delete(String delValue) { //delValue = 1,2,3,4이런식으로 들어오기때문에 쿼리${}써야함
		boolean b = false;
		try {
			int cnt = session.delete("guestbook.delete",delValue);
			if(cnt>0) {
				session.commit();
				b=true;
			}else {
				session.rollback();
			}
			session.close();
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return b;
	}
	
	public Page getPage() {return page;}
	public void setPage(Page page) {this.page = page;}
	
	
}

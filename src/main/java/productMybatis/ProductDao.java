package productMybatis;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import bean.DBConn;

import mybatis.MybaFactory;

public class ProductDao {
	Page page;
	SqlSession session;
	
	Connection conn;
	PreparedStatement ps;
	ResultSet rs;
	
	public ProductDao() {
		try {
			session = MybaFactory.getFactory().openSession();
			conn = new DBConn().getConn();
		}catch(Exception ex) {
			ex.printStackTrace();
		}
	}
	public List<ProductVo> select(String f, String n) {
		int ts = 0;//totSize
		int np = Integer.parseInt(n);
		List<ProductVo> list = new ArrayList<ProductVo>();
		//totSize를 가져오기 위한 검색 쿼리 실행
		try {
			
			ts = session.selectOne("product.totSize",f);
			
			page = new Page(ts,np);
			page.setFindStr(f);
			list = session.selectList("product.search",page);
			/*
			page = new Page();
			page.setFindStr(f);
			ts = session.selectOne("product.totSize",f);
			
			page.setTotSize(ts);
			page.setNowPage(np);
			page.pageCompute();
			list = session.selectList("product.search",page);
			*/
			
			
			session.close();
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		
		return list;
	}
	
	public ProductVo view(String serial) {
		ProductVo vo = new ProductVo();
		int s = Integer.parseInt(serial);
		try {
			vo = session.selectOne("product.view",serial);
			session.close();
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return vo;
	}
	
	public boolean update(ProductVo vo) {
		boolean b = false;
		try {
			int c= session.update("product.update",vo);
			if(c>0){
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
	
	public List<PartsVo> selectParts(String code){
		List<PartsVo> partsList = new ArrayList<PartsVo>();
		try {
			partsList = session.selectList("product.selectParts",code);
			
			session.close();
					
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return partsList;
	}
	
	public boolean delete(String serial) {
		boolean b= false;
		try {
			int c =  session.delete("product.delete",serial);
			
			if(c>0){
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
	
	public boolean insert(ProductVo vo) {
		boolean b = false;
		try {
			int c= session.insert("product.insert",vo);
			
			if(c>0){
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

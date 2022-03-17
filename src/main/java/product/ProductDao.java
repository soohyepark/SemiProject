package product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import bean.DBConn;

public class ProductDao {
	Page page;
	Connection conn;
	PreparedStatement ps;
	ResultSet rs;
	
	public ProductDao() {
		try {
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
		String sql = "select count(pd.serial) totSize from products pd join parts p on pd.code=p.code "
				   + "where pd.mdate like ? or pd.code like ? or p.codeName like ? ";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, "%"+f+"%");
			ps.setString(2, "%"+f+"%");
			ps.setString(3, "%"+f+"%");
			
			rs = ps.executeQuery();
			if(rs.next()) {
				//System.out.println(rs.getInt("totSize"));
				ts = rs.getInt("totSize");
			}
			page = new Page(ts, np);
			
			//page 객체에서 계산된 startNo,endNo까지 리스트 처리
			sql = "select * from products pd join parts p on pd.code=p.code "
				+ "where pd.mdate like ? or pd.code like ? or p.codeName like ? "
				+ "order by mdate desc "
				+ "limit ?, ? ";
			
			ps = conn.prepareStatement(sql);
			ps.setString(1, "%"+f+"%");
			ps.setString(2, "%"+f+"%");
			ps.setString(3, "%"+f+"%");
			ps.setInt(4, page.getStartNo()-1);
			ps.setInt(5, page.getListSize());
			
			rs = ps.executeQuery();
			while(rs.next()) {
				ProductVo vo = new ProductVo();
				vo.setSerial(rs.getInt("serial"));
				vo.setMdate(rs.getString("mdate"));
				vo.setCode(rs.getString("code"));
				vo.setCodeName(rs.getString("codeName"));
				vo.setPrice(rs.getInt("price"));
				vo.setEa(rs.getInt("ea"));
				vo.setAmt(vo.getPrice()*vo.getEa());
				
				list.add(vo);
			}
			//ps.close();
			conn.close();
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		
		return list;
	}
	
	public ProductVo view(String serial) {
		ProductVo vo = new ProductVo();
		int s = Integer.parseInt(serial);
		try {
			String sql = "select * from products pd join parts p on pd.code=p.code "
					   + "where pd.serial=? ";
			
			ps = conn.prepareStatement(sql);
			ps.setInt(1, s);
			rs = ps.executeQuery();
			while(rs.next()) {
				vo.setCode(rs.getString("code"));
				vo.setCodeName(rs.getString("codeName"));
				vo.setPrice(rs.getInt("price"));
				vo.setMdate(rs.getString("mdate"));
				vo.setEa(rs.getInt("ea"));
				break;
			}
			conn.close();
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return vo;
	}
	
	public boolean update(ProductVo vo) {
		boolean b = false;
		try {
			String sql = "update products set ea=?, mdate=?, code=? "
					   + "where serial = ?";
			conn.setAutoCommit(false);
			ps = conn.prepareStatement(sql);
			ps.setInt(1, vo.getEa());
			ps.setString(2, vo.getMdate());
			ps.setString(3, vo.getCode());
			ps.setInt(4, vo.getSerial());
			
			int c = ps.executeUpdate();
			if(c>0) {
				b=true;
				conn.commit();
			}
			conn.close();
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return b;
	}
	
	public List<PartsVo> selectParts(String code){
		List<PartsVo> partsList = new ArrayList<PartsVo>();
		try {
			String sql = "select * from parts where code like ? or codeName like ? ";
			ps = conn.prepareStatement(sql);
			ps.setString(1, "%"+code+"%");
			ps.setString(2, "%"+code+"%");
			
			rs = ps.executeQuery();
			while(rs.next()) {
				PartsVo pVo = new PartsVo();
				pVo.setCode(rs.getString("code"));
				pVo.setCodeName(rs.getString("codeName"));
				pVo.setSpec(rs.getString("spec"));
				pVo.setPrice(rs.getInt("price"));
				
				partsList.add(pVo);
				
			}
			conn.close();
					
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return partsList;
	}
	
	public boolean delete(String serial) {
		boolean b= false;
		try {
			String sql = "delete from products where serial=?";
			conn.setAutoCommit(false);
			ps = conn.prepareStatement(sql);
			ps.setString(1, serial);
			int c = ps.executeUpdate();
			if(c>0) {
				conn.commit();
				b=true;
			}else {
				conn.rollback();
			}
			conn.close();
		}catch(Exception ex) {
			ex.printStackTrace();
		}
		return b;
	}
	
	public boolean insert(ProductVo vo) {
		boolean b = false;
		try {
			String sql = "insert into products(code,mdate,ea) values(?,?,?) ";
			conn.setAutoCommit(false);
			
			ps = conn.prepareStatement(sql);
			ps.setString(1, vo.getCode());
			ps.setString(2, vo.getMdate());
			ps.setInt(3, vo.getEa());
			
			int c = ps.executeUpdate();
			if(c>0) {
				b = true;
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

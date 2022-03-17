package mybatis;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import bean.AES;
import member.MemberVo;
import product.ProductVo;

public class DynamicDao {
	SqlSession session; //Connection
	
	public DynamicDao() {
		session = MybaFactory.getFactory().openSession();
	}
	
	public void methodIf() {
		List<ProductVo> list = session.selectList("dynamic_sql.if",200);
		System.out.println("list size : "+list.size());
	}
	
	public void methodIf2() {
		List<ProductVo> list2 = session.selectList("dynamic_sql.if2","p1");
		System.out.println("code : "+list2.size());
	}
	
	public void methodChoose() {
		List<ProductVo> list = session.selectList("dynamic_sql.choose","2021-11");
		System.out.println("list size : "+list.size());
	}
	
	public void methodWhere() {
		List<ProductVo> list = session.selectList("dynamic_sql.where","p1");
		System.out.println("list size : "+list.size());
	}
	
	public void methodUpdate() {
		MemberVo vo = new MemberVo();
		AES aes = new AES();
		String temp = aes.encrypt("1234");
		
		vo.setMid("hong1");
		vo.setPwd(temp);
		
		int cnt = session.update("dynamic_sql.update",vo);
		if(cnt>0) session.commit();
		else session.rollback();
		session.close();
	}
	
	public static void main(String[] args) {
		DynamicDao dao = new DynamicDao();
		//dao.methodIf();
		//dao.methodIf2();
		//dao.methodChoose();
		//dao.methodWhere();
		dao.methodUpdate();

	}

}

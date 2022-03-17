package memberMybatis;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import bean.AES;
import mybatis.MybaFactory;

public class MemberDao {
	public static String uploadPath = 
			"C:\\Users\\pooh3\\eclipse-workspace\\WebProject\\src\\main\\webapp\\upload/";
	
	Page page;
	SqlSession session;
	
	public MemberDao() {
		try {
			session = MybaFactory.getFactory().openSession();
		}catch(Exception ex) {
			ex.printStackTrace();
		}
	}
	
	public MemberVo login(String mid, String pwd) {
		MemberVo vo = new MemberVo();
		String newPwd = "";
		AES aes = new AES();
		try {
			vo = session.selectOne("member.login",mid);
			newPwd = aes.decrypt(vo.getPwd());
			
			if(!pwd.equals(newPwd)) {
				vo = null;
			}
			session.close();

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
			int ts = session.selectOne("member.totSize",f);
			
			page = new Page(ts,nowPage);
			page.setFindStr(f);
			
			list = session.selectList("member.search",page);
			
			session.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public MemberVo view(String mid) {
		MemberVo vo = new MemberVo();
		try {
			vo = session.selectOne("member.view",mid);
			session.close();
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
		MemberVo vo = null;
		
		try {
			vo = session.selectOne("member.view",mid);
			newPwd = aes.decrypt(vo.getPwd());
			
			if(!pwd.equals(newPwd)) {
				msg="삭제중 오류 발생";
				throw new Exception();
			}
			
			int c = session.delete("member.delete",mid);
			if(c>0) {
				File file = new File(MemberDao.uploadPath + delFile);
				if(file.exists()) file.delete();
				session.commit();
				msg="자료가 삭제되었습니다.";
			}else {
				session.rollback();
				msg="삭제중 오류가 발생하였습니다.";
			}
			
			session.close();
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return msg;
	}
	
	public String insert(MemberVo vo) {
		String msg="회원정보가 저장되었습니다.";
		try {
			int c = session.insert("member.insert",vo);
			
			if(c>0) {
				session.commit();
			}else {
				session.rollback();
				File file = new File(uploadPath+vo.getPhoto());
				if(file.exists()) file.delete();
				msg="회원 정보 저장중 오류가 발생하였습니다.";
			}
			session.close();
			
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
			c = session.update("member.update",vo);
			
			if(c>0) {
				session.commit();
				if(vo.getPhoto() != null) {//사용자가 이미지를 변경한 경우
					File file = new File(uploadPath + vo.getDelFile()); //삭제할 파일을 찾아라
					if(file.exists()) file.delete();
				}
				
			}else {
				session.rollback();
				if(vo.getPhoto() != null) {
					File file = new File(uploadPath + vo.getPhoto()); //
					if(file.exists()) file.delete();
				}
				msg="회원 정보 수정중 오류가 발생하였습니다.";
			}
			session.close();
				
		}catch(Exception e) {
			e.printStackTrace();
			msg= e.toString();
		}
		return msg;
	}
	
	public boolean idCheck(String checkId) {
		boolean b = true;
		try {
			String mid = session.selectOne("member.idCheck2",checkId);
			if(mid != null) {
				b=false;
			}
			
			/*
			b = session.selectOne("member.idCheck",checkId); //0이 false
			*/
			
			session.close();
		}catch(Exception e) {
			e.printStackTrace();
			b = false;
		}
		return b;
	}
		
	public Page getPage() {return page;}
	public void setPage(Page page) {this.page = page;}
	
}

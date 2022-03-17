package board;

import java.io.File;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.ibatis.session.SqlSession;

import bean.AES;
import mybatis.MybaFactory;

public class BoardDao {
	SqlSession session;
	Page page;
	AES aes;
	public BoardDao() {
		session = MybaFactory.getFactory().openSession();
	}
	
	public List<BoardVo> search(Page p){
		int totSize= session.selectOne("brd.totSize", p.getFindStr());
		p.setTotSize(totSize);
		p.pageCompute();
		this.page = p;
		
		List<BoardVo> list = session.selectList("brd.search", p);
		
		session.close();
		return list;
	}
	
	public boolean insert(BoardVo vo) {//본문 내용만 저장
		boolean b = false;
		try {
			int c = session.insert("brd.insert",vo);
			if(c>0) {
				session.commit();
				b=true;
				
			}else {
				session.rollback();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		session.close();
		return b;
	}
	public boolean insertAtt(BoardVo vo, String job) {//파일만 저장하도록
		boolean b = false;
		int c = 0;
		try {
			//첨부 파일 정보 저장
			for(BoardAtt att : vo.getAttList()) {
				if(job.equals("i") || job.equals("r")) {
					c += session.insert("brd.attInsert", att);
				}else if(job.equals("m")) {
					c += session.insert("brd.attModify",att);
				}
			}
			if(c == vo.getAttList().size()) {
				session.commit();
				b=true;
								
			}else {
				session.rollback();
			}
			session.close();
				
		}catch(Exception e) {
			e.printStackTrace();
		}
		return b;
	}
	public BoardVo view(String serial) {
		BoardVo vo = null;
		List<BoardAtt> attList = null;
		//int s = Integer.parseInt(serial);
		try {
			
			vo = session.selectOne("brd.view",serial);
			attList = session.selectList("brd.attList",serial);
			
			vo.setAttList(attList);	
			
			int c = session.update("brd.hitUp",vo);
			if(c>0) {
				session.commit();
			}else {
				session.rollback();
			}
			
			session.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return vo;
	}
	public boolean modify(BoardVo vo) {//본문 내용만 저장
		boolean b = false;
		try {	
			int c = session.update("brd.modify",vo); //본문수정
			if(c>0) {//본문글이 수정된 경우
				
				//boardAtt table 삭제
				if(vo.getDelList().size()>0) {
					session.delete("brd.deleteAtt",vo.getDelList());
				}
				session.commit();
				b=true;
				
				//파일삭제
				for(String del : vo.getDelList()) {
					File delFile = new File(FileUpload.uploadPath + del);
					if(delFile.exists()) delFile.delete();
				}
			}else {
				session.rollback();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		session.close();
		return b;
	}
	public boolean modifyAtt(BoardVo vo) {//파일만 저장하도록
		boolean b = false;
		try {
			//첨부 파일 정보 저장
			for(BoardAtt att : vo.getAttList()) {
				int c2 = session.insert("brd.attModify", att);
				if(c2 <=0) {
					session.rollback();
					throw new Exception();					
				}
			}
			session.commit();
			b=true;
				
		}catch(Exception e) {
			e.printStackTrace();
		}
		session.close();
		return b;
	}
	//1)board, boardAtt 테이블 정보를 삭제
	//2)doc안에 있는 이미지 정보를 찾아서 이미지 삭제
	//3)첨부파일 삭제
	public boolean delete(String serial, String pwd) {
		boolean b = false;
		//doc안에 있는 img 태그의 내용을 찾는 정규식
		String regex = "(<img src=\")(.+?)(\")";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = null;
		BoardVo vo = null;
		List<BoardAtt> attList = null;
		String path = "C:\\Users\\pooh3\\eclipse-workspace\\WebProject\\src\\main\\webapp/";	
		aes = new AES();
		pwd = aes.encrypt(pwd);
		try {
			vo = view(serial);
			vo.setPwd(pwd);
			session = MybaFactory.getFactory().openSession();
			matcher = pattern.matcher(vo.getDoc());
			
			//본문글 삭제
			int c = session.delete("brd.delete",vo);
			if(c>0) {
				b=true;
				//첨부파일 정보삭제
				if(vo.getAttList().size()>0) {
					session.delete("brd.deleteAttGrp",serial);
					
				}
				//2)doc안에 있는 이미지 파일삭제
				while(matcher.find()) {
					File delFile = new File(path + matcher.group(2));
					if(delFile.exists()) delFile.delete();
				}
				//3)첨부파일삭제
				for(BoardAtt att : vo.getAttList()) {
					File delFile = new File(FileUpload.uploadPath + att.getAttFile());
					if(delFile.exists()) delFile.delete();
				}
				session.commit();
			}else {
				session.rollback();
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		session.close();
		return b;
	}
	public boolean repl(BoardVo vo) {
		boolean b = false;
		try {
			//같은 grp 내에 있는 글들중에 본문글보다 큰 seq들의 값을 증가
			session.update("brd.seqUp",vo);
			int c = session.insert("brd.repl",vo);
			if(c>0) {
				session.commit();
				b = true;
			}else {
				session.rollback();
			}
			session.close();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return b;
	}

	public Page getPage() {return page;}
	public void setPage(Page page) {this.page = page;}
	
}

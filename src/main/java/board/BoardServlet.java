package board;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import bean.AES;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "*.brd")
public class BoardServlet extends HttpServlet{
	String url = "index.jsp?sub=./board/";
	RequestDispatcher rd;
	String job = "";
	Page page = new Page();
	BoardDao dao;
	String msg="";
	AES aes = new AES();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		job = "list";	
		doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String serial="";
		String pwd="";
		BoardVo vo=null;
		dao = new BoardDao();
		boolean b = false;
		if(req.getParameter("job") != null) {
			job = req.getParameter("job");
		}
		if(req.getParameter("nowPage") != null) {
			page.setNowPage(Integer.parseInt(req.getParameter("nowPage")));
		}
		if(req.getParameter("findStr") != null) {
			page.setFindStr(req.getParameter("findStr"));
		}
		if(req.getParameter("serial") != null) {
			serial = req.getParameter("serial");
		}
		
		req.setAttribute("page", page);
		
		switch(job) {
		case "list" :
			List<BoardVo> list = dao.search(page);
			page = dao.getPage();
			
			req.setAttribute("page",page);
			req.setAttribute("list",list);
			
			rd = req.getRequestDispatcher(url+"list.jsp");
			rd.forward(req, resp); //현재페이지를 list로
			break;
			
		case "view" :
			vo = dao.view(serial);
			req.setAttribute("vo", vo);
			rd = req.getRequestDispatcher(url+"view.jsp");
			rd.forward(req, resp); 
			break;
			
		case "insert" :
			rd = req.getRequestDispatcher(url+"insert.jsp");
			rd.forward(req, resp); 
			break;
			
		case "insertSave" :
			vo = setVo(req);
			b = dao.insert(vo);
			 
			break;	
		case "modify" :
			vo = dao.view(serial);
			req.setAttribute("vo", vo);
			rd = req.getRequestDispatcher(url+"modify.jsp");
			rd.forward(req, resp); 
			break;	
		case "modifySave" :
			vo = setVo(req);
			b = dao.modify(vo);
			
			break;
		case "delete" :
			pwd = req.getParameter("pwd");
			b = dao.delete(serial,pwd);
			if(b) {
				msg="자료가 삭제되었습니다.";
			}else {
				msg="자료 삭제중 오류가 발생하였습니다.";	
			}
			req.setAttribute("msg", msg);
			rd = req.getRequestDispatcher(url+"result.jsp");
			rd.forward(req, resp); 
			break;	
		case "repl" :
			vo = setVo(req);
			req.setAttribute("page", page);
			req.setAttribute("vo", vo);
			rd = req.getRequestDispatcher(url+"repl.jsp");
			rd.forward(req, resp); 
			break;
		case "replSave" :
			vo = setVo(req);
			b = dao.repl(vo);
			break;
		}
		
	}
	public BoardVo setVo(HttpServletRequest req) {
		BoardVo vo = new BoardVo();
		
		String mid = req.getParameter("mid");
		String subject = req.getParameter("subject");
		String doc = req.getParameter("doc");
		String pwd = aes.encrypt(req.getParameter("pwd"));
		
		vo.setMid(mid);
		vo.setSubject(subject);
		vo.setDoc(doc);
		vo.setPwd(pwd);
		
		if(job.equals("modifySave")) {
			String serial = req.getParameter("serial");
			String[] delFile = req.getParameterValues("delFile"); //checkbox는 다 배열
			if(delFile != null) {
				vo.setDelList(Arrays.asList(delFile));
			}
			vo.setSerial(Integer.parseInt(serial));	
		}else if(job.equals("replSave") || job.equals("repl")) {
			String grp = req.getParameter("grp");
			String seq = req.getParameter("seq");
			String deep = req.getParameter("deep");
			
			vo.setGrp(Integer.parseInt(grp));
			vo.setSeq(Integer.parseInt(seq));
			vo.setDeep(Integer.parseInt(deep));
		}
		
		return vo;
	}
	
}

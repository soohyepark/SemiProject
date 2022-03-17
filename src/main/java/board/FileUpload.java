package board;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import bean.AES;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@MultipartConfig(
		location = "c:/temp",
		maxFileSize = -1,
		maxRequestSize = -1,
		fileSizeThreshold = 2000
)
@WebServlet(urlPatterns = "*.boardUp")
public class FileUpload extends HttpServlet{
	String url = "index.jsp?sub=./board/";
	public static String uploadPath="C:\\Users\\pooh3\\eclipse-workspace\\WebProject\\src\\main\\webapp\\upload/";
	BoardDao dao;
	
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req,resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//req.setCharacterEncoding("utf-8");
		//resp.setContentType("text/html;charset=utf-8");
		AES aes = new AES();
		BoardVo vo = new BoardVo();
		Page page = new Page();
		dao = new BoardDao();
		String msg = "";
		boolean b = false;
		
		List<BoardAtt> attList = new ArrayList<BoardAtt>();
		List<String> delList = new ArrayList<String>();
		Collection<Part> parts = req.getParts();//업로드된 파일 목록
		UUID uuid = UUID.randomUUID();
		RequestDispatcher rd = null;
		
		String job = req.getParameter("job");//i or m or r
		
		
		String nowPage = req.getParameter("nowPage");
		String findStr = req.getParameter("findStr");
		String grp="";
		if(req.getParameter("grp")!=null) {
			grp = req.getParameter("grp");
			vo.setGrp(Integer.parseInt(grp));
		}
		
		page.setNowPage(Integer.parseInt(nowPage));
		page.setFindStr(findStr);
		
		for(Part p : parts) {
			if(p.getHeader("Content-Disposition").contains("filename=")){
				if(p.getSize()<=0) continue;
				
				String temp = String.format("%s-%s", uuid.getLeastSignificantBits(),p.getSubmittedFileName());
				p.write(uploadPath + temp);
				p.delete();
				
				BoardAtt att = new BoardAtt();
				att.setGrp(vo.getGrp());
				att.setAttFile(temp);
				attList.add(att);
			}	
		}
		vo.setAttList(attList);
		
		req.setAttribute("vo", vo);
		req.setAttribute("page", page);
		
		switch(job) {
		case "r" ://repl
		case "m" ://modify
			b = dao.insertAtt(vo,job);
			if(b) {
				msg="자료가 정상적으로 입력되었습니다.";
			}else {
				msg = "자료 입력중 오류가 발생하였습니다.";
			}
			break;
		case "i" ://insert
			b = dao.insertAtt(vo,job);
			if(b) {
				msg="자료가 정상적으로 입력되었습니다.";
			}else {
				msg = "자료 입력중 오류가 발생하였습니다.";
			}
			break;
		}
		req.setAttribute("msg", msg);
		rd = req.getRequestDispatcher(url + "result.jsp");
		rd.forward(req, resp);
	}
	
}

package member;

import java.io.IOException;
import java.util.Collection;

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
@WebServlet(urlPatterns = "*.up") //확장자up이 들어오면 파일 업로드라는 클래스를 실행시켜달라
public class FileUpload extends HttpServlet{
	String url = "index.jsp?sub=./member/";
	String findStr;
	String nowPage;
	String flag;
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		MemberVo vo = new MemberVo();
		Collection<Part> parts = req.getParts();
		
		flag = req.getParameter("flag"); //m(수정) or i(입력)
		findStr = req.getParameter("findStr");//페이징처리를 위해 가지고 오는
		nowPage = req.getParameter("nowPage");
		
		vo.setMid(req.getParameter("mid"));
		vo.setAddress(req.getParameter("address"));
		vo.setAddress2(req.getParameter("address2"));
		vo.setIrum(req.getParameter("irum"));
		vo.setPhone(req.getParameter("phone"));
		vo.setZip(req.getParameter("zip"));
		vo.setDelFile(req.getParameter("delFile"));
		//암호화
		AES aes = new AES();
		String encrypt = aes.encrypt(req.getParameter("pwd"));	
		vo.setPwd(encrypt);
		
		
		
		//System.out.println(vo.getMid());
		//System.out.println(vo.getIrum());
		
		for(Part p : parts) {//파일 업로드
			//System.out.println("name : "+p.getName());
			
			if(p.getHeader("Content-Disposition").contains("filename=")) {
				//System.out.println("file size : "+p.getSize());
				//System.out.println("file name : "+p.getSubmittedFileName());
				if(p.getSize()>0) {
					String temp = String.format("%s%s-%s", 
											MemberDao.uploadPath,
											vo.getMid(),
											p.getSubmittedFileName());
					p.write(temp);//파일 저장해라
					p.delete(); //temp 저장된 임시 파일 삭제
					
					vo.setPhoto(vo.getMid() + "-" + p.getSubmittedFileName());
				}
			}
		}//end for문
		req.setAttribute("vo", vo);
		req.setAttribute("nowPage", nowPage);
		req.setAttribute("findStr", findStr);
		
		RequestDispatcher rd = null;
		if(flag.equals("i")) {//입력에서 실행된 경우
			rd = req.getRequestDispatcher(url+"insert_result.jsp");
		}else if(flag.equals("m")) {//수정에서 실행된 경우
			rd = req.getRequestDispatcher(url+"modify_result.jsp");
		}
		rd.forward(req, resp);//제어권을 포워드해라 현재페이지를 저기로 넘겨라
		
	}
	
}

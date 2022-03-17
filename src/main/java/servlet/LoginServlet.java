package servlet;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.MemberDao;
import member.MemberVo;

@WebServlet(urlPatterns = "*.login")
public class LoginServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//mid,pwd를 req에서 가져오기
		String mid = req.getParameter("loginMid");
		String pwd = req.getParameter("loginPwd");
		MemberVo vo = null;
		
		HttpSession session = req.getSession();
		
		if(mid == null) { //로그아웃할때
			session.removeAttribute("vo");
			
		}else {
		
			//MemberDao.login(mid,pwd)를 실행하여 관련 데이터가 있는지 비교
			MemberDao dao = new MemberDao();
			vo = dao.login(mid,pwd);
			
			//있으면 MemberVo 값을 설정하여 session에 담아 반환,사라지면 안되는 정보를 session에 담는다.
			session.setAttribute("vo", vo);
		}
		//forwarding..
		RequestDispatcher rd = req.getRequestDispatcher("index.jsp");
		rd.forward(req, resp);
		
	}
	
}

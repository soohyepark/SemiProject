package servlet;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "*.gugudan")
public class GuGudanServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("get...........");
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int dan = Integer.parseInt(req.getParameter("dan"));
		String msg="";
		System.out.println("post..........."+dan);
		for(int i=1; i<10; i++) {
			msg += String.format("%s * %s = %s<br/>", dan, i, (dan*i));
		}
		//servlet에 요청된 거를 누가 처리할것인가 화면을 바꿔라 저기로
		RequestDispatcher rd =  req.getRequestDispatcher("./servlet_test.jsp");
		req.setAttribute("msg", msg);
		rd.forward(req, resp);
		
	}
/*
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("get or post...........");
	}
*/
}

package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "*.output")
public class HtmlOutputServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//이렇게 잘 안씀 MVC분리가 안되기 때문에 비추
		req.setCharacterEncoding("utf-8");
		resp.setContentType("text/html; charset=utf-8");
		
		PrintWriter out = resp.getWriter();//응답으로 내보낼 출력 스트림
		out.println("안녕");
		
		out.print("<script>");
		out.print(" alert('경고닷');");
		out.print(" location.href='http://www.naver.com';");
		out.print("</script>");
		
		
		
	}
	
}

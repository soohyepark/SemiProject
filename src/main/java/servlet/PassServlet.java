package servlet;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "*.pass")
public class PassServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int w = Integer.parseInt(req.getParameter("weight"));
		int h = Integer.parseInt(req.getParameter("height"));
		String msg = "";
		if(w<=150 && h<=200) {
			msg = "승차가능";
		}else {
			msg = "승차불가";
		}
		
		RequestDispatcher rd = req.getRequestDispatcher("./pass.jsp");
		//attribute는 setting getting다됨, parameter는 get만 readonly라서 
		req.setAttribute("msg", msg);
		req.setAttribute("weight", w);
		req.setAttribute("height", h);
		rd.forward(req, resp);
		
	}
	
}

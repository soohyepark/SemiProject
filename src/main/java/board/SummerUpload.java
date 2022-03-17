package board;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(urlPatterns = "*.summerUp")
public class SummerUpload extends HttpServlet{
	public static String uploadPath="C:\\Users\\pooh3\\eclipse-workspace\\WebProject\\src\\main\\webapp\\upload/";
	UUID uuid = null;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		resp.setContentType("text/html;charset=utf-8");
		PrintWriter out = resp.getWriter();
		String flag = "";//삭제시 필요
		if(req.getParameter("flag") != null) {
			flag = req.getParameter("flag");
		}
		if(flag.equals("delete")) { //target : (./upload/abc.png)
			String target = req.getParameter("target");
			String[] temp = target.split("/");
			File delFile = new File(uploadPath + temp[temp.length-1]);
			if(delFile.exists()) delFile.delete();
			
		}else {
			Collection<Part> parts = req.getParts();//업로드된 파일 목록
			for(Part p : parts) {
				if(p.getHeader("Content-Disposition").contains("filename=")){
					if(p.getSize()<=0) continue;
					uuid = UUID.randomUUID();
					String temp = String.format("%s-%s", uuid.getLeastSignificantBits(),p.getSubmittedFileName());
					p.write(uploadPath + temp);
					p.delete();
					
					out.print("./upload/" + temp);//ajax에게 저장정보를 리턴하는 역할	
				}	
			}
		}
	}
	
}

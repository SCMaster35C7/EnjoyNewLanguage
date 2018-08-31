package global.sesoc.Youtube.interceptor;

import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		HttpSession session = request.getSession();
		
		String contextPath = request.getContextPath();
		String useremail 	= (String) session.getAttribute("useremail");
		String requestURI = request.getRequestURI();
		String uri = requestURI.substring(requestURI.lastIndexOf("/")+1);
		int admin		= (Integer) session.getAttribute("admin") == null ? 2 :  (Integer) session.getAttribute("admin");
		
		System.out.println("사용자 이메일 : "+useremail);
		System.out.println("contextPath : "+contextPath);
		System.out.println("requestURI : "+requestURI);
		System.out.println("uri : "+uri);
		System.out.println("admin : "+admin);
		
		if (useremail == null) {
			System.out.println("여기 들어옴");
			//response.sendRedirect(contextPath+"/");
			request.setAttribute("plzLogin", "로그인이 필요한 서비스입니다~");
			/*PrintWriter printwriter = response.getWriter();

			printwriter.print("<script>alert('you have to login for using the service');</script>");

			
			printwriter.flush();
			printwriter.close();*/
			
			request.getRequestDispatcher("./").forward(request, response);
			
			//response.sendRedirect(contextPath+"/");
			/*RequestDispatcher dispatcher=request.getRequestDispatcher("");

			 dispatcher.forward(request, response);		*/
			return false;
			//
			
			//return false;
		}
		return true;
		
	}
}

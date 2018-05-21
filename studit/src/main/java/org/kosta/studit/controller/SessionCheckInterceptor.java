package org.kosta.studit.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
/**
 * Spring Handler Interceptor : 
	DispatcherServlet이 해당 컨트롤러를 호출하기 전,후에 요청과 응답을
	제어하는 역할을 한다. 
	 
	컨트롤러 실행전  preHandle(request,response,handler) 
	컨트롤러 실행후 postHandle(request,response,handler)
	응답완료 afterCompletion(request,response,handler)
	Spring에서 제공하는 HandlerInterceptorAdapter 를 상속받아 
	위와 같은 메서드를 오버라이딩해서 사용한다
 */
public class SessionCheckInterceptor extends HandlerInterceptorAdapter{
	/**
	 * 해당 컨드롤러가 수행되기 전에 실행되는 메소드
	 * 리턴하는 boolean 정보가 true이면 컨트롤러가 실행되고,
	 * 리턴하는 boolean 정보가 false이면 컨트롤러가 실행되지 않는다
	 * 
	 * 로그인 확인해서 로그인 되어 있으면 true 반환
	 * 아니면 false 반환
	 * 
	 * request.getSession(false)
	 * 	session이 null인지 확인
	 * 	session null 아니면 인증정보 객체 유무 확인
	 * 	1,2을 통과하면 true/ 아니면 false
	 * 	반환 전에 response.sendRedirect("")
	 */
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session=request.getSession(false);
		if(session!=null&&session.getAttribute("memberVO")!=null) {
			return true;
		}else {
			response.sendRedirect(" /studit/loginNeed");
			return false;
			
		}
	}
}

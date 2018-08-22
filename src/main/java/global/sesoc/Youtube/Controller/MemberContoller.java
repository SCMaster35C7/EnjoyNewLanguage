package global.sesoc.Youtube.Controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.Youtube.dao.MemberRepository;
import global.sesoc.Youtube.dto.Member;

@Controller
public class MemberContoller {
	@Autowired
	MemberRepository mRepository;
	
	/**
	 * 로그인 페이지로 이동한다.
	 * 
	 * @return
	 */
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String login() {
		
		return "Member/login";
	}
	
	/**
	 * 로그인 정보를 확인하여 로그인 판단을 해준다.
	 * 
	 * @param useremail
	 * @param userpwd
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String login(String useremail, String userpwd, HttpSession session, Model model) {
		Member member = mRepository.selectOneFromMember(useremail, userpwd);
		
		if(member != null) {
			session.setAttribute("useremail", member.getUseremail());
			session.setAttribute("admin", member.getAdmin());
			System.out.println(member);
			return "redirect:/";
		}else {
			model.addAttribute("useremail", useremail);
			model.addAttribute("userpwd",userpwd);
			model.addAttribute("message", "아이디나 비밀번호가 틀렸습니다.");
			
			return "Member/login";
		}
	}
	
	/**
	 * 로그아웃을 해준다.
	 * 
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		
		return "redirect:/";
	}
	
	/**
	 * 회원가입 페이지로 이동한다.
	 * 
	 * @return
	 */
	@RequestMapping(value="/joinForm", method=RequestMethod.GET)
	public String joinForm() {
		
		return "Member/joinForm";
	}
	
	/**
	 * 이메일 검증을 해준다.
	 * 
	 * @param useremail
	 * @return
	 */
	@RequestMapping(value="/emailCheck", method=RequestMethod.POST, produces="application/json; charset=utf-8")
	public @ResponseBody String emailCheck(@RequestBody String useremail) {
		System.out.println(useremail);
		return "중복";
	}
}

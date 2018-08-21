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
	
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String login() {
		
		return "Member/login";
	}
	
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
	
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		
		return "redirect:/";
	}
	
	@RequestMapping(value="/joinForm", method=RequestMethod.GET)
	public String joinForm() {
		
		return "Member/joinForm";
	}
	
	@RequestMapping(value="/emailCheck", method=RequestMethod.POST, produces="application/json; charset=utf-8")
	public @ResponseBody String emailCheck(@RequestBody String useremail) {
		System.out.println(useremail);
		return "중복";
	}
	@RequestMapping(value="/updateMember", method=RequestMethod.GET)
	public String updateMember() {
		
		return "Member/updateMember";
	}
	
	@RequestMapping(value="/updateMember", method=RequestMethod.POST)
	public String updateMember(Member member) {
		int result = mRepository.updateMember(member);
		
		System.out.println(result);
		
		return "redirect:/";
	}
}

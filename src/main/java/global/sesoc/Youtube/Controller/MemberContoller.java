package global.sesoc.Youtube.Controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

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
	public String login(String userid, String userpwd, HttpSession session, Model model) {
		Member member = mRepository.selectOneFromMember(userid, userpwd);
		
		if(member != null) {
			session.setAttribute("userid", member.getUserid());
			session.setAttribute("admin", member.getAdmin());
			System.out.println(member);
			return "redirect:/";
		}else {
			model.addAttribute("userid", userid);
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
	@RequestMapping(value="/updateMember", method=RequestMethod.GET)
	public String updateMember() {
		
		return "Member/updateMember";
	}
	
	@RequestMapping(value="/updateMember", method=RequestMethod.POST)
	public String updateMember(Member member) {
		int result = mRepository.updateMember(member);
		return "redirect:/";
	}
}

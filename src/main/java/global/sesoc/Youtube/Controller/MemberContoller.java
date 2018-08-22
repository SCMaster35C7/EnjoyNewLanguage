package global.sesoc.Youtube.Controller;


import javax.mail.MessagingException;
import javax.mail.Message.RecipientType;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
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
	
	 @Autowired
	  private JavaMailSender mailSender;
	
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String login() {
		
		return "Member/login";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String login(String useremail, String userpwd, HttpSession session, Model model) {
		
		Member m = new Member();
		m.setUseremail(useremail);
		m.setUserpwd(userpwd);
		
		Member member = mRepository.selectOneFromMember(m);
		
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
	public @ResponseBody String emailCheck(String useremail) {
		//System.out.println("이메일 아이디 : "+useremail);
		
		
		Member m = new Member();
		m.setUseremail(useremail);
		if (mRepository.selectOneFromMember(m)==null) {
			return "사용 가능한 이메일 입니다";
		} else 	return "이미 가입한 이메일 입니다";

	}
	
	@RequestMapping(value="/nickCheck", method=RequestMethod.POST, produces="application/json; charset=utf-8")
	public @ResponseBody String nickCheck(String usernick) {
		
		if (mRepository.selectByNick(usernick)==null) {
			return "사용 가능한 닉네임 입니다";
		} else 	return "중복된 닉네임 입니다";

	}
	
	
	
	
	@RequestMapping(value = "mailSending", method=RequestMethod.POST)
	  public String mailSending(HttpServletRequest request, Member member, HttpSession session) {
	   System.out.println("횐갑하는넘**********"+member);
		
		mRepository.insertMember(member);
		session.setAttribute("useremail", member.getUseremail());
		
		
	    String setfrom = "timetravelwithdoctor@gmail.com";         
	   // String tomail  = request.getParameter("tomail");     // 받는 사람 이메일
	    String tomail  = member.getUseremail();    // 받는 사람 이메일
	    
	    //String title   = request.getParameter("[앤죠애캉] 회원 가입 인증");      // 제목
	    //String content = request.getParameter("content");    // 내용
	    //String content ="안녕하세요~ 인증하시려면 아래 버튼을 누르셈\n\r";
	    
	    
	    try {
	      MimeMessage message = mailSender.createMimeMessage();
	      MimeMessageHelper messageHelper 
	                        = new MimeMessageHelper(message, true, "UTF-8");
	 
	      messageHelper.setFrom(setfrom);  // 보내는사람 생략하거나 하면 정상작동을 안함
	      messageHelper.setTo(member.getUseremail());     // 받는사람 이메일
	      messageHelper.setSubject("[앤죠애캉] 회원가입 인증"); // 메일제목은 생략이 가능하다
	     
	      String host = "http://localhost:8888/Youtube/certification"; //인증완료페이지
	      
	      messageHelper.setText("", " <h2>앤죠애캉 회원가입 인증</h2><br/>"
	      		+ "<h4>인증하시려면 아래 버튼을 누르세여</h4><br/>"+"<a href="+host+">" +"<button style=\"color: white;background-color: #4c586f;border: none;width:200px;height:50px;text-align: center;text-decoration: none;  font-size: 25px;border-radius:10px;\">인증하기♥</button>");  // 메일 내용
	      //messageHelper.setText("안녕하세요 인증하시려면 아래 버튼을 누르셈", " <a href="+host+">" +"<img src=\"images/tup.png\"/></a>"); 
	      
	     
	      mailSender.send(message);
	    } catch(Exception e){
	      System.out.println(e);
	    }
	   
	    return "Member/waiting";//대기중
	  }
	
	@RequestMapping(value="/certification", method=RequestMethod.GET)
	public String certification(HttpSession session) {
		String useremail = (String) session.getAttribute("useremail");
		mRepository.updateStatus(useremail);
		
		return "Member/certification";
	}
  
	@RequestMapping(value="/myPage", method=RequestMethod.GET)
	public String myPage() {
		
		
		return "Member/myPage";
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

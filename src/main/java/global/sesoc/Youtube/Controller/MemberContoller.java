package global.sesoc.Youtube.Controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import global.sesoc.Youtube.dto.TestResult;
import global.sesoc.Youtube.dto.Video;

@Controller
public class MemberContoller {
	@Autowired
	MemberRepository mRepository;

	@Autowired
	private JavaMailSender mailSender;

	/**
	 * 로그인 페이지로 이동한다.
	 * 
	 * @return
	 */
	@RequestMapping(value = "/login", method = RequestMethod.GET)
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
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(String useremail, String userpwd, HttpSession session, Model model) {

		Member m = new Member();
		m.setUseremail(useremail);
		m.setUserpwd(userpwd);

		Member member = mRepository.selectOneFromMember(m);

		// 아이디 비번 같은 계정이 있음
		if (member != null) {
			// 인증상태 확인
			if (member.getStatus() == 0) {
				model.addAttribute("useremail", useremail);
				model.addAttribute("userpwd", userpwd);
				model.addAttribute("message", "이메일 인증 먼저 해주세요~!");

				return "Member/login";
			}

			else {
				session.setAttribute("useremail", member.getUseremail());
				session.setAttribute("admin", member.getAdmin());
				session.setAttribute("usernick", member.getUsernick());
				session.setAttribute("gender", member.getGender());
				session.setAttribute("birth", member.getBirth());

				System.out.println("로그인한넘" + member);

				// 접속일 업뎃
				mRepository.updateLastAccess(member.getUseremail());

				return "redirect:/";
			}
		} else {
			model.addAttribute("useremail", useremail);
			model.addAttribute("userpwd", userpwd);
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
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();

		return "redirect:/";
	}

	/**
	 * 회원가입 페이지로 이동한다.
	 * 
	 * @return
	 */
	@RequestMapping(value = "/joinForm", method = RequestMethod.GET)
	public String joinForm() {

		return "Member/joinForm";
	}

	/**
	 * 이메일 검증을 해준다.
	 * 
	 * @param useremail
	 * @return
	 */
	@RequestMapping(value = "/emailCheck", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	public @ResponseBody String emailCheck(String useremail) {
		// System.out.println("이메일 아이디 : "+useremail);

		Member m = new Member();
		m.setUseremail(useremail);
		if (mRepository.selectOneFromMember(m) == null) {
			return "사용 가능한 이메일 입니다";
		} else
			return "이미 가입한 이메일 입니다";

	}

	@RequestMapping(value = "/nickCheck", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	public @ResponseBody String nickCheck(String usernick) {
		/*
		 * String a="true"; String b="false";
		 */
		if (mRepository.selectByNick(usernick) == null) {
			return "사용 가능한 닉네임 입니다";
			/* return a; */
		} else
			return "중복된 닉네임 입니다.";
		/* return b; */

	}

	@RequestMapping(value = "mailSending", method = RequestMethod.POST)
	public String mailSending(HttpServletRequest request, Member member, HttpSession session) {
		System.out.println("횐갑하는넘**********" + member);

		mRepository.insertMember(member);
		session.setAttribute("waitingEmail", member.getUseremail());

		String setfrom = "timetravelwithdoctor@gmail.com";
		// String tomail = request.getParameter("tomail"); // 받는 사람 이메일
		String tomail = member.getUseremail(); // 받는 사람 이메일

		// String title = request.getParameter("[앤죠애캉] 회원 가입 인증"); // 제목
		// String content = request.getParameter("content"); // 내용
		// String content ="안녕하세요~ 인증하시려면 아래 버튼을 누르셈\n\r";

		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

			messageHelper.setFrom(setfrom); // 보내는사람 생략하거나 하면 정상작동을 안함
			messageHelper.setTo(member.getUseremail()); // 받는사람 이메일
			messageHelper.setSubject("[앤죠애캉] 회원가입 인증"); // 메일제목은 생략이 가능하다

			String host = "http://localhost:8888/Youtube/certification"; // 인증완료페이지

			messageHelper.setText("", " <h2>앤죠애캉 회원가입 인증</h2><br/>" + "<h4>인증하시려면 아래 버튼을 누르세여</h4><br/>" + "<a href="
					+ host + ">"
					+ "<button style=\"color: white;background-color: #4c586f;border: none;width:200px;height:50px;text-align: center;text-decoration: none;  font-size: 25px;border-radius:10px;\">인증하기♥</button>"); // 메일
																																																						// 내용
			// messageHelper.setText("안녕하세요 인증하시려면 아래 버튼을 누르셈", " <a href="+host+">" +"<img
			// src=\"images/tup.png\"/></a>");

			mailSender.send(message);
		} catch (Exception e) {
			System.out.println(e);
		}

		return "Member/waiting";// 대기중
	}

	@RequestMapping(value = "/certification", method = RequestMethod.GET)
	public String certification(HttpSession session) {
		String waitingEmail = (String) session.getAttribute("waitingEmail");
		mRepository.updateStatus(waitingEmail);

		return "Member/certification";
	}

	@RequestMapping(value = "/myPage", method = RequestMethod.GET)
	public String myPage(Model model, HttpSession session) {
		String useremail = (String) session.getAttribute("useremail");
		int myChallengeCount = mRepository.checkChallengeCount(useremail);
		// x/0 에러를 방지하기 위해 먼저 분모부분을 체크하고 해당 경우를 반영
		Member checkIfo = new Member();
		checkIfo.setUseremail(useremail);
		checkIfo.setAllChallenge(myChallengeCount);
		// 갠정보
		Member member = mRepository.selectMyInfo(checkIfo);
		// 갠영상
		List<Video> video = mRepository.selectMyVideo(useremail);
		// 갠레벨스
		List<TestResult> levelList = mRepository.selectLevels(useremail);

		System.out.println("마이페이지에 나올 넘*******" + member);
		System.out.println("마이페이지에 나올 영상*******" + video);
		System.out.println("마이페이지에 나올 레벨스****" + levelList);

		List<Video> notfinished = new ArrayList<>();
		List<Video> finished = new ArrayList<>();

		for (Video item : video) {
			int challengeCount = item.getChallengecount();
			if (challengeCount == 0) {
				notfinished.add(item);
			} else {
				finished.add(item);
			}
		}

		model.addAttribute("myInfo", member);
		model.addAttribute("finished", finished);
		model.addAttribute("notfinished", notfinished);
		// System.out.println("완료 영상*******"+finished);
		// System.out.println("아직 영상*******"+notfinished);
		// map
		Map<Integer, Integer> levelMap = new HashMap<>();

		int one = 0;
		int two = 0;
		int three = 0;
		int four = 0;
		int five = 0;

		for (int i = 0; i < levelList.size(); i++) {
			if (levelList.get(i).getTestlevel() == 1) {
				one++;
			} else if (levelList.get(i).getTestlevel() == 2) {
				two++;
			} else if (levelList.get(i).getTestlevel() == 3) {
				three++;
			} else if (levelList.get(i).getTestlevel() == 4) {
				four++;
			} else if (levelList.get(i).getTestlevel() == 5) {
				five++;
			}
		}

		levelMap.put(1, one);
		levelMap.put(2, two);
		levelMap.put(3, three);
		levelMap.put(4, four);
		levelMap.put(5, five);

		model.addAttribute("levelMap", levelMap);

		return "Member/myPage";
	}

	@RequestMapping(value = "/updateMember", method = RequestMethod.GET)
	public String updateMember() {

		return "Member/updateMember";
	}

	@RequestMapping(value = "/updateMember", method = RequestMethod.POST)
	public String updateMember(Model model, HttpSession session, String usernick, String currpwd, String newpwd) {

		String useremail = (String) session.getAttribute("useremail");
		int result = mRepository.updateMember(useremail, currpwd, newpwd, usernick);
		String message = null;

		if (result == 1) {

			message = "비밀번호 수정 완료. 다시 로그인해 주세요";
			session.invalidate();

		} else {
			message = "비밀번호가 수정되지 않았습니다.";
		}
		model.addAttribute("msg", message);


		return "redirect:/";
	}

	@RequestMapping(value = "recovery", method = RequestMethod.GET)
	public String recovery() {
		return "Member/recovery";
	}

	@RequestMapping(value = "recoveryID", method = RequestMethod.POST)
	public String recoveryID(String recoveryID) {
		mRepository.recoveryID(recoveryID);
		return "redirect:/";
	}

	@RequestMapping(value = "closeID", method = RequestMethod.GET)
	public String closeID() {
		return "Member/closeID";
	}

	@RequestMapping(value = "closeIDsubmit", method = RequestMethod.POST)
	public @ResponseBody String closeIDsubmit(@RequestBody Member member) {
		Member checkresult = mRepository.selectOneFromMember(member);
		if (checkresult != null)
			return "ok";
		else
			return "no";

	}
	
	@RequestMapping(value="insertCloseID",method=RequestMethod.POST)
	public String insertCloseID(HttpSession session,String useremail) {
		mRepository.insertCloseID(useremail);
		session.invalidate();
		return "redirect:/";
	}
}

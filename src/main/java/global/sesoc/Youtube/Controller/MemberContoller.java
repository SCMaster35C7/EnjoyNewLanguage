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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.Youtube.dao.MemberRepository;
import global.sesoc.Youtube.dto.Black;
import global.sesoc.Youtube.dto.Member;
import global.sesoc.Youtube.dto.Reply;
import global.sesoc.Youtube.dto.TestResult;
import global.sesoc.Youtube.dto.Video;
import global.sesoc.Youtube.util.PageNavigator;

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
   @RequestMapping(value = "/statusCheck", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
   public @ResponseBody String statusCheck(@RequestBody Member member, HttpSession session){
      Member selectedM = mRepository.selectOneFromMember(member);
      
      /*
       1. 인증 유무 확인
             return checkFailure;
       2. 비밀번호 유무 확인
             if(비밀번호/ 아이디 다르면 == null)
                    return loginFailure;
              else
                    return loginSuccess; 세션저장 -> jsp에서 리프레시
       
       * 
       */
      if (selectedM!=null) {
         //1.
         if (selectedM.getStatus()==0) {
            return "checkEmail";
         } else { //로그인가능
            session.setAttribute("useremail", selectedM.getUseremail());
            session.setAttribute("admin", selectedM.getAdmin());
            session.setAttribute("usernick", selectedM.getUsernick());

            session.setAttribute("gender", selectedM.getGender());
            session.setAttribute("birth", selectedM.getBirth());

            // 접속일 업뎃
            mRepository.updateLastAccess(selectedM.getUseremail());
            return "loginSuccess";
         }
      } else {
         //아디비번없을때
         return "loginFailure";
      }
   }
   
   
   /*@RequestMapping(value = "/login", method = RequestMethod.POST)
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
         //}
      } 
      else {
         model.addAttribute("useremail", useremail);
         model.addAttribute("userpwd", userpwd);
         model.addAttribute("message", "아이디나 비밀번호가 틀렸습니다.");

         return "Member/login";
      }
      return "fail"
   }*/

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
       System.out.println("이메일 체크 : "+useremail);

      Member m = new Member();
      m.setUseremail(useremail);
      System.out.println("널이니*****"+mRepository.selectOneFromMember(m));
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
         return "중복된 닉네임 입니다";
      /* return b; */

   }

   @RequestMapping(value = "mailSending", method = RequestMethod.POST)
   public String mailSending(HttpServletRequest request, Member member, HttpSession session) {
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

         String host = "localhost:9999/Youtube/certification"; // 인증완료페이지

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
   
   @RequestMapping(value = "recoveryMail", method = RequestMethod.POST)
   public String recoveryID(HttpServletRequest request, String  recoveryEmail, HttpSession session) {
      //mRepository.insertMember(member);
      session.setAttribute("recoveringEmail", recoveryEmail);

      String setfrom = "timetravelwithdoctor@gmail.com";
      // String tomail = request.getParameter("tomail"); // 받는 사람 이메일
      String tomail = recoveryEmail; // 받는 사람 이메일

      // String title = request.getParameter("[앤죠애캉] 회원 가입 인증"); // 제목
      // String content = request.getParameter("content"); // 내용
      // String content ="안녕하세요~ 인증하시려면 아래 버튼을 누르셈\n\r";

      try {
         MimeMessage message = mailSender.createMimeMessage();
         MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

         messageHelper.setFrom(setfrom); // 보내는사람 생략하거나 하면 정상작동을 안함
         messageHelper.setTo(recoveryEmail); // 받는사람 이메일
         messageHelper.setSubject("[앤죠애캉] 회원복구 인증"); // 메일제목은 생략이 가능하다

         String host = "localhost:9999/Youtube/recoveryID"; // 인증완료페이지

         messageHelper.setText("", " <h2>앤죠애캉 회원복구 인증</h2><br/>" + "<h4>인증하시려면 아래 버튼을 누르세여</h4><br/>" + "<a href="
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
   public String myPage(
         Model model,
         HttpSession session,
         @RequestParam(value = "finishedCurrentPage", defaultValue = "1") int finishedCurrentPage,
         @RequestParam(value = "unfinishedCurrentPage", defaultValue = "1") int unfinishedCurrentPage
         ) {
      
	  String useremail = (String) session.getAttribute("useremail");
      int totalRecordFinishedCount   = mRepository.getTotalCountFromFinished(useremail);
      int totalRecordUnfinishedCount = mRepository.getTotalCountFromUnfinished(useremail);
      
      // 페이징용 navigation
      PageNavigator finishedNavi = new PageNavigator(finishedCurrentPage, totalRecordFinishedCount, 5);
      PageNavigator unfinishedNavi = new PageNavigator(unfinishedCurrentPage, totalRecordUnfinishedCount, 5);
      
      // 각 페이지별 자료 추출
      List<Video> finished = mRepository.selectFinishedVideo(useremail, finishedNavi.getStartRecord(), finishedNavi.getcountPerPage());
      List<Video> unfinished = mRepository.selectUnfinishedVideo(useremail, unfinishedNavi.getStartRecord(), unfinishedNavi.getcountPerPage());
      
      Integer myChallengeCount = mRepository.checkChallengeCount(useremail);
      Member checkIfo = new Member();
      
      if(myChallengeCount == null)  
         checkIfo.setAllChallenge(0);
      else 
         checkIfo.setAllChallenge(myChallengeCount);
      
      // x/0 에러를 방지하기 위해 먼저 분모부분을 체크하고 해당 경우를 반영
      checkIfo.setUseremail(useremail);
      // 갠정보
      Member member = mRepository.selectMyInfo(checkIfo);
      System.out.println("member : "+member);
      // 갠레벨스
      List<TestResult> levelList = mRepository.selectLevels(useremail);
      
      //배열로 만들자
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
      
      List<Integer> levelArray = new ArrayList<>();
      levelArray.add(one);
      levelArray.add(two);
      levelArray.add(three);
      levelArray.add(four);
      levelArray.add(five);
      
      List<Integer> winningRate = new ArrayList<>();
      if(member != null) {
    	  winningRate.add(member.getAllSuccess());
    	  winningRate.add(member.getAllFailure());
      }
      model.addAttribute("myInfo", member);
      model.addAttribute("finished", finished);
      model.addAttribute("unfinished", unfinished);
      model.addAttribute("levelArray", levelArray);
      model.addAttribute("winningRate", winningRate);
      model.addAttribute("finishedNavi", finishedNavi);
      model.addAttribute("unfinishedNavi", unfinishedNavi);
      
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

   @RequestMapping(value = "recoveryID", method = RequestMethod.GET)
   public String recoveryID(HttpSession session) {
      String recoveringEmail = (String) session.getAttribute("recoveringEmail"); 
      mRepository.recoveryID(recoveringEmail);
      return "Member/certification";
   }

   @RequestMapping(value = "closeIDsubmit", method = RequestMethod.POST)
   public @ResponseBody String closeIDsubmit(@RequestBody Member member) {
      System.out.println(member);
      Member checkresult = mRepository.selectOneFromMember(member);
      System.out.println(checkresult);
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
   
   
   @RequestMapping(value="/selectInConfirm", method=RequestMethod.POST, produces = "application/json; charset=utf-8")
   public @ResponseBody String selectInConfirm(@RequestBody String useremail) {
      System.out.println("이멜나오냐?????"+useremail);
      
      Member member = mRepository.selectInConfirm(useremail);
      
      if (member==null) {
         return "notok";
      }else{
         return "ok";
      }
      
   }
   
   
   @RequestMapping(value="/resendValidate", method=RequestMethod.POST, produces = "application/json; charset=utf-8")
   public @ResponseBody String resendValidate(@RequestBody Member member) {
      //있나 & 상태 0인가 확인
      Member selectedM = mRepository.selectOneFromMember(member);
      System.out.println("뽑힌애"+selectedM);
      if (selectedM.getStatus()==0) {
         return "ok";
      } else {
         return "notok";
      } 
   }
   
   @RequestMapping(value="resendEmail",method=RequestMethod.POST)
   public String resendEmail(HttpServletRequest request, Member member, HttpSession session) {
      session.setAttribute("waitingEmail", member.getUseremail());
      String setfrom = "timetravelwithdoctor@gmail.com";
      String tomail = member.getUseremail(); // 받는 사람 이메일

      try {
         MimeMessage message = mailSender.createMimeMessage();
         MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");

         messageHelper.setFrom(setfrom); // 보내는사람 생략하거나 하면 정상작동을 안함
         messageHelper.setTo(member.getUseremail()); // 받는사람 이메일
         messageHelper.setSubject("[앤죠애캉] 회원가입 인증"); // 메일제목은 생략이 가능하다

         String host = "localhost:9999/Youtube/certification"; // 인증완료페이지

         messageHelper.setText("", " <h2>앤죠애캉 회원가입 인증</h2><br/>" + "<h4>인증하시려면 아래 버튼을 누르세여</h4><br/>" + "<a href="
               + host + ">"
               + "<button style=\"color: white;background-color: #4c586f;border: none;width:200px;height:50px;text-align: center;text-decoration: none;  font-size: 25px;border-radius:10px;\">인증하기♥</button>"); // 메일
                                                                                                                                                                  // 내용
         mailSender.send(message);
      } catch (Exception e) {
         System.out.println(e);
      }

      return "Member/waiting";// 대기중
   }
}


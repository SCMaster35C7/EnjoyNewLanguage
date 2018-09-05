package global.sesoc.Youtube.Controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.Youtube.dao.EducationRepository;
import global.sesoc.Youtube.dto.SubtitlesList;
import global.sesoc.Youtube.dto.TestResult;
import global.sesoc.Youtube.dto.WrongAnswer;
import global.sesoc.Youtube.util.RetakeMaker;
import global.sesoc.Youtube.util.SubtitlesMaker;

@Controller
public class EducationController {

	@Autowired
	EducationRepository eduRepository;


	private final String eduFileRoot = "/YoutubeEduCenter/EducationVideo";

	
	@RequestMapping(value = "getSubtitlesList", method = RequestMethod.GET)
	public @ResponseBody SubtitlesList getSubtitlesList(int level, String savedfileName) {
		String jamacURL = eduFileRoot + "/" + savedfileName;
		SubtitlesMaker sm = new SubtitlesMaker();
		SubtitlesList sublist = sm.RandomText(jamacURL, level);
	
		return sublist;
	}

	@RequestMapping(value = "ScoreResult", method = RequestMethod.POST)
	@ResponseBody
	public String ScoreResult(int testlevel, String[] WronganswerList, String[] CorrectanswerList, String useremail,
			String url, boolean testType, int correctCount) {
		// WronganswerList : 오답문제의 index 정보, CorrectanswerList: 정답 단어리스트 useremail: 수험자id
		// url : 영상 주소값, correctCount: 정답갯수 testType: 시험 타입(false text true mic), testlevel: 난이도
		double successPercent = correctCount / (WronganswerList.length + correctCount);
		TestResult tr = new TestResult();
		tr.setUseremail(useremail);
		tr.setUrl(url);
		int lastTestlevel = eduRepository.checkLastTestlevel(tr);
		
		if (lastTestlevel < testlevel)
			tr.setTestlevel(testlevel);

		if (successPercent > 0.7)        //70%이상 맞추면 합격처리
			tr.setSuccessCount(1);
		else
			tr.setFailureCount(1);

		eduRepository.updateTestResult(tr);

		WrongAnswer wa = new WrongAnswer();
		wa.setUseremail(useremail);
		wa.setUrl(url);
		if (testType)
			wa.setClassification(1);
		else
			wa.setClassification(0);

		for (int i = 0; i < WronganswerList.length; i++) {
			wa.setCorrectAnswer(CorrectanswerList[i]);
			wa.setWrongIndex(WronganswerList[i]);
			eduRepository.insertWrongAnswer(wa);
		}

		if (successPercent > 0.7) { // 정답률에 따른 합불 판정
			return "ok"; // 시험 통과
		} else {
			return "fail"; // 시험 실패
		}

	}

	@RequestMapping(value = "MakeRetakeTest", method = RequestMethod.GET)
	public @ResponseBody SubtitlesList MakeRetakeTest(HttpSession session, String url, boolean testType,
			String savedfileName) {
		String useremail = (String) session.getAttribute("useremail");
    	WrongAnswer wa = new WrongAnswer();
		String jamacURL = eduFileRoot + "/" + savedfileName;
		wa.setUseremail(useremail);
		wa.setUrl(url);
		if (testType)
			wa.setClassification(1);
		else
			wa.setClassification(0);

		ArrayList<WrongAnswer> retakeList = (ArrayList<WrongAnswer>) eduRepository.selectWrongAnswerList(wa);
		if(retakeList.size()!=0) {
		RetakeMaker rm = new RetakeMaker();
		SubtitlesList sl = rm.RetakeText(jamacURL, retakeList);
	
		return sl;
		}else {
			return null;
		}
	}

	// 재시험이므로 맞은 문제의 경우 기존 db에서 틀린문제 기록을 삭제함
	@RequestMapping(value = "RetakeResult", method = RequestMethod.POST)
	@ResponseBody
	public String RetakeResult(int WronganswerCount, String[] CorrectanswerList, String useremail, String url,
			boolean testType) {
		// WronganwerCount : 오답갯수, CorrectanswerList: 정답 단어의 2차원 인덱스정보, userid 로그인한
		// 아이디,
		// url : 영상 주소값, testType: 시험 타입(false text true mic)
		// TestSuccess: 시험 수행여부, 90% 이상시 수행처리(true) 일단 뷰단에서 처리하고 거르는것으로 구현
		double successPercent = CorrectanswerList.length / (WronganswerCount + CorrectanswerList.length);
		TestResult tr = new TestResult();
		tr.setUseremail(useremail);
		tr.setUrl(url);

		if (successPercent > 0.7)
			tr.setSuccessCount(1);
		else
			tr.setFailureCount(1);

		eduRepository.updateTestResult(tr);

		WrongAnswer wa = new WrongAnswer();
		wa.setUseremail(useremail);
		wa.setUrl(url);
		if (testType)
			wa.setClassification(1);
		else
			wa.setClassification(0);

		for (int i = 0; i < CorrectanswerList.length; i++) {

			wa.setWrongIndex(CorrectanswerList[i]);
			eduRepository.deleteWrongAnswer(wa);
		}

		if (successPercent > 0.7) { // 정답률에 따른 합불 판정
			return "ok"; // 시험 통과
		} else {
			return "fail"; // 시험 실패
		}

	}
	
	@RequestMapping(value="dictionaryBoard",method=RequestMethod.GET)
	public String dicionaryBoard() {
		return "EducationBoard/dictionaryBoard";
	}
}

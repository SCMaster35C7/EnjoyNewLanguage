package global.sesoc.Youtube.Controller;


import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import global.sesoc.Youtube.dao.EducationRepository;
import global.sesoc.Youtube.dao.InvestigationRepository;
import global.sesoc.Youtube.dto.Dubbing;
import global.sesoc.Youtube.dto.Education;
import global.sesoc.Youtube.dto.InvSubtitle;
import global.sesoc.Youtube.dto.Investigation;
import global.sesoc.Youtube.dto.Recommendation;
import global.sesoc.Youtube.dto.SubtitlesList;
import global.sesoc.Youtube.dto.TestResult;
import global.sesoc.Youtube.util.FileService;
import global.sesoc.Youtube.util.PageNavigator;
import global.sesoc.Youtube.util.SubtitlesMaker;

@Controller
public class VideoController {
	@Autowired
	EducationRepository eduRepository;
	
	@Autowired
	InvestigationRepository invRepository;

	// 교육용 자막파일 경로
	private final String eduFileRoot = "/YoutubeEduCenter/EducationVideo";
	
	// 자막검증용 자막파일 경로
	private final String subtitleFileRoot ="/YoutubeEduCenter/InvSubtitle";
	/***
	 * Home 기본 페이지 이동
	 * 
	 * @return
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(HttpServletRequest request, Model model) {
		String plzLogin = (String) request.getAttribute("plzLogin");
		model.addAttribute("plzLogin", plzLogin);
		
		List<Education> eList = eduRepository.selectBestFive();
		model.addAttribute("eList", eList);
		
		return "index";
	}
	

	/**
	 * 교육 영상 게시판으로 이동 검색 테마와 검색 내용에 합당한 자료를 찾는다.
	 * 
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/eduBoard", method = RequestMethod.GET)
	public String eduBoard(@RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
			@RequestParam(value = "searchType", defaultValue = "title") String searchType,
			@RequestParam(value = "searchWord", defaultValue = "") String searchWord, Model model) {
		int totalRecordCount = eduRepository.getTotalCount(searchType, searchWord);

		PageNavigator navi = new PageNavigator(currentPage, totalRecordCount, 8);
		List<Education> eduList = eduRepository.selectEduList(searchType, searchWord, navi.getStartRecord(),
				navi.getcountPerPage());

		model.addAttribute("eduList", eduList);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("navi", navi);

		return "EducationBoard/eduBoard";
	}

	/**
	 * 교육 영상 상세 정보페이지로 넘어간다.
	 * 
	 * @param videoNum
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/detailEduBoard", method=RequestMethod.GET)
	public String detailEduBoard(
			HttpSession session,
			int videoNum, 
			@RequestParam(value="currentPage", defaultValue="1") int currentPage, 
			@RequestParam(value="searchType", defaultValue="") String searchType, 
			@RequestParam(value="searchWord", defaultValue="") String searchWord, 
			Model model) {
		System.out.println(videoNum);
		Education edu = eduRepository.selectOneFromEduVideo(videoNum);

		if (edu != null) {
			model.addAttribute("edu", edu);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);

			int result = eduRepository.updateHitCount(videoNum);
		}
		String url=edu.getUrl();
		String useremail=(String)session.getAttribute("useremail");
		TestResult tr=new TestResult();
		tr.setUseremail(useremail);
		tr.setUrl(url);
		
		String testresult=eduRepository.checkUserStudyExist(tr);
		if(testresult==null) 
			eduRepository.insertUserStudy(tr);
		

		return "EducationBoard/detailEduBoard";
	}

	/**
	 * 교육 영상을 DB에 넣어준다.
	 * 
	 * @param education
	 * @param subtitle
	 * @return
	 */
	@RequestMapping(value = "/addEduVideo", method = RequestMethod.POST)
	public String addEduVideo(Education education, MultipartFile subtitle, boolean invDelete) {
		if(invDelete == true) {
			Investigation invTemp = new Investigation();
			invTemp.setUrl(education.getUrl());
			
			invTemp = invRepository.selectOneFromInvUseURL(invTemp);
			List<InvSubtitle> invSubList = invRepository.subtitleAllFromInv(invTemp.getInvestigationnum());
			
			for(int i=0; i<invSubList.size(); i++) {
				String pullPath = subtitleFileRoot+"/"+invSubList.get(i).getSavedFile();
				FileService.deleteFile(pullPath);
			}
			
			int result = invRepository.deleteInvUseURL(education.getUrl());
		}
		
		if (subtitle.getSize() != 0) {
			String originalfile = subtitle.getOriginalFilename();
			String savedfile = FileService.saveFile(subtitle, eduFileRoot);

			education.setOriginalfile(originalfile);
			education.setSavedfile(savedfile);
		}
		
		int result = eduRepository.insertEduVideo(education);
		return "redirect:/eduBoard";
	}

	@RequestMapping(value = "/slide", method = RequestMethod.GET)
	public String slide() {

		return "Practice/slide";
	}
	
	@RequestMapping(value="TryRetake",method=RequestMethod.GET)
	public String TryRetake(Model model,int videoNum) {
		Education edu = eduRepository.selectOneFromEduVideo(videoNum);
		model.addAttribute("edu",edu);
		
		return"EducationBoard/RetakeEduBoard";
	}

	/***
	 * 교육 영상 좋아요/ 싫어요 기능
	 * @param reco
	 * @return
	 */
	@RequestMapping(value="/insertRecommendation", method=RequestMethod.POST)
	public @ResponseBody String updateRecommendation(@RequestBody Recommendation reco) {
		Recommendation recoTemp = eduRepository.selectOneFromRecommendation(reco);

		if(recoTemp != null) {
			int savedReco = recoTemp.getRecommendation();	// 저장되어 있는 값
			int reqReco	= reco.getRecommendation();			// 요청온 값
			
			if(savedReco == reqReco) {
				int result = eduRepository.deleteRecommend(reco);
				
				if(reqReco == 0) {
					// 좋아요 상태 취소
					result = eduRepository.updateDecreRecommend(reco.getTableName(), reco.getIdCode(), reco.getIdentificationnum(), "recommendation");
				}else {
					// 싫어요 상태 취소
					result = eduRepository.updateDecreRecommend(reco.getTableName(),reco.getIdCode(),  reco.getIdentificationnum(), "decommendation");
				}
				
				return "cancel";
			}else {
				int result = 0 ;
				if(reqReco == 0) {
					// 좋아요 상태에서 싫어요로 변경
					result = eduRepository.updateRecommend(reco);
					result = eduRepository.updateDecreRecommend(reco.getTableName(), reco.getIdCode(), reco.getIdentificationnum(), "decommendation");
					result = eduRepository.updateIncreRecommend(reco.getTableName(), reco.getIdCode(), reco.getIdentificationnum(), "recommendation");
				}else {
					// 싫어요 상태에서 좋아요로 변경
					result = eduRepository.updateRecommend(reco);
					result = eduRepository.updateDecreRecommend(reco.getTableName(), reco.getIdCode(), reco.getIdentificationnum(), "recommendation");
					result = eduRepository.updateIncreRecommend(reco.getTableName(), reco.getIdCode(), reco.getIdentificationnum(), "decommendation");
				}
			}
			
			return "change";
		}else {
			int result = eduRepository.insertRecommendation(reco);
			
			if(reco.getRecommendation() == 0) {
				result = eduRepository.updateIncreRecommend(reco.getTableName(), reco.getIdCode(), reco.getIdentificationnum(), "recommendation");
			}else {
				result = eduRepository.updateIncreRecommend(reco.getTableName(), reco.getIdCode(), reco.getIdentificationnum(), "decommendation");
			}
			
			return "success";
		}
	}
	
	@RequestMapping(value="/existVideo", method=RequestMethod.GET)
	public @ResponseBody String existVideo(String url) {
		Investigation inv = invRepository.existVideo(url);
		Education edu = eduRepository.existVideo(url);
		
		if(inv != null) 
			return "invExist";
		if(edu != null) 
			return "eduExist";
		else
			return "success";
	}
}

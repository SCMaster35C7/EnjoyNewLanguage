package global.sesoc.Youtube.Controller;


import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import global.sesoc.Youtube.dao.EducationRepository;
import global.sesoc.Youtube.dto.Education;
import global.sesoc.Youtube.dto.TestResult;
import global.sesoc.Youtube.util.FileService;
import global.sesoc.Youtube.util.PageNavigator;

@Controller
public class VideoController {
	@Autowired
	EducationRepository eduRepository;

	private final String eduFileRoot = "/EducationVideo";
	// 교육용 자막파일 경로
	

	/***
	 * Home 기본 페이지 이동
	 * 
	 * @return
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
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
		System.out.println(totalRecordCount);

		PageNavigator navi = new PageNavigator(currentPage, totalRecordCount, 6);
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
	@RequestMapping(value = "/detailEduBoard", method = RequestMethod.GET)
	public String detailEduBoard(HttpSession session,int videoNum, int currentPage, String searchType, String searchWord, Model model) {
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
	 * 교육 영상 추가 페이지로 이동한다.
	 * 
	 * @return
	 */
	@RequestMapping(value = "/addEduVideo", method = RequestMethod.GET)
	public String addEduVideo() {

		return "EducationBoard/addEduVideo";
	}

	/**
	 * 교육 영상을 DB에 넣어준다.
	 * 
	 * @param education
	 * @param subtitle
	 * @return
	 */
	@RequestMapping(value = "/addEduVideo", method = RequestMethod.POST)
	public String addEduVideo(Education education, MultipartFile subtitle) {
		// System.out.println(education);
		// System.out.println(subtitle);
		if (subtitle.getSize() != 0) {
			String originalfile = subtitle.getOriginalFilename();
			String savedfile = FileService.saveFile(subtitle, eduFileRoot);

			education.setOriginalfile(originalfile);
			education.setSavedfile(savedfile);
		}
		// System.out.println(education);

		int result = eduRepository.insertEduVideo(education);
		return "EducationBoard/addEduVideo";
	}

	@RequestMapping(value = "/slide", method = RequestMethod.GET)
	public String slide() {

		return "Practice/slide";
	}
	
	@RequestMapping(value="TryRetake",method=RequestMethod.GET)
	public String TryRetake(Model model,int videoNum) {
		Education edu = eduRepository.selectOneFromEduVideo(videoNum);

		if (edu != null) {
			model.addAttribute("edu", edu);
			eduRepository.updateHitCount(videoNum);
		}
		return "EducationBoard/RetakeEduBoard";
	}

	
	// 개발중인 메소드 아직 쓰지마셈
	/*
	 * //사용 미정, 컨트롤단에서 사운드 파일을 가져올 경우, 몇가지 기능이 마비
	 * 
	 * @RequestMapping(value = "soundFile", method = RequestMethod.GET) public
	 * MultipartFile soundFile(int soundFileNum,HttpServletResponse response) {
	 * String fullPath = "C:\\lyr\\Test\\That Time of Year.mp3";
	 * System.out.println(soundFileNum);
	 * 
	 * FileInputStream fis = null; ServletOutputStream fout = null;
	 * 
	 * try { fout = response.getOutputStream(); fis = new FileInputStream(fullPath);
	 * FileCopyUtils.copy(fis, fout); fout.flush();
	 * 
	 * } catch (Exception e) {
	 * 
	 * } finally { try { if (fis != null) fis.close(); if (fout != null)
	 * fout.close(); } catch (Exception e) {
	 * 
	 * }
	 * 
	 * }
	 * 
	 * return null; }
	 */
}

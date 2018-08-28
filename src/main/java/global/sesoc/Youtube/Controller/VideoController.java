package global.sesoc.Youtube.Controller;

import java.io.FileInputStream;
import java.util.List;
import java.util.Locale;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import global.sesoc.Youtube.dao.EducationRepository;
import global.sesoc.Youtube.dto.Dubbing;
import global.sesoc.Youtube.dto.Education;
import global.sesoc.Youtube.dto.SubtitlesList;
import global.sesoc.Youtube.util.FileService;
import global.sesoc.Youtube.util.PageNavigator;
import global.sesoc.Youtube.util.SubtitlesMaker;

@Controller
public class VideoController {
	@Autowired
	EducationRepository eduRepository;
	
	//교육용 자막파일 경로
	private final String eduFileRoot = "/EducationVideo";
	
	/***
	 * Home 기본 페이지 이동
	 * @return
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(HttpServletRequest request, Model model) {
		String plzLogin = (String) request.getAttribute("plzLogin");
		System.out.println("로그인해임마 :  "+plzLogin);
		model.addAttribute("plzLogin", plzLogin);
		return "index";
	}
	
	/**
	 * 교육 영상 게시판으로 이동
	 * 검색 테마와 검색 내용에 합당한 자료를 찾는다.
	 * 
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/eduBoard", method=RequestMethod.GET)
	public String eduBoard(
			@RequestParam(value="currentPage", defaultValue="1") int currentPage,
			@RequestParam(value="searchType", defaultValue="title") String searchType,
			@RequestParam(value="searchWord", defaultValue="") String searchWord,
			Model model			
			) {
		int totalRecordCount = eduRepository.getTotalCount(searchType, searchWord);
		System.out.println(totalRecordCount);
		
		PageNavigator navi = new PageNavigator(currentPage, totalRecordCount, 6);
		List<Education> eduList =  eduRepository.selectEduList(searchType, searchWord, navi.getStartRecord(), navi.getcountPerPage());
		
		model.addAttribute("eduList",eduList);
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
	public String detailEduBoard(int videoNum, 
			@RequestParam(value="currentPage", defaultValue="0") int currentPage, 
			@RequestParam(value="searchType", defaultValue="") String searchType, 
			@RequestParam(value="searchWord", defaultValue="") String searchWord, 
			Model model) {
		Education edu = eduRepository.selectOneFromEduVideo(videoNum);
		
		if(edu != null) {
			model.addAttribute("edu", edu);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
			
			int result = eduRepository.updateHitCount(videoNum);
		}
		
		return "EducationBoard/detailEduBoard";
	}
	
	/**
	 * 교육 영상 추가 페이지로 이동한다.
	 * 
	 * @return
	 */
	@RequestMapping(value="/addEduVideo", method=RequestMethod.GET)
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
	@RequestMapping(value="/addEduVideo", method=RequestMethod.POST)
	public String addEduVideo(Education education, MultipartFile subtitle) {
		//System.out.println(education);
		//System.out.println(subtitle);
		if(subtitle.getSize() != 0) {
			String originalfile = subtitle.getOriginalFilename();
			String savedfile = FileService.saveFile(subtitle, eduFileRoot);
			
			education.setOriginalfile(originalfile);
			education.setSavedfile(savedfile);
		}
		//System.out.println(education);
		
		int result = eduRepository.insertEduVideo(education);
		return "EducationBoard/addEduVideo";
	}
	
	@RequestMapping(value="/slide", method=RequestMethod.GET)
	public String slide() {
		
		return "Practice/slide";
	}
	
	@RequestMapping(value="getSubtitlesList",method=RequestMethod.GET)
	public @ResponseBody SubtitlesList getSubtitlesList(int level, int videoNum) {
		String jamacName=eduRepository.selectSubName(videoNum);
		String jamacURL=eduFileRoot+"/"+jamacName;
		SubtitlesMaker sm = new SubtitlesMaker();
		SubtitlesList sublist = sm.RandomText(jamacURL, level);
		

		return sublist;

	}
	
	
	//더빙겟

	@RequestMapping(value="/dubbingBoard", method=RequestMethod.GET)
	public String dubbingBoard(HttpSession session, Model model) {
		List<Dubbing> dubbing =  eduRepository.dubbingBoard();
		model.addAttribute("dubbing", dubbing);
		return "EducationBoard/dubbingBoard";
	}
	
	
	//더빙 디테일

		@RequestMapping(value="/dubDetail", method=RequestMethod.GET)
		public String dubDetail(int dubbingnum, Model model) {
			System.out.println("더빙넘은,,,,,,"+dubbingnum);
			
			Dubbing dubbing = eduRepository.selectOneDub(dubbingnum);
			model.addAttribute("dubbing", dubbing);
		
			return "EducationBoard/dubDetail";
		}
		

	
	 // 개발중인 메소드 아직 쓰지마셈
	/*
	//사용 미정, 컨트롤단에서 사운드 파일을 가져올 경우, 몇가지 기능이 마비
	@RequestMapping(value = "soundFile", method = RequestMethod.GET)
	public MultipartFile soundFile(int soundFileNum,HttpServletResponse response) {
		String fullPath = "C:\\lyr\\Test\\That Time of Year.mp3";
		System.out.println(soundFileNum);

		FileInputStream fis = null;
		ServletOutputStream fout = null;

		try {
			fout = response.getOutputStream();
			fis = new FileInputStream(fullPath);
			FileCopyUtils.copy(fis, fout);
			fout.flush();

		} catch (Exception e) {

		} finally {
			try {
				if (fis != null)
					fis.close();
				if (fout != null)
					fout.close();
			} catch (Exception e) {

			}

		}

		return null;
	}
	*/
}



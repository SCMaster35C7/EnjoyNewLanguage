package global.sesoc.Youtube.Controller;

import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import global.sesoc.Youtube.dao.EducationRepository;
import global.sesoc.Youtube.dto.Education;
import global.sesoc.Youtube.util.FileService;

@Controller
public class VideoController {
	@Autowired
	EducationRepository eduRepository;
	
	//교육용 자막파일 경로
	private final String eduFileRoot = "/EducationVideo";
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		return "index";
	}
	
	@RequestMapping(value="/eduBoard", method=RequestMethod.GET)
	public String eduBoard(Model model) {
		List<Education> eduList =  eduRepository.selectAllEduList();
		
		model.addAttribute("eduList",eduList);
		
		return "EducationBoard/eduBoard";
	}
	
	@RequestMapping(value="/detailEduBoard", method=RequestMethod.GET)
	public String detailEduBoard(int videoNum, Model model) {
		Education edu = eduRepository.selectOneFromEduVideo(videoNum);
		
		model.addAttribute("edu", edu);
		
		return "EducationBoard/detailEduBoard";
	}
	
	@RequestMapping(value="/addEduVideo", method=RequestMethod.GET)
	public String addEduVideo() {
		
		return "EducationBoard/addEduVideo";
	}
	
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
}



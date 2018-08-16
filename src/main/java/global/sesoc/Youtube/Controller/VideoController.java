package global.sesoc.Youtube.Controller;

import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import global.sesoc.Youtube.dao.EducationRepository;
import global.sesoc.Youtube.dto.Education;

@Controller
public class VideoController {
	@Autowired
	EducationRepository eduRepository;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		return "index";
	}
	
	@RequestMapping(value="/eduBoard", method=RequestMethod.GET)
	public String eduBoard(Model model) {
		List<Education> eduList =  eduRepository.selectAllStudyList();
		
		model.addAttribute("eduList",eduList);
		
		return "EducationBoard/eduBoard";
	}
	
	@RequestMapping(value="/detailEduBoard", method=RequestMethod.GET)
	public String detailEduBoard(int videoNum, Model model) {
		Education edu = eduRepository.selectOneFromEduVideo(videoNum);
		
		model.addAttribute("edu", edu);
		
		System.out.println(edu);
		return "EducationBoard/detailEduBoard";
	}
}

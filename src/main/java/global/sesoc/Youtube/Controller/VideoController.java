package global.sesoc.Youtube.Controller;

import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.Youtube.dao.EducationRepository;
import global.sesoc.Youtube.dto.Education;
import global.sesoc.Youtube.dto.SubtitlesList;
import global.sesoc.Youtube.util.SubtitlesMaker;

@Controller
public class VideoController {
	@Autowired
	EducationRepository eduRepository;
	
	
	final String SubtitlesURL="";
	
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
	
	
	
	@RequestMapping(value="getSubtitlesList",method=RequestMethod.GET)
	public @ResponseBody SubtitlesList getSubtitlesList(int level, int videoNum) {
		String jamacName=eduRepository.selectSubName(videoNum);
		String jamacURL=SubtitlesURL+jamacName;
		SubtitlesMaker sm = new SubtitlesMaker();
		SubtitlesList sublist = sm.RandomText(jamacURL, level);
		

		return sublist;

	}
}

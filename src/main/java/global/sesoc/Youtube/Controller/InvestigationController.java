package global.sesoc.Youtube.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import global.sesoc.Youtube.dao.InvestigationRepository;
import global.sesoc.Youtube.dto.Education;
import global.sesoc.Youtube.dto.Investigation;
import global.sesoc.Youtube.util.PageNavigator;

@Controller
public class InvestigationController {
	@Autowired
	InvestigationRepository invRepository;
	/***
	 * 자막 검증 게시판 
	 * @return
	 */
	@RequestMapping(value="/InvestigationBoard", method=RequestMethod.GET)
	public String investigaionBoard(
			@RequestParam(value="currentPage", defaultValue="1") int currentPage,
			@RequestParam(value="searchType", defaultValue="title") String searchType,
			@RequestParam(value="searchWord", defaultValue="") String searchWord,
			Model model
			) {
		int totalRecordCount = invRepository.getTotalCount(searchType, searchWord);
		PageNavigator navi = new PageNavigator(currentPage, totalRecordCount, 6);
		
		List<Investigation> invList =  invRepository.selectInvList(searchType, searchWord, navi.getStartRecord(), navi.getcountPerPage());
		
		model.addAttribute("invList",invList);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("navi", navi);
		
		return "InvestigationBoard/InvBoard";
	}
	
	@RequestMapping(value="/requestInvestigation", method=RequestMethod.GET)
	public String requestInvestigation() {
		return "InvestigationBoard/requestInvestigation";
	}
	
	@RequestMapping(value="/requestInvestigation", method=RequestMethod.POST)
	public String requestInvestigation(Investigation inv) {
		System.out.println(inv);
		return "InvestigationBoard/requestInvestigation";
	}
}

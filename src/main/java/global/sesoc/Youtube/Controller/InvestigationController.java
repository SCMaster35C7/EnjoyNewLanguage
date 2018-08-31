package global.sesoc.Youtube.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.Youtube.dao.InvestigationRepository;
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
		// System.out.println(currentPage+", "+searchType+", "+searchWord);
		
		int totalRecordCount = invRepository.getTotalCount(searchType, searchWord);
		PageNavigator navi = new PageNavigator(currentPage, totalRecordCount, 6);
		
		List<Investigation> invList =  invRepository.selectInvList(searchType, searchWord, navi.getStartRecord(), navi.getcountPerPage());
		
		model.addAttribute("invList",invList);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("navi", navi);
		
		return "InvestigationBoard/InvBoard";
	}
	
	/***
	 * 자막 요청 등록페이지로 이동
	 * @return
	 */
	@RequestMapping(value="/requestInvestigation", method=RequestMethod.GET)
	public String requestInvestigation() {
		return "InvestigationBoard/requestInvestigation";
	}
	
	/***
	 * 자막 요청 게시글 등록
	 * @param inv
	 * @return
	 */
	@RequestMapping(value="/requestInvestigation", method=RequestMethod.POST)
	public @ResponseBody String requestInvestigation(@RequestBody Investigation inv) {
		Investigation finInv = invRepository.selectOneFromInvUseURL(inv);
		
		if(finInv == null) {
			int result = invRepository.insertInvestigation(inv);
			
			return "success";
		}else {
			return "failure";
		}
	}
	
	@RequestMapping(value="/detailInvBoard", method=RequestMethod.GET)
	public String detailInvBoard(
		int investigationnum,
		@RequestParam(value="currentPage", defaultValue="1" ) int currentPage,
		@RequestParam(value="searchType", defaultValue="") String searchType,
		@RequestParam(value="searchWord", defaultValue="") String searchWord,
		Model model
		) {
		Investigation inv = invRepository.selectOneFromInvUseNum(investigationnum);
		
		if(inv != null) {
			model.addAttribute("inv", inv);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("searchType", searchType);
			model.addAttribute("searchWord", searchWord);
			
			int result = invRepository.updateHitCount(investigationnum);
		}
		
		return "InvestigationBoard/detailInvBoard";
	}
}
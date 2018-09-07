package global.sesoc.Youtube.Controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import global.sesoc.Youtube.dto.Investigation;
import global.sesoc.Youtube.dto.InvSubtitle;
import global.sesoc.Youtube.dto.Reply;
import global.sesoc.Youtube.util.EasySubtitlesMaker;
import global.sesoc.Youtube.util.FileService;
import global.sesoc.Youtube.util.PageNavigator;

@Controller
public class InvestigationController {
	@Autowired
	InvestigationRepository invRepository;
	
	@Autowired
	EducationRepository eduRepository;
	
	private final String subtitleFileRoot ="/YoutubeEduCenter/InvSubtitle";
	
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
		PageNavigator navi = new PageNavigator(currentPage, totalRecordCount, 8);
		
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
	public @ResponseBody Map requestInvestigation(@RequestBody Investigation inv) {
		Investigation finInv = invRepository.selectOneFromInvUseURL(inv);
		Map<String, Object> map = new HashMap<>();
		
		if(finInv == null) {
			int result = invRepository.insertInvestigation(inv);
			map.put("result", "success");
		}else {
			map.put("result", "failure");
			map.put("investigationnum", finInv.getInvestigationnum());
		}
		
		return map;
	}
	
	/**
	 * 자막 검증 상세페이지로 이동
	 * @param investigationnum
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/detailInvBoard", method= RequestMethod.GET)
	public String detailInvBoard(
		int investigationnum,
		@RequestParam(value="currentPage", defaultValue="1" ) int currentPage,
		@RequestParam(value="searchType", defaultValue="") String searchType,
		@RequestParam(value="searchWord", defaultValue="") String searchWord,
		Model model
		) {
		// System.out.println(investigationnum+", "+currentPage+", "+searchType+", "+searchWord);
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
	
	/**
	 * 자막 검증 상세페이지 모든 댓글가져오기
	 * @param idnum
	 * @return
	 */
	@RequestMapping(value="/replyInvAll", method=RequestMethod.POST)
	public @ResponseBody List<Reply> replyInvAll(int idnum) {
		List<Reply> replyList = invRepository.replyAllFromInv(idnum);
		
		return replyList;
	}
	
	/**
	 * 자막 검증 게시판 댓글 삽입
	 * @param reply
	 * @return
	 */
	@RequestMapping(value="/replyInvInsert", method=RequestMethod.POST)
	public @ResponseBody String replyInvInsert(@RequestBody Reply reply) {
		//System.out.println(reply);
		int result = invRepository.insertReplyToInv(reply);
		
		return "success";
	}
	
	/**
	 * 자먹 검증 게시판 댓글 없데이트
	 * @param reply
	 * @return
	 */
	@RequestMapping(value="/replyInvUpdate", method=RequestMethod.POST)
	public @ResponseBody String replyInvUpdate(@RequestBody Reply reply) {
		System.out.println(reply);
		int result = invRepository.replyInvUpdate(reply);
		
		return "success";
	}
	
	/**
	 * 자막 검증 게시판 댓글 삭제
	 * @param replynum
	 * @return
	 */
	@RequestMapping(value="/replyInvDelete", method=RequestMethod.GET)
	public @ResponseBody String replyInvDelete(int replynum) {
		int result = invRepository.replyInvDelete(replynum);
		
		return "success";
	}
	
	/**
	 * 자막 검증 게시판 자막파일 등록
	 * @param file
	 * @return
	 */
	@RequestMapping(value="/registSubtitle", method=RequestMethod.POST)
	public @ResponseBody String registSubtitle(MultipartFile file, InvSubtitle invSub) {
		// System.out.println("file : "+file);
		// System.out.println("data : "+invSub);
		
		if(file != null) {
			if(file.getSize() == 0) {
				return "failure";
			}else {
				String originalFile = file.getName();
				String savedFile = FileService.saveFile(file, subtitleFileRoot);
				invSub.setSavedFile(savedFile);
				invSub.setOriginalFile(originalFile);
				
				int result = invRepository.insertInvSubtitle(invSub);
			}
		}
		
		return "success";
	}
	
	@RequestMapping(value="/invSubAll", method=RequestMethod.POST)
	public @ResponseBody List<InvSubtitle> invSubAll(int investigationnum) {
		List<InvSubtitle> subList = invRepository.subtitleAllFromInv(investigationnum);

		return subList;
	}
	
	@RequestMapping(value="/invSubDelete", method=RequestMethod.GET)
	public @ResponseBody String invSubDelete(int subtitleNum, int recommendtable) {
		//System.out.println("subtitlenum: "+subtitleNum+", recommendtable: "+recommendtable);
		eduRepository.deleteAllRecommend(subtitleNum, recommendtable);
		
		int result = invRepository.deleteInvSubtitle(subtitleNum);

		if (result == 1)
			return "success";
		else
			return "failure";
	}
	
	@RequestMapping(value = "/getSubtitles", method = RequestMethod.GET)
	public @ResponseBody Map<String, String> getSubtitles(int subtitleNum) {
		InvSubtitle sub = invRepository.selectOneFromSubUseNum(subtitleNum);
		
		if(sub != null) {
			String jamacURL = subtitleFileRoot + "/" + sub.getSavedFile();
			EasySubtitlesMaker esm = new EasySubtitlesMaker();
			Map<String, String> result = esm.GetSubtitles(jamacURL);
			
			if (!result.isEmpty())	return result;
		}
		
		return null;
	}
}
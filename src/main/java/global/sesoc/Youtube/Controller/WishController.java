package global.sesoc.Youtube.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import global.sesoc.Youtube.dao.WishRepository;
import global.sesoc.Youtube.dto.WishList;
import global.sesoc.Youtube.util.PageNavigator;

public class WishController {

	@Autowired
	WishRepository wRepository;
	
	/**
	 * 영상위시리스트 화면으로 이동	 * 
	 * @return
	 */
	@RequestMapping(value="/videoWish", method=RequestMethod.GET)
	public String videoWish(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
						@RequestParam(value="searchType", defaultValue="title") String searchType,
						@RequestParam(value="searchWord", defaultValue="") String searchWord,
						Model model) {
		
		int totalRecordCount = wRepository.getTotalCount1(searchType, searchWord);
		PageNavigator navi = new PageNavigator(currentPage, totalRecordCount, 8);
		
		List<WishList> wishlist =  wRepository.findVideoWish(searchType, searchWord, navi.getStartRecord(), navi.getcountPerPage());

		model.addAttribute("wishlist", wishlist);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("navi", navi);
		
		return "Member/videoWish";
	}
	
	/**
	 * 자막위시리스트 화면으로 이동	 * 
	 * @return
	 */
	@RequestMapping(value="/subWish", method=RequestMethod.GET)
	public String subWish(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
						@RequestParam(value="searchType", defaultValue="title") String searchType,
						@RequestParam(value="searchWord", defaultValue="") String searchWord,
						Model model) {
		
		int totalRecordCount = wRepository.getTotalCount1(searchType, searchWord);
		PageNavigator navi = new PageNavigator(currentPage, totalRecordCount, 8);
		
		List<WishList> wishlist =  wRepository.findSubWish(searchType, searchWord, navi.getStartRecord(), navi.getcountPerPage());

		model.addAttribute("wishlist", wishlist);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("navi", navi);
		
		return "Member/subWish";
	}
		
	/**
	 * 더빙위시리스트 화면으로 이동	 * 
	 * @return
	 */
	@RequestMapping(value="/dubWish", method=RequestMethod.GET)
	public String dubWish(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
						@RequestParam(value="searchType", defaultValue="title") String searchType,
						@RequestParam(value="searchWord", defaultValue="") String searchWord,
						Model model) {
		
		int totalRecordCount = wRepository.getTotalCount1(searchType, searchWord);
		PageNavigator navi = new PageNavigator(currentPage, totalRecordCount, 8);
		
		List<WishList> wishlist =  wRepository.findDubWish(searchType, searchWord, navi.getStartRecord(), navi.getcountPerPage());

		model.addAttribute("wishlist", wishlist);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("navi", navi);
		
		return "Member/dubWish";
	}
	
	/**
	 * 영상위시리스트 등록
	 * 
	 * @param wishlist
	 * @return
	 */
	@RequestMapping(value = "/insertVideoWish", method = RequestMethod.POST)
	public @ResponseBody Map insertVideoWish(map) {
		
		WishList wishlist = wRepository.selectVideoWish(videoNum);
		
		Map<String, Object> map = new HashMap<>();
		int result = wRepository.insertVideoWish(wishlist);
		
		
		return result;
	}
	
	/**
	 * 영상위시리스트 삭제
	 * 
	 * @param wishNum
	 * @return
	 */	
	/*@RequestMapping(value = "/deleteVideoWish", method = RequestMethod.GET)
	public int deleteVideoWish(@RequestParam("videoNum") int videoNum,	// 게시물번호
			Model model,
			HttpSession session){
		
	
	String useremail = (String) session.getAttribute("useremail");

		return 0;

	}*/
}

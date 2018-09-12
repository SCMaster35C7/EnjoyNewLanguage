package global.sesoc.Youtube.Controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.Youtube.dao.WishRepository;
import global.sesoc.Youtube.dto.WishList;
import global.sesoc.Youtube.util.PageNavigator;

@Controller
public class WishController {

	@Autowired
	WishRepository wRepository;


	/**
	 * 영상위시리스트 화면으로 이동	 * 
	 * @return
	 */
	@RequestMapping(value="/wishList", method=RequestMethod.GET)
	public String wishList(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
						@RequestParam(value="searchType", defaultValue="title") String searchType,
						@RequestParam(value="searchWord", defaultValue="") String searchWord,
						HttpSession session,
						Model model) {
		
		int totalRecordCount = wRepository.getTotalCount1(searchType, searchWord);
		PageNavigator navi = new PageNavigator(currentPage, totalRecordCount, 8);
		String useremail = (String)session.getAttribute("useremail");
		
		List<WishList> vWishlist =  wRepository.getVideoWishList(useremail, searchType, searchWord, navi.getStartRecord(), navi.getcountPerPage());
		System.out.println(vWishlist);
		model.addAttribute("vWishlist", vWishlist);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("navi", navi);

		return "Member/wishList";

	}
	
	/**
	 * 자막위시리스트 화면으로 이동	 * 
	 * @return
	 */

	@RequestMapping(value="/subWish", method=RequestMethod.GET)
	public String subWish(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
						@RequestParam(value="searchType", defaultValue="title") String searchType,
						@RequestParam(value="searchWord", defaultValue="") String searchWord,
						String useremail,
						Model model) {
		
		int totalRecordCount = wRepository.getTotalCount1(searchType, searchWord);
		PageNavigator navi = new PageNavigator(currentPage, totalRecordCount, 8);
		
		List<WishList> sWishlist =  wRepository.getSubWishList(useremail, searchType, searchWord, navi.getStartRecord(), navi.getcountPerPage());

		model.addAttribute("sWishlist", sWishlist);
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
		
		List<WishList> dWishlist =  wRepository.selectDubWish(searchType, searchWord, navi.getStartRecord(), navi.getcountPerPage());
				
					
		model.addAttribute("dWishlist", dWishlist);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("navi", navi);
		
		return "Member/dubWish";
	}
	
	@ResponseBody
	@RequestMapping(value="/dubWish", method=RequestMethod.GET, produces="application/text; charset=UTF8")
	public String dubWish(int wishnum, int dubbingnum, HttpSession session) {
		
		String useremail = (String) session.getAttribute("useremail");		
		/*WishList dubWishList = wRepository.findDubWish(useremail, dubbingnum);*/

		return "Member/dubWish";
	}

	/**
	 * 영상위시리스트 등록
	 * 
	 * @param wishlist
	 * @return
	 */
	@RequestMapping(value = "/insertVideoWish", method = RequestMethod.POST)
	public @ResponseBody String insertVideoWish(@RequestBody WishList wishlist) {
		System.out.println(wishlist);
		//WishList wishlist = wRepository.selectVideoWish(videoNum);
		WishList wList = wRepository.selectOneFromWishList(wishlist);
		
		if(wList == null) {
			int result = wRepository.insertVideoWish(wishlist);
			
			if(result != 0)
				return "success";
			else	
				return "failRegist";
		}
		
		return "failure";
	}
	
	/**
	 * 영상위시리스트 조회
	 * @return
	 */
	@RequestMapping(value="/videoWish", method=RequestMethod.GET)
	public String videoWish(
			@RequestParam(value="currentPage", defaultValue="1") int currentPage,
			@RequestParam(value="searchType", defaultValue="title") String searchType,
			@RequestParam(value="searchWord", defaultValue="") String searchWord,
			Model model
			) {
		
		int totalRecordCount = wRepository.getTotalCount1(searchType, searchWord);
		PageNavigator navi = new PageNavigator(currentPage, totalRecordCount, 8);
		
		/*List<WishList> wList =  wRepository.selectVideoWish(useremail, startRecord, countPerPage);*/   
				
		/*selectInvList(searchType, searchWord, navi.getStartRecord(), navi.getcountPerPage());*/

		/*model.addAttribute("wList",wList);*/
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("navi", navi);
		
		return "Member/videoWish";

	}

	/**
	 * 영상위시리스트 삭제
	 * 
	 * @param wishNum
	 * @return
	 */

	@RequestMapping(value = "/deleteVideoWish", method = RequestMethod.GET)
	public int deleteVideoWish(int wishnum,	// 게시물번호
			Model model,
			HttpSession session){
		/*int result = wRepository.deleteVideoWish(wishNum);*/
		/*Member member = mRepository.selectOneFromMember(m);*/
		
	String useremail = (String) session.getAttribute("useremail");

	int result = wRepository.deleteVideoWish(wishnum);
	
	
	return result;

	}
		
	/**
	 * 더빙픽 리스트 화면으로 이동
	 * @return
	 */
	@RequestMapping(value="/myDubbing", method=RequestMethod.GET)
	public String myDubbing() {			
		return "Member/myDubbing";
	}
	/**
	 * 
	 * 더빙픽 리스트 로직 처리
	 * @param dubbingnum
	 * @return
	 */
	@RequestMapping(value="/myDubbing", method=RequestMethod.POST)
	public String myDubbing(int dubbingnum) {			
		return "redirect:/myPage";
	}
	
	/**
	 * 자막픽 리스트 화면으로 이동
	 * @return
	 */
	@RequestMapping(value="/mySublist", method=RequestMethod.GET)
	public String mySublist() {		
		return "Member/mySublist";
	}
	
	/**
	 * 자막픽 리스트 로직 처리
	 * 
	 * @param subtitlenum
	 * @return
	 */
	@RequestMapping(value="/mySublist", method=RequestMethod.POST)
	public String mySublist(int subtitlenum) {		
		return "redirect:/myPage";
	}
}

package global.sesoc.Youtube.Controller;

import java.util.List;

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
	 * 영상위시리스트 탭으로 이동
	 * 
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/videoWish", method=RequestMethod.GET)
	public String videoWish(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
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

		return "Member/videoWish";

	}
	
	/**
	 * 자막위시리스트 탭으로 이동
	 * 
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/subWish", method=RequestMethod.GET)
	public String subWish(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
						@RequestParam(value="searchType", defaultValue="title") String searchType,
						@RequestParam(value="searchWord", defaultValue="") String searchWord,
						HttpSession session,
						Model model) {
		
		int totalRecordCount = wRepository.getTotalCount1(searchType, searchWord);
		PageNavigator navi = new PageNavigator(currentPage, totalRecordCount, 8);
		String useremail = (String)session.getAttribute("useremail");
		
		List<WishList> sWishlist =  wRepository.getSubWishList(useremail, searchType, searchWord, navi.getStartRecord(), navi.getcountPerPage());

		
		model.addAttribute("sWishlist", sWishlist);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("navi", navi);

		return "Member/subWish";

	}
	
	/**
	 * 더빙위시리스트 탭으로 이동
	 * 
	 * @param currentPage
	 * @param searchType
	 * @param searchWord
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/dubWish", method=RequestMethod.GET)
	public String dubWish(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
						@RequestParam(value="searchType", defaultValue="title") String searchType,
						@RequestParam(value="searchWord", defaultValue="") String searchWord,
						HttpSession session,
						Model model) {
		
		int totalRecordCount = wRepository.getTotalCount1(searchType, searchWord);
		PageNavigator navi = new PageNavigator(currentPage, totalRecordCount, 8);
		String useremail = (String)session.getAttribute("useremail");
		
		List<WishList> dWishlist =  wRepository.getDubWishList(useremail, searchType, searchWord, navi.getStartRecord(), navi.getcountPerPage());

		model.addAttribute("dWishlist", dWishlist);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("navi", navi);

		return "Member/dubWish";

	}		

	/**
	 * 영상, 더빙, 자막 위시리스트 삭제
	 * @param title
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/deleteVideoWish", method = RequestMethod.GET)
	public int deleteVideoWish(String title) {

		int result = wRepository.deleteWish(title);
		
	return result;

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
			int result = wRepository.insertWish(wishlist);
			
			if(result != 0)
				return "success";
			else	
				return "failRegist";
		}
		
		return "failure";
	}	

	
	/**
	 * 자막위시리스트 등록
	 * 
	 * @param wishlist
	 * @return
	 */	
	@RequestMapping(value = "/insertSubWish", method = RequestMethod.POST)
	public @ResponseBody String insertSubWish(@RequestBody WishList wishlist) {
		System.out.println(wishlist);
		//WishList wishlist = wRepository.selectVideoWish(videoNum);
		WishList wList = wRepository.selectOneFromWishList(wishlist);
		
		if(wList == null) {
			int result = wRepository.insertWish(wishlist);
			
			if(result != 0)
				return "success";
			else	
				return "failRegist";
		}
		
		return "failure";
	}
		
	/**
	 * 더빙위시리스트 등록
	 * 
	 * @param wishlist
	 * @return
	 */	
	@RequestMapping(value = "/insertDubWish", method = RequestMethod.POST)
	public @ResponseBody String insertDubWish(@RequestBody WishList wishlist) {
		System.out.println(wishlist);
		//WishList wishlist = wRepository.selectVideoWish(videoNum);
		WishList wList = wRepository.selectOneFromWishList(wishlist);
		
		if(wList == null) {
			int result = wRepository.insertWish(wishlist);
			
			if(result != 0)
				return "success";
			else	
				return "failRegist";
		}
		
		return "failure";
	}	

}

package global.sesoc.Youtube.Controller;

<<<<<<< HEAD
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

=======
import java.util.List;

<<<<<<< HEAD
=======
import javax.servlet.http.HttpSession;

>>>>>>> Muk
>>>>>>> Muk
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
<<<<<<< HEAD
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.Youtube.dao.WishRepository;
=======
<<<<<<< HEAD

import global.sesoc.Youtube.dao.WishRepository;
=======
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.Youtube.dao.WishRepository;
import global.sesoc.Youtube.dto.Investigation;
>>>>>>> Muk
>>>>>>> Muk
import global.sesoc.Youtube.dto.WishList;
import global.sesoc.Youtube.util.PageNavigator;

public class WishController {

	@Autowired
	WishRepository wRepository;
<<<<<<< HEAD

=======
	
<<<<<<< HEAD
=======
	final int COUNT_PER_PAGE = 10;
>>>>>>> Muk
>>>>>>> Muk
	/**
	 * 영상위시리스트 화면으로 이동	 * 
	 * @return
	 */
<<<<<<< HEAD

	@RequestMapping(value="/wishList", method=RequestMethod.GET)
	public String wishList(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
=======
<<<<<<< HEAD
	@RequestMapping(value="/videoWish", method=RequestMethod.GET)
	public String videoWish(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
>>>>>>> Muk
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
<<<<<<< HEAD

		return "Member/wishList";
=======
		
=======
	@ResponseBody
	@RequestMapping(value="/videoWish", method=RequestMethod.GET, produces="application/text; charset=UTF8")
	public String videoWish(int wishnum, int videoNum, HttpSession session) {
		
		String useremail = (String) session.getAttribute("useremail");
		
		WishList videoWishList = wRepository.findVideoWish(useremail, videoNum);
		/*SubWishList subWishList		= wRepository.findSubWish(useremail, subwishnum);
		DubWishList dubWishList		= wRepository.findDubWish(useremail, dubwishnum);*/
		
		/*if(videoWishList == null) {
			int result = wRepository.insertVideoWish(map);
			
			return "확인";
		}else {
			return "취소";
		}*/
>>>>>>> Muk
		return "Member/videoWish";
>>>>>>> Muk
	}
	
	/**
	 * 자막위시리스트 화면으로 이동	 * 
	 * @return
<<<<<<< HEAD
	 */
=======
	 */
<<<<<<< HEAD
>>>>>>> Muk
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
<<<<<<< HEAD

=======
		
=======
	@ResponseBody
	@RequestMapping(value="/subWish", method=RequestMethod.GET, produces="application/text; charset=UTF8")
	public String subWish(int wishnum, int subtitlenum, HttpSession session) {
		
		String useremail = (String) session.getAttribute("useremail");
		
		WishList subWishList = wRepository.findSubWish(useremail, subtitlenum);
		/*SubWishList subWishList		= wRepository.findSubWish(useremail, subwishnum);
		DubWishList dubWishList		= wRepository.findDubWish(useremail, dubwishnum);*/
		
		/*if(videoWishList == null) {
			int result = wRepository.insertVideoWish(map);
			
			return "확인";
		}else {
			return "취소";
		}*/
>>>>>>> Muk
>>>>>>> Muk
		return "Member/subWish";
	}
		
	/**
	 * 더빙위시리스트 화면으로 이동	 * 
	 * @return
<<<<<<< HEAD
	 */
=======
	 */
<<<<<<< HEAD
>>>>>>> Muk
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
<<<<<<< HEAD

=======
	
=======
	@ResponseBody
	@RequestMapping(value="/dubWish", method=RequestMethod.GET, produces="application/text; charset=UTF8")
	public String dubWish(int wishnum, int dubbingnum, HttpSession session) {
		
		String useremail = (String) session.getAttribute("useremail");
		
		WishList dubWishList = wRepository.findDubWish(useremail, dubbingnum);
		/*SubWishList subWishList		= wRepository.findSubWish(useremail, subwishnum);
		DubWishList dubWishList		= wRepository.findDubWish(useremail, dubwishnum);*/
		
		/*if(videoWishList == null) {
			int result = wRepository.insertVideoWish(map);
			
			return "확인";
		}else {
			return "취소";
		}*/
		return "Member/dubWish";
	}
>>>>>>> Muk
>>>>>>> Muk
	/**
	 * 영상위시리스트 등록
	 * 
	 * @param wishlist
	 * @return
	 */
<<<<<<< HEAD
	@RequestMapping(value = "/insertVideoWish", method = RequestMethod.POST)
	public @ResponseBody Map insertVideoWish(WishList wishlist) {
		System.out.println(wishlist);
		/*WishList wishlist = wRepository.selectVideoWish(videoNum);*/
		
		Map<String, Object> map = new HashMap<>();
				
		int result = wRepository.insertVideoWish(wishlist);
		
		
		return map;


	}	
=======
	@RequestMapping(value = "/insertVideoWish", method = RequestMethod.POST)
<<<<<<< HEAD
	public @ResponseBody Map insertVideoWish(map) {
		
		WishList wishlist = wRepository.selectVideoWish(videoNum);
		
		Map<String, Object> map = new HashMap<>();
		int result = wRepository.insertVideoWish(wishlist);
		
		
		return result;
=======
	public int insertWish(WishList wlist, HttpSession session) {
		
		return 0;
		/*int result = wRepository.insertVideoWish(wishlist);

		/*String useremail = (String) session.getAttribute("useremail");
		wishlist.setUseremail(useremail);
		
		Map<Integer, Object> map_list = new Map<Integer, Object>();  
		// 장바구니에 기존 상품이 있는지 검사
		

		int count = */
	
		
		

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
		
		int totalRecordCount = wRepository.getTotalCount(searchType, searchWord);
		PageNavigator navi = new PageNavigator(currentPage, totalRecordCount, 8);
		
		List<WishList> wList =  wRepository.selectVideoWish(useremail, startRecord, countPerPage)   
				
		/*selectInvList(searchType, searchWord, navi.getStartRecord(), navi.getcountPerPage());*/

		model.addAttribute("wList",wList);
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("navi", navi);
		
		return "Member/videoWish";
>>>>>>> Muk
	}
	
>>>>>>> Muk
	/**
	 * 영상위시리스트 삭제
	 * 
	 * @param wishNum
	 * @return
<<<<<<< HEAD
	 */
	@RequestMapping(value = "/deleteVideoWish", method = RequestMethod.GET)
=======
	 */	
<<<<<<< HEAD
	/*@RequestMapping(value = "/deleteVideoWish", method = RequestMethod.GET)
	public int deleteVideoWish(@RequestParam("videoNum") int videoNum,	// 게시물번호
			Model model,
			HttpSession session){
		
	
	String useremail = (String) session.getAttribute("useremail");

		return 0;

	}*/
=======
	@RequestMapping(value = "/deleteVideoWish", method = RequestMethod.GET)

>>>>>>> Muk
	public int deleteVideoWish(@RequestParam("videoNum") int videoNum,	// 게시물번호
			Model model,
			HttpSession session){
		/*int result = wRepository.deleteVideoWish(wishNum);*/
		/*Member member = mRepository.selectOneFromMember(m);*/
	String result = "";
	
	String useremail = (String) session.getAttribute("useremail");
<<<<<<< HEAD

		return 0;

	}		

=======
/*	List<Education> educationList = new ArrayList<>();
	
	if(useremail == null){	// 로그인 안된 경우
		result = "redirect:/login";
	} else {
		HashMap<String, Object> insertMap=new HashMap<String,Object>();	// mapper로 넘기는 param
		try {
			int wishNum = select (member.getUseremail()).getWishNum(); //wishlist 번호
			insertMap.put("wishNum", wishNum);
			insertMap.put("videoNum", videoNum);
			(insertMap); // 상품삭제
			productList = (member.getUseremail());	// 아이디로 위시리스트  반환
		} catch (Exception e) {
			result = "redirect:/";
		}	
	}
	result = "index";
	model.addAttribute("eList", educationList);
<<<<<<< HEAD
	model.addAttribute("path", "wishlist.jsp");*/
	
		return 0;

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
>>>>>>> Muk
>>>>>>> Muk
}

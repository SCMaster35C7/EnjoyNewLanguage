package global.sesoc.Youtube.Controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.Youtube.dao.WishRepository;
import global.sesoc.Youtube.dto.WishList;

public class WishController {

	@Autowired
	WishRepository wRepository;
	
	/**
	 * 종합위시리스트 화면으로 이동	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/wishList", method=RequestMethod.GET, produces="application/text; charset=UTF8")
	public String wishList(int wishnum, int videowishnum, HttpSession session) {
		
		String useremail = (String) session.getAttribute("useremail");
		
		WishList videoWishList = wRepository.findVideoWish(useremail, videowishnum);
		/*SubWishList subWishList		= wRepository.findSubWish(useremail, subwishnum);
		DubWishList dubWishList		= wRepository.findDubWish(useremail, dubwishnum);*/
		
		/*if(videoWishList == null) {
			int result = wRepository.insertVideoWish(map);
			
			return "확인";
		}else {
			return "취소";
		}*/
		return "Member/wishList";
	}
	/**
	 * 영상위시리스트 등록
	 * 
	 * @param wishlist
	 * @return
	 */
	@RequestMapping(value = "/insertVideoWish", method = RequestMethod.POST)
	public int insertWish(WishList wlist, HttpSession session) {
		
		return 0;
		/*int result = wRepository.insertVideoWish(wishlist);*/

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
	
	@RequestMapping(value = "/selectVideoWish", method = RequestMethod.POST)
	public List<WishList> selectWishlist() {
		/*List<VideoWishList> result = wRepository.selectVideoWish(useremail, bound);*/
		
		return null;
	}
	
	/**
	 * 영상위시리스트 삭제
	 * 
	 * @param wishNum
	 * @return
	 */	
	@RequestMapping(value = "/deleteVideoWish", method = RequestMethod.GET)

	public int deleteVideoWish(@RequestParam("videoNum") int videoNum,	// 게시물번호
			Model model,
			HttpSession session){
		/*int result = wRepository.deleteVideoWish(wishNum);*/
		/*Member member = mRepository.selectOneFromMember(m);*/
	String result = "";
	
	String useremail = (String) session.getAttribute("useremail");
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
}

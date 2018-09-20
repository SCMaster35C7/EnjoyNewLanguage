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
    * 영상위시리스트 화면으로 이동    * 
    * @return
    */
   /*
   @RequestMapping(value="/wishList", method=RequestMethod.GET)
   public String wishList(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
                  @RequestParam(value="searchType", defaultValue="title") String searchType,
                  @RequestParam(value="searchWord", defaultValue="") String searchWord,
                  HttpSession session,
                  Model model) {
      
      int totalRecordCount = wRepository.getTotalCount(searchType, searchWord);
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
   */
   
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
   @RequestMapping(value="/particularList", method=RequestMethod.GET)
   public String videoWish(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
                  int wishtable,
                  String useremail,
                  @RequestParam(value="distinguishNum", defaultValue="0")int distinguishNum,
                  Model model) {
      
      int totalRecordCount = wRepository.getTotalCount(wishtable, useremail);
      PageNavigator navi = new PageNavigator(currentPage, totalRecordCount, 8);
      List<WishList> vWishlist =  wRepository.getParticularWishList(wishtable, useremail, navi.getStartRecord(), navi.getcountPerPage());
      System.out.println(vWishlist);
      
      model.addAttribute("vWishlist", vWishlist);
      model.addAttribute("wishtable", wishtable);
      model.addAttribute("useremail", useremail);
      model.addAttribute("navi", navi);
      
      if(distinguishNum == 1) {
         return "Member/videoWish";
      }else if(distinguishNum == 2) {
         return "Member/subWish";
      }else if(distinguishNum == 3) {
         return "Member/dubWish";
      }
      return "Member/wishList";
   }

   /**
    * 영상, 더빙, 자막 위시리스트 삭제
    * @param title
    * @param session
    * @return
    */   
   @RequestMapping(value = "/deleteWish", method = RequestMethod.POST)
   public String deleteWish(String title) {

      wRepository.deleteWish(title);
      
   return "redirect:/Member/wishList";

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
      System.out.println("대상:"+wList);
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
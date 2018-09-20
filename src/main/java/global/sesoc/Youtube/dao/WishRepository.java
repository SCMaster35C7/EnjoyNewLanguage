package global.sesoc.Youtube.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.Youtube.dto.WishList;

@Repository
public class WishRepository {
   
   @Autowired
   SqlSession session;

   //페이징을 위해 데이터수 세기
   public int getTotalCount(int wishtable, String useremail) {
      WishMapper wMapper = session.getMapper(WishMapper.class);
      Map<String, Object> map = new HashMap<>();
      map.put("wishtable", wishtable);
      map.put("useremail", useremail);
      
      int result = wMapper.getTotalCount(map);
            
      return result;
   }
   
   //위시리스트 등록 전 중복 검사
   public WishList selectOneFromWishList(WishList wishlist) {
      WishMapper wMapper = session.getMapper(WishMapper.class);
      WishList wList = wMapper.selectOneFromWishList(wishlist);
      
      return wList;
   }   
   
   public WishList selectFromWishList2(WishList wishlist)   {
      WishMapper wMapper = session.getMapper(WishMapper.class);
      WishList wList2 = wMapper.selectFromWishList2(wishlist);
      
      return wList2;
   }
   
   //비디오파트
   public List<WishList> getParticularWishList(int wishtable, String useremail, int startRecord, int getcountPerPage) {
      WishMapper wMapper = session.getMapper(WishMapper.class);
      RowBounds bound = new RowBounds(startRecord, getcountPerPage);   
      Map<String,Object> map = new HashMap<>();
      map.put("useremail", useremail);
      map.put("wishtable", wishtable);
      
      System.out.println("매쁘"+map);
      
      List<WishList> vWishList = wMapper.getParticularWishList(map, bound);
      System.out.println("매쁘 결과"+vWishList);
      return vWishList;
   }
   
   //영상, 자막, 더빙 위시리스트에 등록
   public int insertWish(WishList wishlist) {
      WishMapper wMapper = session.getMapper(WishMapper.class);
      System.out.println(wishlist);
      int result = wMapper.insertWish(wishlist);
      
      return result;
   }
   //영상, 자막, 더빙 위시리스트에서 삭제
   public int deleteWish (String title) {
      WishMapper wMapper = session.getMapper(WishMapper.class);
      wMapper.deleteWish(title);
      
      return 0;
   }
   
}
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
	public int getTotalCount1(String searchType, String searchWord) {

		WishMapper wMapper = session.getMapper(WishMapper.class);
		Map<String, String> map =new HashMap<>();
		map.put("searchType", searchType);
		map.put("searchWord", searchWord);

		int result = wMapper.getTotalCount1(map);
				
		return result;
	}
	
	//위시리스트 등록 전 중복 검사
	public WishList selectOneFromWishList(WishList wishlist) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		WishList wList = wMapper.selectOneFromWishList(wishlist);
		
		return wList;
	}	
	
	//비디오파트
	public List<WishList> getVideoWishList(String useremail, String searchType, String searchWord, int startRecord, int getcountPerPage) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		RowBounds bound = new RowBounds(startRecord, getcountPerPage);	
		Map<String,Object> map = new HashMap<>();
		
		map.put("useremail", useremail);
		map.put("searchType", searchType);
		map.put("searchWord", searchWord);
		//System.out.println("잘 들어옴? : "+map);
		List<WishList> vWishList = wMapper.getAllWishList(map, bound);
		
		return vWishList;
	}
	
	//자막 파트	
	public List<WishList> getSubWishList(String useremail, String searchType, String searchWord, int startRecord, int getcountPerPage) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		RowBounds bound = new RowBounds(startRecord, getcountPerPage);	
		Map<String,Object> map = new HashMap<>();
		
		map.put("useremail", useremail);
		map.put("searchType", searchType);
		map.put("searchWord", searchWord);
		//System.out.println("잘 들어옴? : "+map);
		List<WishList> sWishList = wMapper.getAllWishList(map, bound);
		
		return sWishList;
	}
	
	//더빙 파트
	public List<WishList> getDubWishList(String useremail, String searchType, String searchWord, int startRecord, int getcountPerPage) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		RowBounds bound = new RowBounds(startRecord, getcountPerPage);	
		Map<String,Object> map = new HashMap<>();
		
		map.put("useremail", useremail);
		map.put("searchType", searchType);
		map.put("searchWord", searchWord);
		//System.out.println("잘 들어옴? : "+map);
		List<WishList> dWishList = wMapper.getAllWishList(map, bound);
		
		return dWishList;
		
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

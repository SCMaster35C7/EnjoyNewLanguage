package global.sesoc.Youtube.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.Youtube.dto.Dubbing;
import global.sesoc.Youtube.dto.WishList;

@Repository
public class WishRepository {
	
	@Autowired
	SqlSession session;

	public int getTotalCount1(String searchType, String searchWord) {

		WishMapper wMapper = session.getMapper(WishMapper.class);
		Map<String, String> map =new HashMap<>();
		map.put("searchType", searchType);
		map.put("searchWord", searchWord);

		int result = wMapper.getTotalCount1(map);
				
		return result;
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
		List<WishList> vWishList = wMapper.getVideoWishList(map, bound);
		
		return vWishList;
	}
	
	public int insertVideoWish(WishList wishlist) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		System.out.println(wishlist);
		int result = wMapper.insertVideoWish(wishlist);
		
		return result;
	}

	public WishList selectVideoWish(int wishnum) {		
		WishMapper wMapper = session.getMapper(WishMapper.class);
		WishList vList = wMapper.selectVideoWish(wishnum);
				
		return vList;		
	}
	
	public int deleteVideoWish(int wishnum) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		int result = wMapper.deleteVideoWish(wishnum);
		
		return result;
	}
	

	//자막 파트	
	public List<WishList> getSubWishList (String useremail, String searchType, String searchWord, int startRecord, int getcountPerPage) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		RowBounds bound = new RowBounds(startRecord, getcountPerPage);	
		
		Map<String, Object> map = new HashMap<>();
		
		
		map.put("useremail", useremail);
		map.put("searchType", searchType);
		map.put("searchWord", searchWord);
		
		List<WishList> sWishList = wMapper.getDubWishList(map, bound);
		
		return sWishList;	
	}
	
	public WishList selectSubWish(int subtitlenum) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		WishList sList = wMapper.selectSubWish(subtitlenum);
		
		return sList;
	}

	public int insertSubWish(WishList wishlist) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		System.out.println(wishlist);
		
		int result = wMapper.insertSubWish(wishlist);
		
		return result;
	}

	public int deleteSubWish(int subtitlenum) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		int result = wMapper.deleteSubWish(subtitlenum);

		
		return result;
	}
	
	//더빙 파트
	public List<WishList> getDubWishList(String useremail, String searchType, String searchWord, int startRecord, int getcountPerPage) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		RowBounds bound = new RowBounds(startRecord, getcountPerPage);	
		
		Map<String, Object> map = new HashMap<>();		
		
		/*Dubbing dub = new Dubbing();		
		
		String useremail = dub.getUseremail(); 
		*/
		
		/*map.put("useremail", useremail);*/		
		map.put("searchType", searchType);
		map.put("searchWord", searchWord);
		
		List<WishList> dWishList = wMapper.getDubWishList(map, bound);
		
		return dWishList;
	}

	public int insertDubWish(WishList wishlist) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		System.out.println(wishlist);
		
		int result = wMapper.insertDubWish(wishlist);
		
		return result;
	}

	public WishList selectDubWish(int dubbingnum) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		WishList dList = wMapper.selectDubWish(dubbingnum);
		
		return dList;
	}

	public int deleteDubWish(int dubbingnum) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		int result = wMapper.deleteDubWish(dubbingnum);
		
		return result;
	}

	public WishList selectOneFromWishList(WishList wishlist) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		WishList wList = wMapper.selectOneFromWishList(wishlist);
		
		return wList;
	}	
}

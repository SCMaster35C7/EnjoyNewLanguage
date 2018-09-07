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
	
	public int getTotalCount1(String searchType, String searchWord) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		Map<String, String> map =new HashMap<>();
		map.put("searchType", searchType);
		map.put("searchWord", searchWord);
		int result = wMapper.getTotalCount1(map);
				
		return result;
	}
	
	public List<WishList> findVideoWish(String searchType, String searchWord, int startRecord, int getcountPerPage) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		RowBounds bound = new RowBounds(startRecord, getcountPerPage);	
		
		Map<String, Object> map = new HashMap<>();
		map.put("searchType", searchType);
		map.put("searchWord", searchWord);
		
		List<WishList> vWishList = wMapper.findVideoWish(map, bound);
		
		return vWishList;
	}
	
	public int insertVideoWish(WishList wishlist) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		
		int result = wMapper.insertVideoWish(wishlist);
		
		return result;
	}

	public WishList selectVideoWish(int videoNum) {
		
		WishMapper wMapper = session.getMapper(WishMapper.class);
		WishList vList = wMapper.selectVideoWish(videoNum);
				
		return vList;
	}

	public int deleteVideoWish(int videoNum) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		int result = wMapper.deleteVideoWish(videoNum);
		
		return result;
	}
	
	public List<WishList> findSubWish(String searchType, String searchWord, int startRecord, int getcountPerPage) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		RowBounds bound = new RowBounds(startRecord, getcountPerPage);	
		
		Map<String, Object> map = new HashMap<>();
		map.put("searchType", searchType);
		map.put("searchWord", searchWord);
		
		List<WishList> sWishList = wMapper.findSubWish(map, bound);
		
		return sWishList;	
	}

	public int insertSubWish(WishList wishlist) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		int result = wMapper.insertSubWish(wishlist);
		
		return result;
	}

	public WishList selectSubWish(int subtitlenum) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		WishList sList = wMapper.selectSubWish(subtitlenum);
		
		return sList;
	}

	public int deleteSubWish(int subtitlenum) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		int result = wMapper.deleteSubWish(subtitlenum);
		return result;
	}
	
	
	
	
	public List<WishList> findDubWish(String searchType, String searchWord, int startRecord, int getcountPerPage) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		RowBounds bound = new RowBounds(startRecord, getcountPerPage);	
		
		Map<String, Object> map = new HashMap<>();
		map.put("searchType", searchType);
		map.put("searchWord", searchWord);
		
		List<WishList> vWishList = wMapper.findDubWish(map, bound);
		
		return vWishList;
	}

	public int insertDubWish(WishList wishlist) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
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
}

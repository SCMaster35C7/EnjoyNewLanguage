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
	
<<<<<<< HEAD

	public int getTotalCount1(String searchType, String searchWord) {

=======
<<<<<<< HEAD
	public int getTotalCount1(String searchType, String searchWord) {
=======
	public int getTotalCount(String searchType, String searchWord) {
>>>>>>> Muk
>>>>>>> Muk
		WishMapper wMapper = session.getMapper(WishMapper.class);
		Map<String, String> map =new HashMap<>();
		map.put("searchType", searchType);
		map.put("searchWord", searchWord);
<<<<<<< HEAD

		int result = wMapper.getTotalCount1(map);

				
		return result;
	}
	//비디오파트
=======
<<<<<<< HEAD
		int result = wMapper.getTotalCount1(map);
=======
		int result = wMapper.getTotalCount(map);
>>>>>>> Muk
				
		return result;
	}
	
<<<<<<< HEAD
>>>>>>> Muk
	public List<WishList> findVideoWish(String searchType, String searchWord, int startRecord, int getcountPerPage) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		RowBounds bound = new RowBounds(startRecord, getcountPerPage);	
		
<<<<<<< HEAD
		
		
		List<WishList> vWishList = wMapper.findVideoWish(bound);
=======
		Map<String, Object> map = new HashMap<>();
		map.put("searchType", searchType);
		map.put("searchWord", searchWord);
		
		List<WishList> vWishList = wMapper.findVideoWish(map, bound);
>>>>>>> Muk
		
		return vWishList;
	}
	
	public int insertVideoWish(WishList wishlist) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		
		int result = wMapper.insertVideoWish(wishlist);
<<<<<<< HEAD
		
		return result;
	}
	

	public WishList selectVideoWish(int videoNum) {
		
		WishMapper wMapper = session.getMapper(WishMapper.class);
		WishList vList = wMapper.selectVideoWish(videoNum);
=======
=======
	public WishList findVideoWish(String useremail, int videoNum) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		Map<String, Object> map = new HashMap<>();
		map.put("useremail", useremail);
		map.put("videoNum", videoNum);
		
		WishList videoWishList = wMapper.findVideoWish(map);
		
		return videoWishList;
	}
	
	public int videoWishCount(String useremail) {		
		WishMapper wMapper = session.getMapper(WishMapper.class);
		int result = wMapper.videoWishCount(useremail);
>>>>>>> Muk
		
		return result;
	}

<<<<<<< HEAD
	public WishList selectVideoWish(int videoNum) {
		
		WishMapper wMapper = session.getMapper(WishMapper.class);
		WishList vList = wMapper.selectVideoWish(videoNum);
=======

	public int insertVideoWish(String useremail, String videoNum, String title, String url, int subtitlenum, int dubbingnum) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		Map<String, Object> map = new HashMap<>();
		
		map.put("useremail", useremail);
		map.put("videoNum", videoNum);
		map.put("title", title);
		map.put("url", url);
		map.put("subtitlenum", subtitlenum);
		map.put("dubbingnum", dubbingnum);
		
		int result = wMapper.insertVideoWish(map);
		
		return result;
	}

	public List<WishList> selectVideoWish(String useremail, int startRecord, int countPerPage) {
		RowBounds bound = new RowBounds(startRecord, countPerPage);
		WishMapper wMapper = session.getMapper(WishMapper.class);
		List<WishList> vList = wMapper.selectVideoWish(useremail, bound);
>>>>>>> Muk
>>>>>>> Muk
				
		return vList;
	}

	public int deleteVideoWish(int videoNum) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		int result = wMapper.deleteVideoWish(videoNum);
		
		return result;
	}
	
<<<<<<< HEAD
	//자막 파트
=======
<<<<<<< HEAD
>>>>>>> Muk
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
<<<<<<< HEAD
		
		return result;
	}

	public WishList selectSubWish(int subtitlenum) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		WishList sList = wMapper.selectSubWish(subtitlenum);
=======
=======
	public WishList findSubWish(String useremail, int subtitlenum) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		Map<String, Object> map = new HashMap<>();
		map.put("useremail", useremail);
		map.put("subtitlenum", subtitlenum);
		
		
		WishList subWishList = wMapper.findSubWish(map);
		
		return subWishList;		
	}
	
	public int subWishCount(String useremail) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		int result = wMapper.subWishCount(useremail);
		
		return result;
	}

	public int insertSubWish(Map<String, Object> map) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		int result = wMapper.insertSubWish(map);
>>>>>>> Muk
		
		return result;
	}

<<<<<<< HEAD
	public WishList selectSubWish(int subtitlenum) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		WishList sList = wMapper.selectSubWish(subtitlenum);
=======
	public List<WishList> selectSubWish(String useremail, RowBounds bound) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		List<WishList> sList = wMapper.selectSubWish(useremail, bound);
>>>>>>> Muk
>>>>>>> Muk
		
		return sList;
	}

	public int deleteSubWish(int subtitlenum) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		int result = wMapper.deleteSubWish(subtitlenum);
<<<<<<< HEAD
		
		return result;
	}
	
	//자막 파트
=======
		return result;
	}
	
<<<<<<< HEAD
	
	
	
>>>>>>> Muk
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
<<<<<<< HEAD
		
		return result;
	}

	public WishList selectDubWish(int dubbingnum) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		WishList dList = wMapper.selectDubWish(dubbingnum);
=======
=======
	public WishList findDubWish(String useremail, int dubbingnum) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		Map<String, Object> map = new HashMap<>();
		map.put("useremail", useremail);
		map.put("dubbingnum", dubbingnum);
		
		WishList dWishList = wMapper.findDubWish(map);
		return dWishList;
		
	}
	public int dubWishCount(String useremail) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		int result = wMapper.dubWishCount(useremail);
		return result;
	}

	public int insertDubWish(Map<String, Object> map) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		int result = wMapper.insertDubWish(map);
>>>>>>> Muk
		
		return result;
	}

<<<<<<< HEAD
	public WishList selectDubWish(int dubbingnum) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		WishList dList = wMapper.selectDubWish(dubbingnum);
=======
	public List<WishList> selectDubWish(String useremail, RowBounds bound) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		List<WishList> dList = wMapper.selectDubWish(useremail, bound);
>>>>>>> Muk
>>>>>>> Muk
		
		return dList;
	}

	public int deleteDubWish(int dubbingnum) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		int result = wMapper.deleteDubWish(dubbingnum);
		
		return result;
	}	
}

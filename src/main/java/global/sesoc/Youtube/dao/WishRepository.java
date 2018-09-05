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
	
	
	public WishList findVideoWish(String useremail, int videowishnum) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		Map<String, Object> map = new HashMap<>();
		map.put("useremail", useremail);
		map.put("videowishnum", videowishnum);
		
		WishList videoWishList = wMapper.findVideoWish(map);
		
		return videoWishList;
	}
	
	public int videoWishCount(String useremail) {		
		WishMapper wMapper = session.getMapper(WishMapper.class);
		int result = wMapper.videoWishCount(useremail);
		
		return result;
	}


	public int insertVideoWish(String useremail, int videowishnum) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		Map<String, Object> map = new HashMap<>();
		map.put("useremail", useremail);
		map.put("videowishnum", videowishnum);
		
		int result = wMapper.insertVideoWish(map);
		
		return result;
	}

	public List<WishList> selectVideoWish(String useremail, int startRecord, int countPerPage) {
		RowBounds bound = new RowBounds(startRecord, countPerPage);
		WishMapper wMapper = session.getMapper(WishMapper.class);
		List<WishList> vList = wMapper.selectVideoWish(useremail, bound);
				
		return vList;
	}

	public int deleteVideoWish(int videowishnum) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		int result = wMapper.deleteVideoWish(videowishnum);
		
		return result;
	}
	
	public WishList findSubWish(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}
	
	public int subWishCount(String useremail) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		int result = wMapper.subWishCount(useremail);
		
		return result;
	}

	public int insertSubWish(Map<String, Object> map) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		int result = wMapper.insertSubWish(map);
		
		return result;
	}

	public List<WishList> selectSubWish(String useremail, RowBounds bound) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		List<WishList> sList = wMapper.selectSubWish(useremail, bound);
		
		return sList;
	}

	public int deleteSubWish(int subwishnum) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		int result = wMapper.deleteSubWish(subwishnum);
		return result;
	}

	
	public WishList findDubWish(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
		
	}
	public int dubWishCount(String useremail) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		int result = wMapper.dubWishCount(useremail);
		return result;
	}

	public int insertDubWish(Map<String, Object> map) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		int result = wMapper.insertDubWish(map);
		
		return result;
	}

	public List<WishList> selectDubWish(String useremail, RowBounds bound) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		List<WishList> dList = wMapper.selectDubWish(useremail, bound);
		
		return dList;
	}

	public int deleteDubWish(int dubbingnum) {
		WishMapper wMapper = session.getMapper(WishMapper.class);
		int result = wMapper.deleteDubWish(dubbingnum);
		
		return result;
	}	
}

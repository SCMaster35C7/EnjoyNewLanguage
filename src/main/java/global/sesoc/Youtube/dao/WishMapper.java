package global.sesoc.Youtube.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import global.sesoc.Youtube.dto.WishList;

public interface WishMapper {
	//영상, 자막, 더빙 위시리스트 데이터 수
	public int getTotalCount(Map<String, Object> map);
	//영상, 자막, 더빙 위시리스트 중복 확인
	public WishList selectOneFromWishList(WishList wishlist);
	//영상, 자막, 더빙 위시리스트 분별하여 뽑아오기
	public WishList selectFromWishList2(WishList wishlist);
	//영상, 자막, 더빙 위시리스트 불러오기
	public List<WishList> getParticularWishList(Map<String,Object> map, RowBounds bound);	
	//영상, 자막, 더빙 위시리스트 등록
	public int insertWish(WishList wishlist);
	//영상, 자막, 더빙 위시리스트 삭제	
	public int deleteWish(String title);	
		
}

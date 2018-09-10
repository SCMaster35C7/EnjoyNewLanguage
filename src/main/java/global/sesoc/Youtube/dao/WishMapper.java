package global.sesoc.Youtube.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import global.sesoc.Youtube.dto.WishList;

public interface WishMapper {
	

	//영상위시리스트 데이터 수
	public int getTotalCount1(Map<String, String> map);
	// 위시리스트 중복 확인
	public WishList selectOneFromWishList(WishList wishlist);
	
	
	//영상위시리스트 불러오기
	public List<WishList> getVideoWishList(Map<String,Object> map, RowBounds bound);	
	//영상위시리스트 선택
	public WishList selectVideoWish(int wishnum);	
	//영상위시리스트 등록
	public int insertVideoWish(WishList wishlist);		
	//영상위시리스트 삭제	
	public int deleteVideoWish(int wishnum);															
	

	//자막위시리스트 데이터 수
	/*public int getTotalCount2(Map<String, String> map);*/
	//자막위시리스트 불러오기
	public List<WishList> getSubWishList(Map<String, Object> map, RowBounds bound);						
	//자막위시리스트 선택
	public WishList selectSubWish(int wishnum);	
	//자막위시리스트 등록
	public int insertSubWish(WishList wishlist);
	//자막위시리스트 삭제	
	public int deleteSubWish(int wishnum);
	

	//더빙위시리스트 데이터 수
	/*public int getTotalCount3(Map<String, String> map);*/
	//더빙위시리스트 불러오기
	public List<WishList> getDubWishList(Map<String, Object> map, RowBounds bound);							
	//더빙위시리스트 게시글 선택
	public WishList selectDubWish(int wishnum);
	//더빙위시리스트 등록
	public int insertDubWish(WishList wishlist);
	//더빙위시리스트 삭제	
	public int deleteDubWish(int wishnum);

		
}

package global.sesoc.Youtube.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import global.sesoc.Youtube.dto.DubWishList;
import global.sesoc.Youtube.dto.SubWishList;
import global.sesoc.Youtube.dto.VideoWishList;

public interface WishMapper {
	
	//영상위시리스트 불러오기
	public VideoWishList findVideoWish(Map<String, Object> map);
	//영상위시리스트 데이터 수
	public int videoWishCount(String useremail);									
	//영상위시리스트 등록
	public int insertVideoWish(Map<String, Object> map);						
	//영상위시리스트 선택
	public List<VideoWishList> selectVideoWish(String useremail, RowBounds bound);	
	//영상위시리스트 삭제	
	public int deleteVideoWish(int videowishnum);															
	
	//자막위시리스트 불러오기
	public SubWishList findSubWish(Map<String, Object> map);
	//자막위시리스트 데이터 수
	public int subWishCount(String useremail);									
	//자막위시리스트 등록
	public int insertSubWish(Map<String, Object> map);						
	//자막위시리스트 선택
	public List<SubWishList> selectSubWish(String useremail, RowBounds bound);	
	//자막위시리스트 삭제	
	public int deleteSubWish(int subwishnum);
	
	//더빙위시리스트 불러오기
	public DubWishList findDubWish(Map<String, Object> map);
	//더빙위시리스트 데이터 수
	public int dubWishCount(String useremail);									
	//더빙위시리스트 등록
	public int insertDubWish(Map<String, Object> map);						
	//더빙위시리스트 선택
	public List<DubWishList> selectDubWish(String useremail, RowBounds bound);	
	//더빙위시리스트 삭제	
	public int deleteDubWish(int dubwishnum);
		
}

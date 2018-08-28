package global.sesoc.Youtube.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import global.sesoc.Youtube.dto.Dubbing;
import global.sesoc.Youtube.dto.Education;

public interface EducationMapper {
	public List<Education> selectEduList(RowBounds bound);	// 교육영상 목록
	public Education selectOneFromEduVideo(int videoNum);	// 교육 영상 가져오기
	public int insertEduVideo(Education education);			// 교육 영상 삽입
	public int getTotalCount(Map<String, Object> map);		// 교육 영상 개수 추출
	String selectSubName(int videoNum);                     // 자막파일 이름가져오기
	public int updateHitCount(int videoNum);				// 교육 영상 조회수 증가
	public List<Dubbing> dubbingBoard();	//더빙보드
	public Dubbing selectOneDub(int dubbingnum);
}

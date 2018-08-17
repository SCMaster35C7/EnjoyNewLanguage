package global.sesoc.Youtube.dao;

import java.util.List;

import global.sesoc.Youtube.dto.Education;

public interface EducationMapper {
	public List<Education> selectAllEduList();				// 교육영상 목록
	public Education selectOneFromEduVideo(int videoNum);	// 교육 영상 가져오기
	public int insertEduVideo(Education education);				// 교육 영상 삽입
}

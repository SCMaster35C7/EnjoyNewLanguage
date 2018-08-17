package global.sesoc.Youtube.dao;

import java.util.List;

import global.sesoc.Youtube.dto.Education;

public interface EducationMapper {
	List<Education> selectAllStudyList();			// 교육영상 목록
	Education selectOneFromEduVideo(int videoNum);	// 교육 영상 가져오기
}

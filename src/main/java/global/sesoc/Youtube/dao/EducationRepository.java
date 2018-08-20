package global.sesoc.Youtube.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.Youtube.dto.Education;

@Repository
public class EducationRepository {
	@Autowired
	SqlSession session;
	
	/**
	 * 교육용 동영상을 전부 추출
	 * @return
	 */
	public List<Education> selectAllEduList() {
		EducationMapper mapper = session.getMapper(EducationMapper.class);
		List<Education> eduList = mapper.selectAllEduList();
		
		return eduList;
	}

	/**
	 * 교육용 동영상 중 선택된 특정 영상을 추출
	 * @param videoNum
	 * @return
	 */
	public Education selectOneFromEduVideo(int videoNum) {
		EducationMapper mapper = session.getMapper(EducationMapper.class);
		Education edu = mapper.selectOneFromEduVideo(videoNum);
		
		return edu;
	}
	
	/**
	 * 교육용 동영상 삽입
	 * @param education
	 * @return
	 */
	public int insertEduVideo(Education education) {
		EducationMapper mapper = session.getMapper(EducationMapper.class);
		int result = mapper.insertEduVideo(education);
		
		return result;
	}
	
}

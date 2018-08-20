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

	public List<Education> selectAllStudyList() {
		EducationMapper mapper = session.getMapper(EducationMapper.class);
		List<Education> eduList = mapper.selectAllStudyList();

		return eduList;
	}

	public Education selectOneFromEduVideo(int videoNum) {
		EducationMapper mapper = session.getMapper(EducationMapper.class);
		Education edu = mapper.selectOneFromEduVideo(videoNum);

		return edu;
	}

	public String selectSubName(int videoNum) {
		EducationMapper mapper = session.getMapper(EducationMapper.class);
		String result = mapper.selectSubName(videoNum);
		return result;
	}

}

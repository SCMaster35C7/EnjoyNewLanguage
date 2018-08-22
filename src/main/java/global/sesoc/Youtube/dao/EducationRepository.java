package global.sesoc.Youtube.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.Youtube.dto.Education;

@Repository
public class EducationRepository {
	@Autowired
	SqlSession session;

	public List<Education> selectEduList(String searchType, String searchWord, int startRecord, int countPerPage) {
		RowBounds bound = new RowBounds(startRecord, countPerPage);
		
		EducationMapper mapper = session.getMapper(EducationMapper.class);
		List<Education> eduList = mapper.selectEduList(bound);
		
		return eduList;
	}

	public Education selectOneFromEduVideo(int videoNum) {
		EducationMapper mapper = session.getMapper(EducationMapper.class);
		Education edu = mapper.selectOneFromEduVideo(videoNum);
		
		return edu;
	}

	public int insertEduVideo(Education education) {
		EducationMapper mapper = session.getMapper(EducationMapper.class);
		int result = mapper.insertEduVideo(education);
		
		return result;
	}

	public int getTotalCount(String searchType, String searchWord) {
		EducationMapper mapper = session.getMapper(EducationMapper.class);
		Map<String, Object> map = new HashMap<>();
		map.put("searchType", searchType);
		map.put("searchWord", searchWord);
		
		int result = mapper.getTotalCount(map);
		
		return result;
	}

	public int updateHitCount(int videoNum) {
		EducationMapper mapper = session.getMapper(EducationMapper.class);
		int result = mapper.updateHitCount(videoNum);
		
		return result;
	}
	
}

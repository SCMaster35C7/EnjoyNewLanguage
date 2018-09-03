package global.sesoc.Youtube.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.Youtube.dto.Investigation;

@Repository
public class InvestigationRepository {
	@Autowired
	SqlSession session;

	public int getTotalCount(String searchType, String searchWord) {
		InvestigationMapper mapper = session.getMapper(InvestigationMapper.class);
		Map<String, String> map =new HashMap<>();
		map.put("searchType", searchType);
		map.put("searchWord", searchWord);
		
		int result = mapper.getTotalCount(map);
				
		return result;
	}

	public List<Investigation> selectInvList(String searchType, String searchWord, int startRecord, int getcountPerPage) {
		InvestigationMapper mapper = session.getMapper(InvestigationMapper.class);
		RowBounds bound = new RowBounds(startRecord, getcountPerPage);
		
		Map<String, String> map = new HashMap<>();
		map.put("searchType", searchType);
		map.put("searchWord", searchWord);
		
		List<Investigation> invList = mapper.selectInvList(map, bound);
		
		return invList;
	}

	public int insertInvestigation(Investigation inv) {
		InvestigationMapper mapper = session.getMapper(InvestigationMapper.class);
		int result = mapper.insertInvestigation(inv);
		
		return result;
	}

	public Investigation selectOneFromInvUseURL(Investigation inv) {
		InvestigationMapper mapper = session.getMapper(InvestigationMapper.class);
		Investigation findInv = mapper.selectOneFromInvUseURL(inv);
		
		return findInv;
	}

	public Investigation selectOneFromInvUseNum(int investigationnum) {
		InvestigationMapper mapper = session.getMapper(InvestigationMapper.class);
		Investigation inv = mapper.selectOneFromInvUseNum(investigationnum);
		
		return inv;
	}

	public int updateHitCount(int investigationnum) {
		InvestigationMapper mapper = session.getMapper(InvestigationMapper.class);
		int result = mapper.updateHitCount(investigationnum);
		
		return result;
	}
}

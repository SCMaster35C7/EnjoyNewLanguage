package global.sesoc.Youtube.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import global.sesoc.Youtube.dto.Investigation;

public interface InvestigationMapper {
	public int getTotalCount(Map<String, String> map);									// 자막 요청 게시글 총 수
	public List<Investigation> selectInvList(Map<String, String> map, RowBounds bound);	// 자막 요청 게시글 가져오기
}
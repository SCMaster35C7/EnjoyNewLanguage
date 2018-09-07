package global.sesoc.Youtube.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;

import global.sesoc.Youtube.dto.Investigation;
import global.sesoc.Youtube.dto.InvSubtitle;
import global.sesoc.Youtube.dto.Reply;

public interface InvestigationMapper {
	// investigation 테이블 관련
	public int getTotalCount(Map<String, String> map);									// 자막 요청 게시글 총 수
	public List<Investigation> selectInvList(Map<String, String> map, RowBounds bound);	// 자막 요청 게시글 가져오기
	public int insertInvestigation(Investigation inv);									// 자막 요청 게시글 등록
	public Investigation selectOneFromInvUseURL(Investigation inv);						// 자막 요청 URL 중복 확인
	public Investigation selectOneFromInvUseNum(int investigationnum);					// 자막 요청 특정 게시글 탐색
	public int updateHitCount(int investigationnum);									// 자막 요청 게시글 조회수 증가
	
	// investigationReply 테이블 관련
	public List<Reply> replyAllFromInv(int investigationnum);							// 자막 요청 게시글 댓글 가져오기
	public int insertReplyToInv(Reply reply);											// 자막 요청 게시글 댓글 추가	
	public int replyInvUpdate(Reply reply);												// 자막 요청 게시글 댓글 수정
	public int replyInvDelete(int replynum);											// 자막 요청 게시글 댓글 삭제
	
	// investigationSubtitle 테이블 관련
	public int insertInvSubtitle(InvSubtitle invSub);									// 자막 요청 게시글의 자막 파일 등록
	public List<InvSubtitle> subtitleAllFromInv(int investigationnum);					// 자막 요청 게시글의 자막 파일 목록 가져오기
	public int deleteInvSubtitle(int subtitleNum);										// 자막 요청 게시글의 자막 파일 삭제
	public InvSubtitle selectOneFromSubUseNum(int subtitleNum);
}

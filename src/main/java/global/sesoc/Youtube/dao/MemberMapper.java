package global.sesoc.Youtube.dao;

import java.util.List;
import java.util.Map;

import global.sesoc.Youtube.dto.Member;
import global.sesoc.Youtube.dto.TestResult;
import global.sesoc.Youtube.dto.Video;

public interface MemberMapper {
	public Member selectOneFromMember(Member member); 			// 아이디 중복 검사, 아이디 검사
	public int insertMember(Member member);
	public int updateStatus(String useremail);
	public Member selectByNick(String usernick);
	public int updateLastAccess(String useremail);
	public int updateMember(Map<String, String> map); 			// 회원정보 수정
	public Member selectMyInfo(Member member); 					//마이페이지 처음 정보
	public List<Video> selectMyVideo(String useremail); 		// 마이페이지 처음 영상제목
	public List<TestResult> selectLevels(String useremail); 	//마이페이지 레벨스
	public int checkChallengeCount(String useremail); 			// x/0을 방지하기 위한 분모체크용
	public int insertCloseID(String useremail);					// 잠구는 계정 추가
	public int recoveryID(String useremail); 					//계정 복구
	public Member selectInConfirm(String useremail);
	
	public int idCompletelyDeleteFromMember();					// 한 달된 계정 삭제(Member)
	public int idCompletelyDeleteFromConfirmmeber();			// 한 달된 계정 삭제(ConfirmMember)
}

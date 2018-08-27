package global.sesoc.Youtube.dao;

import java.util.List;
import java.util.Map;

import global.sesoc.Youtube.dto.Member;
import global.sesoc.Youtube.dto.TestResult;
import global.sesoc.Youtube.dto.Video;

public interface MemberMapper {
	public Member selectOneFromMember(Member member);		// 아이디 중복 검사, 아이디 검사

	public int insertMember(Member member);

	public int updateStatus(String useremail);

	public Member selectByNick(String usernick);


public int updateLastAccess(String useremail);

public int updateMember(Member member);		//회원정보 수정

public Member selectMyInfo(String useremail); //마이페이지 처음 정보

public List<Video> selectMyVideo(String useremail); //마이페이지 처음 영상제목

public List<TestResult> selectLevels(String useremail); //마이페이지 레벨스
}

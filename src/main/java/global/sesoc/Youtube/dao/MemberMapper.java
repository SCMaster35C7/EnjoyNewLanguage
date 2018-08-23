package global.sesoc.Youtube.dao;

import java.util.Map;

import global.sesoc.Youtube.dto.Member;

public interface MemberMapper {
	public Member selectOneFromMember(Member member);		// 아이디 중복 검사, 아이디 검사

	public int insertMember(Member member);

	public int updateStatus(String useremail);

	public Member selectByNick(String usernick);

	public int updateLastAccess(String useremail);

	/*public int updateMember(Member member);*/		//회원정보 수정
	
	public int updateMember(Map<String, String> map);
}

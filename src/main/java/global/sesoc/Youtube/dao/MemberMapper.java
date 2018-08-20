package global.sesoc.Youtube.dao;

import java.util.Map;

import global.sesoc.Youtube.dto.Member;

public interface MemberMapper {
	public Member selectOneFromMember(Map<String, Object> map);		// 아이디 중복 검사, 아이디 검사
	
	public int updateMember (Member member);	// 회원수정
}

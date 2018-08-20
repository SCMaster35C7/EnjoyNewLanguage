package global.sesoc.Youtube.dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.Youtube.dto.Member;

@Repository
public class MemberRepository {
	@Autowired
	SqlSession session;
	
	/**
	 * 사용자 아이디 중복 검사 or 사용자 아이디 확인
	 * @param useremail
	 * @param userpwd
	 * @return
	 */
	public Member selectOneFromMember(String useremail, String userpwd) {
		Map<String, Object> map = new HashMap<>();
		map.put("useremail", useremail);
		map.put("userpwd", userpwd);
		
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		Member member = mapper.selectOneFromMember(map);
		
		return member;
	}
	
}

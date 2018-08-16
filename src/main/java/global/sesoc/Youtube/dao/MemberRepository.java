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

	public Member selectOneFromMember(String userid, String userpwd) {
		Map<String, Object> map = new HashMap<>();
		map.put("userid", userid);
		map.put("userpwd", userpwd);
		
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		Member member = mapper.selectOneFromMember(map);
		
		return member;
	}
	
}

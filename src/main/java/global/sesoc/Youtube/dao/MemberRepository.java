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

	public Member selectOneFromMember(String useremail, String userpwd) {
		Map<String, Object> map = new HashMap<>();
		map.put("useremail", useremail);
		map.put("userpwd", userpwd);
		
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		Member member = mapper.selectOneFromMember(map);
		
		return member;
	}
	public int updateMember (Member member) {
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		
		int result = 0;
		try {
			result = mapper.updateMember(member);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
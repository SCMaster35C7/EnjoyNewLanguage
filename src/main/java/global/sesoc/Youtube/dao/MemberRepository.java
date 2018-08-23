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

	public Member selectOneFromMember(Member m) {
		/*Map<String, Object> map = new HashMap<>();
		map.put("useremail", useremail);
		map.put("userpwd", userpwd);*/
		
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		Member member = mapper.selectOneFromMember(m);
		
		return member;
	}

	public int insertMember(Member member) {
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		int result = mapper.insertMember(member);
		
		return result;
		
	}

	public int updateStatus(String useremail) {
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		int result = mapper.updateStatus(useremail);
		
		return result;
	}

	public Member selectByNick(String usernick) {
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		Member member = mapper.selectByNick(usernick);
		
		return member;
	}

	public int updateLastAccess(String useremail) {
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		int result = mapper.updateLastAccess(useremail);
		
		return result;
		
	}
	
}

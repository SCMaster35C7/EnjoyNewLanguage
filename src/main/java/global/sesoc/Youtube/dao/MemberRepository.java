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

		public int updateMember(String loginId, String currpwd, String newpwd, String usernick) {
			MemberMapper mapper = session.getMapper(MemberMapper.class);

			int result = 0;
			Map<String, String> map = new HashMap<>();
			map.put("useremail", loginId);
			map.put("currpwd", currpwd);
			map.put("newpwd", newpwd);
			map.put("usernick", usernick);
			
			try {
				result = mapper.updateMember(map);
			}
			catch (Exception e) {
				e.printStackTrace();
			}
			return result;
		}

}


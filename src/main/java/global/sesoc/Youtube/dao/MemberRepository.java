package global.sesoc.Youtube.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.Youtube.dto.Member;
import global.sesoc.Youtube.dto.TestResult;
import global.sesoc.Youtube.dto.Video;

@Repository
public class MemberRepository {
	@Autowired
	SqlSession session;

	/**
	 * 사용자 아이디 중복 검사 or 사용자 아이디 확인
	 * 
	 * @param useremail
	 * @param userpwd
	 * @return
	 */
	public Member selectOneFromMember(Member m) {
		/*
		 * Map<String, Object> map = new HashMap<>(); map.put("useremail", useremail);
		 * map.put("userpwd", userpwd);
		 */

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

	public int updateMember(String useremail, String currpwd, String newpwd, String usernick/* , Member member */) {
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		int result = 0;
		Map<String, String> map = new HashMap<>();

		map.put("useremail", useremail);
		map.put("currpwd", currpwd);
		map.put("newpwd", newpwd);
		map.put("usernick", usernick);

		result = mapper.updateMember(map);

		/* int result = mapper.updateMember(member); */
		try {
			// result = mapper.updateMember(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public Member selectMyInfo(Member member) {

		MemberMapper mapper = session.getMapper(MemberMapper.class);
		Member result = mapper.selectMyInfo(member);

		return result;

	}

	public List<Video> selectMyVideo(String useremail) {
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		List<Video> video = mapper.selectMyVideo(useremail);

		return video;
	}

	public List<TestResult> selectLevels(String useremail) {
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		List<TestResult> levelList = mapper.selectLevels(useremail);
		return levelList;
	}

	public int checkChallengeCount(String useremail) {
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		int result = mapper.checkChallengeCount(useremail);
		return result;
	}

	public int insertCloseID(String useremail) {
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		int result = mapper.insertCloseID(useremail);
		return result;
	}

	public int recoveryID(String useremail) {
		MemberMapper mapper = session.getMapper(MemberMapper.class);
		int result = mapper.recoveryID(useremail);
		return result;
	}
}

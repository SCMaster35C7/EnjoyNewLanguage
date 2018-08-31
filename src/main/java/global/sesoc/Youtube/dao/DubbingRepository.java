package global.sesoc.Youtube.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.Youtube.dto.Dubbing;

@Repository
public class DubbingRepository {
	@Autowired
	SqlSession session;

	public int insertDubbing(Dubbing dub) {
		DubbingMapper mapper = session.getMapper(DubbingMapper.class);
		int result = mapper.insertDubbing(dub);
		return result;

	}

}

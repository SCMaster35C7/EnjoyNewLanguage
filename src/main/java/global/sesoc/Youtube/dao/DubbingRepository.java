package global.sesoc.Youtube.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.Youtube.dto.Dubbing;
@Repository
public class DubbingRepository {

	@Autowired
	SqlSession session;
	
	public Dubbing selectOneDub(int dubbingnum) {
		DubbingMapper mapper = session.getMapper(DubbingMapper.class);
		Dubbing dubbing = mapper.selectOneDub(dubbingnum);
		return dubbing;
	}

	
	public List<Dubbing> dubbingBoard() {
		DubbingMapper mapper = session.getMapper(DubbingMapper.class);
		List<Dubbing> dubbing = mapper.dubbingBoard();
		return dubbing;
	}


	public int insertDubbing(Dubbing dub) {
		DubbingMapper mapper = session.getMapper(DubbingMapper.class);
		int result = mapper.insertDubbing(dub);
		return result;

	}

}

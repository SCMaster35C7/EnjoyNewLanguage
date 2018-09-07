package global.sesoc.Youtube.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.Youtube.dto.Black;
import global.sesoc.Youtube.dto.Dubbing;
import global.sesoc.Youtube.dto.Reply;

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
  
  public int deleteDubbing(Dubbing dub) {
		DubbingMapper mapper = session.getMapper(DubbingMapper.class);
		int result = mapper.deleteDubbing(dub);
		return result;
	}

	public List<Reply> replyDubAll(int idnum) {
		DubbingMapper mapper = session.getMapper(DubbingMapper.class);
		List<Reply> replyList = mapper.replyDubAll(idnum);
		return replyList;
	}

	public int replyDubDelete(int replynum) {
		DubbingMapper mapper = session.getMapper(DubbingMapper.class);
		int result = mapper.replyDubDelete(replynum);
		return result;
	}

	public int replyDubUpdate(Reply reply) {
		DubbingMapper mapper = session.getMapper(DubbingMapper.class);
		int result = mapper.replyDubUpdate(reply);
    
		return result;
	}

	public Black existedBlack(Black black) {
		DubbingMapper mapper = session.getMapper(DubbingMapper.class);
		Black b = mapper.existedBlack(black);
		return b;
	}

	public int insertBlack(Black black) {
		DubbingMapper mapper = session.getMapper(DubbingMapper.class);
		int result = mapper.insertBlack(black);
    
		return result;
	}

	public int updateBlack(Black black) {
		DubbingMapper mapper = session.getMapper(DubbingMapper.class);
		int result = mapper.updateBlack(black);
		return result;
	}


	public Reply selectReply(Black black) {
		DubbingMapper mapper = session.getMapper(DubbingMapper.class);
		Reply reply = mapper.selectReply(black);
		return reply;
	}

	public int reportDelete(Black black) {
		DubbingMapper mapper = session.getMapper(DubbingMapper.class);
		int result = mapper.reportDelete(black);
		return result;
	}

	public int replyDubInsert(Reply reply) {
		DubbingMapper mapper = session.getMapper(DubbingMapper.class);
		int result = mapper.replyDubInsert(reply);
		return result;
	}
}

package global.sesoc.Youtube.dao;

import java.util.List;

import global.sesoc.Youtube.dto.Dubbing;
import global.sesoc.Youtube.dto.Reply;

public interface DubbingMapper {

	public int insertDubbing(Dubbing dub);
	public List<Dubbing> dubbingBoard();	//더빙보드
	public Dubbing selectOneDub(int dubbingnum);
	
	//주말
	public List<Reply> replyAll(int dubbingnum);
	public int insertReply(Reply reply);
	public int replyDelete(int replynum);
	public int replyUpdate(Reply reply);
}

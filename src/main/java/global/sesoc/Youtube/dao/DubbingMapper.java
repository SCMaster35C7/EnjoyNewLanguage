package global.sesoc.Youtube.dao;

import java.util.List;

import global.sesoc.Youtube.dto.Black;
import global.sesoc.Youtube.dto.Dubbing;
import global.sesoc.Youtube.dto.Reply;

public interface DubbingMapper {
	public int insertDubbing(Dubbing dub);        // 더빙 삽입
	public List<Dubbing> dubbingBoard();	      // 더빙 보드 
	public Dubbing selectOneDub(int dubbingnum);  // 특정 더빙 가져오기
	public int deleteDubbing(Dubbing dub);        // 더빙 지우기
	public List<Reply> replyDubAll(int idnum);  // 댓글 가져오기
	public int insertReply(Reply reply);          // 댓글 삽입
	public int replyDubDelete(int replynum);         // 댓글 삭제
	public int replyDubUpdate(Reply reply);          // 댓글 수정
	public Black existedBlack(Black black);
	public int insertBlack(Black black);
	public int updateBlack(Black black);
	public Reply selectReply(Black black);
	public int reportDelete(Black black);

}

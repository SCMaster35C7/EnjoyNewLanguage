package global.sesoc.Youtube.dao;

import java.util.List;

import global.sesoc.Youtube.dto.Dubbing;

public interface DubbingMapper {

	public int insertDubbing(Dubbing dub);
	public List<Dubbing> dubbingBoard();	//더빙보드
	public Dubbing selectOneDub(int dubbingnum);
}

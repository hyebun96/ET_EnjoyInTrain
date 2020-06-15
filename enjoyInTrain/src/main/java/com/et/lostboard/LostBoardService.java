package com.et.lostboard;

import java.util.List;

public interface LostBoardService {
	public int insertBoard(LostBoard dto);
	public int updateBoard(int num);
	public int deleteBoard(int num);
	public LostBoard readBoard(int num);
	public List<LostBoard> listLostBoard();
}

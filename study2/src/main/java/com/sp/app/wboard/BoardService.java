package com.sp.app.wboard;

import java.util.List;
import java.util.Map;

public interface BoardService {
	public void insertBoard(Board dto, String mode) throws Exception;
	public int dataCount(Map<String, Object> map);
	public List<Board> listBoard(Map<String, Object> map);
	public List<Board> listCategory();
	public Board preReadBoard(Map<String, Object> map);
	public Board nextReadBoard(Map<String, Object> map);
	public void updateHitCount(int bNum) throws Exception;
	public Board readBoard(int bNum);
	public void updateBoard(Board dto) throws Exception;
	public void deleteBoard(int bNum) throws Exception;
}

package com.sp.app.wboard;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.dao.CommonDAO;

@Service("wboard.BoardService")
public class BoardServiceImpl implements BoardService {

	@Autowired
	private CommonDAO dao;

	@Override
	public void insertBoard(Board dto, String mode) throws Exception {
		int seq = dao.selectOne("wboard.wboard_seq");
		dto.setbNum(seq);
		try {
			if(mode.equalsIgnoreCase("insert")) {
				dto.setGroupNum(seq);
				dto.setDepth(0);
				dto.setOrderNum(0);
				dto.setParent(0);
			} else {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("groupNum", dto.getGroupNum());
				map.put("orderNum", dto.getOrderNum());
				
				dao.updateData("wboard.updateOrderNum", map);
				dto.setOrderNum(dto.getOrderNum()+1);
				dto.setDepth(dto.getDepth()+1);
			}
			dao.insertData("wboard.insertBoard", dto);
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("wboard.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Board> listBoard(Map<String, Object> map) {
		List<Board> list = new ArrayList<Board>();
		try {
			list = dao.selectList("wboard.listBoard",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Board> listCategory() {
		List<Board> list = new ArrayList<Board>();
		try {
			list = dao.selectList("wboard.listCategory");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Board preReadBoard(Map<String, Object> map) {
		Board dto = null;
		try {
			dto = dao.selectOne("wboard.preReadBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Board nextReadBoard(Map<String, Object> map) {
		Board dto = null;
		try {
			dto = dao.selectOne("wboard.nextReadBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateHitCount(int bNum) throws Exception{
		try {
			dao.updateData("wboard.updateHitCount", bNum);
		} catch (Exception e) {
			throw e;
		}

	}

	@Override
	public Board readBoard(int bNum) {
		Board dto = null; 
		try {
			dto = dao.selectOne("wboard.readBoard", bNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateBoard(Board dto) throws Exception {
		try {
			dao.updateData("wboard.updateBoard", dto);
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public void deleteBoard(int bNum) throws Exception {
		try {
			dao.deleteData("wboard.deleteBoard", bNum);
		} catch (Exception e) {
			throw e;
		}
	}

}

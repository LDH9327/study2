package com.sp.app.wboard;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.app.common.MyUtil;

@Controller("wboard.BoardController")
@RequestMapping("/wboard/*")
public class BoardController {
	
	@Autowired
	private BoardServiceImpl service;
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping("list")
	public String list(
			@RequestParam(value = "cn", defaultValue = "0") int cNum,
			@RequestParam(value = "page",defaultValue = "1") int current_page,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			@RequestParam(defaultValue = "10") int rows,
			HttpServletRequest req,
			Model model
			) throws Exception {
		
		List<Board> clist = service.listCategory();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cNum", cNum);
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		int dataCount = service.dataCount(map);
		int total_page = myUtil.pageCount(rows, dataCount);
		if(current_page > total_page)
			current_page = total_page;
		int offset = (current_page-1) * rows;
		if(offset < 0)
			offset = 0;
		
		map.put("offset", offset);
		map.put("rows",rows);
		List<Board> blist = service.listBoard(map);
		int listNum, n =0;
		for(Board dto : blist) {
			listNum = dataCount - (offset + (n++));
			dto.setListNum(listNum);
		}
		
		String cp = req.getContextPath();
		String query = "cn="+cNum;
		String listUrl = cp+"/wboard/list";
		String articleUrl = cp + "/wboard/article?page="+current_page;
		if(keyword.length()!=0) {
			query += "&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "utf-8");
		}
		listUrl += "?"+query;
		articleUrl += "&"+query;
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("keyword", keyword);
		model.addAttribute("condition", condition);
		model.addAttribute("clist", clist);
		model.addAttribute("boardList", blist);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("page", current_page);
		model.addAttribute("cNum", cNum);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("paging", paging);
		model.addAttribute("rows", rows);
		
		return "wboard/list";
	}
	
	@GetMapping("insert")
	public String insertForm(
			Model model
			) throws Exception {
		
		List<Board> clist = service.listCategory();
		
		model.addAttribute("categoryList", clist);
		model.addAttribute("mode", "insert");
		
		return "wboard/writer";
	}
	
	@PostMapping("insert")
	public String insertSubmit(
			Board dto,
			@RequestParam(value = "cn", defaultValue = "0") int cNum,
			HttpServletRequest req
			) throws Exception {
		dto.setcNum(cNum);
		String ip = req.getRemoteAddr();
		dto.setIpAddr(ip);
		
		service.insertBoard(dto, "insert");
		
		return "redirect:/wboard/list";
	}
	
	@GetMapping("article")
	public String article(
			@RequestParam int bNum,
			@RequestParam String page,
			@RequestParam(defaultValue = "0") int cn,
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			Model model
			) throws Exception {
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		
		String query = "page="+page+"&cn="+cn;
		if(keyword.length()!=0) {
			query += "&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "utf-8");
		}
		
		
		service.updateHitCount(bNum);
		
		Board dto = service.readBoard(bNum);
		if(dto==null)
			return "redirect:/board/list?"+query;
		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cNum", cn);
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("groupNum", dto.getGroupNum());
		map.put("orderNum", dto.getbNum());
		Board preReadBoard = service.preReadBoard(map);
		Board nextReadBoard = service.nextReadBoard(map);
		
		model.addAttribute("dto", dto);
		model.addAttribute("preReadBoard", preReadBoard);
		model.addAttribute("nextReadBoard", nextReadBoard);
		model.addAttribute("cNum", cn);
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		
		return "wboard/article";
	}
	
	@GetMapping("reply")
	public String replyForm (
			@RequestParam int bNum,
			@RequestParam String page,
			Model model
			) throws Exception {
		
		Board dto = service.readBoard(bNum);
		if(dto==null)
			return "redirect:/wboard/list?page="+page;
		
		String str = "["+dto.getTitle()+"]에 대한 답변입니다.\n";
		dto.setContent(str);
		dto.setName("");
		dto.setPwd("");
		
		List<Board> clist = service.listCategory();
		model.addAttribute("clist", clist);
		
		model.addAttribute("dto", dto);
		model.addAttribute("mode", "reply");
		model.addAttribute("page", page);
		
		return "wboard/writer";
	}
	
	@PostMapping("reply")
	public String replySubmit(
			Board dto,
			@RequestParam String page,
			HttpServletRequest req
			) throws Exception {
		
		try {
			dto.setIpAddr(req.getRemoteAddr());
			service.insertBoard(dto, "reply");
		} catch (Exception e) {
		}
		
		return "redirect:/wboard/list?page="+page;
	}
	
	@GetMapping("pwd")
	public String pwdForm(
			@RequestParam int bNum,
			@RequestParam String page,
			@RequestParam String mode,
			Model model
			) throws Exception {
		
		model.addAttribute("bNum", bNum);
		model.addAttribute("page", page);
		model.addAttribute("mode", mode);
		
		return "wboard/pwd";
	}
	
	@PostMapping("pwd")
	public String pwdSubmit(
			@RequestParam int bNum,
			@RequestParam String page,
			@RequestParam String mode,
			@RequestParam String pwd,
			Model model
			) throws Exception {
		
		Board dto = service.readBoard(bNum);
		if(dto == null)
			return "redirect:/wboard/list?page="+page;
		
		if(! dto.getPwd().equals(pwd)) {
			model.addAttribute("bNum", bNum);
			model.addAttribute("page", page);
			model.addAttribute("mode", mode);
			model.addAttribute("msg", "패스워드가 일치하지 않습니다.");
			return "wboard/pwd";
		}
		
		if(mode.equals("delete")) {
			service.deleteBoard(bNum);
			return "redirect:/wboard/list?page="+page;
		}
		
		if(mode.equals("update")) {
			List<Board> clist = service.listCategory();
			
			model.addAttribute("dto", dto);
			model.addAttribute("clist", clist);
			model.addAttribute("mode", mode);
			model.addAttribute("page", page);
			
			return "wboard/writer";
		}
		
		return "redirect:/wboard/list?page="+page;
	}
	
	@PostMapping("update")
	public String updateSubmit(
			Board dto,
			@RequestParam String page
			) throws Exception {
		try {
			service.updateBoard(dto);
		} catch (Exception e) {
		}
		
		return "redirect:/wboard/list?page="+page;
	}
}

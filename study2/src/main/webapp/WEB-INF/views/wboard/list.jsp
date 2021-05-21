<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/style.css">
<script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
<style type="text/css">
* {
	margin: 0;
	padding: 0;
	font-size: 14px;
	font-family: 맑은 고딕, 돋움;
}
.boardLayout {
	width: 700px;
	margin: 30px auto;
}
table {
	width: 100%;
	border-spacing: 0;
	border-collapse: collapse;
}

.title span{
	font-size: 24px;
	font-weight: 700;
}

.table-header {
	margin: 30px auto 10px;
}

.table-body tr {
	height: 35px;
	border-bottom: 1px solid #ccc;
}

.table-body tr:first-child {
	border-top: 2px solid #ccc;
	background: #eee;
}

.table-boby tr:last-child {
	border-bottom: 2px solid #ccc;
}

.table-body td:nth-child(1) {
	width: 70px
}
.table-body td:nth-child(2) {
	width: 150px
}
.table-body td:nth-child(3) {
	width: 180px
}
.table-body td:nth-child(4) {
	width: 100px
}
.table-body td:nth-child(5) {
	width: 120px
}
.table-body td:nth-child(6) {
	width: 70px
}

.table-footer {
	margin: 15px auto 30px;
}
.table-footer tr {
	height: 35px;
}
.table-footer td:nth-child(1) {
	width: 100px;
}
.table-footer td:nth-child(2) {
	width: 500px;
}
.table-footer td:nth-child(3) {
	width: 100px;
}
</style>

<script type="text/javascript">
function searchOk() {
	const f = document.searchForm;
	f.action = "${pageContext.request.contextPath}/wboard/list";
	f.submit();
}

$(function() {
	$("#cn").change(function() {
		let cn = $(this).val();
		let url = "${pageContext.request.contextPath}/wboard/list?cn="+cn;
		location.href=url;
	});
	
	$("#rows").change(function() {
		let rows = $(this).val();
		let url = "${pageContext.request.contextPath}/wboard/list?rows="+rows;
		location.href = url;
	});
});
</script>
</head>
<body>
<div class="boardLayout">
	<table class="title">
		<tr>
			<td>
				<span>문의 사항</span>
			</td>
		</tr>
	</table>
	
	<table class="table table-header">
		<tr>
			<td width="50%">
				${dataCount}개 (${page}/${total_page})페이지
			</td>
			<td align="right">
				<select name="cn" id="cn" class="selectField">
					<option value="0">모두</option>
					<c:forEach var="vo" items="${clist}">
						<option value="${vo.cNum}" ${vo.cNum==cNum? "selected='selected'":"" }>${vo.subject}</option>				
					</c:forEach>
				</select>
				<select id="rows" name="rows" class="selectField">
					<option value="5" ${rows==5?"selected='selected'":""}>5개씩 출력</option>
					<option value="10" ${rows==10?"selected='selected'":""}>10개씩 출력</option>
					<option value="20" ${rows==20?"selected='selected'":""}>20개씩 출력</option>
					<option value="30" ${rows==30?"selected='selected'":""}>30개씩 출력</option>
				</select>
			</td>
		</tr>
	</table>
	<table class="table table-body">
		<tr>
			<td align="center">번호</td>
			<td align="center">카테고리</td>
			<td align="center">제목</td>
			<td align="center">작성자</td>
			<td align="center">등록일</td>
			<td align="center">조회수</td>
		</tr>
		<c:forEach var="vo" items="${boardList}">
			<tr>
				<td align="center">${vo.listNum}</td>
				<td align="center">${vo.subject}</td>
				<td>
					<c:forEach var="n" begin="1" end="${vo.depth}">
						&nbsp;
					</c:forEach>
					<c:if test="${vo.depth != 0}">└&nbsp;</c:if>
					<a href="${articleUrl}&bNum=${vo.bNum}">${vo.title}</a>
				</td>
				<td align="center">${vo.name}</td>
				<td align="center">${vo.reg_date}</td>
				<td align="center">${vo.hitCount}</td>
			</tr>
		</c:forEach>
	</table>
	<table class="table table-footer">
		<tr>
			<td colspan="3" align="center">${dataCount==0 ? "등록된 데이터가 없습니다." : paging}</td>
		</tr>
		<tr>
			<td >
				<button type="button" onclick="location.href='${pageContext.request.contextPath}/wboard/list'" class="btn">새로고침</button>				
			</td>
			<td align="center">
				<form name="searchForm" method="post">
					<select name="condition" class="selectField">
						<option value="all" ${condition=='all' ? "selected='selected'" : "" }>내용+제목</option>
						<option value="content" ${condition=='content' ? "selected='selected'" : "" }>내용</option>
						<option value="title" ${condition=='title' ? "selected='selected'" : "" }>제목</option>
						<option value="name" ${condition=='name' ? "selected='selected'" : "" }>작성자</option>
						<option value="reg_date" ${condition=='reg_date' ? "selected='selected'" : "" }>작성일</option>
					</select>
					<input type="text" name="keyword" class="boxTF" value="${keyword}">
					<button type="button" class="btn" onclick="searchOk()">검색</button>
				</form>
			</td>
			<td align="right">
				<button type="button" onclick="location.href='${pageContext.request.contextPath}/wboard/insert';" class="btn">글 작성</button>
			</td>
		</tr>
	</table>
</div>
</body>
</html>
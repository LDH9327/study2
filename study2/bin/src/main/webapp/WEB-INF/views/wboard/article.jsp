<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객센터</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/style.css">
<style type="text/css">
* {
	margin: 0;
	padding: 0;
	font-size: 14px;
	font-family: 맑은 고딕, 돋움;
}

.board {
	margin: 20px auto;
	width: 600px;
}

.table {
	width: 100%;
	border-spacing: 0;
	border-collapse: collapse;
}
table-title {
	font-size: 24px;
}
.table-content {
	margin-top: 5px;
}
.table-content tr {
	border-bottom: 1px solid #ccc;
	height: 35px;
}
.table-content tr:first-child {
	border-top: 2px solid #ccc;
}
.table-content tr:last-child {
	border-bottom: none;
}
.table-content tr > td {
	padding: 7px 5px;
}

.table-footer {
	margin: 5px auto;
}
.table-footer tr {
	height: 40px;
}

</style>
<script type="text/javascript">
function sendOk() {
	var v = document.writerForm;
	v.action = "${pageContext.request.contextPath}/wboard/insert";
	v.submit();
}
</script>
</head>
<body>
	<div class="board">
		<div class="table table-title">
			<span>질문과 답변</span>
		</div>
		
		<table class="table table-content">
			<tr>
				<td colspan="2" align="center">
					${dto.title}
				</td>				
			</tr>
			<tr>
				<td width="50%">과목 : ${dto.subject}</td>
				<td width="50%" align="right">등록일 : ${dto.reg_date}</td>
			</tr>
			<tr>
				<td width="50%">작성자 : ${dto.name}</td>
				<td width="50%" align="right">조회수 : ${dto.hitCount}</td>
			</tr>
			<tr>
				<td colspan="2" height="150" valign="top">
					${dto.content}
				</td>
			</tr>
			<tr>
				<td colspan="2"> 
					이전글 :
					<c:if test="${not empty preReadBoard}">
						<a href="${pageContext.request.contextPath}/wboard/article?boardNum=${preReadBoard.bNum}&${query}">${preReadBoard.title}</a>
					</c:if>
				</td>
			</tr>
			<tr>
				<td colspan="2"> 
					다음글 :
					<c:if test="${not empty nextReadBoard}">
						<a href="${pageContext.request.contextPath}/wboard/article?boardNum=${nextReadBoard.bNum}&${query}">${nextReadBoard.title}</a>
					</c:if>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					${dto.ipAddr}
				</td>
			</tr>
		</table>
		
		<table class="table table-footer">
			<tr>
				<td width="50%">
					<button type="button" onclick="location.href='${pageContext.request.contextPath}/wboard/reply?bNum=${dto.bNum}&page=${page}';">답변</button>
					<button type="button" onclick="location.href='${pageContext.request.contextPath}/wboard/pwd?bNum=${dto.bNum}&page=${page}&mode=update';">수정</button>
					<button type="button" onclick="location.href='${pageContext.request.contextPath}/wboard/pwd?bNum=${dto.bNum}&page=${page}&mode=delete';">삭제</button>
				</td>
				<td align="right">
					<button type="button" onclick="location.href='${pageContext.request.contextPath}/wboard/list?${query}';">리스트</button>
				</td>
			</tr>
		</table>
		
	</div>

</body>
</html>
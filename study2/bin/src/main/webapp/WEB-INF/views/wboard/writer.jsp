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
.layout {
	width: 600px;
	margin: 30px auto;
}
table {
	width: 100%;
	border-spacing: 0;
	border-collapse: collapse;
}

.title span {
	font-size: 24px;
	font-weight: 700;
}
.table-body {
	margin: 30px auto 10px;
}

.table-body tr {
	height: 35px;
	border-bottom: 1px solid #ccc;
}
.table-body tr:first-child {
	border-top: 2px solid #ccc;
}
.table-body tr:last-child {
	border-bottom: 2px solid #ccc;
}
.table-body tr:nth-child(4) {
	height: 300px;
}
.table-body tr:nth-child(4) td:last-child {
	padding-top: 5px;
}

.table-body td:first-child {
	background: #eee;
	width: 100px;
}
.table-body td:last-child {
	padding-left: 5px;
}

.table-body input {
	width: 480px;
}
.table-body textarea {
	width: 480px;
	height: 280px;
}
.table-body input[name=pwd] {
	width: 200px;
}
.table-body select {
	width: 200px;
}
</style>

<script type="text/javascript">
function sendOk() {
	let f = document.writeForm;
	f.action = "${pageContext.request.contextPath}/wboard/${mode}";
	f.submit();
}
</script>

</head>
<body>
<div class="layout">
	<table class="title">
		<tr>
			<td>
				<span>질문과 답변</span>
			</td>
		</tr>
	</table>
	
	<form name="writeForm" method="post">
		<table class="table table-body">
			<tr>
				<td align="center">과&nbsp;&nbsp;목</td>
				<td>
					<select name="cn" class="selectField" ${mode=='reply'?"disabled='disabled'":""}>
						<c:forEach var="vo" items="${clist}">
							<option value="${vo.cNum}" ${vo.cNum==dto.cNum? "selected='selected'":"" }>${vo.subject}</option>				
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td align="center">제&nbsp;&nbsp;목</td>
				<td>
					<input type="text" name="title" class="boxTF" value="${dto.title}">
				</td>
			</tr>
			<tr>
				<td align="center">작성자</td>
				<td>
					<input type="text" name="name" class="boxTF" value="${dto.name}">
				</td>
			</tr>
			<tr>
				<td align="center">내&nbsp;&nbsp;용</td>
				<td valign="top">
					<textarea class="boxTA" name="content">${dto.content}</textarea>
				</td>
			</tr>
			<tr>
				<td align="center">패스워드</td>
				<td>
					<input type="password" name="pwd" class="boxTF" >
				</td>
			</tr>
		</table>
		
		<table class="table table-footer">
			<tr>
				<td align="center">
					<button type="button" class="btn" onclick="sendOk();">${mode=='update'? "수정완료" : "등록완료" }</button>
					<button type="reset" class="btn">다시입력</button>
					<button type="button" class="btn" onclick="location.href='${pageContext.request.contextPath}/wboard/list';">${mode=='update'? "수정취소" : "등록취소" }</button>
					<c:if test="${mode=='update'}">
						<input type="hidden" name="page" value="${page}">
						<input type="hidden" name="bNum" value="${dto.bNum}">
					</c:if>
					
					<c:if test="${mode=='reply'}">
						<input type="hidden" name="page" value="${page}">
						<input type="hidden" name="groupNum" value="${dto.groupNum}">
						<input type="hidden" name="orderNum" value="${dto.orderNum}">
						<input type="hidden" name="depth" value="${dto.depth}">
						<input type="hidden" name="parent" value="${dto.bNum}">
						
						<input type="hidden" name="cNum" value="${dto.cNum}">
					</c:if>
				</td>
			</tr>
		</table>
	</form>
</div>


</body>
</html>
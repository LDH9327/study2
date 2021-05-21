<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style type="text/css">
*{
	margin: 0; padding: 0;
	font-size: 14px;
	font-family: 맑은 고딕, 돋움;
}

.board{
	margin: 50px auto;
	width: 300px;
}

.board-title h3 {
	font-size: 15px;
	font-weight: 700;
}

.table {
	width: 100%;
	border-collapse: collapse;
	border-spacing: 0;
}

.table-content tr {
	height: 40px;
	text-align: center;
}
</style>

<title>고객센터</title>
</head>
<body>

<div class="board">
	<form action="${pageContext.request.contextPath}/wboard/pwd" method="post">
		<table class="table table-content">
			<tr>
				<td style="font-weight: 700;">게시물 ${mode=="update"? "수정" : "삭제" }</td>
			</tr>
			<tr>
				<td>
					<input type="password" name="pwd" placeholder="패스워드">
				</td>
			</tr>
			<tr>
				<td>
					<input type="hidden" name="bNum" value="${bNum}">
					<input type="hidden" name="mode" value="${mode}">
					<input type="hidden" name="page" value="${page}">
					<button type="submit"> 확인 </button>
				</td>
			</tr>
			<tr>
				<td>
					<p>${msg}</p>
				</td>
			</tr>
		</table>
	</form>
</div>


</body>
</html>
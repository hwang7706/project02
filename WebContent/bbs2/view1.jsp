<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/include/header.jsp"%>
<%
	String uid = request.getParameter("uid");
%>
<style>
td img {
	width: 300px;
	height: 300px;
}
</style>
<script>
	function like_do(uid){
		location.href = "/like.do?uid="+uid;
	}
</script>

<body>
	<div class="container" align="center">
		<div class="row">
			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">
				<c:forEach var="list" items="${v}">

					<thead>
						<tr>
							<th colspan="2"
								style="background-color: #eeeeee; text-align: center; font-size: 20px;">subject:
								${list.subject}</th>
						</tr>
						<tr>
							<th colspan="2"
								style="background-color: #eeeeee; text-align: center; font-size: 18px;">${list.date}</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="width: 600px; height: 350px;">${list.content}</td>
						</tr>
					</tbody>
					<tbody>
						<tr>
							<td>이름: ${list.subject}</td>
						</tr>
						<tr>
							<td><img src="/upload/${list.file1}"></td>
						</tr>

						<c:set var="session_id" value="<%=session_id %>"/>
						<c:if test="${list.id == session_id}">
							<form action="/bbs2/adoptcancel.do?uid=<%=uid%>" method="post">
								<input type="submit" value="입양취소">
							</form>
						</c:if>
						<c:if test="${session_id == 'admin'}">
						<form action="/bbs2/listdelete.do?uid=<%=uid%>" method="post">
								<input type="submit" value="게시물삭제">
							</form>
						</c:if>
						<input type="button" onclick="like_do(<%=uid %>)" value="좋아요">
						<h2>좋아요!!:${likes }</h2>
					</tbody>
				</c:forEach>
			</table>
			<div style="border: 1px solid; width: 600px; padding: 5px;">
				<form name="form1" action="/bbs2/comment2.do?uid=<%=uid%>"
					method="post">
					<input type="hidden" name="benum" value="uid" /> 작성자:<input
						name="rewriter" size="20" maxlength="20" value="<%=session_id%>"
						readonly><br />
					<textarea name="rememo" rows="3" cols="60" maxlength="500"
						placeholder="댓글을 달아주세요."></textarea>
					<input type="submit" value="글쓰기">
				</form>
				<script src="js/reply_list.js"></script>
				<c:set var="uid" value="<%=uid%>" />
				<c:forEach var="re" items="${v2}">
        		작성자:${re.rewriter}<br>
					<div id="reply<c:out value="${re.reno}"/>">${re.rememo}</div>
					<c:if test="${re.reorder == '65'}">
						<div>
							<form action="/reply.do" method="post">
								<input id="comment_reply" name="rememo"> <input
									type="submit" value="답글"> <input type="hidden"
									name="borderuid" value="<%=uid%>"> <input type="hidden"
									name="reno" value="${re.reno }"> <input type="hidden"
									name="fid" value="${re.reparent }">
							</form>
						</div>
					</c:if>
        		${re.redate}
        		<a
						href="/bbs2/deleteComment2.do?reno=${re.reno}&uid=<%=uid %>"
						style="cursor: pointer;">삭제</a>
					<a href="/bbs2/view2.do?uid=<%=uid %>"
						onclick="fn_replyUpdate(${re.reno})">수정</a>
					<br>
				</c:forEach>
				<form action="/bbs2/ReplySave.do" name="form2" method="post">
					<input type="hidden" name=""> <input type="hidden" name="">
				</form>

			</div>
		</div>
	</div>
</body>
</html>
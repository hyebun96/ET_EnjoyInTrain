<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<style type="text/css">
.homepage #main {
	margin-top: 0em;
	padding-top: 0em;
}

.ui-widget-header {
	background: none;
	border: none;
	height: 35px;
	line-height: 35px;
	border-bottom: 1px solid #cccccc;
	border-radius: 0px;
}

.alert-info {
	border: 1px solid #9acfea;
	border-radius: 4px;
	background-color: #d9edf7;
	color: #31708f;
	padding: 15px;
	margin-top: 10px;
	margin-bottom: 20px;
}

.btn {
	width: 100px;
	height: 30px;
	background-color: white;
	border-color: #cccccc;
	border-radius: 10px;
	margin: 20px 10px;
}

table td {
	padding-top: 6px;
}

.title {
	text-align: center;
}

a {
	color: black;
}
.aTag:hover {
	color: #21373F;
	font-weight: bold;
}
</style>


<div style="width: 100%;">

	<table
		style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">

		<tr height="35" 
			style="border-top: 1px solid #cccccc; background: #8BD1BD; border-bottom: 1px solid #cccccc; color: white; font-weight: bold;">
			<td colspan="2" align="left" style="padding-left: 5px;"><i
				class="fas fa-question-circle"></i>&nbsp;질문 : ${dto.qnaTitle}</td>
		</tr>

		<tr height="35" style="border-bottom: 1px solid #cccccc;">
			<td colspan="2" align="left" style="padding-left: 5px;">분류 :
				${dto.category}</td>
		</tr>

		<tr height="35" style="border-bottom: 1px solid #cccccc;">
			<td width="50%" align="left" style="padding-left: 5px;">이름 :
				${dto.crewName}</td>
			<td width="50%" align="right" style="padding-right: 5px;">
				${dto.qnaCreated} | 조회 ${dto.qnaHitCount}</td>
		</tr>

		<tr
			style="border-bottom: 1px solid #cccccc; background: #21373F; color: white; font-weight: bold;">
			<td colspan="2" align="left" style="padding-left: 5px;"><i
				class="fas fa-subway"></i>&nbsp;${dto.qnaContent!=null? "답변" : "답변이 준비중입니다." }</td>
		</tr>

		<c:if test="${dto.qnaContent != null}">
		<tr style="border-bottom: 1px solid #cccccc; height: 300px;">
			<td align="left" colspan="2" style="padding: 10px 5px;" valign="top"
				height="200"><c:if test="${dto.qnaContent != null }">
					<br>
					<br> ${dto.qnaContent}
			</c:if></td>
		</tr>
		</c:if>

		<tr height="35" style="border-bottom: 1px solid #cccccc;">
			<td colspan="2" style="width: 100%;"><c:if
					test="${not empty preReadDto}">
					<a href="javascript:articleQnA('${preReadDto.qnaNum}', '${preReadDto.qnaSecret}', '${preReadDto.crewId}');" class="aTag">
						＜＜이전_${preReadDto.qnaTitle}</a>
				</c:if> <c:if test="${not empty nextReadDto}">
					<a href="javascript:articleQnA('${nextReadDto.qnaNum}', '${nextReadDto.qnaSecret}', '${nextReadDto.crewId}');"
						style="float: right;" class="aTag">${nextReadDto.qnaTitle}＿다음 ＞＞</a>
				</c:if></td>
		</tr>

	</table>

	<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
		<tr height="45">
			<td width="400px" align="left">

				<c:if test="${sessionScope.crew.crewId==dto.crewId}">
					<button type="button" class="btn" onclick="updateForm('${dto.qnaNum}');">질문수정하기</button>
				</c:if> 
				<c:if
					test="${sessionScope.crew.crewId==dto.crewId}">
					<button type="button" class="btn" onclick="deleteQnA('${dto.qnaNum}');">삭제</button>
				</c:if>
			</td>

			<td align="right">
				<button type="button" class="btn" onclick="list('${group}');">리스트</button>
			</td>
		</tr>
	</table>

</div>


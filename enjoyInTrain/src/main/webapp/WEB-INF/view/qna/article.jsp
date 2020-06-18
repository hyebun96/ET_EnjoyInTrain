<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style type="text/css">
.homepage #main{
   margin-top: 0em;
    padding-top: 0em;
}   

.ui-widget-header {
	background: none;
	border: none;
	height:35px;
	line-height:35px;
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



.btn{
	width: 100px; 
	height: 30px; 
	background-color: white; 
	border-color: #cccccc;
	border-radius: 10px;
	margin: 20px 10px;
}

table td{
	padding-top: 6px;
}

.title{
	text-align: center;

}
</style>


				<div  style=" width: 750px;">
								
					<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
						
							<tr height="35" style="border-top: 1px solid #cccccc;  border-bottom: 1px solid #cccccc;">
								 <td colspan="2" align="left" style="padding-left: 5px;">
								  질문 : ${dto.qnaTitle}
								 </td>
							</tr>
							
							<tr height="35" style="border-bottom: 1px solid #cccccc;">
							    <td colspan="2" align="left" style="padding-left: 5px;">
								   분류 : ${dto.category}
							    </td>
							</tr>
							
							<tr height="35" style="border-bottom: 1px solid #cccccc;">
							    <td width="50%" align="left" style="padding-left: 5px;">
							       이름 : ${dto.crewName}
							    </td>
							    <td width="50%" align="right" style="padding-right: 5px;">
							        ${dto.qnaCreated} | 조회 ${dto.qnaHitCount}
							    </td>
							</tr>
							
							<c:if test="${dto.qnaContent != null }">
								<tr style="border-bottom: 1px solid #cccccc;">
								  <td align="left" style="width:90%; padding: 10px 5px;" valign="top" height="200">
								     <i class="fas fa-subway"></i>&nbsp;답변   <br><br> ${dto.qnaContent}
								   </td>
								</tr>
							</c:if>
							
							<tr height="35" style="border-bottom: 1px solid #cccccc;">
							    <td colspan="2" align="left" style="padding-left: 5px;">
							       이전글 :
							         <c:if test="${not empty preReadDto}">
							              <a href="javascript:articleQnA('${preReadDto.qnaNum}', '${preReadDto.qnaSecret}', '${dto.crewId}');">${preReadDto.qnaTitle}</a>
							        </c:if>
							    </td>
							</tr>
							
							<tr height="35" style="border-bottom: 1px solid #cccccc;">
							    <td colspan="2" align="left" style="padding-left: 5px;">
							       다음글 :
							         <c:if test="${not empty nextReadDto}">
							              <a href="javascript:articleQnA('${nextReadDto.qnaNum}', '${nextReadDto.qnaSecret}', '${dto.crewId}');">${nextReadDto.qnaTitle}</a>
							        </c:if>
							    </td>
							</tr>
							</table>
							
							<table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
							<tr height="45">
							    <td width="400px" align="left">
							    	<c:if test="${sessionScope.crew.crewId=='a'}">
						          		<button type="button" class="btn" onclick="updateForm('${dto.qnaNum}');" >답변달기</button>
						         	</c:if>
						         	<c:if test="${sessionScope.crew.crewId==dto.crewId}">
						          		<button type="button" class="btn" onclick="updateForm('${dto.qnaNum}');" >질문수정하기</button>
						         	</c:if>
						         	<c:if test="${sessionScope.crew.crewId==dto.crewId || sessionScope.crew.crewId=='a'}">
						          		<button type="button" class="btn" onclick="deleteQnA('${dto.qnaNum}');" >삭제</button>
						          	</c:if>
							    </td>
							
							    <td align="right">
							        <button type="button" class="btn" onclick="list(${group});">리스트</button>
							    </td>
							</tr>
							</table>
							
				</div>
							

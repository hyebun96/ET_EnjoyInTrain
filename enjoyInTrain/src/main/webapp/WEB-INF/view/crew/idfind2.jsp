<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>

	<tr class="idsolution">
		<td width="100" valign="top" style="text-align: right; padding-top: 5px;">
          		<label style="font-weight: 900;">아이디</label>
		
    			</td>
    			<td style="padding: 0 0 10px 15px;">
			<p style="margin-top: 1px; margin-bottom: 5px;"><input name="crewId" type="text"  
			style="width: 100%;" placeholder="${crewId}" class="idinput" onchange="crewIdCheck();"></p>
			<p class="help-block1">아이디를 성공적으로 찾았습니다.</p>
		</td>
	</tr>


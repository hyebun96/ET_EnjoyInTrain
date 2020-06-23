<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<script type="text/javascript">

$(function(){
	$(".stationBtn").click(function(){
		alert("aaaa");
		//var stationCode=$(this).val();
		//$("#station1").text()=stationCode;
		//fncClose();
		window.close();
	});
});


</script>
<c:forEach var="dto" items="${list}">
	<button class="stationBtn"  value="${dto.sCode}">${dto.sName}</button>
	<br>
</c:forEach>

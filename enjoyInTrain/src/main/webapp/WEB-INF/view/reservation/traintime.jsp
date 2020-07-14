<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<style>
table td{
	border: 1px solid #EAEAEA;
}
</style>

<script type="text/javascript">
$(function(){
	var modal = document.getElementById("myModal3");
		var span = document.getElementsByClassName("close")[1];
		modal.style.display = "block";
		
		// When the user clicks on <span> (x), close the modal
		span.onclick = function() {
		  modal.style.display = "none";
		}
		
		// When the user clicks anywhere outside of the modal, close it
		window.onclick = function(event) {
		  if (event.target == modal) {
		    modal.style.display = "none";
		  }
		}
});

</script>

<div style="text-align:center;  margin-bottom: 10px;">
    <span  style="line-height:17px; font-size:17px; color: white; font-weight: bold;">운행시간</span><span class="close">&times;</span>
    </div>
	    <div style="padding:10px; height:90%; background: white;">
		    <table style="border:1px solid #EAEAEA; text-align:center; height:250px; width: 100%;">
		    	<tr>
		    		<td>역명</td>
		    		<td>도착시각</td>
		    		<td>출발시각</td>
		    	</tr>
		    	<c:forEach items="${list}" var="dto">
			    	<tr>
			    		<td>${dto.station}</td>
			    		<td>${dto.arriveTime}</td>
			    		<td>${dto.departureTime}</td>
			    	</tr>
		    	</c:forEach>
		    </table>
	    </div>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<style>
.traintime td{
	border: 1px solid #D5D5D5;
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
		    <table class="traintime" style="border:1px solid #e1e8e76e; text-align:center; height:250px; width: 100%;">
		    	<tr>
		    		<td style="background:#e1e8e76e; padding:7px;">역명</td>
		    		<td style="background:#e1e8e76e; padding:7px;">도착시각</td>
		    		<td style="background:#e1e8e76e; padding:7px;">출발시각</td>
		    	</tr>
		    	<c:forEach items="${list}" var="dto">
			    	<tr>
			    		<td style="padding:7px;">${dto.station}</td>
			    		<td style="padding:7px;">${dto.arriveTime}</td>
			    		<td style="padding:7px;">${dto.departureTime}</td>
			    	</tr>
		    	</c:forEach>
		    </table>
	    </div>
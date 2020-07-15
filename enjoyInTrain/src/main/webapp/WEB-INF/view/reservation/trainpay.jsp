<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
<style>
.trainpay td{
	border: 1px solid #D5D5D5;
}
</style>
<script type="text/javascript">
$(function(){
	var modal = document.getElementById("myModal4");
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
		    <table class="trainpay" style="width:100%; border:1px solid #EAEAEA; text-align:center; height:200px; width: 100%;">
		    	<tr>
		    		<td style="width:15%; padding: 5px; background: #EAEAEA;">구분</td>
		    		<td style="width:17%; padding: 5px; background: #EAEAEA;">어른</td>
		    		<td style="width:17%; padding: 5px; background: #EAEAEA;">어린이</td>
		    		<td style="width:17%; padding: 5px; background: #EAEAEA;">경로</td>
		    		<td style="width:17%; padding: 5px; background: #EAEAEA;">경증장애인</td>
		    		<td style="width:17%; padding: 5px; background: #EAEAEA;">중증장애인</td>
		    	</tr>
		    	<c:forEach items="${list}" var="dto">
			    	<tr>
			    		<td style="padding: 5px;">${dto.roomGrade}</td>
			    		<td style="padding: 5px;">${dto.adult}</td>
			    		<td style="padding: 5px;">${dto.child}</td>
			    		<td style="padding: 5px;">${dto.senior}</td>
			    		<td style="padding: 5px;">${dto.disabled1}</td>
			    		<td style="padding: 5px;">${dto.disabled2}</td>
			    	</tr>
		    	</c:forEach>
		    </table>
		    <span>· 표에 표기된 운임·요금은 1명 기준이며, 추가할인이 적용될 경우 결제금액이 변경될 수 있습니다.</span><br>
		    <span>· 예상 운임·요금은 기준운임을 기준으로 계산된 금액으로 결제 시 변경될 수 있습니다.</span><br>
	    </div>
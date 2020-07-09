<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>


<style>
table{
	border: 1px solid #BDBDBD;
}
table td{
	border-right: 1px solid #BDBDBD;
}
table tr{
}
</style>

<script type="text/javascript">
</script>
	<!-- Main -->
		<div id="page" >
			<!-- Main -->
			<div id="main" class="container" style="margin-top: 0; padding-top: 0;">
				<div class="row">
					<div class="9u skel-cell-important">
						<section>
							<header>
								<h2>환불</h2>
								<span class="byline">REFUND</span>
								<div style="width: 1200px; text-align: center;">
								 	<table style="width:100%;">
								 		<tr style="height:40px; font-weight:bold; border-top: 2px solid black; background: #EAEAEA;">
								 			<td>승차일</td>
								 			<td>열차종류</td>
								 			<td>열차번호</td>
								 			<td>출발역</td>
								 			<td>도착역</td>
								 			<td>출발시간</td>
								 			<td>도착시간</td>
								 			<td>결제금액</td>
								 		</tr>
									 		<tr style="height:40px; border-bottom: 1px solid #BDBDBD">
									 			<td>7월11일</td>
									 			<td>KTX</td>
									 			<td>653</td>
									 			<td>익산</td>
									 			<td>정읍</td>
									 			<td>07:57</td>
									 			<td>08:11</td>
									 			<td>14000</td>
									 		</tr>
								 	</table>
								 	<table style="width:100%;  ">
								 		<tr style="height:40px; font-weight:bold; border-top: 2px solid black; background: #EAEAEA;">
								 			<td>열차번호</td>
								 			<td>객실등급</td>
								 			<td>좌석정보</td>
								 			<td>승객유형</td>
								 			<td>환불금액</td>
								 		</tr>
									 		<tr style="height:40px; border-bottom: 1px solid #BDBDBD">
									 			<td>505</td>
									 			<td>일반실</td>
									 			<td>2호차 9C</td>
									 			<td>어른</td>
									 			<td>7500</td>
									 		</tr>
								 	</table>
								 	<br>
								 	<button type="button" style="font-weight:bold; font-size:15px; border-radius:5px; width:200px; height:30px; background: #6f047f; color: white; border: none;">환불 최종 완료하기</button>
								 	<br>
								</div>
							</header>
						</section>
					</div>
				</div>
			</div>
			<!-- Main -->
		</div>
	<!-- /Main -->
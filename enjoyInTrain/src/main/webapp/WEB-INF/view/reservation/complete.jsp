<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<style>
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
								<div style="width:1200px; text-align:center; height:150px; line-height:150px; border: 1px solid #BDBDBD">
									<p style="font-weight:bold; font-size: 20px;"><i class="fas fa-check-circle" style=" color: #6f047f;"></i>&nbsp;승차권 발급이 완료되었습니다.</p>
								</div>
								<div style="width: 1200px; text-align: center;">
									<button onclick="javascript:location.href='<%=cp%>/main';" style="margin:20px; width:200px; font-weight:bold; font-size:15px; border-radius:5px; height:40px; background: #6f047f; color: white; border: none;">메인으로 가기</button>
								</div>
							</header>
						</section>
					</div>
					
				</div>
			</div>
			<!-- Main -->

		</div>
	<!-- /Main -->
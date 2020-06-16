<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<script type="text/javascript">
function send() {
    var f = document.lostBoardForm;

	var str = f.lostTitle.value;
    if(!str) {
        alert("제목을 입력하세요. ");
        f.title.focus();
        return false;
    }

	str = f.lostContent.value;
	if(!str || str=="<p>&nbsp;</p>") {
        alert("내용을 입력하세요. ");
        f.content.focus();
        return false;
    }

	f.action="<%=cp%>/lostBoard/${mode}";
	
	f.submit();

    return true;
}


</script>
	<!-- Banner -->
		<div id="banner">
			<div class="container">
			</div>
		</div>
	<!-- /Banner -->

	<!-- Main -->
		<div id="page">
				
			<!-- Main -->
			<div id="main" class="container">
				<div class="row">

					<div class="3u">
						<section class="sidebar">
							<header>
								<h2>Feugiat Tempus</h2>
							</header>
							<ul class="style1">
								<li><a href="#">Maecenas luctus lectus at sapien</a></li>
								<li><a href="#">Etiam rhoncus volutpat erat</a></li>
								<li><a href="#">Donec dictum metus in sapien</a></li>
								<li><a href="#">Nulla luctus eleifend purus</a></li>
								<li><a href="#">Maecenas luctus lectus at sapien</a></li>
							</ul>
						</section>
						<section class="sidebar">
							<header>
								<h2>Nulla luctus eleifend</h2>
							</header>
							<ul class="style1">
								<li><a href="#">Maecenas luctus lectus at sapien</a></li>
								<li><a href="#">Donec dictum metus in sapien</a></li>
								<li><a href="#">Integer gravida nibh quis urna</a></li>
								<li><a href="#">Etiam posuere augue sit amet nisl</a></li>
								<li><a href="#">Mauris vulputate dolor sit amet nibh</a></li>
							</ul>
						</section>
					</div>
				<form action="" name="lostBoardForm" method="post" enctype="multipart/form-data">
					<div class="9u skel-cell-important">
						<ul>
							<li style="float: left; width: 100px; clear: both;">제목</li>
							<li style="float: left; width: 100px"><input type="text" name="lostTitle" value="${dto.lostTitle}"></li>
							<li style="float: left; width: 100px; clear: both;">작성자</li>
							<li style="float: left; width: 100px">${sessionScope.crew.crewName}</li>
							<li style="float: left; width: 100px; clear: both;">내용</li>
							<li style="float: left;">
								<textarea Id="content" name="lostContent" rows="12" class="boxTA" style="width: 95%; height: 270px">${dto.lostContent}</textarea>
							</li>
							<li style="float: left; width: 100px; clear: both;">첨부파일</li>
							<li style="float: left; width: 100px"><input type="file" name="upload"></li>
						</ul>
					</div>
					<div>
						<ul>
							<li style="clear: both;">
								<button type="button" onclick="send()">${mode=='update'?'수정완료':'등록완료'}</button>
								<button type="reset">다시입력</button>
								<button type="button" onclick="javascript:location.href='<%=cp%>/lostBoard/list';">${mode=='update'?'수정취소':'등록취소'}</button>
								<c:if test="${mode=='update'}">
									<input type="hidden" name="lostNum" value="${dto.lostNum}">
									<input type="hidden" name="page" value="${page}">
									<input type="hidden" name="saveFileName" value="${dto.saveFileName}">
									<input type="hidden" name="originalFileName" value="${dto.originalFileName}">
								</c:if>
							</li>
						</ul>
					</div>
				</form>

					
				</div>
			</div>
			<!-- Main -->

		</div>
	<!-- /Main -->
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/lostboardcreated.css" type="text/css">
<style type="text/css">
.homepage #main{
   margin-top: 0em;
    padding-top: 0em;
}
</style>
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

<c:if test="${mode=='update'}">
function deleteFile(num) {
		var url="<%=cp%>/lostBoard/deleteFile";
		$.post(url, {num:num}, function(data){
			$("#f"+num).remove();
		}, "json");
}
</c:if>

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
								<h2>게시판</h2>
							</header>
							<ul class="style1">
								<li><a href="<%=cp%>/qna/main">QnA</a></li>
								<li><a href="<%=cp%>/faq/list">FAQ</a></li>
								<li><a href="<%=cp%>/notice/list">공지사항</a></li>
								<li><a href="<%=cp%>/lostBoard/list">유실물</a></li>
								<li><a href="<%=cp%>/freeBoard/list">자유게시판</a></li>
								<li><a href="<%=cp%>/suggest/list">고객의소리</a></li>
							</ul>
						</section>
					</div>
				<form action="" name="lostBoardForm" method="post" enctype="multipart/form-data">
				<div id="article_title">유실물 게시판</div>
					<div class="9u skel-cell-important">
						<ul id="article_main">
							<li id="article_question">제목</li>
							<li id="article_answer"><input type="text" name="lostTitle" value="${dto.lostTitle}"></li>
							<li id="article_question">작성자</li>
							<li id="article_answer">${sessionScope.crew.crewName}</li>
							<li id="article_content">
								<textarea id="content" name="lostContent">${dto.lostContent}</textarea>
							</li>
							<li id="article_question">첨부파일</li>
							<li id="article_file"><input type="file" name="upload"></li>
						</ul>
					</div>
					<div>
						<ul>
							<li id="article_button">
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
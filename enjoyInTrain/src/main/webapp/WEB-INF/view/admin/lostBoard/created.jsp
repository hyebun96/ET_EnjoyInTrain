<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/lostboardcreated.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/notice.css" type="text/css">
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

	f.action="<%=cp%>/admin/lostBoard/${mode}";
	
	f.submit();

    return true;
}

<c:if test="${mode=='update'}">
function deleteFile(num) {
		var url="<%=cp%>/admin/lostBoard/deleteFile";
		$.post(url, {num:num}, function(data){
			$("#f"+num).remove();
		}, "json");
}
</c:if>

</script>


	<!-- Main -->
		<div id="adminpage">
				<div class="trainandtime">
					<a href="<%=cp%>/admin/notice/list">공지사항</a> <span>|</span> <a href="<%=cp%>/admin/qna/main">QnA</a>
					<span>|</span> <a href="<%=cp%>/admin/faq/list">FAQ</a> <span>|</span> <a href="<%=cp%>/admin/lostBoard/list">유실물</a>
					<span>|</span> <a href="<%=cp%>/admin/freeBoard/list">자유게시판</a> <span>|</span> <a href="<%=cp%>/admin/suggest/list">고객의소리</a>
				</div>
			<!-- Main -->
			<div id="main" class="container">
				<div class="row">
					<div class="9u skel-cell-important">
						<header>
								<h2>유실물</h2>
								<span class="byline">Lost | Lost property
								<img src="<%=cp%>/resource/images/createdicon.png" alt="" width="40px;" style="float: right;">
								</span>
						</header>
				<form action="" name="lostBoardForm" method="post" enctype="multipart/form-data">
						
						<table class="noticearticle">
							<tr class="noticearticletitle">
								<td class="noticearticletitle1">제목  </td>
								<td style="text-align: left;" colspan="3"><input type="text" name="lostTitle" value="${dto.lostTitle}" maxlength="100" class="boxTF" style="width: 100%;"></td>
							</tr>
							<tr class="noticearticletitle">
								<td class="noticearticletitle2">작성자</td>
								<td colspan="3">${sessionScope.crew.crewName}</td>
							</tr>
							<tr id="article_content" class="noticearticletitle" style="width: 95%;">
								<td class="noticearticletitle1">내용</td>
								<td class="notice-content" colspan="3"><textarea id="content" name="lostContent">${dto.lostContent}</textarea></td>
							</tr>
							<tr class="noticearticletitle" style="border: none;">
								<td class="noticearticletitle1">첨부파일</td>
								<td colspan="3"><input type="file" name="upload"></td>
							</tr>
						</table>

					<div class="notice_createdbutton">
						<ul>
							<li>
								<button type="button" onclick="send()" class="articlebtn">${mode=='update'?'수정완료':'등록완료'}</button>
								<button type="reset" class="articlebtn">다시입력</button>
								<button type="button" onclick="javascript:location.href='<%=cp%>/admin/lostBoard/list';" class="articlebtn">${mode=='update'?'수정취소':'등록취소'}</button>
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
			</div>
			<!-- Main -->

		</div>
	<!-- /Main -->
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/notice.css" type="text/css">
<style type="text/css">
.homepage #main{
   margin-top: 0em;
    padding-top: 0em;
}
</style>

<script type="text/javascript">
  <c:if test="${mode=='update'}">
  function deleteFile(noticeFileNum) {
		var url="<%=cp%>/notice/deleteFile";
		$.post(url, {noticeFileNum:noticeFileNum}, function(data){
			$("#f"+noticeFileNum).remove();
		}, "json");
  }
</c:if>

</script>

<script type="text/javascript">
    function sendOk() {
        var f = document.noticeForm;

    	var str = f.noticeTitle.value;
        if(!str) {
            alert("제목을 입력하세요. ");
            f.noticeTitle.focus();
            return;
        }

    	str = f.noticeContent.value;
        if(!str) {
            alert("내용을 입력하세요. ");
            f.noticeContent.focus();
            return;
        }

    	f.action="<%=cp%>/notice/${mode}";

        f.submit();
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
								<font size="3px">News</font>
								<h2>Enjoy in Train</h2>
							</header>
							<ul class="style11">
								<li><a href="#">회원가입</a></li>
								<li><a href="#">QnA</a></li>
								<li><a href="#">FAQ</a></li>
								<li><a href="<%=cp%>/notice/list">공지사항</a></li>
								<li><a href="#">유실물</a></li>
								<li><a href="#">자유게시판</a></li>
								<li><a href="#">신고</a></li>
							</ul>
						</section>
						
					</div>
				
					<div class="9u skel-cell-important">
						<section>
							<header>
								<h2>공지사항</h2>
								<span class="byline">Notice | Check news of new services and events</span>
							</header>
							<div id="namul">
							
							<h3>▶ 공지사항 작성</h3>
							
					<form name="noticeForm" method="post" enctype="multipart/form-data">
					<table class="noticearticle1">
							<tr class="noticearticletitle">
								<td class="noticearticletitle1">제목  </td>
								<td colspan="3" style="text-align: left;"> <input type="text" name="noticeTitle" maxlength="100" class="boxTF" style="width: 100%;" value="${dto.noticeTitle}"> </td>
							</tr>
							<tr style="padding: 5px 5px;">
								<td class="notice-content1" colspan="4"> <textarea name="noticeContent" rows="12" class="boxTA" style="width: 100%;">${dto.noticeContent}</textarea></td>
							</tr>
							
							<tr class="articleReadDto1">
							
								<td colspan="4">
									<font style="font-weight: bold;">첨부 파일  ▶</font>
									<input type="file" name="upload" multiple="multiple" class="boxTF" size="53" style="width: 200px; height: 25px;">
								</td>
							
							
						</table>
			        </form>
					<button type="button" class="articlebtn" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}</button>
			        <button type="reset" class="articlebtn">다시입력</button>
			        <button type="button" class="articlebtn" onclick="javascript:location.href='<%=cp%>/notice/list';">${mode=='update'?'수정취소':'등록취소'}</button>
			        <c:if test="${mode=='update'}">
			         	 <input type="hidden" name="noticeNum" value="${dto.noticeNum}">
			        	 <input type="hidden" name="page" value="${page}">
			        </c:if>
			        
			        </div>
						</section>
					</div>
					
				</div>
			
			</div>
			<!-- Main -->

		</div>
	<!-- /Main -->
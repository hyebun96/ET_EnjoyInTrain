<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

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
								<h2>메뉴창1</h2>
							</header>
							<ul class="style1">
								<li><a href="<%=cp%>/notice/list">공지사항</a></li>
								<li><a href="<%=cp%>/notice/list">이벤트</a></li>

							</ul>
						</section>
						
					</div>
				
					<div class="9u skel-cell-important">
						<section>
							<header>
								<h2>공지사항</h2>
								<span class="byline">공지사항 | 신규서비스 및 다양한 소식이 업데이트 됩니다.</span>
							</header>
							<div id="namul">
					<form name="noticeForm" method="post" enctype="multipart/form-data">
							<ul>
								<li style="float: left; width: 100px;">번호</li>
								<li style="float: left; width: 100px;">제목</li>
								<li style="float: left; width: 100px;">등록일</li>
							</ul>
							<br>
							<ul>
							<li>
								제목  <input type="text" name="noticeTitle" maxlength="100" class="boxTF" style="width: 50%;" value="${dto.noticeTitle}">
							</li>
							<li>
								내용 <textarea name="noticeContent" rows="12" class="boxTA" style="width: 70%;">${dto.noticeContent}</textarea>
							</li>
							<li>
								첨부 <input type="file" name="upload" multiple="multiple" class="boxTF" size="53" style="width: 70%; height: 25px;">
							</li>
							</ul>
					<button type="button" class="btn" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}</button>
			        <button type="reset" class="btn">다시입력</button>
			        <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/notice/list';">${mode=='update'?'수정취소':'등록취소'}</button>
			        <c:if test="${mode=='update'}">
			         	 <input type="hidden" name="noticeNum" value="${dto.noticeNum}">
			        	 <input type="hidden" name="page" value="${page}">
			        </c:if>
			        </form>
			        </div>
						</section>
					</div>
					
				</div>
			
			</div>
			<!-- Main -->

		</div>
	<!-- /Main -->
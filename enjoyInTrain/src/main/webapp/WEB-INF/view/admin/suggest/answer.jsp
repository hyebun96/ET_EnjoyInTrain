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
    function sendAn() {
        var f = document.suggestForm;

    	str = f.anContent.value;
        if(!str) {
            alert("내용을 입력하세요. ");
            f.anContent.focus();
            return;
        }
    	f.action="<%=cp%>/admin/suggest/answer";
        f.submit();
    }
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
						<section>
							<header>
								<h2>고객의 소리</h2>
								<span class="byline">${mode=='created'?"글쓰기":"수정하기"}</span>
							</header>
							<div id="namul">
							
							
					<form name="suggestForm" method="post" enctype="multipart/form-data">
						<input type="hidden" name="mode" value="${mode}"> 
								<c:if test="${mode=='update'}">
									<input type="hidden" name="page" value="${page}"> 
									<input type="hidden" name="rows" value="${rows}"> 
									<input type="hidden" name="sgCode" value="${dto.sgCode}">
								</c:if>
								<c:if test="${mode=='reply'}">
									<input type="hidden" name="groupNum" value="${dto.groupNum}"> 
									<input type="hidden" name="dept" value="${dto.dept}"> 
									<input type="hidden" name="orderNo" value="${dto.orderNo}"> 
									<input type="hidden" name="parent" value="${dto.sgCode}"> 
								</c:if>
					<table class="noticearticle1">
					<tbody id="tb">
							<tr class="noticearticletitle">
								<td class="noticearticletitle1">질문제목  </td>
								<td colspan="3" style="text-align: left;"> <input readonly="readonly" type="text" name="sgTitle" maxlength="100" class="boxTF" style="width: 100%;" value="${dto.sgTitle}"> </td>
							</tr>
							<tr style="padding: 5px 5px;">
								<td>질문내용</td>
								<td class="notice-content1" colspan="4" > <p class="boxTA" style="width: 100%;">${dto.sgContent}</p></td>
							</tr>
							<tr>
								<td>답변</td>
								<td class="notice-content1" colspan="4"> <textarea name="anContent" rows="12" class="boxTA" style="width: 100%;"></textarea></td>
							</tr>
							</tbody>
						</table>
			        </form>
			        
					<button type="button" class="articlebtn" onclick="sendAn();">답변등록</button>
			        <button type="reset" class="articlebtn">다시입력</button>
			        <button type="button" class="articlebtn" onclick="javascript:location.href='<%=cp%>/admin/suggest/list';">답변취소</button>
			        </div>
						</section>
					</div>
					
				</div>
			
			</div>
			<!-- Main -->

		</div>
	<!-- /Main -->
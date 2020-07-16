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


</script>

<script type="text/javascript">
    function sendSuggest() {
        var f = document.suggestForm;

    	var str = f.sgTitle.value;
        if(!str) {
            alert("제목을 입력하세요. ");
            f.sgTitle.focus();
            return;
        }

    	str = f.sgContent.value;
        if(!str) {
            alert("내용을 입력하세요. ");
            f.sgContent.focus();
            return;
        }

    	f.action="<%=cp%>/suggest/${mode=='update'?'update?':'created'}";

        f.submit();
    }
    
    $(function(){
    	$("form input[name=upload]").change(function(){
    		
    		if(! $(this).val()) return;
    		
    		var b=false;
    		$("form input[name=upload]").each(function(){
    			if(! $(this).val()) {
    				b=true;
    				return;
    			}
    		});
    		if(b) return false;
    			
    		
    		var $tr = $(this).closest("tr").clone(true); // 이벤트도 복제
    		$tr.find("input").val("");
    		$("#tb").append($tr);
    	});
    });

  
  <c:if test="${mode=='update'}">
    function deleteFile(fileNum) {
  		var url="<%=cp%>/suggest/deleteFile";
  		$.post(url, {fileNum:fileNum}, function(data){
  			$("#f"+fileNum).remove();
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
								<h2>Customer</h2>
							</header>
							<ul class="style1">
								<li><a href="<%=cp%>/qna/main">QnA</a></li>
								<li><a href="<%=cp%>/lostBoard/list">유실물</a></li>
								<li><a href="<%=cp%>/freeBoard/list">자유게시판</a></li>
								<li><a href="<%=cp%>/suggest/list">고객의소리</a></li>
							</ul>
						</section>
					</div>
				
					<div class="9u skel-cell-important">
						<section>
							<header>
								
								<h2>고객의 소리</h2>
								<span class="byline">THANK YOU FOR YOUR VALUABLE OPINION.
								<img src="<%=cp%>/resource/images/createdicon.png" alt="" width="40px;" style="float: right;">
								</span>
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
								<td class="noticearticletitle1">제목  </td>
								<td colspan="3" style="text-align: left;"> <input type="text" name="sgTitle" maxlength="100" class="boxTF" style="width: 100%;" value="${mode=='reply'?'[re]':''}${dto.sgTitle}"> </td>
							</tr>
							<tr class="noticearticletitle">
								<td class="noticearticletitle1">분류</td>
								<td colspan="3" style="padding-left: 20px;">
												<select name="sgCategory" style="border-radius: 5px; width: 100px;">
													<option value="1">불편/불만</option>
													<option value="2">제안/건의</option>
													<option value="3">칭찬</option>
													<option value="4">기타</option>
												</select>
								</td>
							</tr>
							<tr class="noticearticletitle">
								<td class="noticearticletitle1">내용</td>
								<td class="notice-content1" colspan="3"> <textarea name="sgContent" rows="12" class="boxTA" style="width: 100%; margin-top: 10px; height: 450px;">${mode=='reply'?'':dto.sgContent}</textarea></td>
							</tr>
							
							<tr class="noticearticletitle">
			      				<td class="noticearticletitle1">첨부 파일  </td>
			      				<td style="padding-left:10px;"> 
			         				 <input type="file" name="upload" class="boxTF" size="53" style="width: 95%; height: 25px;">
			      				 </td>
			 				 </tr>
			 				 <c:if test="${mode=='update'}">
				   				<c:forEach var="vo" items="${listFile}">
								  <tr id="f${vo.fileNum}" height="40" style="border-bottom: 1px solid #cccccc;"> 
								     <td width="100" bgcolor="#eeeeee" style="text-align: center;">첨부된파일</td>
						 		     <td style="padding-left:10px;"> 
										<a href="javascript:deleteFile('${vo.fileNum}');">[삭제]</a> 
										${vo.originalFilename}
						  		     </td>
								  </tr>
							   </c:forEach>
							</c:if>
			 				 
							</tbody>
						</table>
			        </form>
			        <div class="notice_createdbutton">
						<button type="button" class="articlebtn" onclick="sendSuggest();">${mode=='update'?'수정완료':'등록하기'}</button>
			        	<button type="reset" class="articlebtn">다시입력</button>
			        	<button type="button" class="articlebtn" onclick="javascript:location.href='<%=cp%>/suggest/list';">${mode=='update'?'수정취소':'등록취소'}</button>
			        </div>
			        </div>
						</section>
					</div>
					
				</div>
			
			</div>
			<!-- Main -->

		</div>
	<!-- /Main -->
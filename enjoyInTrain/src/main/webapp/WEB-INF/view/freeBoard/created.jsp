<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<link rel="stylesheet" href="<%=cp%>/resource/css/notice.css" type="text/css">
<style>
.homepage #main{
	margin-top: 0em;
    padding-top: 0em;
}	

.menu-height1{
	width: 100%; 
	margin: 20px auto 0px; 
	border-spacing: 0px; 
	border-collapse: collapse;"
}

.menu-height1 tr{
	align:left;
	height:40; 
	border-top: 1px solid #cccccc; 
	border-bottom: 1px solid #cccccc;"
}

.menu-height1 td{
	 width:100; 
	 bgcolor:#eeeeee;
	 text-align: center; 
}
.bott-button{
	width: 100%; 
	margin: 0px auto; 
	border-spacing: 0px;"
}

.bott-button tr{
	 height:45;
}

.bott-button td{
	 align:center; 
}

.btn{
	width: 100px; 
	height: 30px; 
	background-color: white; 
	border-color: #cccccc;
	border-radius: 10px;
	margin: 20px 10px;
}

.menu-height1 .boxTF{
	background: white;
	border-color: #787878;
	border-width: 1px;
	height: 28px;
	align:center;
	width: 95%; 

}

</style>

<script type="text/javascript" src="<%=cp%>/resource/se/js/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript">
    function check() {
        var f = document.boardForm;

        var str = f.fbTitle.value;
        if(!str) {
            alert("제목을 입력하세요. ");
            f.fbTitle.focus();
            return;
        }

    	str = f.fbContent.value;
        if(!str) {
            alert("내용을 입력하세요. ");
            f.fbContent.focus();
            return;
        }

    	f.action="<%=cp%>/freeBoard/${mode}";

        f.submit();
    }
    

 <c:if test="${mode=='update'}">
  function deleteFile(fbFileNum) {
		var url="<%=cp%>/freeBoard/deleteFile";
		$.post(url, {fbFileNum:fbFileNum}, function(data){
			$("#f"+fbFileNum).remove();
		}, "json");
  }
</c:if>

</script>

<!-- Banner -->
<div id="banner">
	<div class="container"></div>
</div>
<!-- /Banner -->

<!-- Main -->
<div id="page">
		
	<!-- Main -->
	<div id="main" class="container">
		<div class="row">
			
			<!-- 사이드 바 메뉴 -->
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
			<!-- /사이드바 메뉴 -->
			
			<!-- 메인 내용 -->
			<div class="9u skel-cell-important">
				<section>
					<header>
						<h2>자유게시판</h2>
							<span class="byline" style="margin-top: 20px; font-size: 15px;">Please feel free to write.
							<img src="<%=cp%>/resource/images/createdicon.png" alt="" width="40px;" style="float: right;">
							</span>
					</header>
					
					<div>
			<form name="boardForm" method="post" enctype="multipart/form-data" onsubmit="return submitContents(this);">
			  <table class="noticearticle">
			  <tr class="noticearticletitle"> 
			      <td class="noticearticletitle1">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
			      <td style="padding:10px;"> 
			        <input type="text" name="fbTitle" maxlength="100" class="boxTF" style="width: 97%;" value="${dto.fbTitle}">
			      </td>
			  </tr>
			
			  <tr class="noticearticletitle"> 
			      <td class="noticearticletitle1">작성자</td>
			      <td style="text-align: left; padding-left: 22px"> 
			      	  ${sessionScope.crew.crewName}
			      </td>
			  </tr>
			
			  <tr class="noticearticletitle"> 
			      <td class="noticearticletitle1">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
			      <td valign="top" style="padding:5px 0px 5px 5px;"> 
			        <textarea id="content" name="fbContent" rows="12" class="boxTA" style="width: 95%; height: 470px;">${dto.fbContent}</textarea>
			      </td>
			  </tr>
			  
			  <tr class="noticearticletitle">
			      <td class="noticearticletitle1">첨&nbsp;&nbsp;&nbsp;&nbsp;부</td>
			      <td style="padding-left:10px;"> 
			          <input type="file" name="upload" multiple="multiple" class="boxTF" size="53">
			       </td>
			  </tr>
			  
			  <c:if test="${mode=='update'}">
			  	<c:forEach var="vo" items="${listFile}">
				  <tr id="f${vo.fbFileNum}" >
				      <td>첨부된파일</td>
				      <td style="padding-left:10px; ">
						 ${vo.originalFileName}
						<a href="javascript:deleteFile('${vo.fbFileNum}');"><i class="far fa-trash-alt"></i></a> 				       
				       </td>
				  </tr>
				</c:forEach>
			  </c:if>

			  </table>
			
			  
			  <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
				<tr height="45"> 
					<td align="center" >
			        <button type="submit" class="btn" onclick="check();">${mode=='update'?'수정완료':'등록하기'}</button>
			        <button type="reset" class="btn">다시입력</button>
			        <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/freeBoard/list';">${mode=='update'?'수정취소':'등록취소'}</button>
			         <c:if test="${mode=='update'}">
			         	 <input type="hidden" name="fbNum" value="${dto.fbNum}">
			         	 <input type="hidden" name="saveFileName" value="${dto.saveFileName}">
			         	 <input type="hidden" name="originalFileName" value="${dto.originalFileName}">
			        	 <input type="hidden" name="page" value="${page}">
			        </c:if>
			      </td>
			    </tr>
			  </table>
			</form>
    </div>
    			</section>
			</div>
			<!-- /메인내용 -->
			
		</div>
	</div>
	<!-- /Main -->
</div>
<!-- /Main -->
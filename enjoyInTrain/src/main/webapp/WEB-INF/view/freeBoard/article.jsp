<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/freeBoard.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/notice.css" type="text/css">
<style>
.homepage #main {
	margin-top: 0em;
	padding-top: 0em;
}

.articleReadDto1{
	width: 100px;
	font-size: 15px;
	height: 80px;
	line-height: 40px;
	font-family: "나눔 고딕";
}

a:-webkit-any-link {
    cursor: pointer;
    text-decoration: none;
    color: black;
}

.btn{
	width: 100px; 
	height: 30px; 
	background-color: white; 
	border-color: #cccccc;
	border-radius: 10px;
	margin: 20px 10px;
}

.btn1{
	width: 70px; 
	height: 30px; 
	background-color: white; 
	border-color: #cccccc;
	border-radius: 10px;
	margin: 20px 10px;
}



</style>

<script type="text/javascript">
function updateBoard(){
<c:if test ="${sessionScope.crew.crewId == dto.crewId}">
	var q = "num=${dto.fbNum}&page=${page}";
	var url = "<%=cp%>/freeBoard/update?"+q;
	location.href=url;
</c:if>

<c:if test="${sessionScope.crew.crewId!=dto.crewId}">
	alert("게시물을 수정할 수  없습니다.");
</c:if>
}

function deleteBoard() {
<c:if test="${sessionScope.crew.crewId=='a' || sessionScope.crew.crewId==dto.crewId}">
	var q = "num=${dto.fbNum}&${query}";
	var url = "<%=cp%>/freeBoard/delete?" + q;
	
	if(confirm("위 자료를 삭제 하시 겠습니까 ? ")){
		location.href=url;
	}

</c:if>

<c:if test="${sessionScope.crew.crewId != 'a' && sessionScope.crew.crewId != dto.crewId}">
	alert("게시물을 삭제할 수 없습니다.");
</c:if>

}
</script>

<script type="text/javascript">
function login() {
	location.href="<%=cp%>/crew/login";
}

function ajaxJSON(url,type,query,fn){
	$.ajax({
		type:type,
		url:url,
		data:query,
		dataType:"json",
		success:function(data){
			fn(data);
		},
		beforeSend:function(jqXHR){
			jqXHR.setRequestHeader("AJAX",true);
		},
		error:function(jqXHR){
			if(jqXHR.status==403){
				login();
				return false;
			}
			console.log(jqXHR.responseText);
		}
	});
}
function ajaxHTML(url,type,query,selector) {
	$.ajax({
		type:type,
		url:url,
		data:query,
		success:function(data){
			$(selector).html(data);
		},
		beforeSend:function(jqXHR){
			jqXHR.setRequestHeader("AJAX",true);
		},
		error:function(jqXHR){
			if(jqXHR.status==403){
				login();
				return false;
			}
			console.log(jqXHR.responseText);
		}
	});
}


//게시글 좋아요 여부
$(function() {
	$(".btnSendBoardLike").click(function(){
		if(! confirm("게시물에 공감하십니까?")){
			return false;
		}
		
		var url="<%=cp%>/freeBoard/insertBoardLike";
		var num="${dto.fbNum}";
		var query = {num:num};
		
		var fn = function(data) {
			var state = data.state;
			if(state == "true"){
				var count = data.boardLikeCount;
				$("#boardLikeCount").text(count);
			}else if(state == "false"){
				alert("좋아요는 한번만 가능합니다.");
			}
		};
		ajaxJSON(url,"post",query,fn);
	});
});


//리스트 페이징처리
$(function() {
	listPage(1);
});

function listPage(page) {
	var url = "<%=cp%>/freeBoard/listReply";
	var query = "fbNum=${dto.fbNum}&pageNo="+page;
	var selector = "#listReply";
	
	ajaxHTML(url,"get",query,selector);
}

//댓글 추가
$(function() {
	$(".btnSendReply").click(function() {
		var num = "${dto.fbNum}";
		var $tb=$(this).closest("table");
		var content = $tb.find("textarea").val().trim();
		
		if(! content){
			$tb.find("textarea").focus();
			return false;
		}
		
		content = encodeURIComponent(content);
		
		var url = "<%=cp%>/freeBoard/insertReply";
		var query = "fbNum="+num+"&content="+content+"&answer=0";
		
		var fn = function(data) {
			$tb.find("textarea").val("");
			
			var state=data.state;
			if(state=="true") {
				listPage(1);
			} else if(state=="false") {
				alert("댓글을 추가 하지 못했습니다.");
			}
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});


//댓글 삭제
$(function () {
	$("body").on("click", ".deleteReply", function () {
		if(! confirm("게시물을 삭제하시겠습니까?")){
			return false;
		}
		
		var fbReplyNum = $(this).attr("data-replyNum");
		var page=$(this).attr("data-pageNo");
		
		var url = "<%=cp%>/freeBoard/deleteReply";
		var query = "fbReplyNum="+fbReplyNum+"&mode=reply";
		
		var fn = function (data) {
			listPage(page);
			
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});

//댓글 좋아요
$(function() {
	$("body").on("click",".btnSendReplyLike",function(){
		var fbReplyNum = $(this).attr("data-replyNum");
		var replyLike = $(this).attr("data-replyLike");
		var $btn = $(this);
		
		if(! confirm("게시물에 공감하십니까?")){
			return false;
		}
		
		var url="<%=cp%>/freeBoard/insertReplyLike";
		var query="fbReplyNum="+fbReplyNum+"&replyLike="+replyLike;
		
		var fn = function(data) {
			var state=data.state;
	
			if(state=="true"){
				var likeCount = data.likeCount;
				$btn.parent("td").children().eq(0).find("span").html(likeCount);
			} else if(state =="false"){
				alert("좋아요는 한번만 가능합니다.");
			}
		};
		
		ajaxJSON(url,"post",query,fn);
	});	
});

//댓글별 답글 리스트
function listReplyAnswer(answer) {
	var url="<%=cp%>/freeBoard/listReplyAnswer";
	var query = {answer : answer};
	var selector = "#listReplyAnswer"+answer;
	
	ajaxHTML(url,"get",query,selector);
}

//댓글별 답글 개수
function countReplyAnswer(answer){
	var url = "<%=cp%>/freeBoard/countReplyAnswer";
	var query = {answer:answer};
	
	var fn = function(data) {
		var count = data.count;
		var vid = "#answerCount"+answer;
		$(vid).html(count);
	};
	ajaxJSON(url,"post",query,fn);
}

//답글버튼(댓글별 답글 등록 폼,답글 리스트)
$(function() {
	$("body").on("click",".btnReplyAnswerLayout",function(){
		
		var $trReplyAnswer = $(this).closest("tr").next();
		// var $trReplyAnswer = $(this).parent().parent().next();
		// var $answerList = $trReplyAnswer.children().children().eq(0);
		
		var isVisible=$trReplyAnswer.is(':visible');
		var fbReplyNum = $(this).attr("data-replyNum");
		
		if(isVisible){
			$trReplyAnswer.hide();
		} else{
			$trReplyAnswer.show();
			
			//답글리스트
			listReplyAnswer(fbReplyNum);
			
			//답글 개수
			countReplyAnswer(fbReplyNum);
		}
	});
});

//댓글별 답글 등록
$(function () {
	$("body").on("click", ".btnSendReplyAnswer", function () {
		var fbNum = "${dto.fbNum}";
		var fbReplyNum = $(this).attr("data-replyNum");
		var $td = $(this).closest("td");
		var content = $td.find("textarea").val().trim();
		if(!content){
			$td.find("textarea").focus();
			return false;
		}
		
		cotent = encodeURIComponent(content);
		
		var url = "<%=cp%>/freeBoard/insertReply";
	
		var query = "fbNum="+fbNum+"&content="+content+"&answer="+fbReplyNum;
		
		var fn = function (data) {
			$td.find("textarea").val("");
			
			var state = data.state;
			if(state=="true"){
				listReplyAnswer(fbReplyNum);
				countReplyAnswer(fbReplyNum);
			}
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});

//댓글별 답글 삭제
$(function () {
	$("body").on("click", ".deleteReplyAnswer", function () {
		if(!confirm("게시물을 삭제하시겠습니까 ? ")){
			return;
		}
		var fbReplyNum = $(this).attr("data-replyNum");
		var answer = $(this).attr("data-answer");
		
		var url = "<%=cp%>/freeBoard/deleteReply";
		var query = "fbReplyNum="+fbReplyNum+"&mode=answer";
		
		var fn = function (data) {
			listReplyAnswer(answer);
			countReplyAnswer(answer);
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});

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
						<span class="byline">Free | PlEASE FEEL FREE TO WRITE.</span>
					</header>

					<div>
						<table class="noticearticle">
							
							<tr class="noticearticletitle">
								<td style="text-align: center; background: #21373F; color: white; font-weight: bold;" colspan="4">${dto.fbTitle}</td>
								
							</tr>

							<tr class="noticearticletitle">
								<td style="text-align: left;" colspan="2"> 작성자 : ${dto.crewName}</td>
								<td style="text-align: right;" colspan="2">${dto.fbCreated} | 조회 : ${dto.fbHitCount}</td>
							</tr>

							<tr>
								<td colspan="4" align="left" style="padding: 10px 5px;"
									valign="top" height="200"><div class="content_scroll">${dto.fbContent}</div></td>
							</tr>

							<tr style="border-bottom: 1px solid #cccccc;">
								<td colspan="4" height="40" style="padding-bottom: 15px;"
									align="center">
									<button style="width: 50px;" type="button" class="btn btnSendBoardLike" title="좋아요">
										<i class="far fa-hand-point-up"></i>&nbsp;&nbsp;<span
											id="boardLikeCount">${dto.fbLikeCount}</span>
									</button>
								</td>
							</tr>

							<c:forEach var="vo" items="${listFile}">
							<tr height="35" style="border-bottom: 1px solid #cccccc;">
								<td colspan="4" align="left" style="padding-left: 5px;">
									첨&nbsp;&nbsp;부 : 『
									<a href="<%=cp%>/freeBoard/download?fbFileNum=${vo.fbFileNum}">${vo.originalFileName}</a>
									(<fmt:formatNumber value="${vo.fileSize/1024}" pattern="0.00"/>kByte)
									 』	
								</td>
							</tr>
							</c:forEach>

							<tr>
								<td colspan="2" style="text-align: left;" class="articleReadDto">
									<c:if test="${not empty preReadDto}">
										<a href="<%=cp%>/freeBoard/article?${query}&num=${preReadDto.fbNum}"> ＜＜이전 글 보기  ＿ ${preReadDto.fbTitle}</a>
									</c:if>
								</td>

								<td colspan="2" style="text-align: right;" class="articleReadDto">
									<c:if test="${not empty nextReadDto}">
										<a href="<%=cp%>/freeBoard/article?${query}&num=${nextReadDto.fbNum}">${nextReadDto.fbTitle} ＿  다음 글 보기 ＞＞ </a>
									</c:if>
							
								</td>
							</tr>
							
							
						</table>
								<br>
								<br>
						<table
							style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
							<tr height="45">
								<td width="300" align="left">
									<c:if
										test="${sessionScope.crew.crewId==dto.crewId}">
										<button type="button" class="btn1" onclick="updateBoard();">수정</button>
									</c:if> 
									
									<c:if
										test="${sessionScope.crew.crewId==dto.crewId || sessionScope.crew.crewId=='a'}">
										<button type="button" class="btn1" onclick="deleteBoard();">삭제</button>
									</c:if>
								</td>

								<td align="right">
									<button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/freeBoard/list?${query}';">리스트</button>
								</td>
							</tr>
						</table>
					</div>

					<div class="content_scroll">
						<table
							style='width: 100%; margin: 15px auto 0px; border-spacing: 0px;'>
							<tr height='30'>
								<td align='left'><span style='font-weight: bold;'>댓글쓰기</span><span>
										- 타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가 주세요.</span></td>
							</tr>
							<tr>
								<td style='padding: 5px 5px 0px;'>
								<textarea class='boxTA' style='width: 99%; height: 70px;'></textarea></td>
							</tr>
							<tr>
								<td align='right'>
									<button type='button' class='btn btnSendReply' style=' width: 110px;'>댓글 등록</button>
								</td>
							</tr>
						</table>
					</div>
						<div id="listReply"></div>
				</section>
			</div>
			<!-- /메인내용 -->

		</div>
	</div>
	<!-- /Main -->

</div>
<!-- /Main -->
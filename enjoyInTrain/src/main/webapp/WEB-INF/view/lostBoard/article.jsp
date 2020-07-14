<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="<%=cp%>/resource/css/lostboardarticle.css" type="text/css">
<link rel="stylesheet" href="<%=cp%>/resource/css/notice.css" type="text/css">
<style type="text/css">
.homepage #main{
   margin-top: 0em;
    padding-top: 0em;
}
</style>
<script type="text/javascript">
function deleteLostBoard() {
	<c:if test="${sessionScope.crew.crewId=='admin' || sessionScope.crew.crewId==dto.crewId}">
		var q = "lostNum=${dto.lostNum}&${query}";
		var url = "<%=cp%>/lostBoard/delete?"+q;
		
		if(confirm("위 자료를 삭제 하시겠습니까?")){
			location.href=url;
		}
	</c:if>
	<c:if test="${sessionScope.crew.crewId!='admin' && sessionScope.crew.crewId!=dto.crewId}">
	alert("게시물을 삭제할 수  없습니다.");
</c:if>
}	

function updateLostBoard() {
	<c:if test="${sessionScope.crew.crewId==dto.crewId}">
		var q = "lostNum=${dto.lostNum}&page=${page}";
		var url = "<%=cp%>/lostBoard/update?"+q;
		
		location.href = url;
	</c:if>
	
	<c:if test="${sessionScope.crew.crewId!=dto.crewId}">
		alert("게시물을 수정할 수  없습니다.");
	</c:if>
}
</script>
<script type="text/javascript">
function ajaxJSON(url, type, query, fn) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,dataType:"json"
		,success:function(data) {
			fn(data);
		}
		,beforeSend:function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		login();
	    		return false;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}

function ajaxHTML(url, type, query, selector) {
	$.ajax({
		type:type
		,url:url
		,data:query
		,success:function(data) {
			$(selector).html(data);
		}
		,beforeSend:function(jqXHR) {
	        jqXHR.setRequestHeader("AJAX", true);
	    }
	    ,error:function(jqXHR) {
	    	if(jqXHR.status==403) {
	    		login();
	    		return false;
	    	}
	    	console.log(jqXHR.responseText);
	    }
	});
}

// 페이징 처리
$(function(){
	listPage(1);
});

function listPage(page) {
	var url = "<%=cp%>/lostBoard/listReply";
	var query = "lostNum=${dto.lostNum}&pageNo="+page;
	var selector = "#listReply";
	
	ajaxHTML(url, "get", query, selector);
}

// 리플 등록
$(function () {
	$(".btnSendReply").click(function () {
		var lostNum = "${dto.lostNum}";
		var $tb = $(this).closest("table");
		var content=$tb.find("textarea").val().trim();
		if(!content){
			$tb.find("textarea").focus();
			return false;
		}
		
		cotent = encodeURIComponent(content);
		
		var url ="<%=cp%>/lostBoard/insertReply";
		var query = "lostNum="+lostNum+"&content="+content+"&answer=0";
		
		var fn = function (data) {
			$tb.find("textarea").val("");
			
			var state = data.state;
			if(state=="true"){
				listPage(1);
			} else if(state=="false"){
				alert("댓글을 추가하지 못했습니다.");
			}
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});

$(function () {
	$("body").on("click", ".deleteReply", function () {
		if(!confirm("게시물을 삭제하시겠습니까?")){
			return false;
		}
		
		var lostReplyNum = $(this).attr("data-replyNum");
		var page=$(this).attr("data-pageNo");
		
		var url = "<%=cp%>/lostBoard/deleteReply";
		var query = "lostReplyNum="+lostReplyNum+"&mode=reply";
		
		var fn = function (data) {
			listPage(page);
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});

// 댓글별 답글 리스트
function listReplyAnswer(answer) {
	var url = "<%=cp%>/lostBoard/listReplyAnswer";
	var query = {answer:answer};
	var selector = "#listReplyAnswer"+answer;
	
	ajaxHTML(url, "get", query, selector);
}

// 댓글별 답글 개수
function countReplyAnswer(answer) {
	var url = "<%=cp%>/lostBoard/countReplyAnswer";
	var query = {answer:answer};
	
	var fn = function (data) {
		var count = data.count;
		var vid = "#answerCount"+answer;
		$(vid).html(count);
	};
	
	ajaxJSON(url, "post", query, fn);
}

// 답글 버튼
$(function () {
	$("body").on("click", ".btnReplyAnswerLayout", function () {
		var $trReplyAnswer = $(this).closest("tr").next();
		
		var isVisible = $trReplyAnswer.is(':visible');
		var lostReplyNum = $(this).attr("data-replyNum");
		
		if(isVisible){
			$trReplyAnswer.hide();
		} else {
			$trReplyAnswer.show();
			
			listReplyAnswer(lostReplyNum);
			
			countReplyAnswer(lostReplyNum);
		}
	});
});

// 댓글별 답글 등록
$(function () {
	$("body").on("click", ".btnSendReplyAnswer", function () {
		var lostNum = "${dto.lostNum}";
		var lostReplyNum = $(this).attr("data-replyNum");
		var $td = $(this).closest("td");
		var content = $td.find("textarea").val().trim();
		if(!content){
			$td.find("textarea").focus();
			return false;
		}
		
		cotent = encodeURIComponent(content);
		
		var url = "<%=cp%>/lostBoard/insertReply";
		var query = "lostNum="+lostNum+"&content="+content+"&answer="+lostReplyNum;
		
		var fn = function (data) {
			$td.find("textarea").val("");
			
			var state = data.state;
			if(state=="true"){
				listReplyAnswer(lostReplyNum);
				countReplyAnswer(lostReplyNum);
			}
		};
		
		ajaxJSON(url, "post", query, fn);
	});
});

// 댓글별 답글 삭제
$(function () {
	$("body").on("click", ".deleteReplyAnswer", function () {
		if(!confirm("게시물을 삭제하시겠습니까 ? ")){
			return;
		}
		var lostReplyNum = $(this).attr("data-replyNum");
		var answer = $(this).attr("data-answer");
		
		var url = "<%=cp%>/lostBoard/deleteReply";
		var query = "lostReplyNum="+lostReplyNum+"&mode=answer";
		
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
								<h2>유실물</h2>
								<span class="byline">Lost | Lost property</span>
							</header>
							<div id="namul">
					<form action="" name="lostBoardForm" method="post" enctype="multipart/form-data">
						<table class="noticearticle">
							<tr class="noticearticletitle">
								<td style="text-align: center; background: #21373F; color: white; font-weight: bold;" colspan="4"> ${dto.lostTitle} </td>
							</tr>
							<tr class="noticearticletitle">
								<td style="text-align: left;" colspan="2"> 작성자 : ${dto.crewName}</td>
								<td colspan="2" style="text-align: right;">${dto.lostCreated} | 조회 : ${dto.lostHitCount}</td>
								
							</tr>
							<tr style="padding: 5px 5px;">
								<td class="notice-content" colspan="2"><div class="content_scroll">${dto.lostContent}</div></td>
								<td class="notice-content" colspan="2">
									<c:if test="${dto.saveFileName!=null}">
										<img src="<%=cp%>/uploads/lostBoard/${dto.saveFileName}" style="width: 400px; height: 500px;">
									</c:if>
								</td>
							</tr>
							
							<tr>
								<td colspan="2" style="text-align: left;" class="articleReadDto">
								
								<c:if test="${not empty preReadDto}">
			           		   		<a href="<%=cp%>/lostBoard/article?${query}&lostNum=${preReadDto.lostNum}">＜＜ 이전글 &nbsp;＿${preReadDto.lostTitle}</a>
			       			 	</c:if>
			       			 	</td>
			       			 	
			       			 	<td colspan="2" style="text-align: right;"  class="articleReadDto">
				        			<c:if test="${not empty nextReadDto}">
				             			 <a href="<%=cp%>/lostBoard/article?${query}&lostNum=${nextReadDto.lostNum}">${nextReadDto.lostTitle}＿&nbsp;다음글 ＞＞</a>
				        			</c:if>
								</td>
							</tr>
							<tr>
								<td colspan="4">
								<c:if test="${sessionScope.crew.crewId==dto.crewId}">
									<button type="button" onclick="updateLostBoard();" class="articlebtn" style="float: right;">수정하기</button>
									<button type="button" onclick="deleteLostBoard();" class="articlebtn" style="float: right;">삭제하기</button>
								</c:if>
									<button type="button" onclick="javascript:location.href='<%=cp%>/lostBoard/list';" class="articlebtn" style="float: right;">목록으로</button>
								</td>
							</tr>   
						</table>
			        </form>
					
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
									<button type='button' class='btnSendReply' style=' width: 110px;'>댓글 등록</button>
								</td>
							</tr>
						</table>
						<div id="listReply"></div>
					
			        </div>
						</section>
					</div>
					
				</div>
			
			</div>
			<!-- Main -->

		</div>
	<!-- /Main -->
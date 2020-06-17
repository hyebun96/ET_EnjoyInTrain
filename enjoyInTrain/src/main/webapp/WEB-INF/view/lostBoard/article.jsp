<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

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
		var $tb = $(this).closest("ul");
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
		var $trReplyAnswer = $(this).closest("ul").next();
		
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
		var $td = $(this).closest("ul");
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
							<li style="float: left; width: 100px">${dto.lostTitle}</li>
							<li style="float: left; width: 100px; clear: both;">작성자</li>
							<li style="float: left; width: 100px">${dto.crewId}</li>
							<li style="float: left; width: 100px; clear: both;">${dto.lostCreated} | 조회 ${dto.lostHitCount}</li>
							<li style="float: left; width: 100px; clear: both;">내용</li>
							<li style="float: left;">
								${dto.lostContent}
								<c:if test="${dto.saveFileName!=null}">
									<img src="<%=cp%>/uploads/lostBoard/${dto.saveFileName}">
								</c:if>
							</li>
				
							
						</ul>
						<ul>
							<li>
								이전글 : 
									<c:if test="${not empty preReadDto}">
										<a href="<%=cp%>/lostBoard/article?${query}&lostNum=${preReadDto.lostNum}">${preReadDto.lostTitle}</a>
									</c:if>
							</li>
							<li>
								다음글 : 
									<c:if test="${not empty nextReadDto}">
										<a href="<%=cp%>/lostBoard/article?${query}&lostNum=${nextReadDto.lostNum}">${nextReadDto.lostTitle}</a>
									</c:if>
							</li>
						</ul>
					</div>
					<div>
						<ul>
							<li style="clear: both;">
								<button type="button" onclick="javascript:location.href='<%=cp%>/lostBoard/created';">글쓰기</button>
								<button type="button" onclick="javascript:location.href='<%=cp%>/lostBoard/list';">목록으로</button>
								<c:if test="${sessionScope.crew.crewId=='admin' || sessionScope.crew.crewId==dto.crewId}">
									<button type="button" onclick="updateLostBoard();">수정하기</button>
									<button type="button" onclick="deleteLostBoard();">삭제하기</button>
								</c:if>
							</li>
						</ul>
					</div>
				</form>
					<div>
						<ul>
							 <li>
							 	<span style='font-weight: bold;' >댓글쓰기</span><span> - 타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가 주세요.</span>
							 </li>
									
							<li>
								<textarea style="width: 400px; height: 70px"></textarea>
							</li>
							<li>
								<button type="button" class="btnSendReply">댓글등록</button>
							</li>
						</ul>
					</div>
				<div id="listReply"></div>
					
				</div>
			</div>
			<!-- Main -->

		</div>
	<!-- /Main -->
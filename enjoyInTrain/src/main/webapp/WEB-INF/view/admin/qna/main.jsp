<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<style type="text/css">
.homepage #main{
   margin-top: 0em;
    padding-top: 0em;
}   

.alert-info {
    border: 1px solid #9acfea;
    border-radius: 4px;
    background-color: #d9edf7;
    color: #31708f;
    padding: 15px;
    margin-top: 10px;
    margin-bottom: 20px;
}

tr.over {
	background: #f5fffa;
	cursor: pointer;
}
ul.tabs {
	margin: 5px 0px;
	padding: 0;
	float: left;
	list-style: none;
	height: 35px;
	border-bottom: 1px solid #dddddd;
	width: 100%;
}
ul.tabs li {
	float: left;
	margin: 0;
	cursor: pointer;
	padding: 0px 21px ;
	height: 35px;
	line-height: 35px;
	overflow: hidden;
	position: relative;
}
ul.tabs li:hover {
	background: #e7e7e7;
}	
ul.tabs li.active{
	font-weight: 700;
	border: 1px solid #dddddd;
	border-bottom-color:  transparent;
	background: #ffffff;
}

#btn{
	width: 100px; 
	height: 30px; 
	margin-top: 20px; 
	background-color: white; 
	border-color: #cccccc;
}

#updatebtn{
	width: 50px; 
	height: 30px;  
	background-color: white; 
	border-color: #cccccc;
	float: right;
	border-radius: 10px;
	margin-right: 5px;
}

#deletebtn{
	width: 50px; 
	height: 30px;  
	background-color: white; 
	border-color: #cccccc;
	float: right;
	border-radius: 10px;
	margin-right: 5px;
}

</style>

<script type="text/javascript">
$(function(){
	$("#tab-0").addClass("active");
	list(0);
});

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
			if($.trim(data)=="error") {
				listPage(1);
				return false;
			}	
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


$(function(){
	$("#tab-${group}").addClass("active");
	
	$("ul.tabs li").click(function() {
		tab = $(this).attr("data-tab");
		
		$(".tabs li").each(function(){
			$(this).removeClass("active");
		});
		
		$("#tab-"+tab).addClass("active");
		
		list(tab);
		
	});
});

$(function(){
	$(".board-list tr").hover(function(){
		$(this).addClass("over");
	}, function(){ // 마우스가 벗어나면
		$(this).removeClass("over");
	});

});

function list(group){
	var $tab = $(".tabs .active");
	var tab = $tab.attr("data-tab");
	
	var url="<%=cp%>/admin/qna/list";
	var query="group="+ group;
	var selector = "#tab-content";
	
	ajaxHTML(url, "get", query, selector);
}

// 생성 폼
function insertForm(){
	var $tab = $(".tabs .active");
	var tab = $tab.attr("data-tab");
	
	var url = "<%=cp%>/admin/qna/created";
	var query = "";
	var selector = "#tab-content";
	
	ajaxHTML(url, "get", query, selector);
}

// 게시판 폼
function articleQnA(num, secret, id) {
	
	if(secret=="1") {
		if(id!="${sessionScope.crew.crewId}" && "${sessionScope.crew.crewId}" != "a") {
			alert("비밀글은 열람할 수 없습니다.");
			return;
		}
	}
	
	var $tab = $(".tabs .active");
	var tab = $tab.attr("data-tab");
	
	var url="<%=cp%>/admin/qna/article";
	var query="num="+num;
	
	var selector = "#tab-content";
	
	ajaxHTML(url, "get", query, selector);
}

function updateForm(num){
	var $tab = $(".tabs .active");
	var tab = $tab.attr("data-tab");
	
	var url="<%=cp%>/admin/qna/update";
	var query = "num="+num;
	
	var selector = "#tab-content";
	
	ajaxHTML(url, "get", query, selector);
}

function deleteQnA(num) {
	var $tab = $(".tabs .active");
	var tab = $tab.attr("data-tab");
	var url="<%=cp%>/admin/qna/delete";
	
	var query="num="+num;
	
	if(! confirm("위 게시물을 삭제 하시 겠습니까 ? "))
		  return;
	
	var fn = function(data){

		list(0);
	};
	
	ajaxJSON(url, "post", query, fn);		
}

function sendOk(mode) {
	var $tab = $(".tabs .active");
	var tab = $tab.attr("data-tab");
	
	var f = document.QnAForm;

	if(! f.categoryNum.value) {
		alert("분류 명을 선택하세요. ");
		f.categoryNum.focus();
		return;
	}
        
	if(! f.qnaTitle.value) {
		alert("제목을 입력하세요. ");
		f.subject.focus();
		return;
	}
	
	var group = f.categoryNum.value;
	
	var url = "<%=cp%>/admin/qna/"+mode;
	var query = $('form[name=QnAForm]').serialize(); +"&group="+group;
	
	var fn = function(data){
		var state=data.state;
        if(state=="false")
            alert("게시물을 추가(수정)하지 못했습니다. !!!");
		
        list(group);		
	}

	ajaxJSON(url, "post", query, fn);	
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

				
					<div class="9u skel-cell-important" >
						<section>
							<header style="margin-bottom: 2em padding: 0px">
								<h2>Q&#38;A</h2>
								<span class="byline" style="width: 500px;">Question And Answer</span>
							</header>
							
							<div style="clear: both;">
								<ul class="tabs">
									<li id="tab-0" data-tab="0">전체</li>
									<li  id="tab-1" data-tab="1">미답변</li>
									<li  id="tab-2" data-tab="2">답변완료</li>
								</ul>
							</div>
	
							<div id ="tab-content" style="clear: both; width: 100%;"></div>
							
							</section>
					</div>
					
				</div>
			</div>
			<!-- Main -->

		</div>
	<!-- /Main -->
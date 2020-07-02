<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<%
	request.setCharacterEncoding("utf-8");

	Calendar cal = Calendar.getInstance();
	
	int year = cal.get(Calendar.YEAR);
	int month = cal.get(Calendar.MONTH) + 1;
	
	String sy = request.getParameter("year");
	String sm = request.getParameter("month");
	
	if(sy!=null){
		year = Integer.parseInt(sy);
	}
	if(sm!=null){
		year = Integer.parseInt(sm);
	}
	
	cal.set(year, month-1, 1);
	
	year = cal.get(Calendar.YEAR);
	month = cal.get(Calendar.MONTH)+1;
	int week = cal.get(Calendar.DAY_OF_WEEK);
	
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
	width: 1200px;
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
	background: #ffffff;
}
ul.tabs li:hover {
	background: #e7e7e7;
}	
ul.tabs li.active{
	font-weight: 700;
	border: 1px solid #dddddd;
	border-bottom-color:  transparent;
}

#btn{
	width: 100px; 
	height: 30px; 
	margin-top: 20px; 
	background-color: white; 
	border-color: #cccccc;
}

</style>
<script type="text/javascript">

function ajaxFileJSON(url, type, query, fn) {
	$.ajax({
		type:type
		,url:url
        ,processData: false  // file 전송시 필수
        ,contentType: false  // file 전송시 필수
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

$(function(){
	$("#tab-0").addClass("active");
	
	var pmCode="${pmCode}";
	if(pmCode!=="") {
		articleForm(pmCode);
	} else {
		list(0);
	}
});

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



// 리스트
function list(group){

	var url="<%=cp%>/travel/list";
	var query="group="+ group;
	var selector = "#tab-content";
	
	ajaxHTML(url, "get", query, selector);
}

// 생성 폼
function insertForm(){

	var url = "<%=cp%>/travel/created";
	var query = "";
	var selector = "#tab-content";
	
	ajaxHTML(url, "get", query, selector);
}

// 업데이트 폼
function updateForm(pmCode){
	
	var url = "<%=cp%>/travel/update";
	var query = "pmCode="+pmCode;
	var selector = "#tab-content";
	
	ajaxHTML(url, "get", query, selector);
}
	
// 게시판 폼
function articleForm(num) {
	
	var url="<%=cp%>/travel/article";
	var query="pmCode="+num + "&year=" +<%=year%> + "&month=" + <%=month%>;
	
	var selector = "#tab-content";
	
	ajaxHTML(url, "get", query, selector);
}

// 캘린더 변경
function calendar(year, month, num){
	
	var url="<%=cp%>/travel/article";
	
	var query="pmCode="+num + "&year=" + year + "&month=" + month;
	
	var selector = "#tab-content";
	
	console.log(query);
	
	ajaxHTML(url, "get", query, selector);
}

// 예약 폼
function reservation(){
	var f = document.travelArticleForm;
	var query = $(f).serialize();
	
	f.action="<%=cp%>/booking/reservation?"+query;

	f.submit();
}

</script>

<!-- Main -->
<div id="page">

	<!-- Main -->
	<div id="main" class="container">
		<div class="row">

			<div class="9u skel-cell-important">
				<section>
					<header>
						<h2>여행 프로모션</h2>
						<span class="byline">Travel Promotion</span>
					</header>
					
					<div style="clear: both;">
						<ul class="tabs">
							<li id="tab-0" data-tab="0">전체</li>
							<c:forEach var="vo" items="${categoryList}">
								<li id="tab-${vo.categoryNum}" data-tab="${vo.categoryNum}">${vo.category}</li>
							</c:forEach>
						</ul>
					</div>

					<div id="tab-content"
						style="clear: both; padding: 10px 0px 0px; width: 1200px;"></div>
				</section>
			</div>

		</div>
	</div>
	<!-- Main -->

</div>
<!-- /Main -->

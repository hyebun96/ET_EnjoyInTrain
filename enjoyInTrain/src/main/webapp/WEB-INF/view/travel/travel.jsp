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
	background: white; 
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

//submit
function sendOk(mode) {
	var f = document.travelForm;
	var query = new FormData(f);

	var url = "<%=cp%>/travel/"+mode;
	
	if(f.upload.value=="" && list==null){
		alert('메인이미지를 필수적으로 입력해주세요.');
		f.upload.focus();
		return;
	}
	
	 if(f.upload.value!="") {
 		if(! /(\.gif|\.jpg|\.png|\.jpeg)$/i.test(f.upload.value)) {
 			alert('이미지 파일만 가능합니다.(bmp 파일은 불가) !!!');
 			f.upload.focus();
 			return;
 		}
 	}

	var fn = function(data) {
		var state = data.state;
		if (state == "false")
			alert("게시물을 추가(수정)하지 못했습니다. !!!");
		list(0);
	}
	ajaxFileJSON(url, "post", query, fn);   
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
	
	var today = new Date();   

	var year = today.getFullYear(); 
	var month = today.getMonth() + 1; 
	var date = today.getDate(); 
	
	var url="<%=cp%>/travel/article";
	var query="pmCode="+num + "&year=" +<%=year%> + "&month=" + <%=month%>;
	var selector = "#tab-content";
	
	ajaxHTML(url, "get", query, selector);
}

function createdTrain(trainCode){
	var url ="<%=cp%>/travel/createdTrain";
	$.post(url,{
		trainCode:trainCode,
		pmCode : $("input[name=pmCode]").val(),
		startStation : $("select[name=startStation]").val(),
		endStation : $("select[name=endStation]").val()
	}, function(data){
		var trClone = "<tr id='f"+trainCode+" align='left' style='border: 1px solid #cccccc;'>" 
			+ $("#f"+trainCode+"2").clone().html(); + "</tr>";
		
			trClone=trClone.replace("createdTrain2","deleteTrain");
			trClone=trClone.replace("createdTrain","deleteTrain");
			trClone=trClone.replace('plus','trash-alt');
			
			$("#tbodyAdd").append(trClone).clone().html;

		$("#f"+trainCode+"2").remove();
	
	}, "json");
}

function createdTrain2(trainCode){
	var url ="<%=cp%>/travel/createdTrain";
	$.post(url,{
		trainCode:trainCode,
		pmCode : $("input[name=pmCode]").val(),
		startStation : $("select[name=endStation]").val(),
		endStation : $("select[name=startStation]").val()
	}, function(data){
		var trClone = "<tr id='f"+trainCode+" align='left' style='border: 1px solid #cccccc;'>" 
			+ $("#f"+trainCode+"2").clone().html(); + "</tr>";
		
			trClone=trClone.replace("createdTrain","deleteTrain");
			trClone=trClone.replace('plus','trash-alt');
			
			$("#tbodyAdd").append(trClone).clone().html;
		
		$("#f"+trainCode+"2").remove();
	
	}, "json");
}

function deleteFile(fileNum){
	var url ="<%=cp%>/travel/deleteFile";
	$.post(url,{fileNum:fileNum}, function(data){
		$("#f"+fileNum).remove();
		$("input[name=upload]").val("");
		$("input[name=upload]").show();
	}, "json");
}

function deleteContentFile(fileContentNum){
	var url = "<%=cp%>/travel/deleteContentFile";
	$.post(url,{fileNum:fileContentNum},function(data){
		$("#f"+fileContentNum).remove();
	},"json");
}

function deleteTrain(trainCode){
	var url = "<%=cp%>/travel/deleteTrain";
	$.post(url,{trainCode:trainCode},function(data){
		
		$("#f"+trainCode).remove();
		
	},"json");
}

// 캘린더 변경
function calendar(year, month, num){
	
	var url="<%=cp%>/travel/article";
	var query="pmCode="+num + "&year=" + year + "&month=" + month;
	var selector = "#tab-content";

	ajaxHTML(url, "get", query, selector);
}

// 예약 폼
function reservation(){
	var f = document.travelArticleForm;
	var query = $(f).serialize();
	
	/* if(f.pmStartDate.value==""){
		f.pmStartDate.focus();
		return;
	} */
	
	if(f.startTrain.checked ==false){
		return;
	}
	
	if(f.endTrain.checked==false){
		return;
	}

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
						style="clear: both; padding: 10px 0px 0px; width: 1200px;">
					</div>
				</section>
			</div>

		</div>
	</div>
	<!-- Main -->

</div>
<!-- /Main -->

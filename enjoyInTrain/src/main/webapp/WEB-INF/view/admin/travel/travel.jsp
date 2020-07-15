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
	margin-bottom: 20px; 
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
	
	list(0);
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

	var url="<%=cp%>/admin/travel/list";
	var query="group="+ group;
	var selector = "#tab-content";
	
	ajaxHTML(url, "get", query, selector);
}

// 생성 폼
function insertForm(){

	var url = "<%=cp%>/admin/travel/created";
	var query = "";
	var selector = "#tab-content";

	ajaxHTML(url, "get", query, selector);
}

//submit
function sendOk(mode) {
	var f = document.travelForm;
	
	var query = new FormData(f);

	var url = "<%=cp%>/admin/travel/"+ mode;
	
	if(f.upload.value=="" && mode=="created"){
		$("#commentImg").empty();
		$("#commentImg").append("메인이미지를 선택해주세요 ↑");
		$("#commentImg").css("color","#ED6D84");
		f.upload.focus();
		return;
	}
	
	 if(f.upload.value!="") {
 		if(! /(\.gif|\.jpg|\.png|\.jpeg)$/i.test(f.upload.value)) {
 			$("#commentImg").empty();
 			$("#commentImg").append("이미지파일(gif, jpg, png, jpng)만 가능합니다  ↑");
 			$("#commentImg").css("color","#ED6D84");
 			f.upload.focus();
 			return;
 		}
 	}
	
	 if(f.pmTitle.value=="") {
 			$("#commentTitle").show();
 			f.pmTitle.focus();
 			return;
	 }
	 

	 if(f.categoryNum.value=="") {
			$("#commentCategoryNum").empty();
 			$("#commentCategoryNum").append("지역을 선택해 주세요.");
 			$("#commentCategoryNum").css("color","#ED6D84");
			f.categoryNum.focus();
			return;
	 }

	 
	 if(f.pmMaxCount.value=="") {
			$("#commentMaxCount").empty();
 			$("#commentMaxCount").append("최대 수용인원을 선택해 주세요.");
 			$("#commentMaxCount").css("color","#ED6D84");
			f.pmMaxCount.focus();
			return;
	 }
	 
	 if(f.partnerCode.value=="") {
			$("#commentpartnerCode").empty();
 			$("#commentpartnerCode").append("협력업체를 선택해 주세요.");
 			$("#commentpartnerCode").css("color","#ED6D84");
			f.partnerCode.focus();
			return;
	 }
	
	 if(f.pmPercent.value=="") {
			$("#commentpmPercent").empty();
			$("#commentpmPercent").append("협력업체에게 상환할 비율을 선택해 주세요.");
			$("#commentpmPercent").css("color","#ED6D84");
			f.pmPercent.focus();
			return;
	 }
	
	 
	 if(f.pmStartDate.value=="") {
			$("#commentpmStartDate").empty();
			$("#commentpmStartDate").append("프로모션 예약 시작 날짜를 선택해 주세요.");
			$("#commentpmStartDate").css("color","#ED6D84");
			f.pmStartDate.focus();
			return;
	 }
	 
	 if(f.pmEndDate.value=="") {
			$("#commentpmEndDate").empty();
			$("#commentpmEndDate").append("프로모션 예약 종료 날짜를 선택해 주세요.");
			$("#commentpmEndDate").css("color","#ED6D84");
			f.pmEndDate.focus();
			return;
	 }
	

	 if(f.startStation.value=="") {
		 	$(".st-Trains").show();
			$("#commentstartStation1").show();
			$("#commentstartStation1").css("color","#ED6D84");
			f.startStation.focus();
			return;
	 }
	 
	 if(f.endStation.value=="") {
		 	$(".st-Trains").show();
			$("#commentendStation1").show();
			$("#commentendStation1").css("color","#ED6D84");
			f.endStation.focus();
			return;
	 }
	 
	 
	 if(f.product.value=="") {
		 	$("#commentproduct").empty();
			$("#commentproduct").append("프로모션 상품명을  입력해주세요.");
			$("#commentproduct").css("color","#ED6D84");
			f.product.focus();
			return;
	 }
	 /*
	 if(f.pmPrice.value=="") {
		 	$("#commentpmPrice").empty();
			$("#commentpmPrice").append("프로모션 상품가격을  입력해주세요.");
			$("#commentpmPrice").css("color","#ED6D84");
			f.pmPrice.focus();
			return;
	 }
	 
	 if(f.pmPrice.value!="") {
		 if(! /^[0-9]*$/g.test(f.pmPrice.value)) {
		 	$("#commentpmPrice").empty();
			$("#commentpmPrice").append("프로모션 상품가격은 숫자만 가능합니다.");
			$("#commentpmPrice").css("color","#ED6D84");
			f.pmPrice.focus();
			return;
		 }
	 }*/
	 
	 
	 if(f.productContent.value=="") {
		 	$("#commentproductContent").empty();
			$("#commentproductContent").append("프로모션 상품내용을  입력해주세요.");
			$("#commentproductContent").css("color","#ED6D84");
			f.productContent.focus();
			return;
	 }
	 
	 
	 if(f.startStation2.value=="") {
		 	$(".ed-Trains").show();
			$("#commentstartStation2").show();
			$("#commentstartStation2").css("color","#ED6D84");
			f.startStation.focus();
			return;
	 }
	 
	 if(f.endStation2.value=="") {
		 	$(".ed-Trains").show();
			$("#commentendStation2").show();
			$("#commentendStation2").css("color","#ED6D84");
			f.endStation.focus();
			return;
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
	
	var url = "<%=cp%>/admin/travel/update";
	var query = "pmCode="+pmCode;
	var selector = "#tab-content";
	
	ajaxHTML(url, "get", query, selector);
}
	
function deletePromotion(num){
	
	if(!confirm("위 자료를 삭제 하시 겠습니까 ?")) {
		list(0);
	}
	
	var url = "<%=cp%>/admin/travel/deletePromotion";
	var query = "pmCode=" +num;
	
	var fn = function(data) {
		var state = data.state;
		if (state == "false") 
			alert("게시물을 삭제하지 못했습니다.");
		list(0);
	}
	
	ajaxJSON(url, "post", query, fn);   
}

function createdTrain(trainCode){
	var url ="<%=cp%>/admin/travel/createdTrain";
	$.post(url,{
		trainCode:trainCode,
		pmCode : $("input[name=pmCode]").val(),
		startStation : $("select[name=startStation]").val(),
		endStation : $("select[name=endStation]").val()
	}, function(data){
		
		$("#tbodyAdd").show();
		$("#stCircle").show();
		
		var trClone = "<tr id='f"+trainCode+"' align='left' style='border: 1px solid #cccccc;'>" 
			+ $("#f"+trainCode+"2").clone().html(); + "</tr>";
		
			trClone=trClone.replace("createdTrain2","deleteTrain");
			trClone=trClone.replace("createdTrain","deleteTrain");
			trClone=trClone.replace('plus','trash-alt');
			
			$("#tbodyAdd").append(trClone).clone().html;
	
	}, "json");
}

function createdTrain2(trainCode){
	var url ="<%=cp%>/admin/travel/createdTrain";
	$.post(url,{
		trainCode:trainCode,
		pmCode : $("input[name=pmCode]").val(),
		startStation : $("select[name=startStation2]").val(),
		endStation : $("select[name=endStation2]").val()
	}, function(data){
		$("#tbodyAdd2").show();
		$("#edCircle").show();
		
		var trClone = "<tr id='f"+trainCode+"' align='left' style='border: 1px solid #cccccc;'>" 
			+ $("#f"+trainCode+"3").clone().html(); + "</tr>";
		
			trClone=trClone.replace("createdTrain","deleteTrain");
			trClone=trClone.replace('plus','trash-alt');
			
			$("#tbodyAdd2").append(trClone).clone().html;

	
	}, "json");
}

function deleteFile(fileNum){
	var url ="<%=cp%>/admin/travel/deleteFile";
	$.post(url,{fileNum:fileNum}, function(data){
		$("#mainImg").empty();
		$("#f"+fileNum).empty();
		$("input[name=upload]").val("");
		$("input[name=upload]").show();
	}, "json");
}

function deleteContentFile(fileContentNum){
	var url = "<%=cp%>/admin/travel/deleteContentFile";
	$.post(url,{fileNum:fileContentNum},function(data){
		$("#f"+fileContentNum).remove();
	},"json");
}

function deleteTrain(trainCode){
	var url = "<%=cp%>/admin/travel/deleteTrain";
	$.post(url,{trainCode:trainCode},function(data){
		
		$("#f"+trainCode).remove();
		
	},"json");
}
function deleteTrain2(trainCode){
	var url = "<%=cp%>/admin/travel/deleteTrain";
	$.post(url,{trainCode:trainCode},function(data){
		
		$("#f"+trainCode).remove();
		
	},"json");
}

</script>

<!-- Main -->
<div id="adminpage">
	
	<div class="trainandtime">
		<a href="<%=cp%>/admin/travel/travel">프로모션 관리</a> <span>|</span> <a href="<%=cp%>/admin/promotion/list">프로모션 예약 관리</a>
	</div>

	<!-- Main -->
	<div id="main"  class="container">
		<div class="row">
			<div class="9u skel-cell-important">
				<section>
					<header>
						<h2>여행 프로모션</h2>
						<span class="byline">
							Travel Promotion
							<button style="border-radius: 10px; width: 100px; float: right; margin-right: 100px;" type="button" id="btn" class="btn" onclick="insertForm();">프로모션 추가</button>
							<button style="border-radius: 10px; width: 100px; float: right; margin-right: 10px;" type="button" id="btn" class="btn" onclick="list(0);">전체 리스트</button>	
						</span>
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

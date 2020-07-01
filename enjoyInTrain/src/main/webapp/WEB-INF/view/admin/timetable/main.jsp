<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">

<style type="text/css">
*{
    margin:0; padding: 0;
}
body {
    font-size:14px;
	font-family:"Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
}
a{
    color:#000000;
    text-decoration:none;
    cursor:pointer;
}
a:active, a:hover {
    text-decoration: underline;
    color:tomato;
}
.title {
    font-weight:bold;
    font-size:16px;
    font-family:나눔고딕, "맑은 고딕", 돋움, sans-serif;
}
.btn {
    color:#333333;
    font-weight:500;
    font-family:"맑은 고딕", 나눔고딕, 돋움, sans-serif;
    border:1px solid #cccccc;
    background-color:#ffffff;
    text-align:center;
    cursor:pointer;
    padding:3px 10px 5px;
    border-radius:4px;
}
.btn:active, .btn:focus, .btn:hover {
    background-color:#e6e6e6;
    border-color:#adadad;
    color:#333333;
}
.boxTF {
    border:1px solid #999999;
    padding:3px 5px 5px;
    border-radius:4px;
    background-color:#ffffff;
    font-family:"맑은 고딕", 나눔고딕, 돋움, sans-serif;
}
.selectField {
    border:1px solid #999999;
    padding:2px 5px 4px;
    border-radius:4px;
    font-family:"맑은 고딕", 나눔고딕, 돋움, sans-serif;
}

.title {
	width:100%;
	height:45px;
	line-height:45px;
	text-align:left;
	font-weight: bold;
	font-size:15px;
}

tr.over {
	background: #f5fffa;
}

.score-table input {
	border:none;
	padding:3px 5px 5px;
	background-color:#ffffff;
	width:100%;
	box-sizing:border-box;
	font-family:"맑은 고딕", 나눔고딕, 돋움, sans-serif;
}
.score-table input[readonly] {
    pointer-events: none;
    border: none;
    text-align: center;
}

.score-table button {
    color:#333333;
    font-weight:500;
    font-family:"맑은 고딕", 나눔고딕, 돋움, sans-serif;
    border:none;
    width:100%;
    text-align:center;
    cursor:pointer;
    padding:4px 10px 4px;
    background-color: #ffffff;
}
.score-table button:hover {
    font-weight:500;
    color:#4374d9;
}

.spanUpdate, .spanUpdateOk, .spanDelete, .spanUpdateCancel {
	cursor: pointer;
}

.spanUpdate:hover, .spanUpdateOk:hover, .spanDelete:hover, .spanUpdateCancel:hover {
	font-weight:500;
	color: #4374d9;
}
</style>
<script type="text/javascript">
function isValidScoreFormat(data) {
    var regexp = /^(\d+)$/;
    if(! regexp.test(data)) {
        return false;
    }
	var s = parseInt(data);
	return s>=0 && s<=100 ? true : false;
}

function ajaxJSON(url, type, query, fn){
	$.ajax({
		type:type,
		url:url,
		data:query,
		dataType:"json",
		success:function(data){
			fn(data);
		},
		beforeSend:function(jqXHR){
			
		},
		error:function(jqXHR){
			console.log(jqXHR.responseText);
		}
	});
}

//엔터 처리
$(function(){
	$(document).on('keypress', '.score-table input:text', function(evt){
		var fields = $(this).closest("tr").find("input:text");
		var index = fields.index(this);
	        
		if (evt.keyCode == 13) {
			if ( index > -1 && index < 5 ) {
				fields.eq( index + 1 ).focus();
			} else {
				if($(this).closest("tr").find("#btnAdd").length>0) {
					$("#btnAdd").trigger("click");
				}
			}
			return false;
		}
	});
	   
	$(document).on('keyup', '.score-table input:text', function(evt){
		var fields = $(this).closest("tr").find("input:text");
		var index = fields.index(this);

		if(index>=3 && index<=5) {
			var kor=fields.eq(3).val().trim();
			var eng=fields.eq(4).val().trim();
			var mat=fields.eq(5).val().trim();

			var k = isValidScoreFormat(kor) ? parseInt(kor) : 0;
			var e = isValidScoreFormat(eng) ? parseInt(eng) : 0;
			var m = isValidScoreFormat(mat) ? parseInt(mat) : 0;
	        	
			var tot=k+e+m;
			var ave=Math.floor(tot/3);
	        	
			if(!kor && !eng && !mat) {
				tot="";
				ave="";
			}
	        	
			fields.eq(6).val(tot);
			fields.eq(7).val(ave);
		}
	});
});


//리스트
$(function () {
	listPage(1);
});

function listPage(page) {
	var url = "<%=cp%>/admin/timetable/list";
	var query = "pageNo="+page;
	
	var fn = function (data) {
		printScore(data)
	};
	ajaxJSON(url, "get", query, fn);
}

function printScore(data) {
	$(".score-list .rows").remove();
	$(".pagingLayout").empty();
	
	var total_page=data.total_page;
	var dataCount=data.dataCount;
	var pageNo=data.pageNo;
	var paging=data.paging;	
	
	if(dataCount!=0) {
		/*
		for(var idx=0; idx<data.list.length; idx++) {
			var hak=data.list[idx].hak;	
		}
		*/
		$.each(data.list, function(index, value){
			var hak=value.hak;
			var name=value.name;
			var birth=value.birth;
			var kor=value.kor;
			var eng=value.eng;
			var mat=value.mat;
			var tot=value.tot;
			var ave=value.ave;
			
			var str="<tr height='26' class='rows' data-hak='"+hak+"' data-pageNo='"+pageNo+"' bgcolor='#ffffff' align='center'></tr>";
			$(str).
			   hover(function(){
				   $(this).addClass("over");
			   }, function(){
				   $(this).removeClass("over");
			   })
			       .append("<td>"+hak+"</td>")
			       .append("<td>"+name+"</td>")
			       .append("<td>"+birth+"</td>")
			       .append("<td>"+kor+"</td>")
			       .append("<td>"+eng+"</td>")
			       .append("<td>"+mat+"</td>")
			       .append("<td>"+tot+"</td>")
			       .append("<td>"+ave+"</td>")
			       .append("<td><span class='spanUpdate'>수정</span>&nbsp;&nbsp;|&nbsp;&nbsp;<span class='spanDelete'>삭제</span></td>")
			       .appendTo(".score-list");
	    });
		
		$(".pagingLayout").html(paging);
	}
}


//등록하기
$(function(){
	$("#btnAdd").click(function(){
		if(! check()) {
			return false;
		}
		
		var f=document.scoreForm;
		f.hak.value=$("#hak").val().trim();
		f.name.value=$("#name").val().trim();
		f.birth.value=$("#birth").val().trim();
		f.kor.value=$("#kor").val().trim();
		f.eng.value=$("#eng").val().trim();
		f.mat.value=$("#mat").val().trim();
		
		var url="<%=cp%>/admin/timetable/insert";
		var query=$("form[name=scoreForm]").serialize();

		var fn = function(data){
			if(data.state=="false") {
				alert("데이터 추가가 실패했습니다.");
				return false;
			}
			
			listPage(1);
			
			$(".score-input input:text").each(function(){
				$(this).val("");
			});
			$("#hak").focus();
		};
		
		ajaxJSON(url, "post", query, fn);
	});
	
	function check() {
		if(! $("#hak").val().trim()) {
			alert("학번을 입력 하세요 !!!");
			$("#hak").focus();
			return false;
		}
		
		if(! $("#name").val().trim()) {
			alert("이름을 입력 하세요 !!!");
			$("#name").focus();
			return false;
		}
		
		if(! $("#birth").val().trim()) {
			alert("기차종류를 입력해 주세요");
			$("#birth").focus();
			return false;
		}
		
		if(! isValidScoreFormat($("#kor").val()) ) {
			alert("점수는 숫자만 가능합니다. !!!");
			$("#kor").focus();
			return false;
		}
		
		if(! isValidScoreFormat($("#eng").val()) ) {
			alert("점수는 숫자만 가능합니다. !!!");
			$("#eng").focus();
			return false;
		}
		
		if(! isValidScoreFormat($("#mat").val()) ) {
			alert("점수는 숫자만 가능합니다. !!!");
			$("#mat").focus();
			return false;
		}

		return true;
	}
	
});
</script>



<div>@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@</div>


<div style="width: 800px; margin: 30px auto 0px;">

	<div style="title">
	   <h3><span>|</span> timetable</h3>
	</div>

	<table class="score-table" style="width: 100%; margin: 20px auto 0px; border-spacing: 1px; background: #cccccc;">
	<thead>
		<tr height="35" bgcolor="#E4E6E4" align="center">
			<td width="80">시간표고유번호</td>
			<td width="100">기차번호</td>
			<td width="100">기차종류</td>
			<td width="80">행신</td>
			<td width="80">용산</td>
			<td width="80">광명</td>
			<td width="80">총점</td>
			<td width="80">평균</td>
			<td>변경</td>
		</tr>
	</thead>
	
	<tbody class="score-input">
		<tr bgcolor="#ffffff" align="center">
			<td><input type="text" id="hak"></td>
			<td><input type="text" id="name"></td>
			<td><input type="text" id="birth"></td>
			<td><input type="text" id="kor"></td>
			<td><input type="text" id="eng"></td>
			<td><input type="text" id="mat"></td>
			<td><input type="text" id="tot" readonly="readonly" ></td>
			<td><input type="text" id="ave" readonly="readonly" ></td>
			<td>
				<button type="button" id="btnAdd">등록하기</button>
			</td>
		</tr>
	</tbody>
	
	<tfoot class="score-list"></tfoot>
	</table>
	
	<div class="pagingLayout" style="text-align: center; height: 50px;"></div>
	<form name="scoreForm" method="post">
		<input type="hidden" name="hak">
		<input type="hidden" name="name">
		<input type="hidden" name="birth">
		<input type="hidden" name="kor">
		<input type="hidden" name="eng">
		<input type="hidden" name="mat">
	</form>
	
</div>
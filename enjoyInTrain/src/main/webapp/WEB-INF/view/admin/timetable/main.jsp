<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<link rel="stylesheet" href="<%=cp%>/resource/css/timetable.css" type="text/css">
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style>
* {
	margin: 0;
	padding: 0;
}

body {
	font-size: 14px;
	font-family: "Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
}

a {
	color: #000000;
	text-decoration: none;
	cursor: pointer;
}

a:active, a:hover {
	text-decoration: underline;
	color: tomato;
}

.title {
	font-weight: bold;
	font-size: 16px;
	font-family: 나눔고딕, "맑은 고딕", 돋움, sans-serif;
}

.btn {
	color: #333333;
	font-weight: 500;
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
	border: 1px solid #cccccc;
	background-color: #ffffff;
	text-align: center;
	cursor: pointer;
	padding: 3px 10px 5px;
	border-radius: 4px;
}

.btn:active, .btn:focus, .btn:hover {
	background-color: #e6e6e6;
	border-color: #adadad;
	color: #333333;
}

.boxTF {
	border: 1px solid #999999;
	padding: 3px 5px 5px;
	border-radius: 4px;
	background-color: #ffffff;
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
}

.selectField {
	border: 1px solid #999999;
	padding: 2px 5px 4px;
	border-radius: 4px;
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
}

.title {
	width: 100%;
	height: 45px;
	line-height: 45px;
	text-align: left;
	font-weight: bold;
	font-size: 15px;
}

tr.over {
	background: #dde4fd;
}

.time-table input {
	border: none;
	padding: 3px 5px 5px;
	background-color: #ffffff;
	width: 100%;
	box-sizing: border-box;
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
}

.time-table input[readonly] {
	pointer-events: none;
	border: none;
	text-align: center;
}

.time-table button {
	color: #333333;
	font-weight: 500;
	font-family: "맑은 고딕", 나눔고딕, 돋움, sans-serif;
	border: none;
	width: 100%;
	text-align: center;
	cursor: pointer;
	padding: 4px 10px 4px;
	background-color: #ffffff;
}

.time-table button:hover {
	font-weight: 500;
	color: #4374d9;
}

.spanUpdate, .spanUpdateOk, .spanDelete, .spanUpdateCancel {
	cursor: pointer;
}

.spanUpdate:hover, .spanUpdateOk:hover, .spanDelete:hover,
	.spanUpdateCancel:hover {
	font-weight: 500;
	color: #4374d9;
}
</style>
<script type="text/javascript">

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

//
$(function(){
	$(document).on('keypress', '.time-table input:text', function(evt){
		var fields = $(this).closest("tr").find("input:text");
		var index = fields.index(this);
	        
		if (evt.keyCode == 13) {
			if ( index > -1 && index < 17 ) {
				fields.eq( index + 1 ).focus();
			} else {
				if($(this).closest("tr").find("#btnAdd").length>0) {
					$("#btnAdd").trigger("click");
				}
			}
			return false;
		}
	});
	   
	$(document).on('keyup', '.time-table input:text', function(evt){
		var fields = $(this).closest("tr").find("input:text");
		var index = fields.index(this);

		if(index>=3 && index<=16) {
			var HAENGSIN=fields.eq(3).val().trim();
			var YONGSAN=fields.eq(4).val().trim();
			var GWANGMYEONG=fields.eq(5).val().trim();
			var CHEONANASAN=fields.eq(6).val().trim();
			var OSONG=fields.eq(7).val().trim();
			var GONGJU=fields.eq(8).val().trim();
			var SEODAEJEON=fields.eq(9).val().trim();
			var GYERYONG=fields.eq(10).val().trim();
			var NONSAN=fields.eq(11).val().trim();
			var IKSAN=fields.eq(12).val().trim();
			var JEONGEUP=fields.eq(13).val().trim();
			var GWANGJUSONGJEONG=fields.eq(14).val().trim();
			var NAJU=fields.eq(15).val().trim();
			var MOKPO=fields.eq(16).val().trim();

			
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
		printTimeTable(data)
	};
	ajaxJSON(url, "get", query, fn);
}

function printTimeTable(data) {
	$(".score-list .rows").remove();
	$(".pagingLayout").empty();
	
	var total_page=data.total_page;
	var dataCount=data.dataCount;
	var pageNo=data.pageNo;
	var paging=data.paging;	
	
	if(dataCount!=0) {

		$.each(data.list, function(index, value){
			
			var scode=value.scode;
			var traincode=value.traincode;
			var trainname=value.trainname;
			var haengsin=value.haengsin;
			var yongsan=value.yongsan;
			var gwangmyeong=value.gwangmyeong;
			var cheonanasan=value.cheonanasan;
			var osong=value.osong;
			var gongju=value.gongju;
			var seodaejeon=value.seodaejeon;
			var gyeryong=value.gyeryong;
			var nonsan=value.nonsan;
			var iksan=value.iksan;
			var jeongeup=value.jeongeup;
			var gwangjusongjeong=value.gwangjusongjeong;
			var naju=value.naju;
			var mokpo=value.mokpo;

			
			var str="<tr height='26' class='rows' data-scode='"+scode+"' data-pageNo='"+pageNo+"' bgcolor='#ffffff' align='center'></tr>";
			$(str).
			   hover(function(){
				   $(this).addClass("over");
			   }, function(){
				   $(this).removeClass("over");
			   })
			       .append("<td>"+scode+"</td>")
			       .append("<td>"+traincode+"</td>")
			       .append("<td>"+trainname+"</td>")
			       .append("<td>"+haengsin+"</td>")
			       .append("<td>"+yongsan+"</td>")
			       .append("<td>"+gwangmyeong+"</td>")
			       .append("<td>"+cheonanasan+"</td>")
			       .append("<td>"+osong+"</td>")
			       .append("<td>"+gongju+"</td>")
			       .append("<td>"+seodaejeon+"</td>")
			       .append("<td>"+gyeryong+"</td>")
			       .append("<td>"+nonsan+"</td>")
			       .append("<td>"+iksan+"</td>")
			       .append("<td>"+jeongeup+"</td>")
			       .append("<td>"+gwangjusongjeong+"</td>")
			       .append("<td>"+naju+"</td>")
			       .append("<td>"+mokpo+"</td>")
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
		
		var f=document.timeTableForm;
		f.scode.value=$("#scode").val().trim();
		f.traincode.value=$("#traincode").val().trim();
		f.trainname.value=$("#trainname").val().trim();
		f.haengsin.value=$("#haengsin").val().trim();
		f.yongsan.value=$("#yongsan").val().trim();
		f.gwangmyeong.value=$("#gwangmyeong").val().trim();
		f.cheonanasan.value=$("#cheonanasan").val().trim();
		f.osong.value=$("#osong").val().trim();
		f.gongju.value=$("#gongju").val().trim();
		f.seodaejeon.value=$("#seodaejeon").val().trim();
		f.gyeryong.value=$("#gyeryong").val().trim();
		f.nonsan.value=$("#nonsan").val().trim();
		f.iksan.value=$("#iksan").val().trim();
		f.jeongeup.value=$("#jeongeup").val().trim();
		f.gwangjusongjeong.value=$("#gwangjusongjeong").val().trim();
		f.naju.value=$("#naju").val().trim();
		f.mokpo.value=$("#mokpo").val().trim();
		
		var url="<%=cp%>/admin/timetable/insert";
		var query = $("form[name=timeTableForm]").serialize();

			var fn = function(data) {
				if (data.state == "false") {
					alert("데이터 추가가 실패했습니다.");
					return false;
				}

				listPage(1);

				$(".score-input input:text").each(function() {
					$(this).val("");
				});
				$("#scode").focus();
			};

			ajaxJSON(url, "post", query, fn);
		});

		function check() {

			if (!$("#traincode").val().trim()) {
				alert("기차코드 입력 하세요 !!!");
				$("#traincode").focus();
				return false;
			}

			if (!$("#trainname").val().trim()) {
				alert("기차종류를 입력해 주세요");
				$("#trainname").focus();
				return false;
			}

			return true;
		}

	});
	



	
	
	//수정및삭제
	
$(function(){//수정
	var arr=[];
	$("body").on("click", ".spanUpdate", function(){
		var tds = $(this).closest("tr").children("td");

		var s;
		
		$(tds).each(function(index){
			if(index!=tds.length-1) {
				arr[index]=$(this).text();
				s="";
				if(index==0)
					s="  readonly='readonly' "
				
				$(this).empty();
				$(this).append("<input type='text' value='"+arr[index]+"' "+s+">");
			} else {
				$(this).empty();
				$(this).append("<span class='spanUpdateOk'>완료</span>&nbsp;&nbsp;|&nbsp;&nbsp;<span class='spanUpdateCancel'>취소</span>");
			}
		});
		
		$(tds[1]).find("input").focus();
	});
	
	// 수정 완료
	$("body").on("click", ".spanUpdateOk", function(){
		var $inputs = $(this).closest("tr").find("input");
		var pageNo = $(this).closest("tr").attr("data-pageNo");

		if(! check($inputs)) return;
		
		$("form[name=timeTableForm] input[type=hidden]").each(function(index){
			var $input = $(this);
			
			$input.val($inputs.eq(index).val());
		});
		
		var url="<%=cp%>/admin/timetable/update";
		var query=$("form[name=timeTableForm]").serialize();
		
		var fn = function(data){
			if(data.state=="false") {
				alert("데이터 수정이 실패했습니다.");
				return false;
			}
			
			listPage(pageNo);
		};
		ajaxJSON(url, "post", query, fn);
		
	});
	
	function check($inputs) {
		var returnValue=true;
		
		$($inputs).each(function(index){
			if(index==2 && ! $(this).val().trim()) {
				alert("기차번호을 입력 하세요 !!!");
				$(this).focus();
				returnValue=false;
				return false;
			}
		});
		
		return returnValue;
	}
	
	$("body").on("click", ".spanUpdateCancel", function(){
		var tds = $(this).closest("tr").children("td");
		$(tds).each(function(index){
			if(index!=tds.length-1) {
				$(this).empty();
				$(this).text(arr[index]);
			} else {
				$(this).empty();
				$(this).append("<span class='spanUpdate'>수정</span>&nbsp;&nbsp;|&nbsp;&nbsp;<span class='spanDelete' >삭제</span>");
			}
		});
	});
});

// 삭제
$(function(){
	$("body").on("click", ".spanDelete", function(){
		if(! confirm("데이터를 삭제 하시겠습니까 ? "))
			return;
		
		var scode = $(this).closest("tr").attr("data-scode");
		var pageNo = $(this).closest("tr").attr("data-pageNo");
		
		var url="<%=cp%>/admin/timetable/delete";
		var query="scode="+scode;
		
		var fn = function(data){
			if(data.state=="false") {
				alert("데이터 삭제 실패했습니다.");
				return false;
			}
			
			listPage(pageNo);
		};
		ajaxJSON(url, "post", query, fn);
	});
});
</script>



<div>@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@</div>


<div style="width: 1600px; margin: 30px auto 0px;">

	<div style="">
		<h3>
			<span>|</span> timetable
		</h3>
	</div>

	<table class="time-table"
		style="width: 100%; margin: 20px auto 0px; border-spacing: 1px; background: #cccccc;">
		<thead>
			<tr height="35" bgcolor="#E4E6E4" align="center">
				<td width="80">시간표등록고유번호</td>
				<td width="100">기차번호</td>
				<td width="100">기차종류</td>
				<td width="80">행신</td>
				<td width="80">용산</td>
				<td width="80">광명</td>
				<td width="80">천안아산</td>
				<td width="80">오송</td>
				<td width="80">공주</td>
				<td width="80">서대전</td>
				<td width="80">계룡</td>
				<td width="80">논산</td>
				<td width="80">익산</td>
				<td width="80">정읍</td>
				<td width="80">광주송정</td>
				<td width="80">나주</td>
				<td width="80">목포</td>
				<td width="80">변경</td>
			</tr>
		</thead>
		
		<tbody class="score-input">
			<tr bgcolor="#ffffff" align="center">
				<td><input type="text" id="scode" readonly="readonly"></td>
				<td><input type="text" id="traincode"></td>
				<td><input type="text" id="trainname"></td>
				<td><input type="text" id="haengsin"></td>
				<td><input type="text" id="yongsan"></td>
				<td><input type="text" id="gwangmyeong"></td>
				<td><input type="text" id="cheonanasan"></td>
				<td><input type="text" id="osong"></td>
				<td><input type="text" id="gongju"></td>
				<td><input type="text" id="seodaejeon"></td>
				<td><input type="text" id="gyeryong"></td>
				<td><input type="text" id="nonsan"></td>
				<td><input type="text" id="iksan"></td>
				<td><input type="text" id="jeongeup"></td>
				<td><input type="text" id="gwangjusongjeong"></td>
				<td><input type="text" id="naju"></td>
				<td><input type="text" id="mokpo"></td>
				<td>
					<button type="button" id="btnAdd">등록하기</button>
				</td>
			</tr>
		</tbody>

		<tfoot class="score-list"></tfoot>
	</table>

	<div class="pagingLayout" style="text-align: center; height: 50px;"></div>
	<form name="timeTableForm" method="post">
		<input type="hidden" name="scode"> 
		<input type="hidden" name="traincode"> 
		<input type="hidden" name="trainname">
		<input type="hidden" name="haengsin"> 
		<input type="hidden" name="yongsan"> 
			<input type="hidden" name="gwangmyeong">
		<input type="hidden" name="cheonanasan"> 
		<input type="hidden" name="osong"> 
			<input type="hidden" name="gongju"> 
			<input type="hidden" name="seodaejeon"> 
			<input type="hidden" name="gyeryong"> 
			<input type="hidden" name="nonsan">
		<input type="hidden" name="iksan"> 
		<input type="hidden" name="jeongeup"> 
			<input type="hidden" name="gwangjusongjeong">
		<input type="hidden" name="naju"> 
		<input type="hidden" name="mokpo">
	</form>

</div>
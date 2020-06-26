<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<style type="text/css">
.homepage #main {
	margin-top: 0em;
	padding-top: 0em;
}

.ui-widget-header {
	background: none;
	border: none;
	height: 35px;
	line-height: 35px;
	border-bottom: 1px solid #cccccc;
	border-radius: 0px;
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

.btn {
	width: 100px;
	height: 30px;
	background-color: white;
	border-color: #cccccc;
	border-radius: 10px;
	margin: 20px 10px;
}

table td {
	padding-top: 6px;
}

.title {
	text-align: center;
}

#train, #train2 {
	clear: both;
	margin-left: 10px;
	width: 95%;
}

#train tr, #train2 tr {
	width: 20%;
	text-align: center;
}

#train td, #train2 td {
	border: 1px solid #cccccc;
	//
	eaeaea
}

#travelTable tr {
	padding-top: 10px;
	padding-bottom: 10px;
}

.title {
	width: 150px;
	font-weight: bold;
}
</style>

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
	$("#categoryNum").change(function(){
		var categoryNum = $("#categoryNum").val();
		var query = "<span style='color:red;font-weight:bold;'>&nbsp;&nbsp;"+ categoryNum +"</span>";
		
		$("#category").append(query);
	});
});


$(function(){
	$("#endStation").change(function(){
		$("#train").find("tr").remove().end();
		var startStation = $("#startStation").val();
		var endStation = $(this).val();
		
		var url = "<%=cp%>/travel/stationLine1";
		var query = "startStation="+startStation + "&endStation=" +endStation;

		var fn = function(data){
			if(data.stationLineList.length == 0){
				var s="<tr><td style='font-weight: bold; color: green; border:0; outline:0;'>해당역에 일치하는 열차가 없습니다.</td></tr>";
				$("#train").append(s);
				return;
			}
			
			var s="<tr><td>선택</td><td>기차번호</td><td>기차이름</td><td>출발시간</td><td>도착시간</td></tr>";
			$.each(data.stationLineList, function(index, item){
				s += "<tr>"
				s += "<td><input name='startCode' type='checkbox' style='padding-left:20px; margin-left:20px;' value='"+ item.trainCode +"'></td>";
				s += "<td>" + item.trainCode + "</td>"; 
				s += "<td>" + item.trainName + "</td>"; 
				s += "<td>" + item.startTime  + "</td>"; 
				s += "<td>" + item.endTime  + "</td>"; 
				s += "</tr>";
			});
			$("#train").append(s);
		};
		
		
		ajaxJSON(url, "get", query, fn);
	
		
	});
});

$(function(){
	$("#endStation2").change(function(){
		$("#train2").find("tr").remove().end();
		var startStation = $("#startStation2").val();
		var endStation = $(this).val();
		
		var url = "<%=cp%>/travel/stationLine2";
		var query = "startStation2="+startStation + "&endStation2=" +endStation;

		var fn = function(data){
			if(data.stationLineList.length == 0){
				var s="<tr><td style='font-weight: bold; color: green; border:0; outline:0;'>해당역에 일치하는 열차가 없습니다.</td></tr>";
				$("#train2").append(s);
				return;
			}
			
			var s="<tr><td>선택</td><td>기차번호</td><td>기차이름</td><td>출발시간</td><td>도착시간</td></tr>";
			$.each(data.stationLineList, function(index, item){
				s += "<tr>"
				s += "<td><input name='endCode' type='checkbox' style='padding-left:20px; margin-left:20px;' value='"+ item.trainCode +"'></td>";
				s += "<td>" + item.trainCode + "</td>"; 
				s += "<td>" + item.trainName + "</td>"; 
				s += "<td>" + item.startTime  + "</td>"; 
				s += "<td>" + item.endTime  + "</td>"; 
				s += "</tr>";
			});
			$("#train2").append(s);
		};
		
		
		ajaxJSON(url, "get", query, fn);
	
		
	});
});


function sendOk(mode) {
	var f = document.travelForm;
	var query = $(f).serialize();
	var url = "<%=cp%>/travel/${mode}";

		var fn = function(data) {
			var state = data.state;
			if (state == "false")
				alert("게시물을 추가(수정)하지 못했습니다. !!!");
			list(0);
		}

		ajaxJSON(url, "post", query, fn);

	}
</script>

<form name="travelForm" method="post" enctype="multipart/form-data">
	<table id="travelTable"
		style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">


		<tr align="left" height="40"
			style="border-bottom: 1px solid #cccccc; border-top: 3px solid #cccccc;">
			<td class="title" bgcolor="#eeeeee" style="text-align: center;"
				colspan="2">여행 테마</td>
			<td style="padding-left: 10px;" colspan="3"><input type="text"
				name="pmTitle" id="pmTitle" maxlength="100" class="boxTF"
				style="width: 95%;" value="${dto.pmTitle}"></td>
		</tr>

		<tr align="left" height="40"
			style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
			<td class="title" bgcolor="#eeeeee" style="text-align: center;"
				colspan="2">여행지</td>
			<td style="padding-left: 10px; width: 343px;" id="category"><select
				class="selectField" name="categoryNum" id="categoryNum"
				style="width: 150px;">
					<option value="">:: 지역 선택 ::</option>
					<c:forEach var="vo" items="${categoryList}">
						<option value="${vo.categoryNum}"
							${dto.categoryNum==vo.categoryNum?"selected='selected'":""}>${vo.category}</option>
					</c:forEach>
			</select></td>
			<td class="title" bgcolor="#eeeeee"
				style="text-align: center; padding-top: 5px;">최대 인원</td>
			<td valign="top" style="padding: 5px 0px 5px 10px;" colspan="3">
				<input type="number" name="pmMaxCount" max="50" min="0" step="10">&nbsp;명
			</td>
		</tr>

		<tr align="left" height="40"
			style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
			<td class="title" bgcolor="#eeeeee"
				style="text-align: center; padding-top: 5px;" colspan="2">협력 업체</td>
			<td valign="top" style="padding: 5px 0px 5px 10px;"><select
				class="selectField" name="partnerCode" style="width: 150px;">
					<option value="">:: 협력업체 선택 ::</option>
					<c:forEach var="vo" items="${partnerList}">
						<option value="${vo.partnerCode}"
							${dto.partnerCode==vo.partnerCode?"selected='selected'":""}>${vo.partnerName}</option>
					</c:forEach>
			</select></td>
			<td class="title" bgcolor="#eeeeee" style="text-align: center;">업체상환비율</td>
			<td style="padding-left: 10px; width: 343px;"><input
				type="number" name="pmPercent" max="50" min="0" step="10">&nbsp;%
			</td>
		</tr>

		<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
			<td class="title" width="100" bgcolor="#eeeeee"
				style="text-align: center;" colspan="2">예약시작날짜</td>
			<td style="padding-left: 10px;"><input type="text"
				name="pmStartDate" onfocus="(this.type='date')" placeholder="예약시작날짜"></td>
			<td class="title" bgcolor="#eeeeee" style="text-align: center;">예약종료날짜</td>
			<td style="padding-left: 10px;"><input type="text"
				name="pmEndDate" onfocus="(this.type='date')" placeholder="예약종료날짜"></td>
		</tr>

		<!-- 가는 기차 : 출발역, 도착역, 시간  -->
		<tr align="left" height="40"
			style="border-bottom: 1px solid #cccccc; border-top: 3px solid #cccccc;">
			<td class="title" bgcolor="#eeeeee" rowspan="2"
				style="text-align: center; width: 100px; border-bottom: 3px solid #cccccc; border-right: 1px solid #cccccc;">가는열차</td>
			<td class="title" bgcolor="#eeeeee" style="text-align: center;">출발역</td>
			<td style="padding-left: 10px;"><select class="selectField"
				name="startStation" id="startStation" style="width: 150px;">
					<option value="">:: 출발역 선택 ::</option>
					<c:forEach var="vo" items="${stationList}">
						<option value="${vo.engName}"
							${dto.sCode==vo.sCode?"selected='selected'":""}>${vo.sName}</option>
					</c:forEach>
			</select></td>
			<td class="title" bgcolor="#eeeeee" style="text-align: center;">도착역</td>
			<td style="padding-left: 10px;"><select class="selectField"
				name="endStation" id="endStation" style="width: 150px;">
					<option value="">:: 도착역 선택 ::</option>
					<c:forEach var="vo" items="${stationList}">
						<option value="${vo.engName}"
							${dto.sCode==vo.sCode?"selected='selected'":""}>${vo.sName}</option>
					</c:forEach>
			</select></td>
		</tr>

		<!-- 기차 선택 -->
		<tr align="left" height="40" style="border-bottom: 3px solid #cccccc;">
			<td class="title" bgcolor="#eeeeee" style="text-align: center;">기차
				선택</td>
			<td colspan="3">
				<table id="train" style="margin-top: 10px;">
				</table>
			</td>
		</tr>

		<tr align="left"
			style="border-bottom: 1px solid #cccccc; border-top: 3px solid #cccccc; border-bottom: 3px solid #cccccc;">
			<td class="title" width="100" bgcolor="#eeeeee"
				style="text-align: center; padding-top: 5px; border-right: 1px solid #cccccc;"
				rowspan="2">상품</td>
			<td class="title" bgcolor="#eeeeee" style="text-align: center;">상품명</td>
			<td valign="top" style="padding: 5px 0px 5px 10px;"><input
				type="text" name="product"></td>
			<td class="title" bgcolor="#eeeeee" style="text-align: center;">가격</td>
			<td valign="top" style="padding: 5px 0px 5px 10px;"><input
				type="text" name="pmPrice"></td>
		</tr>

		<tr align="left"
			style="border-bottom: 1px solid #cccccc; border-top: 3px solid #cccccc; border-bottom: 3px solid #cccccc;">
			<td class="title" bgcolor="#eeeeee" style="text-align: center;">내용</td>
			<td valign="top" style="padding: 5px 0px 5px 10px;" colspan="3">
				<input type="text" name=productContent>
			</td>
		</tr>


		<!-- 오는 기차 : 출발역, 도착역, 시간  -->
		<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
			<td class="title" bgcolor="#eeeeee"
				style="text-align: center; width: 50px; border-right: 1px solid #cccccc;"
				rowspan="2">오는열차</td>
			<td class="title" bgcolor="#eeeeee" style="text-align: center;">출발역</td>
			<td style="padding-left: 10px;"><select class="selectField"
				name="startStation2" id="startStation2" style="width: 150px;">
					<option value="">:: 출발역 선택 ::</option>
					<c:forEach var="vo" items="${stationList}">
						<option value="${vo.engName}"
							${dto.sCode==vo.sCode?"selected='selected'":""}>${vo.sName}</option>
					</c:forEach>
			</select></td>
			<td class="title" bgcolor="#eeeeee" style="text-align: center;">도착역</td>
			<td style="padding-left: 10px;"><select class="selectField"
				name="endStation2" id="endStation2" style="width: 150px;">
					<option value="">:: 도착역 선택 ::</option>
					<c:forEach var="vo" items="${stationList}">
						<option value="${vo.engName}"
							${dto.sCode==vo.sCode?"selected='selected'":""}>${vo.sName}</option>
					</c:forEach>
			</select></td>
		</tr>

		<!-- 기차 선택 -->
		<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;">
			<td class="title" width="100" bgcolor="#eeeeee"
				style="text-align: center;">기차 선택</td>
			<td colspan="3">
				<table id="train2" style="margin-top: 10px;">
				</table>
			</td>
		</tr>


		<tr align="left" style="border-bottom: 1px solid #cccccc;">
			<td class="title" width="100" bgcolor="#eeeeee"
				style="text-align: center; padding-top: 5px;" colspan="2">여행 내용</td>
			<td valign="top" style="padding: 5px 0px 5px 10px;" colspan="3">
				<textarea name="pmContent" rows="5" class="boxTA"
					style="width: 95%;">${dto.pmContent}</textarea>
			</td>
		</tr>

		<tr align="left" style="border-bottom: 1px solid #cccccc;">
			<td class="title" width="100" bgcolor="#eeeeee"
				style="text-align: center; padding-top: 5px;" colspan="2">파일
				업로드</td>
			<td valign="top" style="padding: 5px 0px 5px 10px;" colspan="3">
				<input type="file" name="uploads" size="53"
				style="width: 95%; height: 25px;">
			</td>
		</tr>

	</table>

	<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
		<tr height="45">
			<td align="center">
				<button type="button" class="btn" onclick="sendOk('${mode}');">${mode=='update'?'수정완료':'등록하기'}</button>
				<button type="reset" class="btn">다시입력</button>
				<button type="button" class="btn"
					onclick="javascript:location.href='<%=cp%>/travel/main';">${mode=='update'?'수정취소':'등록취소'}</button>
				<c:if test="${mode=='update'}">
					<input type="hidden" name="faqNum" value="${dto.pmCode}">
					<input type="hidden" name="group" value="${group}">
				</c:if>
			</td>
		</tr>
	</table>
</form>



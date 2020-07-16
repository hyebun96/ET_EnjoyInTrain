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
	font-weight: bold;
	width: 17%;
}

#train, #train2 {
	clear: both;
	margin-left: 10px;
	width: 95%;
}

#train tr, #train2 tr {
	width: 20%;
	
}

#train td, #train2 td {
	border: 1px solid #cccccc;
	text-align: center;
}

#travelTable tr {
	padding-top: 10px;
	padding-bottom: 10px;
}

.comment{
	color: saddlebrown;
	font-size: 13px;
	font-weight: bold;
}

p{
	margin-bottom: 0px;
}

</style>
<script type="text/javascript">

$(function(){
	$("#endStation").change(function(){
		$("#train").find("tr").remove().end();
		var startStation = $("#startStation").val();
		var endStation = $(this).val();
		
		var url = "<%=cp%>/admin/travel/stationLine1";
		var query = "startStation="+startStation + "&endStation=" +endStation;

		var fn = function(data){
			if(data.stationLineList.length == 0){
				var s="<tr><td style='font-weight: bold; color: green; border:0; outline:0;'>해당역에 일치하는 열차가 없습니다.</td></tr>";
				$("#train").append(s);
				return;
			}
			
			var s="<tr><td style='background: #FDFEF0; font-weight: bold;'>선택</td><td style='background: #FDFEF0; font-weight: bold;'>기차번호</td><td style='background: #FDFEF0; font-weight: bold;'>기차이름</td><td style='background: #FDFEF0; font-weight: bold;'>출발시간</td><td style='background: #FDFEF0; font-weight: bold;'>도착시간</td></tr>";
			$.each(data.stationLineList, function(index, item){
				s += "<tr id='f"+ item.trainCode +"2'>"
				s += "<td><a href='javascript:createdTrain("+item.trainCode+");'><i class='fas fa-plus'></i></a></td>";
				s += "<td>" + item.trainCode + "</td>"; 
				s += "<td>" + item.trainName + "</td>"; 
				s += "<td>" + item.startTime  + "</td>"; 
				s += "<td>" + item.endTime  + "</td>"; 
				s += "</tr>";
			});
			$("#train").append(s);
			
			$("#commentstTrain").empty();
			$("#commentstTrain").append("가는 기차는 프로모션 이용 지역으로 가는 기차입니다. '+' 플러스 버튼을 클릭하여 기차를 선택할 수 있습니다.");
			$("#commentstTrain").css("color","#ED6D84");
			
			
			$("#stPrice").empty();
			$("#stPrice").val(data.price);
			$("#stPrice").append(data.price);
			
			var price= parseInt($("#stPrice").val()) + parseInt($("#edPrice").val()) + parseInt($("#Price").val());
			$("input[name=pmPrice]").val(price);
			
			console.log($("#stPrice").val());
			console.log($("#edPrice").val());
			console.log($("#Price").val());
			
			console.log($("input[name=pmPrice]").val());
		};
		
		ajaxJSON(url, "get", query, fn);
		
	});
});

$(function(){
	$("#endStation2").change(function(){
		$("#train2").find("tr").remove().end();
		var startStation = $("#startStation2").val();
		var endStation = $(this).val();
		
		var url = "<%=cp%>/admin/travel/stationLine2";
		var query = "startStation2="+startStation + "&endStation2=" +endStation;

		var fn = function(data){
			if(data.stationLineList.length == 0){
				var s="<tr><td style='font-weight: bold; color: green; border:0; outline:0;'>해당역에 일치하는 열차가 없습니다.</td></tr>";
				$("#train2").append(s);
				return;
			}
			
			var s="<tr><td style='background: #FDFEF0; font-weight: bold;'>선택</td><td style='background: #FDFEF0; font-weight: bold;'>기차번호</td><td style='background: #FDFEF0; font-weight: bold;'>기차이름</td><td style='background: #FDFEF0; font-weight: bold;'>출발시간</td><td style='background: #FDFEF0; font-weight: bold;'>도착시간</td></tr>";
			$.each(data.stationLineList, function(index, item){
				s += "<tr id='f"+ item.trainCode +"3'>"
				s += "<td><a href='javascript:createdTrain2("+item.trainCode+");'><i class='fas fa-plus'></i></a></td>";
				s += "<td>" + item.trainCode + "</td>"; 
				s += "<td>" + item.trainName + "</td>"; 
				s += "<td>" + item.startTime  + "</td>"; 
				s += "<td>" + item.endTime  + "</td>"; 
				s += "</tr>";
			});
			$("#train2").append(s);
			
			$("#commentstTrain2").empty();
			$("#commentstTrain2").append("오는기차는 프로모션 이용 후 돌아오는 기차입니다. '+' 플러스 버튼을 클릭하여 기차를 선택할 수 있습니다.");
			$("#commentstTrain2").css("color","#ED6D84");
			
			$("#edPrice").empty();
			$("#edPrice").val(data.price);
			$("#edPrice").append(data.price);
			
			var price= parseInt($("#stPrice").val()) + parseInt($("#edPrice").val()) + parseInt($("#Price").val());
			$("input[name=pmPrice]").val(price);
			console.log($("input[name=pmPrice]").val());
			
		};
		
		ajaxJSON(url, "get", query, fn);

	});
});


$(function(){
	$(document).on("keyup","#pmPrice",function(evt){
		var price = $(this).val().trim();
		
		$("#Price").empty();
		$("#Price").val(price);
		$("#Price").append(price);
		
		var price= parseInt($("#stPrice").val()) + parseInt($("#edPrice").val()) + parseInt($("#Price").val());
		$("input[name=pmPrice]").val(price);
		console.log($("input[name=pmPrice]").val());
		
	});
});

$(function() {
	$("#st-Trains-Tr").click(function(){
		
		if ($(".st-Trains").is(":visible")) {
			$(".st-Trains").hide();
			$("#st-train-id").empty();
			$("#st-train-id").append("<i class='fas fa-angle-double-down'></i>&nbsp;&nbsp;가&nbsp;는&nbsp;열&nbsp;차&nbsp;&nbsp;<i class='fas fa-angle-double-down'></i>");
		}else{
			$(".st-Trains").show("200");
			$("#st-train-id").empty();
			$("#st-train-id").append("<i class='fas fa-angle-double-up'></i>&nbsp;&nbsp;가&nbsp;는&nbsp;열&nbsp;차&nbsp;&nbsp;<i class='fas fa-angle-double-up'></i>");
		}
	});
});

$(function() {
	$("#Trains-Product").click(function(){
		
		if ($(".product").is(":visible")) {
			$(".product").hide();
			$("#product-id").empty();
			$("#product-id").append("<i class='fas fa-angle-double-down'></i>&nbsp;프로모션 상품&nbsp;<i class='fas fa-angle-double-down'></i>");
		}else{
			$(".product").show("200");
			$("#product-id").empty();
			$("#product-id").append("<i class='fas fa-angle-double-up'></i>&nbsp;프로모션 상품&nbsp;<i class='fas fa-angle-double-up'></i>");
		}
	});
});

$(function() {
	$("#ed-Trains-Tr").click(function(){
		
		if ($(".ed-Trains").is(":visible")) {
			$(".ed-Trains").hide();
			$("#ed-train-id").empty();
			$("#ed-train-id").append("<i class='fas fa-angle-double-down'></i></i>&nbsp;&nbsp;오&nbsp;는&nbsp;열&nbsp;차&nbsp;&nbsp;<i class='fas fa-angle-double-down'></i></i>");
		}else{
			$(".ed-Trains").show("200");
			$("#ed-train-id").empty();
			$("#ed-train-id").append("<i class='fas fa-angle-double-up'></i>&nbsp;&nbsp;오&nbsp;는&nbsp;열&nbsp;차&nbsp;<i class='fas fa-angle-double-up'></i>");
		}
	});
});

</script>

<form name="travelForm" method="post" enctype="multipart/form-data">
	<table id="travelTable"
		style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
	
		<tr align="left" height="40" 
			style=" background: #382a31; color: white; ">
			<td class="title" colspan="5"
				style=" width: 100px; border-radius: 15px; text-align: center; ">
				<p>
					&nbsp;프로모션&nbsp;
				</p>
			</td>
		</tr>	
	
		<tr align="left" style="padding-top: 100px; ">
			<td class="title" width="100" style="padding: 20px 0px;" >
				<p style="text-align: right;">프로모션 코드</p>
				<p>&nbsp;</p>
			</td>
			<td style="padding-left: 10px; padding-top: 0px;" colspan="2">
				<c:if test="${mode=='created'}">
					<p>${pmCode}</p>
				</c:if>
				<c:if test="${mode=='update'}">
					<p>${dto.pmCode}</p>
				</c:if>
				<input type="hidden" name="pmCode" value="${pmCode}">
				<p class="comment">프로모션 코드는 랜덤으로 생성</p>
			</td>
			<td rowspan="2" id="mainImg" style="padding-left: 50px;">
				<c:if test="${mode=='update'}">
					<img src="<%=cp%>/uploads/travel/${dto.saveFileName}" width="250px" height="130px">
				</c:if>
			</td>
		</tr>
	
		<tr align="left">
			<td class="title" width="100"
				style=" padding-bottom: 20px" >
				<p>&nbsp;</p>
			</td>
			<td valign="top" style="padding: 5px 0px 5px 10px;">
				<c:if test="${mode=='created'}">
					<input type="file" name="upload" class="boxTF" size="53" style="width: 95%; height: 25px;" >
				</c:if>
				<c:if test="${mode=='update'}">
					<input type="file" name="upload" class="boxTF"  size="53" 
						style="width: 95%; height: 25px; display: none;" >
				</c:if>
				<p class="comment" id="commentImg">메인사진은 한장만 업로드 가능합니다</p>
				<span id="promotionMainImage" >
					<c:if test="${mode=='update' && photoList!=null}">
					<c:forEach var="pdto" items="${photoList}">
					<p id="f${pdto.fileNum}" ><a href="javascript:deleteFile('${pdto.fileNum}');" id="mainfile"><i class="fas fa-trash-alt"></i></a>
								&nbsp;&nbsp;${pdto.originalFileName}</p>
					</c:forEach>
					</c:if>	
				</span>
			</td>

			
		</tr>
		
		<tr align="left" height="40" 
			style="  background: #382a31; color: white; border-radius: 15px;">
			<td class="title" colspan="5"
				style=" width: 100px;  text-align: center; border-radius: 15px;">
				<p>
					&nbsp;프로모션 상세&nbsp;
				</p>
			</td>
		</tr>	

		<tr align="left" height="40" >
			<td class="title" style="padding: 30px 0px;" >
				<p style="text-align: right;">프로모션 제목</p>
			</td>
			<td style="padding-left: 10px;" colspan="3" style="padding: 30px 0px;" >
				<input type="text" name="pmTitle" id="pmTitle" maxlength="100" class="boxTF" 
					style="width: 95%; border-radius: 10px; border: 1px solid #cccccc" value="${dto.pmTitle}">
				<p class="comment" id="commentTitle" style="display: none; ">제목을 입력해주세요.</p>
			</td>
		</tr>

	
		<tr align="left" height="40" style=" ">
			<td class="title" style="padding-bottom: 30px;" >
				<p  style="text-align: right;">여행 지역</p>
			</td>
			<td style="padding-left: 10px; width: 343px;" id="category">
				<select class="selectField" name="categoryNum" id="categoryNum" style="width: 180px;">
					<option value="">▶ 지 역 선 택 ◀</option>
					<c:forEach var="vo" items="${categoryList}" >
						<option value="${vo.categoryNum}"
							${dto.categoryNum==vo.categoryNum?"selected='selected'":""}>${vo.category}</option>
					</c:forEach>
				</select>
				<p class="comment" id="commentCategoryNum" >여행지역은 프로모션이 적용되는 지역입니다.</p>
			</td>
		</tr>
		
		<tr align="left" height="40" style=" ">
			<td class="title" style="padding-bottom: 20px;" >
				<p style="text-align: right;">최대 인원</p>
			</td>
			<td valign="top" style="padding: 5px 0px 20px 10px;" colspan="3">
				<input type="number" name="pmMaxCount" max="100" min="0" step="10" value="${dto.pmMaxCount}"
					style="width: 19%; border-radius: 10px; border: 1px solid #cccccc">&nbsp;명
				<p class="comment" id="commentMaxCount" >최대 인원은 프로모션을 이용할 수있는 최대 인원수 입니다.</p>
			</td>
		</tr>
	
		<tr align="left" height="40">
			<td class="title" style="padding-bottom: 20px;" >
				<p style="text-align: right;">협력 업체</p>
			</td>
			<td valign="top" style="padding: 5px 0px 20px 10px;">
				<select class="selectField" name="partnerCode" style="width: 180px;">
					<option value="">▶ 협 력 업 체 선 택  ◀</option>
					<c:forEach var="vo" items="${partnerList}">
						<option value="${vo.partnerCode}"
							${dto.partnerCode==vo.partnerCode?"selected='selected'":""}>${vo.partnerName}</option>
					</c:forEach>
				</select>
				<p class="comment" id="commentpartnerCode">협력업체는 ET와 함께 프로모션을 진행하는 업체입니다.</p>
			</td>
			<td class="title" style="padding-bottom: 20px;">
				<p style="text-align: right;">업체상환비율</p>
			</td>
			<td style="padding: 5px 0px 20px 10px; width: 343px;">
				<input type="number" name="pmPercent" max="50" min="0" step="10" value="${dto.pmPercent}"
					style="width: 25%; border-radius: 10px; border: 1px solid #cccccc">&nbsp;<i class="fas fa-percent"></i>
				<p class="comment" id="commentpmPercent">업체상환비율은 매출에서 협력업체의 지분 금액입니다.</p>
			</td>
		</tr>


		<tr align="left" height="40">
			<td class="title" width="100"  style="padding-bottom: 30px;">
				<p style="text-align: right;">예약시작날짜</p>
			</td>
			<td style="padding-left: 10px; padding-bottom: 30px;"><input type="text" style="width: 180px;"
				name="pmStartDate" onfocus="(this.type='date')" placeholder="예약시작날짜" value="${dto.pmStartDate}">
				<p class="comment" id="commentpmStartDate">예약시작날짜는 예약이 가능한 시작 날짜 입니다.</p>
			</td>
			<td class="title" style="padding-bottom: 30px;">
				<p style="text-align: right;">예약종료날짜</p>
			</td>
			<td style="padding-left: 10px; padding-bottom: 30px;"><input type="text" style="width: 180px;"
				name="pmEndDate" onfocus="(this.type='date')" placeholder="예약종료날짜" value="${dto.pmEndDate}">
				<p class="comment" id="commentpmEndDate">예약종료날짜는 예약이 끝나는 종료 날짜 입니다.</p>	
			</td>
		</tr>
		
		
		<tr align="left" height="40" 
			style="border: 1px solid #382a31;  background: #382a31; color: white;">
			<td class="title" colspan="5"
				style=" width: 100px; text-align: center;  border-radius: 15px;">
				<p>
					&nbsp;프로모션 내용 첨부&nbsp;
				</p>
			</td>
		</tr>	
		
		
		<tr align="left">
			<td class="title" width="100"
				style="padding:20px 0px;" ><p style="float: right;">여행 내용</p></td>
			<td valign="top" style=" padding: 30px 10px;" colspan="3">
				<input multiple="multiple" type="file" name="uploadContent" class="boxTF" size="53" style="width: 95%; height: 25px;">
				<p class="comment" id="commentuploadContent">여행내용은 이미지로 여러개 첨부할 수 있습니다.</p>
			</td>
		</tr>
		
		<c:if test="${mode=='update' && photoList2!=null}">
		<c:forEach var="pdto" items="${photoList2}">
			<tr id="f${pdto.fileContentNum}" align="left" style="">
				<td class="title" width="100"
					style=" padding-top: 5px;" ></td>
				<td valign="top" style="padding: 5px 0px 0px 5px;" colspan="4">
					<a href="javascript:deleteContentFile('${pdto.fileContentNum}');">
						<i class="fas fa-trash-alt"></i>
					</a>&nbsp;&nbsp;${pdto.originalFileName}
				</td>
			</tr>
		</c:forEach>
		</c:if>	
		
		
		<!-- 가는 열차 -->
		<tr align="left" height="40" id="st-Trains-Tr"
			style="  background: #382a31; color: white;">
			<td class="title" colspan="5"
				style=" width: 100px; border-bottom: 3px solid white; text-align: center; margin-top: 50px;  border-radius: 15px;">
				<p id="st-train-id">
					<i class="fas fa-angle-double-down"></i>&nbsp;&nbsp;가&nbsp;는&nbsp;열&nbsp;차&nbsp;&nbsp;<i class="fas fa-angle-double-down"></i>
				</p>
			</td>
		</tr>	

		<!-- 가는 기차 : 출발역, 도착역, 시간  -->
		<tr align="left" height="40" style="display: none;" class="st-Trains">
			<td  class="title" width="100" style="padding: 20px;">
				<p style="text-align: right;">출발역</p>
			</td>
			<td style="padding-left: 10px;" style="padding: 20px;">
				<select class="selectField"
				name="startStation" id="startStation" style="width: 180px;">
					<option value="">▶  출 발 역 선 택 ◀</option>
					<c:forEach var="vo" items="${stationList}">
						<option value="${vo.engName}"
							${startList[0].startStation==vo.engName?"selected='selected'":""}>${vo.sName}</option>
					</c:forEach>    
				</select>
				<p class="comment" id="commentstartStation1" style="display: none; ">출발역을 선택해주세요.</p>
			</td>
			<td class="title" style="padding: 20px;">
				<p style="text-align: right;">도착역</p>
			</td>
			<td style="padding-left: 10px; padding: 20px;"><select class="selectField"
				name="endStation" id="endStation" style="width: 180px;">
					<option value="">▶   도 착 역 선 택  ◀</option>
					<c:forEach var="vo" items="${stationList}">
						<option value="${vo.engName}"
							${startList[0].endStation==vo.engName?"selected='selected'":""}>${vo.sName}</option>
					</c:forEach>
				</select>
				<p class="comment" id="commentendStation1" style="display: none; ">도착역을 선택해주세요.</p>
			</td>
		</tr>

		<!-- 기차 선택 -->
		<tr align="left" height="40" class="st-Trains" style="display: none;">
			<td class="title"  style="padding: 20px;">
				<p style="text-align: right;">기차 선택</p>
			</td>
			<td colspan="4">
				<p class="comment" id="commentstTrain" >가는 기차는 프로모션 이용 지역으로 가는 기차입니다.</p>
				<table id="train" style="margin-top: 10px;">
				
				</table>
			</td>
		</tr>
		
		<tr style="text-align: center; display: none;" class="st-Trains">
			<td class="title" style="padding-right: 20px;">
				<p style="text-align: right;">선택된 기차</p>
			</td>
			<td colspan="4" style="float: left;">
				<p id="stCircle" style=" color: #ED6D84; font-weight: bold; font-size: 13px; ${mode=='created'? 'display: none' : ''} ">휴지통 버튼을 클릭하여 기차를 선택을 해제할 수있습니다.</p>			 
			</td>
		</tr>
		
		<tr style="text-align: center; display: none;" class="st-Trains">
			<td>
				&nbsp;
			</td>
			<td colspan="4">
				<table id="train" style="margin-top: 10px;">
					<tbody id="tbodyAdd" style="display: none;">
						<tr align="left" height="40" style="border: 1px solid #cccccc;">
							<td style="background: #FDFEF0; font-weight: bold;">선택</td>
							<td style="background: #FDFEF0; font-weight: bold;">기차번호</td>
							<td style="background: #FDFEF0; font-weight: bold;">열차번호</td>
							<td style="background: #FDFEF0; font-weight: bold;">출발시간</td>
							<td style="background: #FDFEF0; font-weight: bold;">도착시간</td>
						</tr>

					</tbody>
					
					<c:forEach var="vo" items="${startList}">
						<c:if test="${startList[0]==vo}">						
							<tr align="left" height="40" style="border: 1px solid #cccccc;">
								<td style="background: #FDFEF0; font-weight: bold;">선택</td>
								<td style="background: #FDFEF0; font-weight: bold;">기차번호</td>
								<td style="background: #FDFEF0; font-weight: bold;">열차번호</td>
								<td style="background: #FDFEF0; font-weight: bold;">출발시간</td>
								<td style="background: #FDFEF0; font-weight: bold;">도착시간</td>
							</tr>
						</c:if>
						<tr id="f${vo.trainCode}"  align="left" style="border: 1px solid #cccccc;">
							<td><a href="javascript:deleteTrain('${vo.trainCode}');"><i class="fas fa-trash-alt"></i></a></td>
							<td>${vo.trainName}</td>
							<td>${vo.trainCode}</td>
							<td>${vo.startTime}</td>
							<td>${vo.endTime}</td>
						</tr>
					</c:forEach>

				</table>
			</td>
		</tr>
	
		<!-- 상품 -->	
		<tr align="left" height="40" id="Trains-Product"
			style="  background: #382a31; color: white;">
			<td class="title" colspan="5"
				style=" width: 100px; border-bottom: 3px solid white; text-align: center;  border-radius: 15px;">
				<p id="product-id">
					<i class="fas fa-angle-double-down"></i>&nbsp;프로모션 상품&nbsp;<i class="fas fa-angle-double-down"></i>
				</p>
			</td>
		</tr>	
	
		<tr align="left" class="product"
			style=" display: none; ">
			<td class="title" style="padding: 30px 0px;">
				<p style="text-align: right;">상품명</p>
			</td>
			<td valign="top" style="padding: 20px 10px;" colspan="3">
				<input type="text" name="product" value="${dto.product}" 
					style="width: 95%; border-radius: 10px; border: 1px solid #cccccc">
				<p class="comment" id="commentproduct" >상품명은 프로모션에 포함되는 상품 명입니다.</p>
			</td>
		</tr>
		
		<tr align="left" class="product"
			style=" display: none; ">
			<td class="title" style="padding-bottom: 30px; ">
				<p style="text-align: right;">상품가격</p>
			</td>
			<td valign="top" style="padding: 5px 0px 5px 10px;" colspan="3">
				<input type="text" id="pmPrice" value="${dto.price}"
					style="width: 19%; border-radius: 10px; border: 1px solid #cccccc">&nbsp;원
				<p class="comment" id="commentpmPrice" >상품가격(단, 숫자)을 입력하면 기차와 포함된 총 가격이 계산됩니다.</p>
			</td>
		</tr>

		<tr align="left" class="product"
			style=" height: 57px; display: none;">
			<td class="title" style="padding-bottom: 30px;">
				<p style="text-align: right;">상품내용</p>
			</td>
			<td valign="top" style="padding: 5px 0px 20px 10px;" colspan="3">
				<textarea name=productContent style="width: 95%; border-radius: 10px; border: 1px solid #cccccc">${dto.productContent}</textarea>
				<p class="comment" id="commentproductContent" >상품내용은 프로모션 상품에 내용입니다.</p>
			</td>
		</tr>
		

		<!-- 오는 기차 : 출발역, 도착역, 시간  -->
		<tr align="left" height="40" id="ed-Trains-Tr"
			style="  background: #382a31; color: white;">
			<td class="title" colspan="5"
				style=" width: 100px; border-bottom: 3px solid white; text-align: center;  border-radius: 15px;">
				<p id="ed-train-id">
					<i class="fas fa-angle-double-down"></i>&nbsp;&nbsp;오&nbsp;는&nbsp;열&nbsp;차&nbsp;&nbsp;<i class="fas fa-angle-double-down"></i>
				</p>
			</td>
		</tr>	
		
		<tr align="left" height="40" class="ed-Trains" style="display: none;">
			<td  class="title" width="100" style="padding: 20px;">
				<p style="text-align: right;">출발역</p>
			</td>
			<td style="padding-left: 10px;" style="padding: 20px;">
				<select class="selectField" 
					name="startStation2" id="startStation2" style="width: 150px;">
					<option value="">▶  출 발 역 선 택 ◀</option>
					<c:forEach var="vo" items="${stationList}">
						<option value="${vo.engName}"
							${endList[0].startStation==vo.engName?"selected='selected'":""}>${vo.sName}
						</option>
					</c:forEach>
				</select>
				<p class="comment" id="commentstartStation2" style="display: none; ">출발역을 선택해주세요.</p>
			</td>
			<td class="title" style="padding: 20px;">
				<p style="text-align: right;">도착역</p>
			</td>
			<td style="padding-left: 10px;" style="padding: 20px;">
				<select class="selectField" name="endStation2" id="endStation2" style="width: 150px;">
					<option value="">:: 도착역 선택 ::</option>
					<c:forEach var="vo" items="${stationList}">
						<option value="${vo.engName}"
							${endList[0].endStation==vo.engName?"selected='selected'":""}>${vo.sName}
						</option>
					</c:forEach>
				</select>
				<p class="comment" id="commentendStation2" style="display: none; ">도착역을 선택해주세요.</p>
			</td>
		</tr>

		<!-- 기차 선택 -->
		<tr align="left" height="40"  class="ed-Trains" style="display: none;">
			<td class="title" style="padding: 20px;"></td>
			<td colspan="4">
				<p class="comment" id="commentstTrain2" >오는기차는 프로모션 이용 후 돌아오는 기차입니다.</p>
				<table id="train2" style="margin-top: 10px;">
				</table>
			</td>
		</tr>
		
		<tr style="text-align: center; display: none;" class="ed-Trains">
			<td class="title" style="padding-right: 20px;">
				<p style="text-align: right;">선택된 기차</p>
			</td>
			<td colspan="4" style="float: left;">
				<p id="edCircle" style="color: #ED6D84; font-weight: bold; font-size: 13px; ${mode=='created'? 'display: none' : ''}">휴지통 버튼을 클릭하여 기차를 선택을 해제할 수있습니다.</p>
			</td>
		</tr>

		<tr style="text-align: center; display: none;" class="ed-Trains">
			<td>&nbsp;</td>
			<td colspan="4">
				<table id="train" style="margin-top: 10px;">
					<tbody id="tbodyAdd2" style="display: none;">
						<tr align="left" height="40" style="border: 1px solid #cccccc;">
							<td style="background: #FDFEF0; font-weight: bold;">선택</td>
							<td style="background: #FDFEF0; font-weight: bold;">기차번호</td>
							<td style="background: #FDFEF0; font-weight: bold;">열차번호</td>
							<td style="background: #FDFEF0; font-weight: bold;">출발시간</td>
							<td style="background: #FDFEF0; font-weight: bold;">도착시간</td>
						</tr>

					</tbody>
					
					<c:forEach var="vo" items="${endList}">
						<c:if test="${endList[0]==vo}">						
							<tr align="left" height="40" style="border: 1px solid #cccccc;">
								<td style="background: #FDFEF0; font-weight: bold;">선택</td>
								<td style="background: #FDFEF0; font-weight: bold;">기차번호</td>
								<td style="background: #FDFEF0; font-weight: bold;">열차번호</td>
								<td style="background: #FDFEF0; font-weight: bold;">출발시간</td>
								<td style="background: #FDFEF0; font-weight: bold;">도착시간</td>
							</tr>
						</c:if>
						<tr id="f${vo.trainCode}"  align="left" style="border: 1px solid #cccccc;">
							<td><a href="javascript:deleteTrain('${vo.trainCode}');"><i class="fas fa-trash-alt"></i></a></td>
							<td>${vo.trainName}</td>
							<td>${vo.trainCode}</td>
							<td>${vo.startTime}</td>
							<td>${vo.endTime}</td>
						</tr>
					</c:forEach>

				</table>
			</td>
		</tr>
		
		<tr align="left" height="40" style="  background: #382a31; color: white;">
			<td class="title" colspan="5"
				style=" width: 100px; text-align: center;  border-radius: 15px;">
				<p id="product-id">
					&nbsp;프로모션 총 가격&nbsp;
				</p>
			</td>
		</tr>	
	
		<tr align="left" >
			<td class="title" width="100"
				style="padding:20px 0px;" ><p style="float: right;">총 가격</p></td>
			<td valign="top" style=" padding: 30px 10px;" colspan="3">
			
				<c:if test="${mode=='created'}">
					<input class="comment" id="stPrice" value="0" style="width: 19%; border-radius: 10px; border: 1px solid #cccccc">
						<i class="fas fa-plus"></i>
					<input class="comment" id="Price" value="0" style="width: 19%; border-radius: 10px; border: 1px solid #cccccc">
						<i class="fas fa-plus"></i>
					<input class="comment" id="edPrice" value="0" style="width: 19%; border-radius: 10px; border: 1px solid #cccccc">
						<i class="fas fa-equals"></i>
					<input type="text" name="pmPrice" value="0" style="width: 19%; border-radius: 10px; border: 1px solid #cccccc">&nbsp;원
				</c:if>		
				
				<c:if test="${mode=='update'}">
					<input class="comment" id="stPrice" value="${dto.stPrice}" style="width: 19%; border-radius: 10px; border: 1px solid #cccccc">
						<i class="fas fa-plus"></i>
					<input class="comment" id="Price" value="${dto.price}" style="width: 19%; border-radius: 10px; border: 1px solid #cccccc">
						<i class="fas fa-plus"></i>
					<input class="comment" id="edPrice" value="${dto.edPrice}" style="width: 19%; border-radius: 10px; border: 1px solid #cccccc">
						<i class="fas fa-equals"></i>
					<input type="text" name="pmPrice" value="${dto.pmPrice}" style="width: 19%; border-radius: 10px; border: 1px solid #cccccc">&nbsp;원
				</c:if>			
			</td>
		</tr>
	</table>
	

	<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
		<tr height="45">
			<td align="center">
				<button type="button" class="btn" onclick="sendOk('${mode}');">${mode=='update'?'수정완료':'등록하기'}</button>
				<button type="reset" class="btn">다시입력</button>
				<button type="button" class="btn"
					onclick="javascript:location.href='<%=cp%>/admin/travel/travel';">${mode=='update'?'수정취소':'등록취소'}</button>
				<c:if test="${mode=='update'}">
					<input type="hidden" name="faqNum" value="${dto.pmCode}">
					<input type="hidden" name="group" value="${group}">
					
				</c:if>
			</td>
		</tr>
	</table>
</form>



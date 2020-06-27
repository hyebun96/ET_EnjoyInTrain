<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">

<style>
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

.listname1{
	padding-left: 20px;
}


.btn{
	width: 80px; 
	height: 30px; 
	margin-top: 20px; 
	background-color: white; 
	border-color: #cccccc;
	border-radius: 10px;
}

.btn1{
	width: 80px; 
	height: 25px; 
	margin-top: 20px; 
	background-color: white; 
	border-color: #cccccc;
	border-radius: 10px;
}

.btnsearch{
	width: 55px; 
	height: 25px;  
	margin-top: 20px; 
	background-color: white; 
	border-color: #cccccc;
	border-radius: 10px;
}

.menu-heght1{
	width: 100%; 
	border-spacing: 0px; 
	margin: 0px auto; 
	border-collapse: collapse;

}

.menu-heght1{
	height=35; 
	border-bottom: 1px solid #cccccc;
}

.qu:hover{
	background: #f5fffa;
}

ul.tabs {
	margin: 0;
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

a {
	color: black;
    text-decoration: none;
}

.\39 u {
    width: 65%;
}

/* 모달대화상자 타이틀바 */
.ui-widget-header {
	background: none;
	border: none;
	height:35px;
	line-height:35px;
	border-bottom: 1px solid #cccccc;
	border-radius: 0px;
}
.hover-tr:hover {
	cursor: pointer;
	background: #fffdfd;
}

</style>


<script type="text/javascript">
function searchList() {
	var f=document.searchForm;
	f.action="<%=cp%>/admin/crewManage/list";
	f.submit();
}

function detailedCrew(crewId) {
	var dlg = $("#crew-dialog").dialog({
		autoOpen:false,
		modal:true,
		buttons:{
			" 수정 " : function() {
				updateOk();
			},
			" 삭제 " : function() {
	    	    deleteOk(userId);
		   },
	       " 닫기 " : function() {
	    	    $(this).dialog("close");
	       }
		},
		height:520,
		width: 800,
		title:"회원상세정보",
		close:function(event,ui){
		}
	});
	
	var url = "<%=cp%>/admin/crewManage/detaile";
	var query = "crewId="+crewId;
	
	$.ajax({
		url : url,
		data : query,
		type : 'post',
		success : function(data) {
			$('#crew-dialog').html(data);
			dlg.dialog("open");
		},
		beforeSend : function(jqXHR) {
			jqXHR.setRequestHeader("AJAX", true);
		},
		error : function(jqXHR) {
			if(jqXHR.status == 403){
				location.href="<%=cp%>/crew/login";
				return false;
			}
			console.log(jqXHR.responseText);
		}
	});
}

function updateOk() {
	var f = document.detailedCrewForm;
	
	var url = "<%=cp%>/admin/crewManage/updateCrewState";
	var query = $("#detailedCrewForm").serialize();
	
	$.ajax({
		url : url,
		data: query,
		type : 'post',
		success : function(data) {
			$("form input[name=page]").val("${page}");
			searchList();
		},
		beforeSend : function(jqXHR) {
			jqXHR.setRequertHeader("AJAX",true);
		},
		error : function(jqXHR) {
			if(jqXHR.status == 403){
				location.href = "<%=cp%>/crew/login";
				return false;
			}
			console.log(jqXHR.responseText);
		}
	});
	$('crew-dialog').dialog("close");	
}

function deleteOk(crewId) {
	if(confirm('선택한 계정을 삭제하시겠습니까?')){
		
	}
	$('crew-dialog').dialog("close");	
}

function crewStateDetailView() {
	$('crewStateDetail').dialog({
		modal : true,
		minHeight : 100,
		maxHeight : 450,
		width : 750,
		title: '계정상태 상세 ',
		close : function(event, ui) {
		}
	});
}



</script>

<!-- Banner -->
<div id="banner">
	<div class="container"></div>
</div>
<!-- /Banner -->

<!-- Main -->
<div id="page">

	<!-- Main -->
	<div id="main" class="container">
		<div class="row">
			
			<!-- 사이드 바 메뉴 -->
			<div class="3u">
				<section class="sidebar">
					<header>
						<h2>회원리스트</h2>
					</header>
					
					<ul class="style1">
						<li><a href="#">직원리스트</a></li>
						<li><a href="#">회원관리</a></li>
						<li><a href="#">소메뉴3</a></li>
						<li><a href="#">소메뉴4</a></li>
						<li><a href="#">소메뉴5</a></li>					
					</ul>
				</section>
			</div>
			<!-- /사이드바 메뉴 -->
			
			<!-- 메인 내용 -->
			<div class="9u skel-cell-important">
			
				<section>
					<header>
						<h2>회원관리</h2>
					</header>
					
					<div>		
						<table style="width: 100%; margin: 0px auto; border-spacing: 0px; border-collapse: collapse;">
			               <tr align="center" bgcolor="#eeeeee" height="35" style="border-top: 2px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
						      <th style="width: 60px; color: #787878;">번호</th>
						      <th style="width: 100px; color: #787878;">아이디</th>
						      <th style="width: 100px; color: #787878;">이름</th>
						      <th style="width: 100px; color: #787878;">생년월일</th>
						      <th style="width: 120px; color: #787878;">전화번호</th>
						      <th style="color: #787878;">이메일</th>
						      <th style="width: 60px; color: #787878;">채팅경고</th>
						  </tr>
						 
						 <c:forEach var="dto" items="${list}">
						  <tr align="center" height="35" style="border-bottom: 1px solid #cccccc;" class="hover-tr"
						      onclick="deteailedCrew('${dto.crewId}');"> 
						      <td>${dto.listNum}</td>
						      <td>${dto.crewId}</td>
						      <td>${dto.crewName}</td>
						      <td>${dto.crewBirth}</td>
						      <td>${dto.crewTel}</td>
						      <td>${dto.crewEmail}</td>
						      <td>${dto.crewChatWarning}</td>
						  </tr>
						</c:forEach> 
						</table>
			 
						<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
						   <tr height="40">
							<td align="center">
								${dataCount==0?"등록된 자료가 없습니다.":paging}
							</td>
						   </tr>
						</table>
						
						<table style="width: 100%; margin: 10px auto; border-spacing: 0px;">
						   <tr height="40">
						      <td align="left" width="100">
						          <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/admin/crewManage/list';">새로고침</button>
						      </td>
						      <td align="center">
						          <form name="searchForm" action="<%=cp%>/admin/crewManage/list" method="post">
						              <select name="condition" class="selectField">
						                  <option value="crewId"     ${condition=="crewId" ? "selected='selected'":""}>아이디</option>
						                  <option value="crewName"   ${condition=="crewName" ? "selected='selected'":""}>이름</option>
						                  <option value="crewEmail"  ${condition=="crewEmail" ? "selected='selected'":""}>이메일</option>
						                  <option value="crewTel"    ${condition=="crewTel" ? "selected='selected'":""}>전화번호</option>
						            </select>
						            <input type="text" name="keyword" class="boxTF" value="${keyword}">
						            <input type="hidden" name="page" value="1">
						            <button type="button" class="btn" onclick="searchList()">검색</button>
						        </form>
						      </td>
						      <td align="right" width="100">&nbsp;</td>
						   </tr>
						</table>
						
					</div>
				</section>
			</div>
			<!-- /메인내용 -->
			
			<div id="crew-dialog" style="display: none;">
			</div>
		</div>
	</div>
</div>
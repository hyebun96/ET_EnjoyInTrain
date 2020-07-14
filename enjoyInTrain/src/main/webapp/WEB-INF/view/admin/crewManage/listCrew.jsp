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

.btn{
	width: 80px; 
	height: 30px; 
	margin-top: 20px; 
	background-color: white; 
	border-color: #cccccc;
	border-radius: 10px;
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
	height:40px;
	border-bottom: 1px solid #cccccc;
	border-radius: 0px;

}

.ui-widget .ui-widget {
    background: white;
    font-size: 1em;
}

.hover-tr:hover {
	cursor: pointer;
	background: #fffdfd;
}

.ui-dialog .ui-dialog-content {
    position: relative;
    border: 0;
    padding: .5em 1em;
    background: none;
    overflow: inherit;
}

</style>

<script type="text/javascript">
function searchList() {
	var f=document.searchForm;
	f.action="<%=cp%>/admin/crewManage/list";
	f.submit();
};

function detailedCrew(crewId) {
	var dlg = $("#crew-dialog").dialog({
		autoOpen:false,
		modal:true,
		buttons:{
			" 수정 " : function() {
				updateOk();
			},
	       " 닫기 " : function() {
	    	    $(this).dialog("close");
	       }
		},
		height:280,
		width: 580,
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
};

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
			jqXHR.setRequestHeader("AJAX",true);
		},
		error : function(jqXHR) {
			if(jqXHR.status == 403){
				location.href="<%=cp%>/crew/login";
				return false;
			}
			console.log(jqXHR.responseText);
		}
	});
	$('#crew-dialog').dialog("close");	
};

</script>


<!-- Main -->
<div id="adminpage">
	<div class="trainandtime">
		<a href="<%=cp%>/employee/list">직원관리</a> <span>|</span> <a href="<%=cp%>/admin/crewManage/list">회원관리</a>
	</div>
	<!-- Main -->
	<div id="main" class="container">
		<div class="row">
			
			
			<!-- 메인 내용 -->
			<div class="9u skel-cell-important">
			
				<section>
					<header>
						<h2>회원관리</h2>
					</header>
					
					<div>	
					<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px;">
					   <tr height="35">
					      <td align="right" width="50%">
					          ${dataCount}명(${page}/${total_page} 페이지)
					      </td>
						</tr>
					</table>	
						<table style="width: 100%; margin: 0px auto; border-spacing: 0px; border-collapse: collapse;">
			               <tr align="center" height="35" style="border-top: 2px solid #cccccc; border-bottom: 1px solid #cccccc; color: black; "> 
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
						      onclick="detailedCrew('${dto.crewId}');"> 
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
			
		</div>
	</div>
</div>
<div id="crew-dialog" style="display: none;">
</div>
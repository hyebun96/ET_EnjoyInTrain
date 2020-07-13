<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<style type="text/css">
.homepage #main{
   margin-top: 0em;
    padding-top: 0em;
}   

.ui-widget-header {
	background: none;
	border: none;
	height:35px;
	line-height:35px;
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



.btn{
	width: 100px; 
	height: 30px; 
	background-color: white; 
	border-color: #cccccc;
	border-radius: 10px;
	margin: 20px 10px;
}

table td{
	padding-top: 6px;
}

.title{
	text-align: center;
	width: 30px;
	font-weight: bold;
}

a{
	color: #21373F;
	font-weight: bold;
}
a:hover {
	color: white;
}

p:hover {
	background: #8BD1BD;
	color: white;
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
	$("form select[name=categoryNum]").change(function(){
		var categoryNum = $(this).val();
		var faq = $("form select[name=categoryNum]").closest("tr").next().find("td").next();

		faq.remove().end();
		if(!categoryNum){
			return false;
		}
		
		var url = "<%=cp%>/qna/faqList";
		var query = "group="+categoryNum;
		
		var fn = function(data){
			$("#faq").show();
			
			var s = "<td style='padding-left:10px;' class='faq'>"
			$.each(data.faqList, function(index, item){
				var group = item.faqCategory;
				var category = item.faqTitle;
				s += "<p><a href='<%=cp%>/faq/list?group="+group+"'>"+category+"</p>";
				
			});
			s += "</td>";
			$("form select[name=categoryNum]").closest("tr").next().append(s);
		};
		
		ajaxJSON(url, "get", query, fn);
		
		
	});
});


</script>


						  
	<div style=" width: 100%;">   
		<img src="<%=cp%>/resource/images/createdicon.png" alt="" width="40px;" style="float: right;">		
		<form name="QnAForm" method="post"  enctype="multipart/form-data">
			<table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
				<tr align="left" height="40" style="border-top: 1px solid #cccccc;  border-bottom:1px solid #cccccc;"> 
					<td class="title" style="text-align: center; width: 100px;">분&nbsp;&nbsp;&nbsp;&nbsp;류</td>
					<td style="padding-left:10px;  width: 350px;"> 
						<select class="selectField" name="categoryNum" style="width: 150px;">
						    <option value="" >:: 분류 선택 ::</option>
						    <c:forEach var="vo" items="${groupList}">
						        <option  value="${vo.categoryNum}" ${dto.categoryNum==vo.categoryNum?" selected='selected'":""}>${vo.category}</option>
						    </c:forEach>
						    </select>
			
							<c:if test="${sessionScope.member.userId=='admin'}">
								<button type="button" class="btn" id="btnCategoryUpdate"> 변경 </button>
							</c:if>			        
					</td>
				</tr>
						  
				<tr align="left" height="40" id="faq" style="border-bottom: 1px solid #cccccc; display: none;"> 
					<td class="title" style="text-align: center;" >FAQ</td>
					<td style="padding-left:10px;" class="faq"> 
						<c:forEach var="dto" items="${faqList}">
						    <p><a href="<%=cp%>/faq/list?group=${dto.faqCategory}">&nbsp;${dto.faqTitle}</a></p>
						</c:forEach>
					</td>
				</tr>
						  
				<tr align="left" height="40" style="border-bottom: 1px solid #cccccc; border-top: 1px solid #cccccc;"> 
					<td class="title" style="text-align: center;">질&nbsp;&nbsp;&nbsp;&nbsp;문</td>
					<td style="padding-left:10px;"> 
						<input type="text" name="qnaTitle" maxlength="100" class="boxTF" style="width: 95%;" value="${dto.qnaTitle}">
					</td>
				</tr>
						
				<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;"> 
					<td class="title" style="text-align: center;">작성자</td>
					<td style="padding-left:10px;"> 
						${dto.crewName}
						${crewName}
					</td>
				</tr>
					  
				<tr align="left" height="40" style="border-bottom: 1px solid #cccccc;"> 
					<td class="title" style="text-align: center;">비밀글</td>
					<td style="padding-left:10px;" width="100px;">  
						<input type="checkbox" name="qnaSecret" value="1" ${dto.qnaSecret==1? "checked='ckecked'":""}>
					</td>
				</tr>
				
	
				<tr align="left" style="border-bottom: 1px solid #cccccc; display: ${mode=='update' && sessionScope.crew.crewId=='a' ? '' : 'none;' } "> 
					<td class="title" style="text-align: center; padding-top:5px;">답&nbsp;&nbsp;&nbsp;&nbsp;변</td>
					<td valign="top" style="padding:5px 0px 5px 10px;"> 
						<textarea name="qnaContent" class="boxTA" style="width: 95%; height: 200px;">${dto.qnaContent}</textarea>
					</td>
				</tr>
		
			
			</table>
						
			<table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
				<tr height="45"> 
					<td align="center" >
						<button type="button" class="btn" onclick="sendOk('${mode}');">${mode=='update'?'답변완료':'등록하기'}</button>
						<button type="reset" class="btn">다시입력</button>
						<button type="button" class="btn" onclick="list(1);">${mode=='update'?'답변취소':'등록취소'}</button>
						<c:if test="${mode=='update'}">
						   <input type="hidden" name="qnaNum" value="${dto.qnaNum}">
						    <input type="hidden" name="group" value="${group}">
						</c:if>
					</td>
				</tr>
			</table>
		</form>
							
	</div>

					
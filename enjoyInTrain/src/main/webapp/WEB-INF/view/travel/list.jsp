<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<script type="text/javascript">

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

//게시판 폼
function articleForm(num) {
	
	var $tab = $(".tabs .active");
	var tab = $tab.attr("data-tab");
	
	var url="<%=cp%>/travel/article";
	var query="num="+num;
	
	var selector = "#tab-content";
	
	ajaxHTML(url, "get", query, selector);
}

</script>

<div style="clear: both;">
	<ul class="tabs">
		<li id="tab-0" data-tab="0">전체</li>
		<c:forEach var="vo" items="${categoryList}">
			<li id="tab-${vo.categoryNum}" data-tab="${vo.categoryNum}">${vo.category}</li>
		</c:forEach>
	</ul>
</div>

<table
	style="width: 100%; border-spacing: 0px; margin: 0px auto; border-collapse: collapse;">
	<tbody class="board-list">
		<tr>
			<td></td>
		</tr>
		<c:forEach var="dto" items="${list}">
			<tr id="question-${dto.categoryNum}" class="qu"
				data-num="${dto.pmCode}" height="35"
				style="border-bottom: 1px solid #cccccc;"
				onclick="javascript:articleForm('${dto.pmCode}');">
				<td>${dto.pmTitle}</td>
				<td>${dto.pmPrice}&#126;</td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<table style="width: 100%; border-spacing: 0px;">
	<tr height="35">
		<td align="center">
			  ${dataCount==0?"등록된 게시물이 없습니다.":paging}
		</td>
	</tr>
	<tr height="35">
		<td align="right"><c:if test="${sessionScope.crew.crewId == 'a'}">
				<button style="border-radius: 10px;" type="button" id="btn"
					class="btn" onclick="insertForm();">프로모션 추가</button>
		</c:if></td>
	</tr>
</table>


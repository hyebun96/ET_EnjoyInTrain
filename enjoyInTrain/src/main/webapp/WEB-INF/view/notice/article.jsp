<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<script type="text/javascript">
function deleteNotice() {
	  var q = "noticeNum=${dto.noticeNum}&${query}";
	  var url = "<%=cp%>/notice/delete?" + q;

	  if(confirm("위 자료를 삭제 하시 겠습니까 ? "))
	  	location.href=url;
	}

function updateNotice() {
	  var q = "noticeNum=${dto.noticeNum}&page=${page}";
	  var url = "<%=cp%>/notice/update?" + q;

	  location.href=url;
	
	}

</script>

<script type="text/javascript">

</script>

	<!-- Banner -->
		<div id="banner">
			<div class="container">
			</div>
		</div>
	<!-- /Banner -->

	<!-- Main -->
		<div id="page">
				
			<!-- Main -->
			<div id="main" class="container">
				<div class="row">

					<div class="3u">
						<section class="sidebar">
							<header>
								<h2>메뉴창1</h2>
							</header>
							<ul class="style1">
								<li><a href="<%=cp%>/notice/list">공지사항</a></li>
								<li><a href="<%=cp%>/notice/list">이벤트</a></li>
							</ul>
						</section>

					</div>
				
					<div class="9u skel-cell-important">
						<section>
							
							<div id="namul">
					<form name="noticeForm" method="post" enctype="multipart/form-data">
							
							<ul class="notice">
								<li class="notice-qeustion-left">등록일</li>
								<li class="notice-answer-short">${dto.nCreated}</li>
								<li class="notice-qeustion">게시물제목</li>
								<li class="notice-answer-long">${dto.noticeTitle}</li>
								<li class="notice-qeustion-left">조회수</li>
								<li class="notice-answer-short">${dto.nHitCount}</li>
								<li class="notice-content">${dto.noticeContent}</li>
							</ul>	
					
			       
			        <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/notice/list?${query}';">리스트</button>
			       
			        </form>
			        <c:forEach var="vo" items="${listFile}">
						<ul>
							<li>
				   			   <a href="<%=cp%>/notice/download?noticeFileNum=${vo.noticeFileNum}">${vo.originalFilename}</a>
			         			 (<fmt:formatNumber value="${vo.fileSize/1024}" pattern="0.00"/> KByte)
			         		</li>
				  		</ul> 
					</c:forEach>
						<ul>
			         		<li>
			         		이전글 :
			        		 <c:if test="${not empty preReadDto}">
			           		   <a href="<%=cp%>/notice/article?${query}&noticeNum=${preReadDto.noticeNum}">${preReadDto.noticeTitle}</a>
			       			 </c:if>
			         		</li>
			         		<li>
			         		다음글 :
			        		 <c:if test="${not empty nextReadDto}">
			             		 <a href="<%=cp%>/notice/article?${query}&noticeNum=${nextReadDto.noticeNum}">${nextReadDto.noticeTitle}</a>
			        		</c:if>
			         		</li>
			         	</ul>
			         	
			         	<ul>
			         		<li>
			         						    
			          			<button type="button" class="btn" onclick="updateNotice();">수정</button>
			       						    
			          			<button type="button" class="btn" onclick="deleteNotice();">삭제</button>
			       			
			         		</li>
			         	</ul>
			         	
			        </div>
						</section>
					</div>
					
				</div>
			
			</div>
			<!-- Main -->

		</div>
	<!-- /Main -->
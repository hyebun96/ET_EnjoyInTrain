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

.menu-height1{
	width: 100%; 
	margin: 20px auto 0px; 
	border-spacing: 0px; 
	border-collapse: collapse;"
}

.menu-height1 tr{
	align:left;
	height:40; 
	border-top: 1px solid #cccccc; 
	border-bottom: 1px solid #cccccc;"
}

.menu-height1 td{
	 width:100; 
	 bgcolor:#eeeeee;
	 text-align: center; 
}
.bott-button{
	width: 100%; 
	margin: 0px auto; 
	border-spacing: 0px;"
}

.bott-button tr{
	 height:45;
}

.bott-button td{
	 align:center; 
}

.btn{
	background: white;
	border-color: #787878;
	border-width: 1px;
	height: 27px;
	align:center;
}

.menu-height1 .boxTF{
	background: white;
	border-color: #787878;
	border-width: 1px;
	height: 27px;
	align:center;
	width: 95%; 

}

</style>

<script type="text/javascript" src="<%=cp%>/resource/se/js/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript">
    function check() {
        var f = document.employeeForm;

        var str = f.emName.value;
        if(!str) {
            alert("이름을 입력하세요. ");
            f.emName.focus();
            return;
        }

    	str = f.ptCode.value;
        if(!str) {
            alert("직책을 선택하세요. ");
            f.ptCode.focus();
            return;
        }
        
        str = f.emBirth.value;
        if(!str) {
            alert("생년월일을 입력하세요. ");
            
            f.emBirth.focus();
            return;
        }
        
        str = f.hireDate.value;
        if(!str) {
            alert("입사일을 입력하세요. ");
            f.hireDate.focus();
            return;
        }

    	f.action="<%=cp%>/employee/${mode}";

        f.submit();
    }
    

 <c:if test="${mode=='update'}">
  function deleteFile(fbFileNum) {
		var url="<%=cp%>/freeBoard/deleteFile";
		$.post(url, {fbFileNum:fbFileNum}, function(data){
			$("#f"+fbFileNum).remove();
		}, "json");
  }
</c:if>

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
			
		
			
			<!-- 메인 내용 -->
			<div class="9u skel-cell-important">
				<section>
					<header>
						<h2>${mode=='update'?'직원정보수정':'직원등록'}</h2>
					</header>
					
					<div>
			<form name="employeeForm" method="post" enctype="multipart/form-data" onsubmit="return submitContents(this);">
			  <table class="menu-height1">
			  <tr style="border-top: 1px solid #cccccc;"> 
			      <td>이름</td>
			      <td style="padding:10px;"> 
			        <input type="text" name="emName" maxlength="100" class="boxTF" style="width: 50%;" value="${dto.emName}">
			      </td>
			  </tr>
			  <tr style="border-top: 1px solid #cccccc;"> 
			      <td>직책</td>
			      <td style="padding:10px; "> 
					<select name="ptCode" class="selectField">
						<c:forEach var="pt" items="${ptCodelist}">
							<option value="${pt.ptCode}" ${dto.ptCode == pt.ptCode ?"selected='selected'":""}>${pt.ptCategory}</option>
						</c:forEach>
					</select>
			      </td>
			  </tr>
				
			 <tr style="border-top: 1px solid #cccccc;"> 
			      <td>생년월일</td>
			      <td style="padding:10px;"> 
			        <input type="text" name="emBirth" maxlength="10" class="boxTF" style="width: 50%;" value="${dto.emBirth}">
			      </td>
			  </tr>
			  
			 <tr style="border-top: 1px solid #cccccc;"> 
			      <td>입사일</td>
			      <td style="padding:10px;"> 
			        <input type="text" name="hireDate" maxlength="10" class="boxTF" style="width: 50%;" value="${dto.hireDate}">
			      </td>
			 </tr>
			 
			<c:if test="${mode=='update'}">
			 <tr style="border-top: 1px solid #cccccc;"> 
			      <td>재직여부</td>
			      <td style="padding:10px;"> 
			      <select name="emcheck" class="selectField" >
						<option value="${dto.emcheck}" ${dto.emcheck == 1 ?"selected='selected'":""}>재직</option> 
						<option value="${dto.emcheck}" ${dto.emcheck == 0 ?"selected='selected'":""}>퇴사</option>
			      </select>
			      </td>
			 </tr>
			 </c:if>
			  </table>
			
			  <table class="bott-button" >
			     <tr> 
			      <td>
			        <button type="submit" class="btn" onclick="check();">${mode=='update'?'수정완료':'등록하기'}</button>
			        <button type="reset" class="btn">다시입력</button>
			        <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/employee/list';">${mode=='update'?'수정취소':'등록취소'}</button>
			        
			      </td>
			    </tr>
			  </table>
			</form>
    </div>
    			</section>
			</div>
			<!-- /메인내용 -->
			
		</div>
	</div>
	<!-- /Main -->
</div>
<!-- /Main -->
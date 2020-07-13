<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<script type="text/javascript">
    function sendMail() {
        var f = document.mailForm;
        var str;

        str = f.senderName.value;
        if(!str) {
            alert("이름을 입력하세요. ");
            f.senderName.focus();
            return;
        }
        
    	if(!isValidEmail(f.senderEmail.value)) {
            alert("정상적인 E-Mail을 입력하세요. ");
            f.senderEmail.focus();
            return;
    	}
        
    	if(!isValidEmail(f.receiverEmail.value)) {
            alert("정상적인 E-Mail을 입력하세요. ");
            f.receiverEmail.focus();
            return;
    	}
        
    	str = f.subject.value;
        if(!str) {
            alert("제목을 입력하세요. ");
            f.subject.focus();
            return;
        }

    	str = f.content.value;
        if(!str) {
            alert("내용을 입력하세요. ");
            f.content.focus();
            return;
        }

   		f.action="<%=cp%>/mail/send";

        f.submit();
    }
    
</script>

<div class="body-container" style="width: 700px;">
     <div class="body-title">
         <h3><span style="font-family: Webdings">2</span> 메일 보내기 </h3>
     </div>
     
     <div>
			<form name="mailForm" method="post" enctype="multipart/form-data">
			  <table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
				
			  <tbody id="tb">	
			  <tr height="40"> 
			      <td width="150" style="text-align: left;">보내는사람 이름</td>
			      <td> 
			        <input type="text" name="senderName" maxlength="100" class="boxTF" style="width: 98%;" value="${sessionScope.crew.crewName}" readonly="readonly">
			      </td>
			  </tr>

			  <tr height="40" style="display: none;"> 
			      <td width="150" style="text-align: left;">보내는사람 E-Mail</td>
			      <td> 
			        <input type="text" name="senderEmail" maxlength="100" class="boxTF" style="width: 98%;" value="whddhks9912@gmail.com">
			      </td>
			  </tr>

			  <tr height="40"> 
			      <td width="150" style="text-align: left;">받는사람 E-Mail</td>
			      <td> 
			        <input type="text" name="receiverEmail" maxlength="100" class="boxTF" style="width: 98%;" value="">
			      </td>
			  </tr>

			  <tr height="40"> 
			      <td width="150" style="text-align: left;">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
			      <td> 
			        <input type="text" name="subject" maxlength="100" class="boxTF" style="width: 98%;" value="">
			      </td>
			  </tr>
			
			  <tr> 
			      <td width="150" style="text-align: left; padding-top:5px;" valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
			      <td valign="top" style="padding:5px 0px 5px 0px;"> 
			        <textarea name="content" rows="12" class="boxTA" style="width: 98%; height: 230px;"></textarea>
			      </td>
			  </tr>
			  
			  <tr height="40">
			      <td width="150" style="text-align: left;">첨&nbsp;&nbsp;&nbsp;&nbsp;부</td>
			      <td> 
			           <input type="file" name="upload" class="boxTF" style="width: 98%; height: 25px;" multiple="multiple">
			       </td>
			  </tr> 
			  </tbody>
			  </table>
			
			  <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
			     <tr height="45"> 
			      <td align="center" >
			        <button type="button" class="btn" onclick="sendMail();">메일 전송</button>
			        <button type="reset" class="btn">다시입력</button>
			        <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/';">전송 취소</button>
			      </td>
			    </tr>
			  </table>
			</form>
     </div>

</div>

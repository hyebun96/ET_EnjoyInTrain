<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.2.0/css/all.css">
<link rel="stylesheet" href="<%=cp%>/resource/css/notice.css"
	type="text/css">
<style type="text/css">
.homepage #main {
	margin-top: 0em;
	padding-top: 0em; . room-btn-container { clear : both;
	text-align: center;
}

.chatting-room-btn {
	display: inline-block;
	width: 200px;
	height: 100px;
	line-height: 100px;
	text-align: center;
	margin: 7px;
	color: #333333;
	font-weight: 500;
	font-family: "Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
	border: 1px solid #cccccc;
	background-color: #fff;
	text-align: center;
	cursor: pointer;
	border-radius: 4px;
}

.chatting-room-btn:active, .chatting-room-btn:hover {
	background-color: #e6e6e6;
	border-color: #adadad;
	color: #333333;
}

.chatting-header {
	clear: both;
	width: 100%;
	height: 25px;
	box-sizing: border-box;
}


.chatting-content-list hr {
	border-bottom: 1px solid #4c4c4c;
	position: relative;
	top: 5px;
	margin: 0px 3px;
}


}
</style>
<script src="http://localhost:3001/socket.io/socket.io.js"></script>
<script type="text/javascript">
function convertStringToDate(str) {
	// yyyy-mm-dd hh:mi:ss
    return new Date(str.substr(0,4), str.substr(5,2)-1, str.substr(8,2), str.substr(11,2), str.substr(14,2), str.substr(17,2));
}

function convertDateTimeToString(date) {
    var y = date.getFullYear();
    var m = date.getMonth() + 1;
    m = (m>9 ? '' : '0') + m;
    var d = date.getDate();
    d = (d>9 ? '' : '0') + d;

    var hh = date.getHours();
    hh = (hh>9 ? '' : '0') + hh;
    var mi=date.getMinutes();
    mi = (mi>9 ? '' : '0') + mi;
    var ss=date.getSeconds();
    ss = (ss>9 ? '' : '0') + ss;
    
    return y + '-' + m + '-' + d +' ' + hh + ':'+mi+":"+ss;
}

function convertDateToString(date) {
	var week = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
    var y = date.getFullYear();
    var m = date.getMonth() + 1;
    var d = date.getDate();
    var w = week[date.getDay()];
    
    return y + '년 ' + m + '월 ' + d +"일 " + w;
}

function yyyymmdd(date) {
    var y = date.getFullYear();
    var m = date.getMonth() + 1;
    var d = date.getDate();
    
    return [y,
        (m>9 ? '' : '0') + m,
        (d>9 ? '' : '0') + d
       ].join('');
}

function convertTimeToString(date) {
    var h = date.getHours();
    var m=date.getMinutes();
    var ampm='오전';
    if (h>=12) ampm='오후';
    if (h>12) h=h-12;
    if (h==0) h=12;
    
    return ampm+" "+h+":"+m;
}

function compareToDate(date1, date2) {
	var d1, d2;
	
	if (typeof date1 === 'object' && date1 instanceof Date && typeof date2 === 'object' && date2 instanceof Date) {
		d1 = new Date(date1.getFullYear(), date1.getMonth(), date1.getDate());
		d2 = new Date(date2.getFullYear(), date2.getMonth(), date2.getDate());
	} else {
		// yyyymmdd
		d1 = new Date(date1.substr(0,4), date1.substr(4,2)-1, date1.substr(6,2));
		d2 = new Date(date2.substr(0,4), date2.substr(4,2)-1, date2.substr(6,2));
	}
	
	return d1.getTime() - d2.getTime();	//최근꺼 띄울려는 것
}	
// =========================================================================
	
$(function(){
		var uid = "${sessionScope.crew.crewId}";
		var nickName = "${sessionScope.crew.crewName}";
	    if(! uid) {
	    	location.href="<%=cp%>/crew/login";
			return;
		}

		var first_date = null; // 화면에 출력된 메시지의 최초의 날짜 
		var last_date = null; // 화면에 출력된 메시지의 마지막 날짜 
		var room = null;

		// 채팅 서버에 접속
		var sock = io('http://localhost:3001/chat');
		
		// 채팅방 입장
		var isVisible = $("#myChatMsg").is(':visible');
		var isVisible2 = $("#myChatMsg").is(':hidden');

		$(".chatbtn").click(function() {
			if (isVisible) {
				$("#myChatMsg").hide();
				$("#chatRomInfo").show();
			} else {
				$("#myChatMsg").show();
				$("#chatRomInfo").hide();
			}
			
			room = $(this).attr("data-room");

			first_date = last_date = new Date();

			var roomName = $(this).text();
			$(".chatting-content-list").empty();
			$(".chatting-room-name").html("[" + roomName + "]");

			// 오늘 날짜의 룸 채팅 문자열 리스트 요청
			sock.emit("chat-msg-list", {
				room : room,
				writeDate : convertDateTimeToString(last_date)
			});
			
			
		});
		
		$(".chatting-msg-out").click(function() {
			if (isVisible) {
				$("#myChatMsg").show();
				$("#chatRomInfo").hide();
			} else {
				$("#myChatMsg").hide();
				$("#chatRomInfo").show();
			}
		});
		
		// 채팅 메시지 보내기
		$("#chatMsg").on("keydown", function(event) {
			// 엔터키가 눌린 경우, 서버로 메시지를 전송한다.
			if (event.keyCode == 13) {
				var message = $("#chatMsg").val().trim();

				if (!message) {
					return false;
				}

				var msg = {
					room : room,
					writeDate : convertDateTimeToString(new Date()),
					crewId : uid,
					nickName : nickName,
					message : message,
				};

				sock.emit("chat-msg", msg); //채팅으로 문자를 보낸다

				$("#chatMsg").val("");
				$("#chatMsg").focus();
			}
		});
		
		// 더보기 보내기
		$(".chatting-msg-more").click(function() {
			first_date.setDate(first_date.getDate() - 1);

			// 이전 날짜의 룸 채팅 문자열 리스트 요청
			sock.emit("chat-msg-list", {
				room : room,
				writeDate : convertDateTimeToString(first_date)
			});

		});

		// 채팅 문자열이 전송된 경우
		sock.on("chat-msg", function(data) {
			writeToScreen(data);
		});

		function writeToScreen(data) {
			var room = data.room;
			var writeDate = convertStringToDate(data.writeDate);
			var crewId = data.crewId;
			var nickName = data.nickName;
			var message = data.message;

			var out;
			var dispDate = convertDateToString(writeDate);
			var dispTime = convertTimeToString(writeDate);
			var strDate = yyyymmdd(writeDate);
			var cls = "date-" + strDate;

			if (!$(".chatting-content-list").children("div").hasClass(cls)) {
				// 날짜 출력
				out = "<div class='"+cls+"'>";
				out += " <div style='clear: both; margin: 7px 5px 3px;'>";
				out += "   <div style='float: left; font-size: 11px; padding-right: 5px; color:#556677;'><i class='far fa-calendar'></i> "
						+ dispDate + "</div>";
				out += "   <hr>";
				out += "  </div>";
				out += "</div>";

				if (compareToDate(strDate, yyyymmdd(last_date)) >= 0) {
					last_date = writeDate;
					$(".chatting-content-list").append(out);
				} else {
					$(".chatting-content-list").prepend(out);
				}
			}

			// 메시지 출력
			if (uid == crewId) {
				out = "<div class='chatting-content' style='clear: both; margin: 3px 5px;'>";
				out += " <div style='float: right; background: #fef01b; cursor: pointer; padding:5px 5px; ' >"
						+ message + "</div>";
				out += " <div style='float: right; font-size: 11px; margin-right: 3px;'>"
						+ dispTime + "</div>";
				out += " <div style='clear:both; height:3px;'></div>";
				out += "</div>";

			} else {
				out = "<div class='chatting-content' style='clear: both; margin: 3px 5px;'>";
				out += " <div style='font-size: 16px; margin-bottom: 3px; font-family: 맑은고딕;'>"
						+ nickName + "</div>"
				out += " <div style='display:inline-block; background: #ffffff; cursor: pointer; padding:5px 5px;' >"
						+ message + "</div>";
				out += " <div style='font-size: 11px; display:inline-block;'>"
						+ dispTime + "</div>";
				out += " <div style='clear:both; height:3px;'></div>";
				out += "</div>";
			}

			$("." + cls).append(out);
			$('.chatting-content-list').scrollTop(
					$('.chatting-content-list').prop('scrollHeight'));
		}

	});
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

			<div class="3u">
				<section class="sidebar">
					<header>
						<h2>Customer</h2>
					</header>
					<ul class="style1">
						<li><a href="<%=cp%>/qna/main">QnA</a></li>
						<li><a href="<%=cp%>/lostBoard/list">유실물</a></li>
						<li><a href="<%=cp%>/freeBoard/list">자유게시판</a></li>
						<li><a href="<%=cp%>/suggest/list">고객의소리</a></li>
						<li><a href="<%=cp%>/chat/main">채팅</a></li>
					</ul>
				</section>
			</div>

			<div class="9u skel-cell-important">
				<section>
					<header>
						<h2>채팅</h2>
						<span class="byline">chat | E.T Communication</span>
					</header>


					<div class="chat-title">
						<div class="chat-title1">
							<h3>
								<i class="far fa-comment-alt"></i> 채팅
							</h3>
						</div>


						<div id="chatRomInfo" class="openchat1">
							<div style="clear: both;">
								<div class="chat_room">
									<div class="chat_room_list1">수도권</div>
									<div class="chat_room_list2">강원권</div>
									<div class="chat_room_list3">충청권</div>
									<div class="chat_image">
										<img src="<%=cp%>/resource/images/nam3.PNG" width="80%"	height="200px;" style="padding: 10px;"> 
									</div>
									<div class="chat_image">
										<img src="<%=cp%>/resource/images/nam4.PNG" width="80%"	height="200px;" style="padding: 10px;">
									</div>
									<div class="chat_image"> 
										<img src="<%=cp%>/resource/images/nam1.PNG" width="80%" height="200px;" style="padding: 10px;">
									</div>
									
									<div class="chat_btn">
										<button type="button" class="chatbtn"
											style="margin-right: 40px;" data-room="room1">수도권 방</button>
										<button type="button" class="chatbtn"
											style="margin-right: 40px;" data-room="room2">강원권 방</button>
										<button type="button" class="chatbtn" data-room="room3">충청권 방</button>
									</div>
								</div>
								<div class="chat_room">
									<div class="chat_room_list4">경상권</div>
									<div class="chat_room_list5">전라권</div>
									<div class="chat_room_list6">자유채팅방</div>
									
									<div class="chat_image">
										<img src="<%=cp%>/resource/images/nam5.PNG" width="80%"	height="200px;" style="padding: 10px;">
									</div>
									<div class="chat_image"> 
										<img src="<%=cp%>/resource/images/nam2.PNG" width="80%"	height="200px;" style="padding: 10px;">
									</div>
									<div class="chat_image"> 
										<img src="<%=cp%>/resource/images/ex4.PNG" width="80%"	height="200px;" style="padding: 10px;">
									</div>
									
									<div class="chat_btn">
										<button type="button" class="chatbtn"
											style="margin-right: 40px;" data-room="room4">경상권 방</button>
										<button type="button" class="chatbtn"
											style="margin-right: 40px;" data-room="room5">전라권 방</button>
										<button type="button" class="chatbtn" data-room="room6">자유채팅방</button>
									</div>
								</div>
							</div>
						</div>

						<div id="myChatMsg" style="display: none;">
								<div class="chatting-msg-out" style="float: right; cursor: pointer; font-size: 16px;"> | 퇴장하기</div>
							<div class="chatting-header">
							
								<div style="float: left;">
									<span class="chatting-room-name"></span>
								</div>
								<div class="chatting-msg-more" style="float: right; cursor: pointer;"> 더보기 </div>
								
							</div>
							
							
							<div class="chatting-content-list" style="background: #9bbbd4;"></div>
							
							
							<div style="clear: both; padding-top: 5px;">
								<input type="text" id="chatMsg" class="boxTF" style="width: 100%; box-sizing: border-box;" placeholder="채팅 메시지를 입력 하세요...">
							</div>
							
							
							
						</div>
						
					</div>

				</section>
			</div>

		</div>




	</div>

</div>

<!-- Main -->

<!-- /Main -->

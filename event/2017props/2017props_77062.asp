﻿<% if itemid = 1676126 or itemid = 1676180 or itemid = 1676207 or itemid = 1676225 or itemid = 1676272 or itemid = 1676297 or itemid = 1676411 or itemid = 1676426 or itemid = 1676481 or itemid = 1676486 or itemid = 1676503 or itemid = 1676514 or itemid = 1676654 or itemid = 1676596 or itemid = 1676597 then %>
	<% if date() >= "2017-04-03" and date() <= "2017-04-17" then %>
		<%
		dim myevtitemcnt, eCode, sqlstr
			eCode   =  77062
			myevtitemcnt = 0

			if LoginUserid <> "" then
				sqlstr = "select count(*) From [db_event].[dbo].[tbl_event_subscript] Where evt_code="& eCode &" and userid='"& LoginUserid &"' and datediff(day,regdate,getdate()) = 0  "
				rsget.Open sqlstr, dbget, 1
					myevtitemcnt = rsget(0)
				rsget.close
			end if
		%>
		<style type="text/css">
		/* for dev msg : 정기세일 숨은 보물 찾기 레이어팝업 css */
		.lySopum {position:absolute; top:295px; left:50%; z-index:95; margin-left:-570px;}
		.lySopum img {vertical-align:top;}
		.lySopum button {position:absolute; bottom:76px; left:50%; width:300px; height:60px; margin-left:-150px; background-color:transparent; color:transparent;}
		</style>

		<script type="text/javascript">
		function fnsalereturn() {
			history.back();
		}

		function fnsaletreasure(itid) {
			<% If LoginUserid = "" Then %>
				if ("<%=IsUserLoginOK()%>"=="False") {
					top.location.href="/login/loginpage.asp?vType=G";
					return false;
				}
			<% End If %>
			<% If LoginUserid <> "" Then %>
			var reStr;
			var str = $.ajax({
				type: "GET",
				url:"/event/2017props/do_proc/doEventSubscript77062.asp",
				data: "mode=down&itid="+itid,
				dataType: "text",
				async: false
			}).responseText;
				reStr = str.split("|");
				if(reStr[0]=="OK"){
					if(reStr[1] == "dn") {

						alert('응모가 완료되었습니다.\n당첨은 4월 20일 발표예정입니다.\n이벤트 페이지로 이동합니다.');
						parent.location.href='/event/2017props/treasure.asp';
						return false;
					}else if(reStr[1] == "re2") {
						alert('이미 응모하셨습니다.\n이벤트는 하루에 한번만 응모 가능합니다.');
						return false;
					}else if(reStr[1] == "re") {
						alert('이미 응모하신 상품 입니다.\n한 상품은 한번만 응모 가능합니다.');
						return false;
					}else{
						alert('오류가 발생했습니다.');
						return false;
					}
				}else{
					errorMsg = reStr[1].replace(">?n", "\n");
					alert(errorMsg);
					document.location.reload();
					return false;
				}
			<% End If %>
		}
		</script>

		<%'' for dev msg : 정기세일 숨은 보물 찾기 상품상세 레이어팝업 %>
		<div id="lySopum" class="lySopum">
			<%' for dev msg : 상품코드로 이미지 파일명 바꿔주세요 %>
			<p>
				<% if myevtitemcnt > 0 then %>
					<img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/txt_congratulation_<%=itemid%>_done.png" alt="오늘은 이미 응모하셨습니다 내일 또 다른 보물에 도전하세요! 오늘은 이미 응모하셨습니다 내일 또 다른 보물에 도전하세요! ID당 하루에 한 번 응모 가능합니다" />
				<% else %>
					<img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/txt_congratulation_<%=itemid%>.png" alt="축하합니다! 보물을 찾으셨습니다.총 100명을 추첨해 기프트카드 1만원권 증정 지금 도전하세요! " />
				<% end if %>
			</p>

			<% if myevtitemcnt > 0 then %>
				<button type="button" onclick="fnsalereturn();">이전 페이지로 가기</button>
			<% else %>
				<button type="button" onclick="fnsaletreasure('<%=itemid%>');">응모하기</button>
			<% end if %>
		</div>		
	<% end if %>
<% end if %>
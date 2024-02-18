<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : VIP - 마이 리틀 트리
' History : 2016-11-23 이종화 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim eCode, userid, currenttime, subscriptcoun, totalcnt, subscriptcount, systemok, sqlstr, totalprice
dim arrList
	IF application("Svr_Info") = "Dev" THEN
		eCode = "66214"
	Else
		eCode = "74526"
	end if

currenttime = now()

userid = GetEncLoginUserID()
totalprice = 0
subscriptcount=0

'//본인 참여 여부
if userid<>"" then
	subscriptcount = getevent_subscriptexistscount(eCode, userid, "", "", "")
end if

if userid <> "" then
	sqlstr = sqlstr & " select isnull(sum(subtotalprice),0) as totalprice"
	sqlstr = sqlstr & " from db_order.dbo.tbl_order_master m"
	sqlstr = sqlstr & " where convert(varchar(10),regdate,21) between '2016-11-28' and '2016-12-02' "
	sqlstr = sqlstr & " and m.jumundiv not in (6,9)"
	sqlstr = sqlstr & " and m.ipkumdiv>3 and cancelyn='N'"
	sqlstr = sqlstr & " and m.userid='"& userid &"'"

	'response.write sqlstr & "<Br>"
	rsget.Open sqlstr,dbget
	IF not rsget.EOF THEN
		totalprice = rsget("totalprice")
	else
		totalprice = 0
	END IF
	rsget.close
end if
%>
<style type="text/css">
img {vertical-align:top;}

/* eventContents */
.evntConts {position:relative;}
.evntConts .itemName {display:block; z-index:10; position:absolute; top:287px; left:130px; animation:bounce 1s infinite;}
@keyframes bounce {
	from to {transform:translateY(0); animation-timing-function:ease-out;}
	50% {transform:translateY(-10px); animation-timing-function:ease-in;}
}
.evntConts p.price {width:278px; position:absolute; right:185px; bottom:270px; font-size:25px; line-height:25px; color:#5c7c3d; font-weight:bold;}
.evntConts p .price01 {padding-right:10px;}

/* eventNotice */
.eventNotice {height:155px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74526/bg_noti.jpg) no-repeat 0 0;overflow: hidden;}
.eventNotice h3, .eventNotice .notiContents {float:left;}
.eventNotice h3{display:inline-block; margin:70px 113px 0 120px;}
.eventNotice ul {position:relative; margin:27px 0; padding-left:63px; border-left: #fff 1px solid;}
.eventNotice ul li{color:#fff; font-size:12px; text-align: left; padding:3px 0;}
</style>
<script type="text/javascript">
function jsevtgo(){
<% If IsUserLoginOK() Then %>
	<% if IsVIPUser() then 'vip %>
		<% If not(left(currenttime,10)>="2016-11-28" and left(currenttime,10)<"2016-12-03" ) then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;
		<% else %>
			<% if subscriptcount > 0 then %>
				alert('이미 응모 하셨습니다.\n당첨자 발표일을 기다려 주세요');
				return;
			<% else %>
				<% if totalprice < 1 then %>
					alert('본 이벤트는\n이벤트 기간 내 구매 이력이 있어야\n참여할 수 있어요');
					return false;
				<% else %>
					var str = $.ajax({
						type: "POST",
						url: "/event/etc/doeventsubscript/doEventSubscript74526.asp",
						data: "mode=evtgo",
						dataType: "text",
						async: false
					}).responseText;
					var str1 = str.split("||")
					if (str1[0] == "11"){
						alert('응모가 완료되었습니다!\n당첨자 발표일을 기다려 주세요');
						return false;
					}else if (str1[0] == "01"){
						alert('잘못된 접속입니다.');
						return false;
					}else if (str1[0] == "02"){
						alert('로그인을 해야\n이벤트에 참여할 수 있어요.');
						return false;
					}else if (str1[0] == "03"){
						alert('이벤트 기간이 아닙니다.');
						return false;		
					}else if (str1[0] == "04"){
						alert('본 이벤트는\nID당 한 번씩만 참여할 수 있어요');
						return false;
					}else if (str1[0] == "00"){
						alert('정상적인 경로가 아닙니다.');
						return false;
					}else{
						alert('오류가 발생했습니다.');
						return false;
					}
				<% end if %>
			<% end if %>
		<% end if %>
	<% else %>
		alert('본 이벤트는\nVIP 등급 이상 고객님들을 위한\n이벤트입니다.');
		return false;
	<% end if %>
<% Else %>
	if(confirm("로그인을 하셔야 응모가 가능 합니다.\n로그인 하시겠습니까?")){
		var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
		winLogin.focus();
		return false;
	}
	return false;
<% End IF %>
}
</script>
<div class="evt74526">
	<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/74526/tit_little_tree.jpg" alt="VIP LOUNGE EVENT 마이 리틀 트리 이벤트 기간 내 구매 이력이 있는 분들 중 50분을 추첨하여 크리스마스트리를 드립니다 당첨자 발표 : 2016년 12월 5일" /></h2>
	<div class="evntConts">
		<a href="/shopping/category_prd.asp?itemid=1602684&pEtr=74526" class="itemName"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74526/txt_item.png" alt="로즈골드 별 트리풀 세트" /></a>
		<p class="price">
			<span class="price01"><% If IsUserLoginOK() Then %><%= FormatNumber(totalprice,0) %><% Else %>***,***<% End If %></span>
			<span class="price02">원</span>
		</p>
		<img src="http://webimage.10x10.co.kr/eventIMG/2016/74526/evnt_contents.jpg" alt="이주의 쇼핑활동 2016년 11월 28일 ~ 12월 02일 VIP등급에게만 드리는 기회" usemap="#Map"/>
		<map name="Map">
			<area shape="rect" coords="146,40,556,564" href="/shopping/category_prd.asp?itemid=1602684&pEtr=74526" alt="로즈골드 별 트리풀세트" onfocus="this.blur();">
			<area shape="rect" coords="603,419,1040,522" href="#" alt="응모하기" onfocus="this.blur();" onclick="jsevtgo(); return false;">
		</map>
	</div>
	<div class="eventNotice">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/74526/txt_evnt_noti.png" alt="이벤트 유의사항"/></h3>
		<div class="notiContents">
			<ul>
				<li>- 본 이벤트는 VIP Silver, VIP Gold, VVIP 등급 고객님을 위한 이벤트입니다.</li>
				<li>- 이벤트 기간 내 구매 이력이 있어야 응모가 가능합니다.</li>
				<li>- ID 당 1회만 참여할 수 있습니다.</li>
				<li>- 당첨된 경품의 색상 및 옵션은 랜덤으로 배송됩니다.</li>
			</ul>
		</div>
	</div>
</div>	
<!-- #include virtual="/lib/db/dbclose.asp" -->
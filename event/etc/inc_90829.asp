<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 천원의기적3
' History : 2018-11-30 원승현 
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_evaluatesearchercls.asp" -->
<%
	Dim currenttime, vEventStartDate, vEventEndDate, eCode, vEndEventAfterViewStartDate, vEndEventAfterViewEndDate, vEventConfirmDate
	'// 현재시간
	currenttime = now()
	'currenttime = "2018-12-06 오전 10:03:35"

	'// 이벤트 진행기간
	vEventStartDate = "2018-12-03"
	vEventEndDate = "2018-12-05"

	'// 이벤트 종료 후 당첨자 발표전까지 일자
	vEndEventAfterViewStartDate = "2018-12-06"
	vEndEventAfterViewEndDate = "2018-12-10"

	'// 당첨자 발표일자
	vEventConfirmDate = "2018-12-11"

	eCode = "90829"

	'// 소셜서비스로 글보내기
	Dim vTitle, vLink, vPre, vImg, vIsEnd, vState, vNowTime, vCouponMaxCount
	Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
	snpTitle	= Server.URLEncode("[천원의 기적]")
	snpLink		= Server.URLEncode("http://www.10x10.co.kr/event/eventmain.asp?eventid="&eCode)
	snpPre		= Server.URLEncode("10x10 이벤트")
	snpImg		= Server.URLEncode("http://webimage.10x10.co.kr/eventIMG/2018/90829/banMoList20181130142454.JPEG")


	'// Facebook 오픈그래프 메타태그 작성
	strPageTitle = "[천원의 기적]"
	strPageKeyword = "[천원의 기적]"
	strPageDesc = "지금 하와이 여행 상품권을 1,000원으로 구매할 수 있는\n이벤트에 도전하세요!"
	strPageUrl = "http://www.10x10.co.kr/event/eventmain.asp?eventid="&eCode
	strPageImage = "http://webimage.10x10.co.kr/eventIMG/2018/90829/banMoList20181130142454.JPEG"

	'// 하나의 상품코드로 진행
	Dim miracleProductCode
	miracleProductCode = "2165571"

	Dim userHawaiEventOrderCount
	userHawaiEventOrderCount = 0
	If IsUserLoginOK() Then
		If Trim(miracleProductCode) <> "" Then
			'// 사용자의 해당일자 상품의 결제내역을 확인한다.
			Dim sqlstr
			sqlStr = ""
			sqlStr = sqlStr & " select count(m.userid) from db_order.dbo.tbl_order_master as m " &VBCRLF
			sqlStr = sqlStr & " 	inner join db_order.dbo.tbl_order_detail as d " &VBCRLF
			sqlStr = sqlStr & " 	on m.orderserial=d.orderserial " &VBCRLF
			sqlStr = sqlStr & " 	where m.jumundiv<>'9' and m.ipkumdiv > 3 and m.cancelyn = 'N' " &VBCRLF
			sqlStr = sqlStr & " 	and d.cancelyn<>'Y' and d.itemid<>'0' And m.userid='"&GetEncLoginUserId&"' " &VBCRLF
			sqlStr = sqlStr & " 	and d.itemid='"&miracleProductCode&"' " &VBCRLF
			rsget.Open sqlStr, dbget, 1
			userHawaiEventOrderCount = rsget(0)
			rsget.Close
		End If
	End If
%>
<style type="text/css">
.evt90829 {width:1140px; margin:0 auto;}
.evt90829 .inner {position:relative; height:1266px; background:url(http://webimage.10x10.co.kr/fixevent/event/2018/90829/bg_miracle.jpg) 0 0 no-repeat;}
.evt90829.after .inner {height:971px; background-image:url(http://webimage.10x10.co.kr/fixevent/event/2018/90829/bg_miracle_after.jpg);}
.evt90829.dday .inner {height:1473px; background-image:url(http://webimage.10x10.co.kr/fixevent/event/2018/90829/bg_miracle_dday.jpg);}
.evt90829 .inner h2 {padding-top:126px;}
.evt90829 .bnr-sns {position:absolute; top:-1px; right:38px; width:157px; height:135px; padding-top:75px; box-sizing:border-box; background:url(http://webimage.10x10.co.kr/fixevent/event/2018/90829/btn_sns.png) 0 0 no-repeat;}
.evt90829.dday .bnr-sns {display:none;}
.evt90829 .bnr-sns a {display: inline-block; width:54px; height:36px; text-indent:-9999px;}
.evt90829 .gift {position:absolute; left:236px; top:294px;}
.evt90829.dday .gift {left:315px; top:796px;}
.evt90829 .btn-buy {position:absolute; top:677px; left:377px;}
.evt90829 .btn-buy-after {position:absolute; top:669px; left:343px;}
.evt90829 .deposit {position:absolute; left:423px; bottom:353px;}
.evt90829.after .deposit {bottom:58px;}
.evt90829.dday .deposit {bottom:49px;}
.evt90829 .deposit a {position:absolute; right:-22px; bottom:-12px; width:140px; height:40px; text-indent:-9999px;}
.evt90829 .event {position:absolute; left:230px; bottom:65px;}
.evt90829.after .event, .evt90829.dday .event {display:none;}
.evt90829 .winner {display:none; position:absolute; left:311px; top:1109px; width:513px; height:76px; padding-top:100px; background:url(http://webimage.10x10.co.kr/fixevent/event/2018/90829/txt_winner.jpg?v=1.1) 0 0 no-repeat; font-family:'malgun Gothic','맑은고딕'; font-size:20px; color:#fff; letter-spacing:1px;}
.evt90829.dday .winner {display:block;}
.evt90829 .winner span {display:inline-block; font-weight:300; font-size:28px; color:#ffe5ac;}
.evt90829 .winner b {display:inline-block; font-size:28px;}
.evt90829 .vod {overflow:hidden; margin:25px auto 0; width:454px; height:454px; border:5px solid #acff41; background:#000;}
.evt90829 .vod iframe {vertical-align:top;}
.evt90829 .noti {position:relative; padding:60px 0 60px 290px ; background-color:#0f1c5b;}
.evt90829 .noti strong {position:absolute; top:140px; left:180px;}
.evt90829 .noti li {font:12px/28px 'malgun Gothic','맑은고딕',Dotum,'돋움',sans-serif; color:#e6e7f0; text-align:left;}
.evt90829 .noti li:before {content:'·'; display:inline-block; width:7px;}
.evt90829 .noti li a {margin-left:2px; padding:2px 18px 2px 10px; color:#fff; background-color:#6a00d6; text-decoration:none;}
.evt90829 .noti li a:after {content:'·'; display:inline-block; position:relative; top:13px; left:6px; width:4px; height:4px; transform:rotate(45deg); border-top:1px solid #fff; border-right:1px solid #fff; text-indent:-9999px;}
</style>
<script type="text/javascript">
function snschk(snsnum) {
	if(snsnum == "tw") {
		popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');
	}else if(snsnum=="fb"){
		popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');
	}else if(snsnum=="pt"){
		pinit('<%=snpLink%>','<%=snpImg%>');
	}
}

function TnAddShoppingBag90829(){
	<% If not( left(trim(currenttime),10)>=trim(vEventStartDate) and left(trim(currenttime),10) < trim(DateAdd("d", 1, trim(vEventEndDate))) ) Then %>
		alert("이벤트 응모기간이 아닙니다.");
		return false;
	<% end if %>
	<% If not(IsUserLoginOK) Then %>
		top.location.href="/login/loginpage.asp?vType=G";
		return false;
	<% end if %>
	<% If userHawaiEventOrderCount > 0 Then %>
		alert('고객님께서는 이벤트 상품을 이미 주문하셨습니다.\n한 ID당 최대 1개까지 주문 가능');
		return false;
	<% End If %>
	document.directOrd.submit();
}

function PopupNews90829(){
	var popwin = window.open('/common/news_list.asp?type=03','popupnews', 'width=580,height=800,left=300,top=100,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no');
	popwin.focus();
}
</script>

<%' 90829 천원의 기적3 하와이 상품권 %>
<%' 실제 이벤트 진행기간 동안 보여줄 내용 %>
<% If left(trim(currenttime),10) < trim(DateAdd("d", 1, trim(vEventEndDate))) Then %>
	<div class="evt90829">
<% End If %>

<%' 이벤트 종료 후 당첨자 발표전까지 보여줄 내용 %>
<% If left(trim(currenttime),10)>=trim(vEndEventAfterViewStartDate) and left(trim(currenttime),10) < trim(DateAdd("d", 1, trim(vEndEventAfterViewEndDate))) Then %>
	<div class="evt90829 after">
<% End If %>

<%' 당첨자 발표일날 보여줄 내용 %>
<% If left(trim(currenttime),10)>=trim(vEventConfirmDate) Then %>
	<div class="evt90829 dday">
<% End If %>

	<%' 실제 이벤트 진행기간 동안 보여줄 내용 %>
	<% If left(trim(currenttime),10) < trim(DateAdd("d", 1, trim(vEventEndDate))) Then %>
		<div class="inner">
			<h2><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90829/tit_miracle.png?v=1.0" alt="천원의 기적"></h2>
			<div class="bnr-sns">
				<a href="" onclick="snschk('fb');return false;" alt="페이스북 공유하기">facebook</a>
				<a href="" onclick="snschk('tw');return false;" alt="트위터 공유하기">tweet</a>
			</div>
			<p class="gift"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90829/img_gift.jpg" alt="하와이로 떠날 수 있는 여행 상품권"></p>

			<!-- for dev msg : 버튼 영역 -->
			<a href="" class="btn-buy" onclick="TnAddShoppingBag90829();return false;"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90829/btn_buy.png?v=1.0" alt="구매하러 가기"></a>
			<!-- for dev msg : 발표전 --><span class="btn-buy-after" style="display:none"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90829/btn_buy_after.png?v=1.0" alt="12월 11일을 기다려주세요!"></span>
			
			<div class="deposit"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90829/txt_deposit.png?v=1.0" alt="응모 당첨자 발표 후 당첨이 되지 않은 고객님께는 결제하셨던 1,000원을 예치금으로 돌려드립니다."><a href="/my10x10/myTenCash.asp">예치금이란?</a></div>
			<p class="event"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90829/txt_event.png?v=1.0" alt="응모기간 2018년 12월 03일 ~ 05일"></p>
		</div>
	<% End If %>
	<%'// 실제 이벤트 진행기간 동안 보여줄 내용 %>


	<%' 이벤트 종료 후 당첨자 발표전까지 보여줄 내용 %>
	<% If left(trim(currenttime),10)>=trim(vEndEventAfterViewStartDate) and left(trim(currenttime),10) < trim(DateAdd("d", 1, trim(vEndEventAfterViewEndDate))) Then %>
		<div class="inner">
			<h2><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90829/tit_miracle_after.png?v=1.0" alt="천원의 기적"></h2>
			<p class="gift"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90829/img_gift_after.jpg" alt="하와이로 떠날 수 있는 여행 상품권"></p>
			<span class="btn-buy-after"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90829/btn_buy_after.png?v=1.0" alt="12월 11일을 기다려주세요!"></span>
			<div class="deposit"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90829/txt_deposit.png?v=1.0" alt="응모 당첨자 발표 후 당첨이 되지 않은 고객님께는 결제하셨던 1,000원을 예치금으로 돌려드립니다."><a href="/my10x10/myTenCash.asp">예치금이란?</a></div>
			<p class="event"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90829/txt_event.png?v=1.0" alt="응모기간 2018년 12월 03일 ~ 05일"></p>
		</div>
	<% End If %>
	<%'// 이벤트 종료 후 당첨자 발표전까지 보여줄 내용 %>


 	<%' 당첨자 발표일날 보여줄 내용 %>
	<% If left(trim(currenttime),10)>=trim(vEventConfirmDate) Then %>
		<div class="inner">
			<h2><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90829/tit_miracle_dday.png" alt="천원의 기적"></h2>
			<div class="vod">
				<%'// 동영상 영역 %>
				<iframe src="https://player.vimeo.com/video/305410179" width="454" height="454" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
			</div>
			<p class="gift"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90829/img_gift_dday.jpg?v=1.0" alt="하와이로 떠날 수 있는 여행 상품권"></p>
			<div class="winner">
				<%'// 당첨자 영역 %>
				<span>Vip gold.</span> <b>ykyeakyu**</b>님
			</div>
			<div class="deposit"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90829/txt_deposit.png?v=1.0" alt="응모 당첨자 발표 후 당첨이 되지 않은 고객님께는 결제하셨던 1,000원을 예치금으로 돌려드립니다."><a href="http://www.10x10.co.kr/my10x10/myTenCash.asp">예치금이란?</a></div>
		</div>
	<% End If %>
	<%'// 당첨자 발표일날 보여줄 내용 %>

	<div class="noti">
		<strong><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90829/tit_noti.png" alt="유의사항"></strong>
		<ul>
			<li>본 이벤트는 텐바이텐 회원만 참여할 수 있습니다.</li>
			<li>당첨자에게는 상품에 따라 세무신고에 필요한 개인정보를 요청할 수 있습니다. (제세공과금은 텐바이텐이 부담합니다.)</li>
			<li>본 이벤트의 상품은 즉시 결제로만 구매할 수 있으며, 해당 이벤트에 응모 하신 후 당첨자 발표 이후에는 취소나 환불 처리가 되지 않습니다.</li>
			<li>예치금은 현금 반환 요청이 가능하며, 예치금 현금 반환은 직접 신청이 가능합니다. <a href="/my10x10/myTenCash.asp">예치금이란?</a></li>
			<li>본 이벤트는 ID당 1회만 구매(응모) 가능합니다.</li>
			<li>당첨자는 12월 11일(화) 텐바이텐 이벤트 페이지 및 공지사항에 발표될 예정입니다.</li>
			<li>해당 이벤트의 경품은 모두투어의 여행 상품권으로 진행합니다.</li>
		</ul>
	</div>
</div>
<form method="post" name="directOrd" action="/inipay/shoppingbag_process.asp">
	<input type="hidden" name="itemid" value="<%=miracleProductCode%>">
	<input type="hidden" name="itemoption" value="0000">
	<input type="hidden" name="itemea" value="1">
	<input type="hidden" name="mode" value="DO1">
</form>
<%' // 90829 천원의 기적3 하와이 상품권 %>
<!-- #include virtual="/lib/db/dbclose.asp" -->
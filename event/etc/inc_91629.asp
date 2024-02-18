<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 천원의기적5
' History : 2019-01-10 원승현 
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
	'currenttime = "2019-01-22 오전 10:03:35"

	'// 이벤트 진행기간
	vEventStartDate = "2019-01-14"
	vEventEndDate = "2019-01-16"

	'// 이벤트 종료 후 당첨자 발표전까지 일자
	vEndEventAfterViewStartDate = "2019-01-17"
	vEndEventAfterViewEndDate = "2019-01-21"

	'// 당첨자 발표일자
	vEventConfirmDate = "2019-01-22"

	eCode = "91629"

	'// 소셜서비스로 글보내기
	Dim vTitle, vLink, vPre, vImg, vIsEnd, vState, vNowTime, vCouponMaxCount
	Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
	snpTitle	= Server.URLEncode("[천원의 기적] 이번엔 맥북에어가 천원")
	snpLink		= Server.URLEncode("http://www.10x10.co.kr/event/eventmain.asp?eventid="&eCode)
	snpPre		= Server.URLEncode("10x10 이벤트")
	snpImg		= Server.URLEncode("http://webimage.10x10.co.kr/eventIMG/2018/91629/banMoList20190107144402.JPEG")


	'// Facebook 오픈그래프 메타태그 작성
	strPageTitle = "[천원의 기적] 이번엔 맥북에어가 천원"
	strPageKeyword = "[천원의 기적]"
	strPageDesc = "지금, 맥북에어를 천원에 살 수 있는 기회에 도전해보세요!"
	strPageUrl = "http://www.10x10.co.kr/event/eventmain.asp?eventid="&eCode
	strPageImage = "http://webimage.10x10.co.kr/eventIMG/2018/91629/banMoList20190107144402.JPEG"

	'// 하나의 상품코드로 진행
	Dim miracleProductCode
	miracleProductCode = "2199320"

	Dim useriPadEventOrderCount
	useriPadEventOrderCount = 0
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
			useriPadEventOrderCount = rsget(0)
			rsget.Close
		End If
	End If
%>
<style type="text/css">
.evt91629 .bnr-sns {position:absolute; top:0px; right:38px; width:157px; height:135px; padding-top:75px; box-sizing:border-box; background:url(http://webimage.10x10.co.kr/fixevent/event/2019/91629/btn_sns.png) 0 0 no-repeat;}
.evt91629 .bnr-sns a {display: inline-block; width:54px; height:36px; text-indent:-9999px;}
.evt91629 .txt-winner {position:absolute; top:341px; right:298px; -webkit-border-radius:50%; border-radius:50%; -webkit-box-shadow:15px 15px 43px rgba(77,7,195,0.64); box-shadow:15px 15px 43px rgba(77,7,195,0.64); animation:bounce 1.5s linear infinite;}
@keyframes bounce { 0%{transform:translateY(0px);} 50%{transform:translateY(10px);} 100%{transform:translateY(0px);} }
.evt91629 map area {outline:0;}
.evt91629 .vod {overflow:hidden; position:absolute; top:306px; left:343px; width:454px; height:454px; background-color:#000;}
.evt91629 .winner {position:absolute; left:550px; top:935px; text-align:left; font-family:'malgun Gothic','맑은고딕'; font-size:18px; color:#fff; letter-spacing:1px;}
.evt91629 .winner li + li {margin-top:6px;}
.evt91629 .winner b {display:inline-block; font-weight:400; font-size:22px;}
.evt91629 .winner span {display:inline-block; width: 96px; margin-right:10px; font-weight:300; font-size:20px; color:#fff600;}
.evt91629 .noti {position:relative; padding:60px 0 60px 260px ; background-color:#0f1c5b;}
.evt91629 .noti strong {position:absolute; top:140px; left:130px;}
.evt91629 .noti li {font:12px/28px 'malgun Gothic','맑은고딕',Dotum,'돋움',sans-serif; color:#e6e7f0; text-align:left;}
.evt91629 .noti li:before {content:'·'; display:inline-block; width:7px;}
.evt91629 .noti li a {margin-left:2px; padding:2px 18px 2px 10px; color:#fff; background-color:#6a00d6; text-decoration:none;}
.evt91629 .noti li a:after {content:'·'; display:inline-block; position:relative; top:13px; left:6px; width:4px; height:4px; transform:rotate(45deg); border-top:1px solid #fff; border-right:1px solid #fff; text-indent:-9999px;}
.evt91629 .bnr-event {margin-top:3px;}
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

function TnAddShoppingBag91629(){
	<% If not( left(trim(currenttime),10)>=trim(vEventStartDate) and left(trim(currenttime),10) < trim(DateAdd("d", 1, trim(vEventEndDate))) ) Then %>
		alert("이벤트 응모기간이 아닙니다.");
		return false;
	<% end if %>
	<% If not(IsUserLoginOK) Then %>
		top.location.href="/login/loginpage.asp?vType=G";
		return false;
	<% end if %>
	<% If useriPadEventOrderCount > 0 Then %>
		alert('고객님께서는 이벤트 상품을 이미 주문하셨습니다.\n한 ID당 최대 1개까지 주문 가능');
		return false;
	<% End If %>
	document.directOrd.submit();
}

function PopupNews91629(){
	var popwin = window.open('/common/news_list.asp?type=03','popupnews', 'width=580,height=800,left=300,top=100,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no');
	popwin.focus();
}
</script>

<%' 91629 천원의 기적5 맥북에어 %>
<div class="evt91629">
    <div class="inner">
        <%' 실제 이벤트 진행기간 동안 보여줄 내용 %>
        <% If left(trim(currenttime),10) < trim(DateAdd("d", 1, trim(vEventEndDate))) Then %>
            <h2><img src="http://webimage.10x10.co.kr/fixevent/event/2019/91629/tit_miracle.png" alt="천원의 기적"></h2>
            <div class="bnr-sns">
                <a href="" onclick="snschk('fb');return false;" title="페이스북 공유하기">facebook</a>
                <a href="" onclick="snschk('tw');return false;" title="트위터 공유하기">twitter</a>
            </div>
            <p><img src="http://webimage.10x10.co.kr/fixevent/event/2019/91629/img_event.jpg" alt="이벤트 상세" usemap="#event"></p>
            <span class="txt-winner"><img src="http://webimage.10x10.co.kr/fixevent/event/2019/91629/txt_winner.png" alt="당첨자 3명" /></span>
            <map name="event">
                <area shape="rect" coords="280,40,860,560" href="" onclick="TnAddShoppingBag91629();return false;" alt="구매하러 가기" title="구매하러 가기" />
                <area shape="rect" coords="640,650,770,700" href="/my10x10/myTenCash.asp" target="_self" alt="예치금이란?" title="예치금이란?" />
            </map>
        <% End If %>
        <%'// 실제 이벤트 진행기간 동안 보여줄 내용 %>

        <%' 이벤트 종료 후 당첨자 발표전까지 보여줄 내용 %>
        <% If left(trim(currenttime),10)>=trim(vEndEventAfterViewStartDate) and left(trim(currenttime),10) < trim(DateAdd("d", 1, trim(vEndEventAfterViewEndDate))) Then %>
            <h2><img src="http://webimage.10x10.co.kr/fixevent/event/2019/91629/tit_miracle_after.png" alt="천원의 기적"></h2>
            <p><img src="http://webimage.10x10.co.kr/fixevent/event/2019/91629/img_after.jpg" alt="1월 22일을 기다려주세요!" usemap="#after"></p>
            <span class="txt-winner"><img src="http://webimage.10x10.co.kr/fixevent/event/2019/91629/txt_winner.png" alt="당첨자 3명" /></span>
            <map name="after">
                <area shape="rect" coords="648,627,752,677" href="/my10x10/myTenCash.asp" target="_self" alt="예치금이란?" title="예치금이란?" />
            </map>
        <% End If %>
        <%'// 이벤트 종료 후 당첨자 발표전까지 보여줄 내용 %>

        <%' 당첨자 발표일날 보여줄 내용 %>
        <% If left(trim(currenttime),10)>=trim(vEventConfirmDate) Then %>
            <h2><img src="http://webimage.10x10.co.kr/fixevent/event/2019/91629/tit_miracle_dday.png" alt="천원의 기적"></h2>
            <p><img src="http://webimage.10x10.co.kr/fixevent/event/2019/91629/img_dday.jpg" alt="MacBook Air 당첨자" usemap="#dday"></p>
            <div class="vod">
                <%'// 동영상 영역 %>
                <iframe src="https://player.vimeo.com/video/312053666" width="454" height="454" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
            </div>
            <ul class="winner">
                <%'// 당첨자 영역 %>
				<li><span>RED</span> <b>llollol***</b>님</li>
				<li><span>VIP</span> <b>kwmzxc1234***</b>님</li>
				<li><span>WHITE</span> <b>ghghc***</b>님</li>
            </ul>
            <map name="dday">
                <area shape="rect" coords="634,933,760,983" href="/my10x10/myTenCash.asp" target="_self" alt="예치금이란?" title="예치금이란?" />
            </map>
        <% End If %>
        <%'// 당첨자 발표일날 보여줄 내용 %>
    </div>

    <%' 유의사항 (공통) %>
    <div class="noti">
        <strong><img src="http://webimage.10x10.co.kr/fixevent/event/2019/91629/tit_noti.png" alt="유의사항"></strong>
        <ul>
            <li>본 이벤트는 텐바이텐 회원만 참여할 수 있습니다.</li>
            <li>당첨자에게는 상품에 따라 세무신고에 필요한 개인정보를 요청할 수 있습니다. (제세공과금은 텐바이텐이 부담합니다.)</li>
            <li>본 이벤트의 상품은 즉시 결제로만 구매할 수 있으며, 해당 이벤트에 응모 하신 후 당첨자 발표 이후에는 취소나 환불 처리가 되지 않습니다.</li>
            <li>예치금은 현금 반환 요청이 가능하며, 예치금 현금 반환은 직접 신청이 가능합니다. <a href="http://www.10x10.co.kr/my10x10/myTenCash.asp">예치금이란?</a></li>
            <li>본 이벤트는 ID당 1회만 구매(응모) 가능합니다.</li>
            <li>당첨자는 01월 22일(화) 이벤트 페이지 및 공지사항에 발표될 예정입니다.</li>
            <li>당첨 상품 정보 : MacBook Air 13형(1.6GHz 듀얼 코어 8세대 Intel Core i5 프로세서, 128GB 저장용량, 실버 컬러)</li>
        </ul>
	</div>

	<%' 관련이벤트 (공통) %>
	<div class="bnr-event">
		<img src="http://webimage.10x10.co.kr/fixevent/event/2019/91629/bnr_event.png" usemap="#map-evt"alt="">
		<map name="map-evt" id="map-evt">
			<area  alt="이번 설에는 꼭 하고 싶은말 선물, 말" title="이번 설에는 꼭 하고 싶은말 선물, 말" href="/event/eventmain.asp?eventid=91396" shape="rect" coords="0,0,569,119" onfocus="this.blur();" />
			<area  alt="지금 가장 핫한 리빙 띵템! Living Best item" title="지금 가장 핫한 리빙 띵템! Living Best item" href="/event/eventmain.asp?eventid=91467" shape="rect" coords="569,0,1139,119" onfocus="this.blur();" />
		</map>
	</div>
</div>
<form method="post" name="directOrd" action="/inipay/shoppingbag_process.asp">
	<input type="hidden" name="itemid" value="<%=miracleProductCode%>">
	<input type="hidden" name="itemoption" value="0000">
	<input type="hidden" name="itemea" value="1">
	<input type="hidden" name="mode" value="DO1">
</form>
<%' // 91629 천원의 기적5 맥북에어 %>
<!-- #include virtual="/lib/db/dbclose.asp" -->
<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 츄삐의 여름 휴가 계획 세우기(쿠폰이벤트)
' History : 2019-06-25 최종원
'####################################################
%>
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%

dim eCode, userid, couponIdx
IF application("Svr_Info") = "Dev" THEN
	eCode = "90321"
	couponIdx = "2903"
Else
	eCode = "95898"
	couponIdx = "1174"
End If
userid = GetEncLoginUserID()

dim eventEndDate, currentDate, eventStartDate
dim subscriptcount, totalsubscriptcount 
dim evtinfo : evtinfo = getEventDate(eCode)

if not isArray(evtinfo) then
	Call Alert_Return("잘못된 이벤트번호입니다.")
	dbget.close()	:	response.End
end if

'변수 초기화
eventStartDate = cdate(evtinfo(0,0))
eventEndDate = cdate(evtinfo(1,0))
currentDate = date()
'currentDate = Cdate("2019-05-04")
eventStartDate = cdate("2019-05-10")
%>
<style type="text/css">
.serise {background-color:#fff;}
.serise .inner {position:relative; width:1140px; height:60px; margin:0 auto; padding-top:15px; text-align:left;}
.serise .inner h2 {position:absolute; left:50%; top:18px; margin-left:-30px;}
.serise .inner iframe {position:absolute; right:0; top:0;}
.serise .inner .btn-cmt {position:absolute; top:110px; left:0; z-index:10;}
.vod-wrap {position:relative; height:855px; background:#fff663 url(//webimage.10x10.co.kr/fixevent/event/2019/95898/bg_daccu.jpg) no-repeat 50% 0;}
.vod-wrap h3 {position:absolute; visibility:hidden; font-size:0;}
.vod-wrap .vod {padding-top:337px;}
.vod-wrap iframe {vertical-align:top;}
.bnr-coupon {position:fixed; top:395px; left:50%; z-index:50; margin-left:415px;}
.diaryVod map area {outline:0;}
</style>
<script type="text/javascript">
function jsDownCoupon(stype,idx){
	<% if Not(IsUserLoginOK) then %>
		jsEventLogin();
	<% else %>
	$.ajax({
		type: "post",
		url: "/shoppingtoday/act_couponshop_process.asp",
		data: "idx="+idx+"&stype="+stype,
		cache: false,
		success: function(message) {
			if(typeof(message)=="object") {
				if(message.response=="Ok") {
					alert("쿠폰이 발급되었습니다.\n마이텐바이텐에서 쿠폰을 확인해주세요!")
				} else {
					alert(message.message);
				}
			} else {
				alert("처리중 오류가 발생했습니다.");
			}
		},
		error: function(err) {
			console.log(err.responseText);
		}
	});
	<% end if %>
}

function jsEventLogin(){
	if(confirm("로그인을 하셔야 쿠폰을 다운받으실수 있습니다.")){
		location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
		return;
	}
}
</script>
<div class="diaryVod evt95898">
	<div class="serise">
		<div class="inner">
			<p><a href="/diarystory2019/"><img src="//webimage.10x10.co.kr/fixevent/event/2018/89423/logo_2019diary.png" alt="2019 DIARY STORY"></a></p>
			<h2><img src="//webimage.10x10.co.kr/fixevent/event/2018/89817/tit_daccu.png" alt="다꾸채널"></h2>
			<iframe frameborder="0" scrolling="no" src="/event/etc/group/iframe_diaryvod.asp?eventid=95898" width="271" height="75" title="PLAY YOUR DIARY" allowTransparency="true"></iframe>
		</div>
	</div>
	<div class="vod-wrap">
		<h3>텐플루언서 보쨘's 상큼달큼 다꾸의 정석!</h3>
		<div class="vod">
			<iframe width="750" height="450" src="https://www.youtube.com/embed/82b8INw5RZw" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
		</div>
	</div>
	<p><img src="//webimage.10x10.co.kr/fixevent/event/2019/95898/txt_artist.jpg" alt="유튜버 보쨘"></p>
	<p><img src="//webimage.10x10.co.kr/fixevent/event/2019/95898/img_items.jpg" alt="SELECT ITEMS" usemap="#items"></p>
	<map name="items">
		<area shape="rect" coords="50,100,250,400" href="/shopping/category_prd.asp?itemid=2312151&pEtr=95898" alt="JUJUBE O-ssum for deco 8종">
		<area shape="rect" coords="260,100,460,400" href="/shopping/category_prd.asp?itemid=2125874&pEtr=95898" alt="LEEGONG 사각사각 메모지">
		<area shape="rect" coords="470,100,670,400" href="/shopping/category_prd.asp?itemid=2369957&pEtr=95898" alt="메종드알로하 Big Heart Sticker">
		<area shape="rect" coords="680,100,880,400" href="/shopping/category_prd.asp?itemid=2268759&pEtr=95898" alt="데일리라이크 리무버 스티커">
		<area shape="rect" coords="890,100,1090,400" href="/shopping/category_prd.asp?itemid=2240911&pEtr=95898" alt="루카랩 A5 육공 리필 속지 타일 노트">
	</map>
	<!-- 쿠폰 -->
	<%'<!-- for dev msg : 플로팅 배너 클릭시 쿠폰 1174 지급'마이텐바이텐에서 쿠폰을 확인해주세요!' 얼럿2019-07-24 (수) 00:00:00 ~ 2019-08-06 (화) 23:59:59 동안만 노출 -->%>
	<% if date() <= Cdate("2019-08-20") then %>
	<a href="javascript:jsDownCoupon('event','<%=couponIdx%>')" class="bnr-coupon"><img src="//webimage.10x10.co.kr/fixevent/event/2019/95898/bnr_coupon.png" alt="보쨘 쿠폰"></a>
	<% end if %>
	<div class="noti"><img src="//webimage.10x10.co.kr/fixevent/event/2019/95898/txt_noti.jpg" alt="유의사항"></div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->
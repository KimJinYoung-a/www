<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 다꾸TV 4편 인스타그래머 나키의 다이어리꾸미기(쿠폰이벤트)
' History : 2019-08-20 김송이
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
	eCode = "90372"
	couponIdx = "2903"
Else
	eCode = "96769"
	couponIdx = "1189"
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
.vod-wrap {position:relative; height:855px; background:#f5d485 url(//webimage.10x10.co.kr/fixevent/event/2019/96769/bg_daccu.jpg) no-repeat 50% 0;}
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
<div class="diaryVod evt96769">
    <div class="serise">
        <div class="inner">
            <p><a href="/diarystory2019/"><img src="//webimage.10x10.co.kr/fixevent/event/2018/89423/logo_2019diary.png" alt="2019 DIARY STORY"></a></p>
            <h2><img src="//webimage.10x10.co.kr/fixevent/event/2018/89817/tit_daccu.png" alt="다꾸채널"></h2>
            <iframe frameborder="0" scrolling="no" src="/event/etc/group/iframe_diaryvod.asp?eventid=96769" width="271" height="75" title="PLAY YOUR DIARY" allowTransparency="true"></iframe>
        </div>
    </div>
    <div class="vod-wrap">
        <h3>텐플루언서 나키’s 감성 가득한 다꾸는 이렇게!</h3>
        <div class="vod">
            <iframe width="750" height="450" src="https://www.youtube.com/embed/Zi7C6WuImXE" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
        </div>
    </div>
    <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/96769/txt_artist.jpg" alt="유튜버 나키"></p>
    <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/96769/img_items.jpg" alt="SELECT ITEMS" usemap="#items"></p>
    <map name="items">
        <area shape="rect" coords="50,100,250,400" href="/shopping/category_prd.asp?itemid=2328829&pEtr=96769" alt="Plain note 103 : grid note">
        <area shape="rect" coords="260,100,460,400" href="/shopping/category_prd.asp?itemid=1148996&pEtr=96769" alt="STAMPMAMA Vintage Book Pages">
        <area shape="rect" coords="470,100,670,400" href="/shopping/category_prd.asp?itemid=2257070&pEtr=96769" alt="SPLICE STAMp BSS-001002">
        <area shape="rect" coords="680,100,880,400" href="/shopping/category_prd.asp?itemid=1027391&pEtr=96769" alt="타자체 알파벳  소문자 세트">
        <area shape="rect" coords="890,100,1090,400" href="/shopping/category_prd.asp?itemid=1643953&pEtr=96769" alt="촉촉한 pigment inkpad Fog">
    </map>
    <!-- 쿠폰 -->
    <% if date() <= Cdate("2019-09-03") then %>
    <a href="javascript:jsDownCoupon('event','<%=couponIdx%>')" class="bnr-coupon"><img src="//webimage.10x10.co.kr/fixevent/event/2019/96769/bnr_coupon.png" alt="나키 쿠폰"></a>
    <% end if %>
    <div class="noti"><img src="//webimage.10x10.co.kr/fixevent/event/2019/96769/txt_noti.jpg" alt="유의사항"></div>
</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->
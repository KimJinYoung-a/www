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
	eCode = "95779"
	couponIdx = "1169"
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
.vod-wrap {position:relative; padding-bottom:69px; background:#ffa3bb url(http://webimage.10x10.co.kr/fixevent/event/2019/95779/bg_diary_vod.jpg) no-repeat 50% 0;}
.vod-wrap .vod1 {height:450px; margin-top:49px;}
.bnr-coupon {position:fixed; top:395px; left:50%; z-index:10; z-index:50; margin-left:418px;}
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
                    <div class="diaryVod evt95779">
                        <div class="serise">
                            <div class="inner">
                                <p><a href="/diarystory2019/"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/89423/logo_2019diary.png" alt="2019 DIARY STORY" /></a></p>
                                <h2><img src="http://webimage.10x10.co.kr/fixevent/event/2018/89817/tit_daccu.png" alt="다꾸채널" /></h2>
                                <iframe frameborder="0" scrolling="no" src="/event/etc/group/iframe_diaryvod.asp?eventid=95779" width="271" height="75" title="PLAY YOUR DIARY" allowTransparency="true"></iframe>
                            </div>
                        </div>
                        <div class="vod-wrap">
                            <h3><img src="http://webimage.10x10.co.kr/fixevent/event/2019/95779/tit_diary_vod.jpg" alt="텐플루언서 밥팅’s 핑크 다꾸의 모든 것!" /></h3>
                            <div class="vod1">
                                <iframe width="750" height="450" src="https://www.youtube.com/embed/kfZQuV7Q2MI" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
                            </div>
                        </div>
                        <p><img src="http://webimage.10x10.co.kr/fixevent/event/2019/95779/tit_artist.jpg" alt="밥팅" /></p>
                        <div>
                            <img src="http://webimage.10x10.co.kr/fixevent/event/2019/95779/img_select_item.jpg" alt="select items" usemap="#map_item" />
                        </div>
                        <map name="map_item">
                            <area alt="루카랩 A5 하드 육공 모눈 노트" href="javascript:TnGotoProduct('2268480');" coords="53,111,255,380" shape="rect" onfocus="this.blur();">
                            <area alt="텐텐문방구 A5 컬러 Half 리필속지" href="javascript:TnGotoProduct('2111471');" coords="461,380,260,112" shape="rect" onfocus="this.blur();">
                            <area alt="스탠다드러브댄스 메모패드_핑크가든" href="javascript:TnGotoProduct('2381233');" coords="465,112,674,380" shape="rect" onfocus="this.blur();">
                            <area alt="비온뒤 마스킹테이프" href="javascript:TnGotoProduct('2014296');" coords="677,113,885,380" shape="rect" onfocus="this.blur();">
                            <area alt="메종드알로하 Check Heart Sticker" href="javascript:TnGotoProduct('2369958');" coords="889,113,1092,380" shape="rect" onfocus="this.blur();">
                        </map>
                        <!-- 쿠폰 -->                        
						<% if date() <= Cdate("2019-07-23") then %>
                        <a href="javascript:jsDownCoupon('event','<%=couponIdx%>')" class="bnr-coupon"><img src="http://webimage.10x10.co.kr/fixevent/event/2019/95779/bnr_coupon.png" alt="영상을 본 분들께 드리는 밥팅!" /></a>
						<% end if %>
                        <div class="noti"><img src="http://webimage.10x10.co.kr/fixevent/event/2019/95779/txt_noti.jpg" alt="해당 이벤트 내 '밥팅 쿠폰’은  3만 원 구매 시, 2,000원 할인 쿠폰이며, 2019년 7월 23일까지 사용 가능합니다. 이벤트는 내부 사정으로 인하여 조기 종료될 수 있습니다." /></div>
                    </div>
<!-- #include virtual="/lib/db/dbclose.asp" -->
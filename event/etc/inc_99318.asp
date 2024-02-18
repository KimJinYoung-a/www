<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : MD 기획전 리틀히어로 브랜드 쿠폰
' History : 2019-12-20 원승현
'####################################################
%>
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%

dim eCode, userid
IF application("Svr_Info") = "Dev" THEN
	eCode = "90449"
Else
	eCode = "99318"
End If

userid = GetEncLoginUserID()

dim eventEndDate, currentDate, eventStartDate
dim subscriptcount  
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
'// STAFF 아이디는 테스트를 위해 시작일을 테스트 일자로 부터 시작하게 변경
If GetLoginUserLevel() = "7" Then
    eventStartDate = cdate("2019-12-12")
End If
%>
<style>
.evt99318 {overflow:hidden; position:relative; background:#fff;}
.evt99318 .topic {height:1133px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/99318/bg_topic.jpg) 50% 0 no-repeat;}
.evt99318 .topic h2 {font-size:0; color:transparent;}
.evt99318 .slider {overflow:hidden; left:50%; width:1920px; height:705px; margin-left:-960px;}
.evt99318 .slider .slick-slide {width:1140px;}
.evt99318 .slider .slick-arrow {top:0; width:390px; height:705px; background:rgba(0,0,0,0.3);}
.evt99318 .slider .slick-prev {left:0;}
.evt99318 .slider .slick-next {right:0;}
.evt99318 .point {position:relative; height:1264px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/99318/txt_point.jpg) 50% 0 no-repeat;}
.evt99318 .btn-coupon {position:absolute; bottom:120px; right:50%; margin-right:-360px; width:345px; height:200px; font-size:0; color:transparent; background:none;}
.evt99318 .last {height:270px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/99318/txt_last.jpg) 50% 0 no-repeat;}
</style>
<script type="text/javascript" src="/event/etc/json/js_applyItemInfo.js"></script>
<script type="text/javascript">
$(function(){
	$('.evt99318 .slider').slick({
		autoplay: true,
		autoplaySpeed: 2500,
		speed: 1500,
		centerMode: true,
		centerPadding: '0px',
		variableWidth: true
	});
});

function jsDownCoupon(cType){
	<% if not (currentDate >= eventStartDate and currentDate <= eventEndDate) then %>	
		alert("이벤트 참여기간이 아닙니다.");
		return false;
    <% end if %>
    
    <% if Not(IsUserLoginOK) then %>
        jsEventLogin();
    <% else %>
        $.ajax({
            type: "post",
            url: "/event/etc/doeventsubscript/doEvenSubscript99318.asp",		
            data: {
                eCode: '<%=eCode%>',
                couponType: cType
            },
            cache: false,
            success: function(resultData) {
                fnAmplitudeEventMultiPropertiesAction('click_coupon_btn','evtcode|couponType','<%=eCode%>|'+cType)
                var reStr = resultData.split("|");				
                
                if(reStr[0]=="OK"){		
                    alert('쿠폰이 발급 되었습니다.\n주문시 사용 가능합니다.');
                }else{
                    var errorMsg = reStr[1].replace(">?n", "\n");
                    alert(errorMsg);					
                }			
            },
            error: function(err) {
                console.log(err.responseText);
            }
        });
    <% end if %>
}

function jsEventLogin(){
	if(confirm("로그인을 하셔야 쿠폰을 발급 받으실 수 있습니다.")){
		location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
		return;
	}
}
</script>

<%' 99318 브라운 소방관 %>
<div class="evt99318">
    <div class="topic">
        <h2>브라운 소방관이 지켜주는 우리집</h2>
    </div>
    <div class="slider">
        <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/99318/img_slide_01.jpg" alt=""></div>
        <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/99318/img_slide_02.jpg" alt=""></div>
        <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/99318/img_slide_03.jpg" alt=""></div>
        <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/99318/img_slide_04.jpg" alt=""></div>
    </div>
    <%' for dev msg : 쿠폰코드 1280 %>
    <div class="point"><button type="button" class="btn-coupon" onclick="jsDownCoupon('cLittleHero');return false;">쿠폰 다운받기</button></div>
    <div class="last"></div>
</div>
<%' // 99318 브라운 소방관 %>
<!-- #include virtual="/lib/db/dbclose.asp" -->
<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 텐바이텐X인플루언서
' History : 2020-07-03 김송이
'###########################################################
' UI 개발 가이드
'###########################################################
' <button onclick="jsDownCustomCoupon();"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97856/m/btn_tencpu.jpg" alt="쿠폰 등록"></button>
' ㄴ 버튼에 스크립트 추가
' <input id="couponname" type="text" placeholder="쿠폰명을 입력해주세요!">
' ㄴ 쿠폰명 입력 부분 input id="couponname" 네이밍 그대로 써주세요
' dim eCode : eCode = chkiif(application("Svr_Info") = "Dev","90412","100761")
' ㄴ 이벤트 코드 설정 ex) 90412 - 테스트이벤트코드 , 100761 - 실서버이벤트코드 (2가지 각각 이벤트 코드 생성후 변경)
'###########################################################
%>
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim eCode : eCode = chkiif(application("Svr_Info") = "Dev","104327","110069")
%>
<style>
.tenten-cpn {position:relative; max-width:1920px; margin:0 auto;}
.tenten-cpn .topic {position:relative; height:838px; padding-top:74px; background:#52e5e3 url(//webimage.10x10.co.kr/fixevent/event/2021/110069/bg_top.jpg) 50% 0; box-sizing:border-box;}
.tenten-cpn .topic h2 {position:relative; width:440px; height:168px; margin:0 auto 35px; padding-top:43px; box-sizing:border-box;}
.tenten-cpn .topic .t1,
.tenten-cpn .topic .t2 {position:absolute; top:10px; left:0; animation:rotateAni 1s 30 forwards; transform-origin:50% 100%;}
.tenten-cpn .topic .t2 {top:0; left:145px; animation-delay:-.5s;}
.tenten-cpn .coupon {position:relative;}
.tenten-cpn .coupon #couponname {position:absolute; top:265px; left:50%; width:350px; height:82px; margin-left:-181px; text-align:center; font-size:21px; letter-spacing:-1px; border:solid 5px #b0f40c; border-radius:6px;}
.tenten-cpn .btn-cpn {position:absolute; top:407px; left:50%; width:460px; height:90px; margin-left:-230px; font-size:0; color:transparent; background:none;}
.tenten-cpn .link-area {position:relative; background:#fff0c6;}
.tenten-cpn .link-area a {display:inline-block; width:550px; height:140px; position:absolute; left:50%; top:196px; transform:translate(-50%,0);}
.tenten-cpn .howto {position:relative; background-color:#ffe294;}
.tenten-cpn .howto:before,
.tenten-cpn .howto:after {display:block; position:absolute; top:90px; left:50%; width:109px; height:486px; background-color:#fff; border-radius:17px 0 0 17px; content:'';}
.tenten-cpn .howto:before {margin-left:-679px;}
.tenten-cpn .howto:after {right:-109px; margin-left:570px; border-radius: 0 17px 17px 0;}
.tenten-cpn .noti {background:#444444;}
.tenten-cpn .banner-list01 {background:#f44049;}
.tenten-cpn .banner-list02 {background:#7b40f4;}
@keyframes rotateAni {
	0%,100% {transform:rotate(0deg);}
	50% {transform:rotate(-20deg);}
}
</style>
<%'!-- MKT 텐X텐 쿠폰 --%>
<div class="evt110069 tenten-cpn">
    <div class="topic">
        <h2>
            <span class="t1"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110069/img_tenten.png" alt="텐바이텐"></span>
            <span class="t2"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110069/img_shopper.png" alt="텐텐쇼퍼"></span>
            <span calss="t3"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110069/tit_coupon.png" alt="텐X텐 쿠폰"></span>
        </h2>
        <div class="coupon">
            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110069/txt_coupon.png" alt="할인쿠폰">
            <input type="text" id="couponname" placeholder="쿠폰코드를 입력해주세요!">
            <button type="button" onclick="jsDownCustomCoupon();" class="btn-cpn">쿠폰 발급 받기</button>
        </div>
    </div>
    <div class="howto"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110069/txt_howto.jpg" alt="쿠폰 등록 방법"></div>
    <div class="link-area">
        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110069/img_link.jpg" alt="봄 정기세일 에서 알차게 쿠폰 쓰자!">
        <a href="/event/eventmain.asp?eventid=110211"></a>
    </div>
    <div class="noti"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110069/txt_noti.jpg" alt="이벤트 유의사항"></p></div>
</div>
<%'!--// MKT 텐X텐 쿠폰 --%>
<script type="text/javascript">
function jsDownCustomCoupon(){
	<% if Not(IsUserLoginOK) then %>
		jsEventLogin();
	<% else %>	
	$.ajax({
		type: "post",
		url: "/event/etc/coupon/shopper/couponprocess.asp",				
		data: {
			couponname : $("#couponname").val(),
			eventid : <%=eCode%>
		},
		cache: false,
		success: function(resultData) {			
			var reStr = resultData.split("|");				
			if(reStr[0]=="OK"){		
				fnAmplitudeEventMultiPropertiesAction('click_custom_coupon_btn','evtcode|couponname','<%=eCode%>|'+$("#couponname").val());
				alert('5,000원 할인 쿠폰이 지급되었습니다!');
			}else if(reStr[0]=="ERR"){
				var errorMsg = reStr[1].replace(">?n", "/n");
				alert(errorMsg);										
			}			
		},
		error: function(err) {
			console.log(err.responseText);
		}
	});
	<% end if %>
	$('#couponname').val('');
}

function jsEventLogin(){
	if(confirm("로그인을 하셔야 쿠폰을 다운받으실수 있습니다.")){
		location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
		return;
	}
}
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->
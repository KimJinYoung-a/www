<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 텐x텐 쿠폰 이벤트
' History : 2019-10-11
'####################################################
%>
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode = "90412"  
Else
	eCode = "97856"
End If
%>
<style>
.evt97856,.evt97856 > div {position: relative; text-align: center;}
.evt97856 .img-bg {position: relative; display: block; left: 50%; width: 1920px; margin-left: -960px;}
.evt97856 .topic {height: 861px; background: #ff4889 url(//webimage.10x10.co.kr/fixevent/event/2019/97856/tit_tencpu.jpg) no-repeat center top;}
.evt97856 .topic .motion {position: absolute; top: 70px; left: 50%; margin-left: -217px;}
.evt97856 .topic .motion span {display: inline-block; vertical-align: top; transform: scale(0); animation: scale1 both .55s cubic-bezier(0.18, 0.89, 0.32, 1.28)}
.evt97856 .topic .motion span.ani1 {margin: 10px; transform-origin: 100% 100%;}
.evt97856 .topic .motion span.ani2 {animation-delay: .5s; transform-origin: 0% 100%;}
.evt97856 .topic .inputbox {position: absolute; bottom: 240px; left: 50%; transform: translateX(-50%); }
.evt97856 .topic .inputbox input {padding: 20px 10px; border: 0; font-size: 22px; text-align: center; }
.evt97856 .topic .inputbox input:focus::-webkit-input-placeholder {opacity: 0;} 
.evt97856 .topic button {position: absolute; bottom: 96px; left: 50%; transform: translateX(-50%); background: none;}
.evt97856 .tencpn_guide {height: 570px; background-color: #ffc6d2;}
.evt97856 .tencpn_guide .motion2 {position: absolute; bottom: 136px; left: 50%; margin-left: -385px;}
.evt97856 .tencpn_guide .motion2 .typed { color: #222; font-size: 16px; white-space: nowrap; overflow: hidden; width: 0; font-family: 'Noto Sans KR','malgun Gothic','맑은고딕',sans-serif; text-align: left; animation: typed 3s steps(20, end) infinite;}
.evt97856 .tencpn_noti {background-color: #444;}
@keyframes scale1{to {transform: scale(1);}} 
@keyframes typed{40%,to {width:140px}} 
</style>
<script type="text/javascript">
function jsDownCustomCoupon(){
	<% if Not(IsUserLoginOK) then %>
		jsEventLogin();
	<% else %>	
	$.ajax({
		type: "post",
		url: "/event/etc/doeventsubscript/doEventSubscript97856.asp",				
		data: {
			couponname: $("#couponname").val()		
		},
		cache: false,
		success: function(resultData) {			
			var reStr = resultData.split("|");				
			if(reStr[0]=="OK"){		
                fnAmplitudeEventMultiPropertiesAction('click_custom_coupon_btn','evtcode|couponname','<%=eCode%>|'+$("#couponname").val());
                alert('4,000원 할인 쿠폰이 지급되었습니다!');
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
}

function jsEventLogin(){
	if(confirm("로그인을 하셔야 쿠폰을 다운받으실수 있습니다.")){
		location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
		return;
	}
}
</script>       

<!-- MKT_97856_텐X텐쿠폰 -->
<div class="evt97856">
    <div class="topic">
        <div class="motion">
            <span class="ani1"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97856/tit_ani_1.png" alt="텐바이텐"></span>
            <span class="ani2"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97856/tit_ani_2.png" alt="텐텐쇼퍼"></span>
        </div>
        <span class="inputbox"><input id="couponname" type="text" placeholder="쿠폰명을 입력해주세요!"></span>
        <button onclick="jsDownCustomCoupon();"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97856/btn_tencpn.png" alt="쿠폰 등록"></button>
    </div>
    <div class="tencpn_guide">
        <div class="img-bg"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97856/img_guide.jpg" alt="쿠폰등록방법"></div>
        <span class="motion2"><p class="typed">텐바이텐 18주년</p></span>
    </div>
    <div class="tencpn_noti"><span class="img-bg"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97856/txt_noti.jpg" alt="유의사항"></span></div>
</div>
<!--// MKT_97856_텐X텐쿠폰 -->
<!-- #include virtual="/lib/db/dbclose.asp" -->
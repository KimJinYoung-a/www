<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  카테고리쿠폰 89454
' History : 2018-09-21 최종원 
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim eCode, couponIdx

IF application("Svr_Info") = "Dev" THEN
	eCode = "89173"
	couponIdx = "2890,2891,2892,2893"
Else
	eCode = "89454"
	couponIdx = "1084,1085,1086,1087"
End If


%>
<style type="text/css">
.evt89454 .coupon {position:relative}
.evt89454 .coupon > a {position:absolute;bottom:90px;left:calc(50% - 205px)}
.layer-popup {display:none; position:absolute; left:0; top:0; z-index:9997; width:100%; height:100%;}
.layer-popup .layer {overflow:hidden; position:absolute;z-index:99999;}
.layer-popup .mask {display:block; position:absolute; left:0; top:0; z-index:9998; width:100%; height:100%; background:rgba(0,0,0,.7);}
#lyrSch .layer {top:160px; left:calc(50% - 225px); width:450px; background-color:#fff2c4; border-radius:16px;padding:63px 0 43px;}
#lyrSch .layer p{margin:0 auto 30px}
#lyrSch .layer a{margin:auto}
</style>
<script type="text/javascript">
$(function() {
	// 레이어 닫기
	$('.layer-popup .btn-close').click(function(){
		$('.layer-popup').fadeOut();
	});
	$('.layer-popup .mask').click(function(){
		$('.layer-popup').fadeOut();
	});
});
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
					$('#lyrSch').fadeIn();
					window.parent.$('html,body').animate({scrollTop:$('#lyrSch').offset().top}, 800);				
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
                        <!-- 쿠폰쓰고시퐁 -->
						<div class="evt89454">
							<h2><img src="http://webimage.10x10.co.kr/fixevent/event/2018/89454/tit-top.png" alt="쿠폰 쓰고시퐁"></h2>
                            <div class="coupon">
                                <p><img src="http://webimage.10x10.co.kr/fixevent/event/2018/89454/bg-img.png" alt="쿠폰"></p>
                                <!-- 쿠폰 한번에 다운받기 버튼 -->
                                <a href="" onclick="jsDownCoupon('event,event,event,event','<%=couponIdx%>');return false;" class="btn-layer"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/89454/btn-onestop.png" alt="쿠폰 한번에 다운받기" /></a>
                            </div>
                            <!-- 레이어 -->
                            <div id="lyrSch" class="layer-popup">
                                <div class="layer">
                                    <p><img src="http://webimage.10x10.co.kr/fixevent/event/2018/89454/layer-tit.png" alt="카테고리쿠폰 발급! 쿠폰함을 확인해주세요"></p>
                                    <!-- 쿠폰함으로 가기 버튼 -->
                                    <a href="/my10x10/couponbook.asp" class="layer-btn"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/89454/layer-btn.png" alt="쿠폰함으로 가기" /></a>
                                </div>
                                <div class="mask"></div>
                            </div>
						</div>
						<!--// 쿠폰쓰고시퐁 -->
<!-- #include virtual="/lib/db/dbclose.asp" -->
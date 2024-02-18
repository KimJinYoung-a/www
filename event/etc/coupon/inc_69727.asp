<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 태양의 쿠폰
' History : 2016-03-15 이종화 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim eCode, userid , strSql
Dim getbonuscoupon1 , getlimitcnt1, currenttime
Dim totcnt1

	IF application("Svr_Info") = "Dev" THEN
		eCode = "66066"
	Else
		eCode = "69727"
	End If

	IF application("Svr_Info") = "Dev" THEN
		getbonuscoupon1 = "2772"
	Else
		getbonuscoupon1 = "832"
	End If


	userid = getEncLoginUserID()
	getlimitcnt1 = 20000		'20000
	currenttime = now()

dim bonuscouponcount1, subscriptcount1, totalsubscriptcount1, totalbonuscouponcount1
Dim use_bonuscouponcount1

bonuscouponcount1=0
subscriptcount1=0
totalsubscriptcount1=0
totalbonuscouponcount1=0

'//본인 참여 여부
if userid<>"" then
	subscriptcount1 = getevent_subscriptexistscount(eCode, userid, "", "", "")
	bonuscouponcount1 = getbonuscouponexistscount(userid, getbonuscoupon1, "", "", "")
	use_bonuscouponcount1 = getbonuscouponexistscount(userid, getbonuscoupon1, "", "Y", "")
end if

'//전체 참여수
totalsubscriptcount1 = getevent_subscripttotalcount(eCode, "", "", "")
'//전체 쿠폰 발행수량
totalbonuscouponcount1 = getbonuscoupontotalcount(getbonuscoupon1, "", "", "")
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
img {vertical-align:top;}
.couponDownload {position:relative;}
.couponDownload .btnCoupon {position:absolute; left:50%; top:281px; margin-left:-178px;}
.couponDownload .soon {position:absolute; left:749px; top:-38px; z-index:30;}
.couponDownload .soldout {position:absolute; left:325px; top:0; z-index:30;}
.evtNoti {overflow:hidden; padding:45px 100px 40px; text-align:left; background:#e8e8e8;}
.evtNoti h3 {float:left; width:215px;}
.evtNoti ul {float:left; width:700px;}
.evtNoti ul li {position:relative; line-height:23px; color:#727272;}
</style>
<script type="text/javascript">

function jseventSubmit(frm){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10) = "2016-03-16" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;
		<% else %>
			<% if subscriptcount1>0 or bonuscouponcount1>0 then %>
				alert("쿠폰은 한 개의 아이디당 한 번만 다운 받으실 수 있습니다.");
				return;
			<% else %>
				<% if totalsubscriptcount1>=getlimitcnt1 or totalbonuscouponcount1>=getlimitcnt1 then %>
					alert("죄송합니다. 쿠폰이 모두 소진 되었습니다.");
					return;
				<% else %>
					frm.action="/event/etc/doeventsubscript/doEventSubscript69727.asp";
					frm.target="evtFrmProc";
					//frm.target="_blank";
					frm.mode.value='coupon';
					frm.submit();
				<% end if %>
			<% end if %>
		<% end if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
		}
		return false;
	<% End IF %>
}
</script>
</head>
<body>
<% If userid = "cogusdk" Or userid = "greenteenz" Or userid = "motions" Then %>
<div>
	<p>&lt;<%=getbonuscoupon1%>&gt; 쿠폰 발급건수 : <%=totalbonuscouponcount1%> </p>
</div>
<% End If %>
<div class="evt69727">
	<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/69727/tit_sun_coupon.png" alt="태양의 쿠폰" /></h2>
	<div class="couponDownload">
		<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/69727/img_coupon.png" alt="6만원 이상 구매 시 1만원 할인 쿠폰" /></div>
		<% if totalsubscriptcount1>=getlimitcnt1 or totalbonuscouponcount1>=getlimitcnt1 then %>
		<p class="soldout"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69727/txt_soldout.png" alt="쿠폰이 모두 소진되었습니다!" /></p>
		<% Else %>
			<% if ((getlimitcnt1 - totalsubscriptcount1) < 5000) or ((getlimitcnt1 - totalbonuscouponcount1) < 5000) then %>
			<p class="soon"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69727/txt_soon.png" alt="마감임박" /></p>
			<% End If %>
		<% End If %>
		<a href="" onclick="jseventSubmit(evtFrm1);return false;" class="btnCoupon"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69727/btn_coupon.png" alt="쿠폰 다운받기" /></a>
	</div>
	<div>
		<img src="http://webimage.10x10.co.kr/eventIMG/2016/69727/btn_go.png" alt="" usemap="#map01" />
		<map name="map01" id="map01">
			<area shape="rect" coords="113,40,467,158" href="/event/appdown/" alt="텐바이텐 APP 다운" />
			<area shape="rect" coords="676,40,1028,155" href="/member/join.asp" alt="회원가입하고 구매하러 GO!" />
		</map>
	</div>
	<div class="evtNoti">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/69727/tit_noti.png" alt="이벤트 유의사항" /></h3>
		<ul>
			<li>- 이벤트는 ID 당 1일 1회만 참여할 수 있습니다.</li>
			<li>- 지급된 쿠폰은 텐바이텐 APP에서만 사용 가능 합니다.</li>
			<li>- 쿠폰은 금일 3/16(수) 23시 59분 종료됩니다.</li>
			<li>- 주문한 상품에 따라, 배송비용은 추가로 발생할 수 있습니다.</li>
			<li>- 이벤트는 조기 마감될 수 있습니다.</li>
		</ul>
	</div>
</div>
<form name="evtFrm1" action="" onsubmit="return false;" method="post" style="margin:0px;">
	<input type="hidden" name="mode" />
</form>
<iframe id="evtFrmProc" name="evtFrmProc" src="about:blank" frameborder="0" width=0 height=0></iframe>
<!-- #include virtual="/lib/db/dbclose.asp" -->
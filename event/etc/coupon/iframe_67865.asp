<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 해피 두개다 (쿠폰 이벤트)
' History : 2015-12-02 이종화 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim eCode, userid , strSql
Dim getbonuscoupon1 , getbonuscoupon2 , getlimitcnt1, getlimitcnt2 , currenttime
Dim totcnt1

	IF application("Svr_Info") = "Dev" THEN
		eCode = "65960"
	Else
		eCode = "67865"
	End If

	IF application("Svr_Info") = "Dev" THEN
		getbonuscoupon1 = "2752"
		getbonuscoupon2 = "2753"
	Else
		getbonuscoupon1 = "801"
		getbonuscoupon2 = "802"
	End If

	userid = getEncLoginUserID()
	getlimitcnt1 = 30000		'20000
	getlimitcnt2 = 30000		'20000
	currenttime = now()

dim bonuscouponcount1, subscriptcount1, totalsubscriptcount1, totalbonuscouponcount1
dim bonuscouponcount2, totalsubscriptcount2, totalbonuscouponcount2
Dim use_bonuscouponcount1 , use_bonuscouponcount2
Dim down_bonuscouponcount1 , down_bonuscouponcount2

bonuscouponcount1=0
subscriptcount1=0
totalsubscriptcount1=0
totalbonuscouponcount1=0

bonuscouponcount2=0
totalsubscriptcount2=0
totalbonuscouponcount2=0

'//본인 참여 여부
if userid<>"" then
	subscriptcount1 = getevent_subscriptexistscount(eCode, userid, "", "", "")
	bonuscouponcount1 = getbonuscouponexistscount(userid, getbonuscoupon1, "", "", "")
	bonuscouponcount2 = getbonuscouponexistscount(userid, getbonuscoupon2, "", "", "")

	down_bonuscouponcount1 = getbonuscoupontotalcount(getbonuscoupon1, "", "", "")
	down_bonuscouponcount2 = getbonuscoupontotalcount(getbonuscoupon2, "", "", "")

	use_bonuscouponcount1 = getbonuscoupontotalcount(getbonuscoupon1, "", "Y", "")
	use_bonuscouponcount2 = getbonuscoupontotalcount(getbonuscoupon2, "", "Y", "")
end if

'//전체 참여수
totalsubscriptcount1 = getevent_subscripttotalcount(eCode, "", "", "")
'//전체 쿠폰 발행수량
totalbonuscouponcount1 = getbonuscoupontotalcount(getbonuscoupon1, "", "", "")
totalbonuscouponcount2 = getbonuscoupontotalcount(getbonuscoupon2, "", "", "")

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
img {vertical-align:top;}
.evt67865 {text-align:left; background:#fff;}
.couponDownload {position:relative; text-align:center; background:#0e7f39;}
.couponDownload .soldout {position:absolute; left:0; top:0;}
.couponDownload .finishSoon {position:absolute; left:295.5px; top:416px;}
.evtNoti {overflow:hidden; padding:42px 0 42px 105px; color:#000; background:#efefef;}
.evtNoti h3 {float:left; width:196px;}
.evtNoti .list {overflow:hidden; float:left; width:720px; line-height:24px; padding-left:38px;}
.evtNoti ul {float:left; width:50%;}
.evtNoti li {text-indent:-9px; padding-left:9px;}
</style>
<script type="text/javascript">

function jseventSubmit(frm){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10) >= "2015-12-07" and left(currenttime,10) <= "2015-12-08" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;
		<% else %>
			<% if subscriptcount1>0 or bonuscouponcount1>0 or bonuscouponcount2>0 then %>
				alert("쿠폰은 한 개의 아이디당 한 번만 다운 받으실 수 있습니다.");
				return;
			<% else %>
				<% if (totalsubscriptcount1>=getlimitcnt1 or totalbonuscouponcount1>=getlimitcnt1) and (totalsubscriptcount2>=getlimitcnt2 or totalbonuscouponcount2>=getlimitcnt2) then %>
					alert("죄송합니다. 쿠폰이 모두 소진 되었습니다.");
					return;
				<% else %>
					frm.action="/event/etc/doeventsubscript/doEventSubscript67865.asp";
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
	<p>&lt;<%=getbonuscoupon1%>&gt; 쿠폰 발급건수 : <%=down_bonuscouponcount1%> 사용건수 : <%=use_bonuscouponcount1%></p>
	<p>&lt;<%=getbonuscoupon2%>&gt; 쿠폰 발급건수 : <%=down_bonuscouponcount2%> 사용건수 : <%=use_bonuscouponcount2%></p>
</div>
<% End If %>
<div class="evt67865">
	<form name="evtFrm1" action="" onsubmit="return false;" method="post" style="margin:0px;">
	<input type="hidden" name="mode" />
	</form>
	<iframe id="evtFrmProc" name="evtFrmProc" src="about:blank" frameborder="0" width=0 height=0 style="display:none;"></iframe>
	<h2><img src="http://webimage.10x10.co.kr/eventIMG/2015/67865/tit_happy_two.png" alt="해피 두개다" /></h2>
	<div class="couponDownload">
		<div>
			<% If Date() <= "2015-12-07" Then %>
			<img src="http://webimage.10x10.co.kr/eventIMG/2015/67865/img_coupon_1207.png" alt="6만원이상 구매시 1만원할인/20만원 이상 구매시 3만원 할인" />
			<% ElseIf Date() >= "2015-12-08" Then %>
			<img src="http://webimage.10x10.co.kr/eventIMG/2015/67865/img_coupon_1208.png" alt="6만원이상 구매시 1만원할인/20만원 이상 구매시 3만원 할인" />
			<% End If %>
		</div>
		<% if totalsubscriptcount1>=getlimitcnt1 or totalbonuscouponcount1>=getlimitcnt1 then %>
			<p class="soldout"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67865/txt_soldout.png" alt="쿠폰이 모두 소진되었습니다. 다음 기회를 기다려주세요" /></p>
		<% else %>
			<% if ((getlimitcnt1 - totalsubscriptcount1) < 5000) or ((getlimitcnt1 - totalbonuscouponcount1) < 5000) then %>
			<p class="finishSoon"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67865/txt_soon.gif" alt="마감임박" /></p>
			<% End If %>
		<% End If %>
		<p class="btnCpDown"><a href="" onclick="jseventSubmit(evtFrm1);return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67865/btn_download.png" alt="쿠폰 한번에 다운받기" /></a></p>
	</div>

	<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/67865/btn_go.png" alt="" usemap="#map01" /></div>
	<map name="map01" id="map01">
		<area shape="rect" coords="85,133,485,268" alt="텐바이텐 APP 다운받기" href="/event/appdown/" />
		<area shape="rect" coords="657,133,1054,268" alt="회원가입하고 구매하러 가기" href="/member/join.asp" />
	</map>
	<div class="evtNoti">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/67865/tit_noti.png" alt="이벤트 유의사항" /></h3>
		<div class="list">
			<ul>
				<li>- 이벤트는 ID 당 1일 1회만 참여할 수 있습니다.</li>
				<li>- 지급된 쿠폰은 텐바이텐에서만 사용가능 합니다.</li>
				<li>- 쿠폰은 금일 12/08(화) 23시59분 종료됩니다.</li>
			</ul>
			<ul>
				<li>- 주문한 상품에 따라, 배송비용은 추가로 발생 할 수 있습니다.</li>
				<li>- 이벤트는 조기 마감 될 수 있습니다.</li>
			</ul>
		</div>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->
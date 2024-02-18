<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 추석 쿠폰 세트
' History : 2015-09-18 이종화 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim eCode, userid , strSql
Dim coupon1 , coupon2 , coupon3
Dim totcnt1 , totcnt2 , totcnt3

	IF application("Svr_Info") = "Dev" THEN
		eCode = "64892"
	Else
		eCode = "66187"
	End If

	IF application("Svr_Info") = "Dev" THEN
		coupon1 = "2741"
		coupon2 = "2742"
		coupon3 = "2743"
	Else
		coupon1 = "780"
		coupon2 = "781"
		coupon3 = "782"
	End If

	userid = getEncLoginUserID()

'//본인 참여 여부
if userid<>"" Then
	'//응모 카운트 체크
	strSql = "SELECT " + vbcrlf
	strSql = strSql & " isnull(sum(case when sub_opt2 = 1 then 1 else 0 end),0) as totcnt1  " + vbcrlf
	strSql = strSql & " ,isnull(sum(case when sub_opt2 = 2 then 1 else 0 end),0) as totcnt2  " + vbcrlf
	strSql = strSql & " ,isnull(sum(case when sub_opt2 = 3 then 1 else 0 end),0) as totcnt3  " + vbcrlf
	strSql = strSql & " FROM [db_event].[dbo].[tbl_event_subscript] WHERE userid = '" & userid & "' AND evt_code = '" & eCode & "'"
'	Response.write strSql
''	Response.end
	rsget.CursorLocation = adUseClient
	rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly

	IF Not rsget.Eof Then
		totcnt1 = rsget(0) '// 0 1
		totcnt2 = rsget(1) '// 0 1
		totcnt3 = rsget(2) '// 0 1
	End IF
	rsget.close	
end if
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
img {vertical-align:top;}
.evt66187 {text-align:left; background:#fff;}
.couponDownload {position:relative; height:437px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/66187/bg_coupon_area.gif) 0 0 no-repeat;}
.couponDownload ul {overflow:hidden; padding-left:109px;}
.couponDownload .btnDown {cursor:pointer;}
.couponDownload li {position:relative; float:left; width:291px; height:444px; margin-right:25px;}
.couponDownload li .get {display:none; position:absolute; left:0; top:0;}
.evtNoti {overflow:hidden; padding:43px 0 43px 110px; color:#917a70; background:#fff7ec;}
.evtNoti h3 {float:left; width:168px;}
.evtNoti .list {overflow:hidden; float:left; width:740px; line-height:24px; padding-left:35px;}
.evtNoti .list ul {float:left; width:50%;}
</style>
<script type="text/javascript">

$(function(){
	$('.couponDownload li .btnDown').click(function(){
		$(this).hide();
		$(this).next('.get').show();
	});
	<% if totcnt1 > 0 then %>$("#cpnum1").hide();$("#cpnum11").show();<% end if %>
	<% if totcnt2 > 0 then %>$("#cpnum2").hide();$("#cpnum22").show();<% end if %>
	<% if totcnt3 > 0 then %>$("#cpnum3").hide();$("#cpnum33").show();<% end if %>
});
function jseventSubmit(v){
	var frm = document.evtFrm1;
	<% If IsUserLoginOK() Then %>
		<% If not( date()>= "2015-09-18" and date() <= "2015-09-22" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;
		<% else %>
			frm.cpnum.value = v;
			frm.action="/event/etc/doeventsubscript/doEventSubscript66187.asp";
			frm.target="evtFrmProc";
			frm.mode.value='coupon';
			frm.submit();
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
<!-- show me the coupon -->
<div class="evt66187">
	<h2><img src="http://webimage.10x10.co.kr/eventIMG/2015/66187/tit_coupon.gif" alt="추석 쿠폰 세트" /></h2>
	<!-- 쿠폰 다운로드 -->
	<div class="couponDownload">
		<ul>
			<li>
				<p class="btnDown" id="cpnum1" onclick="jseventSubmit('1');"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66187/img_coupon01.png" alt="굴비쿠폰" /></p>
				<p class="get" id="cpnum11"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66187/img_coupon01_view.png" alt="" /></p>
			</li>
			<li>
				<p class="btnDown" id="cpnum2" onclick="jseventSubmit('2');"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66187/img_coupon02.png" alt="한우쿠폰" /></p>
				<p class="get" id="cpnum22"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66187/img_coupon02_view.png" alt="" /></p>
			</li>
			<li>
				<p class="btnDown" id="cpnum3" onclick="jseventSubmit('3');"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66187/img_coupon03.png" alt="홍삼쿠폰" /></p>
				<p class="get" id="cpnum33"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66187/img_coupon03_view.png" alt="" /></p>
			</li>
		</ul>
	</div>
	<!--// 쿠폰 다운로드 -->
	<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/66187/txt_tip.gif" alt="쿠폰 사용기간:9월21일~22일(2일간) 텐바이텐에서만 사용" /></p>
	<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/66187/btn_go.gif" alt="" usemap="#thanksgivingMap" /></div>
	<map name="thanksgivingMap" id="thanksgivingMap">
		<area shape="rect" coords="85,50,485,184" alt="텐바이텐 APP 다운받기" href="/event/appdown/" target="_top"/>
		<area shape="rect" coords="658,50,1055,184" alt="회원가입하고 구매하러 가기" href="/member/join.asp" target="_top"/>
	</map>
	<div class="evtNoti">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/66187/tit_notice.gif" alt="이벤트 유의사항" /></h3>
		<div class="list">
			<ul>
				<li>- 본 쿠폰은 ID 당 1회만 다운받을 수 있습니다.</li>
				<li>- 지급된 쿠폰은 텐바이텐에서만 사용가능 합니다.</li>
				<li>- 쿠폰은 9/22(화) 23시59분 종료됩니다.</li>
			</ul>
			<ul>
				<li>- 주문한 상품에 따라, 배송비용은 추가로 발생 할 수 있습니다.</li>
				<li>- 이벤트는 조기 마감 될 수 있습니다.</li>
			</ul>
		</div>
	</div>
</div>
<form name="evtFrm1" action="" onsubmit="return false;" method="post" style="margin:0px;">
	<input type="hidden" name="mode" />
	<input type="hidden" name="cpnum" />
</form>
<iframe id="evtFrmProc" name="evtFrmProc" src="about:blank" frameborder="0" width=0 height=0></iframe>
<!-- #include virtual="/lib/db/dbclose.asp" -->
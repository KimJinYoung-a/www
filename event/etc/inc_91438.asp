<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim iscouponeDown, vQuery, eventCoupons
iscouponeDown = false
IF application("Svr_Info") = "Dev" THEN
	eventCoupons = "22103,22105,22106"
Else
	eventCoupons = "33043,33042,33041"
End If

vQuery = "select count(1) from [db_item].[dbo].[tbl_user_item_coupon] where userid = '" & getencLoginUserid() & "'"
vQuery = vQuery + " and itemcouponidx in ("&eventCoupons&") "
vQuery = vQuery + " and usedyn = 'N' "
rsget.CursorLocation = adUseClient
rsget.Open vQuery,dbget,adOpenForwardOnly,adLockReadOnly
If rsget(0) = 3 Then
	iscouponeDown = true
End IF
rsget.close
%>
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
.evt91438 {position:relative;}
.evt91438 area {outline:0;}
.evt91438 .bnr {margin-top:4px;}
.layer-coupon {display:none; position:absolute; top:0; left:0; width:100%; height:100%;}
.layer-coupon:before {display:block; position:absolute; top:0; left:0; z-index:30; width:100%; height:100%; background-color:rgba(0,0,0,.65); content:' ';}
.layer-coupon .inner {position:absolute; top:242px; left:348px; z-index:50; width:439px; -webkit-box-shadow:0 39px 29px rgba(46,3,9,.65); box-shadow:0 39px 29px rgba(46,3,9,.65);}
.layer-coupon .btn-close {position:absolute; top:0; right:0; width:71px; height:67px; text-indent:-999em; background:url(http://webimage.10x10.co.kr/fixevent/event/2018/91438/btn_close.png) 50% 50% no-repeat; outline:0;}
</style>
<script type="text/javascript">
$(document).ready(function(){
	// coupon popup
	$('.layer-coupon').hide();
	$('.layer-coupon .btn-close').click(function (e){$('.layer-coupon').hide();});

	$('.btn-coupon').click(function () {
		<% if iscouponeDown then %>
			alert("이미 다운로드 받으셨습니다.");
			return false;
		<% end if %> 

		<% if Not(IsUserLoginOK) then %>
			jsEventLogin();
			return false;
		<% end if %>
			jsDownCoupon('prd,prd,prd','<%=eventCoupons%>');
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
					setTimeout(function(){$('.layer-coupon').show();}, 800);					
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
		location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid=91438")%>';
		return;
	}
}
</script>
</head>
<div class="evt91438">
	<h2><img src="http://webimage.10x10.co.kr/fixevent/event/2018/91438/img_event.jpg" alt="연말정산 쿠폰" usemap="#coupon"></h2>
	<map name="coupon">
		<area shape="rect" coords="381,625,756,724" id="couponBtn" class="btn-coupon" target="_self" alt="쿠폰 한번에 다운받기" />
	</map>
	<div class="bnr"><a href="/event/eventmain.asp?eventid=91297"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/91438/img_bnr.jpg" alt="최최최저가"></a></div>
	<div class="layer-coupon">
		<div class="inner">
			<p><img src="http://webimage.10x10.co.kr/fixevent/event/2018/91438/popup.jpg" alt="쿠폰이 발급 되었습니다!" /></p>
			<p><a href="/event/eventmain.asp?eventid=91467"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/91438/popup_bnr.jpg" alt="리빙 띵템"></a></p>
			<button class="btn-close">닫기</button>
		</div>
	</div>
</div>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->
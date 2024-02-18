<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 플레이, 첫 구매! W
' History : 2016-06-16 이종화 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim eCode, userid, currenttime, i
	IF application("Svr_Info") = "Dev" THEN
		eCode = "66154"
	Else
		eCode = "71255"
	End If

currenttime = now()
userid = GetEncLoginUserID()

dim couponidx
	IF application("Svr_Info") = "Dev" THEN
		couponidx = "10104"
	Else
		'couponidx = "11715"									''수정확인
		couponidx = "11848"
	End If

Dim selectitemid
	IF application("Svr_Info") = "Dev" THEN
		selectitemid = "1210578"
	Else
		selectitemid = "1510805"							''수정확인
	End If

dim subscriptcount, itemcouponcount , totcnt
subscriptcount=0
itemcouponcount=0
totcnt = 0

'//본인 참여 여부
if userid<>"" then
	subscriptcount = getevent_subscriptexistscount11(eCode, userid, "", "", "")
	itemcouponcount = getitemcouponexistscount(userid, couponidx, "", "")
end If
totcnt = getitemcouponexistscount("", couponidx, "", "")

dim administrator
	administrator=FALSE

if userid="greenteenz" or userid="djjung" or userid="okkang77" or userid="kyungae13" or userid="tozzinet" or userid="thensi7" or userid="baboytw" or userid="motions" then
	administrator=TRUE
end If

%>
<style type="text/css">
img {vertical-align:top;}
.getCoupon {position:relative;}
.getCoupon .goBuy {position:absolute; left:730px; top:153px; background:transparent;}
.evtNoti {overflow:hidden; padding:32px 0 32px 5px; text-align:left; background:#075177;}
.evtNoti h3 {float:left; width:352px; text-align:center; padding-top:52px;}
.evtNoti ul {float:left; width:700px; padding-top:4px; border-left:1px solid #0a71a7;}
.evtNoti ul li {position:relative; line-height:22px; padding:0 0 0 70px; color:#eae3dc;}
.evtNoti ul li a {position:absolute; right:45px; top:-1px;}
#couponLayer {position:absolute; left:0; top:0; width:100%; height:100%; z-index:50; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71225/bg_mask.png) repeat 0 0;}
#couponLayer .resultCont {position:absolute; left:50%; top:600px; margin-left:-242px;}
#couponLayer .btnClose {position:absolute; right:25px; top:24px; background:transparent; z-index:60;}

/* animation */
.goBuy {-webkit-animation: move 0.3s ease-in-out 0s 50 alternate; -moz-animation: move 0.3s ease-in-out 0s 50 alternate; -ms-animation: move 0.3s ease-in-out 0s 50 alternate; -o-animation: move 0.3s ease-in-out 0s 50 alternate; animation: move 0.3s ease-in-out 0s 50 alternate;}
@keyframes move {from {transform:translate(-3px,0);} to {transform:translate(3px,0);}}
@-webkit-keyframes move { from {-webkit-transform:translate(-3px,0);} to {-webkit-transform:translate(3px,0);}}
@-moz-keyframes move {from {-moz-transform:translate(-3px,0);} to{-moz-transform:translate(3px,0);}}
@-o-keyframes move {from {-o-transform:translate(-3px,0);} to {-o-transform:translate(3px,0);}}
@-ms-keyframes move {from {-ms-transform:translate(-3px,0);} to {-ms-transform:translate(3px,0);}}
</style>
<script type="text/javascript">
$(function(){
	$(".btnClose").click(function(){
		$("#couponLayer").hide();
	});
});

function jscoupondown(){
	<% If IsUserLoginOK() Then %>
		<% If Now() > #08/15/2016 23:59:59# Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;
		<% else %>
			<% if GetLoginUserLevel<>"5" and not(administrator) then %>
				alert("고객님은 쿠폰발급 대상이 아닙니다.");
				return;
			<% else %>
				<% if administrator then %>
					alert("[관리자] 특별히 관리자님이니까 오렌지 등급이 아니여도 다음 단계로 진행 시켜 드릴께요!");
				<% end if %>
				var str = $.ajax({
					type: "POST",
					url: "/event/etc/doeventsubscript/doEventSubscript71255.asp",
					data: "mode=coupondown",
					dataType: "text",
					async: false
				}).responseText;
				//alert(str);
				var str1 = str.split("||")
				//alert(str1[0]);
				if (str1[0] == "11"){
					$("#couponLayer").empty().html(str1[1]);
					$("#couponLayer").show();
					window.parent.$('html,body').animate({scrollTop:700}, 500);
					return false;
				}else if (str1[0] == "10"){
					alert('데이터 처리에 예외 상황이 발생하였습니다. 관리자에게 문의해주십시오.');
					return false;
				}else if (str1[0] == "09"){
					$("#couponLayer").empty().html(str1[1]);
					$("#couponLayer").show();
					window.parent.$('html,body').animate({scrollTop:700}, 500);
					return false;
				}else if (str1[0] == "08"){
					alert('기간이 종료되었거나 유효하지 않은 쿠폰입니다.');
					return false;
				}else if (str1[0] == "07"){
					alert('데이터 처리에 문제가 발생하였습니다. 관리자에게 문의해주십시오.');
					return false;
				}else if (str1[0] == "06"){
					alert('쿠폰은 오전 10시부터 다운 받으실수 있습니다.');
					return false;
				}else if (str1[0] == "05"){
					alert('고객님은 쿠폰발급 대상이 아닙니다.');
					return false;
				}else if (str1[0] == "04"){
					$("#couponLayer").empty().html(str1[1]);
					$("#couponLayer").show();
					window.parent.$('html,body').animate({scrollTop:700}, 500);
					return false;
				}else if (str1[0] == "03"){
					alert('이벤트 응모 기간이 아닙니다.');
					return false;
				}else if (str1[0] == "03"){
					alert('이벤트 응모 기간이 아닙니다.');
					return false;
				}else if (str1[0] == "02"){
					alert('로그인을 해주세요.');
					return false;
				}else if (str1[0] == "01"){
					alert('잘못된 접속입니다.');
					return false;
				}else if (str1[0] == "00"){
					alert('정상적인 경로가 아닙니다.');
					return false;
				}else if (str1[0] == "12"){
					alert('오전 10시부터 응모하실 수 있습니다.');
					return false;
				}else{
					alert('오류가 발생했습니다.');
					return false;
				}
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

function goDirOrdItem()
{
	document.directOrd.submit();
}

function poplayerclose()
{
	$("#couponLayer").hide();
	location.reload();
}
</script>
<div class="evt71225">
	<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/71225/tit_play_a.png" alt="플레이 첫 구매 - 아직 한번도 구매하지 않은 당신에게 귀여운 플레이모빌을 소개합니다!" /></h2>
	<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/71225/img_playmobil.jpg" alt="플레이모빌 미스터리 피규어 시리즈 9 (랜덤 발송)" /></div>
	<div class="getCoupon">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/71225/txt_first_buy.png" alt="오늘 당신만을 위한 엄청난 쿠폰으로 첫 구매에 도전하세요!" /></p>
		<button class="goBuy" <% If totcnt < 1910 Then %>onclick="jscoupondown(); return false;"<% End If %>>
			<% If totcnt < 1910 Then %>
			<img src="http://webimage.10x10.co.kr/eventIMG/2016/71225/btn_buy.png" alt="쿠폰 받고 구매하러 가기" />
			<% Else %>
			<img src="http://webimage.10x10.co.kr/eventIMG/2016/71225/btn_soldout.png" alt="SOLD OUT" />
			<% End If %>
		</button>
	</div>

	<%' -- 쿠폰받기 레이어 -- %>
	<div id="couponLayer" style="display:none"></div>

	<div class="evtNoti">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/71225/tit_noti.png" alt="이벤트 유의사항" /></h3>
		<ul>
			<li>- 텐바이텐에서 한번도 구매이력이 없는 오렌지등급 고객님을 위한 이벤트입니다. <a href="/my10x10/special_info.asp" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71225/btn_grade.png" alt="회원등급 보러가기" /></a></li>
			<li>- 본 이벤트는 로그인 후에 참여가 가능합니다.</li>
			<li>- ID 당 1회만 구매가 가능합니다.</li>
			<li>- 이벤트는 조기 마감 될 수 있습니다.</li>
			<li>- 이벤트는 즉시결제로만 구매가 가능하며, 배송 후 반품/교환/구매취소가 불가능합니다.</li>
		</ul>
	</div>
</div>
<form method="post" name="directOrd" action="/inipay/shoppingbag_process.asp">
	<input type="hidden" name="itemid" value="<%=selectitemid%>">
	<input type="hidden" name="itemoption" value="0000">
	<input type="hidden" name="itemea" value="1">
	<input type="hidden" name="mode" value="DO1">
</form>
<%
function getevent_subscriptexistscount11(evt_code, userid, sub_opt1, sub_opt2, sub_opt3)
	dim sqlstr, tmevent_subscriptexistscount
	
	if evt_code="" or userid="" then
		getevent_subscriptexistscount11=99999
		exit function
	end if
	
	sqlstr = "select count(*) as cnt"
	sqlstr = sqlstr & " from [db_event].[dbo].[tbl_event_subscript] sc"
	sqlstr = sqlstr & " where sc.sub_idx > '8003642' and sc.evt_code="& evt_code &""
	sqlstr = sqlstr & " and sc.userid='"& userid &"'"
	
	if sub_opt1<>"" then
		sqlstr = sqlstr & " and isnull(sc.sub_opt1,'') = '"& sub_opt1 &"'"
	end if
	if sub_opt2<>"" then
		sqlstr = sqlstr & " and isnull(sc.sub_opt2,'') = '"& sub_opt2 &"'"
	end if
	if sub_opt3<>"" then
		sqlstr = sqlstr & " and isnull(sc.sub_opt3,'') = '"& sub_opt3 &"'"
	end if
	
	'response.write sqlstr & "<Br>"
	rsget.Open sqlstr,dbget
	IF not rsget.EOF THEN
		tmevent_subscriptexistscount = rsget("cnt")
	END IF
	rsget.close
	
	getevent_subscriptexistscount11 = tmevent_subscriptexistscount
end function
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
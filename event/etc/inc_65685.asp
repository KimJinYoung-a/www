<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 가을을 준비하는 올바른 자세
' History : 2015-08-19 이종화
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
dim eCode, vUserID, userid, myuserLevel, sqlStr, vTotalCount, vTotalSum
	vUserID = GetLoginUserID()
	myuserLevel = GetLoginUserLevel
	userid = vUserID

	IF application("Svr_Info") = "Dev" THEN
		eCode = "64859"
	Else
		eCode = "65685"
	End If

Dim vQuery, vCount
	vQuery = "SELECT count(*) FROM [db_event].[dbo].[tbl_event_subscript] WHERE userid = '" & userid & "' AND evt_code = '" & eCode & "' "
	rsget.CursorLocation = adUseClient
	rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly

	IF Not rsget.Eof Then
		vCount = rsget(0)
	End IF
	rsget.close

	'//7월 구매 내역 체킹 (응모는 7월 구매고객만 가능)
	sqlStr = " EXEC [db_order].[dbo].[sp_Ten_MyOrderList_SUM] '" & userid & "', '', '', '2015-07-01', '2015-08-01', '10x10', '', 'issue' "
	rsget.CursorLocation = adUseClient
	rsget.CursorType = adOpenStatic
	rsget.LockType = adLockOptimistic
	rsget.Open sqlStr,dbget,1
		vTotalCount = rsget("cnt")
		vTotalSum   = CHKIIF(isNull(rsget("tsum")),0,rsget("tsum"))
	rsget.Close

%>
<link rel="stylesheet" type="text/css" href="/lib/css/section.css" />
<style type="text/css">
img {vertical-align:top;}
.topic p {visibility:hidden; width:0; height:0;}
.eventBox {overflow:hidden;}
.eventBox .check {float:left; width:570px;}
.eventBox .check {position:relative; text-align:left;}
.eventBox .check ul {position:absolute; top:129px; left:272px; width:212px; margin-bottom:12px; padding-bottom:10px; border-top:1px solid #ededed; border-bottom:1px solid #ededed;}
.eventBox .check ul li {overflow:hidden; height:12px; margin-top:12px; padding:0 2px;}
.eventBox .check ul li:first-child {margin-bottom:14px;}
.eventBox .check ul li span, .check ul li strong {float:left; width:50%; line-height:1em;}
.eventBox .check ul li strong {background:url(http://webimage.10x10.co.kr/eventIMG/2015/65685/ico_star.png) no-repeat 84% 0; color:#000; text-align:right;}
.eventBox .check ul li strong em {display:inline-block; min-width:50px; background-color:#fff; color:#e33840; font-family:'Verdana', 'Dotum';}
.eventBox .check ul li strong em {zoom:1;*display:inline;}
.eventBox .btncheck {position:absolute; top:208px; left:360px;}

.presentBox {padding:58px 0 76px 49px; border-bottom:5px solid #d2d0c8; background:#e7e6e1 url(http://webimage.10x10.co.kr/eventIMG/2015/65685/bg_pattern.png) repeat 0 0;}
.presentBox .inner {width:1060px; height:506px; padding-top:45px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/65685/bg_box.png) no-repeat 0 0;}
.presentBox ul {overflow:hidden; width:988px; margin:45px auto 0;}
.presentBox ul li {float:left; text-align:center;}
.presentBox ul li a {overflow:hidden; display:block; width:200px; height:200px; padding:0 23px; border-left:1px dashed #dcdcdc;}
.presentBox ul li a img {transition:transform 0.7s ease;}
.presentBox ul li a:hover img {transform:scale(0.95);}
.presentBox ul li label {display:block;}
.presentBox ul li:first-child a {border-left:0;}
.presentBox .btnsubmit {margin-top:28px;}

.noti {padding-bottom:53px; background-color:#f5f5f2; text-align:left;}
.noti ul {margin-top:28px; padding-left:53px;}
.noti ul li {margin-top:7px; padding:0 0 0 17px; background:url(http://fiximage.10x10.co.kr/web2015/common/blt10.gif) 0 5px no-repeat; color:#000; font-size:11px;}
</style>
<script type="text/javascript">
<!--
$(function(){
<% if Not(IsUserLoginOK) then %>
    jsChklogin('<%=IsUserLoginOK%>');
	return false;
<% end if %>
});

function jsSubmitComment(){
	var frm = document.frmGubun2;

	<% if Not(IsUserLoginOK) then %>
		jsChklogin('<%=IsUserLoginOK%>');
		return false;
	<% end if %>

	<% If Now() > #08/31/2015 23:59:59# Then %>
		alert("이벤트가 종료되었습니다.");
		return;
	<% Elseif Now() < #08/24/2015 00:00:00# Then %>
		alert("이벤트 기간이 아닙니다.");
		return;
	<% else %>
		<% If vUserID <> "" Then %>
			<% if vTotalCount > 0 and vTotalSum > 0 then %>
				<% if vCount = 0 then %>
				var totcnt , totsum
				totcnt = $("#totcnt").text();
				totsum = $("#totsum").text();

				if (!frm.spoint[0].checked && !frm.spoint[1].checked && !frm.spoint[2].checked && !frm.spoint[3].checked)
				{
					alert('상품을 선택 하고 응모하세요');
					return false;
				}

				if (totcnt == "0" && totcnt == "0" ){
					alert('먼저 구매 내역 확인버튼을 눌러주세요');
					return;
				}else{
					frm.action = "/event/etc/doeventsubscript/doEventSubscript65685.asp";
					frm.submit();
				}
				<% else %>
				alert("이미 응모 하셨습니다.");
				return;
				<% End If %>
			<% else %>
				alert("응모 대상자가 아닙니다.");
				return;
			<% End If %>
		<% End If %>
	<% End if %>
}

function chkmyorder(){
	var rstStr = $.ajax({
		type: "POST",
		url: "/event/etc/doeventsubscript/doEventSubscript65685.asp",
		data: "mode=myorder",
		dataType: "text",
		async: false
	}).responseText;
		$("#tempdiv").empty().append(rstStr);
		$("#totcnt").css("display","inline-block");
		$("#totsum").css("display","inline-block");
		$("#totcnt").text($("div#tcnt").text());
		$("#totsum").text($("div#tsum").text());
}
//-->
</script>
<div class="evt65685">
	<div class="topic">
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2015/65685/tit_fall.png" alt="가을을 준비하는 올바른 자세" /></h2>
		<p>8월 구매내역이 있다면, 가을 감성 가득한 선물에 응모하세요. 1,000명을 추첨하여 선택한 사은품을 보내드립니다! 이벤트 기간은 8월 24일부터 8월 31일까지며, 당첨자 발표는 9월 8일입니다.</p>
	</div>
	<div class="eventBox">
		<div class="check">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/65685/txt_got.png" alt="8월 고객님의 구매내역을 확인하세요!" /></h3>
			<ul>
				<li>
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2015/65685/txt_count.png" alt="구매횟수" /></span>
					<strong><em id="totcnt" style="display:none;">0</em> <img src="http://webimage.10x10.co.kr/eventIMG/2015/65685/txt_no.png" alt="회" /></strong>
				</li>
				<li>
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2015/65685/txt_price.png" alt="구매금액" /></span>
					<strong><em id="totsum" style="display:none;">0</em> <img src="http://webimage.10x10.co.kr/eventIMG/2015/65685/txt_won.png" alt="원" /></strong>
				</li>
			</ul>
			<button type="button" class="btncheck" onclick="chkmyorder();return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65685/btn_check.png" alt="확인하기" /></button>
		</div>
		<div class="check">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/65685/txt_present_v2.gif" alt="선물을 확인하고 응모하세요! 구매내역이 있으시면 선물을 확인하고, 하단의 응모하기를 누르세요! 9월 8일 당첨자가 발표됩니다! 1,000명 추첨" /></p>
		</div>
	</div>
	<div id="presentBox" class="presentBox">
		<form name="frmGubun2" method="post" style="margin:0px;" target="prociframe">
		<input type="hidden" name="mode" value="add"  />
			<fieldset>
			<legend>받고 싶은 상품을 선택하고 응모하기</legend>
				<div class="inner">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/65685/tit_present.png" alt="받고 싶은 상품을 선택하고 응모하세요!" /></h3>
					<ul>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1182503"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65685/img_item_01.jpg" alt="Merry light 2p set" /></a>
							<label for="select01"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65685/txt_label_01.png" alt="모두가 매일매일 좋은밤 Merry light 2p set" /></label>
							<input type="radio" id="select01" name="spoint" value="1" />
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1263982"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65685/img_item_02.jpg" alt="프리저브드 디퓨저" /></a>
							<label for="select02"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65685/txt_label_02.png" alt="가을 향기 가득한 프리저브드 디퓨저" /></label>
							<input type="radio" id="select02" name="spoint" value="2" />
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=1040465"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65685/img_item_03.jpg" alt="마리안케이트 럭키독 파우치" /></a>
							<label for="select03"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65685/txt_label_03.png" alt="외출하고싶은 계절 마리안케이트 파우치" /></label>
							<input type="radio" id="select03" name="spoint" value="3" />
						</li>
						<li>
							<a href="/shopping/category_prd.asp?itemid=971835"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65685/img_item_04.jpg" alt="아이엠 낫 타이어드 아이패치" /></a>
							<label for="select04"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65685/txt_label_04.png" alt="촉촉한 가을여자 컨셉 아이엠 낫 타이어드 아이패치" /></label>
							<input type="radio" id="select04" name="spoint" value="4" />
						</li>
					</ul>
				</div>

				<div class="btnsubmit"><input type="image" src="http://webimage.10x10.co.kr/eventIMG/2015/65685/btn_submit.png" alt="응모하기" onClick="jsSubmitComment(); return false;"/></div>
			</fieldset>
		</form>
	</div>

	<div class="noti">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/65685/tit_noti.png" alt="이벤트 유의사항" /></h3>
		<ul>
			<li>이벤트는 이메일 또는 푸쉬로 이벤트 안내를 받으신 회원님만을 위한 헤택입니다.</li>
			<li>응모하기는 이벤트 기간 중 1회만 가능합니다.</li>
			<li>8월 구매내역이 있어야 응모하기가 가능합니다.</li>
			<li>9월 8일 당첨자가 발표되며, 주소 입력 이후 배송됩니다.</li>
			<li>환불이나 교환으로 인해 8월 구매횟수나 구매금액이 충족되지 않을 경우 응모는 자동 취소 됩니다.</li>
			<li>이벤트는 조기종료 될 수 있습니다.</li>
		</ul>
	</div>
	<div id="tempdiv" style="display:none;"></div>
	<iframe name="prociframe" id="prociframe" frameborder="0" width="0px" height="0px"></iframe>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->
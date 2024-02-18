<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 깨긋한 산소방
' History : 2016.03.11 원승현 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->

<% '<!-- #include virtual="/lib/inc/head.asp" --> %>

<%
dim eCode, userid
	IF application("Svr_Info") = "Dev" THEN
		eCode = "66063"
	Else
		eCode = "69634"
	End If

userid = GetEncLoginUserID()

dim couponidx
	IF application("Svr_Info") = "Dev" THEN
		couponidx = "830"
	Else
		couponidx = "830"
	End If


Dim vPrvOrderCnt, vPrvOrderSumPrice, vEvtOrderCnt, vEvtOrderSumPrice, vMyThisEvtCnt, vMyThisCouponCnt, sqlstr, vQuery
'//이전 구매 내역 체킹 (1월 1일부터 3월 13일까지)
sqlStr = " EXEC [db_order].[dbo].[sp_Ten_MyOrderList_SUM] '" & userid & "', '', '', '2016-01-01', '2016-03-14', '10x10', '', 'issue' "
'response.write sqlStr & "<br>"
rsget.CursorLocation = adUseClient
rsget.CursorType = adOpenStatic
rsget.LockType = adLockOptimistic
rsget.Open sqlStr,dbget,1
	vPrvOrderCnt = rsget("cnt")
	vPrvOrderSumPrice   = CHKIIF(isNull(rsget("tsum")),0,rsget("tsum"))
'	vPrvOrderCnt = 0
'	vPrvOrderSumPrice   = 0
rsget.Close


'// 이벤트 기간 구매 내역 체킹(3월 14일부터 3월 20일까지)
sqlStr = " EXEC [db_order].[dbo].[sp_Ten_MyOrderList_SUM] '" & userid & "', '', '', '2016-03-14', '2016-03-21', '10x10', '', 'issue' "
'response.write sqlStr & "<br>"
rsget.CursorLocation = adUseClient
rsget.CursorType = adOpenStatic
rsget.LockType = adLockOptimistic
rsget.Open sqlStr,dbget,1
	vEvtOrderCnt = rsget("cnt")
	vEvtOrderSumPrice   = CHKIIF(isNull(rsget("tsum")),0,rsget("tsum"))
'	vEvtOrderCnt = 1
'	vEvtOrderSumPrice   = 1000
rsget.Close

' 현재 이벤트 본인 참여수
vQuery = "SELECT count(*) FROM [db_event].[dbo].[tbl_event_subscript] WHERE evt_code = '" & eCode & "' And userid='"&userid&"' And sub_opt3='event' "
rsget.CursorLocation = adUseClient
rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
IF Not rsget.Eof Then
	vMyThisEvtCnt = rsget(0)
End IF
rsget.close

' 현재 이벤트 본인 쿠폰발급여부
vQuery = "SELECT count(*) FROM [db_event].[dbo].[tbl_event_subscript] WHERE evt_code = '" & eCode & "' And userid='"&userid&"' And sub_opt3='coupon' "
rsget.CursorLocation = adUseClient
rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
IF Not rsget.Eof Then
	vMyThisCouponCnt = rsget(0)
End IF
rsget.close




%>
<style type="text/css">
img {vertical-align:top;}

.evt69634 button {background-color:transparent;}

.article {overflow:hidden;}
.article .get, .article .gift {float:left; position:relative;}
.article .get ul {position:absolute; top:314px; left:157px; width:253px;}
.article .get ul li {width:100%; margin-bottom:20px;}
.article .get ul li:after {content:' '; display:block; clear:both;}
.article .get ul li .area {float:left; width:50%; font-size:16px; line-height:18px; text-align:left;}
.article .get ul li:first-child span {line-height:16px;}
.article .get ul li .count {text-align:right;}
.article .get ul li span b {color:#ffed89;}
.article .get .btnCheck {position:absolute; top:402px; right:168px;}
.article .gift .btnEnter {position:absolute; bottom:47px; left:50%; margin-left:-168px;}

.lyBox {display:none; position:fixed; top:50%; left:50%; z-index:105; width:482px; height:516px; margin-top:-258px; margin-left:-241px;}
.lyBox .btnDown {position:absolute; bottom:56px; left:50%; width:324px; height:66px; margin-left:-162px; background:none; color:#f0524a; line-height:115px;}
.lyBox .btnClose {position:absolute; top:20px; right:20px; width:60px; height:60px; color:#fff; line-height:100px;}

#dimmed {display:none; position:fixed; top:0; left:0; width:100%; height:100%; z-index:100; background:url(http://webimage.10x10.co.kr/eventIMG/2015/68354/bg_mask.png);}

.noti {position:relative; padding:30px 0; background-color:#465755; color:#fff;}
.noti img {color:#fff;}
.noti h3 {position:absolute; top:50%; left:117px; margin-top:-10px;}
.noti ul {margin-left:357px; padding:2px 0 2px 63px; border-left:1px solid #627a77; text-align:left;}
.noti ul li {margin-top:5px; font-family:'Gulim'; font-size:12px; line-height:1.5em;}
</style>
<script type="text/javascript">
$(function(){

	$("#lyBox .btnClose, #dimmed").click(function(){
		$("#lyBox").hide();
		$("#dimmed").fadeOut();
	});
});



function jsSubmit(){
	<% If IsUserLoginOK() Then %>
		<% If not( left(now(),10)>="2016-03-14" and left(now(),10)<"2016-03-21" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
			if ($("#orderchkval").val()!="1")
			{	
				alert("구매내역을 확인하셔야 이벤트에 참여하실 수 있습니다.");
				return false;
			}
			<% if vPrvOrderCnt > 0 And vEvtOrderCnt < 1 then '// 이전 구매내역은 있지만 이벤트 기간 내 구매내역이 없을경우 %>
				alert("이벤트 기간 내 구매내역이 없습니다.\n먼저 구매 후 응모해주세요!");
				return;
			<% elseif vPrvOrderCnt < 1 then '// 이전 구매내역이 없을경우는 이벤트 기간내 구매내역이 있어도 1회 쿠폰발급 %>
				<% if vMyThisCouponCnt > 0 then '// 쿠폰 발급내역이 있으면 %>
					alert("쿠폰을 이미 다운받으셨습니다.");
					return;
				<% end if %>
				var wrapHeight = $(document).height();
				$("#lyBox").show();
				$("#dimmed").show();
				$("#dimmed").css("height",wrapHeight);
			<% elseif vPrvOrderCnt > 0 And vEvtOrderCnt > 0 then '// 두개다 구매내역이 있을경우엔 응모시킴 %>
				<% if vMyThisEvtCnt > 0 then '// 1회만 응모되기때문에 응모내역이 있으면 튕김 %>
					alert("이미 응모가 완료되었습니다.");
					return;
				<% end if %>

				$.ajax({
					type:"GET",
					url:"/event/etc/doEventSubscript69634.asp?mode=ins",
					dataType: "text",
					async:false,
					cache:true,
					success : function(Data, textStatus, jqXHR){
						if (jqXHR.readyState == 4) {
							if (jqXHR.status == 200) {
								if(Data!="") {
									var str;
									for(var i in Data)
									{
										 if(Data.hasOwnProperty(i))
										{
											str += Data[i];
										}
									}
									str = str.replace("undefined","");
									res = str.split("|");
									if (res[0]=="OK")
									{
										alert("응모가 완료되었습니다.\n당첨자 발표는 3월28일 입니다!");
										document.location.reload();
										return false;
									}
									else
									{
										errorMsg = res[1].replace(">?n", "\n");
										alert(errorMsg );
										return false;
									}
								} else {
									alert("잘못된 접근 입니다.");
									document.location.reload();
									return false;
								}
							}
						}
					},
					error:function(jqXHR, textStatus, errorThrown){
						alert("잘못된 접근 입니다.");
						var str;
						for(var i in jqXHR)
						{
							 if(jqXHR.hasOwnProperty(i))
							{
								str += jqXHR[i];
							}
						}
						alert(str);
						document.location.reload();
						return false;
					}
				});
			<% else %>
				return false;
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



function evtCouponIns()
{
	<% if vPrvOrderCnt < 1 then '// 이전 구매내역이 없을경우는 이벤트 기간내 구매내역이 있어도 1회 쿠폰발급 %>
		<% if vMyThisCouponCnt > 0 then '// 쿠폰 발급내역이 있으면 %>
			alert("쿠폰을 이미 다운받으셨습니다.");
			return;
		<% else %>
			$.ajax({
				type:"GET",
				url:"/event/etc/doEventSubscript69634.asp?mode=coupon",
				dataType: "text",
				async:false,
				cache:true,
				success : function(Data, textStatus, jqXHR){
					if (jqXHR.readyState == 4) {
						if (jqXHR.status == 200) {
							if(Data!="") {
								var str;
								for(var i in Data)
								{
									 if(Data.hasOwnProperty(i))
									{
										str += Data[i];
									}
								}
								str = str.replace("undefined","");
								res = str.split("|");
								if (res[0]=="OK")
								{
									alert("쿠폰이 발급되었습니다.");
									document.location.reload();
									return false;									
								}
								else
								{
									errorMsg = res[1].replace(">?n", "\n");
									alert(errorMsg );
									return false;
								}
							} else {
								alert("잘못된 접근 입니다.");
								document.location.reload();
								return false;
							}
						}
					}
				},
				error:function(jqXHR, textStatus, errorThrown){
					alert("잘못된 접근 입니다.");
					var str;
					for(var i in jqXHR)
					{
						 if(jqXHR.hasOwnProperty(i))
						{
							str += jqXHR[i];
						}
					}
					alert(str);
					document.location.reload();
					return false;
				}
			});		
		<% end if %>		
	<% end if %>
}


function evtOrderChk()
{
	<% If IsUserLoginOK() Then %>
		<% If not( left(now(),10)>="2016-03-14" and left(now(),10)<"2016-03-21" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
			$.ajax({
				type:"GET",
				url:"/event/etc/doEventSubscript69634.asp?mode=orderchk",
				dataType: "text",
				async:false,
				cache:true,
				success : function(Data, textStatus, jqXHR){
					if (jqXHR.readyState == 4) {
						if (jqXHR.status == 200) {
							if(Data!="") {
								var str;
								for(var i in Data)
								{
									 if(Data.hasOwnProperty(i))
									{
										str += Data[i];
									}
								}
								str = str.replace("undefined","");
								res = str.split("|");
								if (res[0]=="OK")
								{
									$("#ordercntval").empty().html(res[1]);
									$("#orderpriceval").empty().html(res[2]);
									$("#orderchkval").val("1");
									return false;									
								}
								else
								{
									errorMsg = res[1].replace(">?n", "\n");
									alert(errorMsg );
									return false;
								}
							} else {
								alert("잘못된 접근 입니다.");
								document.location.reload();
								return false;
							}
						}
					}
				},
				error:function(jqXHR, textStatus, errorThrown){
					alert("잘못된 접근 입니다.");
					var str;
					for(var i in jqXHR)
					{
						 if(jqXHR.hasOwnProperty(i))
						{
							str += jqXHR[i];
						}
					}
					alert(str);
					document.location.reload();
					return false;
				}
			});		
		<% end if %>		
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
		}
		return false;
	<% end if %>
}

</script>

<%' [W] 69634 깨끗한 산소방 %>
<div class="evt69634">
	<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/69634/tit_spring_v1.gif" alt="이전 구매 내역을 확인하세요! 산뜻 산뜻 봄바람" /></h2>
	<div class="article">
		<div class="get">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/69634/txt_get_list_v2.png" alt="이전 구매내역을 확인하세요! 구매 내역이 있다면 이벤트 기간 2016년 1월 1일부터 3월 31일 동안 1회 이상 구매시 사은품에 응모할 수 있어요. 무통장 주문건은 제외됩니다. 당첨자 발표는 3월 28일입니다." /></p>
			<ul>
				<%' for dev msg : 이전 구매내역, 로그인 전에는 * 표시해주세요 %>
				<li>
					<span class="area"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69634/txt_get_no.png" alt="구매횟수" /></span>
					<span class="area count"><b><span id="ordercntval">*</span></b> <img src="http://webimage.10x10.co.kr/eventIMG/2016/69634/txt_unit_no.png" alt="회" /></span>
				</li>
				<li>
					<span class="area"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69634/txt_get_amount.png" alt="구매금액" /></span>
					<span class="area count"><b><span id="orderpriceval">*</span></b> <img src="http://webimage.10x10.co.kr/eventIMG/2016/69634/txt_unit_won.png" alt="원" /></span>
				</li>
			</ul>
			<button type="button" class="btnCheck" onclick="evtOrderChk();return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69634/btn_check.png" alt="구매내역 확인하기" /></button>
		</div>

		<div class="gift">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/69634/txt_gift.jpg" alt="사은품에 응모하세요! 공기청정기 돌리고 황사 조심해방" usemap="#itemlink" /></p>
			<map name="itemlink" id="itemlink">
				<area shape="rect" coords="11,11,552,517" href="/shopping/category_prd.asp?itemid=1226544" alt="가정용 소형 공기청정기 에어비타 큐" />
			</map>
			<%' for dev msg : 응모하기 버튼 id="btnEnter"로 레이어팝업 스크립트 제어했어요. %>
			<button type="button" id="btnEnter" class="btnEnter" onclick="jsSubmit();return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69634/btn_enter.png" alt="응모하기" /></button>
		</div>
	</div>

	<%' for dev msg : 이전 구매내역이 없는 없을 경우 응모하기 버튼 클릭시 나오는 팝업 %>
	<div id="lyBox" class="lyBox">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/69634/txt_layer_coupon_v1.png" alt="아쉽게도 이벤트 대상이 아니시네요 ㅠㅠ 하지만 실망하지 마세요! 쇼핑을 즐길 수 있는 할인 쿠폰을 드 립니다!" /></p>
		<%' for dev msg : 쿠폰 다운받기 %>
		<button type="button" class="btnDown" onclick="evtCouponIns();return false;">쿠폰 다운받기</button>
		<button type="button" class="btnClose">닫기</button>
	</div>

	<div class="noti">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/69634/tit_noti.png" alt="이벤트 유의사항" /></h3>
		<ul>
			<li>- 응모하기는 이벤트 기간 중 1회만 가능합니다. </li>
			<li>- 1월1일~3월13일 구매내역이 있는 고객 중 이벤트 기간 (3월14일 ~ 20일)동안 구매내역이 있는 고객 대상으로 참여가 가능합니다.</li>
			<li>- 사은품 당첨자는 3월 28일 발표됩니다. </li>
			<li>- 환불이나 교환으로 인해 구매횟수나 구매금액이 충족되지 않을 경우 응모는 자동 취소 됩니다.</li>
			<li>- 이벤트는 조기종료 될 수 있습니다.</li>
		</ul>
	</div>

	<div id="dimmed"></div>
</div>
<form name="orderchkfrm" method="get">
	<input type="hidden" name="orderchkval" id="orderchkval">
</form>
<%' // 깨끗한 산소방 %>

<!-- #include virtual="/lib/db/dbclose.asp" -->
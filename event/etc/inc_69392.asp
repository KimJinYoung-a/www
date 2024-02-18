<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 백지수표
' History : 2016-02-29 원승현 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
Dim eCode, userid, vTotalCount, sqlstr, vCount, vTotalSum, currenttime, vTCount, evtLimitCnt, vQuery


IF application("Svr_Info") = "Dev" THEN
	eCode   =  66052
Else
	eCode   =  69392
End If

userid = GetEncLoginUserID()
currenttime = now()


'나의 참여수
vCount = getevent_subscriptexistscount(eCode, userid, "", "", "")

'이벤트 전체 참여수
vQuery = "SELECT count(*) FROM [db_event].[dbo].[tbl_event_subscript] WHERE convert(varchar(10), regdate, 120) = '" & Left(Trim(currenttime), 10) & "' AND evt_code = '" & eCode & "' "
rsget.CursorLocation = adUseClient
rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
IF Not rsget.Eof Then
	vTCount = rsget(0)
End IF
rsget.close


'//구매 내역 체킹 (응모는 3월 2일부터 4일까지 구매고객만 가능)
sqlStr = " EXEC [db_order].[dbo].[sp_Ten_MyOrderList_SUM] '" & userid & "', '', '', '2016-03-02', '2016-03-05', '10x10', '', 'issue' "

'response.write sqlStr & "<br>"
rsget.CursorLocation = adUseClient
rsget.CursorType = adOpenStatic
rsget.LockType = adLockOptimistic
rsget.Open sqlStr,dbget,1
	vTotalCount = rsget("cnt")
	vTotalSum   = CHKIIF(isNull(rsget("tsum")),0,rsget("tsum"))
rsget.Close


'// 일자별 응모횟수제한
Select Case Left(Trim(currenttime), 10)
	Case "2016-03-02"
		evtLimitCnt = 100

	Case "2016-03-03"
		evtLimitCnt = 150

	Case "2016-03-04"
		evtLimitCnt = 100

	Case Else
		evtLimitCnt = 0
End Select

%>
<style type="text/css">
img {vertical-align:top;}
.evt69392 {position:relative; background:#fff;}
.step01 {position:relative; width:600px; height:366px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69392/bg_step_01.png) no-repeat 0 0;}
.step01 h3 {padding:75px 0 57px;}
.step01 .history {position:absolute; left:295px; top:161px; width:252px; padding-top:14px; border-top:2px solid #c2d3f8;}
.step01 .history dl {overflow:hidden; line-height:16px; padding:9px 0;}
.step01 .history dt {float:left; text-align:left;}
.step01 .history dd {float:right; text-align:right;}
.step01 .history dd strong {color:#ffed89; font-size:20px; font-family:verdana; font-weight:normal; line-height:15px;}
.step01 .history p {padding-top:18px; margin-top:12px; border-top:2px solid #c2d3f8; text-align:center;}
.step02 {position:relative; height:507px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69392/bg_step_02.png) no-repeat 0 0;}
.step02 h3 {padding:60px 0 30px;}
.step02 .blankCheck {position:relative; width:564px; height:312px; margin:0 auto 24px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69392/img_check.png) no-repeat 0 0;}
.step02 .blankCheck .limit {position:absolute; right:-32px; top:-38px; z-index:30;}
.step02 .blankCheck .writeNum {overflow:hidden; position:absolute; left:123px; top:113px; width:420px;}
.step02 .blankCheck .writeNum input {display:inline-block; float:left; width:76px; height:76px; margin-right:26px; font-size:60px; line-height:76px; font-family:arial; text-align:center; color:#fa484c; border:0;}
.step02 .blankCheck .finish {position:absolute; left:0; top:0; z-index:20;}
.evtNoti {overflow:hidden; height:156px; padding:100px 0 0 120px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69392/bg_noti.png) no-repeat 0 0;}
.evtNoti h3 {float:left;}
.evtNoti ul {float:left; padding-left:50px; text-align:left; padding-top:10px; color:#fff; font-size:12px; line-height:24px; font-family:gulim;}
</style>
<script>

function jsSubmit(){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10)>="2016-03-02" and left(currenttime,10)<"2016-03-05" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
			<% if vCount > 0 then %>
				alert("이미 응모하셨습니다.");
				return;
			<% elseif vTCount >= evtLimitCnt then %>
				alert("금일 신청이 마감되었습니다.");
				return;

			<% elseif not(vTotalSum >= 100000) then %>
				alert("본 이벤트는 3월 2일 이후\n10만원이상 구매이력이 있는\n고객대상으로 참여가 가능합니다.");
				return;

			<% else %>

				if ($("#num1v").val()=="")
				{
					alert("마일리지 금액을 입력해주세요.");
					return false;
				}

				if ($("#num2v").val()=="")
				{
					alert("마일리지 금액을 입력해주세요.");
					return false;
				}

				if ($("#num3v").val()=="")
				{
					alert("마일리지 금액을 입력해주세요.");
					return false;
				}

				if ($("#num4v").val()=="")
				{
					alert("마일리지 금액을 입력해주세요.");
					return false;
				}
				var totalusermiligeVal;
				totalusermiligeVal = $("#num1v").val()+$("#num2v").val()+$("#num3v").val()+$("#num4v").val()

				$.ajax({
					type:"GET",
					url:"/event/etc/doEventSubscript69392.asp?milval="+totalusermiligeVal,
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
										alert("신청되었습니다!\n\n마일리지는 구매 완료된 고객분에 한하여\n3월15일에 발급될 예정입니다.");
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
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
		}
		return false;
	<% End IF %>
}

function onlyNumber(event){
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 9 || keyID == 46 || keyID == 37 || keyID == 39 ) 
		return;
	else
		alert("숫자만 입력가능합니다.");
		return;
}
function removeChar(event) {
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
		return;
	else
		event.target.value = event.target.value.replace(/[^0-9]/g, "");
}

</script>


<%' 백지수표 %>
<div class="evt69392">
	<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/69392/tit_blank_check.png" alt="백지수표" /></h2>
	<!-- 구매내역 확인 -->
	<div class="overHidden">
		<div class="step01 ftLt">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/69392/txt_step_01.png" alt="구매내역을 확인하세요" /></h3>
			<div class="history">
				<dl>
					<dt><img src="http://webimage.10x10.co.kr/eventIMG/2016/69392/txt_number_01.png" alt="구매횟수 :" /></dt>
					<dd><strong><% If IsUserLoginOK() Then %><%=vTotalCount%><% Else %>*<% End If %></strong> <img src="http://webimage.10x10.co.kr/eventIMG/2016/69392/txt_number_02.png" alt="회" /></dd>
				</dl>
				<dl>
					<dt><img src="http://webimage.10x10.co.kr/eventIMG/2016/69392/txt_price_01.png" alt="구매금액 :" /></dt>
					<dd><strong><% If IsUserLoginOK() Then %><%=FormatNumber(vTotalSum, 0)%><% Else %>*<% End If %></strong> <img src="http://webimage.10x10.co.kr/eventIMG/2016/69392/txt_price_02.png" alt="원" /></dd>
				</dl>
				<% If Not(IsUserLoginOK()) Then %>
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/69392/txt_login.png" alt="로그인후에 확인 할 수 있습니다." /></p>
				<% End If %>
			</div>
		</div>
		<div class="ftRt"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69392/txt_mileage.png" alt="10만원 이상 구매금액 확인하고 백지수표에 원하는 금액 입력하세요! (마일리지는 3월 15일에 구매완료된 고개분들께 지급될 예정입니다." /></div>
	</div>
	<%'// 구매내역 확인 %>

	<%' 마일리지 입력 %>
	<div class="step02">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/69392/txt_step_02.png" alt="금액을 입력해주세요" /></h3>
		<div class="blankCheck">
			<p class="limit"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69392/txt_limit.png" alt="선착순 100명" /></p>
			<div class="writeNum">
				<em><input type="text" name="num1" id="num1v" value="" title="마일리지 입력" maxLength="1" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;' /></em>
				<em><input type="text" name="num2" id="num2v" value="" title="마일리지 입력" maxLength="1" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;' /></em>
				<em><input type="text" name="num3" id="num3v" value="" title="마일리지 입력" maxLength="1" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;' /></em>
				<em><input type="text" name="num4" id="num4v" value="" title="마일리지 입력" maxLength="1" onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)' style='ime-mode:disabled;' /></em>
			</div>
			<% If vTCount >= evtLimitCnt Then %>
				<p class="finish"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69392/txt_finish.png" alt="금일 신청이 마감되었습니다" /></p>
			<% End If %>
		</div>
		<% If Not(vTCount >= evtLimitCnt) Then %>
			<button class="applyMg" onclick="jsSubmit();return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69392/btn_mileage.png" alt="마일리지 신청하기" /></button>
		<% End If %>
		
	</div>
	<%'// 마일리지 입력 %>

	<div class="evtNoti">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/69392/tit_noti.png" alt="이벤트 유의사항" /></h3>
		<ul>
			<li>- 본 이벤트는 3월 2일부터 4일까지 구매이력이 있는 고객 대상으로 참여가 가능합니다.</li>
			<li>- ID 당 1회만 신청이 가능합니다.</li>
			<li>- 신청된 마일리지는 지급일인 3월 15일 기준으로 구매 완료된 분에 한하여 지급될 예정입니다. (주문 취소 및 환불 제외)</li>
		</ul>
	</div> 
</div>
<%' // 백지수표 %>

<!-- #include virtual="/lib/db/dbclose.asp" -->
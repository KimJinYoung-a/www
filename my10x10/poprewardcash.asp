<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#######################################################
'	History	: 2018-11-29 이종화 생성
'	Description : 예치금 반환 신청
'#######################################################

	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 예치금 반환 신청"		'페이지 타이틀 (필수)
%>
<!-- #include virtual="/login/checkPopLogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_tenCashCls.asp" -->
<%
dim userid , username , vCurrentDeposit
userid = getEncLoginUserID
username = getLoginUserName

if Not(IsUserLoginOK) then
	Response.write "<script>alert('로그인하셔야 사용할 수 있습니다.');window.close();</script>"
	dbget.close()
	Response.End
end if

dim oTenCash
set oTenCash = new CTenCash
oTenCash.FRectUserID = userid
oTenCash.getUserCurrentTenCash

vCurrentDeposit = oTenCash.Fcurrentdeposit

if oTenCash.Fcurrentdeposit = 0 then
	Response.Write "<script>alert('예치금이 0원 입니다.');window.close();</script>"
	dbget.close()
	Response.End
end if

%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script type="text/javascript">
function returnToBankCash()
{
	var frm = document.frmReturnToBankCash;

	if(!frm.returncash.value){
		alert("반환 받으실 금액을 입력 해주세요.");
		frm.returncash.focus();
		return;
	}

	if(isNaN(frm.returncash.value))
	{
		alert("반환 받으실 금액을 정확히 입력해주세요");
		frm.returncash.value = frm.returncash.value.replace(/[^0-9]/g, "");
		frm.returncash.focus();
		return;
	}

	if(!frm.rebankname.value){
		alert("반환 받으실 계좌의 은행을 선택해주세요");
		return;
	}

	if(!frm.rebankaccount.value)
	{
		alert("반환 받으실 계좌번호를 입력해주세요.");
		frm.rebankaccount.focus();
		return;
	}

	if(isNaN(frm.rebankaccount.value)){
		alert("반환받으실 계좌번호를 정확히 입력해주세요.");
		frm.rebankaccount.value = frm.rebankaccount.value.replace(/[^0-9]/g, "");
		frm.rebankaccount.focus();
		return;
	}

	if (!frm.rebankownername.value){
		alert("반환 받으실 계좌의 예금주를 입력해주세요.");
		frm.rebankownername.value = "";
		frm.rebankownername.focus();
		return;
	}

	if((<%=vCurrentDeposit%>-document.getElementById("returncash").value) < 0)
	{
		alert("환불할 예치금이 <%=vCurrentDeposit%>보다 큽니다.\n<%=vCurrentDeposit%>이하로 입력해 주세요.");
		document.getElementById("returncash").value = "<%=vCurrentDeposit%>";
		document.getElementById("returncash").focus();
		return;
	}

	if(confirm("입력하신 계좌로\n예치금 반환을 신청하시겠습니까?") == true) {
		document.frmReturnToBankCash.submit();
	} else {
		return;
	}
}

function allreturn(){
	$("#returncash").val(<%=vCurrentDeposit%>);
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

$(function() {
	//selectbox
	$(".selectbox p").click(function(){
		if ($(this).closest(".selectbox").hasClass("current")) {
			$(this).closest(".selectbox").removeClass("current");
		} else {
			$(".selectbox").removeClass("current");
			$(this).closest(".selectbox").addClass("current");
		}
	});
	$(".selectbox li").click(function(){
		var selectedVal = $(this).text();
		$(this).closest("ul").prev("p").text(selectedVal);
		$('.selectbox p').css('color','#000');
		$(this).closest(".selectbox").removeClass("current");
		$("#rebankname").val($(this).attr('rel'));
	});
});
</script>
</head>
<body>
	<div class="heightgird popV18 deposit">
        <div class="popHeader">
            <h1>예치금 반환 신청</h1>
        </div>
        <div class="popContent">
            <%'!-- content --%>
            <div class="total-deposit">
                <div class="inner">
                    <h2>반환 가능한 예치금</h2>
                    <p><em><%= FormatNumber(vCurrentDeposit,0) %></em>원</p>
                </div>
            </div>
			<form name="frmReturnToBankCash" method="post" action="poprewardcash_proc.asp" style="margin:0px;">
			<input type="hidden" name="orderserial" value="">
			<input type="hidden" name="rebankname" id="rebankname" value="">
            <div class="section">
                <div class="table-wrap">
                    <table>
                        <caption>반환받을 계좌 입력</caption>
                        <colgroup>
                            <col style="width:200px;"> <col style="width:*;">
                        </colgroup>
                        <tbody>
                            <tr>
                                <th>반환 받을 금액(원)</th>
                                <td>
                                    <input type="text" name="returncash" id="returncash" class="returnDeposit" onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" style="width:136px;ime-mode:disabled;">
                                    <button class="btn-dark-grey2 btn-all" onclick="allreturn();return false;">전액</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="section">
                <h3>반환 받을 계좌 입력</h2>
                <p>입금 사고를 예방하기 위해 정확한 계좌정보를 입력해주세요.</p>
                <div class="table-wrap">
                    <table>
                        <caption>반환받을 계좌 입력</caption>
                        <colgroup>
                            <col style="width:200px;"> <col style="width:*;">
                        </colgroup>
                        <tbody>
                            <tr>
                                <th>은행 선택</th>
                                <td>
                                    <div class="selectbox" style="width:240px;">
										<p class="btn-linkV18 link1">은행을 선택해주세요.<span></span></p>
										<ul>
											<% call DrawBankComboForSCM%>
										</ul>
									</div>
                                </td>
                            </tr>
                            <tr>
                                <th>계좌번호</th>
                                <td><input type="text" name="rebankaccount" class="" onkeydown="return onlyNumber(event)" onkeyup="removeChar(event)" style="width:216px;ime-mode:disabled;" placeholder="계좌번호를 입력하세요."></td>
                            </tr>
                            <tr>
                                <th>예금주</th>
                                <td><input type="text" name="rebankownername" class="" style="width:216px;" placeholder="계좌상 예금주를 정확히 입력하세요." value=""></td><% ''예금주는 주문자와 다를 수 있습니다. %>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
			</form>
            <div class="noti"><i class="icon"></i>신청 후 약 2-3일 내 예치금 반환이 완료됩니다.</div>
            <div class="btn-area">
                <button class="btn-block btn-red" onclick="returnToBankCash();return false;">신청하기</button>
            </div>
            <%'!-- //content --%>
        </div>
	</div>
</body>
</html>
<%
    Set oTenCash = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->

<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/login/checkPopUserGuestLogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<%

'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 주문제작상품 문구수정"		'페이지 타이틀 (필수)
strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)

dim userid, orderserial, IsBiSearch, idx
userid = getEncLoginUserID
orderserial = requestCheckVar(request("orderserial"),11)
idx         = requestCheckVar(request("idx"),11)

if ((userid="") and session("userorderserial")<>"") then
	IsBiSearch = true
	orderserial = session("userorderserial")
end if

dim myorder
set myorder = new CMyOrder

if (IsUserLoginOK()) then
    myorder.FRectUserID = userid
    myorder.FRectOrderserial = orderserial
    myorder.GetOneOrder
elseif (IsGuestLoginOK()) then
    orderserial = GetGuestLoginOrderserial()
    myorder.FRectOrderserial = orderserial
    myorder.GetOneOrder
end if


dim myorderdetail
set myorderdetail = new CMyOrder
myorderdetail.FRectOrderserial = orderserial
myorderdetail.FRectIdx = idx

if myorder.FResultCount>0 then
    myorderdetail.GetOneOrderDetail
end if


dim i

if ((myorder.FResultCount<1) or (myorderdetail.FResultCount<1)) then
    response.write "<script language='javascript'>alert('주문 정보가 존재하지 않습니다.');</script>"
    response.write "<script language='javascript'>window.close();</script>"
    dbget.close()	:	response.End
end if


dim IsRequireDetailEditEnable
IsRequireDetailEditEnable = (myorderdetail.FOneItem.IsRequireDetailExistsItem) and (myorderdetail.FOneItem.IsEditAvailState)

'// 상품정보 표시 요청이 있는 경우 아래 페이지 참조
'// /2012www/my10x10/orderPopup/popEditHandMadeReq.asp

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script language='javascript'>

function editHandMadeRequire(frm){
    var detailArr='';
<% if (IsRequireDetailEditEnable) then %>
    if (frm.requiredetail != undefined) {
        if (frm.requiredetail.value.length < 1) {
            alert('주문 제작 문구를 입력해 주세요.');
            frm.requiredetail.focus();
            return;
        }

        if(GetByteLength(frm.requiredetail.value) > 500) {
    		alert('문구 입력은 최대 250자(한글 기준) 까지 가능합니다.\n\n현재 글자수 : ' + frm.requiredetail.value.length);
    		frm.requiredetailedit.focus();
    		return;
    	}
	}else{
	    <% if (myorderdetail.FOneItem.FItemNo>1) then %>
    	for (var i = 0; i < <%=myorderdetail.FOneItem.FItemNo%>; i++) {
			var obj = eval("frm.requiredetail" + i);

            if(GetByteLength(obj.value) > 500) {
    			alert('문구 입력은 최대 250자(한글 기준) 까지 가능합니다.\n\n현재 글자수 : ' + obj.value.length);
    			obj.focus();
    			return;
    		}

            detailArr = detailArr + obj.value + '||';
        }

        if(GetByteLength(detailArr) > 800) {
			alert('문구 입력합계는 최대 400자(한글 기준) 까지 가능합니다.\n\n현재 글자수 : ' + detailArr.length);
			frm.requiredetail0.focus();
			return;
		}
        <% end if %>
	}

	if (confirm('수정 하시겠습니까?')) {
		frm.submit();
	} else {
		return;
	}
<% else %>
    alert('수정 가능 상태가 아닙니다. 고객센터로 문의 해 주세요.');
    return;
<% end if %>
}

</script>
</head>
<body>
	<div class="heightgird">
		<!-- #include virtual="/lib/inc/incPopupHeader.asp" -->
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/inipay/tit_ordermade_edit.gif" alt="주문제작 문구 수정" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<div class="orderMade">

					<p class="ct fs12">
						상품문구는 최대 120자까지 가능합니다.
						<% if myorderdetail.FOneItem.FItemNo > 1 then %>
						<br />같은 상품을 2개 이상 주문하시고 문구를 다르게 하실 경우, <br />반드시 각각의 문구를 작성해주시기 바랍니다.<br />제작 문구가 같을경우 1번째 상품에만 입력하시기 바랍니다.
						<% end if %>
					</p>

<% if (myorderdetail.FResultCount>0) then %>
					<form name="frm" method="post" action="EditOrderInfo_process.asp">
					<input type="hidden" name="mode" value="edithandmadereq">
					<input type="hidden" name="orderserial" value="<%= orderserial %>">
					<input type="hidden" name="detailidx" value="<%= idx %>">

					<fieldset>
					<legend>주문제작 문구 수정하기</legend>
	<% if myorderdetail.FOneItem.FItemNo=1 then %>
						<textarea name="requiredetail" title="주문제작 문구 입력" cols="20" rows="4" class="tMar05" <% if (Not IsRequireDetailEditEnable) then %>readonly style="background-color:#EEEEEE;"<% end if %> ><%= chkIIF(myorderdetail.FOneItem.FrequiredetailUTF8="",myorderdetail.FOneItem.Frequiredetail,myorderdetail.FOneItem.FrequireDetailUTF8) %></textarea>
	<% else %>
		<% for i=0 to myorderdetail.FOneItem.FItemNo-1 %>
						<p class="tPad30"><strong><%= (i + 1) %>번 상품 문구</strong></p>
						<textarea name="requiredetail<%= i %>" title="<%= (i + 1) %>번 상품 주문제작 문구 입력" cols="20" rows="4" class="tMar05" <% if (Not IsRequireDetailEditEnable) then %>readonly style="background-color:#EEEEEE;"<% end if %> ><%= splitValue(chkIIF(myorderdetail.FOneItem.FrequiredetailUTF8="",myorderdetail.FOneItem.Frequiredetail,myorderdetail.FOneItem.FrequireDetailUTF8),CAddDetailSpliter,i) %></textarea>
		<% next %>
	<% end if %>
					</form>
<% end if %>

						<div class="btnArea ct tPad30">
							<input type="button" class="btn btnS1 btnRed btnW100" value="수정" onClick="editHandMadeRequire(document.frm);" />
							<button type="button" class="btn btnS1 btnGry btnW100" onClick="window.close();">취소</button>
						</div>
					</fieldset>

				</div>
				<!-- //content -->
			</div>
		</div>
		<!-- #include virtual="/lib/inc/incPopupFooter.asp" -->
	</div>
</body>
</html>
<%
set myorder = Nothing
set myorderdetail = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->

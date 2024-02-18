<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<% const MenuSelect = "02" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checkUserGuestlogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
	Dim userid , orderserial
	Dim oUniPassNumber, pflag
	Dim IsValidOrder : IsValidOrder = False	 '''정상 주문인가
	userid       = getEncLoginUserID()
	orderserial = requestCheckVar(request("orderserial"), 11)
	pflag		= requestCheckVar(request("pflag"),10)
    
    dim myorder, IsBiSearch
    set myorder = new CMyOrder
   
    if IsUserLoginOK() then
        myorder.FRectUserID = userid
        myorder.FRectOrderserial = orderserial
        myorder.GetOneOrder
    elseif IsGuestLoginOK() then
        myorder.FRectOrderserial = GetGuestLoginOrderserial()
        myorder.GetOneOrder
    
        IsBiSearch = True
        orderserial = myorder.FRectOrderserial
    end if

    if myorder.FResultCount<1 then
        dbget.close()
        response.end
    end if

	dim myorderdetail
	set myorderdetail = new CMyOrder
	myorderdetail.FRectOrderserial = orderserial
	myorderdetail.FRectOldjumun = CHKIIF(pflag="P","on","")

	if myorder.FResultCount>0 then
		myorderdetail.FRectUserID = userid
		myorderdetail.GetOrderDetail
		IsValidOrder = True
	end if

	'2020-10-20 상단 UI추가 정태훈
	dim orderState, i
	dim CurrStateCnt1 : CurrStateCnt1 = 0
	dim CurrStateCnt2 : CurrStateCnt2 = 0
	dim CurrStateCnt3 : CurrStateCnt3 = 0
	dim CurrStateCnt4 : CurrStateCnt4 = 0
	dim CurrStateCnt5 : CurrStateCnt5 = 0

	if ((myorder.FOneItem.FCancelyn="Y") or (myorder.FOneItem.FCancelyn="D")) then'취소
		orderState = "E"
	elseif ((myorder.FOneItem.Fjumundiv="6") or (myorder.FOneItem.Fjumundiv="9")) then'교환/반품
		orderState = "E"
	else
		if (myorder.FOneItem.FIpkumDiv="0") then'결제오류
			orderState = "E"
		elseif (myorder.FOneItem.FIpkumDiv="1") then'주문실패
			orderState = "E"
		elseif (myorder.FOneItem.FIpkumDiv="2") or (myorder.FOneItem.FIpkumDiv="3") then'결제 대기 중
			orderState = "S"
		else
			orderState = "S"
			for i=0 to myorderdetail.FResultCount-1
				if (IsNull(myorderdetail.FItemList(i).Fcurrstate) or (myorderdetail.FItemList(i).Fcurrstate="0")) and (myorderdetail.FItemList(i).Fcancelyn="N" or myorderdetail.FItemList(i).Fcancelyn="A") then'결제완료
					if myorderdetail.FItemList(i).Fisupchebeasong="Y" then
						CurrStateCnt1=CurrStateCnt1+1
					else
						if (datediff("n",myorder.FOneItem.FIpkumDate,now()) >= 30) then
							CurrStateCnt2=CurrStateCnt2+1
						else
							CurrStateCnt1=CurrStateCnt1+1
						end if
					end if
				elseif myorderdetail.FItemList(i).Fcurrstate="2" and (myorderdetail.FItemList(i).Fcancelyn="N" or myorderdetail.FItemList(i).Fcancelyn="A") then'상품 확인 중
					if myorderdetail.FItemList(i).Fisupchebeasong="Y" then
						CurrStateCnt2=CurrStateCnt2+1
					else
						if (datediff("n",myorder.FOneItem.Fbaljudate,now()) >= 30) then
							CurrStateCnt3=CurrStateCnt3+1
						else
							CurrStateCnt2=CurrStateCnt2+1
						end if
					end if
				elseif myorderdetail.FItemList(i).Fcurrstate="3" and (myorderdetail.FItemList(i).Fcancelyn="N" or myorderdetail.FItemList(i).Fcancelyn="A") then'상품 포장 중
					CurrStateCnt3=CurrStateCnt3+1
				elseif myorderdetail.FItemList(i).Fcurrstate="7" and (myorderdetail.FItemList(i).Fcancelyn="N" or myorderdetail.FItemList(i).Fcancelyn="A") and IsNull(myorderdetail.FItemList(i).Fdlvfinishdt) then'배송 시작
					CurrStateCnt4=CurrStateCnt4+1
				elseif myorderdetail.FItemList(i).Fcurrstate="7" and (myorderdetail.FItemList(i).Fcancelyn="N" or myorderdetail.FItemList(i).Fcancelyn="A") and not IsNull(myorderdetail.FItemList(i).Fdlvfinishdt) then'배송 완료
					CurrStateCnt5=CurrStateCnt5+1
				end if
			next
		end if
	end if

    if CurrStateCnt3>0 or CurrStateCnt4>0 or CurrStateCnt5>0 then
        dbget.close()
		response.write "<script>window.close();</script>"
        response.end
    end if

    set myorder = Nothing
    set myorderdetail = Nothing

	If orderserial <> "" Then oUniPassNumber = fnUniPassNumber(orderserial)
%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script>
function fnCustomNumberSubmit(){
	var frm =  document.frm;
	if(!frm.customNumber.value || frm.customNumber.value.length < 13){
		alert('13자리의 개인통관고유부호 를 입력 해주세요.');
		frm.customNumber.focus();
		return;
	}

	var str1 = frm.customNumber.value.substring(0,1);
	var str2 = frm.customNumber.value.substring(1,13);

	if((str1.indexOf("P") < 0) == true){
		alert('P로 시작하는 13자리 번호를 입력 해주세요.');
		frm.customNumber.focus();
		return;
	}

	var regNumber = /^[0-9]*$/;
	if (!regNumber.test(str2)){
		alert('번호를 숫자만 입력해주세요.');
		frm.customNumber.focus();
		return;
	}

	frm.target = "";
	frm.action = "/my10x10/orderPopup/popCustomsIdEdit_proc.asp";
	frm.submit();
}
</script>
</head>
<body>
	<div class="heightgird">
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2018/my10x10/tit_customs_id_edit.png" alt="주문정보변경" /></h1>
			</div>
			<div class="popContent">
				<div class="mySection">
					<fieldset>
						<form name="frm" method="post" onSubmit="return false">
						<input type="hidden" name="orderserial" value="<%=orderserial%>"/>
							<legend>개인통관 고유부호 수정 입력 폼</legend>
							<table class="baseTable rowTable docForm">
							<caption>개인통관 고유부호 수정</caption>
							<colgroup>
								<col width="140" /> <col width="*" />
							</colgroup>
							<tbody>
							</tr>
							<tr>
								<th scope="row"><label for="individualNum">개인통관 고유부호</label></th>
								<td><input type="text" id="individualNum" name="customNumber" class="txtInp focusOn" style="width:390px;" value="<%=oUniPassNumber%>" maxlength="13" /></td>
							</tr>
							</tbody>
							</table>

							<div class="btnArea ct tPad20">
								<input type="submit" class="btn btnS1 btnRed btnW100" value="수정" onclick="fnCustomNumberSubmit();"/>
								<button type="button" class="btn btnS1 btnGry btnW100" onclick="window.close();">취소</button>
							</div>
						</form>
					</fieldset>
				</div>
			</div>
		</div>
		<div class="popFooter">
			<div class="btnArea">
				<button type="button" class="btn btnS1 btnGry2" onclick="window.close();">닫기</button>
			</div>
		</div>
	</div>
</body>
</html>
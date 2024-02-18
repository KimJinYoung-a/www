<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/login/checkPopUserGuestLogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<%
'####################################################
' Description : 마이텐바이텐 - 환불 계좌 정보 수정
' History : 2020-11-24 정태훈 생성
'####################################################

dim userid, rebankname, rebankownername, encaccount
userid = getEncLoginUserID()

if userid<>"" then
    fnSoldOutMyRefundInfo userid, rebankname, rebankownername, encaccount
end if
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/popupV18.css">
<script>
function fnMyRefundInfoEdit(){
    frmedit = document.frmedit;
    if(frmedit.rebankname.value==""){
        alert('환불 받을 계좌의 은행을 선택해주세요.');
        frmedit.rebankname.focus();
        return;
    }
    if(frmedit.encaccount.value==""){
        alert('계좌번호를 정확히 입력해주세요.');
        frmedit.encaccount.focus();
        return;
    }
    if(frmedit.rebankownername.value==""){
        alert('예금주를 정확히 입력해주세요.');
        frmedit.rebankownername.focus();
        return;
    }
    if(confirm("입력된 환불 계좌 정보로 변경하시겠습니까?")){
        frmedit.submit();
    }
}
</script>
</head>
<body>
	<div class="heightgird popV18">
        <!-- #include virtual="/lib/inc/incPopupHeader.asp" -->
		<div class="popHeader">
			<h1>품절 시 처리 방법</h1>
		</div>
		<div class="popContent">
			<!-- content -->
			<div class="mySection">
				<div class="tPad25 bPad20">
					<ul class="list">
						<li>빠른 주문 처리를 위해 품절 발생 시 별도의 연락을 하지 않고 입력하신 계좌로 안전하게 환불해 드립니다.</li>
						<li>주문 취소일 기준, 3-5일(주말 제외) 후 환불 금액이 입금됩니다.</li>
					</ul>
				</div>
				<div class="">
                    <form name="frmedit" method="post" action="refundinfo_process.asp" style="margin:0px;">
					<table class="baseTable" style="table-layout:fixed">
						<caption>품절 시 처리 방법</caption>
						<colgroup>
							<col style="width:130px;" />
							<col style="width:170px;" />
							<col style="width:350px;" />
							<col style="width:auto;" />
						</colgroup>
						<tbody>
						<tr>
							<th scope="row">환불 계좌 정보</th>
							<td class="lt ">
								<select title="은행선택" name="rebankname" id="rebankname" class="select" style="width:120px;">
                                    <option value=''>선택</option>
                                    <option value='경남' <% if rebankname="경남" then response.write "selected" %>>경남</option>
                                    <option value='광주' <% if rebankname="광주" then response.write "selected" %>>광주</option>
                                    <option value='국민' <% if rebankname="국민" then response.write "selected" %>>국민</option>
                                    <option value='기업' <% if rebankname="기업" then response.write "selected" %>>기업</option>
                                    <option value='농협' <% if rebankname="농협" then response.write "selected" %>>농협</option>
                                    <option value='단위농협' <% if rebankname="단위농협" then response.write "selected" %>>단위농협</option>
                                    <option value='대구' <% if rebankname="대구" then response.write "selected" %>>대구</option>
                                    <option value='도이치' <% if rebankname="도이치" then response.write "selected" %>>도이치</option>
                                    <option value='부산' <% if rebankname="부산" then response.write "selected" %>>부산</option>
                                    <option value='산업' <% if rebankname="산업" then response.write "selected" %>>산업</option>
                                    <option value='새마을금고' <% if rebankname="새마을금고" then response.write "selected" %>>새마을금고</option>
                                    <option value='수협' <% if rebankname="수협" then response.write "selected" %>>수협</option>
                                    <option value='신한' <% if rebankname="신한" then response.write "selected" %>>신한</option>
                                    <option value='KEB하나' <% if rebankname="KEB하나" then response.write "selected" %>>KEB하나</option>
                                    <option value='우리' <% if rebankname="우리" then response.write "selected" %>>우리</option>
                                    <option value='우체국' <% if rebankname="우체국" then response.write "selected" %>>우체국</option>
                                    <option value='전북' <% if rebankname="전북" then response.write "selected" %>>전북</option>
                                    <option value='제일' <% if rebankname="제일" then response.write "selected" %>>제일</option>
                                    <option value='시티' <% if rebankname="시티" then response.write "selected" %>>시티</option>
                                    <option value='홍콩샹하이' <% if rebankname="홍콩샹하이" then response.write "selected" %>>홍콩샹하이</option>
                                    <option value='ABN암로은행' <% if rebankname="ABN암로은행" then response.write "selected" %>>ABN암로은행</option>
                                    <option value='UFJ은행' <% if rebankname="UFJ은행" then response.write "selected" %>>UFJ은행</option>
                                    <option value='신협' <% if rebankname="신협" then response.write "selected" %>>신협</option>
                                    <option value='제주' <% if rebankname="제주" then response.write "selected" %>>제주</option>
                                    <option value='현대스위스상호저축은행' <% if rebankname="현대스위스상호저축은행" then response.write "selected" %>>현대스위스상호저축은행</option>
                                    <option value='케이뱅크' <% if rebankname="케이뱅크" then response.write "selected" %>>케이뱅크</option>
                                    <option value='카카오뱅크' <% if rebankname="카카오뱅크" then response.write "selected" %>>카카오뱅크</option>
                                    <option value='토스뱅크' <% if rebankname="토스뱅크" then response.write "selected" %>>토스뱅크</option>
								</select>
							</td>
							<td class="lt">
								<label for="accountNum" class="bulletDot">계좌번호</label>
								<input type="text" name="encaccount" value="<%=encaccount%>" class="txtInp focusOn" style="width:220px;" placeholder="-를 제외하고 입력하시기 바랍니다." />
							</td>
							<td class="lt">
								<label for="accountHolder" class="bulletDot">예금주</label>
								<input type="text" name="rebankownername" value="<%=rebankownername%>" class="txtInp focusOn" style="width:100px;" />
							</td>
						</tr>
						</tbody>
					</table>
                    </form>
				</div>
				<div class="btnArea ct tPad40">
					<a href="javascript:fnMyRefundInfoEdit();" class="btn btnS1 btnRed btnW160"><span class="fn fs12">변경하기</span></a>
				</div>
			</div>
			<!-- //content -->
		</div>
	</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->
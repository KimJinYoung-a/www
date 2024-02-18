<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
dim OrderSerial

OrderSerial = requestCheckVar(request("ods"),20)

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script language="javascript">
<!--

	function onlyNumber(){
		if ((event.keyCode<48)||(event.keyCode>57)){
			alert('숫자를 입력해주세요');
			event.returnValue = false;
		}
	}

	function chkNext(frm, obj){
		if(obj != null){
			var tmpObj = null;

			if(typeof(obj) == "string"){
				tmpObj = document.getElementById(obj);
			} else {
				tmpObj = obj;
				if(frm.value.length == frm.maxLength){
					tmpObj.focus();
				}
			}
		}
	}

	function chkOK(){

		if(document.CardFrm.num1.value.length != document.CardFrm.num1.maxLength) {
			alert("카드번호를 전부 입력해 주세요");
			document.CardFrm.num1.focus();
		} else if(document.CardFrm.num2.value.length != document.CardFrm.num2.maxLength) {
			alert("카드번호를 전부 입력해 주세요");
			document.CardFrm.num2.focus();
		} else if(document.CardFrm.num3.value.length != document.CardFrm.num3.maxLength) {
			alert("카드번호를 전부 입력해 주세요");
			document.CardFrm.num3.focus();
		} else if(document.CardFrm.num4.value.length != document.CardFrm.num4.maxLength) {
			alert("카드번호를 전부 입력해 주세요");
			document.CardFrm.num4.focus();
		} else {
			if(!$("#cashbagAgree").is(":checked")){
				alert("OK캐쉬백 적립 및 정보제공에 동의해 주세요");
			}else{
				document.CardFrm.submit();
			}
		}
	}

	document.title='OKCashBag';

    //window.onload = function(){
	//	window.resizeTo(500,530);
	//}
//-->
</script>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
</head>
<body>
	<div class="heightgird">
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/inipay/tit_okcash_point.gif" alt="OK캐쉬백 포인트 적립 안내" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<form name="CardFrm" action="okcashbagProc.asp" method="POST" target="_self">
		        <input type="hidden" name="ods" value="<%= OrderSerial %>">
				<p class="fs15 cBk0V15 lh19"><strong>OK캐쉬백몰을 경유하여 구매하신 고객님께 <img src="http://fiximage.10x10.co.kr/web2013/inipay/okcash_symbol.gif" alt="OK Cashbag" class="vMiddle" /> 포인트를 <br />적립해 드립니다.</strong></p>
				<p class="tPad10 cGy1V15 lh19">구매 확정 후 익월 말에 적립되며, 카드번호를 입력하지 않으시거나 잘못 입력하실 경우 포인트 적립이 <br />불가하오니 주의하시기 바랍니다.</p>
				<h2 class="cBk0V15 tMar40">OK캐쉬백 카드 번호</h2>
				<div class="box5 pad20 ct tMar10">
					<input name="num1" type="text" class="txtInp ct" style="width:60px;ime-mode:disabled;" maxlength="4" onFocus="this.select();" OnKeypress="onlyNumber();" onKeyUp="chkNext(this, num2);" /> -
					<input name="num2" type="text" class="txtInp" style="width:60px;ime-mode:disabled;" maxlength="4" onFocus="this.select();" OnKeypress="onlyNumber();" onKeyUp="chkNext(this, num3);"/> -
					<input name="num3" type="text" class="txtInp" style="width:60px;ime-mode:disabled;" maxlength="4" onFocus="this.select();" OnKeypress="onlyNumber();" onKeyUp="chkNext(this, num4);"/> -
					<input name="num4" type="text" class="txtInp" style="width:60px;ime-mode:disabled;" maxlength="4" onFocus="this.select();" OnKeypress="onlyNumber();" onKeyUp="chkNext(this, btnok);"/>
				</div>
				<h2 class="cBk0V15 tMar40">OK캐쉬백 적립 동의</h2>
				<div class="box5 pad20 tMar10">
					<ul>
						<li class="cGy1V15 lPad10" style="text-indent:-10px;">- OK캐쉬백 적립을 위해 고객님의 카드번호, 이름, 결제금액, 주문번호 정보가 SK플래닛으로 제공되며 적립 후 고객문의 발생시 응대를 위해 2년 보관 후 자동 폐기됩니다.</li>
						<li class="cGy1V15 lPad10 tMar10" style="text-indent:-10px;">- 고객님께서는 동의거부 권리가 있으며, 동의 거부 시 포인트 추가 적립이 불가합니다.</li>
					</ul>
				</div>
				<p class="fs12 tMar10"><input type="checkbox" class="check" id="cashbagAgree" name="cashbagAgree" /> <label for="cashbagAgree">OK캐쉬백 적립 및 정보제공에 동의합니다.</label></p>
				<p class="ct tMar30"><a href="" class="btn btnM2 btnRed btnW220" onclick="chkOK();return false;">적립 신청</a></p>
				</form>
				<!-- //content -->
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


<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/MD5.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<%
	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : gift카드 재전송"		'페이지 타이틀 (필수)

''GIFT카드 주문내역에서만 사용가능
dim refer
refer = lcase(request.serverVariables("HTTP_REFERER"))

if InStr(refer,"giftcardorderdetail.asp")<1 then
	Call Alert_close("잘못된 접속입니다.")
	dbget.Close: response.End
end if
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/giftcard/giftcard_orderCls.asp" -->
<!-- #include virtual="/lib/classes/giftcard/giftcard_MyCardInfoCls.asp" -->
<%
	Dim IsValidOrder : IsValidOrder = False   '''정상 주문인가.
	Dim myorder, userid, i, giftorderserial
	userid = getEncLoginUserID()
	giftorderserial = requestCheckvar(request("idx"),15)

	set myorder = new cGiftcardOrder
	myorder.FUserID = userid
	myorder.Fgiftorderserial = giftorderserial
	myorder.getGiftcardOrderDetail
	
	
	If myorder.FResultcount > 0 Then
		IsValidOrder = true
	Else
		Response.Write "<script language='javascript'>alert('잘못된 주문번호 입니다.');</script>"
		dbget.close()
		Response.End
	End If
%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script type="text/javascript">
<!--

	//입력폼 검사
	function CheckForm(frm){

    	<% if myorder.FOneItem.FsendDiv="E" then %>
    	if(!(frm.chkMMS.checked||frm.chkEmail.checked)) {
			alert("재전송할 수단(모바일/이메일)을 선택해주세요.");
			return false;
	    }
	    <% end if %>

		// 전송정보(이메일)
		if(frm.chkMMS.checked) {
			if(!getFrmPhoneNum("frmorder","sendhp",true)) {return false;} else {frm.sendhp.value=getFrmPhoneNum("frmorder","sendhp",false);}
			if(!getFrmPhoneNum("frmorder","reqhp",true)) {return false;} else {frm.reqhp.value=getFrmPhoneNum("frmorder","reqhp",false);}
	
			if(!frm.MMSTitle.value) {
				alert("메시지 제목을 입력해주세요.");
				frm.MMSTitle.focus();
				return false;
			}
			if(getByteLength(frm.MMSContent.value)>200) {
				alert("메시지 내용은 200byte를 넘을 수 없습니다.");
				frm.MMSContent.focus();
				return false;
			}
		}
		<% if myorder.FOneItem.FsendDiv="E" then %>
		// 전송정보(이메일)
		if(frm.chkEmail.checked) {
			if(!getFrmEmail("frmorder","sendemail",true)) {return false;} else {frm.sendemail.value=getFrmEmail("frmorder","sendemail",false);}
			if(!getFrmEmail("frmorder","reqemail",true)) {return false;} else {frm.reqemail.value=getFrmEmail("frmorder","reqemail",false);}
			if(frm.reqemail.value!=getFrmEmail("frmorder","reqemail2",false)) {
				alert("받은분 이메일과 재확인 주소가 다릅니다.");
				frm.reqemail_Pre.focus();
				return false;
			}

			if(!frm.emailTitle.value) {
				alert("이메일 제목을 입력해주세요.");
				frm.emailTitle.focus();
				return false;
			}
			if(getByteLength(frm.emailContent.value)>400) {
				alert("이메일 내용은 400byte를 넘을 수 없습니다.");
				frm.emailContent.focus();
				return false;
			}
		}
		<% end if %>


    	if(frm.chkNewCode[1].checked) {
    		var ret = confirm('새로운 인증번호 재발송을 선택하셨습니다.\n이전에 전송된 입력한 인증번호는 더이상 사용할 수 없게 됩니다.\n\n선택한 내용으로 재전송 하시겠습니까?')
    	} else {
    		var ret = confirm('입력한 내용으로 재전송 하시겠습니까?')
    	}
    	if(ret){
    		frm.target = "iframeProc";
    		frm.action = "do_GiftCodeResend.asp";
    		return true;
    	} else {
    		return false;
    	}
	}

	//입력내용 길이검사/표시
	function chkContentLength(txt,ln,pfm) {
		if(getByteLength(txt)>ln) {
			document.getElementById(pfm).className = "red_11px";
		} else {
			document.getElementById(pfm).className = "";
		}
		document.getElementById(pfm).innerHTML = getByteLength(txt);
	}

	//문자열 Byte
	function getByteLength(inputValue) {
	     var byteLength = 0;
	     for (var inx = 0; inx < inputValue.length; inx++) {
	         var oneChar = escape(inputValue.charAt(inx));
	         if ( oneChar.length == 1 ) {
	             byteLength ++;
	         } else if (oneChar.indexOf("%u") != -1) {
	             byteLength += 2;
	         } else if (oneChar.indexOf("%") != -1) {
	             byteLength += oneChar.length/3;
	         }
	     }
	     return byteLength;
	 }

	//전화(휴대폰) 입력폼 검사
	function getFrmPhoneNum(fnm,inm,chk) {
	    var oPn, strRst="";

		for(var i=1; i<=3; i++) {
			oPn = eval(fnm + "." + inm + i);

		    if(chk) {
				if ((oPn.value.length<1)||(!IsDigit(oPn.value))){
					alert(oPn.alt + '을(를) 입력하세요.');
					oPn.focus();
					return false;
				}
			}
			if(i<3) {
				strRst+=oPn.value + "-";
			} else {
				strRst+=oPn.value;
			}
		}
		if(strRst=="--") strRst="";
		return strRst;
	}

	//이메일 입력폼 검사
	function getFrmEmail(fnm,inm,chk) {
	    var oPre = eval(fnm + "." + inm + "_Pre");
	    var oBx = eval(fnm + "." + inm + "_Bx");
	    var oTx = eval(fnm + "." + inm + "_Tx");
	    var strRst;

	    if(chk) {
		    if (oPre.value.length<1){
		        alert(oPre.alt + ' 주소를 입력해주세요.');
		        oPre.focus();
		        return false;
		    }
		    if (oBx.value.length<4){
		        if (!check_form_email(oPre.value + '@' + oTx.value)){
		            alert(oPre.alt + ' 주소가 올바르지 않습니다.');
		            oTx.focus();
		            return false;
		        }
		    }
		}
	    
	    if(oPre.value.length>0) {
		    if (oBx.value.length<4){
		        strRst = oPre.value + '@' + oTx.value;
		    }else{
		        strRst = oPre.value + '@' + oBx.value;
		    }
		}
	    return strRst;
	}

	//이메일 형태 검사
	function check_form_email(email){
		var pos;
		pos = email.indexOf('@');
		if (pos < 0){				//@가 포함되어 있지 않음
			return(false);
		}else{
			
			pos = email.indexOf('@', pos + 1)
			if (pos >= 0)			//@가 두번이상 포함되어 있음
				return(false);
		}
	
	
		pos = email.indexOf('.');
	
		if (pos < 0){				//@가 포함되어 있지 않음
			return false;
	    }
		return(true);
	}

	// 페이지 로드 완료시 각 입력내용 길이 표시
	$(function(){
		chkContentLength(frmorder.MMSContent.value,200,'mmsLen');
		<% if myorder.FOneItem.FsendDiv="E" then %>
		chkContentLength(frmorder.emailContent.value,400,'emailLen');
		<% end if %>
	});
//-->
</script>
</head>
<body>
	<div class="heightgird">
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_giftcard_resend.gif" alt="GIFT카드 재전송" /></h1>
			</div>
			<div class="popContent">
			<!-- content -->
			<form name="frmorder" method="POST" style="margin:0px" onsubmit="return CheckForm(this);">
			<input type=hidden name=cardid value="<%=giftorderserial%>">
			<input type=hidden name=sendemail value="">
			<input type=hidden name=sendhp value="">
			<input type=hidden name=reqemail value="">
			<input type=hidden name=reqhp value="">
			<input type=hidden name=sendDiv value="<%=myorder.FOneItem.FsendDiv="E" %>">
				<div class="mySection">
					<fieldset>
						<legend>GIFT카드 모바일/이메일 재전송</legend>
						<div class="crRed" style="text-align:right;">※ 인증번호 재전송은 2회까지 가능합니다.</div>
						<div class="radioBox resendSelect">
							<input type="radio" name="chkNewCode" value="N" id="sendOld" checked="checked" /><label for="sendOld">기존 인증번호 재전송</label>
							<input type="radio" name="chkNewCode" value="Y" id="sendNew" /><label for="sendNew">신규 인증번호 전송(이전 인증번호 무효처리)</label>
						</div>
						<!-- 모바일 재전송 -->
						<h2><input type="checkbox" id="mobileResend" name="chkMMS" value="Y" class="check" <%=chkIIF(myorder.FOneItem.FsendDiv="S","checked","")%> /> <label for="mobileResend" class="lPad05">모바일 재전송</label></h2>
						<table class="baseTable rowTable docForm">
						<caption>GIFT카드 모바일 재전송</caption>
						<colgroup>
							<col width="120" /> <col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<th scope="row">보내시는 분</th>
							<td>
								<select name="sendhp1" title="보내시는 분 휴대전화 앞자리 선택" class="select focusOn" style="width:78px;">
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="018">018</option>
									<option value="019">019</option>
								</select>
								<span class="symbol">-</span>
								<input name="sendhp2" type="text" maxlength="4" title="보내시는 분 휴대전화 가운데자리 입력" value="<%= Splitvalue(myorder.FOneItem.Fsendhp,"-",1) %>" class="txtInp" style="width:48px;" />
								<span class="symbol">-</span>
								<input name="sendhp3" type="text" maxlength="4" title="보내시는 분 휴대전화 뒷자리 입력" value="<%= Splitvalue(myorder.FOneItem.Fsendhp,"-",2) %>" class="txtInp" style="width:48px;" />
								<script type="text/javascript">
									document.frmorder.sendhp1.value="<%= Splitvalue(myorder.FOneItem.Fsendhp,"-",0) %>";
								</script>
							</td>
						</tr>
						<tr>
							<th scope="row">받으시는 분</th>
							<td>
								<select name="reqhp1" title="받으시는 분 휴대전화 앞자리 선택" class="select focusOn" style="width:78px;">
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="016">016</option>
									<option value="017">017</option>
									<option value="018">018</option>
									<option value="019">019</option>
								</select>
								<span class="symbol">-</span>
								<input name="reqhp2" type="text" maxlength="4" title="받으시는 분 휴대전화 가운데자리 입력" value="<%= Splitvalue(myorder.FOneItem.Freqhp,"-",1) %>" class="txtInp" style="width:48px;" />
								<span class="symbol">-</span>
								<input name="reqhp3" type="text" maxlength="4" title="받으시는 분 휴대전화 뒷자리 입력" value="<%= Splitvalue(myorder.FOneItem.Freqhp,"-",2) %>" class="txtInp" style="width:48px;" />
								<script type="text/javascript">
									document.frmorder.reqhp1.value="<%= Splitvalue(myorder.FOneItem.Freqhp,"-",0) %>";
								</script>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="msgTitle">메세지 제목</label></th>
							<td>
								<input type="text" id="msgTitle" name="MMSTitle" maxlength="40" class="txtInp" value="<%=myorder.FOneItem.FMMSTitle%>" style="width:92%;" />
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="sendMsg">전송메세지</label></th>
							<td>
								<textarea id="sendMsg" name="MMSContent" cols="60" rows="8" onkeyup="chkContentLength(this.value,200,'mmsLen')" style="width:94%; height:128px;"><%=myorder.FOneItem.FMMSContent%></textarea>
								<div class="tPad07 rPad15 rt fs11">(<span id="mmsLen">0</span>/200byte)</div>
							</td>
						</tr>
						</tbody>
						</table>
				<% if myorder.FOneItem.FsendDiv="E" then %>
						<!-- 이메일 재전송 -->
						<h2 class="tMar50"><input type="checkbox" id="emailResend" name="chkEmail" value="Y" class="check" /> <label for="emailResend" class="lPad05">이메일 재전송</label></h2>
						<table class="baseTable rowTable docForm">
						<caption>GIFT카드 이메일 재전송</caption>
						<colgroup>
							<col width="120" /> <col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<td colspan="2" class="ct">
								<div class="tPad10 bPad10"><img src="http://fiximage.10x10.co.kr/web2011/mytenbyten/mail_card_type<%=left(myorder.FOneItem.FdesignId,1) &"_"& right(myorder.FOneItem.FdesignId,2) %>.jpg" width="420" height="246" alt="텐바이텐 기프트카드 BASIC 디자인" /></div>
							</td>
						</tr>
						<tr>
							<th scope="row">보내시는 분</th>
							<td>
								<input type="text" name="sendemail_Pre" maxlength="40" title="보내시는 분 이메일 아이디 입력" value="<%= Splitvalue(myorder.FOneItem.Fsendemail,"@",0) %>" class="txtInp focusOn" style="width:118px;" />
								<span class="symbol">@</span>
								<% call DrawEamilBoxHTML("frmorder","sendemail_Tx","sendemail_Bx",Splitvalue(myorder.FOneItem.Fsendemail,"@",1)) %>
							</td>
						</tr>
						<tr>
							<th scope="row">받으시는 분</th>
							<td>
								<input type="text" name="reqemail_Pre" maxlength="40" title="받으시는 분 이메일 아이디 입력" value="<%= Splitvalue(myorder.FOneItem.Freqemail,"@",0) %>" class="txtInp focusOn" style="width:118px;" />
								<span class="symbol">@</span>
								<% call DrawEamilBoxHTML("frmorder","reqemail_Tx","reqemail_Bx",Splitvalue(myorder.FOneItem.Freqemail,"@",1)) %>

								<p class="tPad10 bPad10 fs11"><em class="crRed">- 받으시는 분의 메일주소를 다시 한번 입력해주세요</em></p>

								<input type="text" name="reqemail2_Pre" maxlength="40" title="받으시는 분 이메일 확인" value="" class="txtInp focusOn" style="width:118px;" />
								<span class="symbol">@</span>
								<% call DrawEamilBoxHTML("frmorder","reqemail2_Tx","reqemail2_Bx","") %>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="msgTitle01">메세지 제목</label></th>
							<td>
								<input type="text" id="msgTitle01" name="emailTitle" maxlength="60" class="txtInp" value="<%=myorder.FOneItem.FemailTitle%>" style="width:92%;" />
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="sendMsg02">전송메세지</label></th>
							<td>
								<textarea id="sendMsg02" name="emailContent" cols="60" rows="8" onkeyup="chkContentLength(this.value,400,'emailLen')" style="width:94%; height:128px;"><%=myorder.FOneItem.FemailContent%></textarea>
								<div class="tPad07 rPad15 rt fs11">(<span id="emailLen">0</span>/200byte)</div>
							</td>
						</tr>
						</tbody>
						</table>
						<!-- 이메일 재전송 -->
				<% end if %>

						<div class="btnArea ct tPad20">
							<input type="submit" class="btn btnS1 btnRed btnW100" value="재전송" />
							<button type="button" class="btn btnS1 btnGry btnW100" onclick="self.close();return false;">취소</button>
						</div>
					</fieldset>
				</div>
			</form>
			<iframe src="about:blank" name="iframeProc" width="0" height="0"></iframe>
			<!-- //content -->
			</div>
		</div>
		<!-- #include virtual="/lib/inc/incPopupFooter.asp" -->
	</div>
</body>
</html>
<% set myorder = Nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->

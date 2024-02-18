<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
	Response.AddHeader "Cache-Control","no-cache"
	Response.AddHeader "Expires","0"
	Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/classes/hitchhiker/hitchhikerCls.asp"-->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_userinfocls.asp" -->
<%
'// 2018 회원등급 개편

'#############################################################
'	Description : HITCHHIKER
'	History		: 2014.08.08 유태욱 생성
'#############################################################
%>
<%
Dim chkid, chklevel, evtID
Dim myprofile
Dim i, iHVol, HHVol
Dim userphone, usercell
iHVol = requestCheckVar(Request("iHV"),10)
chkid = getEncLoginUserID
chklevel =  GetLoginUserLevel
HHVol = ""

Dim dbstartdate , dbenddate
Dim startdate , enddate , deliverydate
rsget.open "select top 1 * from db_event.dbo.tbl_vip_hitchhiker where isusing= 'Y' and getdate()>startdate and getdate() <= enddate",dbget,1
If not rsget.eof Then
'	evtID = rsget("mevt_code")
	dbstartdate =  rsget("startdate")	'시작일
	dbenddate =  rsget("enddate")		'종료일
	deliverydate =  rsget("delidate")	'배송일
End If
rsget.close

function weekDayName(wd)
	select case wd
	case "1" wd = "일"
	case "2" wd = "월"
	case "3" wd = "화"
	case "4" wd = "수"
	case "5" wd = "목"
	case "6" wd = "금"
	case "7" wd = "토"
	end select
	weekDayName = wd
end function

Dim st_date , ed_date , dl_date
	st_date = left(dbstartdate,10)		'"2017-07-03"
	ed_date = left(dbenddate,10)			'"2017-07-16"
	dl_date = left(deliverydate,10)		'"2017-07-21"
	startdate		= dbstartdate & "("&weekDayName(Weekday(dbstartdate))&")"
	enddate		= ed_date & "("&weekDayName(Weekday(dbenddate))&")"
	deliverydate	= deliverydate & "("&weekDayName(Weekday(deliverydate))&")"

If IsUserLoginOK = False Then
	response.write "<script>alert('로그인이 필요한 서비스입니다.');top.location.href='"&wwwURL&"/hitchhiker/';</script>"
	response.end
End If

IF (chklevel <> 3 and chklevel <> 4 and chklevel <> 6 and chkid <> "kjy8517" and chkid <> "thensi7" and chkid <> "dream1103" And chkid <> "motions" and chkid <> "okkang77" and chkid <> "baboytw" and chkid <> "tozzinet"  and chkid <> "jj999a" and chkid <> "dlwjseh") THEN
	response.write "<script>alert('마이텐바이텐의 회원등급을 확인해주세요!');top.location.href='"&wwwURL&"/hitchhiker/';</script>"
	response.end
END IF

rsget.open "select top 1 * from db_event.dbo.tbl_vip_hitchhiker where isusing= 'Y' and getdate()>startdate and getdate() <= enddate",dbget,1
If not rsget.eof Then
	evtID = rsget("evt_code")
	iHVol = rsget("Hvol")
Else
	evtID = ""
	iHVol = "93"
End If
rsget.close

rsget.open "select top 1 * from [db_user].[dbo].[tbl_user_hitchhiker] where HVol = '"&iHVol&"' and userid = '"&chkid&"'",dbget,1
If not rsget.eof Then
	HHVol = rsget("Hvol")
Else
	HHVol = ""
End If
rsget.close

If HHVol <> "" Then
	response.write "<script>alert('고객님께서는 이미 히치하이커를 신청하셨습니다.\n배송지 수정을 원하실 경우 고객센터로 문의 바랍니다.');top.location.href='"&wwwURL&"/hitchhiker/';</script>"
	response.End
End If

If evtID="" and chkid <> "kjy8517" and chkid <> "dream1103" and chkid <> "thensi7" And chkid <> "motions" and chkid <> "okkang77" and chkid <> "baboytw" and chkid <> "tozzinet"  and chkid <> "jj999a" and chkid <> "10x10vvip" and chkid <> "10x10vipgold" and chkid <> "dlwjseh" Then
	response.write "<script>alert('지금은 주소 입력 기간이 아닙니다.');top.location.href='"&wwwURL&"/hitchhiker/';</script>"
	response.End
End If

Dim appCount
rsget.open "select count(1) as appCount from [db_user].[dbo].[tbl_user_hitchhiker] where HVol = '"&iHVol&"'",dbget,1
If not rsget.eof Then
	appCount = rsget("appCount")
Else
	appCount = 0
End If
rsget.close

If appCount > 10000 Then
	response.write "<script>alert('아쉽게도 선착순 신청이 마감되었어요!\n다음 기회에 참여해주세요 :)');top.location.href='"&wwwURL&"/hitchhiker/';</script>"
	response.End
End If

Dim oUserInfo, vzipCode, vAddress1, vAddress2, vuserphone, vusercell
Set oUserInfo = new CUserInfo
	oUserInfo.FRectUserID = chkid
If (chkid<>"") then
    oUserInfo.GetUserData
    If oUserInfo.FResultCount > 0 Then
    	vzipCode	= oUserInfo.FOneItem.FZipCode
    	vAddress1	= oUserInfo.FOneItem.FAddress1
    	vAddress2	= oUserInfo.FOneItem.FAddress2
    	vuserphone	= oUserInfo.FOneItem.Fuserphone
    	vusercell	= oUserInfo.FOneItem.Fusercell
	End If
End If
%>

<script type="text/javascript" src="http://www.10x10.co.kr/lib/js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">
	
function clearFields() {
    var frm = document.getElementById('frmorder');
    var em = frm.elements;
    //frm.reset();
    for(var i=0; i<em.length; i++) {
        if(em[i].type == 'text') em[i].value = '';
        if(em[i].type == 'checkbox') em[i].checked = false;
       // if(em[i].type == 'radio') em[i].checked = false;
        if(em[i].type == 'select-one') em[i].options[0].selected = true;
        if(em[i].type == 'textarea') em[i].value = '';
    }
    return;
}
function PopOldAddress(){
	var popwin = window.open('/my10x10/MyAddress/popMyAddressList.asp?sgubun=hitchhiker','popMyAddressList','width=600,height=300,scrollbars=yes,resizable=yes');
	popwin.focus();
}
function defaultAddr(){
	var frm = document.frmorder;
	frm.reqname.value = "<%=GetLoginUserName%>";

//	frm.txZip1.value = "<%' Splitvalue(vzipCode,"-",0) %>"
//	frm.txZip2.value = "<%' Splitvalue(vzipCode,"-",1) %>"
	frm.txZip.value = "<%= vzipCode %>"
	frm.txAddr1.value = "<%= doubleQuote(vAddress1) %>"
	frm.txAddr2.value = "<%= doubleQuote(vAddress2) %>"

	frm.reqphone1.value = "<%= Splitvalue(vuserphone,"-",0) %>"
	frm.reqphone2.value = "<%= Splitvalue(vuserphone,"-",1) %>"
	frm.reqphone3.value = "<%= Splitvalue(vuserphone,"-",2) %>"

	frm.reqhp1.value = "<%= Splitvalue(vusercell,"-",0) %>"
	frm.reqhp2.value = "<%= Splitvalue(vusercell,"-",1) %>"
	frm.reqhp3.value = "<%= Splitvalue(vusercell,"-",2) %>"
}
function jsSubmit(frm){
	if (frm.reqname.value == ''){
		alert('이름을 입력해 주세요.');
		frm.reqname.focus();
		return;
	}
	// 주소, 전화번호, 핸드폰 필수 정보입력
	if (frm.txZip.value.length<5){
		alert('우편번호를 입력해 주세요.');
		frm.txZip.focus();
		return;
	}

	/*
	if (frm.txAddr2.value.length<1){
		alert('나머지 주소를 입력해 주세요.');
		frm.txAddr2.focus();
		return;
	}
	*/

	if (frm.reqphone1.value.length<2){
		alert('전화번호1을 입력해 주세요.');
		frm.reqphone1.focus();
		return;
	}

	if (frm.reqphone2.value.length<2){
		alert('전화번호2을 입력해 주세요.');
		frm.reqphone2.focus();
		return;
	}

	if (frm.reqphone3.value.length<2){
		alert('전화번호3을 입력해 주세요.');
		frm.reqphone3.focus();
		return;
	}

	if (frm.reqhp1.value.length<2){
		alert('핸드폰번호1을 입력해 주세요.');
		frm.reqhp1.focus();
		return;
	}

	if (frm.reqhp2.value.length<2){
		alert('핸드폰번호2을 입력해 주세요.');
		frm.reqhp2.focus();
		return;
	}

	if (frm.reqhp3.value.length<2){
		alert('핸드폰번호3을 입력해 주세요.');
		frm.reqhp3.focus();
		return;
	}
	frm.submit();
}
</script>
<div class="lyHitchhiker window" style="height:654px; margin-top:-327px;">
	<div class="modalBox htype">
		<div class="modalHeader">
			<h1>
				<!--img src="http://fiximage.10x10.co.kr/web2013/hitchhiker/tit_vip_address.gif" alt="VIP 주소입력 이벤트" /-->
				<%=GetUserLevelStr(GetLoginUserLevel())%> 주소입력 이벤트
			</h1>
		</div>
		
		<form name="frmorder" id ="frmorder"  method="post" action="processhitchreceive.asp">
		<input type="hidden" name="chkid" value="<%=chkid%>">
		<input type="hidden" name="chklevel" value="<%=chklevel%>">
		<input type="hidden" name="iHVol" value="<%=iHVol%>">
		<input type="hidden" name="st_date" value="<%=dbstartdate%>">
		<input type="hidden" name="ed_date" value="<%=dbenddate%>">
		<input type="hidden" name="dl_date" value="<%=dl_date%>">
		<div class="modalBody vipAddress">
			<h2>
				<!--img src="http://fiximage.10x10.co.kr/web2013/hitchhiker/tit_vip_address_present.gif" alt="텐바이텐 VIP 고객님께 HITCHHIKER vol.64를 선물합니다!" /-->
				텐바이텐 <%=GetUserLevelStr(GetLoginUserLevel())%> 고객님께<br /><strong>vol.<%=iHVol%> HITCHHIKER를 선물합니다!</strong>
			</h2>
			<div class="addressOption">
<!-- 				<input type="radio" id="defaultAddress" name="r1" onclick="javascript:defaultAddr();" /> <label for="defaultAddress">기본 배송지 주소</label> -->
<!-- 				<input type="radio" id="newAddress" name="r1" onclick="javascript:clearFields();" /> <label for="newAddress">새로운 주소</label> -->
<!-- 				<a href="javascript:PopOldAddress();" name="r1" class="btn btnS2 btnGry"><span class="whiteArr01 fn">나의 주소록</span></a> -->
			</div>

				<fieldset>
					<legend>VIP 주소 정보 입력</legend>
					<table class="baseTable rowTable docForm">
					<caption class="visible">히치하이커를 받을 배송지 입력</caption>
					<colgroup>
						<col width="110" /> <col width="300" /> <col width="110" /> <col width="*" />
					</colgroup>
					<tbody>
					<tr>
						<th scope="row">아이디</th>
						<td><strong><%=chkid%></strong></td>
						<th scope="row"><label for="name">이름</label></th>
						<td><input type="text" name="reqname" id="name" class="txtInp" style="width:128px;" /></td>
					</tr>
					<tr>
						<th scope="row">주소</th>
						<td colspan="3">
							<div>
								<!--
								<input type="text" title="우편번호 앞자리" name="txZip1" class="txtInp focusOn" style="width:38px;" />
								<span class="symbol">-</span>
								<input type="text" title="우편번호 뒷자리" name="txZip2" class="txtInp focusOn rMar05" style="width:38px;" />
								<%'=vzipCode%>
								-->

								<input type="text" name="txZip" value="" readonly title="우편번호" class="txtInp focusOn" style="width:60px;" />
								<a href="javascript:TnFindZipNew('frmorder');" class="btn btnS1 btnGry2 rMar05"><span class="fn">우편번호찾기</span></a>
								<span class="fs11 ftDotum" style="padding-top:16px; padding-left:5px; color:#d53a3a;">우편발송이기 때문에 상세주소를 정확히 입력해주세요.</span>
							</div>
							<div class="tPad07">
								<input type="text" name="txAddr1" title="기본주소" readOnly class="txtInp" style="width:248px;" />
								<input type="text" name="txAddr2" title="상세주소" class="txtInp" style="width:248px;" />
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row">전화번호</th>
						<td>
							<select name="reqphone1" title="지역번호 선택" class="select" style="width:68px;">
								<option value="02">02</option>
								<option value="051">051</option>
								<option value="053">053</option>
								<option value="032">032</option>
								<option value="062">062</option>
								<option value="042">042</option>
								<option value="052">052</option>
								<option value="044">044</option>
								<option value="031">031</option>
								<option value="033">033</option>
								<option value="043">043</option>
								<option value="041">041</option>
								<option value="063">063</option>
								<option value="061">061</option>
								<option value="054">054</option>
								<option value="055">055</option>
								<option value="064">064</option>
								<option value="070">070</option>
								<option value="010">010</option>
								<option value="011">011</option>
								<option value="016">016</option>
								<option value="017">017</option>
								<option value="018">018</option>
								<option value="019">019</option>								
							</select>
							<span class="symbol">-</span>
							<input type="text" name="reqphone2" title="전화번호 앞자리 입력" class="txtInp" style="width:48px;" />
							<span class="symbol">-</span>
							<input type="text" name="reqphone3" title="전화번호 뒷자리 입력" class="txtInp" style="width:48px;" />
						</td>
						<th scope="row">휴대전화</th>
						<td>
							<select name="reqhp1" title="휴대전화 앞자리 선택" class="select" style="width:68px;">
								<option value="010">010</option>
								<option value="011">011</option>
								<option value="016">016</option>
								<option value="017">017</option>
								<option value="018">018</option>
								<option value="019">019</option>
							</select>
							<span class="symbol">-</span>
							<input type="text" name="reqhp2" title="휴대전화 가운데자리 입력" class="txtInp" style="width:48px;" />
							<span class="symbol">-</span>
							<input type="text" name="reqhp3" title="휴대전화 뒷자리 입력" class="txtInp" style="width:48px;" />
						</td>
					</tr>
					</tbody>
					</table>

					<div class="btnArea ct">
						<input type="button" class="btn btnM3 btnGry btnW130" onclick="javascript:jsSubmit(document.frmorder);" value="확인" />
					</div>
				</fieldset>

			<ul class="list">
				<li>본 회원정보와 주소가 동일하더라도 기간 내에 배송지 입력 및 확인 절차를 거쳐야 정상 발송됩니다.</li>
				<li>우편으로 발송되기 때문에 고객님께서 수령하시기까지는 발송일 기준으로 최대 1주일 가량 소요됩니다.</li>
				<li>주소입력 기간 내에 신청 필수로, 추가 발송이 진행되지 않는 점 양해부탁드립니다.</li>
			</ul>
			<div class="period">
				<strong>주소 입력 기간 및 일괄 발송일 안내</strong>
				<div class="date">
					<ul style="float:none; width:100%;">
						<!-- <li style="border-right:0;"><%=startdate%> ~ <%=enddate%> / 발송일 : <%=deliverydate%></li> -->
						<li style="border-right:0;">2022-10-31(월) ~ 2022-11-13(목) / 발송일 : 2022-11-25(금)</li>
					</ul>
				</div>
			</div>
		</div>
		</form>
		<button onclick="ClosePopLayer()" class="modalClose">닫기</button>
	</div>
</div>
<% Set oUserInfo = nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->
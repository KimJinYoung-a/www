<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'==========================================================================
'	Description: 나의 기념일 등록폼, 이영진
'	History: 2009.04.16
'==========================================================================
	Response.Expires = -1440
%>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/membercls/clsMyAnniversary.asp" -->
<%
	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 나의 기념일 등록 팝업"		'페이지 타이틀 (필수)
Dim idx		: idx		= req("idx","")
Dim yyyy,mm,dd

Dim obj	: Set obj = new clsMyAnniversary
obj.GetData idx


' 화면표시정보
Dim pageInfo1, pageInfo2, pageInfo3
If idx = "" Then
	pageInfo1 = "INS"
Else
	pageInfo1 = "UPD"
End If

If doubleQuote(obj.Item.memo)= "" Then
	obj.Item.memo="메모는 최대 30자까지 등록하실 수 있습니다."
end If
%>

<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script language='javascript'>
<!--

// 등록,수정 처리
function jsSubmit(mode)
{
	var f = document.frmWrite;
	if (!mode)
		if (f.idx.value=="")
			f.mode.value = "INS";
		else
			f.mode.value = "UPD";
	else
		f.mode.value = mode;

	if (!validField(f.setDay1, "날짜를"))	return ;
	if (!validField(f.title, "기념일명을"))		return ;
	if (!f.memo.value||f.memo.value=="메모는 최대 30자까지 등록하실 수 있습니다.")
	{
		alert("메모를 입력해주세요.");
		f.memo.value="";
		f.memo.focus();
		return false;
	}
	if (!validField(f.alarmcycle, "알람주기를"))		return ;

	f.submit();

}

function calendarOpen3(objTarget,caption,defaultval){
	 //var objTarget = document.getElementById(targetName);
	 /*
	 var ret = window.showModalDialog("/lib/calendar.asp?caption=" + caption + "&defaultval=" + defaultval , null, "dialogwidth:250px;dialogheight:230px;center:yes;scroll:no;resizable:no;status:no;help:no;");

	 if(ret!=''){
		objTarget.value=ret;
		return true;
	 }else{
		return false;
	 }
	 */

	 var fName = objTarget.form.name;
     var sName = objTarget.name;
     var winCal = window.open('/lib/common_cal.asp?FN='+fName+'&DN='+sName+'&defaultval='+defaultval+'','pCal','width=250, height=200');
     winCal.focus();
}

function jsChklogin11(blnLogin)
{
	var f = document.frmWrite;
	if (blnLogin == "True"){
		if(f.memo.value =="메모는 최대 30자까지 등록하실 수 있습니다."){
			f.memo.value="";
		}
		return true;
	} else {
		jsChklogin('<%=IsUserLoginOK%>');
	}

	return false;
}

function jsChkUnblur()
{
	var f = document.frmWrite;
	if(f.memo.value ==""){
		f.memo.value="메모는 최대 30자까지 등록하실 수 있습니다.";
	}
}

function Limit(obj)
{
   var maxLength = parseInt(obj.getAttribute("maxlength"));
   if ( obj.value.length > maxLength ) {
	alert("글자수는 최대 30자 입니다.");
	obj.value = obj.value.substring(0,maxLength);
	}
}

window.onload = function()
{
	resizeTo(645,644);
}

//-->
</script>
</head>
<body>
	<div class="heightgird">
		<!-- #include virtual="/lib/inc/incPopupHeader.asp" -->
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_my_anniversary_popup.gif" alt="나의 기념일" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<form name="frmWrite" method="post" action="popAnniversaryProc.asp">
				<input type="hidden" name="mode">
				<input type="hidden" name="idx" value="<%=obj.Item.idx%>">
				<div class="mySection">
					<fieldset>
						<legend>나의 기념일 신규등록 입력 폼</legend>
						<table class="baseTable rowTable docForm">
						<caption class="visible"> 나의 기념일 신규등록</caption>
						<colgroup>
							<col width="120" /> <col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<th scope="row"><label for="anniverName">기념일명<%response.write SplitValue(obj.Item.getsetday,"-",0)%></label></th>
							<td><input type="text" name="title" value="<%=doubleQuote(obj.Item.title)%>" maxlength="50" id="anniverName" class="txtInp" style="width:300px;" /></td>
						</tr>
						<tr>
							<th scope="row"><label for="anniverDate">날짜</label></th>
							<td>
								<select name="dayType" title="이메일 서비스 선택" id="anniverDate" class="select" style="width:70px;">
									<option value="S" <%If obj.Item.dayType = "S" Then response.write "selected" %>>양력</option>
									<option value="L" <%If obj.Item.dayType = "L" Then response.write "selected" %>>음력</option>
								</select>
								
								<input type="text" name="setDay1" value="<%=SplitValue(obj.Item.getsetday,"-",0)%>" maxlength="4" class="txtInp" style="width:50px;" />년
								<select name="setDay2" title="월 선택" class="select lMar05" style="width:70px;">
										<% For mm = 1 to 12 %>
											<% If mm < 10 Then mm = Format00(2,mm) End If %>
											<option value="<%=mm%>" <% IF SplitValue(obj.Item.getsetday,"-",1)=db2html(mm) Then response.write "selected" %>><%=mm%>월</option>
										<% Next %>
								</select>
								<select name="setDay3" title="일 선택" class="select lMar05" style="width:70px;">
										<% For dd = 1 to 31%>
											<% If dd < 10 Then dd =Format00(2,dd) End If %>
											<option value="<%=dd%>" <% IF SplitValue(obj.Item.getsetday,"-",2)=db2html(dd) Then response.write "selected" %>><%=dd%>일</option>
										<% Next%>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="anniverMemo">메모</label></th>
							<td>
								<textarea name="memo" value="<%=doubleQuote(obj.Item.memo)%>" maxlength="30" onClick="jsChklogin11('<%=IsUserLoginOK%>');" onblur="jsChkUnblur()" onKeyUp="jsChklogin11('<%=IsUserLoginOK%>');return Limit(this);" id="anniverMemo" cols="60" rows="5" style="width:96%; height:110px;"><%=doubleQuote(obj.Item.memo)%></textarea>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="anniverAlarm">알림</label></th>
							<td>
								<div class="radioBox">
									<input type="radio" name="alarmcycle" value="1" <% If doubleQuote(obj.Item.alarmcycle) = "1" Then response.write "checked" %> id="alarm1" /><label for="alarm1">없음</label>
									<input type="radio" name="alarmcycle" value="2" <% If doubleQuote(obj.Item.alarmcycle) = "2" Then response.write "checked" %> id="alarm2" /><label for="alarm2">한번</label>
									<input type="radio" name="alarmcycle" value="3" <% If doubleQuote(obj.Item.alarmcycle) = "3" Then response.write "checked" %> id="alarm4" /><label for="alarm4">매년</label>
									<input type="radio" name="alarmcycle" value="4" <% If doubleQuote(obj.Item.alarmcycle) = "4" Then response.write "checked" %> id="alarm5" /><label for="alarm5">100일마다</label>
								</div>
							</td>
						</tr>
						</tbody>
						</table>

						<div class="btnArea ct tPad20">
							<input type="button" onclick="jsSubmit('<%=pageInfo1%>')" class="btn btnS1 btnRed btnW100" value="등록" />
							<button type="button" onclick="window.close()" class="btn btnS1 btnGry btnW100">취소</button>
						</div>
					</fieldset>
				</div>
				</form>
				<!-- //content -->
			</div>
		</div>
<!-- #include virtual="/lib/inc/incPopupFooter.asp" -->
	</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->
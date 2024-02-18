<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/login/checkPopUserGuestLogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/ordercls/cardPartialCancelCls.asp"-->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<%

'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 신용카드 부분취소 리스트"		'페이지 타이틀 (필수)
strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)


Dim orderserial : orderserial=requestCheckvar(request("orderserial"),20)
Dim tid         : tid=requestCheckvar(request("tid"),100)
Dim i, rURi

dim userid
userid = getEncLoginUserID()


'rURi = "https://iniweb.inicis.com/DefaultWebApp/mall/cr/cm/mCmReceipt_head.jsp?" + "noTid=" + tid + "&noMethod=1" //2012-07-17;URL변경;허진원
rURi = "https://iniweb.inicis.com/app/publication/apReceipt.jsp?" + "noTid=" + tid + "&noMethod=1"

''본인 준문건인지 check
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

if (myorder.FResultCount<1) then
    myorder.FRectOldjumun = "on"
    if (IsUserLoginOK()) then
        myorder.FRectUserID = userid
        myorder.FRectOrderserial = orderserial
        myorder.GetOneOrder
    elseif (IsGuestLoginOK()) then
        orderserial = GetGuestLoginOrderserial()
        myorder.FRectOrderserial = orderserial
        myorder.GetOneOrder
    end if
end if

if (myorder.FResultCount<1) then
    response.write "정상주문건이 아닙니다."
    response.end
end if

''2015/08/04 추가
if (myorder.FOneItem.Fpggubun = "KA") then
    rURi = "https://mms.cnspay.co.kr/trans/retrieveIssueLoader.do?TID=" + tid + "&type=0"
end if


Dim ocardCancel
set ocardCancel = new CCardPartialCancel
ocardCancel.FRectOrderserial = orderserial
ocardCancel.getCardCancelList


if (ocardCancel.FResultCount<1) then
    set ocardCancel = Nothing
    dbget.Close()

    response.redirect rURi
    response.end
else

	'// 이하 신용카드 부분취소 리스트
	Dim sqlStr, ipkumdate, acctamount
	sqlStr = " select ipkumdate, P.acctamount from db_order.dbo.tbl_order_Master M"
	sqlStr = sqlStr & " 	left join db_order.dbo.tbl_order_Paymentetc P"
	sqlStr = sqlStr & " 	on M.orderserial=P.orderserial"
	sqlStr = sqlStr & " 	and P.acctdiv='100'"
	sqlStr = sqlStr & " where M.orderserial='"&orderserial&"'"

	rsget.Open sqlStr, dbget, 1
	if Not rsget.Eof then
		ipkumdate  = rsget("ipkumdate")
		acctamount = rsget("acctamount")
	end if
	rsget.close

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<style>
body, tr, td {font-size:9pt; font-family:굴림,verdana; color:#433F37; line-height:19px;}
table, img {border:none}

/* Padding ******/
.pl_01 {padding:1 10 0 10; line-height:19px;}
.pl_03 {font-size:20pt; font-family:굴림,verdana; color:#FFFFFF; line-height:29px;}

/* Link ******/
.a:link  {font-size:9pt; color:#333333; text-decoration:none}
.a:visited { font-size:9pt; color:#333333; text-decoration:none}
.a:hover  {font-size:9pt; color:#0174CD; text-decoration:underline}

.txt_03a:link  {font-size: 8pt;line-height:18px;color:#333333; text-decoration:none}
.txt_03a:visited {font-size: 8pt;line-height:18px;color:#333333; text-decoration:none}
.txt_03a:hover  {font-size: 8pt;line-height:18px;color:#EC5900; text-decoration:underline}

.buttoncss {
	font-family: "Verdana", "돋움";
	font-size: 9pt;
	background-color: #E6E6E6;
	border: 1px outset #BABABA;
	color: #000000;
	height: 20px;
	cursor:hand;
}

</style>
<script language='javascript'>
window.resizeTo(680,400);

function receiptinicis(tid){
	var receiptUrl = "https://iniweb.inicis.com/app/publication/apReceipt.jsp?" + "noTid=" + tid + "&noMethod=1";
	var popwin = window.open(receiptUrl,"INIreceipt","width=415,height=600,scrollbars=yes,resizable=yes");
	popwin.focus();
}

function receiptKakao(tid){
	var status = "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width=420,height=540";
    var url = "https://mms.cnspay.co.kr/trans/retrieveIssueLoader.do?TID="+tid+"&type=0";
    var popwin = window.open(url,"popupIssue",status);
	popwin.focus();
}

</script>
</head>
<body>
	<div class="heightgird">
		<!-- #include virtual="/lib/inc/incPopupHeader.asp" -->
		<div class="popWrap">

<table width="650" border="0" cellspacing="0" cellpadding="0">
    <tr>
	    <!---- 팝업제목 시작 ---->
	    <td valign="top" bgcolor="#af1414"><img src="http://fiximage.10x10.co.kr/web2011/mytenbyten/pop_reciept_sel_tit.gif" width="650" height="60"></td>
	    <!---- 팝업제목 끝 ---->
  	</tr>
  	<tr>
    	<td style="padding:0px 15px">

    		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		        <tr>
          			<td style="padding:25px 0 7px 0;">
		        		<b>신용카드 부분취소 증빙서류 내역입니다.</b>
          			</td>
        		</tr>
		       	<tr>
          			<td>

        <table width="100%" border="0" cellspacing="0" cellpadding="0" style="border-top:solid 3px #be0808; border-bottom:solid 1px #eaeaea; padding-top:3px;">
        <tr align="center" height="30" bgcolor="#fcf6f6">
            <td width="60" style="border-bottom:solid 1px #eaeaea;" >구분</td>
            <td width="60" style="border-bottom:solid 1px #eaeaea;" >취소차수</td>
            <td style="border-bottom:solid 1px #eaeaea;" >결제일</td>
            <td style="border-bottom:solid 1px #eaeaea;" >취소요청일</td>
            <td width="100" style="border-bottom:solid 1px #eaeaea;" >취소액</td>
            <td width="100" style="border-bottom:solid 1px #eaeaea;" >승인잔액</td>
            <td width="100" style="border-bottom:solid 1px #eaeaea;" >전표</td>
        </tr>
        <tr align="center" height="30" bgcolor="#FFFFFF" >
            <td align="center" >최초<br>승인 </td>
            <td >&nbsp;</td>
            <td ><%= ipkumdate %></td>
            <td >&nbsp;</td>
            <td >&nbsp;</td>
            <td ><%= FormatNumber(acctamount,0) %></td>
            <%
			if (myorder.FOneItem.Fpggubun = "KA") then
				rURi = "javascript:receiptKakao('" + tid + "');"
			else
				rURi = "javascript:receiptinicis('" + tid + "');"
			end if
            %>
            <td ><a href="<%= rURi %>"><img src="http://fiximage.10x10.co.kr/web2009/mytenbyten/cs_icon01.gif" border="0"></a></td>
        </tr>

        <% for i=0 to ocardCancel.FResultCount-1 %>
        <tr align="center" height="30" bgcolor="#FFFFFF" style="border-top:solid 1px #eaeaea;">
            <td style="border-top:solid 1px #eaeaea;">취소 </td>
            <td style="border-top:solid 1px #eaeaea;"><%= ocardCancel.FItemList(i).Fcancelrequestcount%></td>
            <td style="border-top:solid 1px #eaeaea;">&nbsp;</td>
            <td style="border-top:solid 1px #eaeaea;"><%= ocardCancel.FItemList(i).Fregdate%></td>
            <td style="border-top:solid 1px #eaeaea;"><%= FormatNumber(ocardCancel.FItemList(i).Fcancelprice,0) %></td>
            <td style="border-top:solid 1px #eaeaea;"><%= FormatNumber(ocardCancel.FItemList(i).Frepayprice,0)%></td>
            <%
			if (myorder.FOneItem.Fpggubun = "KA") then
				rURi = "javascript:receiptKakao('" + ocardCancel.FItemList(i).Fnewtid + "');"
			else
				rURi = "javascript:receiptinicis('" + ocardCancel.FItemList(i).Fnewtid + "');"
			end if
            %>
            <td style="border-top:solid 1px #eaeaea;"><a href="<%= rURi %>"><img src="http://fiximage.10x10.co.kr/web2009/mytenbyten/cs_icon01.gif" border="0"></a></td>
        </tr>
        <% next %>
        </table>
            </td>
            </tr>
        </table>
</td></tr>
</table>

		</div>
		<!-- #include virtual="/lib/inc/incPopupFooter.asp" -->
	</div>
</body>
</html>
<%

end if

set myorder = nothing
set ocardCancel = Nothing

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->

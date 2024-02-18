<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head_SSL.asp" -->
<%
Dim userid : userid=getEncLoginUserID
Dim empno, isIdentify, usercell
Dim smsconfirm : smsconfirm = requestCheckvar(request("smsconfirm"),10)

if Not (GetLoginUserLevel()="7" or GetLoginUserLevel()="8") then
    response.write "<script>alert('직원만 접속 가능합니다.(1)');</script>"
    dbget.close()	: response.end
end if

Dim sqlStr

sqlStr = "select A.empno, isNULL(A.isIdentify,'N') as isIdentify, isNULL(A.usercell,'') as usercell "&VbCRLF
sqlStr = sqlStr&"FROM db_partner.dbo.tbl_user_tenbyten as A "&VbCRLF
sqlStr = sqlStr&"where A.isusing=1 "&VbCRLF
sqlStr = sqlStr&"	and A.frontid='"&userid&"' "&VbCRLF
sqlStr = sqlStr&"	and (A.statediv='Y' or (A.statediv='N' and datediff(d,getdate(),A.retireday)>=0)) "
rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly
IF Not (rsget.EOF OR rsget.BOF) THEN
    empno = rsget("empno")
    isIdentify = rsget("isIdentify")
    usercell   = rsget("usercell")
END IF
rsget.Close()

if (empno="") then
    response.write "<script>alert('직원만 접속 가능합니다.(2)');</script>"
    dbget.close()	: response.end
end if

''인증번호 확인
if (smsconfirm<>"") then
    sqlStr = "select USBTokenSn " &VbCRLF
    sqlStr = sqlStr & " from db_log.dbo.tbl_partner_login_log " &VbCRLF
    sqlStr = sqlStr & " where userid='" & empno & "' " &VbCRLF
    sqlStr = sqlStr & " 	and loginSuccess='W' " &VbCRLF
    sqlStr = sqlStr & " 	and datediff(ss,regdate,getdate()) between 0 and 180"
    rsget.Open sqlStr,dbget,1
    if rsget.EOF or rsget.BOF  then
    	response.write("<script>window.alert('입력 제한시간이 초과되었습니다.\n다시 인증번호를 발급받아 입력해주세요.');location.href='/inipay/popLocalUserConfirm.asp';</script>")
    	dbget.close()	:	response.End
    else
    	if trim(rsget("USBTokenSn"))<>trim(smsconfirm) then
    		response.write("<script>window.alert('휴대폰으로 발송된 인증번호값이 아닙니다.\n정확히 입력해주세요.');</script>")
    	else
    	    '' OK
    	    session("tnsmsok")="ok"
    	    response.write("<script>opener.authPs();window.close();</script>")
            dbget.close()	:	response.End
    	end if
    end if
    rsget.Close
end if
%>

<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup_ssl.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script language='javascript'>
function popSMSAuthNo() {
    <% if (request.ServerVariables("SERVER_PORT_SECURE")<>1) then %>
    hidFrm.location.href="http://<%= CHKIIF(application("Svr_Info")="Dev","test","") %>scm.10x10.co.kr/admin/member/tenbyten/do_LocalUser_SendSMS.asp?empno=<%=empno%>"+"&lstp=W";
    <% else %>
	hidFrm.location.href="<%= CHKIIF(application("Svr_Info")="http:","https:","") %>//<%= CHKIIF(application("Svr_Info")="Dev","test","") %>scm.10x10.co.kr/admin/member/tenbyten/do_LocalUser_SendSMS.asp?empno=<%=empno%>"+"&lstp=W";
	<% end if %>

	document.getElementById("smsInput").style.display = "block";
	document.frmauth.smsconfirm.focus();
}

function PopChgHPNum() {
    alert('본인확인을 아직 받지 않은 아이디입니다.\n웹어드민 본인 확인 후 이용가능합니다.');
}

function confirmSMS(){
    if (document.frmauth.smsconfirm.value.length<1){
        alert('인증번호를 입력해 주세요.');
        return;
    }
    document.frmauth.submit();

}

function systemAlert(message) {
    alert(message);
}
window.addEventListener("message",function(event) {
    var data = event.data;
    if (typeof(window[data.action]) == "function") {
        window[data.action].call(null, data.message);
    }  
},false);
</script>
<style type="text/css">
.localUser .popHeader {padding:12px 15px;}
.localUser h1 {color:#fff; font-size:24px; font-weight:bold; font-family:dotum, dotumche, '돋움', '돋움체', sans-serif;}
</style>
</head>
<div class="heightgird">
		<div class="popWrap localUser">
			<div class="popHeader">
				<h1>직원 SMS 인증</h1>
			</div>
			<div class="popContent" align="center">
			<form name="frmauth" method="post" action="" onsubmit="confirmSMS();return false;">
				<!-- content -->
				<% if (usercell="") then %>
				회원 정보에 휴대폰 번호가 없습니다.
				<br>SCM 에서 USB키를 사용하여 로그인 후 휴대폰정보를 입력해주세요.
				<% elseif (isIdentify<>"Y") then %>
				SCM 본인 인증 후 사용 가능합니다.
				<br>SCM 휴대폰 인증 로그인 후 본인인증 가능 합니다.
				<br>
				<% else %>
				<p class="fs12">인증번호 발송 휴대폰 번호 : <strong><%= usercell %></strong></p>
				<p class="tPad10"><button type="button" class="btn btnS1 btnGry btnW120 fn" onclick="popSMSAuthNo();">인증번호 받기</button></p>
				<div class="tMar30 tPad30" id="smsInput" style="display:<%=CHKIIF(smsconfirm<>"","","none")%>; border-top:dashed 1px #ccc;">
					<p class="fs12">
						인증번호 입력 : <input type="text" name="smsconfirm" class="txtInp" style="width:80px" />
						<button type="button" class="btn btnS1 btnRed btnW100 fn" onclick="confirmSMS();">인증번호 확인</button>
					</p>
				</div>
				<% end if %>
			</form>
			</div>
		</div>
		<div class="popFooter">
			<div class="btnArea">
				<button type="button" class="btn btnS1 btnGry2" onclick="window.close();">닫기</button>
			</div>
		</div>
	</div>
<iframe id="hidFrm" name="hidFrm" src="about:blank" frameborder="0" width="0" height="0"></iframe>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->
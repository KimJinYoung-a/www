<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/login/checkPopLogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_myfavoritePlayCls.asp" -->
<%
Dim sMode,suserid, ievt_code, arrevt_code
Dim clsMFE
Dim iReturnValue, chkPop
sMode 	= requestCheckvar(request("hidM"),1)
suserid  = getEncLoginUserID
arrevt_code = requestCheckvar(request("chkevt"),200)
chkPop = requestCheckvar(request("pop"),1)

SELECT CASE sMode
CASE "D" 
	set clsMFE = new CProcMyFavoritePlay
		clsMFE.FUserId	 		= suserid
		clsMFE.FFavCode	 	= arrevt_code
		iReturnValue 			= clsMFE.fnDelMyFavoriteEvent
	set clsMFE = nothing
	IF iReturnValue = 1 THEN  
		%>
	<script type="text/javascript"> 
		alert("선택하신 Play가 삭제되었습니다.");
		top.location.reload();
		self.location.href = "about:blank"; 
	</script>
<%
	ELSE
		%>
	<script type="text/javascript"> 
		alert("데이터 처리에 문제가 발생하였습니다.고객센터에 문의해주세요");
		self.location.href = "about:blank"; 
	</script>
<%
	END IF	
CASE ELSE
	%>
	<script type="text/javascript"> 
		alert("데이터 처리에 문제가 발생하였습니다.고객센터에 문의해주세요");
		self.location.href = "about:blank"; 
	</script>
<%
END SELECT
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
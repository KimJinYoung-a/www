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
<!-- #include virtual="/lib/classes/membercls/sp_myfavoriteEventCls.asp" -->
<%
Dim sMode,suserid, ievt_code, arrevt_code
Dim clsMFE
Dim iReturnValue, chkPop
sMode 	= requestCheckvar(request("hidM"),1)
suserid  = getEncLoginUserID
ievt_code= requestCheckvar(request("eventid"),10)
arrevt_code = requestCheckvar(request("chkevt"),200)
chkPop = requestCheckvar(request("pop"),1)

If  sMode <> "D" then
	If ievt_code ="" THEN
			%>
		<script type="text/javascript"> 
			alert("데이터 처리에 문제가 발생하였습니다.고객센터에 문의해주세요");
			self.location.href = "about:blank"; 
		</script>
	<%		
	END If
End If 
SELECT CASE sMode
CASE "I"
	set clsMFE = new CProcMyFavoriteEvent
		clsMFE.FUserId	 	= suserid
		clsMFE.Fevtcode	 	= ievt_code
		iReturnValue 			= clsMFE.fnSetMyFavoriteEvent
	set clsMFE = nothing
	
	if chkPop="L" then
		Response.Write iReturnValue
	else
		IF iReturnValue <> 0 THEN 
%>
	<script type="text/javascript"> 
		var winME = window.open("/my10x10/pop_myfavoriteEvent.asp","popME","width=350,height=210");
		winME.focus(); 
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
		response.end
		END IF
	end if
CASE "D" 
	set clsMFE = new CProcMyFavoriteEvent
		clsMFE.FUserId	 	= suserid
		clsMFE.Fevtcode	 	= arrevt_code
		iReturnValue 			= clsMFE.fnDelMyFavoriteEvent
	set clsMFE = nothing
	IF iReturnValue = 1 THEN  
		%>
	<script type="text/javascript"> 
		alert("선택하신 이벤트가 삭제되었습니다.");
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
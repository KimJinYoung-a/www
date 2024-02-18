<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<%
'####################################################
' Description :  컬쳐스테이션 #07. 바로 그, [진실공방]
' History : 2015.03.16 유태욱 생성
'####################################################
%>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim eCode, eCodelink, userid, eventnewexists, mode, sqlstr, refer, coupongubun, vIsAllDown
dim subscriptcount, couponnewcount

	IF application("Svr_Info") = "Dev" THEN
		eCode   =  62773
		eCodelink = 62773
	Else
		eCode   =  62962
		eCodelink = 62962
	End If
	

	userid = getloginuserid()
	mode = requestcheckvar(request("mode"),32)
	coupongubun = requestcheckvar(request("coupongubun"),3)

refer = request.ServerVariables("HTTP_REFERER")
if InStr(refer,"10x10.co.kr")<1 then
	Response.Write "잘못된 접속입니다."
	dbget.close() : Response.End
end if

If userid = "" Then
		Response.Write "<script type='text/javascript'>alert('로그인을 해주세요');</script>"
	dbget.close() : Response.End
End IF

If Now() > #05/28/2015 23:59:59# Then
	Response.Write "<script type='text/javascript'>alert('이벤트 응모 기간이 아닙니다.');</script>"
	dbget.close() : Response.End
End IF

if mode="couponinsert" then
	sqlstr = "select count(sub_idx) from [db_event].[dbo].[tbl_event_subscript] where evt_code = "& eCode &" and userid = '" & userid & "'"
	rsget.Open sqlstr,dbget,1
	IF rsget(0) > 2 Then
		vIsAllDown = "o"
	Else
		vIsAllDown = "x"
	End IF
	rsget.close
	
	If vIsAllDown = "o" Then
		Response.Write "<script type='text/javascript'>alert('쿠폰은 ID당 1회만 발급 받으실 수 있습니다.'); top.location.reload();</script>"
		dbget.close() : Response.End
	End If
	
	
	if coupongubun="1" or coupongubun="all" then
		sqlstr = "IF NOT EXISTS(select sub_idx from [db_event].[dbo].[tbl_event_subscript] where evt_code = "& eCode &" and userid = '" & userid & "' and sub_opt1 = '1' and sub_opt2 = '1') " + vbcrlf
		sqlstr = sqlstr & " BEGIN" + vbcrlf
		sqlstr = sqlstr & " 	INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, sub_opt2, sub_opt3)" + vbcrlf
		sqlstr = sqlstr & " 	VALUES("& eCode &", '" & userid & "', '1', 1, 'PC1')" + vbcrlf
		sqlstr = sqlstr & " END"
		'response.write sqlstr & "<Br>"
		dbget.execute sqlstr
		sqlstr = "insert into [db_user].[dbo].tbl_user_coupon" + vbcrlf
		sqlstr = sqlstr & " (masteridx,userid,coupontype,couponvalue, couponname,minbuyprice,targetitemlist,startdate,expiredate,couponmeaipprice,validsitename) " + vbcrlf
		sqlstr = sqlstr & " 	SELECT "& get1couponid &", '"&userid&"',m.coupontype,m.couponvalue,m.couponname,m.minbuyprice,m.targetitemlist,m.startdate,m.expiredate,m.couponmeaipprice,m.validsitename " + vbcrlf
		sqlstr = sqlstr & " 	from [db_user].[dbo].tbl_user_coupon_master m" + vbcrlf
		sqlstr = sqlstr & " 	left join [db_user].[dbo].tbl_user_coupon uc" + vbcrlf
		sqlstr = sqlstr & " 		on m.idx=uc.masteridx" + vbcrlf
		sqlstr = sqlstr & " 		and uc.deleteyn='N'" + vbcrlf
		sqlstr = sqlstr & " 		and uc.isusing='N'" + vbcrlf
		sqlstr = sqlstr & " 		and uc.userid='"&userid&"'" + vbcrlf		
		sqlstr = sqlstr & " 	where m.idx="& get1couponid &" and uc.masteridx is null"
		'response.write sqlstr & "<Br>"
		dbget.execute sqlstr
	end if
	
	if coupongubun="3" or coupongubun="all" then
		sqlstr = "IF NOT EXISTS(select sub_idx from [db_event].[dbo].[tbl_event_subscript] where evt_code = "& eCode &" and userid = '" & userid & "' and sub_opt1 = '1' and sub_opt2 = '3') " + vbcrlf
		sqlstr = sqlstr & " BEGIN" + vbcrlf
		sqlstr = sqlstr & " 	INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, sub_opt2, sub_opt3)" + vbcrlf
		sqlstr = sqlstr & " 	VALUES("& eCode &", '" & userid & "', '1', 3, 'PC3')" + vbcrlf
		sqlstr = sqlstr & " END"
		'response.write sqlstr & "<Br>"
		dbget.execute sqlstr		
		sqlstr = "insert into [db_user].[dbo].tbl_user_coupon" + vbcrlf
		sqlstr = sqlstr & " (masteridx,userid,coupontype,couponvalue, couponname,minbuyprice,targetitemlist,startdate,expiredate,couponmeaipprice,validsitename) " + vbcrlf
		sqlstr = sqlstr & " 	SELECT "& get3couponid &", '"&userid&"',m.coupontype,m.couponvalue,m.couponname,m.minbuyprice,m.targetitemlist,m.startdate,m.expiredate,m.couponmeaipprice,m.validsitename " + vbcrlf
		sqlstr = sqlstr & " 	from [db_user].[dbo].tbl_user_coupon_master m" + vbcrlf
		sqlstr = sqlstr & " 	left join [db_user].[dbo].tbl_user_coupon uc" + vbcrlf
		sqlstr = sqlstr & " 		on m.idx=uc.masteridx" + vbcrlf
		sqlstr = sqlstr & " 		and uc.deleteyn='N'" + vbcrlf
		sqlstr = sqlstr & " 		and uc.isusing='N'" + vbcrlf
		sqlstr = sqlstr & " 		and uc.userid='"&userid&"'" + vbcrlf		
		sqlstr = sqlstr & " 	where m.idx="& get3couponid &" and uc.masteridx is null"
		'response.write sqlstr & "<Br>"
		dbget.execute sqlstr
	end if
	
	if coupongubun="7" or coupongubun="all" then
		sqlstr = "IF NOT EXISTS(select sub_idx from [db_event].[dbo].[tbl_event_subscript] where evt_code = "& eCode &" and userid = '" & userid & "' and sub_opt1 = '1' and sub_opt2 = '7') " + vbcrlf
		sqlstr = sqlstr & " BEGIN" + vbcrlf
		sqlstr = sqlstr & " 	INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, sub_opt2, sub_opt3)" + vbcrlf
		sqlstr = sqlstr & " 	VALUES("& eCode &", '" & userid & "', '1', 7, 'PC7')" + vbcrlf
		sqlstr = sqlstr & " END"
		'response.write sqlstr & "<Br>"
		dbget.execute sqlstr		
		sqlstr = "insert into [db_user].[dbo].tbl_user_coupon" + vbcrlf
		sqlstr = sqlstr & " (masteridx,userid,coupontype,couponvalue, couponname,minbuyprice,targetitemlist,startdate,expiredate,couponmeaipprice,validsitename) " + vbcrlf
		sqlstr = sqlstr & " 	SELECT "& get7couponid &", '"&userid&"',m.coupontype,m.couponvalue,m.couponname,m.minbuyprice,m.targetitemlist,m.startdate,m.expiredate,m.couponmeaipprice,m.validsitename " + vbcrlf
		sqlstr = sqlstr & " 	from [db_user].[dbo].tbl_user_coupon_master m" + vbcrlf
		sqlstr = sqlstr & " 	left join [db_user].[dbo].tbl_user_coupon uc" + vbcrlf
		sqlstr = sqlstr & " 		on m.idx=uc.masteridx" + vbcrlf
		sqlstr = sqlstr & " 		and uc.deleteyn='N'" + vbcrlf
		sqlstr = sqlstr & " 		and uc.isusing='N'" + vbcrlf
		sqlstr = sqlstr & " 		and uc.userid='"&userid&"'" + vbcrlf		
		sqlstr = sqlstr & " 	where m.idx="& get7couponid &" and uc.masteridx is null"
		'response.write sqlstr & "<Br>"
		dbget.execute sqlstr
	end if

	Response.Write "<script type='text/javascript'>alert('쿠폰이 발급 되었습니다! \n2015-05-31까지 사용하세요!'); top.location.reload();</script>"
	dbget.close() : Response.End
	
else
	Response.Write "<script type='text/javascript'>alert('정상적인 경로가 아닙니다.'); parent.top.location.href='/event/eventmain.asp?eventid="&eCodelink&"'</script>"
	dbget.close() : Response.End
end if


function get1couponid()'1만원이상구매시 10프로
	dim couponid
	
	IF application("Svr_Info") = "Dev" THEN
		couponid   =  391
	Else
		couponid   =  737
	End If
	
	get1couponid = couponid
end function

function get3couponid()'3만원이상구매시 5000원
	dim couponid
	
	IF application("Svr_Info") = "Dev" THEN
		couponid   =  392
	Else
		couponid   =  738
	End If
	
	get3couponid = couponid
end function

function get7couponid()'7만원이상구매시 10000원
	dim couponid
	
	IF application("Svr_Info") = "Dev" THEN
		couponid   =  393
	Else
		couponid   =  739
	End If
	
	get7couponid = couponid
end function
%>

<!-- #include virtual="/lib/db/dbclose.asp" -->
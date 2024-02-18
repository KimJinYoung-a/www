<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<%
'#######################################################
'	History	:  2010.04.09 한용민 수정
'	Description : 위시리스트 관리
'#######################################################
%>
<!-- #include virtual="/login/checkPopLogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_myfavoritecls.asp" -->
<%

dim i, sqlStr , viewisusing , userid, bagarray, mode, itemid, wishEvent, wishEventOX, vECode
dim foldername,fidx,backurl , arrList, intLoop,stype , myfavorite, intResult, vOpenerChk
	userid  		= getEncLoginUserID
	stype    		= requestCheckvar(request("hidM"),1)
	viewisusing    	= "Y"
	foldername  	= "넣어둬 넣어둬"
	fidx			= requestCheckvar(request("fidx"),9)
	backurl		= requestCheckvar(request("backurl"),100)
	bagarray	= Trim(requestCheckvar(request("bagarray"),1024))
	mode    	= requestCheckvar(request("mode"),16)
	itemid  	= requestCheckvar(request("itemid"),9)
	vOpenerChk	= requestCheckvar(request("op"),1)

	IF application("Svr_Info") = "Dev" THEN
		vECode = "21473"
	Else
		vECode = "59604"
	End If
%>
<!-- #include virtual="/my10x10/event/include_samename_folder_check.asp" -->
<%
SELECT CASE stype
	CASE "I"	'폴더추가

		set myfavorite = new CMyFavorite
			myfavorite.FRectUserID = userid
			myfavorite.FFolderName = foldername
			myfavorite.fviewisusing = viewisusing
			intResult = myfavorite.fnSetFolder
		set myfavorite = nothing

		IF intResult > 0  THEN
			Set wishEvent = new CMyFavorite
				wishEvent.FRectUserID	= userid
				wishEvent.FFolderIdx	= intResult
				wishEvent.fnWishListEventSave

				wishEventOX = wishEvent.FResultCount
			Set wishEvent = Nothing

			If wishEventOX = "x" Then
				Response.Write "<script>alert('데이터 처리에 문제가 생겼습니다.');</script>"
				dbget.close()
				Response.End
			ElseIf wishEventOX = "o" Then
				sqlStr = "if exists(select top 1 * from db_temp.dbo.tbl_wishlist_event where evt_code="& vECode &" and userid='"& userid &"')" + vbcrlf
				sqlStr = sqlStr & " begin" + vbcrlf
				sqlStr = sqlStr & " 	delete from db_temp.dbo.tbl_wishlist_event where evt_code="& vECode &" and userid='"& userid &"'" + vbcrlf
				sqlStr = sqlStr & " end"

				'response.write sqlstr
				dbget.execute(sqlStr)
				
'				sqlStr = "if not exists(select top 1 * from db_user.dbo.tbl_user_coupon where masteridx=686 and userid='"& userid &"')" + vbcrlf
'				sqlStr = sqlStr & " begin" + vbcrlf
'				sqlStr = sqlStr & " 	insert into [db_user].[dbo].tbl_user_coupon" + vbcrlf
'				sqlStr = sqlStr & " 	(masteridx,userid,coupontype,couponvalue, couponname,minbuyprice,targetitemlist,startdate,expiredate,couponmeaipprice,validsitename)" + vbcrlf
'				sqlStr = sqlStr & " 		SELECT " + vbcrlf
'				sqlStr = sqlStr & " 		m.idx, '"& userid &"', m.coupontype, m.couponvalue, m.couponname, m.minbuyprice, m.targetitemlist" + vbcrlf
'				sqlStr = sqlStr & " 		, m.startdate, m.expiredate, m.couponmeaipprice, m.validsitename" + vbcrlf
'				sqlStr = sqlStr & " 		from [db_user].[dbo].tbl_user_coupon_master m" + vbcrlf
'				sqlStr = sqlStr & " 		where m.isusing='Y' and m.idx=686" + vbcrlf
'				sqlStr = sqlStr & " end"
'
'				'response.write sqlstr
'				dbget.execute(sqlStr)
'
'				sqlStr = "if not exists(select top 1 * from db_user.dbo.tbl_user_coupon where masteridx=687 and userid='"& userid &"')" + vbcrlf
'				sqlStr = sqlStr & " begin" + vbcrlf
'				sqlStr = sqlStr & " 	insert into [db_user].[dbo].tbl_user_coupon" + vbcrlf
'				sqlStr = sqlStr & " 	(masteridx,userid,coupontype,couponvalue, couponname,minbuyprice,targetitemlist,startdate,expiredate,couponmeaipprice,validsitename)" + vbcrlf
'				sqlStr = sqlStr & " 		SELECT " + vbcrlf
'				sqlStr = sqlStr & " 		m.idx, '"& userid &"', m.coupontype, m.couponvalue, m.couponname, m.minbuyprice, m.targetitemlist" + vbcrlf
'				sqlStr = sqlStr & " 		, m.startdate, m.expiredate, m.couponmeaipprice, m.validsitename" + vbcrlf
'				sqlStr = sqlStr & " 		from [db_user].[dbo].tbl_user_coupon_master m" + vbcrlf
'				sqlStr = sqlStr & " 		where m.isusing='Y' and m.idx=687" + vbcrlf
'				sqlStr = sqlStr & " end"
'
'				'response.write sqlstr
'				dbget.execute(sqlStr)

				Call JoinEvent(vECode)

				Response.Write "<script>"
				Response.Write "	alert('넣어둬 넣어둬 폴더가 생성되었습니다.\n힌트를 보고 그에 맞는 상품을 담아 주세요.');"
				Response.Write "	parent.location.href='/my10x10/mywishlist.asp';"
				Response.Write "</script>"
				dbget.close() : Response.End
			End IF

		ELSEIF 	intResult =-1 THEN
			Alert_return("폴더는 10개까지만 등록가능합니다.")
			dbget.Close
			response.end
		ELSE
			Alert_return("데이터처리에 문제가 발생했습니다.")
			dbget.Close
			response.end
		END IF

END SELECT

Function JoinEvent(evt_code)
Dim vQuery
	vQuery = "IF NOT EXISTS(SELECT userid FROM [db_event].[dbo].[tbl_event_comment] WHERE evt_code = '" & evt_code & "' AND userid = '" & getEncLoginUserID & "') " & vbCrLf
	vQuery = vQuery & "BEGIN " & vbCrLf
	vQuery = vQuery & "		INSERT INTO [db_event].[dbo].[tbl_event_comment](evt_code,userid,evtcom_txt,evtcom_point,evtcom_regdate,evtcom_using,evtbbs_idx,evtgroup_code,refip,blogurl,device) " & vbCrLf
	vQuery = vQuery & "		SELECT '" & evt_code & "','" & getEncLoginUserID & "','','0',getdate(),'Y','0','0','" & Request.ServerVariables("REMOTE_ADDR") & "',null,'W'" & vbCrLf
	vQuery = vQuery & "END "
	dbget.execute(vQuery)
End Function
%>

<!-- #include virtual="/lib/db/dbclose.asp" -->
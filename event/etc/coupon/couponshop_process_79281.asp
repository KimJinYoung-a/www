<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
'####################################################
' Description : 쿠폰이벤트용 처리페이지
' History : 2016-05-17 유태욱
'####################################################
%>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
Dim sub_opt1, sub_opt2, sub_opt3, strSql, sql
Dim idx, arridx, stype, arrstype, i, userid, mode, reval, eCode
	sub_opt2 = 0
	idx = Request("idx")			'쿠폰 idx
	stype = Request("stype")	'발급 종류
	reval = Request("reval")
	mode = requestcheckvar(request("mode"),32)
	eCode = requestcheckvar(request("eCode"),32)
	sub_opt1 = requestcheckvar(request("sub_opt1"),32)
	sub_opt2 = requestcheckvar(request("sub_opt2"),32)
	sub_opt3 = requestcheckvar(request("sub_opt3"),32)
	arridx = split(idx,",")
	arrstype = split(stype,",")
	userid  = GetencLoginUserID

'// 로그인 여부 체크
If Not(IsUserLoginOK) Then
	Response.Write "02|로그인 후 참여하실 수 있습니다."
	response.End
End If

dim getbonuscoupon
IF application("Svr_Info") = "Dev" THEN
	eCode = "66416"
	getbonuscoupon = 2854
Else
	eCode = "79281"
	getbonuscoupon = 1000
End If

dim couponexistscount
	couponexistscount = getbonuscouponexistscount(userid, getbonuscoupon, "", "", "")

if couponexistscount <> 0 then
	Response.Write "13||이미 쿠폰을 받으셨습니다."
	dbget.close() : Response.End
end if

If now() > #09/30/2017 23:59:59# then
	Response.Write "12||기간이 종료되었거나 유효하지 않은 쿠폰입니다."
	dbget.close() : Response.End
end If

if mode = "cpok" then
	sql = "insert into [db_user].[dbo].tbl_user_coupon"
	sql = sql & " (masteridx,userid,coupontype,couponvalue, couponname,minbuyprice,targetitemlist,startdate,expiredate,couponmeaipprice,validsitename)"
	sql = sql & " 	SELECT idx, '"& userid &"',coupontype,couponvalue,couponname,minbuyprice,targetitemlist, getdate(), dateadd(hh, +24, getdate()),couponmeaipprice,validsitename"		'startdate,expiredate
	sql = sql & " 	from [db_user].[dbo].tbl_user_coupon_master m"
	sql = sql & " 	where idx="& getbonuscoupon &""

	'response.write sql & "<Br>"
	dbget.execute sql

	Response.Write "11||쿠폰이 발급되었습니다."
	dbget.close() : Response.End

else
	Response.Write "00||정상적인 경로가 아닙니다."
	dbget.close() : Response.End	
end if

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->

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
' Description : ���� �δ� Ʈ��
' History : 2016.02.17 ���¿� ����
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim systemyn, couponidx
dim subscriptcount, itemcouponcount
dim mode, sqlstr, eCode, userid, currenttime, i
	mode = requestcheckvar(request("mode"),32)

	IF application("Svr_Info") = "Dev" THEN
		eCode = "66032"
		couponidx = "2768"
	Else
		eCode = "69218"
		couponidx = "826"
	End If

	currenttime = now()
'	currenttime = #02/22/2016 10:05:00#
	
	systemyn=TRUE		''	FALSE
	subscriptcount=0
	itemcouponcount=0
	userid = GetEncLoginUserID()

dim refer
	refer = request.ServerVariables("HTTP_REFERER")
if InStr(refer,"10x10.co.kr")<1 then
	Response.Write "{ "
	response.write """ytcode"":""01"""	''||�߸��� �����Դϴ�.
	response.write "}"
	dbget.close()	:	response.End
end If

If not(left(currenttime,10)>="2016-02-18" and left(currenttime,10)<"2016-02-23") Then
	Response.Write "{ "
	response.write """ytcode"":""03"""	''||�̺�Ʈ �Ⱓ�� �ƴմϴ�.
	response.write "}"
	dbget.close()	:	response.End
End IF

if mode="coupondown" then
	If userid = "" Then
		Response.Write "{ "
		response.write """ytcode"":""02"""	''||�α����� ���ּ���
		response.write "}"
		dbget.close()	:	response.End
	End IF

	'//���� ���� ����
	if userid<>"" then
		subscriptcount = getevent_subscriptexistscount(eCode, userid, "", "", "")
		itemcouponcount = getbonuscouponexistscount(userid, couponidx, "", "", "")
	end if

	if subscriptcount>0 or itemcouponcount>0 then
		Response.Write "{ "
		response.write """ytcode"":""04"""	''||�Ѱ��� ���̵�� �ѹ��� �߱� �����մϴ�.
		response.write "}"
		dbget.close()	:	response.End
	end if

	if  not(systemyn) then
		Response.Write "{ "
		response.write """ytcode"":""05"""	''||��� �� �ٽ� �õ��� �ּ���.
		response.write "}"
		dbget.close()	:	response.End
	end if

	sqlstr = "insert into [db_user].[dbo].tbl_user_coupon" + vbcrlf
	sqlstr = sqlstr & " (masteridx,userid,coupontype,couponvalue, couponname,minbuyprice,targetitemlist,startdate,expiredate,couponmeaipprice,validsitename)" + vbcrlf
	sqlstr = sqlstr & " 	SELECT idx, '"& userid &"',coupontype,couponvalue,couponname,minbuyprice,targetitemlist,startdate, expiredate,couponmeaipprice,validsitename" + vbcrlf
	sqlstr = sqlstr & " 	from [db_user].[dbo].tbl_user_coupon_master m" + vbcrlf
	sqlstr = sqlstr & " 	where idx="& couponidx &""
	'response.write sqlstr & "<Br>"
	dbget.execute sqlstr

	sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, sub_opt2, sub_opt3, device)" + vbcrlf
	sqlstr = sqlstr & " VALUES("& eCode &", '" & userid & "', '"& left(currenttime,10) &"', 1, '', 'W')" + vbcrlf
	'response.write sqlstr & "<Br>"
	dbget.execute sqlstr

	Response.Write "{ "
	response.write """ytcode"":""11"""	''||������ �߱� �Ǿ����ϴ�.
	response.write "}"
	dbget.close()	:	response.End

Else
	Response.Write "{ "
	response.write """ytcode"":""00"""	''||�������� ��ΰ� �ƴմϴ�.
	response.write "}"
	dbget.close()	:	response.End
end if

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->

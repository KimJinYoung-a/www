<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/classes/shopping/category_contents_managecls.asp" -->
<%
Dim refip
refip = request.ServerVariables("HTTP_REFERER")

If (InStr(refip, "10x10.co.kr") < 1) Then
	response.write "not valid Referer"
	response.end
End if

Dim oKeyArr, i, j, cnt
Dim poscode, allrefresh, idx
Dim HeaderDataExsists, IdxDataExsists
Dim appData, sqlStr, vTotalCount, vReqCount, vFixType, vTerm, prevDate, vTerm2, sqlDate, vCateCode
Dim ocontents, ocontentsCode

vCateCode 	= requestCheckVar(Request("catecode"),3)
poscode		= requestCheckVar(Request("poscode"),32)
allrefresh	= requestCheckVar(Request("allrefresh"),32)
idx			= requestCheckVar(Request("idx"),9)
vTerm		= requestCheckVar(Request("term"),3)
vTerm2		= vTerm

If vTerm2 = "" Then vTerm2 = 1
If vTerm <> "" Then
	vTerm = DateAdd("d",date(),vTerm-1)
End IF
sqlDate = ""

'// 적용코드 확인
Set ocontentsCode = new CCateContentsCode
	ocontentsCode.FRectPoscode = poscode
	ocontentsCode.GetOneContentsCode

	If (ocontentsCode.FResultCount < 1) Then
	    response.write "<script language=javascript>alert('유효한 적용코드가 아닙니다.');self.close();</script>"
		response.end
	End If


		'// 최소 제한수 검사
		for j=1 to cInt(vTerm2)
			'해당 날짜 접수
			prevDate = dateadd("d",(j-1),date)
			sqlDate = sqlDate & "('" & prevDate & "' between startdate and enddate)"

			if j<cInt(vTerm2) then sqlDate = sqlDate & " or "
		
			'// 메인 데이터 접수
			set ocontents = New CCateContents
				ocontents.FRectPoscode = poscode
				ocontents.FPageSize = ocontentsCode.FOneItem.FuseSet
				ocontents.FRectSelDate = prevDate
				ocontents.FRectDisp1 = vCateCode
				ocontents.GetMainContentsValidList

				if (ocontents.FResultCount<1) then
				    response.write "<script language=javascript>alert('[" & prevDate & "]일의 적용할 데이터가 없습니다.');self.close();</script>"
					response.end
				elseif (ocontents.FResultCount<(ocontentsCode.FOneItem.FuseSet)) then
				    response.write "<script language=javascript>alert('[" & prevDate & "]일 적용에 필요한 데이터가 부족합니다.\n\n(※ 최소 " & (ocontentsCode.FOneItem.FuseSet) & "건 필요. 현재 " & ocontents.FResultCount & "건 등록됨)');self.close();</script>"
					response.end
				end if
		
			set ocontents = Nothing
		Next

	
	sqlStr = "select useSet, fixtype from [db_sitemaster].dbo.tbl_category_contents_poscode"
	sqlStr = sqlStr & " where poscode = " & poscode & " "
	rsget.Open SqlStr, dbget, 1
		vReqCount = rsget("useSet")
		vFixType = rsget("fixtype")
	rsget.Close
	
	'### 일별등록
	If poscode="367" Then
		sqlStr = " select c.*, p.posname, eed.evt_name, eed.evt_subcopyK, eed.etc_itemimg, eed.etc_itemid, i.basicimage, i.basicimage600 "
		sqlStr = sqlStr & " from [db_sitemaster].[dbo].tbl_category_contents c  "
		sqlStr = sqlStr & " left join [db_sitemaster].dbo.tbl_category_contents_poscode p on c.poscode=p.poscode  "
		sqlStr = sqlStr & " Left Join  "
		sqlStr = sqlStr & " (  "
		sqlStr = sqlStr & " 	Select e.evt_code, e.evt_name, e.evt_subcopyK, ed.etc_itemimg, ed.etc_itemid From db_event.dbo.tbl_event e  "
		sqlStr = sqlStr & " 	inner join db_event.[dbo].[tbl_event_display] ed on e.evt_code=ed.evt_code  "
		sqlStr = sqlStr & " ) eed on c.evt_code = eed.evt_code  "
		sqlStr = sqlStr & " left join db_item.dbo.tbl_item i on i.itemid = eed.etc_itemid "
		sqlStr = sqlStr & " where c.poscode = " & poscode & " and c.isusing = 'Y' and c.disp1 = '" & vCateCode & "' and (" & sqlDate & ") "
		sqlStr = sqlStr & " order by c.sortNo asc, c.idx desc  "
	Else
		sqlStr = "select c.*, p.posname"
		If poscode = "370" Then
			sqlStr = sqlStr & " ,STUFF(( "
			sqlStr = sqlStr & " 	SELECT Top 6 ',' + cast(b.itemid as varchar(10)) + ':' + cast(i.icon1image as varchar(24)) "
			sqlStr = sqlStr & " 		+ ':' + cast(convert(varchar,i.sellcash) as varchar(10)) + ':' + cast(convert(varchar,i.orgprice) as varchar(10)) + ':' + cast(i.sailyn as varchar(1)) "
			sqlStr = sqlStr & " 		+ ':' + cast(i.itemcouponyn as varchar(1)) + ':' + cast(i.itemcouponvalue as varchar(8)) + ':' + cast(i.itemcoupontype as varchar(1)) "
			sqlStr = sqlStr & " 		FROM [db_sitemaster].[dbo].tbl_category_contents_brand as b "
			sqlStr = sqlStr & " 	inner JOIN [db_item].dbo.tbl_item as i ON b.itemid = i.itemid "
			sqlStr = sqlStr & " 	WHERE b.tidx = c.idx ORDER BY b.sortno asc, i.itemid desc "
			sqlStr = sqlStr & " FOR XML PATH('') "
			sqlStr = sqlStr & " ), 1, 1, '') AS itemlist "
			sqlStr = sqlStr & " , c.makerid, uc.newflg, uc.recommendcount, uc.todayrecommendcount, uc.artistflg, uc.socname, uc.socname_kor  "
			sqlStr = sqlStr & " from [db_sitemaster].[dbo].tbl_category_contents c"
			sqlStr = sqlStr & " left join [db_sitemaster].dbo.tbl_category_contents_poscode p"
			sqlStr = sqlStr & " 	on c.poscode=p.poscode"
			sqlStr = sqlStr & " left join [db_user].dbo.tbl_user_c uc on c.makerid = uc.userid"
			sqlStr = sqlStr & " where c.poscode = " & poscode & " and c.isusing = 'Y' and c.disp1 = '" & vCateCode & "' and eed.evt_code > 0 "
			sqlStr = sqlStr & "	and (" & sqlDate & ") "
			sqlStr = sqlStr & " order by c.sortNo asc, c.idx desc "
		Else
			sqlStr = sqlStr & " from [db_sitemaster].[dbo].tbl_category_contents c"
			sqlStr = sqlStr & " left join [db_sitemaster].dbo.tbl_category_contents_poscode p"
			sqlStr = sqlStr & " 	on c.poscode=p.poscode"
			sqlStr = sqlStr & " where c.poscode = " & poscode & " and c.isusing = 'Y' and c.disp1 = '" & vCateCode & "' and eed.evt_code > 0 "
			sqlStr = sqlStr & "	and (" & sqlDate & ") "
			sqlStr = sqlStr & " order by c.sortNo asc, c.idx desc "
		End If
	End If

	rsget.Open SqlStr, dbget, 1
	vTotalCount = rsget.RecordCount

	If vTotalCount < vReqCount Then
		Response.Write "<script>alert('최소 "& vReqCount & "개 이상을 등록하셔야 합니다.');window.close();</script>"
		rsget.Close
		dbget.close()
		response.end
	End If
	

	Dim savePath, FileName, fso, tFile, BufStr, VarName, DoubleQuat, omd,ix
	savePath = server.mappath("/chtml_test/dispcate/xml/") + "\"
	FileName = "catemain_xml_" & poscode & "_" & vCateCode & ".xml"
	BufStr = ""
	BufStr = "<?xml version=""1.0"" ?>" & VbCrlf
	BufStr = BufStr & "<list>" & VbCrlf
	For i = 0 To CInt(vTotalCount) - 1 
		BufStr = BufStr & "<item>" & VbCrlf
			If poscode="367" Then
				If Trim(rsget("imageurl"))="" Then
					BufStr = BufStr & "<image><![CDATA[]]></image>" & VbCrlf
				Else
					BufStr = BufStr & "<image><![CDATA[" & staticImgUrl & "/category/" & db2Html(rsget("imageurl")) & "]]></image>" & VbCrlf
				End If
			Else
				BufStr = BufStr & "<image><![CDATA[" & staticImgUrl & "/category/" & db2Html(rsget("imageurl")) & "]]></image>" & VbCrlf
			End If
			BufStr = BufStr & "<link><![CDATA[" & db2Html(rsget("linkUrl")) & "]]></link>" & VbCrlf
			BufStr = BufStr & "<posname><![CDATA[" & db2Html(replace(rsget("posname"),"-","")) & "]]></posname>" & VbCrlf
			BufStr = BufStr & "<idx><![CDATA[" & rsget("idx") & "]]></idx>" & VbCrlf
			BufStr = BufStr & "<startdate><![CDATA[" & Replace(Left(rsget("startdate"),10),"-",",") & "]]></startdate>" & VbCrlf
			BufStr = BufStr & "<enddate><![CDATA[" & Replace(Left(rsget("enddate"),10),"-",",") & "]]></enddate>" & VbCrlf
			If poscode = "370" Then
				BufStr = BufStr & "<makerid><![CDATA[" & rsget("makerid") & "]]></makerid>" & VbCrlf
				BufStr = BufStr & "<brandcopy><![CDATA[" & db2html(rsget("brandcopy")) & "]]></brandcopy>" & VbCrlf
				BufStr = BufStr & "<socname><![CDATA[" & db2html(rsget("socname")) & "]]></socname>" & VbCrlf
				BufStr = BufStr & "<socnamekor><![CDATA[" & db2html(rsget("socname_kor")) & "]]></socnamekor>" & VbCrlf
				BufStr = BufStr & "<itemlist><![CDATA[" & fnPosCode370ReSetting(rsget("itemlist")) & "]]></itemlist>" & VbCrlf
				BufStr = BufStr & "<tagclass><![CDATA[" & fnTagClassSetting(rsget("newflg"),rsget("recommendcount"),rsget("todayrecommendcount"),rsget("artistflg")) & "]]></tagclass>" & VbCrlf
			End If
			If poscode = "367" Then
				BufStr = BufStr & "<evtname><![CDATA[" & Replace(db2html(rsget("evt_name")), Chr(34), "") & "]]></evtname>" & VbCrlf
				BufStr = BufStr & "<evtcode><![CDATA[" & rsget("evt_code") & "]]></evtcode>" & VbCrlf
				BufStr = BufStr & "<evtsubcopyK><![CDATA[" & Replace(db2html(rsget("evt_subcopyK")), Chr(34), "") & "]]></evtsubcopyK>" & VbCrlf
				BufStr = BufStr & "<etcitemimg><![CDATA[" & db2Html(rsget("etc_itemimg")) & "]]></etcitemimg>" & VbCrlf
				BufStr = BufStr & "<etcitemid><![CDATA[" & db2Html(rsget("etc_itemid")) & "]]></etcitemid>" & VbCrlf
				BufStr = BufStr & "<basicimage><![CDATA[" & db2Html(rsget("basicimage")) & "]]></basicimage>" & VbCrlf
				BufStr = BufStr & "<basicimage600><![CDATA[" & db2Html(rsget("basicimage600")) & "]]></basicimage600>" & VbCrlf
			End If
		BufStr = BufStr & "</item>" & VbCrlf
		rsget.MoveNext
	Next
	BufStr = BufStr & "</list>" & VbCrlf
	
	Set fso = Server.CreateObject("ADODB.Stream")
		fso.Type = 2
		fso.Charset = "utf-8"
		fso.Open
		fso.WriteText (BufStr)
		fso.SaveToFile savePath & "\"&FileName, 2
	Set fso = nothing

	rsget.Close
set ocontentsCode = Nothing


Function fnPosCode370ReSetting(arr)
	Dim vReSet, vCnt, i
	vReSet = arr
	vReSet = Replace(vReSet," ","")
	vCnt = UBound(Split(vReSet,","))
	
	For i=0 To (5-(vCnt+1))
		vReSet = vReSet & ",:"
	Next
	
	fnPosCode370ReSetting = vReSet
End Function

	
Function fnTagClassSetting(n,z1,z2,a)
	Dim vClass
	vClass = ""
	If z1 >= 1000 OR z2 >= 5 Then
		vClass = "brZzimV15"
	End If
	If a = "Y" Then
		vClass = "brArtV15"
	End If
	If n = "Y" Then
		vClass = "brNewV15"
	End If
	
	fnTagClassSetting = vClass
	vClass = ""
End Function
%>
<script>alert("적용완료!");window.close();</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->
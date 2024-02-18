<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
Dim cTime
If CDate(now()) <= CDate(Date() & " 00:05:00") Then
	cTime = 60*1
Else
	cTime = 60*60
End If

Dim sqlStr , rsMem , arrList , intI
dim itemid, itemname, limitno, limitsold, brandname, listimage, listimage120, basicimage , makerid
dim orgprice, sellcash, getSalePro, LimitedLowStock, sailper, sailyn, itemcoupontype, itemcouponYn, itemCouponValue , amplitudeclassval

	sqlStr = " SELECT  TOP 3  * " & vbcrlf
	sqlStr = sqlStr & " 	FROM     (" & vbcrlf
	sqlStr = sqlStr & "	select i.itemid, i.itemname, i.sellcash, i.orgprice, i.makerid " & vbcrlf
	sqlStr = sqlStr & "	,i.brandname, i.listimage, i.listimage120, i.smallImage, i.sellyn, i.sailyn, i.limityn, i.limitno, i.limitsold, i.regdate,i.reipgodate " & vbcrlf
	sqlStr = sqlStr & "		,itemcouponYn, itemCouponValue, itemCouponType, i.evalCnt, i.itemScore, icon1image, i.icon2image, i.itemdiv, i.basicimage " & vbcrlf
	sqlStr = sqlStr & "		,CASE i.limityn WHEN 'Y' THEN (i.limitno-i.limitsold) else 0  end as LimitedLowStock " & vbcrlf
	sqlStr = sqlStr & "		,((orgprice-sellcash)/orgprice*100) as sailper " & vbcrlf
	sqlStr = sqlStr & "		FROM db_item.dbo.[tbl_display_cate_item] as c with (nolock) " & vbcrlf
	sqlStr = sqlStr & "		inner join [db_item].[dbo].tbl_item  AS i with (nolock) " & vbcrlf
	sqlStr = sqlStr & "		on c.itemid = i.itemid and substring(convert(varchar(20), c.catecode), 1, 6) = '104119' " & vbcrlf
	sqlStr = sqlStr & "		WHERE i.isusing='Y' and i.sellyn in ('Y') " & vbcrlf 
	'sqlStr = sqlStr & "		and limityn='Y' and (i.limitno-i.limitsold)>0 and (i.limitno-i.limitsold)>=3  " & vbcrlf
	'sqlStr = sqlStr & "		and (i.limitno-i.limitsold)<100 " & vbcrlf
	'sqlStr = sqlStr & "		and datediff(day,i.sellSTDate,getdate())<=31 " & vbcrlf
	sqlStr = sqlStr & "		) as k  " & vbcrlf
	sqlStr = sqlStr & "	order by newid()" & vbcrlf

	set rsMem = getDBCacheSQL(dbget, rsget, "TENCLASS", sqlStr, cTime)
	IF Not (rsMem.EOF OR rsMem.BOF) THEN
		arrList = rsMem.GetRows
	END IF
	rsMem.close

	on Error Resume Next
%>
<%
	If IsArray(arrList) Then

		'시작태그 출력
		Response.write "<div class='section tenten-class'><div class='inner-cont'><div class='ftLt'><h2>텐텐 <b>클래스</b></h2><a href='/shopping/category_list.asp?disp=104119&gaparam=main_class_0' class='btn-linkV18 link2'>클래스 더 보기 <span></span></a><div class='btnWrap'></div></div><div class='ftRt'><div class='items type-thumb'><ul>"

		For intI = 0 To ubound(arrlist,2)

			'변수 저장
			itemid			= arrlist(0,intI)
			itemname		= arrlist(1,intI)
			limitno			= arrlist(12,intI)
			makerid			= arrlist(4,intI)
			brandname		= arrlist(5,intI)
			basicimage		= "http://webimage.10x10.co.kr/image/basic/"&GetImageSubFolderByItemid(arrlist(0,intI))&"/"& db2Html(arrlist(24,intI))
			LimitedLowStock = arrlist(25,intI)

			sellcash		= arrlist(2,intI)
			sailyn			= arrlist(10,intI)
			sailper			= arrlist(26,intI)
			itemcoupontype	= arrlist(18,intI)
			itemcouponYn	= arrlist(16,intI)
			itemCouponValue	= arrlist(17,intI)

			amplitudeclassval = "{'TenClassNumber':'"&intI&"'}" 
			amplitudeclassval = Replace(amplitudeclassval, "'", "\""")
%>

			<li>
				<a href="/shopping/category_prd.asp?itemid=<%=itemid%>&gaparam=main_class_<%=intI+1%>" onclick="fnAmplitudeEventMultiPropertiesAction('click_mainclass','indexnumber|itemid','<%=intI+1%>|<%=itemid%>');">
					<div class="thumbnail"><!-- <span class="hurry">마감임박</span> --><img src="<%=basicimage%>" alt="<%= itemname %>"></div>
					<div class="desc">
						<p class="name"><%= itemname %></p>
						<div class="price">
							<% if sailyn = "Y" then %>
							<span class="discount color-red"><%=CInt(sailper)%>%</span>
							<% end if %>
							<span class="sum"><%= FormatNumber(sellcash,0) %></span>
						</div>
					</div>
				</a>
			</li>
<%
		Next

		'종료태그 출력
		Response.write "</ul></div></div></div><script>function AmpEventTenclass(jsonval){	AmplitudeEventSend('MainTenClass', jsonval, 'eventProperties');}</script></div>"
	End If

	on Error Goto 0
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
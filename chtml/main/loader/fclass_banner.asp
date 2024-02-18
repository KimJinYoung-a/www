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
	cTime = 60*10
End If

Dim sqlStr , rsMem , arrList , intI
dim itemid, itemname, limitno, limitsold, brandname, listimage, listimage120, basicimage , makerid
dim orgprice, sellcash, getSalePro, LimitedLowStock, sailper, sailyn, itemcoupontype, itemcouponYn, itemCouponValue

	sqlStr = " SELECT  top 4  * " & vbcrlf
	sqlStr = sqlStr & " 	FROM     (" & vbcrlf
	sqlStr = sqlStr & "	select i.itemid, i.itemname, i.sellcash, i.orgprice, i.makerid " & vbcrlf
	sqlStr = sqlStr & "	,i.brandname, i.listimage, i.listimage120, i.smallImage, i.sellyn, i.sailyn, i.limityn, i.limitno, i.limitsold, i.regdate,i.reipgodate " & vbcrlf
	sqlStr = sqlStr & "		,itemcouponYn, itemCouponValue, itemCouponType, i.evalCnt, i.itemScore, icon1image, i.icon2image, i.itemdiv, i.basicimage " & vbcrlf
	sqlStr = sqlStr & "		,CASE i.limityn WHEN 'Y' THEN (i.limitno-i.limitsold) else 0  end as LimitedLowStock " & vbcrlf
	sqlStr = sqlStr & "		,((orgprice-sellcash)/orgprice*100) as sailper " & vbcrlf
	sqlStr = sqlStr & "		FROM db_item.dbo.[tbl_display_cate_item] as c with (nolock) " & vbcrlf
	sqlStr = sqlStr & "		inner join [db_item].[dbo].tbl_item  AS i with (nolock) " & vbcrlf
	sqlStr = sqlStr & "		on c.itemid = i.itemid and c.catecode = 104119 " & vbcrlf
	sqlStr = sqlStr & "		WHERE i.isusing='Y' and i.sellyn in ('Y') and limityn='Y' and (i.limitno-i.limitsold)>0 and (i.limitno-i.limitsold)>=3  " & vbcrlf
	sqlStr = sqlStr & "		and (i.limitno-i.limitsold)<100 " & vbcrlf
	sqlStr = sqlStr & "		and datediff(day,i.sellSTDate,getdate())<=30 " & vbcrlf
	sqlStr = sqlStr & "		) as k  " & vbcrlf
	sqlStr = sqlStr & "	order by newid() " & vbcrlf

	set rsMem = getDBCacheSQL(dbget, rsget, "CSCLASS", sqlStr, cTime)
	IF Not (rsMem.EOF OR rsMem.BOF) THEN
		arrList = rsMem.GetRows
	END IF
	rsMem.close

	on Error Resume Next
	If IsArray(arrList) Then

		'시작태그 출력
		Response.Write "<h2><a href=""/shopping/category_list.asp?disp=104119&gaparam=main_class_0""><img src=""http://fiximage.10x10.co.kr/web2017/main/tit_class.png"" alt=""10x10 CLASS"" /></a></h2><ul>"

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
%>
						<li <%=chkiif(LimitedLowStock < 5,"class='tag imminent'","")%>>
							<p class="tagCont"><span>마감임박</span></p>
							<a href="/shopping/category_prd.asp?itemid=<%=itemid%>&gaparam=main_class_<%=intI+1%>"><p class="imgOverV15"><img src="<%=basicimage%>" alt="<%= itemname %>" /></p></a>
							<div class="pdtInfo">
								<p class="pdtBrand"><a href="/street/street_brand_sub06.asp?makerid=<%=makerid%>&gaparam=main_class_<%=intI+1%>"><%=brandname%></a></p>
								<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%=itemid%>&gaparam=main_class_<%=intI+1%>"><%= itemname %></a></p>
								<p class="pdtPrice tPad05"><span class="cBk0V15 rPad05"><strong><%= FormatNumber(sellcash,0) %></strong>원</span>
									<% if sailyn = "Y" then %>
								 		<span class="cRd0V15">[<%=CInt(sailper)%>%]</span>
								 	<% end if %>
								 	<% if itemcouponYn = "Y" then %>
									 	<% if itemcoupontype = "3" then %>
									 	 	<span class="cGr0V15">[무료배송]</span>
									 	<% elseif itemcoupontype = "1" then %>
									 	 	<span class="cGr0V15">[<%= FormatNumber(itemCouponValue,0) %>%쿠폰]</span>
									 	<% elseif itemcoupontype = "2" then %>
									 		<span class="cGr0V15">[<%= FormatNumber(itemCouponValue,0) %>원쿠폰]</span>
									 	<% end if %>
									<% end if %>
								</p>
							</div>
						</li>
<%
		Next

		'종료태그 출력
		Response.Write "</ul><a href=""/shopping/category_list.asp?disp=104119&gaparam=main_class_0"" class=""btnMore"">더 많은 클래스 보기</a>"
	End If

	on Error Goto 0
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
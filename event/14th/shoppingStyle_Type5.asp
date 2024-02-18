<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/shoppingchanceCls_B.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/search/searchCls.asp" -->
<!-- #include virtual ="/lib/classes/enjoy/newawardcls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->

<%
        dim sqlStr, i

        '// 본문 내용 접수
		sqlStr = "select top 8 m.photoimg, m.linkinfo, m.textinfo, m.linkitemid, m.idx, "
		sqlStr = sqlStr & " i.itemid, i.itemname, i.listImage120,i.icon1Image, i.sellcash, i.orgprice, "
		sqlStr = sqlStr & " i.sailyn, i.itemcouponyn, i.itemcouponvalue, i.itemcoupontype "
		sqlStr = sqlStr & " from [db_sitemaster].[dbo].tbl_main_mdchoice_flash as m "
		sqlStr = sqlStr & " Join [db_item].[dbo].tbl_item as i "
		sqlStr = sqlStr & "		on m.linkitemid=i.itemid "
		sqlStr = sqlStr + " where m.isusing in ('Y','M') And i.sellcash >= 10000 "
		sqlStr = sqlStr + " order by m.disporder, m.idx desc"
        rsget.Open sqlStr,dbget, adOpenForwardOnly, adLockReadOnly
		Do Until rsget.eof
%>
				<li>
					<input type='checkbox' class='check' name="pdFavChk" value="<%=rsget("itemid")%>"/>
					<div class='pdtBox'>
						<div class='pdtPhoto'>
							<span class='soldOutMask'></span>
							<a href="/shopping/category_prd.asp?itemid=<%=rsget("itemid")%>" target="_blank">
								<img src='<% = "http://webimage.10x10.co.kr/image/icon1/" + GetImageSubFolderByItemid(rsget("itemid")) + "/" + rsget("icon1image") %>' alt='<% = rsget("itemname") %>' />
							</a>
						</div>
						<div class='pdtInfo'>
							<p class='pdtName'><a href="/shopping/category_prd.asp?itemid=<%=rsget("itemid")%>" target="_blank"><%=chrbyte(rsget("itemname"), 10, "Y")%></a></p>
							<p class='pdtPrice'><span class='finalP'><%=FormatNumber(rsget("sellcash"),0)%>원</span></p>
						</div>
					</div>
				</li>
<%
		rsget.movenext
		Loop
		rsget.close
%>

<!-- #include virtual="/lib/db/dbclose.asp" -->

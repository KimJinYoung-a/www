<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/db/dbEVTopen.asp" -->
<%

dim mode : mode = requestCheckvar(request("mode"),30)

dim title, bufStr, sqlStr

dim i_XML_TOP , i_XML_BOTTOM
i_XML_TOP = "<?xml version=""1.0"" encoding=""UTF-8""?>"&vbCRLF
i_XML_TOP = i_XML_TOP&"<urlset"&vbCRLF
i_XML_TOP = i_XML_TOP&"xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"""&vbCRLF
i_XML_TOP = i_XML_TOP&"xmlns:xhtml=""http://www.w3.org/1999/xhtml"""&vbCRLF
i_XML_TOP = i_XML_TOP&"xsi:schemaLocation=""http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd"""&vbCRLF
i_XML_TOP = i_XML_TOP&"xmlns=""http://www.sitemaps.org/schemas/sitemap/0.9"">"&vbCRLF

i_XML_BOTTOM  = "</urlset>"

select case mode
	case "cate":
		title = "텐바이텐 : 카테고리목록"

		sqlStr = " [db_EVT].[dbo].[sp_TEN_Search_ConSole_SiteMap_Maker] ('google','W','cate')"
		rsEVTget.CursorLocation = adUseClient
		rsEVTget.Open sqlStr,dbEVTget,adOpenForwardOnly, adLockReadOnly, adCmdStoredProc

		if (not rsEVTget.EOF) then
			Do Until rsEVTget.Eof
				bufStr = bufStr & "<url>"&VbCRLF
				bufStr = bufStr & "   <loc>"&replace(rsEVTget("urlid"),"&","&amp;")&"</loc>"&VbCRLF
				bufStr = bufStr & "   <lastmod>" & Left(DateAdd("d", -2, Now()), 10) & "T23:45:21+00:00</lastmod>"&VbCRLF
				bufStr = bufStr & "   <changefreq>weekly</changefreq>"&VbCRLF
				bufStr = bufStr & "   <priority>0.8</priority>"&VbCRLF
				bufStr = bufStr & "</url>"&VbCRLF
				rsEVTget.moveNext
			loop
		end if
		rsEVTget.close()
	case "search":
		title = "텐바이텐 : 검색결과"

		sqlStr = " [db_EVT].[dbo].[sp_TEN_Search_ConSole_SiteMap_Maker] ('google','W','search')"
		rsEVTget.CursorLocation = adUseClient
		rsEVTget.Open sqlStr,dbEVTget,adOpenForwardOnly, adLockReadOnly, adCmdStoredProc

		if (not rsEVTget.EOF) then
			Do Until rsEVTget.Eof
				bufStr = bufStr & "<url>"&VbCRLF
				bufStr = bufStr & "   <loc>"&rsEVTget("uri")&server.URLEncode(rsEVTget("rect"))&replace("&exkw=1","&","&amp;")&"</loc>"&VbCRLF
				bufStr = bufStr & "   <lastmod>" & Left(DateAdd("d", -2, Now()), 10) & "T23:45:21+00:00</lastmod>"&VbCRLF
				bufStr = bufStr & "   <changefreq>weekly</changefreq>"&VbCRLF
				bufStr = bufStr & "   <priority>0.65</priority>"&VbCRLF
				bufStr = bufStr & "</url>"&VbCRLF
				rsEVTget.moveNext
			loop
		end if
		rsEVTget.close()
	case else:
		title = "텐바이텐 : 에러"
end select

response.ContentType="text/xml"

%>
<%= i_XML_TOP %>
<%= bufStr %>
<%= i_XML_BOTTOM %>
<!-- #include virtual="/lib/db/dbEVTclose.asp" -->

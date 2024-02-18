<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% Server.ScriptTimeOut = 200  '' sec %>
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/db/dbEVTopen.asp" -->
<%
dim lastmod:lastmod=requestCheckvar(request("lastmod"),30)
dim changefreq:changefreq=requestCheckvar(request("changefreq"),30)
dim chkm:chkm=request("chkm")
dim isitename:isitename=requestCheckvar(request("isitename"),32)
dim mode

if (changefreq="") then changefreq="weekly"  ''weekly, monthly
if (isitename="") then isitename="naver"
    
if (lastmod<>"") and (changefreq<>"") then
    mode = "mk"
end if

dim sqlStr
dim bufStr, i
dim bufStr_etc, bufStr_cate, bufStr_brand, bufStr_search, bufStr_item

dim i_XML_TOP , i_XML_BOTTOM
i_XML_TOP = "<?xml version=""1.0"" encoding=""UTF-8""?>"&vbCRLF
i_XML_TOP = i_XML_TOP&"<urlset"&vbCRLF
i_XML_TOP = i_XML_TOP&"xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"""&vbCRLF
i_XML_TOP = i_XML_TOP&"xmlns:xhtml=""http://www.w3.org/1999/xhtml"""&vbCRLF
i_XML_TOP = i_XML_TOP&"xsi:schemaLocation=""http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd"""&vbCRLF
i_XML_TOP = i_XML_TOP&"xmlns=""http://www.sitemaps.org/schemas/sitemap/0.9"">"&vbCRLF

i_XML_BOTTOM  = "</urlset>"

bufStr=""

dim iSiteNameParam:iSiteNameParam=isitename
dim iMWParam:iMWParam=CHKIIF(chkm<>"","M","W")

if (mode="mk") then
    '' etc 
    sqlStr = " [db_EVT].[dbo].[sp_TEN_Search_ConSole_SiteMap_Maker] ('"&iSiteNameParam&"','"&iMWParam&"','etc')"
    
    rsEVTget.CursorLocation = adUseClient
    rsEVTget.Open sqlStr,dbEVTget,adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
    
    if (not rsEVTget.EOF) then
        Do Until rsEVTget.Eof
            
            bufStr_etc=bufStr_etc&"<url>"&VbCRLF
            bufStr_etc=bufStr_etc&"   <loc>"&replace(rsEVTget("loc"),"&","&amp;")&"</loc>"&VbCRLF
            bufStr_etc=bufStr_etc&"   <lastmod>"&lastmod&"</lastmod>"&VbCRLF
            bufStr_etc=bufStr_etc&"   <changefreq>"&changefreq&"</changefreq>"&VbCRLF
            bufStr_etc=bufStr_etc&"   <priority>"&rsEVTget("priority")&"</priority>"&VbCRLF
            bufStr_etc=bufStr_etc&"</url>"&VbCRLF

            rsEVTget.moveNext
	    loop
	end if
	rsEVTget.close()
	
	''category
    sqlStr = " [db_EVT].[dbo].[sp_TEN_Search_ConSole_SiteMap_Maker] ('"&iSiteNameParam&"','"&iMWParam&"','cate')"
    
    rsEVTget.CursorLocation = adUseClient
    rsEVTget.Open sqlStr,dbEVTget,adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
    
    if (not rsEVTget.EOF) then
        Do Until rsEVTget.Eof
            
            bufStr_cate=bufStr_cate&"<url>"&VbCRLF
            bufStr_cate=bufStr_cate&"   <loc>"&replace(rsEVTget("loc"),"&","&amp;")&"</loc>"&VbCRLF
            bufStr_cate=bufStr_cate&"   <lastmod>"&lastmod&"</lastmod>"&VbCRLF
            bufStr_cate=bufStr_cate&"   <changefreq>"&changefreq&"</changefreq>"&VbCRLF
            bufStr_cate=bufStr_cate&"   <priority>0.8</priority>"&VbCRLF
            bufStr_cate=bufStr_cate&"</url>"&VbCRLF
            
            rsEVTget.moveNext
	    loop
	end if
	rsEVTget.close()
	
	''brand
    sqlStr = " [db_EVT].[dbo].[sp_TEN_Search_ConSole_SiteMap_Maker] ('"&iSiteNameParam&"','"&iMWParam&"','brand')"
    
    rsEVTget.CursorLocation = adUseClient
    rsEVTget.Open sqlStr,dbEVTget,adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
    
    if (not rsEVTget.EOF) then
        Do Until rsEVTget.Eof
            
            bufStr_brand=bufStr_brand&"<url>"&VbCRLF
            bufStr_brand=bufStr_brand&"   <loc>"&replace(rsEVTget("loc"),"&","&amp;")&"</loc>"&VbCRLF
            bufStr_brand=bufStr_brand&"   <lastmod>"&lastmod&"</lastmod>"&VbCRLF
            bufStr_brand=bufStr_brand&"   <changefreq>"&changefreq&"</changefreq>"&VbCRLF
            bufStr_brand=bufStr_brand&"   <priority>0.7</priority>"&VbCRLF
            bufStr_brand=bufStr_brand&"</url>"&VbCRLF
            
            rsEVTget.moveNext
	    loop
	end if
	rsEVTget.close()
	
	''search
    sqlStr = " [db_EVT].[dbo].[sp_TEN_Search_ConSole_SiteMap_Maker] ('"&iSiteNameParam&"','"&iMWParam&"','search')"
    
    rsEVTget.CursorLocation = adUseClient
    rsEVTget.Open sqlStr,dbEVTget,adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
    
    if (not rsEVTget.EOF) then
        Do Until rsEVTget.Eof
            
            bufStr_search=bufStr_search&"<url>"&VbCRLF
            bufStr_search=bufStr_search&"   <loc>"&rsEVTget("uri")&server.URLEncode(rsEVTget("rect"))&replace(rsEVTget("addParam"),"&","&amp;")&"</loc>"&VbCRLF
            bufStr_search=bufStr_search&"   <lastmod>"&lastmod&"</lastmod>"&VbCRLF
            bufStr_search=bufStr_search&"   <changefreq>"&changefreq&"</changefreq>"&VbCRLF
            bufStr_search=bufStr_search&"   <priority>0.65</priority>"&VbCRLF
            bufStr_search=bufStr_search&"</url>"&VbCRLF
            
            rsEVTget.moveNext
	    loop
	end if
	rsEVTget.close()
	
	''item
    sqlStr = " [db_EVT].[dbo].[sp_TEN_Search_ConSole_SiteMap_Maker] ('"&iSiteNameParam&"','"&iMWParam&"','item')"
    
    rsEVTget.CursorLocation = adUseClient
    rsEVTget.Open sqlStr,dbEVTget,adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
    
    if (not rsEVTget.EOF) then
        Do Until rsEVTget.Eof
            
            bufStr_item=bufStr_item&"<url>"&VbCRLF
            bufStr_item=bufStr_item&"   <loc>"&replace(rsEVTget("loc"),"&","&amp;")&"</loc>"&VbCRLF
            bufStr_item=bufStr_item&"   <lastmod>"&lastmod&"</lastmod>"&VbCRLF
            bufStr_item=bufStr_item&"   <changefreq>"&changefreq&"</changefreq>"&VbCRLF
            bufStr_item=bufStr_item&"   <priority>0.6</priority>"&VbCRLF
            bufStr_item=bufStr_item&"</url>"&VbCRLF
            
            rsEVTget.moveNext
	    loop
	end if
	rsEVTget.close()
	
	''bufStr = bufStr_etc& bufStr_cate& bufStr_brand& bufStr_search& bufStr_item
end if 
%>

<!doctype html>
<html lang="ko">
	<meta charset="utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	
	<head>
		<title>google fetch mk</title>
		<script language='javascript'>
    	function mkSitemap(){
    	    var frm = document.frmsbm;
    	    frm.submit();
    	}    
    	</script>
    	<script language="jscript" runat="server">
            function jsURLDecode(v){ return decodeURI(v); }
            function jsURLEncode(v){ return encodeURI(v); }
        </script>
	</head>
	<body>
	    <form name="frmsbm" method="post" action="">
	        <br>
	    <input type="checkbox" name="chkm" <%=CHKIIF(chkm="on","checked","")%>>모바일<br>
	    isitename : <input type="text" name="isitename" width="30" size="30" value="<%=isitename%>">  ( naver, google ) <br>
	    lastmod : <input type="text" name="lastmod" width="30" size="30" value="<%=lastmod%>">  ( 2017-06-04T23:45:21+00:00 ) <br>
	    changefreq : <input type="text" name="changefreq" width="10" size="10" value="<%=changefreq%>">
	    
	    <input type="button" value="작성" onClick="mkSitemap();">
	    
	    </form>
	    <% if (bufStr_etc<>"") then %>
	    <br>
<textarea cols="160" rows="30">
<%=i_XML_TOP%>
<%=bufStr_etc%>
<% response.flush%>
<%=bufStr_cate%>
<% response.flush%>
<%=bufStr_brand%>
<% response.flush%>
<%=bufStr_search%>
<% response.flush%>
<%=bufStr_item%>
<% response.flush%>
<%i_XML_BOTTOM%>
</textarea>
	    <% end if %>
	</body>
</html>
<!-- #include virtual="/lib/db/dbEVTclose.asp" -->
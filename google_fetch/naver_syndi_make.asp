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
    
if (lastmod<>"") and (isitename<>"") then
    mode = "mk"
end if

dim bufStr
bufStr = ""

dim nowGMT 
dim nowdt : nowdt=now()
nowGMT = LEFT(nowdt,10)&"T"&formatdatetime(nowdt,4)&":"&right(formatdatetime(nowdt,2),2)&"+09:00"
if (lastmod="") then lastmod=nowGMT
    
    
dim sqlStr
dim  i
dim bufStr_etc, bufStr_cate, bufStr_brand, bufStr_search, bufStr_item

dim i_XML_TOP , i_XML_BOTTOM
i_XML_TOP = "<feed xmlns=""http://webmastertool.naver.com"">"&vbCRLF
if (chkm="on") then 
    i_XML_TOP = i_XML_TOP&"<id>http://m.10x10.co.kr/category/category_list.asp</id>"&vbCRLF
else
    i_XML_TOP = i_XML_TOP&"<id>http://www.10x10.co.kr/shopping/category_main.asp</id>"&vbCRLF
end if

i_XML_TOP = i_XML_TOP&"<title>shopping category</title>"&vbCRLF
i_XML_TOP = i_XML_TOP&"<author>"&vbCRLF
i_XML_TOP = i_XML_TOP&"<name>10x10</name>"&vbCRLF
i_XML_TOP = i_XML_TOP&"<email>bnoti@10x10.co.kr</email>"&vbCRLF
i_XML_TOP = i_XML_TOP&"</author>"&vbCRLF
i_XML_TOP = i_XML_TOP&"<updated>"&nowGMT&"</updated>"&vbCRLF

i_XML_BOTTOM  = "</feed>"

dim iSiteNameParam:iSiteNameParam=isitename
dim iMWParam:iMWParam=CHKIIF(chkm<>"","M","W")

if (mode="mk") then
   
	''category
    sqlStr = " [db_EVT].[dbo].[sp_TEN_Search_ConSole_SiteMap_Maker] ('"&iSiteNameParam&"','"&iMWParam&"','cate')"
    
    rsEVTget.CursorLocation = adUseClient
    rsEVTget.Open sqlStr,dbEVTget,adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
    
    if (not rsEVTget.EOF) then
        Do Until rsEVTget.Eof
            bufStr_cate=bufStr_cate&"<entry>"&VbCRLF
            bufStr_cate=bufStr_cate&"<id>"&replace(rsEVTget("urlid"),"&","&amp;")&"</id>"&VbCRLF
            bufStr_cate=bufStr_cate&"<title><![CDATA["&replace(rsEVTget("title"),"&","&amp;")&"]]></title>"&VbCRLF
            bufStr_cate=bufStr_cate&"<author><name>10x10</name></author>"
            bufStr_cate=bufStr_cate&"<updated>"&nowGMT&"</updated>"&VbCRLF
            bufStr_cate=bufStr_cate&"<published>2017-06-16T00:00:00+09:00</published>"&VbCRLF
            bufStr_cate=bufStr_cate&"<link rel=""via"" href="""+rsEVTget("linkvia")+""" title=""카테고리 리스트""/>"&VbCRLF
            bufStr_cate=bufStr_cate&"<content type=""html"">"
            bufStr_cate=bufStr_cate&"<![CDATA["
            bufStr_cate=bufStr_cate&rsEVTget("content")
            bufStr_cate=bufStr_cate&"]]>"
            bufStr_cate=bufStr_cate&"</content>"&VbCRLF
            
            bufStr_cate=bufStr_cate&"<summary type=""text"">"
            bufStr_cate=bufStr_cate&"<![CDATA["
            bufStr_cate=bufStr_cate&rsEVTget("content")
            bufStr_cate=bufStr_cate&"]]>"
            bufStr_cate=bufStr_cate&"</summary>"&VbCRLF
            
            bufStr_cate=bufStr_cate&"</entry>"&VbCRLF

            
            rsEVTget.moveNext
	    loop
	    
	end if
	rsEVTget.close()
end if

bufStr = i_XML_TOP & bufStr_cate & i_XML_BOTTOM

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
	    <% if false then %>changefreq : <input type="text" name="changefreq" width="10" size="10" value="<%=changefreq%>"><% end if %>
	    
	    <input type="button" value="작성" onClick="mkSitemap();">
	    
	    </form>
	    <% if (bufStr<>"") then %>
	    <br>
<textarea cols="160" rows="30">
<%= bufStr %>
</textarea>
	    <% end if %>
	</body>
</html>
<!-- #include virtual="/lib/db/dbEVTclose.asp" -->


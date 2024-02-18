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
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<%
	dim fso
		
		''Js ALL 생성
		dim ijsArray : ijsArray = fnGetDispcateArray()
        dim ii,iBufJsALL
        iBufJsALL =""
        
        for ii=LBound(ijsArray) to UBound(ijsArray)
            Set fso = Server.CreateObject("ADODB.Stream")
            fso.Type = 2
		    fso.Charset = "utf-8"
		    fso.Open
		    On Error resume Next
		    fso.LoadFromFile server.mappath("/chtml/dispcate/html/") & "\"&"cate_menu_new"&ijsArray(ii)&".js"
		    iBufJsALL=iBufJsALL+fso.ReadText&VbCRLF&VbCRLF
		    On Error Goto 0
            
            Set fso=Nothing
        next 
        
        ''임시 파일 만들고 Copy //간혹 2차서버로 복사가 안되는 케이스가 있음?
        Set fso = Server.CreateObject("ADODB.Stream")
		fso.Type = 2
		fso.Charset = "utf-8"
		fso.Open
		fso.WriteText (iBufJsALL)
		fso.SaveToFile server.mappath("/chtml/dispcate/html/") & "\"&"cate_menu_new_all.js", 2
		Set fso = nothing
		
		''Copy //2015/04/15 추가
        'set fso=Server.CreateObject("Scripting.FileSystemObject")
        'if fso.FileExists(server.mappath("/chtml/dispcate/html/") & "\"&"cate_menu_new_all.js") then
        '  fso.DeleteFile(server.mappath("/chtml/dispcate/html/") & "\"&"cate_menu_new_all.js")
        'end if
        'fso.CopyFile server.mappath("/chtml/dispcate/html/") & "\"&"cate_menu_new_all_TT.js",server.mappath("/chtml/dispcate/html/") & "\"&"cate_menu_new_all_T.js"
        'set fso=nothing

		''js script include 생성 (캐시 방지 위해 버전 삽입)
		iBufJsALL = ""
		iBufJsALL = "<script type=""text/javascript"" src=""/chtml/dispcate/html/cate_menu_new_all.js?v="&FormatDate(now(),"00000000000000")&"""></script>"&VbCRLF
		Set fso = Server.CreateObject("ADODB.Stream")
		fso.Type = 2
		fso.Charset = "utf-8"
		fso.Open
		fso.WriteText (iBufJsALL)
		fso.SaveToFile server.mappath("/chtml/dispcate/html/") & "\"&"cate_menu_js_loader.html", 2
		Set fso = nothing

%>
<script>
alert("카테 상단 메뉴 생성완료");
window.close();
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->
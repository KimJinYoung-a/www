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
<!-- #include virtual="/lib/classes/main/menumakeCls.asp" -->
<%
	'// 유입경로 확인
	Dim refip, objXML, fso, savePath, FileName, delFile, objXMLv, tmpIdx, rstMsg, oMain, vItemID, vImgLink, vBookLink, vPreCode, vArrList
	Dim vCateCode, vGubun
	refip = request.ServerVariables("HTTP_REFERER")
	vPreCode = ""

	vCateCode = Request("catecode")
	If vCateCode = "" Then
		Response.Write "<script>alert('잘못된 접근임!');window.close();</script>"
		dbget.close()
		Response.End
	End IF
	
	If isNumeric(vCateCode) = False Then
		Response.Write "<script>alert('잘못된 접근임!');window.close();</script>"
		dbget.close()
		Response.End
	End IF
	'----------------------------------------------------------------------------------------------------------------------------------------
	Dim vTopBannerImg, vTopBannerLink, vTopBanner
	set oMain = new CMainMenu
	oMain.FRectCateCode = vCateCode
	oMain.GetCateTopBannerImg
	
	vTopBanner = oMain.FResultCount
	vTopBannerImg = oMain.Fimgurl
	vTopBannerLink = oMain.Flinkurl
	set oMain = Nothing

	If vTopBanner < 1 Then
		Response.Write "<script>alert('등록된 배너가 없거나 사용중인 배너가 없습니다.\n어드민 [ON]카테고리관리>>전시cate상단배너 에서 확인하세요.');window.close();</script>"
		dbget.close()
		Response.End
	End If
	'----------------------------------------------------------------------------------------------------------------------------------------
	
	savePath = server.mappath("/chtml/dispcate/menu/xml/") + "\"

    Dim iBuf,iBufAll, i, j, CNT, v2DepCount
	Dim vCateName
	vCateName = fnCateName1Depth(vCateCode)


	'####### Top 메뉴 생성.
	iBuf = ""
    iBuf = iBuf & "<div class='gnbSubV15' id='gnb" & vCateCode & "'>" & vbCrLf
    iBuf = iBuf & "	<div class='gnbCtgyGroupV15'>" & vbCrLf
    
	set oMain = new CMainMenu
	oMain.FRectCateCode = vCateCode
	oMain.FRectUseYN = "y"
	vArrList = oMain.GetMainMenuListNew
	v2DepCount = oMain.FResultCount
	
	iBuf = iBuf & fnCateMakeHtml(vArrList, v2DepCount)
	
	Set oMain = Nothing
	j = 0
	iBuf = iBuf & "	</div>" & vbCrLf
	iBuf = iBuf & "	<div class='deptUnitV15 gnbBnrV15'>" & vbCrLf
	iBuf = iBuf & "		<span></span><a href='" & vTopBannerLink & "'><img src='" & vTopBannerImg & "' alt='" & vTopBannerImg & "' /></a>" & vbCrLf
	iBuf = iBuf & "	</div>" & vbCrLf
    iBuf = iBuf & "</div>" & vbCrLf
    iBufAll = iBufAll & iBuf
    
    
    '####### Left 메뉴 생성.
	FileName = "cate_left_menu_new"&vCateCode&".xml"

	Set objXML = server.CreateObject("Microsoft.XMLDOM")
	objXML.async = False

	'// 기존 파일 삭제
	Set fso = CreateObject("Scripting.FileSystemObject")
	if fso.FileExists(savePath & FileName) then
		Set delFile = fso.GetFile(savePath & FileName)
		delFile.Delete
		set delFile = Nothing
	end if
	set fso = Nothing

	'----- XML 해더 생성
	objXML.appendChild(objXML.createProcessingInstruction("xml","version=""1.0"""))
	objXML.appendChild(objXML.createElement("mainPage"))

	set oMain = new CMainMenu
	oMain.FRectCateCode = vCateCode
	oMain.FRectUseYN = "y"
	oMain.GetLeftMenuList

	'-----프로세스 시작
	for j=0 to oMain.FResultCount-1
		Set objXMLv = objXML.createElement("item")
		objXMLv.appendChild(objXML.createElement("catecode"))
		objXMLv.appendChild(objXML.createElement("depth"))
		objXMLv.appendChild(objXML.createElement("catename"))
		objXMLv.appendChild(objXML.createElement("link"))
		objXMLv.appendChild(objXML.createElement("dep3exist"))
		objXMLv.appendChild(objXML.createElement("dep4list"))

		'데이터 넣기
		objXMLv.childNodes(0).text = oMain.FItemList(j).Fcatecode
		objXMLv.childNodes(1).text = oMain.FItemList(j).Fdepth
		objXMLv.childNodes(2).text = oMain.FItemList(j).Fcatename
		objXMLv.childNodes(3).text = "/shopping/category_list.asp?disp=" & oMain.FItemList(j).Fcatecode & ""
		objXMLv.childNodes(4).text = oMain.FItemList(j).Fdep3exist
		objXMLv.childNodes(5).text = oMain.FItemList(j).Fdep4list

		objXML.documentElement.appendChild(objXMLv.cloneNode(True))
		Set objXMLv = Nothing
	Next

	'-----파일 저장
	objXML.save(savePath & FileName)

	'-----객체 해제
	Set objXML = Nothing
	Set oMain = Nothing


    if (iBufAll<>"") then
		Set fso = Server.CreateObject("ADODB.Stream")
		fso.Type = 2
		fso.Charset = "utf-8"
		fso.Open
		fso.WriteText (iBufAll)
		fso.SaveToFile server.mappath("/chtml/dispcate/html/") & "\"&"cate_menu_new"&vCateCode&".html", 2
		Set fso = nothing
		
		''Js생성 서동석 추가-------------------------------------------------
		iBufAll = TRIM(iBufAll)
		iBufAll = replace(iBufAll,VbCRLF,""";"&VbCRLF&"vCtHtml"&vCateCode&"+=""")
		iBufAll = "var vCtHtml"&vCateCode&" = """+iBufAll+""";"
		
		Set fso = Server.CreateObject("ADODB.Stream")
		fso.Type = 2
		fso.Charset = "utf-8"
		fso.Open
		fso.WriteText (iBufAll)
		fso.SaveToFile server.mappath("/chtml/dispcate/html/") & "\"&"cate_menu_new"&vCateCode&".js", 2
		Set fso = nothing
		
		dim ii,iBufJsALL
		
''		''Js ALL 생성 '파일 따로 뺌..
''		dim ijsArray : ijsArray = fnGetDispcateArray()
''        iBufJsALL =""
''        
''        for ii=LBound(ijsArray) to UBound(ijsArray)
''            Set fso = Server.CreateObject("ADODB.Stream")
''            fso.Type = 2
''		    fso.Charset = "utf-8"
''		    fso.Open
''		    On Error resume Next
''		    fso.LoadFromFile server.mappath("/chtml/dispcate/html/") & "\"&"cate_menu_new"&ijsArray(ii)&".js"
''		    iBufJsALL=iBufJsALL+fso.ReadText&VbCRLF&VbCRLF
''		    On Error Goto 0
''            
''            Set fso=Nothing
''        next 
''        
''        ''임시 파일 만들고 Copy //간혹 2차서버로 복사가 안되는 케이스가 있음?
''        Set fso = Server.CreateObject("ADODB.Stream")
''		fso.Type = 2
''		fso.Charset = "utf-8"
''		fso.Open
''		fso.WriteText (iBufJsALL)
''		fso.SaveToFile server.mappath("/chtml/dispcate/html/") & "\"&"cate_menu_new_all_BUF.js", 2
''		Set fso = nothing
''		
''		''Copy //2015/04/15 추가
''        set fso=Server.CreateObject("Scripting.FileSystemObject")
''        'if fso.FileExists(server.mappath("/chtml/dispcate/html/") & "\"&"cate_menu_new_all.js") then
''        '  fso.DeleteFile(server.mappath("/chtml/dispcate/html/") & "\"&"cate_menu_new_all.js")
''        'end if
''        fso.CopyFile server.mappath("/chtml/dispcate/html/") & "\"&"cate_menu_new_all_BUF.js",server.mappath("/chtml/dispcate/html/") & "\"&"cate_menu_new_all.js"
''        set fso=nothing
''		
''		''js script include 생성 (캐시 방지 위해 버전 삽입)
''		iBufJsALL = ""
''		iBufJsALL = "<script type=""text/javascript"" src=""/chtml/dispcate/html/cate_menu_new_all.js?v="&FormatDate(now(),"00000000000000")&"""></script>"&VbCRLF
''		Set fso = Server.CreateObject("ADODB.Stream")
''		fso.Type = 2
''		fso.Charset = "utf-8"
''		fso.Open
''		fso.WriteText (iBufJsALL)
''		fso.SaveToFile server.mappath("/chtml/dispcate/html/") & "\"&"cate_menu_js_loader.html", 2
''		Set fso = nothing
		
		'' js hot 생성
		Dim iHotArray : iHotArray = fnGetHotCatelist()
		iBufJsALL = ""
		iBufJsALL = iBufJsALL&"function jsHotCateShow(idisp){"&VbCRLF
		if isArray(iHotArray) then
		    for ii=0 To UBound(iHotArray,2)
		        iBufJsALL = iBufJsALL&"if (idisp=='"&LEFT(iHotArray(0,ii),3)&"') $('#tophotdisp"&iHotArray(0,ii)&"').show();"&VbCRLF  ''$('#tophotdisp101104').show();
		    next
		end if
		iBufJsALL = iBufJsALL&"}"&VbCRLF
		
		Set fso = Server.CreateObject("ADODB.Stream")
		fso.Type = 2
		fso.Charset = "utf-8"
		fso.Open
		fso.WriteText (iBufJsALL)
		fso.SaveToFile server.mappath("/chtml/dispcate/html/") & "\"&"cate_menu_hot.js", 2
		Set fso = nothing
		
		'' js hot include
		iBufJsALL = ""
		iBufJsALL = "<script type=""text/javascript"" src=""/chtml/dispcate/html/cate_menu_hot.js?v="&FormatDate(now(),"00000000000000")&"""></script>"
		Set fso = Server.CreateObject("ADODB.Stream")
		fso.Type = 2
		fso.Charset = "utf-8"
		fso.Open
		fso.WriteText (iBufJsALL)
		fso.SaveToFile server.mappath("/chtml/dispcate/html/") & "\"&"cate_menu_hot_js_loader.html", 2
		Set fso = nothing
		
        ''Js생성 끝-------------------------------------------------
    end if


    '####### BOOK Left 메뉴 생성.
	FileName = "cate_left_book_menu.xml"

	Set objXML = server.CreateObject("Microsoft.XMLDOM")
	objXML.async = False

	'// 기존 파일 삭제
	'Set fso = CreateObject("Scripting.FileSystemObject")
	'if fso.FileExists(savePath & FileName) then
	'	Set delFile = fso.GetFile(savePath & FileName)
	'	delFile.Delete
	'	set delFile = Nothing
	'end if
	'set fso = Nothing

	'----- XML 해더 생성
	objXML.appendChild(objXML.createProcessingInstruction("xml","version=""1.0"""))
	objXML.appendChild(objXML.createElement("mainPage"))

	set oMain = new CMainMenu
	oMain.FRectUseYN = "y"
	oMain.GetBOOKLeftMenuList

	'-----프로세스 시작
	for j=0 to oMain.FResultCount-1
		Set objXMLv = objXML.createElement("item")
		objXMLv.appendChild(objXML.createElement("catecode"))
		objXMLv.appendChild(objXML.createElement("depth"))
		objXMLv.appendChild(objXML.createElement("catename"))
		objXMLv.appendChild(objXML.createElement("link"))
		objXMLv.appendChild(objXML.createElement("dep3exist"))

		'데이터 넣기
		objXMLv.childNodes(0).text = oMain.FItemList(j).Fcatecode
		objXMLv.childNodes(1).text = oMain.FItemList(j).Fdepth
		objXMLv.childNodes(2).text = oMain.FItemList(j).Fcatename
		objXMLv.childNodes(3).text = "/shopping/category_list.asp?disp=" & oMain.FItemList(j).Fcatecode & ""
		objXMLv.childNodes(4).text = oMain.FItemList(j).Fdep3exist

		objXML.documentElement.appendChild(objXMLv.cloneNode(True))
		Set objXMLv = Nothing
	Next

	'-----파일 저장
	objXML.save(savePath & FileName)

	'-----객체 해제
	Set objXML = Nothing
	Set oMain = Nothing
%>
<script>
alert("1차 생성완료");
window.location.href='menu_make_xml_New_JS_ALL.asp';

//alert("생성완료");
//window.close();
</script>
<%
Function fnCateMakeHtml(arr, v2DepCount)
	'### select 2depthcode, 2depthname
	Dim vBody, i, j, vPreCode, vCnt1, vCnt2, v3DepCount, vArray, cCaArr
	vBody = ""
	vCnt1 = 0
	vCnt2 = 0
	
		For i = 0 To UBound(arr,2)
		
			'### 앞 4칸 - 길게 한칸
			If i < 4 Then
				Set cCaArr = New CMainMenu
				cCaArr.FRectCateCode = arr(0,i)
				cCaArr.FRectUseYN = "y"
				vArray = cCaArr.GetMainMenuListNewDepth3
				v3DepCount = cCaArr.FResultCount
				Set cCaArr = Nothing
	
				If isArray(vArray) Then
					
				vBody = vBody & "		<div class='deptUnitV15'>" & vbCrLf
				vBody = vBody & "			<dl>" & vbCrLf
				vBody = vBody & "				<dt><p><a href='/shopping/category_list.asp?disp="&arr(0,i)&"'>" & Replace(arr(1,i),"&","&amp;") & "<span class='icoHot' style='display:none;' id='tophotdisp"&arr(0,i)&"'> <img src='http://fiximage.10x10.co.kr/web2013/common/ico_hot.gif' alt='HOT' /></span><span class='icoNew' " & CHKIIF(arr(2,i)="o","","style='display:none;'") & "> <img src='http://fiximage.10x10.co.kr/web2013/common/ico_new2.gif' alt='New' /></span></a></p></dt>" & vbCrLf
				vBody = vBody & "				<dd>" & vbCrLf
				vBody = vBody & "					<ul class='deptListV15'>" & vbCrLf
				
				For j = 0 To UBound(vArray,2)
					If j < 10 Then
						vBody = vBody & "						<li><a href='/shopping/category_list.asp?disp="&vArray(0,j)&"'>" & Replace(vArray(1,j),"&","&amp;") & " <span class='icoHot' style='display:none;' id='tophotdisp"&vArray(0,j)&"'><img src='http://fiximage.10x10.co.kr/web2013/common/ico_hot.gif' alt='HOT' /></span> <span class='icoNew' " & CHKIIF(vArray(2,j)="o","","style='display:none;'") & "><img src='http://fiximage.10x10.co.kr/web2013/common/ico_new2.gif' alt='New' /></span></a></li>" & vbCrLf
					End If
				Next
				
				vBody = vBody & "					</ul>" & vbCrLf
				If v3DepCount > 10 Then
					vBody = vBody & "					<span class='gnbMoreV15'><a href='/shopping/category_list.asp?disp="&arr(0,i)&"'>more</a> &gt;</span>" & vbCrLf
				End If
				vBody = vBody & "				</dd>" & vbCrLf
				vBody = vBody & "			</dl>" & vbCrLf
				vBody = vBody & "		</div>" & vbCrLf
				
				End If
			End If

			
			'### 다음 1칸 - 2dep카테고리에 3뎁레이어
			If i >= 4 AND i < 14 Then
				
				If i = 4 Then
				vBody = vBody & "		<div class='deptUnitV15 deptUnitTopV15'>" & vbCrLf
				vBody = vBody & "			<ul class='deptListV15'>" & vbCrLf
				End If
				vBody = vBody & "				<li><p><a href='/shopping/category_list.asp?disp="&arr(0,i)&"'>" & Replace(arr(1,i),"&","&amp;") & "<span class='icoHot' style='display:none;' id='tophotdisp"&arr(0,i)&"'> <img src='http://fiximage.10x10.co.kr/web2013/common/ico_hot.gif' alt='HOT' /></span><span class='icoNew' " & CHKIIF(arr(2,i)="o","","style='display:none;'") & "> <img src='http://fiximage.10x10.co.kr/web2013/common/ico_new2.gif' alt='New' /></span></a></p>" & vbCrLf
				
				Set cCaArr = New CMainMenu
				cCaArr.FRectCateCode = arr(0,i)
				cCaArr.FRectUseYN = "y"
				vArray = cCaArr.GetMainMenuListNewDepth3
				v3DepCount = cCaArr.FResultCount
				Set cCaArr = Nothing
				
				If isArray(vArray) Then
					vBody = vBody & "					<div class='subGroupWrapV15'>" & vbCrLf
					vBody = vBody & "						<div class='subGroupV15'>" & vbCrLf
					vBody = vBody & "							<ul class='deptListV15'>" & vbCrLf
					
					For j = 0 To UBound(vArray,2)
						If j < 10 Then
							vBody = vBody & "							<li><a href='/shopping/category_list.asp?disp="&vArray(0,j)&"'>" & Replace(vArray(1,j),"&","&amp;") & "<span class='icoHot' style='display:none;' id='tophotdisp"&vArray(0,j)&"'> <img src='http://fiximage.10x10.co.kr/web2013/common/ico_hot.gif' alt='HOT' /></span><span class='icoNew' " & CHKIIF(vArray(2,j)="o","","style='display:none;'") & "> <img src='http://fiximage.10x10.co.kr/web2013/common/ico_new2.gif' alt='New' /></span></a></li>" & vbCrLf
						End If
					Next

					vBody = vBody & "							</ul>" & vbCrLf
					If v3DepCount > 10 Then
					vBody = vBody & "							<span class='gnbMoreV15'><a href='/shopping/category_list.asp?disp="&arr(0,i)&"'>more</a> &gt;</span>" & vbCrLf
					End If
					vBody = vBody & "						</div>" & vbCrLf
					vBody = vBody & "					</div>" & vbCrLf
				
				End If
				
				vBody = vBody & "				</li>" & vbCrLf
			End If
			
			If i = UBound(arr,2) OR i = 13 Then
				vBody = vBody & "				<li><p><a href='/shoppingtoday/shoppingchance_saleitem.asp?disp="&arr(0,i)&"' class='cRd0V15'>SALE</a></p></li>" & vbCrLf
				vBody = vBody & "				<li><p><a href='/shoppingtoday/shoppingchance_allevent.asp?disp="&arr(0,i)&"'>EVENT</a></p></li>" & vbCrLf
				vBody = vBody & "			</ul>" & vbCrLf
				vBody = vBody & "		</div>" & vbCrLf
				Exit For
			End If
		Next

	fnCateMakeHtml = vBody
End Function

Function fnCateName1Depth(c)
	Dim a
	rsget.Open "select db_item.dbo.getDisplayCateName('" & c & "')",dbget, 1
	If not rsget.Eof Then
		a = rsget(0)
	End If
	rsget.close()
	fnCateName1Depth = a
End Function

Function fnGetHotCatelist()
    
	rsget.Open "SELECT catecode FROM [db_sitemaster].[dbo].[tbl_dispcate_hot]",dbget, 1
	If not rsget.Eof Then
		fnGetHotCatelist = rsget.getRows()
	End If
	rsget.close()
	
End Function
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
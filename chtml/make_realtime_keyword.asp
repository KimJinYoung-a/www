<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/util/functions.asp" -->
<%
response.charset = "utf-8"
Session.Codepage = 65001
'#######################################################
' Discription : today _ 실시간 급상승 검색어
' History : 2017-04-24 이종화 생성
' History : 2018-05-28 정태훈 ImageBasic600 추가
'#######################################################

dim refip : refip = request.serverVariables("REMOTE_ADDR")
if (application("Svr_Info")="Dev") then
    
else
    if NOT (refip="110.93.128.113") and NOT (LEFT(refip,11)="61.252.133.") then
        dbget.close():
        response.write "invalid"
        response.end
    end if
end if


Dim gaParam : gaParam = "&gaparam=main_keyword_" '//GA 체크 변수
dim chkMyKeyword : chkMyKeyword=True '나의 검색어
	dim arrMyKwd, mykeywordloop
	dim retUrl
	retUrl = request.ServerVariables("HTTP_REFERER")

	'//검색어
	DIM oPpkDoc, arrRTg , arrRtp
	SET oPpkDoc = NEW SearchItemCls
		oPpkDoc.FPageSize = 20
		oPpkDoc.getPopularKeyWords2 arrRtp,arrRTg				'인기검색어 순위정보 포함
	SET oPpkDoc = NOTHING

Dim strList , bestkeywordlist
dim brand_id, categoryname

Function callsearchitemtojson(SearchText,knum)
	dim SearchItemDiv	: SearchItemDiv="y"	'기본 카테고리만
	dim SearchCateDep	: SearchCateDep= "T"	'하위카테고리 모두 검색
	dim SortMet			: SortMet="be"		'베스트:be, 신상:ne
	dim SearchFlag		: searchFlag= "n"
	dim ListDiv			: ListDiv = "search" '카테고리/검색 구분용
	dim colorCD			: colorCD="0"
	dim CurrPage		: CurrPage=1
	dim PageSize		: PageSize=7
	dim LogsAccept		: LogsAccept = true
	Dim SellScope		: SellScope = "Y"
	dim ScrollCount		: ScrollCount = 1
	dim lp, i
	Dim returnHtml

	Dim kgubun , itemurl , itemname , image

	SearchText = RepWord(SearchText,"[^가-힣a-zA-Z0-9.&%\-\_\s]","")

	'// 상품검색
	dim oDoc,iLp
	set oDoc = new SearchItemCls
	oDoc.FRectSearchTxt = SearchText
	oDoc.FRectSortMethod	= SortMet
	oDoc.FRectSearchFlag = searchFlag
	oDoc.FRectSearchItemDiv = SearchItemDiv
	oDoc.FRectSearchCateDep = SearchCateDep

	oDoc.FCurrPage = CurrPage
	oDoc.FPageSize = PageSize
	oDoc.FScrollCount = ScrollCount
	oDoc.FListDiv = ListDiv
	oDoc.FLogsAccept = LogsAccept
	oDoc.FRectColsSize = 10
	oDoc.FcolorCode = colorCD
	oDoc.FSellScope=SellScope
	oDoc.getSearchList

	'// html 시작
		returnHtml = "<div class=""items type-thumb item-150 item-hover"" style=""display:none;""><ul>"
	For i=0 To oDoc.FResultCount-1
		itemurl		= "/shopping/category_Prd.asp?itemid="& oDoc.FItemList(i).FItemID & "&gaparam=main_keyworditem_"& Server.URLEncode(SearchText) &"_"& kgubun+1 &"_"& i+1
		itemname	= oDoc.FItemList(i).FItemName
		If i = 0 Then 
			image	= oDoc.FItemList(i).FImageBasic600
		Else
			image	= getThumbImgFromURL(oDoc.FItemList(i).FImageBasic,200,200,"true","false")
		End If 

		brand_id = fnItemIdToBrandName(oDoc.FItemList(i).FItemID)
		categoryname = fnItemIdToCategory1DepthName(oDoc.FItemList(i).FItemID)

		returnHtml =  returnHtml & "<li>"
		returnHtml =  returnHtml & "	<a href="""& itemurl &""" onclick=fnAmplitudeEventMultiPropertiesAction('click_mainrealtime_keyword','itemid|categoryname|brand_id|itemindex','"& oDoc.FItemList(i).FItemID &"|"& categoryname &"|"& brand_id &"|"& i+1 &"');>"
		returnHtml =  returnHtml & "		<div class=""thumbnail"">"
If oDoc.FItemList(i).IsSaleItem or oDoc.FItemList(i).isCouponItem Then
	IF oDoc.FItemList(i).IsSaleItem then 
		returnHtml =  returnHtml & "				<span class=""discount color-red"">"& oDoc.FItemList(i).getSalePro &"</span>"
	End If
	IF oDoc.FItemList(i).IsCouponItem Then
		returnHtml =  returnHtml & "				<span class=""discount color-green"">"& oDoc.FItemList(i).GetCouponDiscountStr &"</span>"
	End If
End If
		returnHtml =  returnHtml & "		<img src="""& image &""" alt="""& itemname &"""></div>"
		returnHtml =  returnHtml & "		<div class=""desc"">"
		returnHtml =  returnHtml & "			<p class=""name"">"& itemname &"</p>"
		returnHtml =  returnHtml & "			<div class=""price"">"
If oDoc.FItemList(i).IsSaleItem or oDoc.FItemList(i).isCouponItem Then
	IF oDoc.FItemList(i).IsSaleItem then 
		returnHtml =  returnHtml & "				<span class=""discount color-red"">"& oDoc.FItemList(i).getSalePro &"</span>"
		returnHtml =  returnHtml & "				<span class=""sum"">"& FormatNumber(oDoc.FItemList(i).getRealPrice,0) &"</span>"
	End If
	IF oDoc.FItemList(i).IsCouponItem Then
		returnHtml =  returnHtml & "				<span class=""discount color-green"">"& oDoc.FItemList(i).GetCouponDiscountStr &"</span>"
		returnHtml =  returnHtml & "				<span class=""sum"">"& FormatNumber(oDoc.FItemList(i).GetCouponAssignPrice,0) &"</span>"
	End If
Else 
		returnHtml =  returnHtml & "				<span class=""sum"">"& FormatNumber(oDoc.FItemList(i).getRealPrice,0) & chkIIF(oDoc.FItemList(i).IsMileShopitem,"Point","원") &"</span>"
End If
		returnHtml =  returnHtml & "			</div>"
		returnHtml =  returnHtml & "		</div>"
		returnHtml =  returnHtml & "	</a>"
		returnHtml =  returnHtml & "</li>"
	Next
		returnHtml =  returnHtml & "</ul></div>"

	If oDoc.FResultCount < 5 Then 
		returnHtml = ""
	End If 

	set oDoc = Nothing
	callsearchitemtojson = returnHtml
End Function

'on Error Resume Next
If isArray(arrRtp)  THEN
		
		dim vArwhtml , t_keyword , bestkeyworditem , tmphtml
		Dim ii : ii = 0
		If Ubound(arrRtp)>0 then
			For mykeywordloop=0 To UBOUND(arrRtp)
				If arrRtp(mykeywordloop) <> t_keyword Then
					if trim(arrRtp(mykeywordloop))<>"" Then
						If ii > 9 Then Exit For 

						tmphtml = callsearchitemtojson(arrRtp(mykeywordloop),mykeywordloop) '// 상품명을 만들면서 검색어를 만든다.
						bestkeyworditem = bestkeyworditem & tmphtml

						If tmphtml <> "" And Not(isnull(tmphtml)) Then 
							'등락표시
							if cStr(arrRTg(mykeywordloop))="new" then
								vArwhtml = "<span class=""icoV18 ico-new"">NEW</span>"
							elseif arrRTg(mykeywordloop)="0" or arrRTg(mykeywordloop)="" or arrRTg(mykeywordloop)="-" then
								vArwhtml = ""
							elseif arrRTg(mykeywordloop)>0 then
								vArwhtml = "<span class=""icoV18 ico-up"">상승</span>"
							else
								vArwhtml = ""
							end If
							
							bestkeywordlist = bestkeywordlist &"<li><a href=""/search/search_result.asp?rect="&Server.URLEncode(arrRtp(mykeywordloop)) &"&burl="&Server.URLEncode(retUrl)&gaParam&Server.URLEncode(arrRtp(mykeywordloop)) &"""onclick=fnAmplitudeEventMultiPropertiesAction('click_mainrealtime_keyword','indexnumber|keyword','"&ii+1&"|"& arrRtp(mykeywordloop) &"');><em>"&ii+1&"</em>"& arrRtp(mykeywordloop) & vArwhtml &"</a></li>"

						ii = ii + 1
						End If 
					End If
				end If
			t_keyword = arrRtp(mykeywordloop)
			Next
		End If

		strList = "<div class=""section hot-keyword"">"
		strList = strList&"<div class=""inner-cont"">"
		strList = strList&"<h2>급상승 <b>인기 검색어</b></h2>"
		strList = strList&"<ol class=""ranking"">"
		strList = strList& bestkeywordlist
		strList = strList&"</ol>"
		strList = strList& bestkeyworditem
		strList = strList&"</div>"
		strList = strList&"</div>"

    
    dim savePath, FileName, fso
    IF (ERR) or (ii<10) then 
        response.write "ERR"
        'response.write strList
    ELSE
            
        savePath = server.mappath("/chtml/")&"\main\html\"
        FileName = "realtime_keyword_pcweb.html"
        Set fso = Server.CreateObject("ADODB.Stream")
        	fso.Open
        	fso.Type = 2
        	fso.Charset = "UTF-8"
        	fso.WriteText (strList)
        	fso.SaveToFile savePath & FileName, 2
        Set fso = nothing
        
        response.write "OK"
    END IF 

End If 
'on Error Goto 0
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
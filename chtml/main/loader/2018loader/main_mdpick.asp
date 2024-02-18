<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
response.charset = "utf-8"
Session.Codepage = 65001
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
'#######################################################
' Discription : pc_main_multievent_banner // cache DB경유
' History : 2018-03-15 이종화 생성
'#######################################################
Dim intI
Dim sqlStr , rsMem , arrList , contentsHtml
Dim gaParam : gaParam = "&gaparam=main_mdpick_" '//GA 체크 변수
Dim alink
Dim photoimg , linkinfo , textinfo , linkitemid , idx , itemid , itemname , listimage , icon1image , sellcash , orgprice , sailyn ,  itemcouponyn , itemcouponvalue , itemcoupontype ,  tentenimage200, tentenimage600 , prddate, basicimage
Dim imgurl , totalsale , totalprice , amplitudelookval
Dim itemdiv , dealsaleper
Dim categoryName, brand_id
Dim test, isLowestPrice 

'미리보기용 변수
dim currentDate, testdate

testdate = request("testdate")
if testdate <> "" Then
	currentDate = cdate(testdate) 
end if

'//DB 시간 타이머 00시부터 00시 5분 사이에는 DB 캐쉬 1분에 한번 읽기
Dim cTime , dummyName
If timer > 10 And Cint(timer/60) < 6 Then
	cTime = 60*1
	dummyName = "MDPICK_"&Cint(timer/60)
Else
	cTime = 60*5
	dummyName = "MDPICK"
End If

if testdate <> "" and GetLoginUserLevel = "7" Then
'if testdate <> "" Then
	sqlStr = "EXEC db_sitemaster.dbo.usp_Ten_pcmain_test_mdpicklist_get '"& currentDate &"' "	
else
	sqlStr = "EXEC db_sitemaster.dbo.usp_Ten_pcmain_mdpicklist_get "
end if

set rsMem = getDBCacheSQL(dbget, rsget, dummyName, sqlStr, cTime)
IF Not (rsMem.EOF OR rsMem.BOF) THEN
	arrList = rsMem.GetRows
END IF
rsMem.close

on Error Resume Next
%>
<%
If IsArray(arrList) Then

		contentsHtml = contentsHtml &"<div class='section md-pick'>"
		contentsHtml = contentsHtml &"	<div class='inner-cont'>"
		contentsHtml = contentsHtml &"		<div class='ftLt' style='width:280px;'>"
		contentsHtml = contentsHtml &"			<h2><strong>MD's</strong> Pick</h2>"
		contentsHtml = contentsHtml &"			<p class='desc'>텐바이텐 엠디가<br />자신있게 추천합니다</p>"
		contentsHtml = contentsHtml &"			<ul class='list-tag'>"
		contentsHtml = contentsHtml &"				<li><a href='/award/awardlist.asp?atype=b&gaparam=main_mdpick_best'>#BEST 100</a></li>"
		contentsHtml = contentsHtml &"				<li><a href='/my10x10/popularwish.asp?gaparam=main_mdpick_wish'>#BEST WISH</a></li>"
		contentsHtml = contentsHtml &"				<li><a href='/award/bestaward_new.asp?gaparam=main_mdpick_newbest'>#NEW BEST</a></li>"
		contentsHtml = contentsHtml &"			</ul>"
		contentsHtml = contentsHtml &"		</div>"
		contentsHtml = contentsHtml &"		<div class='ftRt' style='width:860px;'>"
		contentsHtml = contentsHtml &"			<div class='items type-thumb'>"
		contentsHtml = contentsHtml &"				<ul>"

	For intI = 0 To ubound(arrlist,2)
		'// mdpick 노출갯수 16개->15개로 변경
		If intI>= 15 Then
			Exit For
		End If

		photoimg			= arrlist(0,intI)
		linkinfo			= arrlist(1,intI)
		itemname			= arrlist(2,intI)
		linkitemid			= arrlist(3,intI)
		idx					= arrlist(4,intI)
		itemid				= arrlist(5,intI)
		listimage			= arrlist(7,intI)
		icon1image			= arrlist(8,intI)
		sellcash			= arrlist(9,intI)
		orgprice			= arrlist(10,intI)
		sailyn				= arrlist(11,intI)
		itemcouponyn		= arrlist(12,intI)
		itemcouponvalue		= arrlist(13,intI)
		itemcoupontype		= arrlist(14,intI)
		tentenimage200		= arrlist(15,intI)
		prddate				= arrlist(18,intI)
		itemdiv				= arrlist(19,intI)
		dealsaleper			= arrlist(20,intI)
		isLowestPrice		= arrlist(21,intI)
		tentenimage600		= arrlist(22,intI)
		basicimage			= arrlist(23,intI)

		If Not(photoimg="" or isNull(photoimg)) then 
			photoimg	= staticImgUrl & "/contents/maincontents/" & photoimg & "/10x10/resize/260x260/"
		End If 

		'If Not(listimage="" or isNull(icon1image)) then 
		'	listimage	= "http://webimage.10x10.co.kr/image/icon1/" & GetImageSubFolderByItemid(itemid) & "/" & icon1image & "/10x10/resize/260x260/"
		'End If 

		If Not(tentenimage600="" or isNull(tentenimage600)) then 
			IF application("Svr_Info") = "Dev" THEN
				tentenimage600	= "http://testwebimage.10x10.co.kr/image/tenten600/" & GetImageSubFolderByItemid(itemid) & "/" & tentenimage600
			Else
				tentenimage600	= "http://webimage.10x10.co.kr/image/tenten600/" & GetImageSubFolderByItemid(itemid) & "/" & tentenimage600 & "/10x10/resize/260x260/"
			End If			
		End If

		If Not(basicimage="" or isNull(basicimage)) then 
			IF application("Svr_Info") = "Dev" THEN
				basicimage	= "http://testwebimage.10x10.co.kr/image/basic/" & GetImageSubFolderByItemid(itemid) & "/" & basicimage
			Else
				basicimage	= "http://webimage.10x10.co.kr/image/basic/" & GetImageSubFolderByItemid(itemid) & "/" & basicimage & "/10x10/resize/260x260/"
			End If			
		End If

		If Not(photoimg="" Or isnull(photoimg)) Then
			imgurl = photoimg
		ElseIf Not(tentenimage600="" Or isnull(tentenimage600)) Then
			imgurl = tentenimage600
		Else
			imgurl = basicimage
		End If

		If itemdiv = "21" Then 
			totalprice = ""&formatNumber(sellCash,0) &" ~"
			If dealsaleper >0 Then
				totalsale = ""& dealsaleper &"%"
			Else
				totalsale=""
			End If
		else
			if sailyn = "N" and itemcouponyn = "N" Then
				totalprice = ""&formatNumber(orgPrice,0) &""
			End If
			If sailyn = "Y" and itemcouponyn = "N" Then
				totalprice = ""&formatNumber(sellCash,0) &""
			End If
			if itemcouponyn = "Y" And itemcouponvalue>0 Then
				If itemcoupontype = "1" Then
				totalprice = ""&formatNumber(sellCash - CLng(itemcouponvalue*sellCash/100),0) &""
				ElseIf itemcoupontype = "2" Then
				totalprice = ""&formatNumber(sellCash - itemcouponvalue,0) &""
				ElseIf itemcoupontype = "3" Then
				totalprice = ""&formatNumber(sellCash,0) &""
				Else
				totalprice = ""&formatNumber(sellCash,0) &""
				End If
			End If
			If sailyn = "Y" And itemcouponyn = "Y" Then
				If itemcoupontype = "1" Then
					'//할인 + %쿠폰
					totalsale = ""& CLng((orgPrice-(sellCash - CLng(itemcouponvalue*sellCash/100)))/orgPrice*100)&"%"
				ElseIf itemcoupontype = "2" Then
					'//할인 + 원쿠폰
					totalsale = ""& CLng((orgPrice-(sellCash - itemcouponvalue))/orgPrice*100)&"%"
				Else
					'//할인 + 무배쿠폰
					totalsale = ""& CLng((orgPrice-sellCash)/orgPrice*100)&"%"
				End If 
			ElseIf sailyn = "Y" and itemcouponyn = "N" Then
				If CLng((orgPrice-sellCash)/orgPrice*100)> 0 Then
					totalsale = ""& CLng((orgPrice-sellCash)/orgPrice*100)&"%"
				End If
			elseif sailyn = "N" And itemcouponyn = "Y" And itemcouponvalue>0 Then
				If itemcoupontype = "1" Then
					totalsale = ""&  CStr(itemcouponvalue) & "%"
				ElseIf itemcoupontype = "2" Then
					totalsale = "쿠폰"
				ElseIf itemcoupontype = "3" Then
					totalsale = "쿠폰"
				Else
					totalsale = ""& itemcouponvalue &"%"
				End If
			Else 
				totalsale = ""
			End If
			categoryname = fnItemIdToCategory1DepthName(itemid)
			brand_id = fnItemIdToBrandName(itemid)
		End If 


		alink = linkinfo & gaParam & intI+1

		amplitudelookval = "{'MdpickNumber':'"&intI&"'}" 
		amplitudelookval = Replace(amplitudelookval, "'", "\""")

		contentsHtml = contentsHtml &"					<li onclick=fnAmplitudeEventMultiPropertiesAction('click_mainmdpick','mdpicknumber|itemid|categoryname|brand_id','"& intI+1 &"|"& itemid &"|"& categoryname &"|"& brand_id &"');>"
		contentsHtml = contentsHtml &"						<a href='"& alink &"' onclick=AmpEventMdPick(JSON.parse('"& amplitudelookval &"'));>"
		contentsHtml = contentsHtml &"							<div class='thumbnail'> "
		If Trim(isLowestPrice)="Y" Then
			contentsHtml = contentsHtml &"								<p class='tagV18 t-low'><span>최저가</span></p> "
		End If
		contentsHtml = contentsHtml &"								<img src='"& imgurl &"' alt='"& itemname &"'></div>"
		contentsHtml = contentsHtml &"							<div class='desc'>"
		contentsHtml = contentsHtml &"								<p class='name'>"& chrbyte(itemname,30,"Y") & chkiif(CInt(datediff("d",Left(prddate,10),Date())) < 15," <span class='labelV18 color-blue'>NEW</span>","") &"</p>"
		contentsHtml = contentsHtml &"								<div class='price'>"

		If itemdiv = "21" Then
			contentsHtml = contentsHtml &"									<span class='discount color-red'>"& totalsale &"</span>"
		else
			If itemcouponyn = "Y" Then
			contentsHtml = contentsHtml &"									<span class='discount color-green'>"& totalsale &"</span>"
			Else 
			contentsHtml = contentsHtml &"									<span class='discount color-red'>"& totalsale &"</span>"
			End If 
		End If 

		contentsHtml = contentsHtml &"									<span class='sum'>"& totalprice &"</span>"
		contentsHtml = contentsHtml &"								</div>"
		contentsHtml = contentsHtml &"							</div>"
		contentsHtml = contentsHtml &"						</a>"
		contentsHtml = contentsHtml &"					</li>"

	Next


		contentsHtml = contentsHtml &"				</ul>"
		'contentsHtml = contentsHtml &"				<button type='button' class='btn-more'>펼쳐보기<span class='arrow-bottom bottom2'></span></button>"
		contentsHtml = contentsHtml &"			</div>"
		contentsHtml = contentsHtml &"		</div>"
		contentsHtml = contentsHtml &"	</div>"
		contentsHtml = contentsHtml &"	<script>function AmpEventMdPick(jsonval){AmplitudeEventSend('MainMdPick', jsonval, 'eventProperties');}</script>"
		contentsHtml = contentsHtml &"</div>"
End If

on Error Goto 0

Response.write contentsHtml
%>


<!-- #include virtual="/lib/db/dbclose.asp" -->
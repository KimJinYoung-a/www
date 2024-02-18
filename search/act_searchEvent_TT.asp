<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.Buffer = True
'#######################################################
'	History	:  2013.09.28 허진원 생성
'	Description : 이벤트 검색 결과 Ajax
'#######################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls_TT.asp" -->
<%
	dim oGrEvt, lp
	dim DocSearchText : DocSearchText = requestCheckVar(request("rect"),100) '현재 입력된 검색어
	dim ExceptText	: ExceptText=requestCheckVar(request("extxt"),100) '결과내 제외어
	dim currpage	:	currpage=getNumeric(requestCheckVar(request("cpg"),8)) '페이지
	Dim oGrEvtMore

	if currpage="" then currpage=1

	DocSearchText = RepWord(DocSearchText,"[^가-힣a-zA-Z0-9.&%\-\s]","")
	ExceptText = RepWord(ExceptText,"[^가-힣a-zA-Z0-9.&%\-\s]","")

	'// 이벤트 검색결과
	set oGrEvt = new SearchEventCls
	oGrEvt.FRectSearchTxt = DocSearchText
	oGrEvt.FRectExceptText = ExceptText
	oGrEvt.FRectChannel = "W"
	oGrEvt.FCurrPage = currpage
	oGrEvt.FPageSize = 3
	oGrEvt.FScrollCount =10
	oGrEvt.getEventList

	if (FALSE) and oGrEvt.FResultCount > 0 And oGrEvt.FResultCount < 3 Then
		'// 이벤트 재 검색
		set oGrEvtMore = new SearchEventCls
		oGrEvtMore.FRectSearchTxt = replace(oGrEvt.FItemList(0).Fevt_tag,","," ")
		'oGrEvtMore.FRectSearchTxt = DocSearchText
		'oGrEvtMore.FRectExceptText = ExceptText
		oGrEvtMore.FRectChannel = "W"
		oGrEvtMore.FCurrPage = currpage
		oGrEvtMore.FPageSize = 3 - oGrEvt.FResultCount
		oGrEvtMore.FScrollCount =10
		oGrEvtMore.FRectEvtCode=oGrEvt.FItemList(0).Fevt_code
		oGrEvtMore.getEventListMore
	End If

	'// 이벤트 검색 결과
	if oGrEvt.FResultCount>0 then
%>
							<%
								dim vEvtUrl, vEvtName, vEvtImg
								FOR lp = 0 to oGrEvt.FResultCount-1
									
									'이벤트 링크
									IF oGrEvt.FItemList(lp).Fevt_kind="16" Then		'#브랜드할인이벤트(16)
										vEvtUrl = "/street/street_brand.asp?makerid=" & oGrEvt.FItemList(lp).Fbrand
										vEvtName = chrbyte(split(oGrEvt.FItemList(lp).Fevt_name,"|")(0),52,"Y")
									Else
										vEvtName = db2html(oGrEvt.FItemList(lp).Fevt_name)
										if ubound(Split(vEvtName,"|"))> 0 Then
											If oGrEvt.FItemList(lp).Fissale Or (oGrEvt.FItemList(lp).Fissale And oGrEvt.FItemList(lp).Fiscoupon) then
												vEvtName	= chrbyte(Split(vEvtName,"|")(0),50,"Y") &" <span style=color:red>"&cStr(Split(vEvtName,"|")(1))&"</span>"
											ElseIf oGrEvt.FItemList(lp).Fiscoupon Then
												vEvtName	= chrbyte(Split(vEvtName,"|")(0),50,"Y") &" <span style=color:green>"&cStr(Split(vEvtName,"|")(1))&"</span>"
											else
												vEvtName	= chrbyte(Split(vEvtName,"|")(0),50,"Y")
											End If 			
										end If
				
										IF oGrEvt.FItemList(lp).Fevt_LinkType="I" and oGrEvt.FItemList(lp).Fevt_bannerLink<>"" THEN		'#별도 링크타입
											vEvtUrl = oGrEvt.FItemList(lp).Fevt_bannerLink
										Else
											vEvtUrl = "/event/eventmain.asp?eventid=" & oGrEvt.FItemList(lp).Fevt_code
										End If
									End If

									'이벤트 이미지(200x200px)
									If oGrEvt.FItemList(lp).Fevt_mo_listbanner = "" Then
										If oGrEvt.FItemList(lp).Ficon1image <> "" Then
											vEvtImg = "http://webimage.10x10.co.kr/image/icon1/" & GetImageSubFolderByItemid(oGrEvt.FItemList(lp).Fetc_itemid) & "/" & oGrEvt.FItemList(lp).Ficon1image
										else
											vEvtImg = ""
										End IF
									Else
										'// 포토서버 사용
										vEvtImg = oGrEvt.FItemList(lp).Fevt_mo_listbanner
										vEvtImg = chkIIF(application("Svr_Info")<>"Dev",getThumbImgFromURL(vEvtImg,430,230,"true","false"),vEvtImg)
									End If
							%><a href="<%=vEvtUrl%>"><p><img src="<%=vEvtImg%>"></p><p class="evtTitV15"><strong><%=vEvtName%></strong></p><p><%=oGrEvt.FItemList(lp).Fevt_subcopyK%></p></a><%If lp=0 Or lp=1 Then %>|<% End If %><% Next %>
<%
	end if
%>
<%
if oGrEvt.FResultCount > 0 And oGrEvt.FResultCount < 3 Then
	FOR lp = 0 to oGrEvtMore.FResultCount-1
		
		'이벤트 링크
		IF oGrEvtMore.FItemList(lp).Fevt_kind="16" Then		'#브랜드할인이벤트(16)
			vEvtUrl = "/street/street_brand.asp?makerid=" & oGrEvtMore.FItemList(lp).Fbrand
			vEvtName = chrbyte(split(oGrEvtMore.FItemList(lp).Fevt_name,"|")(0),20,"Y")
		Else
			vEvtName = stripHTML(db2html(oGrEvtMore.FItemList(lp).Fevt_name))
			if ubound(Split(vEvtName,"|"))> 0 Then
				If oGrEvtMore.FItemList(lp).Fissale Or (oGrEvtMore.FItemList(lp).Fissale And oGrEvtMore.FItemList(lp).Fiscoupon) then
					vEvtName	= chrbyte(Split(vEvtName,"|")(0),20,"Y") &" <span style=color:red>"&cStr(Split(vEvtName,"|")(1))&"</span>"
				ElseIf oGrEvtMore.FItemList(lp).Fiscoupon Then
					vEvtName	= chrbyte(Split(vEvtName,"|")(0),20,"Y") &" <span style=color:green>"&cStr(Split(vEvtName,"|")(1))&"</span>"
				End If 			
			end If

			IF oGrEvtMore.FItemList(lp).Fevt_LinkType="I" and oGrEvtMore.FItemList(lp).Fevt_bannerLink<>"" THEN		'#별도 링크타입
				vEvtUrl = oGrEvtMore.FItemList(lp).Fevt_bannerLink
			Else
				vEvtUrl = "/event/eventmain.asp?eventid=" & oGrEvtMore.FItemList(lp).Fevt_code
			End If
		End If

		'이벤트 이미지(200x200px)
		If oGrEvtMore.FItemList(lp).Fevt_mo_listbanner = "" Then
			If oGrEvtMore.FItemList(lp).Ficon1image <> "" Then
				vEvtImg = "http://webimage.10x10.co.kr/image/icon1/" & GetImageSubFolderByItemid(oGrEvtMore.FItemList(lp).Fetc_itemid) & "/" & oGrEvtMore.FItemList(lp).Ficon1image
			else
				vEvtImg = ""
			End IF
		Else
			'// 포토서버 사용
			vEvtImg = oGrEvtMore.FItemList(lp).Fevt_mo_listbanner
			vEvtImg = chkIIF(application("Svr_Info")<>"Dev",getThumbImgFromURL(vEvtImg,430,230,"true","false"),vEvtImg)
		End If
%>
	<%If lp=1 Or lp=2 Then %>|<% End If %><a href="<%=vEvtUrl%>"><p><img src="<%=vEvtImg%>" alt="<%=vEvtName%>"></p><p class="evtTitV15"><strong><%=vEvtName%></strong></p><p><%=oGrEvtMore.FItemList(lp).Fevt_subcopyK%></p></a>
<%
	Next
End If
%>
<%
	Set oGrEvt = nothing
	Set oGrEvtMore = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
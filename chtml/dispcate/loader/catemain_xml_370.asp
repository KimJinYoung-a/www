<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
On Error Resume Next
Dim sMainXmlUrl, oFile, fileCont, xmlDOM
Dim sFolder, mainFile, i, CtrlDate, existscnt, needcnt, idx, posname, existsidx, itemlist
Dim vLink1, vImg1, vItemID1, vLink2, vImg2, vItemID2, vLink3, vImg3, vItemID3, vLink4, vImg4, vItemID4, vLink5, vImg5, vItemID5, vLink6, vImg6, vItemID6
Dim image, link, startdate, enddate, vDisp, vClass, vSocName, vSocNameKor, vMakerID, vBrandCopy
Dim vTmp1, vTmp2, vTmp3, vTmp4, vTmp5, vTmp6
Dim vRealPrice1, vSale1, vClass1, vRealPrice2, vSale2, vClass2, vRealPrice3, vSale3, vClass3, vRealPrice4, vSale4, vClass4, vRealPrice5, vSale5, vClass5, vRealPrice6, vSale6, vClass6
	vDisp = request("disp")
	sFolder = "/chtml/dispcate/xml/"
	mainFile = "catemain_xml_370_"&vDisp&".xml"

	'//logparam
	Dim logparam : logparam = "&pCtr="&vDisp
	
	CtrlDate = Date()
	existscnt = 0
	needcnt = 0
	
'// 메인페이지를 구성하는 XML로딩 (파일직접로딩)
sMainXmlUrl = server.MapPath(sFolder & mainFile)	'// 접수 파일
Set oFile = CreateObject("ADODB.Stream")
With oFile
	.Charset = "UTF-8"
	.Type=2
	.mode=3
	.Open
	.loadfromfile sMainXmlUrl
	fileCont=.readtext
	.Close
End With
Set oFile = Nothing

'' itemid : 0,	icon1image : 1,	sellcash : 2,	orgprice : 3,	sailyn : 4, 	itemcouponyn : 5, 	itemcouponvalue : 6, 	itemcoupontype : 7
		
If fileCont<>"" Then
	'// XML 파싱
	Set xmlDOM = Server.CreateObject("MSXML2.DomDocument.3.0")
		xmlDOM.async = False
		xmlDOM.LoadXML fileCont
		'// 하위 항목이 여러개일 때
		Dim cTmpl, tplNodes, cSub, subNodes
		Set cTmpl = xmlDOM.getElementsByTagName("item")
	Set xmlDOM = Nothing

	i = 0
	For each tplNodes in cTmpl
	
		if i>2 then exit for	'//이미지 갯수가 3장일경우 그만뿌림
		
		'변수 저장
		image		= tplNodes.getElementsByTagName("image").item(0).text
		link		= tplNodes.getElementsByTagName("link").item(0).text
		startdate	= CDate(replace(tplNodes.getElementsByTagName("startdate").item(0).text, ",", "-"))
		enddate		= CDate(replace(tplNodes.getElementsByTagName("enddate").item(0).text, ",", "-"))
		idx			= tplNodes.getElementsByTagName("idx").item(0).text
		posname		= tplNodes.getElementsByTagName("posname").item(0).text
		vClass		= tplNodes.getElementsByTagName("tagclass").item(0).text
		vSocName	= tplNodes.getElementsByTagName("socname").item(0).text
		vSocNameKor	= tplNodes.getElementsByTagName("socnamekor").item(0).text
		vMakerID	= tplNodes.getElementsByTagName("makerid").item(0).text
		vBrandCopy	= tplNodes.getElementsByTagName("brandcopy").item(0).text
		itemlist	= tplNodes.getElementsByTagName("itemlist").item(0).text
		
		vItemID1	= Split(Split(itemlist,",")(0),":")(0)
		vLink1		= "/shopping/category_prd.asp?itemid="&vItemID1
		vImg1		= "http://webimage.10x10.co.kr/image/icon1/"&GetImageSubFolderByItemid(vItemID1)&"/"&Split(Split(itemlist,",")(0),":")(1)
		vTmp1		= Split(Split(itemlist,",")(0),":")
		vRealPrice1	= fnRealPrice(vTmp1(3),vTmp1(2),vTmp1(4),vTmp1(5),vTmp1(6),vTmp1(7))
		vSale1		= Round(100-(100*(vRealPrice1/vTmp1(3))))
		vClass1		= fnClassName(vTmp1(4), vTmp1(5))
		
		vItemID2	= Split(Split(itemlist,",")(1),":")(0)
		vLink2		= "/shopping/category_prd.asp?itemid="&vItemID2
		vImg2		= "http://webimage.10x10.co.kr/image/icon1/"&GetImageSubFolderByItemid(vItemID2)&"/"&Split(Split(itemlist,",")(1),":")(1)
		vTmp2		= Split(Split(itemlist,",")(1),":")
		vRealPrice2	= fnRealPrice(vTmp2(3),vTmp2(2),vTmp2(4),vTmp2(5),vTmp2(6),vTmp2(7))
		vSale2		= Round(100-(100*(vRealPrice2/vTmp2(3))))
		vClass2		= fnClassName(vTmp2(4), vTmp2(5))
		
		vItemID3	= Split(Split(itemlist,",")(2),":")(0)
		vLink3		= "/shopping/category_prd.asp?itemid="&vItemID3
		vImg3		= "http://webimage.10x10.co.kr/image/icon1/"&GetImageSubFolderByItemid(vItemID3)&"/"&Split(Split(itemlist,",")(2),":")(1)
		vTmp3		= Split(Split(itemlist,",")(2),":")
		vRealPrice3	= fnRealPrice(vTmp3(3),vTmp3(2),vTmp3(4),vTmp3(5),vTmp3(6),vTmp3(7))
		vSale3		= Round(100-(100*(vRealPrice3/vTmp3(3))))
		vClass3		= fnClassName(vTmp3(4), vTmp3(5))
		
		vItemID4	= Split(Split(itemlist,",")(3),":")(0)
		vLink4		= "/shopping/category_prd.asp?itemid="&vItemID4
		vImg4		= "http://webimage.10x10.co.kr/image/icon1/"&GetImageSubFolderByItemid(vItemID4)&"/"&Split(Split(itemlist,",")(3),":")(1)
		vTmp4		= Split(Split(itemlist,",")(3),":")
		vRealPrice4	= fnRealPrice(vTmp4(3),vTmp4(2),vTmp4(4),vTmp4(5),vTmp4(6),vTmp4(7))
		vSale4		= Round(100-(100*(vRealPrice4/vTmp4(3))))
		vClass4		= fnClassName(vTmp4(4), vTmp4(5))
		
		vItemID5	= Split(Split(itemlist,",")(4),":")(0)
		vLink5		= "/shopping/category_prd.asp?itemid="&vItemID5
		vImg5		= "http://webimage.10x10.co.kr/image/icon1/"&GetImageSubFolderByItemid(vItemID5)&"/"&Split(Split(itemlist,",")(4),":")(1)
		vTmp5		= Split(Split(itemlist,",")(4),":")
		vRealPrice5	= fnRealPrice(vTmp5(3),vTmp5(2),vTmp5(4),vTmp5(5),vTmp5(6),vTmp5(7))
		vSale5		= Round(100-(100*(vRealPrice5/vTmp5(3))))
		vClass5		= fnClassName(vTmp5(4), vTmp5(5))
		
		vItemID6	= Split(Split(itemlist,",")(5),":")(0)
		vLink6		= "/shopping/category_prd.asp?itemid="&vItemID6
		vImg6		= "http://webimage.10x10.co.kr/image/icon1/"&GetImageSubFolderByItemid(vItemID6)&"/"&Split(Split(itemlist,",")(5),":")(1)
		vTmp6		= Split(Split(itemlist,",")(5),":")
		vRealPrice6	= fnRealPrice(vTmp6(3),vTmp6(2),vTmp6(4),vTmp6(5),vTmp6(6),vTmp6(7))
		vSale6		= Round(100-(100*(vRealPrice6/vTmp6(3))))
		vClass6		= fnClassName(vTmp6(4), vTmp6(5))

			
		If CtrlDate >= startdate AND CtrlDate <= enddate Then
%>
		<div <%=CHKIIF(vClass<>"","class='"&vClass&"'","")%>>
			<span class="brTagV15"></span>
			<dl>
				<% If link <> "" Then %>
				<dt><a href="<%=link%>"><%=chrbyte(vSocName,18,"Y")%></a></dt>
				<% Else %>
				<dt><a href="/street/street_brand_sub06.asp?makerid=<%=vMakerID%>"><%=chrbyte(vSocName,18,"Y")%></a></dt>
				<% End If %>
				<dd><%=nl2br(vBrandCopy)%> <strong><%=vSocNameKor%></strong></dd>
			</dl>
			<ul class="pdtList">
				<li><% If vItemID1 <> "" Then %><a href="<%=vLink1%><%=logparam%>"><p class="pdtPhoto"><img src="<%=vImg1%>" alt="<%= posname %> 상품1" /></p><p class="pdtPrice"><%=FormatNumber(vRealPrice1,0)%>원</p></a><% End If %></li>
				<li><% If vItemID2 <> "" Then %><a href="<%=vLink2%><%=logparam%>"><p class="pdtPhoto"><img src="<%=vImg2%>" alt="<%= posname %> 상품2" /></p><p class="pdtPrice"><%=FormatNumber(vRealPrice2,0)%>원</p></a><% End If %></li>
				<li><% If vItemID3 <> "" Then %><a href="<%=vLink3%><%=logparam%>"><p class="pdtPhoto"><img src="<%=vImg3%>" alt="<%= posname %> 상품3" /></p><p class="pdtPrice"><%=FormatNumber(vRealPrice3,0)%>원</p></a><% End If %></li>
				<li><% If vItemID4 <> "" Then %><a href="<%=vLink4%><%=logparam%>"><p class="pdtPhoto"><img src="<%=vImg4%>" alt="<%= posname %> 상품4" /></p><p class="pdtPrice"><%=FormatNumber(vRealPrice4,0)%>원</p></a><% End If %></li>
				<li><% If vItemID5 <> "" Then %><a href="<%=vLink5%><%=logparam%>"><p class="pdtPhoto"><img src="<%=vImg5%>" alt="<%= posname %> 상품5" /></p><p class="pdtPrice"><%=FormatNumber(vRealPrice5,0)%>원</p></a><% End If %></li>
				<li><% If vItemID6 <> "" Then %><a href="<%=vLink6%><%=logparam%>"><p class="pdtPhoto"><img src="<%=vImg6%>" alt="<%= posname %> 상품6" /></p><p class="pdtPrice"><%=FormatNumber(vRealPrice6,0)%>원</p></a><% End If %></li>
			</ul>
		</div>
<%
			existsidx = existsidx + idx + ","		'/등록된 이미지의 IDX를 저장
			
			i = i + 1
		End If
	Next

	existscnt = ubound(split(existsidx,","))	'//위에서 등록된 이미지수
	If existscnt = "-1" Then
		existscnt = 0
	End IF
	needcnt = 3-existscnt		'//모자란 이미지수
		
	i = 0
	'//만약 등록을 안했을경우 종료 이전꺼를 가져옴
	For each tplNodes in cTmpl
	
		if i>=needcnt then exit for	'//모자란 이미지수 만큼만 뿌린다
			
		'변수 저장
		image		= tplNodes.getElementsByTagName("image").item(0).text
		link		= tplNodes.getElementsByTagName("link").item(0).text
		startdate	= CDate(replace(tplNodes.getElementsByTagName("startdate").item(0).text, ",", "-"))
		enddate		= CDate(replace(tplNodes.getElementsByTagName("enddate").item(0).text, ",", "-"))
		idx			= tplNodes.getElementsByTagName("idx").item(0).text
		posname		= tplNodes.getElementsByTagName("posname").item(0).text
		vClass		= tplNodes.getElementsByTagName("tagclass").item(0).text
		vSocName	= tplNodes.getElementsByTagName("socname").item(0).text
		vSocNameKor	= tplNodes.getElementsByTagName("socnamekor").item(0).text
		vMakerID	= tplNodes.getElementsByTagName("makerid").item(0).text
		itemlist	= tplNodes.getElementsByTagName("itemlist").item(0).text
		
		vItemID1	= Split(Split(itemlist,",")(0),":")(0)
		vLink1		= "/shopping/category_prd.asp?itemid="&vItemID1
		vImg1		= "http://webimage.10x10.co.kr/image/icon1/"&GetImageSubFolderByItemid(vItemID1)&"/"&Split(Split(itemlist,",")(0),":")(1)
		vTmp1		= Split(Split(itemlist,",")(0),":")
		vRealPrice1	= fnRealPrice(vTmp1(3),vTmp1(2),vTmp1(4),vTmp1(5),vTmp1(6),vTmp1(7))
		vSale1		= Round(100-(100*(vRealPrice1/vTmp1(3))))
		vClass1		= fnClassName(vTmp1(4), vTmp1(5))
		
		vItemID2	= Split(Split(itemlist,",")(1),":")(0)
		vLink2		= "/shopping/category_prd.asp?itemid="&vItemID2
		vImg2		= "http://webimage.10x10.co.kr/image/icon1/"&GetImageSubFolderByItemid(vItemID2)&"/"&Split(Split(itemlist,",")(1),":")(1)
		vTmp2		= Split(Split(itemlist,",")(1),":")
		vRealPrice2	= fnRealPrice(vTmp2(3),vTmp2(2),vTmp2(4),vTmp2(5),vTmp2(6),vTmp2(7))
		vSale2		= Round(100-(100*(vRealPrice2/vTmp2(3))))
		vClass2		= fnClassName(vTmp2(4), vTmp2(5))
		
		vItemID3	= Split(Split(itemlist,",")(2),":")(0)
		vLink3		= "/shopping/category_prd.asp?itemid="&vItemID3
		vImg3		= "http://webimage.10x10.co.kr/image/icon1/"&GetImageSubFolderByItemid(vItemID3)&"/"&Split(Split(itemlist,",")(2),":")(1)
		vTmp3		= Split(Split(itemlist,",")(2),":")
		vRealPrice3	= fnRealPrice(vTmp3(3),vTmp3(2),vTmp3(4),vTmp3(5),vTmp3(6),vTmp3(7))
		vSale3		= Round(100-(100*(vRealPrice3/vTmp3(3))))
		vClass3		= fnClassName(vTmp3(4), vTmp3(5))
		
		vItemID4	= Split(Split(itemlist,",")(3),":")(0)
		vLink4		= "/shopping/category_prd.asp?itemid="&vItemID4
		vImg4		= "http://webimage.10x10.co.kr/image/icon1/"&GetImageSubFolderByItemid(vItemID4)&"/"&Split(Split(itemlist,",")(3),":")(1)
		vTmp4		= Split(Split(itemlist,",")(3),":")
		vRealPrice4	= fnRealPrice(vTmp4(3),vTmp4(2),vTmp4(4),vTmp4(5),vTmp4(6),vTmp4(7))
		vSale4		= Round(100-(100*(vRealPrice4/vTmp4(3))))
		vClass4		= fnClassName(vTmp4(4), vTmp4(5))
		
		vItemID5	= Split(Split(itemlist,",")(4),":")(0)
		vLink5		= "/shopping/category_prd.asp?itemid="&vItemID5
		vImg5		= "http://webimage.10x10.co.kr/image/icon1/"&GetImageSubFolderByItemid(vItemID5)&"/"&Split(Split(itemlist,",")(4),":")(1)
		vTmp5		= Split(Split(itemlist,",")(4),":")
		vRealPrice5	= fnRealPrice(vTmp5(3),vTmp5(2),vTmp5(4),vTmp5(5),vTmp5(6),vTmp5(7))
		vSale5		= Round(100-(100*(vRealPrice5/vTmp5(3))))
		vClass5		= fnClassName(vTmp5(4), vTmp5(5))
		
		vItemID6	= Split(Split(itemlist,",")(5),":")(0)
		vLink6		= "/shopping/category_prd.asp?itemid="&vItemID6
		vImg6		= "http://webimage.10x10.co.kr/image/icon1/"&GetImageSubFolderByItemid(vItemID6)&"/"&Split(Split(itemlist,",")(5),":")(1)
		vTmp6		= Split(Split(itemlist,",")(5),":")
		vRealPrice6	= fnRealPrice(vTmp6(3),vTmp6(2),vTmp6(4),vTmp6(5),vTmp6(6),vTmp6(7))
		vSale6		= Round(100-(100*(vRealPrice6/vTmp6(3))))
		vClass6		= fnClassName(vTmp6(4), vTmp6(5))


			
		'//종료 인것중에, 위에서 노출시킨거 빼고 뿌린다
		If CtrlDate >= startdate AND instr(existsidx,idx)=0 Then
%>
		<div <%=CHKIIF(vClass<>"","class='"&vClass&"'","")%>>
			<span class="brTagV15"></span>
			<dl>
				<% If link <> "" Then %>
				<dt><a href="<%=link%>"><%=chrbyte(vSocName,18,"Y")%></a></dt>
				<% Else %>
				<dt><a href="/street/street_brand_sub06.asp?makerid=<%=vMakerID%>"><%=chrbyte(vSocName,18,"Y")%></a></dt>
				<% End If %>
				<dd><%=nl2br(vBrandCopy)%><strong><%=vSocNameKor%></strong></dd>
			</dl>
			<ul class="pdtList">
				<li><% If vItemID1 <> "" Then %><a href="<%=vLink1%><%=logparam%>"><p class="pdtPhoto"><img src="<%=vImg1%>" alt="<%= posname %> 상품1" /></p><p class="pdtPrice"><%=FormatNumber(vRealPrice1,0)%>원</p></a><% End If %></li>
				<li><% If vItemID2 <> "" Then %><a href="<%=vLink2%><%=logparam%>"><p class="pdtPhoto"><img src="<%=vImg2%>" alt="<%= posname %> 상품2" /></p><p class="pdtPrice"><%=FormatNumber(vRealPrice2,0)%>원</p></a><% End If %></li>
				<li><% If vItemID3 <> "" Then %><a href="<%=vLink3%><%=logparam%>"><p class="pdtPhoto"><img src="<%=vImg3%>" alt="<%= posname %> 상품3" /></p><p class="pdtPrice"><%=FormatNumber(vRealPrice3,0)%>원</p></a><% End If %></li>
				<li><% If vItemID4 <> "" Then %><a href="<%=vLink4%><%=logparam%>"><p class="pdtPhoto"><img src="<%=vImg4%>" alt="<%= posname %> 상품4" /></p><p class="pdtPrice"><%=FormatNumber(vRealPrice4,0)%>원</p></a><% End If %></li>
				<li><% If vItemID5 <> "" Then %><a href="<%=vLink5%><%=logparam%>"><p class="pdtPhoto"><img src="<%=vImg5%>" alt="<%= posname %> 상품5" /></p><p class="pdtPrice"><%=FormatNumber(vRealPrice5,0)%>원</p></a><% End If %></li>
				<li><% If vItemID6 <> "" Then %><a href="<%=vLink6%><%=logparam%>"><p class="pdtPhoto"><img src="<%=vImg6%>" alt="<%= posname %> 상품6" /></p><p class="pdtPrice"><%=FormatNumber(vRealPrice6,0)%>원</p></a><% End If %></li>
			</ul>
		</div>
<%
			i = i + 1
		End If
	Next
	
	Set cTmpl = Nothing
End If
On Error Goto 0



Function fnClassName(sailyn, itemcouponyn)
	Dim vTemp
	If sailyn = "Y" AND itemcouponyn = "Y" Then
		vTemp = "cGr0V15"
	Else
		IF sailyn = "Y" Then
			vTemp = "cRd0V15"
		End IF
		IF itemcouponyn = "Y" Then
			vTemp = "cGr0V15"
		End IF
	End If
	fnClassName = vTemp
End Function


Function fnRealPrice(orgprice, sellcash, sailyn, itemcouponyn, itemcouponvalue, itemcoupontype)
	Dim vPrice
	vPrice = orgprice
	IF sailyn = "Y" AND itemcouponyn = "Y" Then
		vPrice = sellcash
		vPrice = GetCouponAssignPrice(vPrice,itemcouponyn,itemcouponvalue,itemcoupontype)
	Else
		If sailyn = "Y" Then
			vPrice = sellcash
		End If
		If itemcouponyn = "Y" Then
			vPrice = GetCouponAssignPrice(vPrice,itemcouponyn,itemcouponvalue,itemcoupontype)
		End If
	End If
	fnRealPrice = vPrice
End Function


'// 쿠폰 적용가
Function GetCouponAssignPrice(sell,couponyn,cvalue,ctype)
	if (couponyn="Y") then
		GetCouponAssignPrice = sell - GetCouponDiscountPrice(sell,cvalue,ctype)
	else
		GetCouponAssignPrice = sell
	end if
End Function

'// 쿠폰 할인가 '?
Function GetCouponDiscountPrice(sell,cvalue,ctype) 
	Select case ctype
		case "1" ''% 쿠폰
			GetCouponDiscountPrice = CLng(cvalue*sell/100)
		case "2" ''원 쿠폰
			GetCouponDiscountPrice = cvalue
		case "3" ''무료배송 쿠폰
		    GetCouponDiscountPrice = 0
		case else
			GetCouponDiscountPrice = 0
	end Select

End Function
%>
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
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/base64.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
'#######################################################
' Discription : pc_main_foryou // cache DB경유
' History : 2018-03-07 이종화 생성
'#######################################################
Dim poscode , icnt ,jcnt
Dim sqlStr , rsMem , rsMem2 , arrList , arrList2
Dim gaParam : gaParam = "&gaparam=main_foryou_" '//GA 체크 변수

Dim userid : userid = getEncLoginUserID
Dim username : username = GetLoginUserName()

'// foryou
dim itemid , score , basicimage , itemname , sellcash , orgprice , sailprice , itemcouponvalue
Dim orgsuplycash , sailyn , sailsuplycash ,itemcouponyn , itemcoupontype , couponbyprice , brand
Dim totalprice , totalsaleper , amplitudeforyouval

'//DB 시간 타이머 00시부터 00시 5분 사이에는 DB 캐쉬 1분에 한번 읽기
Dim cTime , dummyName , dummyName2
If timer > 10 And Cint(timer/60) < 6 Then
	cTime = 60*1
	dummyName = "FYDATA_"&Cint(timer/60)
	dummyName2 = "MYDATA_"&Cint(timer/60)
Else
	cTime = 60*5
	dummyName = "FYDATA"
	dummyName2 = "MYDATA"
End If

If userid <> "" Then
	'// foryou
	sqlStr = "db_item.dbo.usp_WWW_item_Buyseq_Get @userid ='" & userid  &"'"
	set rsMem = getDBCacheSQL(dbget, rsget, dummyName, sqlStr, cTime)
	IF Not (rsMem.EOF OR rsMem.BOF) THEN		
		arrList = rsMem.GetRows
	END IF
	rsMem.close

	'// 장바구니 , 위시
	sqlStr = "db_sitemaster.dbo.usp_Ten_pcmain_myitems @userid = '" & userid  &"'"
	set rsMem2 = getDBCacheSQL(dbget, rsget, dummyName2, sqlStr, cTime)	
	IF Not (rsMem2.EOF OR rsMem2.BOF) THEN		
		arrList2 = rsMem2.GetRows		
	END IF
	rsMem2.close

	'//쿠폰북 쿠폰 totalcount
	Dim cntSqlstr , rsMem3 , cTotcnt : cTotcnt = 0
		cntSqlstr = "db_item.[dbo].[sp_Ten_couponshop_couponTotalCnt] "
	set rsMem3 = getDBCacheSQL(dbget, rsget, "todaycnt", cntSqlstr, 60*60)
	IF Not (rsMem3.EOF OR rsMem3.BOF) THEN
		cTotcnt = rsMem3(0)
	END IF
	rsMem3.close
End If

on Error Resume Next
%>
<%
If userid <> "" And (IsArray(arrList) Or IsArray(arrList2)) Then
	If not (IsArray(arrList) and IsArray(arrList2)) Then 
%>
	<%' 데이터 있음 %>
	<div class="section custom-rec">
		<div class="inner-cont">
			<h2><b><%=username%>님</b><br />놓치지 마세요!</h2>
			<ul class="my-menu">
				<li><a href="/shoppingtoday/couponshop.asp?gaparam=main_personal_coupon"><span class="icoV18 ico-coupon"></span>쿠폰북<em><%=cTotcnt%></em></a></li>
				<li><a href="/my10x10/popularwish.asp?gaparam=main_personal_wish"><span class="icoV18 ico-heart"></span>위시</a></li>
				<li><a href="/shoppingtoday/shoppingchance_allevent.asp?gaparam=main_personal_event"><span class="icoV18 ico-event"></span>이벤트</a></li>
			</ul>
			<% If IsArray(arrList) Then %>
			<div class="get-item">
				<div class="items type-list">
					<ul>
						<% 
							For jcnt = 0 to ubound(arrList,2)
								If ubound(arrList,2) < 2 Then Exit For
						%>
						<%
							itemid			= arrList(0,jcnt)
							basicimage		= webImgUrl & "/image/basic/" & GetImageSubFolderByItemid(itemid) + "/" & (arrList(2,jcnt))
							itemname		= arrList(3,jcnt)
							sellcash		= arrList(4,jcnt)
							orgprice		= arrList(5,jcnt)
							itemcouponvalue = arrList(7,jcnt)
							sailyn			= arrList(9,jcnt)
							itemcouponyn	= arrList(11,jcnt)
							itemcoupontype	= arrList(12,jcnt)
							couponbyprice	= arrList(13,jcnt)
							brandname		= arrList(14,jcnt)

							amplitudeforyouval = "{'ForYouNumber1':'"&jcnt&"'}" 
							amplitudeforyouval = Replace(amplitudeforyouval, "'", "\""")

							'// 가격 할인
							If sailyn = "N" and itemcouponyn = "N" Then
								totalprice = formatNumber(orgPrice,0)
							End If
							If sailyn = "Y" and itemcouponyn = "N" Then
								totalprice = formatNumber(sellCash,0)
							End If

							if itemcouponyn = "Y" And itemcouponvalue>0 Then
								If itemcoupontype = "1" Then
									totalprice =  formatNumber(sellCash - CLng(itemcouponvalue*sellCash/100),0)
								ElseIf itemcoupontype = "2" Then
									totalprice =  formatNumber(sellCash - itemcouponvalue,0)
								ElseIf itemcoupontype = "3" Then
									totalprice =  formatNumber(sellCash,0)
								Else
									totalprice =  formatNumber(sellCash,0)
								End If
							End If

							If sailyn = "Y" and itemcouponyn = "N" Then
								If CLng((orgPrice-sellCash)/orgPrice*100)> 0 Then
									totalsaleper = CLng((orgPrice-sellCash)/orgPrice*100) &"%"
								End If
							elseif itemcouponyn = "Y" And itemcouponvalue>0 Then
								If itemcoupontype = "1" Then
									totalsaleper = CStr(itemcouponvalue) &"%"
								ElseIf itemcoupontype = "2" Then
									totalsaleper = ""
								ElseIf itemcoupontype = "3" Then
									totalsaleper = ""
								Else
									totalsaleper = CStr(itemcouponvalue) &"%"
								End If
							Else
									totalsaleper = ""
							End If
						%>
						<li>
							<a href="/shopping/category_prd.asp?itemid=<%=itemid%>&gaparam=main_personal_<%=jcnt+1%>" onclick=AmpEventForyou(JSON.parse('<%=amplitudeforyouval%>'));>
								<div class="thumbnail"><img src="<%=getThumbImgFromURL(basicimage,200,200,"true","false")%>" alt="<%=itemname%>" /></div>
								<div class="desc">
									<p class="brand"><%=brandname%></p>
									<p class="name"><%=itemname%></p>
									<div class="price">
										<% If sailyn = "Y" and itemcouponyn = "N" Then %>
										<span class="discount color-red"><%=totalsaleper%></span>
										<% ElseIf itemcouponyn = "Y" And itemcouponvalue>0 Then %>
										<span class="discount color-green"><%=totalsaleper%></span>
										<% End If %>
										<span class="sum"><%=totalprice%></span>
									</div>
								</div>
							</a>
						</li>
						<%
							Next
						%>
					</ul>
				</div>
			</div>
			<% End If %>
			<% If IsArray(arrList2) and ubound(arrList2,2) > 0 Then %>
			<div class="sale-item">
				<%
					amplitudeforyouval = ""
					Dim gubun , iid , bimg , iname , sprice , oprice , syn , icuyn , icutype , icuval
					Dim nextgubun , dummytext , dummylink , totprice , totsale
					Dim gubuncnt1 : gubuncnt1 = 0
					Dim gubuncnt2 : gubuncnt2 = 0
					Dim inhtml(3)
					Dim htmlicon

					For icnt = 0 To ubound(arrList2,2)
						If ubound(arrList2,2) = 0 Then Exit For '// 1개만 있는경우는 아에 노출 안함

						gubun	=	arrList2(0,icnt)
						iid		=	arrList2(2,icnt)
						bimg	=	webImgUrl & "/image/basic/" & GetImageSubFolderByItemid(iid) & "/" & (arrList2(3,icnt))
						iname	=	arrList2(4,icnt)
						sprice	=	arrList2(5,icnt)
						oprice	=	arrList2(6,icnt)
						syn		=	arrList2(8,icnt)
						icuyn	=	arrList2(10,icnt)
						icutype	=	arrList2(11,icnt)
						icuval	=	arrList2(14,icnt)


						amplitudeforyouval = "{'ForYouNumber2':'"&icnt&"'}" 
						amplitudeforyouval = Replace(amplitudeforyouval, "'", "\""")

						'// 가격 할인
						If syn = "N" and icuyn = "N" Then
							totprice = formatNumber(oprice,0)
						End If
						If syn = "Y" and icuyn = "N" Then
							totprice = formatNumber(sprice,0)
						End If

						if icuyn = "Y" And icuval>0 Then
							If icutype = "1" Then
								totprice =  formatNumber(sprice - CLng(icuval*sprice/100),0)
							ElseIf icutype = "2" Then
								totprice =  formatNumber(sprice - icuval,0)
							ElseIf icutype = "3" Then
								totprice =  formatNumber(sprice,0)
							Else
								totprice =  formatNumber(sprice,0)
							End If
						End If

						If syn = "Y" and icuyn = "N" Then
							If CLng((oprice-sprice)/oprice*100)> 0 Then
								totsale = CLng((oprice-sprice)/oprice*100) &"%"
							End If
						elseif icuyn = "Y" And icuval>0 Then
							If icutype = "1" Then
								totsale = CStr(icuval) &"%"
							Else
								totsale = CLng((oprice-sprice)/oprice*100) &"%"
							End If
						Else
								totsale = ""
						End If

						If gubun = "5" Then
							dummytext = "장바구니"
							dummylink = "/inipay/shoppingbag.asp?gaparam=main_personal_cart1"
							gubuncnt1 = gubuncnt1 + 1
							htmlicon  = "cart2"
						ElseIf gubun = "9" Then
							dummytext = "위시리스트"
							dummylink = "/my10x10/mywishlist.asp?gaparam=main_personal_wish1"
							gubuncnt2 = gubuncnt2 + 1
							htmlicon  = "heart2"
						End If

							inhtml(icnt) = "<div class='headline'>"
							inhtml(icnt) = inhtml(icnt) & "<h3><span class='icoV18 ico-"& htmlicon &"'></span><b>"& dummytext &"</b>에 담긴 상품이 <b class='color-red'>할인중</b>입니다!</h3>"
							inhtml(icnt) = inhtml(icnt) & 	"<a href='"& dummylink &"' class='btn-linkV18 link2' onclick=AmpEventForyou(JSON.parse('"& amplitudeforyouval &"'));>더보기 <span></span></a>"
							inhtml(icnt) = inhtml(icnt) & "</div>"
							inhtml(icnt) = inhtml(icnt) & "<div class='items type-list'>"
							inhtml(icnt) = inhtml(icnt) & 	"<a href='/shopping/category_prd.asp?itemid="& iid &"&gaparam=main_personal_"&icnt+1&"'>"
							inhtml(icnt) = inhtml(icnt) & 		"<div class='thumbnail'><img src='"& getThumbImgFromURL(bimg,300,300,"true","false") &"' alt='"& iname &"' /></div>"
							inhtml(icnt) = inhtml(icnt) & 		"<div class='desc'>"
							If syn = "Y" and icuyn = "N" Then
							inhtml(icnt) = inhtml(icnt) & 			"<span class='labelV18 label-red'><b>"& totsale &"</b></span>"
							ElseIf icuyn = "Y" And icuval>0 Then
							inhtml(icnt) = inhtml(icnt) & 			"<span class='labelV18 label-green'><b>"& totsale &"</b></span>"
							End If
							inhtml(icnt) = inhtml(icnt) & 			"<p class='name'>"& iname &"</p>"
							inhtml(icnt) = inhtml(icnt) & 			"<div class='price'>"
							inhtml(icnt) = inhtml(icnt) & 				"<span class='sum'>"& totprice &"</span>"
							inhtml(icnt) = inhtml(icnt) & 			"</div>"
							inhtml(icnt) = inhtml(icnt) & 		"</div>"
							inhtml(icnt) = inhtml(icnt) & 	"</a>"
							inhtml(icnt) = inhtml(icnt) & "</div>"
					Next
				%>
				<%'!-- 장바구니 할인 --%>
				<% If gubuncnt1 > 0 Then  %>
					<div class="article ftLt">
						<%=inhtml(0)%>
					</div>
					<%'!-- 위시리스트 할인 --%>
					<div class="article ftRt">
					<% If gubuncnt1 = 2 And gubuncnt2 = 2 Then %>
						<%=inhtml(2)%>
					<% Else %>
						<%=inhtml(1)%>
					<% End If %>
					</div>
				<% Else %>
					<div class="article ftLt">
						<%=inhtml(0)%>
					</div>
					<div class="article ftRt">
						<%=inhtml(1)%>
					</div>
				<% End If %>
			</div>
			<% End If %>
		</div>
		<script>
			function AmpEventForyou(jsonval)
			{
				AmplitudeEventSend('MainForYou', jsonval, 'eventProperties');
			}
		</script>
	</div>
<%
	End if
End If

on Error Goto 0
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
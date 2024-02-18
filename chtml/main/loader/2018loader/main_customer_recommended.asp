<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
response.charset = "utf-8"
Session.Codepage = 65001
%>
<!-- #include virtual="/lib/db/dbEVTopen.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/base64.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
'#######################################################
' Discription : main_recommended_products // cache DB경유
' History : 2018-04-05 이종화 생성
'#######################################################
Dim poscode , icnt ,jcnt
Dim sqlStr , rsMem , rsMem2 , arrList , arrList2
Dim userid : userid = getEncLoginUserID
Dim username : username = GetLoginUserName()

dim amplitudeTrendView , amplitudeTrendCart

'//DB 시간 타이머 00시부터 00시 5분 사이에는 DB 캐쉬 1분에 한번 읽기
Dim cTime , dummyName , dummyName2
If timer > 10 And Cint(timer/60) < 6 Then
	cTime = 60*1
	dummyName = "TVDATA_"&Cint(timer/60)
	dummyName2 = "TCDATA_"&Cint(timer/60)
Else
	cTime = 60*5
	dummyName = "TVDATA"
	dummyName2 = "TCDATA"
End If

'// 지금다른사람들은 이상품을 보고 있어요 - 73번 
sqlStr = "db_analyze_data_raw.dbo.usp_Ten_trend_data_forpcmain_get"
set rsMem = getDBCacheSQL(dbEVTget, rsEVTget, dummyName, sqlStr, cTime)
IF Not (rsMem.EOF OR rsMem.BOF) THEN
	arrList = rsMem.GetRows
END IF
rsMem.close

'// 지금 장바구니에 이상품이 담기고 있어요 - 72번
sqlStr = "db_sitemaster.dbo.usp_Ten_trend_data_new_forpcmain_get"
set rsMem2 = getDBCacheSQL(dbget, rsget, dummyName2, sqlStr, cTime)
IF Not (rsMem2.EOF OR rsMem2.BOF) THEN
	arrList2 = rsMem2.GetRows
END IF
rsMem2.close

Function gaParam(gubun,num)
	Select Case gubun
		Case 4 
			gaParam = "&gaparam=main_trendview_"&num
		Case 6 
			gaParam = "&gaparam=main_trendcart_"&num
	End Select
End Function 

on Error Resume Next
%>
<%
	If arrList <> "" And arrList2 <> "" Then 
%>
<div class="section cart-item">
	<div class="inner-cont">
		<ul class="tabV18">
			<li class="current"><a href="#hit">조회수 급상승</a></li>
			<li><a href="#popular">장바구니 인기</a></li>
		</ul>
		<div class="tab-container">
			<%'!-- 조회수 급상승 --%>
			<% If IsArray(arrList) Then %>
			<div id="hit" class="tab-cont">
				<div class="ftLt" style="width:300px;">
					<h2>다른 고객들은<br /><b>이 상품을</b><br /><b>보고 있어요</b></h2>
				</div>
				<div class="ftRt" style="width:840px;">
					<div class="items type-thumb item-180 item-hover">
						<ul>
							<%
								Dim saleyn , couponYn , coupontype , couponvalue
								Dim orgPrice , sellcash , itemdiv , basicimage
								Dim itemid , itemurl , image , itemnames , regdt
								Dim totalprice1 , totalsale1
								dim categoryname, brand_id

								For icnt = 0 to ubound(arrList,2)
									itemid			= arrList(2,icnt) 
									itemnames		= arrList(4,icnt) 
									saleyn			= arrList(8,icnt)
									couponYn		= arrList(10,icnt)
									coupontype		= arrList(11,icnt)
									couponvalue		= arrList(14,icnt)
									orgPrice		= arrList(6,icnt)
									sellcash		= arrList(5,icnt)
									itemdiv			= arrList(15,icnt)

									amplitudeTrendView = "{'TrendViewNumber':'"&icnt&"'}" 
									amplitudeTrendView = Replace(amplitudeTrendView, "'", "\""")

									If itemdiv="21" Then
										if instr(arrList(3,icnt),"/") > 0 then
											basicimage  = "http://webimage.10x10.co.kr/image/basic/"& arrList(3,icnt)
										Else
											basicimage  = "http://webimage.10x10.co.kr/image/basic/"& GetImageSubFolderByItemid(arrList(2,icnt)) &"/"& arrList(3,icnt)
										End If
									Else
										basicimage  = "http://webimage.10x10.co.kr/image/basic/"& GetImageSubFolderByItemid(arrList(2,icnt)) &"/"& arrList(3,icnt)
									End If
									itemurl			= "/shopping/category_Prd.asp?itemid="& arrList(2,icnt) & gaParam(arrList(0,icnt),arrList(1,icnt)) 
									image			=  getThumbImgFromURL(basicimage,400,400,"","") 
									regdt			=  arrList(20,icnt)

									If itemdiv = "21" Then
										totalprice1 = formatNumber(sellCash,0)
									else
										If saleyn = "N" and couponYn = "N" Then
											totalprice1 = formatNumber(orgPrice,0)
										End If
										If saleyn = "Y" and couponYn = "N" Then
											totalprice1 = formatNumber(sellCash,0)
										End If
										if couponYn = "Y" And couponvalue>0 Then
											If coupontype = "1" Then
												totalprice1 = formatNumber(sellCash - CLng(couponvalue*sellCash/100),0)
											ElseIf coupontype = "2" Then
												totalprice1 = formatNumber(sellCash - couponvalue,0)
											ElseIf coupontype = "3" Then
												totalprice1 = formatNumber(sellCash,0)
											Else
												totalprice1 = formatNumber(sellCash,0)
											End If
										End If
										If saleyn = "Y" And couponYn = "Y" And couponvalue>0 Then
											If coupontype = "1" Then
												'//할인 + %쿠폰
												totalsale1 = "<span class='discount color-red'>"& CLng((orgPrice-(sellCash - CLng(couponvalue*sellCash/100)))/orgPrice*100) &"%</span>"
											ElseIf coupontype = "2" Then
												'//할인 + 원쿠폰
												totalsale1 = "<span class='discount color-red'>"& CLng((orgPrice-(sellCash - couponvalue))/orgPrice*100)&"%</span>"
											Else
												totalsale1 = "<span class='discount color-red'>"& CLng((orgPrice-sellCash)/orgPrice*100)&"%</span>"
											End If 
										ElseIf saleyn = "Y" and couponYn = "N" Then
											If CLng((orgPrice-sellCash)/orgPrice*100)> 0 Then
												totalsale1 = "<span class='discount color-red'>"& CLng((orgPrice-sellCash)/orgPrice*100)&"%</span>"
											End If
										elseif saleyn = "N" And couponYn = "Y" And couponvalue>0 Then
											If coupontype = "1" Then
												totalsale1 = "<span class='discount color-green'>"& CStr(couponvalue) & "%</span>"
											End If
										Else 
											totalsale1 = ""
										End If
									End If 

									brand_id = fnItemIdToBrandName(itemid)
									categoryname = fnItemIdToCategory1DepthName(itemid)
							%>
							<li>
								<a href="<%=itemurl%>" onclick=AmpEventCustomerRecommended(JSON.parse('<%= amplitudeTrendView %>'));fnAmplitudeEventMultiPropertiesAction('click_mainforyou_views','indexnumber|itemid|categoryname|brand_id','<%=icnt+1%>|<%=itemid%>|<%=categoryname%>|<%=brand_id%>');>
									<div class="thumbnail"><img src="<%=image%>" alt="<%=itemnames%>"></div>
									<div class="desc">
										<p class="name"><%=itemnames%> <%=chkiif(CInt(datediff("d",Left(regdt,10),Date()))<15,"<span class='label label-new'>NEW</span>","")%></p>
										<div class="price">
											<%=totalsale1%>
											<span class="sum"><%=totalprice1%></span>
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
			</div>
			<% End If %>
			<%'!-- 장바구니 인기 --%>
			<% If IsArray(arrList2) Then %>
			<div id="popular" class="tab-cont">
				<div class="ftLt" style="width:300px;">
					<h2>지금 장바구니에<br /><b>이 상품이</b><br /><b>담기고 있어요</b></h2>
				</div>
				<div class="ftRt" style="width:840px;">
					<div class="items type-thumb item-180 item-hover">
						<ul>
							<%
								Dim gubun , sortnum , jsaleyn , jcouponYn , jcoupontype , jcouponvalue , jorgPrice , jsellcash , jitemcouponname
								Dim jbrand , jitemcouponidx , jbasicimage , jitemdiv , jregdt ,jitemURL , jimgurl , jitemname
								Dim totalprice2 , totalsale2
								dim jcategoryname, jbrandid

								For jcnt = 0 To ubound(arrList2,2)
									gubun			= arrList2(0,jcnt)
									sortnum			= arrList2(1,jcnt)
									If sortnum		= "" Then sortnum = 0
									jsaleyn			= arrList2(8,jcnt)
									jcouponYn		= arrList2(10,jcnt)
									jcoupontype		= arrList2(11,jcnt)
									jcouponvalue	= arrList2(14,jcnt)
									jorgPrice		= arrList2(6,jcnt)
									jsellcash		= arrList2(5,jcnt)
									jitemcouponname = arrList2(16,jcnt)
									jbrand		    = arrList2(17,jcnt)
									jitemcouponidx  = arrList2(18,jcnt)
									jitemdiv		= arrList2(19,jcnt)
									jregdt			= arrList2(20,jcnt)
									jitemname		= arrList2(4,jcnt)

									amplitudeTrendCart = "{'TrendCartNumber':'"&jcnt&"'}" 
									amplitudeTrendCart = Replace(amplitudeTrendCart, "'", "\""")

									jcategoryname = fnItemIdToCategory1DepthName(arrList2(2,jcnt))
									jbrandid = fnItemIdToBrandName(arrList2(2,jcnt))

									If jitemdiv="21" Then
										if instr(arrList2(3,jcnt),"/") > 0 then
											jbasicimage  = "http://webimage.10x10.co.kr/image/basic/"& arrList2(3,jcnt)
										Else
											jbasicimage  = "http://webimage.10x10.co.kr/image/basic/"& GetImageSubFolderByItemid(arrList2(2,jcnt)) &"/"& arrList2(3,jcnt)
										End If
									Else
										jbasicimage  = "http://webimage.10x10.co.kr/image/basic/"& GetImageSubFolderByItemid(arrList2(2,jcnt)) &"/"& arrList2(3,jcnt)
									End If

									jitemURL		= "/shopping/category_Prd.asp?itemid="& arrList2(2,jcnt) & gaParam(gubun,sortnum)
									jimgurl			= getThumbImgFromURL(jbasicimage,400,400,"","")

									If jitemdiv = "21" Then
										totalprice2 = formatNumber(jsellCash,0)
									else
										If jsaleyn = "N" and jcouponYn = "N" Then
											totalprice2 = formatNumber(jorgPrice,0)
										End If
										If jsaleyn = "Y" and jcouponYn = "N" Then
											totalprice2 = formatNumber(jsellCash,0)
										End If
										if jcouponYn = "Y" And jcouponvalue>0 Then
											If jcoupontype = "1" Then
												totalprice2 = formatNumber(jsellCash - CLng(jcouponvalue*jsellCash/100),0)
											ElseIf jcoupontype = "2" Then
												totalprice2 = formatNumber(jsellCash - jcouponvalue,0)
											ElseIf jcoupontype = "3" Then
												totalprice2 = formatNumber(jsellCash,0)
											Else
												totalprice2 = formatNumber(jsellCash,0)
											End If
										End If
										If jsaleyn = "Y" And jcouponYn = "Y" And jcouponvalue>0 Then
											If jcoupontype = "1" Then
												'//할인 + %쿠폰
												totalsale2 = "<span class='discount color-red'>"& CLng((jorgPrice-(jsellCash - CLng(jcouponvalue*jsellCash/100)))/jorgPrice*100) &"%</span>"
											ElseIf jcoupontype = "2" Then
												'//할인 + 원쿠폰
												totalsale2 = "<span class='discount color-red'>"& CLng((jorgPrice-(jsellCash - jcouponvalue))/jorgPrice*100)&"%</span>"
											Else
												totalsale2 = "<span class='discount color-red'>"& CLng((jorgPrice-jsellCash)/jorgPrice*100)&"%</span>"
											End If 
										ElseIf jsaleyn = "Y" and jcouponYn = "N" Then
											If CLng((jorgPrice-jsellCash)/jorgPrice*100)> 0 Then
												totalsale2 = "<span class='discount color-red'>"& CLng((jorgPrice-jsellCash)/jorgPrice*100)&"%</span>"
											End If
										elseif jsaleyn = "N" And jcouponYn = "Y" And jcouponvalue>0 Then
											If jcoupontype = "1" Then
												totalsale2 = "<span class='discount color-green'>"& CStr(jcouponvalue) & "%</span>"
											End If
										Else 
											totalsale2 = ""
										End If
									End If 

							%>
							<li>
								<a href="<%=jitemURL%>" onclick=AmpEventCustomerRecommended(JSON.parse('<%= amplitudeTrendCart %>'));fnAmplitudeEventMultiPropertiesAction('click_mainforyou_shoppingbag','indexnumber|itemid|categoryname|brand_id','<%=jcnt+1%>|<%=arrList2(2,jcnt)%>|<%=jcategoryname%>|<%=jbrandid%>');>
									<div class="thumbnail"><img src="<%=jimgurl%>" alt="<%=jitemname%>"></div>
									<div class="desc">
										<p class="name"><%=jitemname%> <%=chkiif(CInt(datediff("d",Left(jregdt,10),Date()))<15,"<span class='label label-new'>NEW</span>","")%></p>
										<div class="price">
											<%=totalsale2%>
											<span class="sum"><%=totalprice2%></span>
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
			</div>
			<% End If %>
		</div>
	</div>
	<script>function AmpEventCustomerRecommended(jsonval){	AmplitudeEventSend('MainCustomerRecommended', jsonval, 'eventProperties');	}</script>
</div>
<%
End If 

on Error Goto 0
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
<!-- #include virtual="/lib/db/dbEVTclose.asp" -->
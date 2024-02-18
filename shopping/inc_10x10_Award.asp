<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual ="/lib/classes/enjoy/newawardcls.asp" -->
<!-- #include virtual="/lib/classes/shopping/category_main_SpecialCls.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/search/searchCls.asp" -->
<!-- #include virtual="/lib/util/makexmllib.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<script language="JavaScript" type="text/javascript" SRC="/lib/js/tenbytencommon.js"></script>

<%
Dim vDisp,cdm, atype , oAward , i , maketr , lp , channel, vSale, vRealPrice, vClass
dim oip
	vDisp = getNumeric(requestCheckVar(Request("disp"),3))
	atype = requestCheckVar(Request("atype"),1)
	channel = requestCheckVar(Request("channel"),1)

	'//logparam
	Dim logparam : logparam = "&pCtr="&vDisp

	if atype="" then atype="b"

	dim strAwardURL
	strAwardURL = "/chtml/main/html/main_award_" & vDisp & ".html"

'// 파일 동시생성시 오류 넘김
on Error resume Next
	'Application("chk_main_award_update" & vDisp)="2008-12-12 05:00:00"
'// 1시간에 한번 신규 HTML 생성!!(로드밸런싱 1차 서버에서만 생성)
if (application("Svr_Info")="137" or application("Svr_Info")="082" or application("Svr_Info")="Dev") and dateDiff("h",Application("chk_main_award_update" & vDisp),now())>0 then
'if true then	'### 필히 www1로 접속!!!
'If Request.ServerVariables("REMOTE_ADDR") = "61.252.133.75" Then

	'파일 생성 시간 저장
	Application("chk_main_award_update" & vDisp) = now()

	'파일설정
	dim fso,tFile, strBody, savePath, filename
	savePath = server.mappath("/chtml/main/html") & "\"


	if Not(vDisp = "" or isNull(vDisp)) Then
		''파일 Header
			strBody = ""

			set oAward = new CAWard
				oAward.FPageSize = 8
				oAward.FDisp1 = vDisp
				oAward.FRectAwardgubun = "b"
				oAward.GetNormalItemList

				if oAward.fresultcount > 0 then

					strBody=strBody & "<!DOCTYPE html>" & vbCrLf
					strBody=strBody & "<html lang=""ko"">" & vbCrLf
					strBody=strBody & "<head>" & vbCrLf
					strBody=strBody & "<body>" & vbCrLf
					strBody=strBody & "<meta charset=""utf-8"" />" & vbCrLf
					strBody=strBody & "<meta http-equiv=""X-UA-Compatible"" content=""IE=edge"" />" & vbCrLf
					strBody=strBody & "<meta name=""description"" content="""" />" & vbCrLf
					strBody=strBody & "<meta name=""keywords"" content=""커플, 선물, 커플선물, 감성디자인, 디자인, 아이디어상품, 디자인용품, 판촉, 스타일, 10x10, 텐바이텐, 큐브"" />" & vbCrLf
					strBody=strBody & "<meta name=""classification"" content=""비즈니스와 경제, 쇼핑과 서비스(B2C, C2C), 선물, 특별상품"" />" & vbCrLf
					strBody=strBody & "<meta name=""application-name"" content=""텐바이텐"" />" & vbCrLf
					strBody=strBody & "<meta name=""msapplication-task"" content=""name=텐바이텐;action-uri=http://www.10x10.co.kr/;icon-uri=/icons/10x10_140616.ico"" />" & vbCrLf
					strBody=strBody & "<meta name=""msapplication-tooltip"" content=""생활감성채널 텐바이텐"" />" & vbCrLf
					strBody=strBody & "<meta name=""msapplication-navbutton-color"" content=""#FFFFFF"" />" & vbCrLf
					strBody=strBody & "<meta name=""msapplication-TileImage"" content=""/lib/ico/mstileLogo144.png""/>" & vbCrLf
					strBody=strBody & "<meta name=""msapplication-TileColor"" content=""#c91314""/>" & vbCrLf
					strBody=strBody & "<meta name=""msapplication-starturl"" content=""/"" />" & vbCrLf
					strBody=strBody & "<link rel=""SHORTCUT ICON"" href=""http://fiximage.10x10.co.kr/icons/10x10_140616.ico"" />" & vbCrLf
					strBody=strBody & "<link rel=""apple-touch-icon"" href=""/lib/ico/10x10TouchIcon_150303.png"" />" & vbCrLf
					strBody=strBody & "<link rel=""search"" type=""application/opensearchdescription+xml"" href=""/lib/util/10x10_brws_search.xml"" title=""텐바이텐 상품검색"" />" & vbCrLf
					strBody=strBody & "<link rel=""alternate"" type=""application/rss+xml"" href=""/shoppingtoday/shoppingchance_rss.xml"" title=""텐바이텐 신상품소식 구독"" />" & vbCrLf
					strBody=strBody & "<link rel=""alternate"" type=""application/rss+xml"" href=""/just1day/just1day_rss.xml"" title=""텐바이텐 Just 1Day 구독"" />" & vbCrLf
					strBody=strBody & "<link rel=""alternate"" type=""application/rss+xml"" href=""http://www.thefingers.co.kr/lecture/lecture_rss.xml"" title=""더핑거스 새로운 강좌 구독"" />" & vbCrLf
					strBody=strBody & "<title>10x10</title>" & vbCrLf
					strBody=strBody & "<link rel=""stylesheet"" type=""text/css"" href=""/lib/css/default.css"" />" & vbCrLf
					strBody=strBody & "<link rel=""stylesheet"" type=""text/css"" href=""/lib/css/preVst/common.css"" />" & vbCrLf
					strBody=strBody & "<link rel=""stylesheet"" type=""text/css"" href=""/lib/css/preVst/content.css"" />" & vbCrLf
					strBody=strBody & "<link rel=""stylesheet"" type=""text/css"" href=""/lib/css/preVst/mytenten.css"" />" & vbCrLf
					strBody=strBody & "<!--[if IE]>" & vbCrLf
					strBody=strBody & "	<link rel=""stylesheet"" type=""text/css"" href=""/lib/css/preVst/ie.css"" />" & vbCrLf
					strBody=strBody & "<![endif]-->" & vbCrLf
					strBody=strBody & "<link rel=""stylesheet"" type=""text/css"" href=""/lib/css/commonV15.css"" />" & vbCrLf
					strBody=strBody & "<link rel=""stylesheet"" type=""text/css"" href=""/lib/css/productV15.css"" />" & vbCrLf
					strBody=strBody & "<link rel=""stylesheet"" type=""text/css"" href=""/lib/css/contentV15.css"" />" & vbCrLf
					strBody=strBody & "<link rel=""stylesheet"" type=""text/css"" href=""/lib/css/mytentenV15.css"" />" & vbCrLf
					strBody=strBody & "<!--[if lt IE 9]>" & vbCrLf
					strBody=strBody & "<script src=""/lib/js/respond.min.js""></script>" & vbCrLf
					strBody=strBody & "<![endif]-->" & vbCrLf
					strBody=strBody & "<script type=""text/javascript"" src=""/lib/js/jquery-1.7.1.min.js""></script>" & vbCrLf
					strBody=strBody & "<script type=""text/javascript"" src=""/lib/js/jquery-ui-1.10.3.custom.min.js""></script>" & vbCrLf
					strBody=strBody & "<script type=""text/javascript"" src=""/lib/js/jquery.slides.min.js""></script>" & vbCrLf
					strBody=strBody & "<script type=""text/javascript"" src=""/lib/js/swiper-2.1.min.js""></script>" & vbCrLf
					strBody=strBody & "<script type=""text/javascript"" src=""/lib/js/common.js""></script>" & vbCrLf
					strBody=strBody & "<script type=""text/javascript"" src=""/lib/js/tenbytencommon.js?v=1.0""></script>" & vbCrLf
					strBody=strBody & "<script type=""text/javascript"">" & vbCrLf
					strBody=strBody & "function bestTab(flag){" & vbCrLf
					strBody=strBody & "	if (flag == ""awrardTab"") {" & vbCrLf
					strBody=strBody & "		document.getElementById(""ctgyAward"").style.display =""block"";" & vbCrLf
					strBody=strBody & "		document.getElementById(""ctgyWish"").style.display =""none"";" & vbCrLf
					strBody=strBody & "		document.getElementById(""ctgyReview"").style.display =""none"";" & vbCrLf
					strBody=strBody & "		document.getElementById(""ctgyBrand"").style.display =""none"";" & vbCrLf
					strBody=strBody & "		document.getElementById(""ctgySale"").style.display =""none"";" & vbCrLf
					strBody=strBody & "	} else if (flag == ""wishTab""){" & vbCrLf
					strBody=strBody & "		document.getElementById(""ctgyAward"").style.display =""none"";" & vbCrLf
					strBody=strBody & "		document.getElementById(""ctgyWish"").style.display =""block"";" & vbCrLf
					strBody=strBody & "		document.getElementById(""ctgyReview"").style.display =""none"";" & vbCrLf
					strBody=strBody & "		document.getElementById(""ctgyBrand"").style.display =""none"";" & vbCrLf
					strBody=strBody & "		document.getElementById(""ctgySale"").style.display =""none"";" & vbCrLf
					strBody=strBody & "	} else if (flag == ""reviewTab""){" & vbCrLf
					strBody=strBody & "		document.getElementById(""ctgyAward"").style.display =""none"";" & vbCrLf
					strBody=strBody & "		document.getElementById(""ctgyWish"").style.display =""none"";" & vbCrLf
					strBody=strBody & "		document.getElementById(""ctgyReview"").style.display =""block"";" & vbCrLf
					strBody=strBody & "		document.getElementById(""ctgyBrand"").style.display =""none"";" & vbCrLf
					strBody=strBody & "		document.getElementById(""ctgySale"").style.display =""none"";" & vbCrLf
					strBody=strBody & "	} else if (flag == ""brandTab""){" & vbCrLf
					strBody=strBody & "		document.getElementById(""ctgyAward"").style.display =""none"";" & vbCrLf
					strBody=strBody & "		document.getElementById(""ctgyWish"").style.display =""none"";" & vbCrLf
					strBody=strBody & "		document.getElementById(""ctgyReview"").style.display =""none"";" & vbCrLf
					strBody=strBody & "		document.getElementById(""ctgyBrand"").style.display =""block"";" & vbCrLf
					strBody=strBody & "		document.getElementById(""ctgySale"").style.display =""none"";" & vbCrLf
					strBody=strBody & "	} else if (flag == ""saleTab""){" & vbCrLf
					strBody=strBody & "		document.getElementById(""ctgyAward"").style.display =""none"";" & vbCrLf
					strBody=strBody & "		document.getElementById(""ctgyWish"").style.display =""none"";" & vbCrLf
					strBody=strBody & "		document.getElementById(""ctgyReview"").style.display =""none"";" & vbCrLf
					strBody=strBody & "		document.getElementById(""ctgyBrand"").style.display =""none"";" & vbCrLf
					strBody=strBody & "		document.getElementById(""ctgySale"").style.display =""block"";" & vbCrLf
					strBody=strBody & "	}" & vbCrLf
					strBody=strBody & "}" & vbCrLf
					strBody=strBody & "$(function() {" & vbCrLf
					strBody=strBody & "	$("".awardNavV15 ul li"").click(function(){" & vbCrLf
					strBody=strBody & "		$("".awardNavV15 ul li"").removeClass(""current"");" & vbCrLf
					strBody=strBody & "		$(this).addClass(""current"");" & vbCrLf
					strBody=strBody & "	});" & vbCrLf
					strBody=strBody & "});" & vbCrLf
					strBody=strBody & "</script>" & vbCrLf
					strBody=strBody & "</head>" & vbCrLf
					strBody=strBody & "<body>" & vbCrLf
					strBody=strBody & "<div class=""ctgyWrapV15"">" & vbCrLf
					strBody=strBody & "	<h3><img src=""http://fiximage.10x10.co.kr/web2015/shopping/contit_bestaward.gif"" alt=""BEST AWARD"" /></h3>" & vbCrLf
					strBody=strBody & "	<div class=""awardNavV15"">" & vbCrLf
					strBody=strBody & "		<ul>" & vbCrLf
					strBody=strBody & "			<li class=""ctgyAwardV15"" onclick=""javascript:bestTab('awrardTab'); return false;""><span>BEST AWARD</span></li>" & vbCrLf
					strBody=strBody & "			<li class=""ctgyWishV15 current"" onclick=""javascript:bestTab('wishTab'); return false;""><span>BEST WISH</span></li>" & vbCrLf
					strBody=strBody & "			<li class=""ctgyReviewV15"" onclick=""javascript:bestTab('reviewTab'); return false;""><span>BEST REVIEW</span></li>" & vbCrLf
					strBody=strBody & "			<li class=""ctgyBrandV15"" onclick=""javascript:bestTab('brandTab'); return false;""><span>BEST BRAND</span></li>" & vbCrLf
					strBody=strBody & "			<li class=""ctgySaleV15"" onclick=""javascript:bestTab('saleTab'); return false;""><span>BEST SALE</span></li>" & vbCrLf
					strBody=strBody & "		</ul>" & vbCrLf
					strBody=strBody & "	</div>" & vbCrLf
					strBody=strBody & "	<div class=""awardContV15"">" & vbCrLf
					strBody=strBody & "		<div class=""ctgyList ctgyAwardListV15"" id=""ctgyAward"">" & vbCrLf
					strBody=strBody & "			<a href=""/award/awardlist.asp?atype=b&disp="&vDisp&""" class=""moreV15"" target=""_parent"">more &gt;</a>" & vbCrLf
					strBody=strBody & "			<ul>" & vbCrLf

					for i = 0 to oAward.fresultcount -1

						vRealPrice = fnRealPrice(oAward.FItemList(i).FOrgPrice,oAward.FItemList(i).FSellCash,oAward.FItemList(i).FSaleYN,oAward.FItemList(i).FItemCouponYN,oAward.FItemList(i).FItemCouponValue,oAward.FItemList(i).FItemCouponType)
						vSale = Round(100-(100*(vRealPrice/oAward.FItemList(i).FOrgPrice)))
						If oAward.FItemList(i).FSaleYN = "Y" AND oAward.FItemList(i).FItemCouponYN = "Y" Then
							vClass = "cGr0V15"
						Else
							IF oAward.FItemList(i).FSaleYN = "Y" Then
								vClass = "cRd0V15"
							End IF
							IF oAward.FItemList(i).FItemCouponYN = "Y" Then
								vClass = "cGr0V15"
							End IF
						End If

						strBody=strBody & "			<li class=""best0"&i+1&""">" & vbCrLf
						strBody=strBody & "				<div>" & vbCrLf
						strBody=strBody & "					<a href=""/shopping/category_prd.asp?itemid=" & oAward.FItemList(i).Fitemid & logparam & """ target=""_parent"">" & vbCrLf
						strBody=strBody & "					<p class=""pdtPhoto""><img src=""" & oAward.FItemList(i).Ficon1image & """ alt=""" & oAward.FItemList(i).FItemName & """ /></p>" & vbCrLf
						strBody=strBody & "					<p class=""pdtName tPad10 tMar03"">" & oAward.FItemList(i).FItemName & "</p>" & vbCrLf
						strBody=strBody & "					<p class=""pdtPrice""><strong>" & FormatNumber(vRealPrice,0) & "원"

						If vSale > 0 Then
							strBody = strBody & " <span class=""" & vClass & """>[" & vSale & "%]</span>"
						End IF

						strBody = strBody & "</strong></p>" & vbCrLf
						strBody = strBody & "				</a>" & vbCrLf
						strBody = strBody & "			</div>" & vbCrLf
						strBody = strBody & "		</li>" & vbCrLf
					next

					strBody=strBody & "			</ul>" & vbCrLf
					strBody=strBody & "		</div>" & vbCrLf

				End If

				'####### 베스트 위시 (02)
				oAward.FPageSize = 8
				oAward.FDisp1 = vDisp
				oAward.FRectAwardgubun = "f"
				oAward.GetNormalItemList

				if oAward.fresultcount > 0 then

					strBody=strBody & "		<div class=""ctgyList ctgyWishListV15"" id=""ctgyWish"">" & vbCrLf
					strBody=strBody & "			<a href=""/award/awardlist.asp?atype=f&disp="&vDisp&""" class=""moreV15"" target=""_parent"">more &gt;</a>" & vbCrLf
					strBody=strBody & "			<ul>" & vbCrLf

					for i = 0 to oAward.fresultcount -1

						vRealPrice = fnRealPrice(oAward.FItemList(i).FOrgPrice,oAward.FItemList(i).FSellCash,oAward.FItemList(i).FSaleYN,oAward.FItemList(i).FItemCouponYN,oAward.FItemList(i).FItemCouponValue,oAward.FItemList(i).FItemCouponType)
						vSale = Round(100-(100*(vRealPrice/oAward.FItemList(i).FOrgPrice)))
						If oAward.FItemList(i).FSaleYN = "Y" AND oAward.FItemList(i).FItemCouponYN = "Y" Then
							vClass = "cGr0V15"
						Else
							IF oAward.FItemList(i).FSaleYN = "Y" Then
								vClass = "cRd0V15"
							End IF
							IF oAward.FItemList(i).FItemCouponYN = "Y" Then
								vClass = "cGr0V15"
							End IF
						End If

						strBody=strBody & "			<li class=""best0"&i+1&""">" & vbCrLf
						strBody=strBody & "				<div>" & vbCrLf
						strBody=strBody & "					<a href=""/shopping/category_prd.asp?itemid=" & oAward.FItemList(i).Fitemid & logparam & """ target=""_parent"">" & vbCrLf
						strBody=strBody & "					<p class=""pdtPhoto""><img src=""" & oAward.FItemList(i).Ficon1image & """ alt=""" & oAward.FItemList(i).FItemName & """ /></p>" & vbCrLf
						strBody=strBody & "					<p class=""pdtName tPad10 tMar03"">" & oAward.FItemList(i).FItemName & "</p>" & vbCrLf
						strBody=strBody & "					<p class=""pdtPrice""><strong>" & FormatNumber(vRealPrice,0) & "원"

						If vSale > 0 Then
							strBody = strBody & " <span class=""" & vClass & """>[" & vSale & "%]</span>"
						End IF

						strBody = strBody & "</strong></p>" & vbCrLf
						strBody=strBody & "					</a>" & vbCrLf
						strBody=strBody & "				</div>" & vbCrLf
						strBody=strBody & "			</li>" & vbCrLf

					next

					strBody=strBody & "			</ul>" & vbCrLf
					strBody=strBody & "		</div>" & vbCrLf

				End If
			set oAward = nothing


			'####### 베스트 리뷰 (03)
			set oAward = new CSpecial
				oAward.FCurrpage = 1
				oAward.FScrollCount = 10
				oAward.FRectSort = "pnt"
				oAward.FRectCateCode = vDisp
				oAward.FPageSize = 4
				oAward.FRectMode = "item"
				oAward.FRegdateS = Left(dateAdd("d",-14,now()),10) ''Left(dateAdd("m",-1,now()),10) ''14일로 수정 eastone 2015/04/12
				oAward.FRegdateE = Left(dateAdd("d",+1,now()),10)
				oAward.GetBestReviewAllList

				strBody=strBody & "		<div class=""ctgyList ctgyReviewListV15"" id=""ctgyReview"">" & vbCrLf
				strBody=strBody & "			<a href=""/bestreview/bestreview_main.asp?disp="&vDisp&""" class=""moreV15"" target=""_parent"">more &gt;</a>" & vbCrLf

				if oAward.fresultcount > 0 then

					strBody=strBody & "			<ul>" & vbCrLf

					for i = 0 to oAward.fresultcount -1

						vRealPrice = fnRealPrice(oAward.FItemList(i).FOrgPrice,oAward.FItemList(i).FSellCash,oAward.FItemList(i).FSaleYN,oAward.FItemList(i).FItemCouponYN,oAward.FItemList(i).FItemCouponValue,oAward.FItemList(i).FItemCouponType)
						vSale = Round(100-(100*(vRealPrice/oAward.FItemList(i).FOrgPrice)))
						If oAward.FItemList(i).FSaleYN = "Y" AND oAward.FItemList(i).FItemCouponYN = "Y" Then
							vClass = "cGr0V15"
						Else
							IF oAward.FItemList(i).FSaleYN = "Y" Then
								vClass = "cRd0V15"
							End IF
							IF oAward.FItemList(i).FItemCouponYN = "Y" Then
								vClass = "cGr0V15"
							End IF
						End If

						strBody=strBody & "				<li class=""best0"&i+1&""">" & vbCrLf
						strBody=strBody & "					<div class=""awardReviewV15"">" & vbCrLf
						strBody=strBody & "						<a href=""/shopping/category_prd.asp?itemid=" & oAward.FItemList(i).Fitemid & logparam & """ target=""_parent"">" & vbCrLf
						strBody=strBody & "						<p class=""pdtPhoto""><img src=""" & oAward.FItemList(i).Ficon1image & """ alt=""" & oAward.FItemList(i).FItemName & """ /></p>" & vbCrLf
						strBody=strBody & "						<p class=""pdtName tPad10 tMar03"">" & oAward.FItemList(i).FItemName & "</p>" & vbCrLf
						strBody=strBody & "						<p class=""pdtPrice""><strong>" & FormatNumber(vRealPrice,0) & "원"

						If vSale > 0 Then
							strBody = strBody & " <span class=""" & vClass & """>[" & vSale & "%]</span>"
						End IF

						strBody = strBody & "</strong></p>" & vbCrLf
						strBody = strBody & "					</a>" & vbCrLf
						strBody = strBody & "					<div class=""reviewBoxV15"">" & vbCrLf
						strBody=strBody & "							<p class=""starView""><img src=""//fiximage.10x10.co.kr/web2019/common/ico_review_star_0" & oAward.FItemList(i).FPoints & ".png"" alt=""별" & oAward.FItemList(i).FPoints & "개"" /></p>" & vbCrLf
						strBody=strBody & "							<div class=""tPad10 lt"">" & chrbyte(oAward.FItemList(i).Fcontents,90,"Y") & "</div>" & vbCrLf
						strBody=strBody & "							<a href=""/bestreview/bestreview_main.asp?disp="&vDisp&""" class=""more1V15"" target=""_parent"">리뷰 더보기</a>" & vbCrLf
						strBody=strBody & "						</div>" & vbCrLf
						strBody=strBody & "					</div>" & vbCrLf
						strBody=strBody & "				</li>" & vbCrLf

					next


					strBody=strBody & "			</ul>" & vbCrLf
				End If

				strBody=strBody & "		</div>" & vbCrLf

			set oAward = nothing


			'####### 베스트 브랜드 (04)
			set oAward = new CAWard
				oAward.FPageSize = 8
				oAward.FDisp1 = vDisp
				oAward.FRectAwardgubun = "b"
				oAward.GetBrandAwardList

				if oAward.fresultcount > 0 then

					strBody=strBody & "		<div class=""ctgyList ctgyBrandListV15"" id=""ctgyBrand"">" & vbCrLf
					strBody=strBody & "			<a href=""/award/awardbrandlist.asp?atype=b&disp="&vDisp&""" class=""moreV15"" target=""_parent"">more &gt;</a>" & vbCrLf
					strBody=strBody & "			<ul>" & vbCrLf

					for i = 0 to oAward.fresultcount -1


						strBody=strBody & "				<li class=""best0"&i+1&""">" & vbCrLf
						strBody=strBody & "					<div>" & vbCrLf
						strBody=strBody & "						<a href=""/street/street_brand.asp?makerid=" & oAward.FItemList(i).FMakerid & """ target=""_parent"">" & vbCrLf
						strBody=strBody & "						<p class=""pdtPhoto""><img src=""" & getThumbImgFromURL(oaward.FItemList(i).Ficon1image,150,150,"true","false") & """ alt=""" & Replace(oAward.FItemList(i).FSocname,"""","") & """ /></p>" & vbCrLf
						strBody=strBody & "						<p class=""tPad10 tMar03""><strong>" & oAward.FItemList(i).FSocname & "</strong></p>" & vbCrLf
						strBody=strBody & "						<p>" & oAward.FItemList(i).FSocname_Kor & "</p>" & vbCrLf
						strBody=strBody & "						</a>" & vbCrLf
						strBody=strBody & "					</div>" & vbCrLf
						strBody=strBody & "				</li>" & vbCrLf

					next

					strBody=strBody & "			</ul>" & vbCrLf
					strBody=strBody & "		</div>" & vbCrLf

				End If

			set oAward = nothing


			'####### 베스트 세일 (05)
			set oAward = new SearchItemCls
				oAward.FListDiv 		= "salelist"
				oAward.FRectSearchFlag 	= "sale"
				oAward.FPageSize 		= 8
				oAward.FRectCateCode	= vDisp
				oAward.FCurrPage 		= 1
				oAward.FSellScope 		= "Y"
				oAward.FScrollCount 	= 1
				oAward.getSearchList

				if oAward.fresultcount > 0 then

					strBody=strBody & "		<div class=""ctgyList ctgySaleListV15"" id=""ctgySale"">" & vbCrLf
					strBody=strBody & "			<a href=""/shoppingtoday/shoppingchance_saleitem.asp?disp="&vDisp&"&sP=&flo="" class=""moreV15"" target=""_parent"">more &gt;</a>" & vbCrLf
					strBody=strBody & "			<ul>" & vbCrLf

					for i = 0 to oAward.fresultcount -1

						vRealPrice = fnRealPrice(oAward.FItemList(i).FOrgPrice,oAward.FItemList(i).FSellCash,oAward.FItemList(i).FSaleYN,oAward.FItemList(i).FItemCouponYN,oAward.FItemList(i).FItemCouponValue,oAward.FItemList(i).FItemCouponType)
						vSale = Round(100-(100*(vRealPrice/oAward.FItemList(i).FOrgPrice)))
						If oAward.FItemList(i).FSaleYN = "Y" AND oAward.FItemList(i).FItemCouponYN = "Y" Then
							vClass = "cGr0V15"
						Else
							IF oAward.FItemList(i).FSaleYN = "Y" Then
								vClass = "cRd0V15"
							End IF
							IF oAward.FItemList(i).FItemCouponYN = "Y" Then
								vClass = "cGr0V15"
							End IF
						End If

						strBody=strBody & "			<li class=""best0"&i+1&""">" & vbCrLf
						strBody=strBody & "				<div>" & vbCrLf
						strBody=strBody & "					<a href=""/shopping/category_prd.asp?itemid=" & oAward.FItemList(i).Fitemid & logparam & """ target=""_parent"">" & vbCrLf
						strBody=strBody & "					<p class=""pdtPhoto""><img src=""" & oAward.FItemList(i).FImageIcon1 & """ alt=""" & oAward.FItemList(i).FItemName & """ /></p>" & vbCrLf
						strBody=strBody & "					<p class=""pdtName tPad10 tMar03"">" & oAward.FItemList(i).FItemName & "</p>" & vbCrLf
						strBody=strBody & "					<p class=""pdtPrice""><strong>" & FormatNumber(vRealPrice,0) & "원"

						If vSale > 0 Then
							strBody = strBody & " <span class=""" & vClass & """>[" & vSale & "%]</span>"
						End IF

						strBody = strBody & "</strong></p>" & vbCrLf
						strBody=strBody & "					</a>" & vbCrLf
						strBody=strBody & "				</div>" & vbCrLf
						strBody=strBody & "			</li>" & vbCrLf
					next

					strBody=strBody & "			</ul>" & vbCrLf
					strBody=strBody & "		</div>" & vbCrLf

				End If

			set oAward = nothing
	end if

	strBody=strBody & "	</div>" & vbCrLf
	strBody=strBody & "</div>" & vbCrLf
	strBody=strBody & "<script type='text/javascript'>bestTab('wishTab');</script>" & vbCrLf
	strBody=strBody & "</body>" & vbCrLf
	strBody=strBody & "</html>" & vbCrLf


	Set fso = Server.CreateObject("ADODB.Stream")
	fso.Type = 2
	fso.Charset = "utf-8"
	fso.Open
	fso.WriteText (strBody)
	fso.SaveToFile server.mappath("/chtml/main/html/") & "\"&"main_award_" & vDisp & ".html", 2
	Set fso = nothing


	if (vDisp = "101") then
		'// 디자인문구 카테고리 파일 생성시 메인 페이지 XML 생성

		'// 베스트 위시
		Call MakeXmlFile("mainPopularWish")

		'// 베스트 상품
		Call MakeXmlFile("mainBestAward")
	end if

end if

'// 어워드 페이지 출력
	Server.Execute(strAwardURL)
on Error goto 0



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


'vSale = getSalePercent(rsget("orgprice"),rsget("sellcash"),rsget("sailyn"),rsget("itemcouponyn"),rsget("itemcouponvalue"),rsget("itemcoupontype"))
'// 상품/쿠폰 할인율
Function getSalePercent(org,sell,sailyn,couponyn,cvalue,ctype)
	dim sSprc, sPer
	sSprc=0 : sPer=0

	if org>0 then
		if sailyn="Y" then sSprc = sSprc + org-sell
		if couponyn="Y" then sSprc = sSprc + org-GetCouponAssignPrice(sell,couponyn,cvalue,ctype)
		sPer = CLng(sSprc/org*100)
	end if

	getSalePercent = sPer
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
<!-- #include virtual="/lib/db/dbclose.asp" -->
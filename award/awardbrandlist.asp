<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
	strPageTitle = "텐바이텐 10X10 : BEST AWARD - 베스트 브랜드"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual ="/lib/classes/enjoy/newawardcls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
'#######################################################
'	History	:  2009.03.30 강준구 생성
'              2009.08.12 허진원 브랜드 상품수 부족에 따른 표시방법 수정 / 상품이미지가 없을때 처리
'              2013.09.26 허진원 2013 리뉴얼
'              2015.03.25 유태욱 2015 리뉴얼
'	Description : 상품 어워드 리스트
'#######################################################

	dim atype, catecode
	catecode = RequestCheckVar(request("disp"),3)
	atype = RequestCheckVar(request("atype"),1)
	if atype="" then atype="b"

	dim oaward
	set oaward = new CAWard
	oaward.FPageSize = 100
	oaward.FDisp1 = catecode
	oaward.FRectAwardgubun = atype
	oaward.GetBrandAwardList

	'변수 선언
	dim i
	dim Cols : Cols = 5
%>
<script type="text/javascript" src="/lib/js/jquery.numspinner.min.js"></script>
<script>
$(function() {
	//급상승 상품 mark control
	$(".bestUpV15 .ranking").append("<span>급상승한 상품입니다</span>");
});

</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container skinV19">
		<div id="contentWrap" class="bestAwdV17">
			<div class="hotHgroupV19">
				<div class="tab-area">
					<ul>
						<li class="on"><a href="#">베스트 셀러</a></li>
						<li><a href="/bestreview/bestreview_main.asp?disp=<%=catecode%>">베스트 리뷰</a></li>
					</ul>
				</div>
				<h2>BEST SELLER</h2>
				<div class="grpSubWrapV19">
					<ul>
						<li><a href="/award/awardlist.asp?atype=b&disp=<%=catecode%>">베스트셀러</a></li>
						<li><a href="/award/awardlist.asp?atype=g&disp=<%=catecode%>">고객만족 베스트</a></li>
						<li><a href="/award/awardlist.asp?atype=f&disp=<%=catecode%>">베스트 위시</a></li>
						<li><a href="/award/bestaward_new.asp?disp=<%=catecode%>">신상품 베스트</a></li>
						<li><a href="/award/bestaward_price.asp?disp=<%=catecode%>">가격대별 베스트</a></li>
						<li><a href="/award/bestaward_colorpalette.asp?disp=<%=catecode%>">베스트 컬러</a></li>
						<li class="on"><a href="/award/awardbrandlist.asp?disp=<%=catecode%>">베스트 브랜드</a></li>
					</ul>
				</div>
			</div>
			<div class="snb-bar">
				<div class="snbbar-inner">
					<div class="btn-ctgr"><span><%=fnSelectCategoryName(catecode)%></span></div>
				</div>
				<div class="lnbHotV19">
					<div class="inner">
						<ul>
							<li class="<%= chkIIF(catecode="","on","") %>"><a href="?atype=<%=atype%>">전체 카테고리</a></li>
							<%=fnAwardBestCategoryLI(catecode,"/award/awardbrandlist.asp?atype="&atype&"&")%>
						</ul>
					</div>
				</div>
			</div>
			<div class="hotSectionV15">
				<div class="hotArticleV15">
				<%	If oaward.FResultCount <= 0 Then %>
					<div class="noData" style="text-align:center;padding:80px 0;">
						<p><strong>해당 베스트 브랜드가 없습니다.</strong></p>
					</div>
				<% else %>
					<%	If oaward.FResultCount > 0 Then %>
					<div class="ctgyBestV15">
						<ul class="bestBrdListV15">
						<%
							dim isMyFavBrand
							for i=0 to oaward.FResultCount-1

							isMyFavBrand=false
							if IsUserLoginOK then
								isMyFavBrand = getIsMyFavBrand(getLoginUserid(),oaward.FItemList(i).FMakerID)
							end if
						%>
							<li <% If oaward.FItemList(i).FNewFlg = "Y" Then response.write "class='bestUpV15'" %>>
								<p class="ranking">BEST <%=i+1%></p>
								<dl class="brdBoxV15">
									<dt>
										<a href="/street/street_brand.asp?makerid=<%=oaward.FItemList(i).FMakerid%>">
											<p class="eng"><%=oaward.FItemList(i).FSocname%></p>
											<p class="kor"><%=oaward.FItemList(i).FSocname_Kor%></p>
										</a>
									</dt>
									<dd>
										<a href="/street/street_brand.asp?makerid=<%=oaward.FItemList(i).FMakerid%>">
											<p class="desc"><%=chrbyte(stripHTML(chkIIF(Not(oaward.FItemList(i).FstoryContent="" or isNull(oaward.FItemList(i).FstoryContent)),oaward.FItemList(i).FstoryContent,oaward.FItemList(i).FDGNComment)),40,"Y")%></p>
											<div class="pic"><img src="<%= oaward.FItemList(i).FBrandImage %>" onerror="this.src = 'https://fiximage.10x10.co.kr/m/2020/common/no_img.svg'" alt="<%=Replace(oaward.FItemList(i).FSocname,"""","")%>" /></div>
										</a>
									</dd>
									<dd class="addMyBrdV15">
										<span id="zzimBr_<%= oaward.FItemList(i).FMakerID %>" class="<%=chkIIF(isMyFavBrand,"zzimBrOn","zzimBrOff")%>" onclick="TnMyBrandJJim('<%= oaward.FItemList(i).FMakerID %>', '<%= oaward.FItemList(i).FSocname %>');">찜브랜드 등록하기</span>
									</dd>
								</dl>
							</li>
						<%
								if i>=2 then Exit For		'3위까지 출력
							next
						%>
						</ul>
					</div>
				<%
					end if

					If oaward.FResultCount > 3 Then
				%>
					<ul class="bestBrdListV15">
						<%
							for i=3 to oaward.FResultCount-1

							isMyFavBrand=false
							if IsUserLoginOK then
								isMyFavBrand = getIsMyFavBrand(getLoginUserid(),oaward.FItemList(i).FMakerID)
							end if
						%>
						<li <% If oaward.FItemList(i).FNewFlg = "Y" then response.write "class='bestUpV15'" %>>
							<p class="ranking"><%=i+1%>.</p>
							<dl class="brdBoxV15">
								<dt>
									<a href="/street/street_brand.asp?makerid=<%=oaward.FItemList(i).FMakerid%>">
										<p class="eng"><%=oaward.FItemList(i).FSocname%></p>
										<p class="kor"><%=oaward.FItemList(i).FSocname_Kor%></p>
									</a>
								</dt>
								<dd>
									<a href="/street/street_brand.asp?makerid=<%=oaward.FItemList(i).FMakerid%>">
										<p class="desc"><%=chrbyte(stripHTML(chkIIF(Not(oaward.FItemList(i).FstoryContent="" or isNull(oaward.FItemList(i).FstoryContent)),oaward.FItemList(i).FstoryContent,oaward.FItemList(i).FDGNComment)),40,"Y")%></p>
										<div class="pic"><img src="<%=getThumbImgFromURL(oaward.FItemList(i).FImageBasic,240,240,"true","false")%>" alt="<%=Replace(oaward.FItemList(i).FSocname,"""","")%>" /></div>
									</a>
								</dd>
								<dd class="addMyBrdV15">
									<span id="zzimBr_<%= oaward.FItemList(i).FMakerID %>" class="<%=chkIIF(isMyFavBrand,"zzimBrOn","zzimBrOff")%>" onclick="TnMyBrandJJim('<%= oaward.FItemList(i).FMakerID %>', '<%= oaward.FItemList(i).FSocname %>');">찜브랜드 등록하기</span>
								</dd>
							</dl>
						</li>
						<%	next %>
					</ul>
				<%	end if %>
				</div>
			<% end if %>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<% set oaward = Nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->
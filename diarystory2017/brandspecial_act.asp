<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 다이어리 스토리2017 브랜드 스페셜
' History : 2015.10.13 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/diarystory2017/lib/classes/specialbrandCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->

<%
', SortMet  , userid , GiftSu , vParaMeter, PrdBrandList, research, isusing, 
Dim i , imglink, PageSize , CurrPage

'PageSize	= requestcheckvar(request("page"),2)
CurrPage 	= requestCheckVar(request("cpg"),9)
'SortMet 	= requestCheckVar(request("srm"),9)
'userid		= getEncLoginUserID

PageSize = 4
if CurrPage="" or CurrPage="0" then CurrPage=1

''스페셜 브랜드 테스트
dim oSpecialBrand
set oSpecialBrand = new DiaryCls
	oSpecialBrand.FPageSize = PageSize
	oSpecialBrand.FCurrPage = CurrPage
	oSpecialBrand.fcontents_list
	
%>
	<div class="brandList">
		<ul>
		<% if oSpecialBrand.FResultCount > 0 then %>
			<% for i=0 to oSpecialBrand.FResultCount - 1 %>
			<%'' for dev msg : 내용이 왼쪽으로 들어갈 경우 클래스 type2 붙여주세요(어드민에서 선택) %>
			<li <% if oSpecialBrand.FItemList(i).fleftright ="L" then %>class="type2" <% end if %>style="background-image:url(<%=staticImgUrl%>/diary/specialbrand/<%= oSpecialBrand.FItemList(i).fmainbrandimg %>);"><%' 배경이미지1146*565 (어드민등록 ) %>
				<div class="brandWrap">
					<div class="brandCont">
						<p class="txt"><img src="<%=staticImgUrl%>/diary/specialbrand/<%= oSpecialBrand.FItemList(i).fpcmainbrandtextimg %>" alt="<%= oSpecialBrand.FItemList(i).Fbrandid %>" />
						<div class="diaryList">
							<ul>
							<%
							dim itemarr, imgarr, itemcnt, j, itembasicimg, itembasicid
							if isarray(split(oSpecialBrand.FItemList(i).fitemimgid,",")) then
								itemarr = split(oSpecialBrand.FItemList(i).fitemimgid,",")
								'imgarr = split(itemarr,"/!/")
								itemcnt = UBound(itemarr)+1
								for j = 0 to itemcnt-1
									itembasicimg	= split(itemarr(j),"/!/")(0)
									itembasicid	= split(itemarr(j),"/!/")(1)
							'		response.write itembasicimg &"........"&itembasicid&"<Br>"
							'		response.write itemarr(j) & "....."
							%>
								<% IF application("Svr_Info") = "Dev" THEN %>
									<li><a href="/shopping/category_prd.asp?itemid=<%= itembasicid %>"><img src="http://testwebimage.10x10.co.kr/image/tenten200/<%= GetImageSubFolderByItemid(trim(itembasicid)) %>/<%= trim(itembasicimg) %>"></a></li>
								<% else %>
									<li><a href="/shopping/category_prd.asp?itemid=<%= itembasicid %>"><img src="http://webimage.10x10.co.kr/image/tenten200/<%= GetImageSubFolderByItemid(trim(itembasicid)) %>/<%= trim(itembasicimg) %>"></a></li>
								<% end if %>
							<%
								next
							end if
							%>
							</ul>
						</div>
						<a href="/street/street_brand_sub06.asp?makerid=<%= oSpecialBrand.FItemList(i).Fbrandid %>" class="goBrand"><span>브랜드 전체 상품 보기</span>&gt;</a>
					</div>
					<% if oSpecialBrand.FItemList(i).fbrandmovieurl <> "" then %>
						<a href="#lyrVideo" class="goPlay" onclick="jsvideo('<%=oSpecialBrand.FItemList(i).fbrandmovieurl%>','<%=getbrandname(oSpecialBrand.FItemList(i).Fbrandid)%>');return false;"><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/btn_play.png" alt="브랜드 동영상 보기" /></a>
						<!--<a href="#lyrVideo" class="goPlay" onclick="viewPoupLayer('modal',$('#lyrVideo').html());return false;"><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/btn_play.png" alt="브랜드 동영상 보기" /></a>-->
					<% end if %>
				</div>
			</li>
			<% next %>
		<% end if %>
		</ul>
	</div>
<%
SET oSpecialBrand = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
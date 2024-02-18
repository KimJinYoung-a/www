<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "utf-8" %>
<!-- #include virtual="/lib/db/dbAppWishopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #INCLUDE Virtual="/lib/classes/wish/wishCls2nd.asp" -->
<%
'#######################################################
'	Description : 상품의 wish Collection
'	History	: 2014.01.29 허진원 생성
'			: 2014.09.17 허진원 2014 하반기 리뉴얼
'			: 2015.04.01 허진원 2015 PC 리뉴얼
'#######################################################
	dim oWishCol, tmpUid, itemid, i, chkcnt, chkPgCnt

	itemid = getNumeric(requestCheckVar(request("itemid"),9))
	if itemid="" then Response.End
	chkcnt = 0: chkPgCnt=1

	set oWishCol = new CWish
	if IsUserLoginOK then oWishCol.FRectUserID = GetLoginUserID
	oWishCol.FPageSize=6
	oWishCol.FRectLimitCnt=5	'표시 제한 (최소 5개 이상 보유 회원만 표시)
	oWishCol.getWishCollectFromItem()

	if oWishCol.FResultCount>0 then
		'초기 아이디 확인
		tmpUid = oWishCol.FItemList(0).Fuserid
%>
<div class="section wishCollectionV15">
	<div class="title">
		<h3><img src="http://fiximage.10x10.co.kr/web2015/shopping/tit_wish_collection.gif" alt="WISH COLLECTION" /></h3>
		<p class="tPad15"><img src="http://fiximage.10x10.co.kr/web2015/shopping/txt_customer_wish.gif" alt="이 상품을 위시한 다른 고객들의 위시" /></p>
	</div>
	<div class="wishCltSlideV15">
		<div class="othersWish">
			<p class="user">
				<img src="http://fiximage.10x10.co.kr/web2015/common/img_profile_<%=Num2Str(getDefaultProfileImgNo(oWishCol.FItemList(0).Fuserid),2,"0","R")%>.png" alt="프로필 이미지" />
				<span><%=printUserId(oWishCol.FItemList(0).Fuserid,2,"*")%></span>
			</p>
			<ul class="pdtList">
			<%
				for i=0 to (oWishCol.FResultCount-1)
					'현재 보는 상품은 제외하고 나머지 상품만 노출 (5개 까지 노출)
					if cStr(itemid)<>cStr(oWishCol.FItemList(i).Fitemid) and chkcnt<5 then
			%>
				<li>
					<a href="/shopping/category_prd.asp?itemid=<%=oWishCol.FItemList(i).Fitemid%>&rc=item_wish_<%=chkPgCnt%>">
						<p class="pdtPhoto"><img src="<%=getThumbImgFromURL(oWishCol.FItemList(i).FimageOrg,150,150,"true","false")%>" alt="<%=replace(oWishCol.FItemList(i).Fitemname,"""","")%>" /></p>
						<p class="pdtName tPad07"><%=chrbyte(oWishCol.FItemList(i).Fitemname,32,"Y")%></p>
					</a>
				</li>
			<%
						chkcnt = chkcnt+1
					end if

					'그룹 구분
					if i<(oWishCol.FResultCount-1) then
						if lcase(tmpUid)<>lcase(oWishCol.FItemList(i+1).Fuserid) then
							tmpUid=oWishCol.FItemList(i+1).Fuserid
							chkcnt=0	'체크번호 리셋
							chkPgCnt=chkPgCnt+1			'페이지 카운트 증가
			%>
			</ul>
		</div>
		<div class="othersWish">
			<p class="user">
				<img src="http://fiximage.10x10.co.kr/web2015/common/img_profile_<%=Num2Str(getDefaultProfileImgNo(oWishCol.FItemList(i+1).Fuserid),2,"0","R")%>.png" alt="프로필 이미지" />
				<span><%=printUserId(oWishCol.FItemList(i+1).Fuserid,2,"*")%></span>
			</p>
			<ul class="pdtList">
			<%
						end if
					end if
				next
			%>
			</ul>
		</div>

	</div>
</div>
<script type="text/javascript">
$(function(){
	if($('.wishCltSlideV15 div').length>1) {
		$('.wishCltSlideV15').slidesjs({
			width:850,
			height:200,
			navigation:{active:false, effect:"fade"},
			pagination:{active:true, effect:"fade"},
			play:{active:false, effect:"fade", auto:false},
			effect:{
				fade:{speed:350, crossfade:true}
			}
		});
	}
});
</script>
<%
	end if

	set oWishCol = Nothing
%>
<!-- #include virtual="/lib/db/dbAppWishclose.asp" -->

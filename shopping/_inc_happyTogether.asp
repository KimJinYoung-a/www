<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/JSON2.asp" -->

<script language="jscript" runat="server" src="/lib/util/JSON_PARSER_JS.asp"></script>
<%
	dim oHTBCItem, chkHT, itemid, catecode, rcpUid, vPrdList, vMtdList, mtv, tmpArr, rtype
	dim lp, vIid, vMtd(), vLnk(), IValue
	ReDim vMtd(4), vLnk(4)

	itemid = requestCheckVar(request("itemid"),9)	'상품코드
	catecode = requestCheckVar(request("disp"),18)	'전시카테고리
    rtype = requestCheckVar(request("rtype"),10)	'타입
    
	'//클래스 선언
	set oHTBCItem = New CAutoCategory
	oHTBCItem.FRectItemId = itemid
	oHTBCItem.FRectDisp = catecode
	if (rtype="1") then
        oHTBCItem.FRectHappyTogetherType = "v4"
    end if
	'// 텐바이텐 해피투게더 상품 목록
	oHTBCItem.GetCateRightHappyTogetherList
	
	if oHTBCItem.FResultCount>0 then
%>
<% If oHTBCItem.FResultCount >= 3 Then %>
<script>
var mySwiper;
$(function() {
	$('.pdtListBoxV17a .btn-prev').on('click', function(e){
		if($("#page").val()>1){
			$("#page").val(Number($("#page").val())-1);
			jsGoEventPage($("#page").val());
			$("#pgcnt").text($("#page").val());
		}
	});
	$('.pdtListBoxV17a .btn-next').on('click', function(e){
		if (Number($("#tpage").val())>Number($("#page").val())){
			$("#page").val(Number($("#page").val())+1);
			jsGoEventPage($("#page").val());
			$("#pgcnt").text($("#page").val());
		}
	});
});

function jsGoEventPage(pg) {
	$.ajax({
		url: "act_happyTogether.asp?itemid=<%=itemid%>&disp=<%=catecode%>&rtype=<%=rtype%>&cpg="+pg,
		cache: false,
		async: false,
		success: function(message) {
			if(message!="") {
				
				$("#rcmdPrd01").empty().html(message);
		    }
		}
		,error: function(err) {
			//alert(err.responseText);
			$('#rcmdPrd01').hide();
		}
	});
}
</script>
<input type="hidden" id="page" value="1">
<input type="hidden" id="tpage" value="<%=int((oHTBCItem.FResultCount-1)/5)+1%>">
<div class="pdtListBoxV17a happy-together">
	<div class="titWrap">
		<h3 class="ftLt"><img src="http://fiximage.10x10.co.kr/web2017/shopping/tab_happytogether.png" alt="HAPPY TOGETHER" /></h3>
		<span class="ftLt">이 상품을 조회한 고객님들이 같이 조회한 상품</span>
	</div>
	<div class="itemContainerV17a">
		<div class="itemContV15">
			<ul class="pdtList" id="rcmdPrd01">
			<% For lp = 0 To oHTBCItem.FResultCount - 1 %>
			<% if lp>4 then Exit For %>
				<li>
					<p class="pdtPhoto">
						<a href="/shopping/category_prd.asp?itemid=<%= oHTBCItem.FItemList(lp).Fitemid %>&rc=item_happy_<%=lp+1%>&disptype=<%=CHKIIF(rtype="1","n","g")%>"><img src="<%=getThumbImgFromURL(oHTBCItem.FItemList(lp).FIcon1Image,150,150,"true","false") %>" width="150px" height="150px" alt="<%=oHTBCItem.FItemList(lp).FItemName%>" /></a>
					</p>
					<p class="pdtBrand tPad15"><a href="/street/street_brand.asp?makerid=<%=oHTBCItem.FItemList(lp).FMakerID%>&rc=item_happy_<%=lp+1%>&disptype=<%=CHKIIF(rtype="1","n","g")%>"><%=oHTBCItem.FItemList(lp).FBrandName%></a></p>
					<p class="pdtName tPad05">
						<a href="/shopping/category_prd.asp?itemid=<%= oHTBCItem.FItemList(lp).Fitemid %>&rc=item_happy_<%=lp+1%>&disptype=<%=CHKIIF(rtype="1","n","g")%>"><%=chrbyte(oHTBCItem.FItemList(lp).FItemName, 12, "Y")%></a>
					</p>
					<p class="pdtPrice tPad05"><strong><% = FormatNumber(oHTBCItem.FItemList(lp).getRealPrice,0) & chkIIF(oHTBCItem.FItemList(lp).IsMileShopitem,"Point","원") %></strong>
					<% IF oHTBCItem.FItemList(lp).IsSaleItem Then %>
						<strong class="cRd0V15">[<% = oHTBCItem.FItemList(lp).getSalePro %>]</strong>
					<% End If %>
					</p>
				</li>
			<%	next %>
			</ul>
			<span class="num"><strong id="pgcnt">1</strong>/<%=int((oHTBCItem.FResultCount-1)/5)+1%></span>
			<button type="button" class="btn-prev">이전</button>
			<button type="button" class="btn-next">다음</button>
		</div>
	</div>
</div>
<% End If %>
<%
	end if
	set oHTBCItem = nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
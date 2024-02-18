<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 2019 펀딩템 기획전
' History : 2019-04-15 최종원 생성
'####################################################
%>
<%
Response.Buffer = True
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_myfavoritecls.asp" -->
<!-- #include virtual="/lib/classes/event/exhibitionCls.asp" -->
<%    
	Dim vCurrPage 
	
	vCurrPage = RequestCheckVar(Request("cpg"),5)
	
	If vCurrPage = "" Then vCurrPage = 1


Dim oExhibition, page
dim mastercode, detailcode, detailGroupList, pagereload, listType, bestItemList, sortMet
dim i
dim imgSz	: imgSz = 600

listType = "B"

IF application("Svr_Info") = "Dev" THEN
	mastercode = 7
Else
	mastercode = 7
End If

pagereload	= requestCheckVar(request("pagereload"),2)
page = requestCheckVar(request("page"),5)
sortMet = request("sortMet")

if page = "" then page = 1

SET oExhibition = new ExhibitionCls	
	oExhibition.FPageSize = 9	
	oExhibition.FCurrPage = vCurrPage
	oExhibition.FrectMasterCode = mastercode	
	oExhibition.FrectListType = listType	
	oExhibition.FrectSortMet = sortMet
	oExhibition.getItemsPageListProc			
%>

<% If (oExhibition.FResultCount > 0) Then %>
<script type="text/javascript">
    $(function(){
        $('.btn-wish').click(function(e){
		    e.preventDefault()            
        });
		$('.review').click(function(e){
		    e.preventDefault()            
        });		
	});
	function viewProductPopup(itemid){
		window.open('/shopping/category_prd.asp?itemid='+itemid,'','width=1200,height=800,toolbar=yes, location=yes, directories=yes, status=yes, menubar=yes, scrollbars=yes, copyhistory=yes, resizable=yes');
	}
</script>
	<% If vCurrPage > 70 Then %>		
	<% Else %>
			<%
             dim couponPrice, couponPer, tempPrice, salePer
             dim saleStr, couponStr            
             for i = 0 to oExhibition.FResultCount - 1 
				couponPer = oExhibition.GetCouponDiscountStr(oExhibition.FItemList(i).Fitemcoupontype, oExhibition.FItemList(i).Fitemcouponvalue)
				couponPrice = oExhibition.GetCouponDiscountPrice(oExhibition.FItemList(i).Fitemcoupontype, oExhibition.FItemList(i).Fitemcouponvalue, oExhibition.FItemList(i).Fsellcash)                    					
				salePer     = CLng((oExhibition.FItemList(i).Forgprice-oExhibition.FItemList(i).Fsellcash)/oExhibition.FItemList(i).FOrgPrice*100)
				if oExhibition.FItemList(i).Fsailyn = "Y" and oExhibition.FItemList(i).Fitemcouponyn = "Y" then '세일, 쿠폰
					tempPrice = oExhibition.FItemList(i).Fsellcash - couponPrice
					saleStr = "<span class=""discount red"">"& salePer &"%</span>"
					couponStr = "<span class=""discount color-green"">"&couponPer&"</span>"  
				elseif oExhibition.FItemList(i).Fitemcouponyn = "Y" then    '쿠폰
					tempPrice = oExhibition.FItemList(i).Fsellcash - couponPrice
					saleStr = ""
					couponStr = "<span class=""discount color-green"">"&couponPer&"</span>"  
				elseif oExhibition.FItemList(i).Fsailyn = "Y" then  '세일
					tempPrice = oExhibition.FItemList(i).Fsellcash
					saleStr = "<span class=""discount red"">"& salePer &"%</span>"
					couponStr = ""    
				else
					tempPrice = oExhibition.FItemList(i).Fsellcash
					saleStr = ""
					couponStr = ""             					
				end if					
			%>
			<li class="item-list" itemid="<%=oExhibition.FItemList(i).Fitemid%>">
				<a href="javascript:viewProductPopup('<%=oExhibition.FItemList(i).Fitemid%>');">
					<div class="pic">
						<div class="thumbnail">
							<img src="<%=getThumbImgFromURL(oExhibition.FItemList(i).FPrdImage,imgSz,imgSz,"true","false")%>" alt="<%=oExhibition.FItemList(i).Fitemname%>">							
						</div>
						<div class="desc">
							<div class="name">
								<span class="ellipsis"><%=oExhibition.FItemList(i).Fitemname%></span>
							</div>
							<button class="btn-wish" onclick="TnAddFavorite('<%= oExhibition.FItemList(i).Fitemid %>');">
								<span class="wish-cnt"><%= FormatNumber(oExhibition.FItemList(i).FfavCnt, 0) %></span>
							</button><!-- for dev msg : 좋아요 누르면 하얀 버튼 으로 이미지 변경 :class="on" 추가 -->
						</div>
					</div>
					<div class="txt"> <!-- for dev msg : md 등록 copy -->
						<p><%=oExhibition.FItemList(i).FAddtext1%></p>
						<span><%=oExhibition.FItemList(i).FAddtext2%></span>						
					</div>
				</a>
				<p class="brand"><a href="/street/street_brand.asp?makerid=<%=oExhibition.FItemList(i).FMakerid%>"><%= oExhibition.FItemList(i).FBrandName %></a></p>  <!-- for dev msg : 브랜드로 이동 -->
			</li>                        		       										
			<%
				'end if
			%>
			<% Next %>
	<% End If %>
<%
Else
%>
<%
End If
%>

<!-- #include virtual="/lib/db/dbclose.asp" -->
<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
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

listType = "B"

IF application("Svr_Info") = "Dev" THEN
	mastercode = 7
Else
	mastercode = 3
End If

pagereload	= requestCheckVar(request("pagereload"),2)
page = requestCheckVar(request("page"),5)
sortMet = request("sortMet")

if page = "" then page = 1

SET oExhibition = new ExhibitionCls	
	oExhibition.FPageSize = 18	
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
					   
				if (vCurrPage = 3 and i = 13) or (vCurrPage = 6 and i = 10) then				
			%>			                            <%'<!-- for dev msg 50번째, 100번재에 sns 배너 삽입 부탁드려요-->%>
			<li class="bnr-sns">
				<img src="//fiximage.10x10.co.kr/web2019/common/img_sns_card.png" alt="">
				<a href="http://bit.ly/2TMmgyd" target="_blank" class="fb">페이스북</a>
				<a href="http://bit.ly/2TMn7ip" target="_blank" class="insta">인스타그램</a>
			</li>
			<%	
				end if
			%>
			<li class="item-list" itemid="<%=oExhibition.FItemList(i).Fitemid%>">
			<div class="info" onClick="">
				<a href="javascript:viewProductPopup('<%=oExhibition.FItemList(i).Fitemid%>');" onclick="fnAmplitudeEventMultiPropertiesAction('click_snsitem_items','idx|itemid','<%=i+1%>|<%=oExhibition.FItemList(i).Fitemid%>');">
					<div>
						<div class="thumbnail"><img src="<%=oExhibition.FItemList(i).FPrdImage%>" alt="<%=oExhibition.FItemList(i).Fitemname%>"></div>
						<div class="desc">
							<span class="brand"><%= oExhibition.FItemList(i).FBrandName %></span>
							<p class="name"><%=oExhibition.FItemList(i).Fitemname%></p>
							<div class="price">
								<%=saleStr%><%=couponStr%><%=FormatNumber(tempPrice, 0)%> 원								
							</div>
						</div>
					</div>
					<div class="etc">
						<div class="review" onclick="popEvaluate('<%= oExhibition.FItemList(i).Fitemid %>');">
							<% if oExhibition.FItemList(i).FevalCnt <> 0 then %>
								<span class="icon-rating"><span><i style="width:<%=fnEvalTotalPointAVG(oExhibition.FItemList(i).FtotalPoint,"search")%>%;"></i></span>(<%=oExhibition.FItemList(i).FevalCnt%>)</span>
							<% else %>
								<span>첫 후기, 200P 지급!</span>
							<% end if %>							
						</div>						
						<button class="btn-wish" onclick="TnAddFavorite('<%= oExhibition.FItemList(i).Fitemid %>');">
							<span class="wish-cnt"><%= FormatNumber(oExhibition.FItemList(i).FfavCnt, 0) %></span>
						</button>
					</div>                                    
				</a>
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
<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.Buffer = True
%>
<!-- #include virtual="/lib/db/dbCTopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_myfavoritecls.asp" -->
<!-- #include virtual="/lib/classes/event/exhibitionCls.asp" -->
<%
    '' 2차서버로 변경 2014/09/30 dbopen.asp => dbCTopen.asp, dbclose.asp =>dbCTclose.asp, fnPopularList => fnPopularList_CT
	Dim cPopular, vDisp, vSort, vCurrPage, i, j, vArrEval, oExhibition
	vDisp = RequestCheckVar(Request("disp"),18)
	vSort = NullFillWith(RequestCheckVar(Request("sort"),1),"1")
	vCurrPage = RequestCheckVar(Request("cpg"),5)
	
	If vCurrPage = "" Then vCurrPage = 1
	
    SET oExhibition = new ExhibitionCls
	SET cPopular = New CMyFavorite
	cPopular.FPageSize = 30
	cPopular.FCurrpage = vCurrPage
	cPopular.FRectDisp = vDisp
	cPopular.FRectSortMethod = vSort
	cPopular.FRectUserID = GetLoginUserID()
	cPopular.fnPopularList_CT
%>
<% If (cPopular.FResultCount > 0) Then %>	
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
    <% 
    dim couponPrice, couponPer, tempPrice, salePer
    dim saleStr, couponStr, tmpEvalArr      
    For i = 0 To cPopular.FResultCount-1 
        couponPer = oExhibition.GetCouponDiscountStr(cPopular.FItemList(i).Fitemcoupontype, cPopular.FItemList(i).Fitemcouponvalue)
        couponPrice = oExhibition.GetCouponDiscountPrice(cPopular.FItemList(i).Fitemcoupontype, cPopular.FItemList(i).Fitemcouponvalue, cPopular.FItemList(i).Fsellcash)                    					
        salePer     = CLng((cPopular.FItemList(i).Forgprice-cPopular.FItemList(i).Fsellcash)/cPopular.FItemList(i).FOrgPrice*100)
        if cPopular.FItemList(i).FSaleyn = "Y" and cPopular.FItemList(i).Fitemcouponyn = "Y" then '세일, 쿠폰
            tempPrice = cPopular.FItemList(i).Fsellcash - couponPrice
            saleStr = "<span class=""discount color-red"">"& salePer &"%</span>"
            couponStr = "<span class=""discount color-green"">"&couponPer&"</span>"  
        elseif cPopular.FItemList(i).Fitemcouponyn = "Y" then    '쿠폰
            tempPrice = cPopular.FItemList(i).Fsellcash - couponPrice
            saleStr = ""
            couponStr = "<span class=""discount color-green"">"&couponPer&"</span>"  					
        elseif cPopular.FItemList(i).FSaleyn = "Y" then  '세일
            tempPrice = cPopular.FItemList(i).Fsellcash
            saleStr = "<span class=""discount color-red"">"& salePer &"%</span>"
            couponStr = ""    
        else
            tempPrice = cPopular.FItemList(i).Fsellcash
            saleStr = ""
            couponStr = ""             
        end if		

        if cPopular.FItemList(i).FAdultType = "1" then            
        else            
    %>
    <li class="item-list" itemid="<%=cPopular.FItemList(i).FItemID%>">
        <a href="javascript:viewProductPopup('<%=cPopular.FItemList(i).FItemID%>');">
            <div>
                <div class="thumbnail"><img src="<%= cPopular.FItemList(i).FImageBasic %>" alt=""></div>
                <div class="desc">
                    <span class="brand"><%= cPopular.FItemList(i).FBrandName %></span>
                    <p class="name"><%= cPopular.FItemList(i).FItemName %></p>
                    <div class="price">
                        <%=saleStr%><%=couponStr%><%=FormatNumber(tempPrice, 0)%> 원								
                    </div>   
                </div>
            </div>
            <div class="etc">
                
                <% if cPopular.FItemList(i).FEvalCnt < 1 then %>                
                <div class="review">                
                    <span>첫 후기, 200P 지급!</span>                              
                </div>                                      
                <% else %>
                <div class="review" onclick="popEvaluate('<%= cPopular.FItemList(i).FItemID %>');">                
                    <span class="icon-rating"><span><i style="width:100%;"></i></span>(<%=FormatNumber(cPopular.FItemList(i).FEvalCnt, 0)%>)</span>
                </div>    
                <% end if %>
                
                <button class="btn-wish" onclick="TnAddFavorite('<%= cPopular.FItemList(i).FItemID %>');">
                    <span><%=FormatNumber(cPopular.FItemList(i).FFavCount,0)%></span>
                </button>
            </div>
        </a>
    </li>										
    <% 
        end if        
    Next
     %>	
<%
Else
%>
<%
End If
SET cPopular = Nothing
%>

<!-- #include virtual="/lib/db/dbCTclose.asp" -->
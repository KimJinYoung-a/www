<script>
$(function(){
    $(".cont1 ul li:gt(7)").css('display','none');    
    $(".cont2 ul li:gt(7)").css('display','none');    
    $(".cont3 ul li:gt(7)").css('display','none');    
    $(".cont4 ul .exh-item:gt(3)").css('display','none');    
	// 더보기
	$('.btn-item-more').click(function(e) {
        var btnIdx = $(".btn-item-more").index($(this)) + 1;                  
        $(".cont"+ btnIdx +" ul li").slideDown()
		e.preventDefault();
	});     
	// $("#exhibition-area .exh-item").each(function(idx){
	// 	$(".badge-area em:gt(2)", this).css('display','none');
	// })	
})
</script>
<%
    dim bestList, soldList, cartList, popularEvtList
    dim couponPer, couponPrice, itemSalePer, tempPrice, saleStr, couponStr

	dim odibest
	set odibest = new cdiary_list
		odibest.FPageSize	= 12
		odibest.FselOp		= 0 '0 신규순 1 종료 임박 2 인기순
		odibest.FEvttype = "1"
		odibest.Fisweb	 	= "1"
		odibest.Fismobile	= "0"
		odibest.Fisapp	 	= "0"
		odibest.fnGetdievent

    bestList = oExhibition.getItemsListProc( "B", 16, mastercode, "", "1", "1" )
    soldList = oExhibition.getItemsListProc( "C", 16, mastercode, "", "", "" )
    cartList = oExhibition.getItemsListProc( "B", 16, mastercode, "", "", "4" )
%>
				<div class="recommend">
					<div class="inner">
						<div class="tit-area ">
							<h3>추천 <b>문구템</b></h3>
							<ul class="tab-menu">
								<li class="on"><a href="/">베스트셀러</a></li>
								<li><a href="">방금 판매된</a></li>
								<li><a href="">위시에 많이 담긴</a></li>
								<li><a href="">많이 보는 기획전</a></li>
							</ul>
						</div>
						<div class="item-area">
							<!-- 베스트셀러 -->
                            <% if isArray(bestList) then %>
							<div class="item-list ranking on cont1">
								<ul>
                                    <% 
                                        for i = 0 to Ubound(bestList) - 1 
                                            couponPer = oExhibition.GetCouponDiscountStr(bestList(i).Fitemcoupontype, bestList(i).Fitemcouponvalue)
                                            couponPrice = oExhibition.GetCouponDiscountPrice(bestList(i).Fitemcoupontype, bestList(i).Fitemcouponvalue, bestList(i).Fsellcash)                    
                                            itemSalePer     = CLng((bestList(i).Forgprice-bestList(i).Fsellcash)/bestList(i).FOrgPrice*100)
                                            if bestList(i).Fsailyn = "Y" and bestList(i).Fitemcouponyn = "Y" then '세일
                                                tempPrice = bestList(i).Fsellcash - couponPrice
                                                saleStr = "<b class=""discount sale"">"&itemSalePer&"%</b>"
                                                couponStr = "<b class=""discount coupon"">"&couponPer&"</b>"  
                                            elseif bestList(i).Fitemcouponyn = "Y" then
                                                tempPrice = bestList(i).Fsellcash - couponPrice
                                                saleStr = ""
                                                couponStr = "<b class=""discount coupon"">"&couponPer&"</b>"  
                                            elseif bestList(i).Fsailyn = "Y" then
                                                tempPrice = bestList(i).Fsellcash
                                                saleStr = "<b class=""discount sale"">"&itemSalePer&"%</b>"
                                                couponStr = ""                                              
                                            else
                                                tempPrice = bestList(i).Fsellcash
                                                saleStr = ""
                                                couponStr = ""                                              
                                            end if                                        
                                    %>
									<li class="item"> 
										<a href="/shopping/category_prd.asp?itemid=<%=bestList(i).Fitemid%>">
											<div class="thumbnail">
												<img src="<%=bestList(i).FImageList%>" alt="" />
												<!-- dev for msg: 랭킹의 1~3위까지만 num-rolling 클래스가 더 붙습니다 4위부터는 num-rolling 빼주세요-->
												<div class="badge badge-count1 <%=chkIIF(i < 3, "num-rolling", "")%>">
													<em><%=i + 1%></em>
												</div>
											</div>
											<div class="desc">
												<div class="price-area">
                                                    <span class="price"><%=formatNumber(tempPrice, 0)%></span>
                                                    <% response.write saleStr%>
                                                    <% response.write couponStr%>                                                    
                                                </div>
												<p class="name"><%=bestList(i).Fitemname%></p>
											</div>
										</a>
									</li>
                                    <% next %>          
								</ul>
								<!-- for dev msg : 처음에는 상품4개 노출 되고 더보기 버튼 누른면 더보기버튼 없어지면서 총 12개 노출 -->
								<a href="" class="ico-diary btn-down btn-item-more" style="display:<%=chkIIF(i > 4, "","none")%>">더 많은 상품보기</a>
							</div>
                            <% end if %>
							<!-- 방금 판매된 -->
                            <% if isArray(soldList) then %>
							<div class="item-list moment cont2">
								<ul>
                                    <% 
                                        for i = 0 to Ubound(soldList) - 1 
                                            couponPer = oExhibition.GetCouponDiscountStr(soldList(i).Fitemcoupontype, soldList(i).Fitemcouponvalue)
                                            couponPrice = oExhibition.GetCouponDiscountPrice(soldList(i).Fitemcoupontype, soldList(i).Fitemcouponvalue, soldList(i).Fsellcash)                    
                                            itemSalePer     = CLng((soldList(i).Forgprice-soldList(i).Fsellcash)/soldList(i).FOrgPrice*100)
                                            if soldList(i).Fsailyn = "Y" and soldList(i).Fitemcouponyn = "Y" then '세일
                                                tempPrice = soldList(i).Fsellcash - couponPrice
                                                saleStr = "<b class=""discount sale"">"&itemSalePer&"%</b>"
                                                couponStr = "<b class=""discount coupon"">"&couponPer&"</b>"  
                                            elseif soldList(i).Fitemcouponyn = "Y" then
                                                tempPrice = soldList(i).Fsellcash - couponPrice
                                                saleStr = ""
                                                couponStr = "<b class=""discount coupon"">"&couponPer&"</b>"  
                                            elseif soldList(i).Fsailyn = "Y" then
                                                tempPrice = soldList(i).Fsellcash
                                                saleStr = "<b class=""discount sale"">"&itemSalePer&"%</b>"
                                                couponStr = ""                                              
                                            else
                                                tempPrice = soldList(i).Fsellcash
                                                saleStr = ""
                                                couponStr = ""                                              
                                            end if                                        
                                    %>                                
									<li class="item"> 
										<a href="/shopping/category_prd.asp?itemid=<%=soldList(i).Fitemid%>">
											<div class="thumbnail">
												<img src="<%=soldList(i).FImageList%>" alt="" />
												<div class="badge badge-count2">
													<em><%=soldList(i).FSellDate%></em>
												</div>
											</div>
											<div class="desc">
												<div class="price-area">
                                                    <span class="price"><%=formatNumber(tempPrice, 0)%></span>
                                                    <% response.write saleStr%>
                                                    <% response.write couponStr%>                                                    
                                                </div>
												<p class="name"><%=soldList(i).Fitemname%></p>
											</div>
										</a>
									</li>
                                    <% next %>
								</ul>
								<a href="" class="ico-diary btn-down btn-item-more" style="display:<%=chkIIF(i > 4, "","none")%>">더 많은 상품보기</a>
							</div>
                            <% end if %>
							<!-- 장바구니에 많이 담긴 -->
                            <% if isArray(cartList) then %>
							<div class="item-list moment cont3">
								<ul>
                                <% 
                                    for i = 0 to Ubound(cartList) - 1 
                                        couponPer = oExhibition.GetCouponDiscountStr(cartList(i).Fitemcoupontype, cartList(i).Fitemcouponvalue)
                                        couponPrice = oExhibition.GetCouponDiscountPrice(cartList(i).Fitemcoupontype, cartList(i).Fitemcouponvalue, cartList(i).Fsellcash)                    
                                        itemSalePer     = CLng((cartList(i).Forgprice-cartList(i).Fsellcash)/cartList(i).FOrgPrice*100)
                                        if cartList(i).Fsailyn = "Y" and cartList(i).Fitemcouponyn = "Y" then '세일
                                            tempPrice = cartList(i).Fsellcash - couponPrice
                                            saleStr = "<b class=""discount sale"">"&itemSalePer&"%</b>"
                                            couponStr = "<b class=""discount coupon"">"&couponPer&"</b>"  
                                        elseif cartList(i).Fitemcouponyn = "Y" then
                                            tempPrice = cartList(i).Fsellcash - couponPrice
                                            saleStr = ""
                                            couponStr = "<b class=""discount coupon"">"&couponPer&"</b>"  
                                        elseif cartList(i).Fsailyn = "Y" then
                                            tempPrice = cartList(i).Fsellcash
                                            saleStr = "<b class=""discount sale"">"&itemSalePer&"%</b>"
                                            couponStr = ""                                              
                                        else
                                            tempPrice = cartList(i).Fsellcash
                                            saleStr = ""
                                            couponStr = ""                                              
                                        end if                                        
                                %>
									<li class="item"> 
										<a href="/shopping/category_prd.asp?itemid=<%=cartList(i).Fitemid%>">
											<div class="thumbnail">
												<img src="<%=cartList(i).FImageList%>" alt="" />
												<div class="badge badge-count2">
													<em><b><%=formatNumber(cartList(i).FfavCnt, 0)%></b>명</em>
												</div>
											</div>
											<div class="desc">
												<div class="price-area">
                                                    <span class="price"><%=formatNumber(tempPrice, 0)%></span>
                                                    <% response.write saleStr%>
                                                    <% response.write couponStr%>                                                    
                                                </div>
												<p class="name"><%=cartList(i).Fitemname%></p>
											</div>
										</a>
									</li>
								<% next %>	
								</ul>
								<a href="" class="ico-diary btn-down btn-item-more" style="display:<%=chkIIF(i > 4, "","none")%>">더 많은 상품보기</a>
							</div>
                            <% end if %>
							<!-- 많이보는 기획전 -->
                            <% If odibest.FResultCount > 0 Then  %>
                            <div class="item-list exhibition cont4" id="exhibition-area">
								<ul>
                                <% FOR i = 0 to odibest.FResultCount-1 %>
									<li class="exh-item">
										<a href="/event/eventmain.asp?eventid=<%=odibest.FItemList(i).fevt_code %>">
											<div class="thumbnail">
                                            <% If odibest.FItemList(i).Fetc_itemimg <> "" Then %>
                                                <img src="<%=odibest.FItemList(i).Fetc_itemimg %>" alt="" />
                                            <% else %>
                                                <img src="<%=odibest.FItemList(i).FImageList %>" alt="" />
                                            <% end if %>
											</div>
											<div class="desc">
												<ul>
													<li class="badge-area">
													<% if odibest.FItemList(i).fissale and odibest.FItemList(i).FSalePer <> "" and odibest.FItemList(i).FSalePer <> "0" then %><em class="badge-sale">~<%=odibest.FItemList(i).FSalePer%>%</em><% end if %>
													<% if odibest.FItemList(i).fiscoupon and odibest.FItemList(i).FSaleCPer <> "" and odibest.FItemList(i).FSaleCPer <> "0" then %><em class="badge-cpn"><%=couponDisp(odibest.FItemList(i).FSaleCPer)%> 쿠폰</em><% end if %>
													<% If odibest.FItemList(i).fisOnlyTen Then %><em class="badge-only">ONLY</em><% End If %>
													<% If odibest.FItemList(i).fisgift Then %><em class="badge-gift">GIFT</em><% End If %>
													<% if odibest.FItemList(i).fisoneplusone then %><em class="badge-plus">1+1</em><% end if %>
													<% if odibest.FItemList(i).fisNew then %><em class="badge-launch">런칭</em><% end if %>
													<% if odibest.FItemList(i).fisfreedelivery then %><em class="badge-free">무료배송</em><% end if %>
													<% if odibest.FItemList(i).fisbookingsell then %><em class="badge-book">예약판매</em><% end if %>														
													</li>
													<li class="tit"><%=split(odibest.FItemList(i).FEvt_name,"|")(0)%></li>
													<li class="subcopy"><%=odibest.FItemList(i).FEvt_subcopyK%></li>
												</ul>
											</div>
										</a>
									</li>
                                <% next %>
								</ul>
								<a href="" class="ico-diary btn-down btn-item-more">더 많은 기획전보기</a>
							</div>
                            <% end if %>
						</div>
					</div>
				</div>
<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 2019 어서와 텐바이텐은 처음이지?
' History : 2019-03-22 최종원 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/classes/event/exhibitionCls.asp" -->
<%
'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			Response.Redirect "http://m.10x10.co.kr/event/memberguide/"
			REsponse.End
		end if
	end if
end if

Dim oExhibition, i, y
dim mastercode,  detailcode, bestItemList, eventList, detailGroupList, listType
dim tempNumber, couponPrice, couponPer, tempPrice, salePer
dim saleStr, couponStr

IF application("Svr_Info") = "Dev" THEN
	mastercode = 1
Else
	mastercode = 5	
End If

listType = "A"

SET oExhibition = new ExhibitionCls

	detailGroupList = oExhibition.getDetailGroupList(mastercode)
function format(ByVal szString, ByVal Expression)
	if len(szString) < len(Expression) then
	format = left(expression, len(szString)) & szString
	else
	format = szString
	end if
end function    
%>
</head>
<style type="text/css">
.whitemember {background-color: #fff;}
.whitemember .topic {position: relative; height: 883px; background: url(//webimage.10x10.co.kr/fixevent/event/2019/memberGuide/white/tit_white.jpg?v=1.01) no-repeat #76dff4 center top; }
.whitemember .topic h2 {position: absolute; top: 60px; left: 50%; width: 480px; height: 275px; margin-left: -240px; text-indent: -9999px; opacity: 0;}
.whitemember .topic .bg-area span {position: absolute; left: 50%; }
.whitemember .topic .bg-area .ballon1 {top: 170px; margin-left: -555px; animation:balloon1 5s 20;}
.whitemember .topic .bg-area .ballon2 {top: 270px; margin-left: -615px; animation:balloon2 3s 30;}
.whitemember .topic .bg-area .ballon3 {top: 287px; margin-left: 540px; animation:balloon3 3s 30;}
.whitemember .topic .bg-area .car1 {top: 520px; margin-left: 510px; animation: car1 5s both 1; animation-timing-function: cubic-bezier(0.15, 0.57, 0.31, 1.06)}
.whitemember .topic .txt-area {position: absolute; top: 650px; left: 0; width: 100%; height: 150px; text-align: center;}
.whitemember .topic .txt-area p {margin-bottom: 13px; animation:fadeDown 1s ease-out both;}
.whitemember .topic .txt-area p.txt2 {animation-delay: .5s}
.whitemember .topic .txt-area p.txt3 {animation-delay: 1s}
.whitemember .section {position: relative; height: 498px; background: url(//webimage.10x10.co.kr/fixevent/event/2019/memberGuide/white/img_white.jpg?v=1.03) no-repeat #3bbe61 center top;}
.whitemember .section ul {width: 810px; margin: 0 auto; padding-top: 13px; *zoom:1} 
.whitemember .section ul:after {display:block; clear:both; content:'';} 
.whitemember .section ul li {float: left; margin: 59px 18px 0 17px;}
.whitemember .section ul li a {display: block; width: 100px; height: 100px; transition:.3s; border-radius: 50%; text-indent: -9999px;}
.whitemember .section ul li:hover a {position: relative; background: rgba(0, 0, 0, 0.4)}
.whitemember .section ul li:hover a:after{position: absolute; top: 0; left: 0; content: ''; display: block; width: 100%; height: 100%; background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/memberGuide/white/ico_arrow.png); animation: bounce1 0.6s 6;}
@keyframes balloon1 {
    from, to { transform:translate(0, -10px) rotate(4deg);}
    50%{ transform:translate(-5px, 10px) rotate(-3deg);}
}
@keyframes balloon2 {
    from, to { transform:translateY(0) rotate(-6deg);}
    50%{ transform:translateY(-10px) rotate(8deg); }
}
@keyframes balloon3 {
    from, to { transform:translateY(0) rotate(6deg);} 
    50%{ transform:translateY(-15px) rotate(-8deg); }
}
@keyframes car1 {
	to {margin-left: 330px;}
} 
@keyframes fadeDown { 
    from {transform:translateY(-10px); opacity:0;} 
    to {transform:translateY(0); opacity:1;} 
}
@keyframes bounce1 { 
    from to {transform:translateY(0); animation-timing-function: ease-in;}
	50% {transform:translateY(7px); animation-timing-function: ease-out;}
}
</style>
<script>
</script>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
						<!-- 어서와 텐바이텐은 처음이지 -->
						<div class="memberGuide whitemember fullEvt">
							<div class="topic">
                                <h2>어서와 텐바이텐은 처음이지 뭘 사야할지 모르는 텐텐 입문러를 위해 준비했어요!</h2>
                                <div class="bg-area">
                                    <span class="ballon1"><img src="//webimage.10x10.co.kr/fixevent/event/2019/memberGuide/white/bg_balloon_01.png" alt=""></span>
                                    <span class="ballon2"><img src="//webimage.10x10.co.kr/fixevent/event/2019/memberGuide/white/bg_balloon_02.png" alt=""></span>
                                    <span class="ballon3"><img src="//webimage.10x10.co.kr/fixevent/event/2019/memberGuide/white/bg_balloon_03.png" alt=""></span>
                                    <span class="car1"><img src="//webimage.10x10.co.kr/fixevent/event/2019/memberGuide/white/bg_car.png?v=1.01" alt=""></span>
                                </div>
                                <div class="txt-area">
                                    <p class="txt1"><img src="//webimage.10x10.co.kr/fixevent/event/2019/memberGuide/white/txt_01.png" alt="어서 오세요. 텐바이텐에 오신 걸 환영합니다!"></p>
                                    <p class="txt2"><img src="//webimage.10x10.co.kr/fixevent/event/2019/memberGuide/white/txt_02.png" alt="아래 원하는 관심사를 선택하시면, 텐바이텐 입문 고객을 위한 맞춤 아이템을 추천해드릴게요!"></p>
                                    <p class="txt3"><img src="//webimage.10x10.co.kr/fixevent/event/2019/memberGuide/white/txt_03.png" alt="오늘부터 단골손님이 되어도 책임 못 져요!"></p>
                                </div>
                            </div>
                            <div class="section">
                                <ul>
                                    <li><a href="#groupBar01">인테리어</a></li>
									<li><a href="#groupBar02">패션</a></li>
									<li><a href="#groupBar03">다꾸</a></li>
									<li><a href="#groupBar04">취미</a></li>
									<li><a href="#groupBar05">여행</a></li>
									<li><a href="#groupBar06">뷰티</a></li>
									<li><a href="#groupBar07">요리</a></li>
									<li><a href="#groupBar08">반려동물</a></li>
									<li><a href="#groupBar09">육아</a></li>
									<li><a href="#groupBar10">디지털기기</a></li>
									<li><a href="#groupBar11">다이어트</a></li>
									<li><a href="#groupBar12">토이</a></li>
                                </ul>
							</div>
							<!-- 상품 목록 -->
							<div class="evtPdtListWrapV15">
                            <% 
                            if Ubound(detailGroupList) > 0 then                             
                                dim tmpItemList, tmpidx
                                for i = 0 to Ubound(detailGroupList) - 1 
                                tmpidx = format(detailGroupList(i).Fdetailcode/10, "00")                                 
                                
                                tmpItemList = oExhibition.getItemsListProc( listType, 100, mastercode, detailGroupList(i).Fdetailcode, "", "")'리스트타입, 아이템수, 마스터코드, 디테일코드, 픽아이템, 카테고리sort                                
                            %>	
								<!-- 기차바 : 인테리어 -->
								<div class="pdtGroupBarV17" id="groupBar<%=tmpidx%>" name="groupBar<%=tmpidx%>">
									<img src="//webimage.10x10.co.kr/fixevent/event/2019/memberGuide/white/groupbar_<%=tmpidx%>.gif" alt="">
								</div>
								<div class="evtPdtListWrapV15 ">
									<div class="pdtWrap pdt240V15">
										<ul class="pdtList">
                                        <% 
                                        if Ubound(tmpItemList) > 0 then 
                                           for y = 0 to Ubound(tmpItemList) - 1             
                                                couponPer = oExhibition.GetCouponDiscountStr(tmpItemList(y).Fitemcoupontype, tmpItemList(y).Fitemcouponvalue)
                                                couponPrice = oExhibition.GetCouponDiscountPrice(tmpItemList(y).Fitemcoupontype, tmpItemList(y).Fitemcouponvalue, tmpItemList(y).Fsellcash)                    
                                                salePer     = CLng((tmpItemList(y).Forgprice-tmpItemList(y).Fsellcash)/tmpItemList(y).FOrgPrice*100)
                                                if tmpItemList(y).Fsailyn = "Y" and tmpItemList(y).Fitemcouponyn = "Y" then '세일
                                                    tempPrice = tmpItemList(y).Fsellcash - couponPrice
                                                    saleStr = "<span class=""discount color-red"">["&salePer&"%]</span>"
                                                    couponStr = "<span class=""discount color-green"">["&couponPer&"]</span>"  
                                                elseif tmpItemList(y).Fitemcouponyn = "Y" then
                                                    tempPrice = tmpItemList(y).Fsellcash - couponPrice
                                                    saleStr = ""
                                                    couponStr = "<span class=""discount color-green"">["&couponPer&"]</span>"  
                                                elseif tmpItemList(y).Fsailyn = "Y" then
                                                    tempPrice = tmpItemList(y).Fsellcash
                                                    saleStr = "<span class=""discount color-red"">["&salePer&"%]</span>"
                                                    couponStr = ""                                   
                                                else
                                                    tempPrice = tmpItemList(y).Fsellcash
                                                    saleStr = ""
                                                    couponStr = ""                                            
                                                end if                                                                                   
                                        %>	
                                            <li>				
												<div class="pdtBox">
													<div class="pdtPhoto">
														<span class="soldOutMask"></span><a href="/shopping/category_prd.asp?itemid=<%=tmpItemList(y).Fitemid%>"><img src="<%=tmpItemList(y).FImageList%>" alt="<%=tmpItemList(y).Fitemname%>" /></a>
													</div>
													<div class="pdtInfo">
														<p class="pdtBrand tPad20"><a href="/street/street_brand.asp?makerid=<%= tmpItemList(y).FMakerid %>"><%=tmpItemList(y).FbrandName%></a></p>
														<p class="pdtName tPad07"><a href=""><%=tmpItemList(y).Fitemname%></a></p>
														<p class="pdtPrice">
                                                            <span class="finalP"><%=formatNumber(tempPrice, 0)%>원</span> 
                                                            <% response.write saleStr%>
                                                            <% response.write couponStr%>
                                                        </p>														
													</div>	
                                                    <ul class="pdtActionV15">
                                                        <li class="largeView"><a href="" onclick="ZoomItemInfo('<%=tmpItemList(y).FItemid %>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
                                                        <li class="postView"><a href="javascript:void(0)" onclick="<%=chkIIF(tmpItemList(y).FEvalCnt>0,"popEvaluate('" & tmpItemList(y).FItemid & "');","")%>"><span><%=tmpItemList(y).FevalCnt%></span></a></li>
                                                        <li class="wishView"><a href="" onclick="TnAddFavorite('<%=tmpItemList(y).FItemid %>'); return false;"><span><%=tmpItemList(y).FfavCnt%></span></a></li>
                                                    </ul>                                                    												
												</div>
                                            </li>    
                                        <%
                                            next
                                        end if
                                        %> 
										</ul>
									</div>
								</div>
                            <% 
                                next
                            end if 
                            %>
							</div>
						</div>
						<!--// 어서와 텐바이텐은 처음이지 -->

	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->
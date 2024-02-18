<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 2018 크리스마스 기획전
' History : 2018-11-14 최종원 생성
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
			Response.Redirect "http://m.10x10.co.kr/christmas/2018/"
			REsponse.End
		end if
	end if
end if

dim updateDate, testDate, currentDate, updatePage, originPage

currentDate = date()
'feed 페이지 설정부분
updateDate = cdate("2018-12-14")
updatePage = "christmas_feed_1214.asp"
originPage = "christmas_feed_1213.asp"

testDate = request("testdate")

if testDate <> "" then
	currentDate = cdate(testDate)
end if

Function printItemName(str,lng,chr)
	dim tmpStr
	if str <> "" then 
		tmpStr = Mid(str, 1, lng) & chr	
	end if
	printItemName = tmpStr	
End Function

Dim oExhibition, page
dim mastercode,  detailcode, eventList, pagereload, listType, detailcodeName
dim i
'10 : 조명
'20 : 트리/리스
'30 : 오너먼트
'40 : 캔들/디퓨저
'50 : 선물
'60 : 카드

listType = "A"
mastercode =  1
detailcode =  requestCheckvar(request("detailcode"),10)
pagereload	= requestCheckVar(request("pagereload"),2)
page = requestCheckVar(request("page"),5)
if page = "" then page = 1

if detailcode = "" then detailcode = "-1"

Select Case detailcode
	Case -1
		detailcodeName = "전체"
	Case 10
		detailcodeName = "조명"														
	Case 20
		detailcodeName = "트리/리스"		
	Case 30
		detailcodeName = "오너먼트"
	Case 40
		detailcodeName = "캔들/디퓨저"
	Case 50
		detailcodeName = "선물"
	Case 60
		detailcodeName = "카드"										
	Case Else
		detailcodeName = "전체"
End Select

SET oExhibition = new ExhibitionCls
	oExhibition.FPageSize = 24
	oExhibition.FCurrPage = page
	oExhibition.FrectMasterCode = mastercode
	oExhibition.FrectDetailCode = detailcode
	oExhibition.FrectListType = listType
	oExhibition.getItemsPageListProc
	
	eventList = oExhibition.getEventListProc( "A", 10, mastercode, 0 )     '리스트타입, row개수, 마스터코드, 디테일코드		
%>
<link rel="stylesheet" type="text/css" href="/lib/css/xmas2018.css?v=1.1" />
</head>
<script>
	fnAmplitudeEventMultiPropertiesAction('view_2018christmas_main','','');
$(function(){	
	if($(".event-obj").length < 5){
		$(".event-more").css("display", "none")
	}	

    $("input[name=detailcode]").click(function(e){        
		var categoryName = $(this).attr("id");	
		// alert();		
		fnAmplitudeEventMultiPropertiesAction("click_2018christmas_category","category_name",categoryName);
        submitForm(e.target.value);
    });
	$(".event-elmore").css("display","none");	
	$(".feed-elmore").css("display","none");	
	
	<% if pagereload <> "" then%>
	pagedown();
	<% end if %>    

    $('.btn-more').click(function(e){
		if($(this).hasClass("event-more")){
		 $(".event-elmore").css("display", "");
		 $(this).hide();        
		}else if($(this).hasClass("feed-more")){
		 $(".feed-elmore").css("display", "");
		 $(this).hide();        
		}
    });		
});
function submitForm(detailCodeVal){    
   var frm = document.frm
   frm.detailcode.value=detailCodeVal
   frm.method = "post"
   frm.action = "/christmas/2018/index.asp?pagereload=ON" 
   frm.submit();
}
function pagedown(){	
	window.$('html,body').animate({scrollTop:$("#xmas-item").offset().top}, 0);
}
function jsGoPage(iP){
	document.pageFrm.page.value = iP;
	document.pageFrm.submit();
}
</script>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container xmas2018">
		<div class="xmas-head">
			<h2><img src="http://fiximage.10x10.co.kr/web2018/xmas2018/tit_xmas.gif" alt="Christmas Record - 찰칵, 당신의 크리스마스를 담아요"></h2>
		</div>
		<%
		
		if currentDate >= updateDate   then			
			server.Execute("/christmas/2018/"&updatePage)
		else
			server.Execute("/christmas/2018/"&originPage)
		end if		
		%>	
		<!-- 기획전 -->
		<% if isArray(eventList) then %>
		<section class="xmas-evt">
			<div class="inner">
				<h3><img src="http://fiximage.10x10.co.kr/web2018/xmas2018/tit_xmas_evt.png" alt="Christmas Event"></h3>
				<ul>
                <% if Ubound(eventList) > 0 then %>                
                <%  dim clsIdx
				    clsIdx = 3
					for i = 0 to Ubound(eventList) - 1 
					if eventList(i).Frectangleimage = "" then
						clsIdx = clsIdx + 1
					else		
				%>
					<li  class="event-obj <%=chkIIF(i > clsIdx, "event-elmore", "")%>">
						<a href="/event/eventmain.asp?eventid=<%=eventList(i).Fevt_code%>" onclick="fnAmplitudeEventMultiPropertiesAction('click_2018christmas_event','idx|eventcode','<%=i+1%>|<%=eventList(i).Fevt_code%>')">
							<div class="thumbnail"><img src="<%=eventList(i).Frectangleimage%>" alt="" />                                
                                <%=chkIIF(eventList(i).Fsaleper <> "", "<em class=""discount"">~"&eventList(i).Fsaleper&"%</em>","") %>									
                            </div>
							<div class="desc">
								<p class="headline ellipsis"><%=cStr(Split(eventList(i).Fevt_name,"|")(0))%></p>
								<p class="subcopy ellipsis">                                    
                                    <!--<%=chkIIF(eventList(i).Fsalecper <> "", "<span class=""discount"">쿠폰 ~"&eventList(i).Fsalecper&"%</span>","") %>-->
                                <%=replace(eventList(i).Fevt_subcopy, "<br>", "")%></p>
							</div>
						</a>
					</li>
                	<% 
					end if		
					next 							
					%>	
                <% end if %>    				
				</ul>
				<% if Ubound(eventList) > 4 then %>
				<button class="btn-more event-more"><img src="http://fiximage.10x10.co.kr/web2018/xmas2018/btn_more.png" alt="더 보기" /></button>
				<% end if %>
			</div>
		</section>
		<% end if %>
		<!-- 카테고리별 아이템 -->
		<section class="xmas-item" id="xmas-item">
			<h3><img src="http://fiximage.10x10.co.kr/web2018/xmas2018/tit_item.jpg" alt="Christmas it-tem" /></h3>
            
			<div class="type">
				<ul>
					<li><input type="radio" value="-1" name="detailcode" id="전체" <%=chkIIF(detailcode = "-1","checked","")%> /><label for="전체"><img src="http://fiximage.10x10.co.kr/web2018/xmas2018/tab_type_all.jpg" alt="전체보기" /></label></li>
					<li><input type="radio" value=10 name="detailcode" id="조명" <%=chkIIF(detailcode = 10,"checked","")%> /><label for="조명"><img src="http://fiximage.10x10.co.kr/web2018/xmas2018/tab_type_01.jpg" alt="조명" /></label></li>
					<li><input type="radio" value=20 name="detailcode" id="트리" <%=chkIIF(detailcode = 20,"checked","")%> /><label for="트리"><img src="http://fiximage.10x10.co.kr/web2018/xmas2018/tab_type_02.jpg" alt="트리&middot;리스" /></label></li>
					<li><input type="radio" value=30 name="detailcode" id="오너먼트" <%=chkIIF(detailcode = 30,"checked","")%> /><label for="오너먼트"><img src="http://fiximage.10x10.co.kr/web2018/xmas2018/tab_type_03.jpg" alt="오너먼트" /></label></li>
					<li><input type="radio" value=40 name="detailcode" id="캔들/디퓨져" <%=chkIIF(detailcode = 40,"checked","")%> /><label for="캔들/디퓨져"><img src="http://fiximage.10x10.co.kr/web2018/xmas2018/tab_type_04.jpg" alt="캔들&middot;디퓨저" /></label></li>
					<li><input type="radio" value=50 name="detailcode" id="선물" <%=chkIIF(detailcode = 50,"checked","")%> /><label for="선물"><img src="http://fiximage.10x10.co.kr/web2018/xmas2018/tab_type_05.jpg" alt="선물" /></label></li>
					<li><input type="radio" value=60 name="detailcode" id="카드" <%=chkIIF(detailcode = 60,"checked","")%> /><label for="카드"><img src="http://fiximage.10x10.co.kr/web2018/xmas2018/tab_type_06.jpg" alt="카드" /></label></li>
				</ul>
			</div>
			<form name="frm">            
				<input type="hidden" name="detailcode">
            </form>
			<div class="item-box">
				<div class="items type-thumb item-240">
					<ul>
					<% if oExhibition.FTotalCount > 0 then %>
					<% 
                    dim couponPrice, couponPer, tempPrice, salePer
                    dim saleStr, couponStr

					for i = 0 to oExhibition.FResultCount - 1 
                    couponPer = oExhibition.GetCouponDiscountStr(oExhibition.FItemList(i).Fitemcoupontype, oExhibition.FItemList(i).Fitemcouponvalue)
                    couponPrice = oExhibition.GetCouponDiscountPrice(oExhibition.FItemList(i).Fitemcoupontype, oExhibition.FItemList(i).Fitemcouponvalue, oExhibition.FItemList(i).Fsellcash)                    					
					salePer     = CLng((oExhibition.FItemList(i).Forgprice-oExhibition.FItemList(i).Fsellcash)/oExhibition.FItemList(i).FOrgPrice*100)
                    if oExhibition.FItemList(i).Fsailyn = "Y" and oExhibition.FItemList(i).Fitemcouponyn = "Y" then '세일
                        tempPrice = oExhibition.FItemList(i).Fsellcash - couponPrice
                        saleStr = "<span class=""discount color-red"">["&salePer&"%]</span>"
                        couponStr = "<span class=""discount color-green"">["&couponPer&"]</span>"  
                    elseif oExhibition.FItemList(i).Fitemcouponyn = "Y" then
                        tempPrice = oExhibition.FItemList(i).Fsellcash - couponPrice
                        saleStr = ""
                        couponStr = "<span class=""discount color-green"">["&couponPer&"]</span>"  
                    elseif oExhibition.FItemList(i).Fsailyn = "Y" then
                        tempPrice = oExhibition.FItemList(i).Fsellcash
                        saleStr = "<span class=""discount color-red"">["&salePer&"%]</span>"
                        couponStr = ""                                              
                    else
                        tempPrice = oExhibition.FItemList(i).Fsellcash
                        saleStr = ""
                        couponStr = ""                                              
                    end if					
					%>
						<li>
							<a href="/shopping/category_prd.asp?itemid=<%=oExhibition.FItemList(i).Fitemid%>" onclick="fnAmplitudeEventMultiPropertiesAction('click_2018christmas_item','itemid|category_name','<%=oExhibition.FItemList(i).Fitemid%>|<%=detailcodeName%>')">
								<span class="thumbnail"><img src="<%=oExhibition.FItemList(i).FImageList%>" alt=""></span>
								<span class="desc">
									<span class="brand"><%=oExhibition.FItemList(i).FbrandName%></span>
									<span class="name"><%=oExhibition.FItemList(i).Fitemname%></span>
									<span class="price">
										<span class="sum"><%=formatNumber(tempPrice, 0)%>원</span>
                                        <% response.write saleStr%>
                                        <% response.write couponStr%>										
									</span>
								</span>
							</a>
						</li>
					<% next %>	
					<% end if %>							
					</ul>
				</div>                
				<% if oExhibition.FTotalCount <> 0 then %>				
                <div class="pageWrapV15">
                    <%= fnDisplayPaging_New(page, oExhibition.FTotalCount,24,10,"jsGoPage") %>
                </div>		                
				<% end if %>
			</div>
		</section>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<form name="pageFrm" method="get" action="/christmas/2018/index.asp">
	<input type="hidden" name="pagereload" value="ON">
	<input type="hidden" name="page" value="<%=page%>">					
	<input type="hidden" name="detailcode" value="<%=detailcode%>">	
</form>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->
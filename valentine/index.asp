<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 2019 발렌타인데이 기획전
' History : 2019-01-17 최종원 생성
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
			Response.Redirect "http://m.10x10.co.kr/valentine/"
			REsponse.End
		end if
	end if
end if

Dim oExhibition, page
dim mastercode, detailcode, detailGroupList, pagereload, listType, bestItemList 
dim i

dim eventEndDate, currentDate, eventStartDate 

eventStartDate = cdate("2019-01-17")	'이벤트 시작일
eventEndDate = cdate("2019-02-15")		'이벤트 종료일
currentDate = date()

listType = "A"

IF application("Svr_Info") = "Dev" THEN
	mastercode = 7
Else
	mastercode = 2	
End If

detailcode =  requestCheckvar(request("detailcode"),10)
pagereload	= requestCheckVar(request("pagereload"),2)
page = requestCheckVar(request("page"),5)
if page = "" then page = 1

if detailcode = "" then detailcode = "10"

SET oExhibition = new ExhibitionCls
	oExhibition.FPageSize = 20
	oExhibition.FCurrPage = page
	oExhibition.FrectMasterCode = mastercode
	oExhibition.FrectDetailCode = detailcode
	oExhibition.FrectListType = listType

	oExhibition.getItemsPageListProc
	detailGroupList = oExhibition.getDetailGroupList(mastercode)		
	bestItemList = oExhibition.getItemsListProc( listType, 7, mastercode, "", "1", "" )     '리스트타입, row개수, 마스터코드, 디테일코드, best아이템 구분, 카테고리 정렬 구분 	
%>
</head>
<style>
@import url('https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css');
.valentine2019 {text-align:center; background-color:#ffdbc5; font-family:'Verdana', 'Nanum Barun Gothic', '나눔바른고딕', sans-serif;}
.valentine2019 button {background-color:transparent;}
.valen-head {position:relative; height:417px; background:url(//fiximage.10x10.co.kr/web2019/valentine/bg_tit_v2.jpg) repeat-x 50% 50%;}
.valen-head h2, .valen-head .sub, .valen-head a {position:absolute; top:83px; left:50%; margin-left:-220px;}
.valen-head .sub {top:316px; margin-left:-251px;}
.valen-head a {position:fixed; top:240px; z-index:10; margin-left:560px;}
.valen-vod {position:relative; height:616px; background:url(//fiximage.10x10.co.kr/web2019/valentine/bg_vod_v2.jpg) no-repeat 50% 50%;}
.valen-vod iframe {position:absolute; top:11px; left:50%; width:882px; height:539px; margin-left:-441px;}
.evt-list {padding:35px 0 105px; background:url(//fiximage.10x10.co.kr/web2019/valentine/bg_brown.png) repeat-x 50% 50%;}

.section {padding:65px 0 107px; background-image:url(//fiximage.10x10.co.kr/web2019/valentine/bg_cont.jpg); background-repeat:repeat-x; background-position:50% 0;}
.section .items.type-thumb.item-240 ul {margin:0 auto;}
.section .items.type-thumb.item-240 li {margin:0;}
.section .items.type-thumb.item-240 li a {text-decoration:none;}
.section .thumbnail {display:block;}
.section .desc {display:block; padding-top:12px;}
.section .desc .brand {display:block; font-size:12px; color:#111;}
.section .desc .name {display:block; padding-top:0; font-weight:400; font-size:14px; line-height:1.2; color:#111;}
.section .desc .price {display:block; margin-top:8px; font-weight:bold; font-size:14px; color:#000;}
.section .color-red {color:#ff4800 !important;}
.section .color-green {color:#3eb995 !important;}

.section1 .items {width:1140px; margin:0 auto; padding-top:227px; padding-bottom:12px; background-image:url(//fiximage.10x10.co.kr/web2019/valentine/bg_item_list_1.jpg);}
.section1 .items.type-thumb.item-240 ul {width:1008px;}
.section1 .items.type-thumb.item-240 li {width:230px; height:340px; padding:0 11px;}
.section1 .items.type-thumb.item-240 .thumbnail {height:230px;}

.section2 {padding-top:100px; background-image:url(//fiximage.10x10.co.kr/web2019/valentine/bg_yellow.png);}
.section2 .items {width:1072px; margin:60px auto 0; padding:58px 44px 58px; background-color:#fff;}
.section2 .items.type-thumb.item-240 li {height:410px; padding:0 14px;}

.section2 .type {width:1140px; margin:35px auto 70px;}
.section2 .type ul {display:inline-block; vertical-align:top;}
.section2 .type li {float:left; position:relative; width:115px; height:140px; padding:0 12px;}
.section2 .type li input {visibility:hidden; position:absolute; left:0; top:0; width:0; height:0;}
.section2 .type li label {display:block; position:relative; height:100%; cursor:pointer;}
.section2 .type li label span {display:inline-block;	width:100%; height:100%; background-image:url(//fiximage.10x10.co.kr/web2019/valentine/img_ctgry_name_v2.png); background-repeat:no-repeat; text-indent:-999em;}
.section2 .type li:nth-child(1) label span {background-position:0 100%;}
.section2 .type li:nth-child(2) label span {background-position:-138px 100%;}
.section2 .type li:nth-child(3) label span {background-position:-276px 100%;}
.section2 .type li:nth-child(4) label span {background-position:-413px 100%;}
.section2 .type li:nth-child(5) label span {background-position:-551px 100%;}
.section2 .type li:nth-child(6) label span {background-position:-689px 100%;}
.section2 .type li:nth-child(7) label span {background-position:100% 100%;}
.section2 .type li:nth-child(1) input:checked + label span {background-position:0 0;}
.section2 .type li:nth-child(2) input:checked + label span {background-position:-138px 0;}
.section2 .type li:nth-child(3) input:checked + label span {background-position:-276px 0;}
.section2 .type li:nth-child(4) input:checked + label span {background-position:-413px 0;}
.section2 .type li:nth-child(5) input:checked + label span {background-position:-551px 0;}
.section2 .type li:nth-child(6) input:checked + label span {background-position:-689px 0;}
.section2 .type li:nth-child(7) input:checked + label span {background-position:100% 0;}

.section2 .pageWrapV15 {top:-22px;}
.section2 .pageWrapV15 .pageMove {display:none;}
.section2 .paging {height:40px;}
.section2 .paging a {width:40px; height:40px; margin:0 10px; border:0; background-color:transparent;}
.section2 .paging a span {width:40px; height:40px; padding:0; color:#111; font:bold 15px/41px 'Roboto', 'Noto Sans KR', 'malgun Gothic', '맑은고딕', sans-serif;}
.section2 .paging a.first, .section .paging a.end {display:none;}
.section2 .paging a.arrow span {background-image:url(//fiximage.10x10.co.kr/web2018/diary2019/bg_arrow.png);}
.section2 .paging a.prev span {background-position:50% -4px;}
.section2 .paging a.next span {background-position:50% -34px}
.section2 .paging a.current {background-color:#ffb8f6; border-radius:50%;}

.gift {position:relative; padding:100px 0 65px; background-color:#965cff;}
.gift button {position:absolute; top:395px; left:50%; margin-left:115px;}
.gift .noti {position:relative; width:1098px; margin:0 auto; padding:38px 0; background-color:#7942dc; border-radius:20px}
.gift .noti p {position:absolute; top:50%; left:175px; margin-top:-9px;}
.gift .noti ul {width:100%; padding-left:320px; text-align:left;}
.gift .noti li {color:#fff; font-size:15px; line-height:2;}
</style>
<script>
$(function() {
	// skip to gift event
	$(".valen-head a").click(function(event){
	event.preventDefault();
	window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top},800);
	});

    $("input[name=detailcode]").click(function(e){        		
		// console.log(e.target.value)
        submitForm(e.target.value);
    });

	<% if pagereload <> "" then%>
	pagedown();
	<% end if %>    	
});
function submitForm(detailCodeVal){    
   var frm = document.frm
   frm.detailcode.value=detailCodeVal
   frm.method = "post"
   frm.action = "/valentine/index.asp?pagereload=ON" 
   frm.submit();
}
function pagedown(){	
	window.$('html,body').animate({scrollTop:$("#itemContainer").offset().top}, 0);
}
function jsGoPage(iP){
	document.pageFrm.page.value = iP;
	document.pageFrm.submit();
}
function jsEventLogin(){
	if(confirm("로그인을 하셔야 이벤트에 참여하실 수 있습니다.")){
		location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/valentine/index.asp")%>';
		return;
	}
}
function doAction(){
	<% if (eventStartDate > currentDate or eventEndDate < currentDate) and GetLoginUserLevel <> "7" then %>	
		alert("이벤트 참여기간이 아닙니다.");
		return false;
	<% end if %>				
    if ("<%=IsUserLoginOK%>"=="False") {
        jsEventLogin();
    }else{
		var str = $.ajax({
			type: "GET",
			url:"/event/etc/doeventsubscript/doEventSubscript91902.asp",
			data: "",
			dataType: "text",
			async: false
		}).responseText;	
		if(!str){alert("시스템 오류입니다."); return false;}
		var reStr = str.split("|");
		if(reStr[0]=="OK"){
            alert('응모 신청되었습니다.');				
            return false;
		}else{
			var errorMsg = reStr[1].replace(">?n", "\n");
			alert(errorMsg);
			return false;
		}
    }	
}
</script>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container valentine2019">
		<div class="valen-head">
            <h2><img src="//fiximage.10x10.co.kr/web2019/valentine/tit_valentine.gif" alt="난 너를 두근두근해"></h2>
			<p class="sub"><img src="//fiximage.10x10.co.kr/web2019/valentine/img_sub.png" alt="우리 사이처럼 달콤한 발렌타인데이 선물"></p>
			<a href="#gift" class="bnr"><img src="" alt=""><img src="//fiximage.10x10.co.kr/web2019/valentine/bnr_mkt_evt.png?v=1.01" alt="애플 워치  응모 이벤트"></a>
        </div>

		<div class="section section1">
			<!-- 동영상 -->
			<div class="valen-vod">
				<iframe src="https://www.youtube.com/embed/6lvRRY72z5s" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
			</div>
			<div class="items type-thumb item-240">
				<ul>
					<% if Ubound(bestItemList) > 0 then %>
                <%  
                    dim couponPrice, couponPer, tempPrice, salePer
                    dim saleStr, couponStr
                    
                    for i = 0 to Ubound(bestItemList) - 1                     
                    couponPer = oExhibition.GetCouponDiscountStr(bestItemList(i).Fitemcoupontype, bestItemList(i).Fitemcouponvalue)
                    couponPrice = oExhibition.GetCouponDiscountPrice(bestItemList(i).Fitemcoupontype, bestItemList(i).Fitemcouponvalue, bestItemList(i).Fsellcash)                    
                    salePer     = CLng((bestItemList(i).Forgprice-bestItemList(i).Fsellcash)/bestItemList(i).FOrgPrice*100)
                    if bestItemList(i).Fsailyn = "Y" and bestItemList(i).Fitemcouponyn = "Y" then '세일
                        tempPrice = bestItemList(i).Fsellcash - couponPrice
                        saleStr = "<span class=""discount color-red"">"&salePer&"%</span>"
                        couponStr = "<span class=""discount color-green"">"&couponPer&"</span>"  
                    elseif bestItemList(i).Fitemcouponyn = "Y" then
                        tempPrice = bestItemList(i).Fsellcash - couponPrice
                        saleStr = ""
                        couponStr = "<span class=""discount color-green"">"&couponPer&"</span>"  
                    elseif bestItemList(i).Fsailyn = "Y" then
                        tempPrice = bestItemList(i).Fsellcash
                        saleStr = "<span class=""discount color-red"">"&salePer&"%</span>"
                        couponStr = ""                                              
                    else
                        tempPrice = bestItemList(i).Fsellcash
                        saleStr = ""
                        couponStr = ""                                              
                    end if
                %>					
					<li>
						<a href="/shopping/category_prd.asp?itemid=<%=bestItemList(i).Fitemid%>" >
							<span class="thumbnail"><img src="<%=bestItemList(i).FImageList%>" alt=""></span>
							<span class="desc">
								<span class="name"><%=bestItemList(i).Fitemname%></span>
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
					<li>
						<a href="/event/eventmain.asp?eventid=91904" target="_blank">
							<img src="//fiximage.10x10.co.kr/web2019/valentine/txt_more.png" alt="" />
						</a>
					</li>
				</ul>
			</div>
		</div>

        <!-- 기획전 -->
        <div class="evt-list">
			<img src="//fiximage.10x10.co.kr/web2019/valentine/img_evt_list.jpg" alt="단거 말고 딴거" usemap="#map-evt">
			<map name="map-evt" id="map-evt">
				<area  alt="그저 평범한 운동화가 아니야" title="그저 평범한 운동화가 아니야" href="/event/eventmain.asp?eventid=91902" shape="rect" coords="114,242,551,628" onfocus="this.blur();" />
				<area  alt="이런 선물, 리스펙트!" title="이런 선물, 리스펙트!" href="/event/eventmain.asp?eventid=91903" shape="rect" coords="588,243,1024,628" onfocus="this.blur();" />
			</map>
		</div>

		<!-- 카테고리별아이템 -->
		<div class="section section2"  id="itemContainer">
			<h3><img src="http://fiximage.10x10.co.kr/web2019/valentine/tit_ctgry_item.png" alt="valentine items" /></h3>
			<div class="type">
				<ul>
				<% if Ubound(detailGroupList) > 0 then %>
					<% for i = 0 to Ubound(detailGroupList) - 1 %>
						<li>
							<input type="radio" value="<%=detailGroupList(i).Fdetailcode%>" name="detailcode" id="<%=detailGroupList(i).Fdetailcode%>" <%=chkIIF(Cint(detailcode) = Cint(detailGroupList(i).Fdetailcode),"checked","")%> />
								<label for="<%=detailGroupList(i).Fdetailcode%>">
									<span><%=detailGroupList(i).Ftitle%></span>
								</label>
						</li>
					<% next %>
				<% end if %>
				</ul>
			</div>
			<form name="frm">            
				<input type="hidden" name="detailcode">
            </form>			
			<div class="items type-thumb item-240">
				<ul>
				<% if oExhibition.FTotalCount > 0 then %>
				<% 				
				dim totalPrice , salePercentString , couponPercentString , totalSalePercent
				for i = 0 to oExhibition.FResultCount - 1

				call oExhibition.FItemList(i).fnItemPriceInfos(totalPrice , salePercentString , couponPercentString , totalSalePercent)
				%>				
					<li>
						<a href="/shopping/category_prd.asp?itemid=<%=oExhibition.FItemList(i).Fitemid%>" >
							<span class="thumbnail"><img src="<%=oExhibition.FItemList(i).FImageList%>" alt=""></span>
							<span class="desc">
								<span class="brand"><%=oExhibition.FItemList(i).FbrandName%></span>
								<span class="name"><%=oExhibition.FItemList(i).Fitemname%></span>
								<span class="price">
									<span class="sum"><%=formatNumber(totalPrice, 0)%>원</span>
									<% if salePercentString <> "0" then %><span class="discount color-red">[<%=salePercentString%>]</span><% end if%>
									<% if couponPercentString <> "0" then %><span class="discount color-green">[<%=couponPercentString%>]</span><% end if%>
								</span>
							</span>
						</a>
					</li>
					<% next %>					
					<% end if %>	
				</ul>
				<% if oExhibition.FTotalCount <> 0 then %>				
                <div class="pageWrapV15">
                    <%= fnDisplayPaging_New(page, oExhibition.FTotalCount,24,10,"jsGoPage") %>
                </div>		                
				<% end if %>
			</div>
		</div>

        <!-- 사은품응모 -->
        <div class="gift" id="gift">
			<div>
				<img src="//fiximage.10x10.co.kr/web2019/valentine/img_gift.jpg" alt="자, 내 선물이야! 사랑하는 사람에게 애플 워치를 선물하세요. 응모하신 분 중 추첨을 통해 1명에게 애플 워치 2대를 드립니다.">
				<button type="button" onclick="doAction();"><img src="//fiximage.10x10.co.kr/web2019/valentine/btn_submit.png" alt="응모하기"></button>
			</div>
			<div class="noti">
				<p><img src="//fiximage.10x10.co.kr/web2019/valentine/tit_noti.png" alt="유의사항"></p>
				<ul>
					<li>텐바이텐 고객에 한하여, ID 당 한 번만 참여 가능합니다.</li>
					<li>당첨자에게는 세무 신고에 필요한 개인 정보를 요청할 수 있습니다. (제세공과금은 텐바이텐 부담)</li>
					<li>당첨 상품 : Apple Watch Series 4 (GPS) 스페이스 그레이 알루미늄 케이스, </li>
					<li>블랙 스포츠 밴드 40mm, 44mm 각 1개</li>
				</ul>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<form name="pageFrm" method="get" action="/valentine/index.asp?pagereload=ON">
	<input type="hidden" name="pagereload" value="ON">
	<input type="hidden" name="page" value="<%=page%>">					
	<input type="hidden" name="detailcode" value="<%=detailcode%>">	
</form>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->
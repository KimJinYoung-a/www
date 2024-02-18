<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 2019 가정의달 기획전
' History : 2019-04-10 최종원 생성
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
			Response.Redirect "http://m.10x10.co.kr/event/family2019/"
			REsponse.End
		end if
	end if
end if

Dim oExhibition, page
dim mastercode, detailcode, detailGroupList, pagereload, listType, bestItemList 
dim numOfItems
dim couponPrice, couponPer, tempPrice, salePer
dim saleStr, couponStr
dim i, j  

listType = "A"
numOfItems = 16

IF application("Svr_Info") = "Dev" THEN
	mastercode = 7
Else
	mastercode = 6	
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
	bestItemList = oExhibition.getItemsListProc( listType, 100, mastercode, "", "1", "" )     '리스트타입, row개수, 마스터코드, 디테일코드, best아이템 구분, 카테고리 정렬 구분         
%>
</head>
<style>
.family2019 {position: relative;}
.family2019 button {background:none;}
.family2019 a .thumbnail img {position:relative; width: 100%; height: auto; z-index:2; opacity: 0.98;}
.family2019 .items .thumbnail:after {background-color: #000; border-radius: 16px 16px 0 0}
.family2019 .category1 .items .thumbnail:after {border-radius: 16px;}

.topic {position: relative; height: 480px; background: url(//webimage.10x10.co.kr/fixevent/event/2019/family2019/bg_top.jpg?v=1.04) center 0 #ffcece; text-align: center;}
.topic h2 {position: absolute; width: 598px; height: 420px; left: 50%; top: 33px; padding-top: 150px; margin-left: -299px; background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/family2019/img_top.png); background-repeat: no-repeat; opacity: 0; transition-duration: .8s; transform: scale(.99)}
.topic h2 img {opacity: 0;}
.topic > span {position: absolute; overflow: hidden; top: 321px; left: 50%; width: 0; margin-left: -264px; text-align: center; transform-origin:0 0; transirion}
.topic.on h2 {opacity: 1; transform: scale(1)}
.topic.on h2 img {opacity: 1; transition: 1.2s .2s; }
.topic.on > span {width: 513px; transition: 1s .9s; transition-timing-function: cubic-bezier(0, 0, 0, 1.03)}

.slick-slide {position:relative; display:block;  float:left; width:1140px; height:640px; outline:none; background-color:#000;}
.slick-slide img {opacity:.7; transition:.2s}
.slick-slide.slick-current img {opacity:1;}
.slick-arrow {position: absolute; top: 310px; left: 50%; height:65px; width: 35px; background: url(//webimage.10x10.co.kr/fixevent/event/2019/family2019/btn_prev.png) no-repeat 0 0 !important; outline: 0;  z-index:999; }
.slick-prev {margin-left: -530px;}
.slick-next {margin-left: 495px; transform: rotateY(180deg);} 

.bubble-area li {position: absolute; z-index: 999; }
.bubble-area li:before {content: ''; display: block; width: 130px; height: 130px; cursor: pointer; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/family2019/ico_point.png); animation: light 1.5s linear infinite}
.bubble-area li.prd-01 {top: 11px; left: 531px;}
.bubble-area li.prd-02 {top: 255px; left: 221px;}
.bubble-area li.prd-03 {top: 510px; left: 246px;}
.bubble-area li.prd-04 {top: 190px; left: 298px;}
.bubble-area li.prd-05 {top: 256px; left: 739px;}
.bubble-area li.prd-06 {top: 188px; left: 560px;}
.bubble-area li.prd-07 {top:423px; left: 412px;}
.bubble-area li.prd-08 {top:221px; left: 500px;}
.bubble-area li.prd-09 {top:157px; left: 330px;}
/* 스승의날 추가 */
.bubble-area li.prd-10 {top:502px; left: 506px;}
.bubble-area li.prd-11 {top:346px; left: 682px;}
.bubble-area li.prd-12 {top:107px; left: 148px;}
.bubble-area li.prd-13 {top:450px; left: 352px;}

.bubble-area li a {position: absolute; top:29px; left: 80px; width: 274px; height: 72px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/family2019/bg_bubble.png); transform: scale(0); transition:0; transform-origin:center left}
.bubble-area li:hover a { transform: scale(1); transition:.3s}
.bubble-area li a:hover {text-decoration: none;}
.bubble-area li a .thumbnail {display: inline-block; width: 56px; height: 56px; margin: 8px 10px 8px 14px; vertical-align: middle; background-color: #666;}
.bubble-area li a .desc {display: inline-block; width: calc(100% - 100px); height: 56px; padding-top: 14px; vertical-align: middle;}
.bubble-area li a .desc .brand {display: block; width: 100%; overflow: hidden; font-style: italic; font-family: 'Times New Roman', Times, serif;  font-size:14px; text-transform: uppercase; color: #666; text-overflow: ellipsis; white-space: nowrap;}
.bubble-area li a .desc .name {width: 100%; color: #222; font-size:14px; font-family: 'Roboto' , 'serif'; }

.section h3 {text-align: center;}
.section .items {width:1088px; margin:0 auto; }
.section .items.type-thumb li {margin:0 14px 30px; }
.section .items.type-thumb li a {text-decoration:none;}
.section .items.type-thumb li a .thumbnail {display:block; overflow:hidden; width:244px; height:244px; border-radius:13px;}
.section .items.type-thumb li a .desc {display:block; width: 244px; height: 115px; padding:15px; box-sizing: border-box;}
.section .items.type-thumb li a .desc .brand {display:block; font-size:12px; color:#111;}
.section .items.type-thumb li a .desc .name {display: -webkit-box; overflow: hidden; width:200px; height: 47px; padding-top:0;  -webkit-line-clamp: 2; -webkit-box-orient: vertical; text-overflow: ellipsis; word-break : break-all; white-space: unset; font: 14px/1.7 'AppleSDGothicNeo-Medium'; color:#666;}
@media screen and (-ms-high-contrast: active), (-ms-high-contrast: none) {
	.section .items.type-thumb li a .desc .name {display:block;}
}
.section .items.type-thumb li a .desc .price {display:block; margin-top:8px; font-family:verdana; font-weight:bold; font-size:16px; color:#222; }
.section .items.type-thumb li a .desc .price span {margin-right: 3px;}
.section .items.type-thumb li a .color-red {color:#ff4800 !important;}
.section .items.type-thumb li a .color-green {color:#3eb995 !important;}

.section1 {position: relative; width:100%; background-color: #ffeff0;}
.section1:before {content: ''; position: absolute; display: block; top: -22px; left: 50%; width: 0; height: 0; margin-left: -11px; border: 11px solid; border-color: transparent transparent #ffeff0 transparent;}
.section1 .btn-area {padding:28px 0 78px; text-align:center; }
.section1 .items {width: 1072px; }
.section1 .items.type-thumb li a {width:236px; height:351px; background-color:#FFF; border-radius: 13px; box-shadow: 2px 2px 1px 0px #0000000f;}
.section1 .items.type-thumb li a .thumbnail {width:236px; height: 236px; border-radius: 0}
.section1 ul.more-area {display: none;}

.category1 .type {width:1087px; margin: 0 auto; box-sizing: border-box;}
.category1 .type ul {width:1060px; height: 126px; overflow: hidden; margin: 0 auto 70px; *zoom:1} 
.category1 .type ul:after {display:block; clear:both; content:'';}
.category1 .type li {float:left; position:relative; margin-right: 11px;}
.category1 .type li:last-child {margin-right: 0;}
.category1 .type li input {visibility:hidden; position:absolute; left:0; top:66px; width:0; height:0;}
.category1 .type li label {display:block; position:relative; cursor:pointer;}
.category1 .type li input + label span {display:block; width:203px; height: 196px; background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/family2019/img_tab.jpg?v=1.01); text-indent:-999em;}
.category1 .type li:nth-child(1) input + label span {background-position:-41px 0;}
.category1 .type li:nth-child(2) input + label span {background-position:-255px 0;}
.category1 .type li:nth-child(3) input + label span {background-position:-469px 0;}
.category1 .type li:nth-child(4) input + label span {background-position:-683px 0;}
.category1 .type li:nth-child(5) input + label span {background-position:-897px 0;}
.category1 .type li input:checked + label span,
.category1 .type li input:hover + label span {background-position-y:-200px;}

.pageWrapV15 {top:-25px; margin-bottom: 80px;}
.pageWrapV15 .pageMove {display:none;}
.paging {height:40px; margin: 30px 0;}
.paging a {position: relative; height: 40px;  margin: 0 12px;  border:0; background-color:transparent;}
.paging a:hover {background-color: transparent;}
.paging a span {width: auto; height: 40px; padding:0; color:#aaa; font: 19px/41px verdana, sans-serif;}
.paging a.arrow {opacity: .4;}
.paging a.arrow span {width:20px; height:40px;  background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/family2019/btn_sm_prev.png); background-position: 0 7px;}
.paging a.next span {transform: rotateY(180deg);}
.paging a.next.arrow[onclick="jsGoPage(11);return false;"] {opacity: 1;}
.paging a.prev.arrow[onclick="jsGoPage(10);return false;"] {opacity: 1;}
.paging a.current {border: 0; color: #111; }
.paging a.current span {color: #111;}
.paging a.current span:after {content: ''; position: absolute; bottom: 4px; left: 0; width: 100%; height: 2px; background-color: #111;}
.paging a.end.arrow, .paging a.first.arrow {display: none;}
@keyframes light { 
	from,to {opacity:1;}
	50% {opacity:.6;}
}
</style>
<script type="text/javascript" src="/event/etc/json/js_applyItemInfo.js"></script>
<script>
$(function(){
	$('.topic').addClass('on')
	//롤링
	$('.slide1').slick({
		variableWidth: true,
		centerMode: true, 
		infinite:true,
		speed: 1400,
		autoplay: true,	
		autoplaySpeed: 4000,
		pauseOnHover: false,
	});
	$('.slide2').slick({
		variableWidth: true,
		centerMode: true, 
		infinite:true,
		speed: 1400,
		autoplay: true,	
		autoplaySpeed: 4000,
		pauseOnHover: false,
	});
	// 더보기
	$('.btn-more').click(function() {
		$(this).fadeOut()
		$(this).parent().prev('.more-area').slideDown()
	});
	//가격
	fnApplyItemInfoToTalPriceList({
		items:"2100115,2243850,1640748", 
		target:"itemList1",
		fields:["name","image","brand"],
	}); 
	fnApplyItemInfoToTalPriceList({
		items:"2278182,1037852", 
		target:"itemList2",
		fields:["name","image","brand"],
	}); 
	fnApplyItemInfoToTalPriceList({
		items:"2148688", 
		target:"itemList3",
		fields:["name","image","brand"],
	}); 
	fnApplyItemInfoToTalPriceList({
		items:"2318512", 
		target:"itemList4",
		fields:["name","image","brand"],
	}); 
	fnApplyItemInfoToTalPriceList({
		items:"2197604", 
		target:"itemList5",
		fields:["name","image","brand"],
	}); 
	fnApplyItemInfoToTalPriceList({
		items:"2272701", 
		target:"itemList6",
		fields:["name","image","brand"],
	});
	//스승의날추가
	fnApplyItemInfoToTalPriceList({
		items:"1693527", 
		target:"itemList7",
		fields:["name","image","brand"],
	});
	fnApplyItemInfoToTalPriceList({
		items:"2313734", 
		target:"itemList8",
		fields:["name","image","brand"],
	});
	fnApplyItemInfoToTalPriceList({
		items:"1948702", 
		target:"itemList9",
		fields:["name","image","brand"],
	});
	fnApplyItemInfoToTalPriceList({
		items:"2272796", 
		target:"itemList10",
		fields:["name","image","brand"],
	});
})
</script>
<script>
$(function() {
	<% if pagereload <> "" then%>
	pagedown();
	<% end if %>   
    $(".cont1 ul li:gt(7)").css('display','none');    
    $(".cont2 ul li:gt(7)").css('display','none');    
	// 더보기
	$('.btn-more').click(function() {
		$(this).fadeOut()
		$(this).parent().prev('.more-area').slideDown()
	});    
	$('.btn-more').click(function(e) { 
        var btnIdx = $(".btn-more").index($(this));        
        if(btnIdx == 0){            
            $(".cont1 ul li").slideDown()
            // $(".cont1 ul li").css('display','');
        }else{
            $(".cont2 ul li").slideDown()
            // $(".cont2 ul li").css('display','');    
        }
        $(this).hide();        
		// $(this).prev('.more-list').addClass('on');
		e.preventDefault();
	}); 
    $("input[name=detailcode]").click(function(e){        		
		// console.log(e.target.value)
        submitForm(e.target.value);
    });        	
});
function submitForm(detailCodeVal){    
   var frm = document.frm
   frm.detailcode.value=detailCodeVal
   frm.method = "post"
   frm.action = "/event/family2019/index.asp?pagereload=ON" 
   frm.submit();
}
function pagedown(){	
	window.$('html,body').animate({scrollTop:$("#itemContainer").offset().top}, 0);
}
function jsGoPage(iP){
	document.pageFrm.page.value = iP;
	document.pageFrm.submit();
}
</script>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<!-- 가정의 달 -->
	<div class="container family2019">
		<div class="topic">
			<h2><img src="//webimage.10x10.co.kr/fixevent/event/2019/family2019/tit_family.png?v=1.02" alt="종합 선물세트" /></h2>
			<span><img src="//webimage.10x10.co.kr/fixevent/event/2019/family2019/txt_top.png" alt="엄선한 가정의 달 선물 모음" /></span>
		</div>
		<!-- 수작업 -->
		<div class="slide1">
			<div>
				<img src="//webimage.10x10.co.kr/fixevent/event/2019/family2019/img_slide1_03.jpg" alt="" />
				<ul class="bubble-area items" id="itemList3">
					<li class="prd-06">
						<a href="/shopping/category_prd.asp?itemid=2148688">
							<div class="thumbnail"><img src="" alt="" /></div>
							<div class="desc">
								<p class="brand">brand</p>
								<p class="name">상품명</p>
							</div>
						</a> 
					</li>
				</ul>
			</div>
			<div>
				<img src="//webimage.10x10.co.kr/fixevent/event/2019/family2019/img_slide1_04.jpg" alt="" />
				<ul class="bubble-area items" id="itemList7">
					<li class="prd-10">
						<a href="/shopping/category_prd.asp?itemid=1693527">
							<div class="thumbnail"><img src="" alt="" /></div>
							<div class="desc">
								<p class="brand">brand</p>
								<p class="name">상품명</p>
							</div>
						</a> 
					</li>
				</ul>
			</div>
			<div>
				<img src="//webimage.10x10.co.kr/fixevent/event/2019/family2019/img_slide1_05.jpg" alt="" />
				<ul class="bubble-area items" id="itemList8">
					<li class="prd-11">
						<a href="/shopping/category_prd.asp?itemid=2313734">
							<div class="thumbnail"><img src="" alt="" /></div>
							<div class="desc">
								<p class="brand">brand</p>
								<p class="name">상품명</p>
							</div>
						</a> 
					</li>
				</ul>
			</div>
			<div>
				<img src="//webimage.10x10.co.kr/fixevent/event/2019/family2019/img_slide1_06.jpg" alt="" />
				<ul class="bubble-area items" id="itemList9">
					<li class="prd-12">
						<a href="/shopping/category_prd.asp?itemid=1948702">
							<div class="thumbnail"><img src="" alt="" /></div>
							<div class="desc">
								<p class="brand">brand</p>
								<p class="name">상품명</p>
							</div>
						</a> 
					</li>
				</ul>
			</div>
		</div>
		<!-- 지금 뜨는 인기선물 상품나열 8개 노출 더보기 누르면 8개 추가 노출 총 16개 노출-->
		<div class="section section1 cont1">
			<h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/family2019/tit_01.png" alt="지금 뜨는 인기선물" /></h3>
			<div class="items type-thumb">
            <% if Ubound(bestItemList) > 0 then %>
				<ul>
                <%
                    j = 0
                    for i = 0 to Ubound(bestItemList) - 1
                    if j = numOfItems then exit for '상품 갯수 제한      
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
                <%                            
                        if bestItemList(i).Fpicksorting <= 50  then                                                                    
                %>                
					<li>
						<a href="/shopping/category_prd.asp?itemid=<%=bestItemList(i).Fitemid%>">
							<span class="thumbnail"><img src="<%=bestItemList(i).FImageList%>" alt=""></span>
							<span class="desc">
								<span class="name"><%=bestItemList(i).Fitemname%></span>
								<span class="price ellipsis">
									<span class="sum"><%=formatNumber(tempPrice, 0)%>원</span>
									<% response.write saleStr%>
									<% response.write couponStr%>
								</span>
							</span>
						</a>
					</li>
                <%
                        j = j + 1 'index값 
                        else
                        end if
                %>                        
                <% next %>    
				</ul>
            <% end if %>    
				<div class="btn-area">
					<button class="btn-more" style="display:<%=chkIIF(j > 8, "","none")%>"><img src="//webimage.10x10.co.kr/fixevent/event/2019/family2019/btn_more.png" alt="상품 더보기" /></button>
				</div>
			</div>
		</div>
		<!-- 수작업 -->
		<div class="slide2">
			<div>
				<img src="//webimage.10x10.co.kr/fixevent/event/2019/family2019/img_slide2_01.jpg?v=1.01" alt="" />
				<ul class="bubble-area items" id="itemList4">
					<li class="prd-07">
						<a href="/shopping/category_prd.asp?itemid=2318512">
							<div class="thumbnail"><img src="" alt="" /></div>
							<div class="desc">
								<p class="brand">brand</p>
								<p class="name">상품명</p>
							</div>
						</a> 
					</li>
				</ul>
			</div>
			<div>
				<img src="//webimage.10x10.co.kr/fixevent/event/2019/family2019/img_slide2_02.jpg" alt="" />
				<ul class="bubble-area items" id="itemList5">
					<li class="prd-08">
						<a href="/shopping/category_prd.asp?itemid=2197604">
							<div class="thumbnail"><img src="" alt="" /></div>
							<div class="desc">
								<p class="brand">brand</p>
								<p class="name">상품명</p>
							</div>
						</a> 
					</li>
				</ul>
			</div>
			<div>
				<img src="//webimage.10x10.co.kr/fixevent/event/2019/family2019/img_slide2_03.jpg" alt="" />
				<ul class="bubble-area items" id="itemList6">
					<li class="prd-09">
						<a href="/shopping/category_prd.asp?itemid=2272701">
							<div class="thumbnail"><img src="" alt="" /></div>
							<div class="desc">
								<p class="brand">brand</p>
								<p class="name">상품명</p>
							</div>
						</a> 
					</li>
				</ul>
			</div>
			<div>
				<img src="//webimage.10x10.co.kr/fixevent/event/2019/family2019/img_slide2_04.jpg" alt="" />
				<ul class="bubble-area items" id="itemList10">
					<li class="prd-13">
						<a href="/shopping/category_prd.asp?itemid=2272796">
							<div class="thumbnail"><img src="" alt="" /></div>
							<div class="desc">
								<p class="brand">brand</p>
								<p class="name">상품명</p>
							</div>
						</a> 
					</li>
				</ul>
			</div>
		</div>
		<!-- 센스있는 추천선물 상품나열 8개 노출 더보기 누르면 8개 추가 노출 총 16개 노출-->
		<div class="section section1 cont2">
			<h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/family2019/tit_02.png" alt="센스있는 추천선물" /></h3>
			<div class="items type-thumb">
                <% if Ubound(bestItemList) > 0 then %>                         
				<ul>
                <%  
                j = 0
                for i = 0 to Ubound(bestItemList) - 1   
                    if j = numOfItems then exit for '12개 상품만 노출                      
                    couponPer = oExhibition.GetCouponDiscountStr(bestItemList(i).Fitemcoupontype, bestItemList(i).Fitemcouponvalue)
                    couponPrice = oExhibition.GetCouponDiscountPrice(bestItemList(i).Fitemcoupontype, bestItemList(i).Fitemcouponvalue, bestItemList(i).Fsellcash)                    
                    salePer     = CLng((bestItemList(i).Forgprice-bestItemList(i).Fsellcash)/bestItemList(i).FOrgPrice*100)
                    if bestItemList(i).Fsailyn = "Y" and bestItemList(i).Fitemcouponyn = "Y" then '세일
                        tempPrice = bestItemList(i).Fsellcash - couponPrice
                        saleStr = "<b class=""discount color-red"">"&salePer&"%</b>"
                        couponStr = "<b class=""discount color-green"">"&couponPer&"</b>"  
                    elseif bestItemList(i).Fitemcouponyn = "Y" then
                        tempPrice = bestItemList(i).Fsellcash - couponPrice
                        saleStr = ""
                        couponStr = "<b class=""discount color-green"">"&couponPer&"</b>"  
                    elseif bestItemList(i).Fsailyn = "Y" then
                        tempPrice = bestItemList(i).Fsellcash
                        saleStr = "<b class=""discount color-red"">"&salePer&"%</b>"
                        couponStr = ""                                              
                    else
                        tempPrice = bestItemList(i).Fsellcash
                        saleStr = ""
                        couponStr = ""                                              
                    end if
                %>            
                <%                            
                        if bestItemList(i).Fpicksorting > 50  then                            
                %>                            
					<li>
						<a href="/shopping/category_prd.asp?itemid=<%=bestItemList(i).Fitemid%>">
							<span class="thumbnail"><img src="<%=bestItemList(i).FImageList%>" alt=""></span>
							<span class="desc">
								<span class="name"><%=bestItemList(i).Fitemname%></span>
								<span class="price ellipsis">
									<span class="sum"><%=formatNumber(tempPrice, 0)%>원</span>
									<% response.write saleStr%>
									<% response.write couponStr%>
								</span>
							</span>
						</a>
					</li>
                <%
                        j = j + 1 'index값 
                        else
                        end if
                %>                                            
                <% next %>                                    
				</ul>                
            <% end if %>    
				<div class="btn-area">
					<button class="btn-more" style="display:<%=chkIIF(j > 8, "","none")%>"><img src="//webimage.10x10.co.kr/fixevent/event/2019/family2019/btn_more.png" alt="상품 더보기" /></button>
				</div>
			</div>
		</div>
		<!-- 상품나열 카테고리별 아이템 20개 노출-->
		<div class="section category1" id="itemContainer">
			<h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/family2019/tit_category.jpg?v=1.01" alt="다섯가지 선물 키워드" /></h3>
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
			<div class="items type-thumb">
            <% if oExhibition.FTotalCount > 0 then %>
				<ul>				
                    <% 
                    for i = 0 to oExhibition.FResultCount - 1 
                    couponPer = oExhibition.GetCouponDiscountStr(oExhibition.FItemList(i).Fitemcoupontype, oExhibition.FItemList(i).Fitemcouponvalue)
                    couponPrice = oExhibition.GetCouponDiscountPrice(oExhibition.FItemList(i).Fitemcoupontype, oExhibition.FItemList(i).Fitemcouponvalue, oExhibition.FItemList(i).Fsellcash)                    					
                    salePer     = CLng((oExhibition.FItemList(i).Forgprice-oExhibition.FItemList(i).Fsellcash)/oExhibition.FItemList(i).FOrgPrice*100)
                    if oExhibition.FItemList(i).Fsailyn = "Y" and oExhibition.FItemList(i).Fitemcouponyn = "Y" then '세일
                        tempPrice = oExhibition.FItemList(i).Fsellcash - couponPrice
                        saleStr = "<span class=""discount color-red"">"&salePer&"%</span>"
                        couponStr = "<span class=""discount color-green"">"&couponPer&"</span>"  
                    elseif oExhibition.FItemList(i).Fitemcouponyn = "Y" then
                        tempPrice = oExhibition.FItemList(i).Fsellcash - couponPrice
                        saleStr = ""
                        couponStr = "<span class=""discount color-green"">"&couponPer&"</span>"  
                    elseif oExhibition.FItemList(i).Fsailyn = "Y" then
                        tempPrice = oExhibition.FItemList(i).Fsellcash
                        saleStr = "<span class=""discount color-red"">"&salePer&"%</span>"
                        couponStr = ""                                              
                    else
                        tempPrice = oExhibition.FItemList(i).Fsellcash
                        saleStr = ""
                        couponStr = ""                                              
                    end if					
                    %>                
					<li>
						<a href="/shopping/category_prd.asp?itemid=<%=oExhibition.FItemList(i).Fitemid%>">
							<span class="thumbnail"><img src="<%=oExhibition.FItemList(i).FImageList%>" alt=""></span>
							<span class="desc">
								<span class="name"><%=oExhibition.FItemList(i).Fitemname%></span>
								<span class="price ellipsis">
									<span class="sum"><%=formatNumber(tempPrice, 0)%>원</span>
									<% response.write saleStr%>
									<% response.write couponStr%>	
								</span>
							</span>
						</a>
					</li>			                 
                    <% next %>					                    
				</ul>					
                <% end if %>	                
				<% if oExhibition.FTotalCount <> 0 then %>				
                <div class="pageWrapV15">
                    <%= fnDisplayPaging_New(page, oExhibition.FTotalCount,24,10,"jsGoPage") %>
                </div>		                
				<% end if %>
			</div>
		</div>
	</div>
	<!-- // 가정의 달 -->
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<form name="pageFrm" method="get" action="/event/family2019/index.asp?pagereload=ON">
	<input type="hidden" name="pagereload" value="ON">
	<input type="hidden" name="page" value="<%=page%>">					
	<input type="hidden" name="detailcode" value="<%=detailcode%>">	
</form>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->
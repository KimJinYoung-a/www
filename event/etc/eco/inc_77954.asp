<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 에코백 시리즈 5월
' History : 2017-07-19 유태욱 생성
'####################################################
%>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<%
dim oItem, itemid
dim currenttime
	currenttime =  now()
'	currenttime = #05/20/2017 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66398
Else
	eCode   =  77954
End If

%>
<style type="text/css">
.ecoBag {width:1140px; margin:0 auto; background-color:#fff;}
.ecoBag h2 {padding:90px 0 50px;}
.ecoBag iframe {width:1140px; height:74px; vertical-align:top;}
.ecoBag .discount {visibility:hidden;}
.main {position:relative; padding-top:47px;}
.main a {display:block; position:absolute; bottom:0; right:0; width:170px; height:35px; padding:30px; text-indent:-999em;}
.intro {padding:108px 0 80px; }

.section {overflow:hidden;}
.section a {text-decoration:none;}
.section .prdTxt {text-align:left;}
.section .prdTxt .info {padding:23px 0 44px;}
.section .prdTxt .only2week {visibility:hidden;}
.section .prdTxt .price {padding-bottom:50px;}
.section .prdTxt .price span {font-size:17px; color:#000; font-family:'Arial';}
.section .prdTxt .price .normal {padding-right:20px; font-size:15px;color:#868686; text-decoration:line-through;}
.section .prdTxt .price .sale {font-weight:bold; color:#df4b4b;}
.section1 .prdImg {float:left; position:relative; margin-left:76px;}
.section1 .prdImg .discount { position:absolute; top:172px; right:150px;}
.section1 .prdTxt {padding:33px 0 0 756px;}
.section2 {margin-top:92px;}
.section2 .prdTxt {padding:56px 76px 76px;}
.section2 .rolling1{float:right; position:relative; padding-right:76px;}
.section2 .rolling1 .swiper-container {overflow:hidden; width:571px; height:480px;}
.section2 .rolling1  .slideWrap {position:relative;}
.section2 .rolling1 .btnNav {display:block; position:absolute; bottom:150px; right:24px; width:16px; height:8.5px; text-indent:-9999em; background:transparent url(http://webimage.10x10.co.kr/eventIMG/2017/75327/btn_nav_v2.png) no-repeat 0 0;}
.section2 .rolling1 .btnNext {bottom:30px; background-position:100% 100%}
.section2 .rolling1 .pagination {position:absolute; bottom:36px; right:27px; z-index:50; }
.section2 .rolling1 .pagination span {display:block; width:10px; height:11px; margin:20px 0; background:url(http://webimage.10x10.co.kr/eventIMG/2017/75327/btn_pagination.png) 0 100% no-repeat; cursor:pointer; transition:0.5s all;}
.section2 .rolling1 .pagination .swiper-active-switch {background-position:100% 0;}
.section2 .rolling1 .discount {position:absolute; top:166px; right:222px; z-index:50;}

.brandStory {padding-top:140px;}
.brandStory ul {overflow:hidden; padding-top:22px;}
.brandStory ul li{float:left; position:relative;}
.brandStory ul li span {opacity:0; position:absolute; top:0; left:0;  transition:all 0.6s;}
.brandStory ul li:hover span {opacity:1;}
.brandStory ul li:first-child + li {margin:0 18px;}

.collabo {padding:90px 0;}
.gallery .rolling2 .swiper-container {overflow:hidden; width:1140px; height:640px;}
.gallery .rolling2  .slideWrap {position:relative;}
.gallery .rolling2 .btnNav {display:block; position:absolute; bottom:209px; right:24px; width:16px; height:8.5px; text-indent:-9999em; background:transparent url(http://webimage.10x10.co.kr/eventIMG/2017/75327/btn_nav_v2.png) no-repeat 0 0;}
.gallery .rolling2 .btnNext {bottom:30px; background-position:100% 100%}
.gallery .rolling2 .pagination {position:absolute; bottom:36px; right:27px; z-index:50; }
.gallery .rolling2 .pagination span {display:block; width:10px; height:11px; margin:20px 0; background:url(http://webimage.10x10.co.kr/eventIMG/2017/75327/btn_pagination.png) 0 100% no-repeat; cursor:pointer; transition:0.5s all;}
.gallery .rolling2 .pagination .swiper-active-switch {background-position:100% 0;}

.interview h3 {padding:123px 0 90px;}
.interview {padding-bottom:100px;}
</style>
</head>
<script type="text/javascript">
$(function(){
        /* swiper */
        var mySwiper1 = new Swiper('#rolling1 .swiper-container',{
                mode:'vertical',
                loop:true,
                resizeReInit:true,
                calculateHeight:true,
                pagination:'#rolling1 .pagination',
                paginationClickable:true,
                speed:1200,
                autoplay:2000
        });
        $('#rolling1 .btnPrev').on('click', function(e){
                e.preventDefault()
                mySwiper1.swipePrev()
        });
        $('#rolling1 .btnNext').on('click', function(e){
                e.preventDefault()
                mySwiper1.swipeNext()
        });

        /* swiper */
        var mySwiper2 = new Swiper('#rolling2 .swiper-container',{
                mode:'vertical',
                loop:true,
                resizeReInit:true,
                calculateHeight:true,
                pagination:'#rolling2 .pagination',
                paginationClickable:true,
                speed:1200,
                autoplay:2000
        });
        $('#rolling2 .btnPrev').on('click', function(e){
                e.preventDefault()
                mySwiper2.swipePrev()
        });
        $('#rolling2 .btnNext').on('click', function(e){
                e.preventDefault()
                mySwiper2.swipeNext()
        });
});
</script>
<div class="evt77954 ecoBag">

        <h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/tit_ecobag.png" alt="월간 에코백" /></h2>
        <iframe id="iframe_ecobag" src="/event/etc/group/iframe_ecobag.asp?eventid=77954" width="1140" height="74" frameborder="0" scrolling="no" title="월간 에코백 메뉴"></iframe>

        <div class="main">
                <img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/img_ithinkso.jpg" alt="#5월호 ithinkso 나도그렇게 생각해" />
                <a href="#groupBar4">코멘트 남기러가기</a>
        </div>

        <div class="intro">
                <img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/txt_brand.png" alt="이번 텐바이텐에서 소개하는 에코백은 아이띵소와 함께 했습니다. 항상 가방속이 복잡한 그대를 위해 가볍고 편한 에코백에 수납력을 더했어요. 더운 여름에 더욱 상쾌하게 느껴지는 린넨 재질로 시원함을 주며 일상을 함께 하고싶은 에코백 입니다. 텐바이텐 X 아이띵소 콜라보 상품을 만나보세요! " />
        </div>

		<%
			IF application("Svr_Info") = "Dev" THEN
				itemid = 1239226
			Else
				itemid = 1702337
			End If
			set oItem = new CatePrdCls
				oItem.GetItemData itemid
		%>
        <div class="section1 section">
                <div class="prdImg">
                        <img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/img_prd.jpg" alt="" />
                        <span class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/txt_15_percent.png" alt="15%할인" /></span>
                </div>
                <a href="/shopping/category_prd.asp?itemid=1702337&pEtr=77954">
                <div class="prdTxt">
                        <p class="only2week"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/txt_only_2week.png" alt="5.17 ~ 5.30  단 2주간 단독특가" /></p>
                        <p class="info"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/txt_prd_info_1.png" alt="텐바이텐 단독 TWIN BAG _ HAY" /></p>
                        <p class="price">
						<% If oItem.FResultCount > 0 Then %>
							<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
								<span class="normal"><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></span>
								<span class="sale"><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</span>
							<% Else %>
								<span class="normal"><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></span>
							<% End If %>
						<% End If %>
                        </p>
                        <p class="viewMore"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/txt_view_more.png" alt="VIEW MORE" /></p>
                </div>
                </a>
        </div>
		<%	set oItem = nothing %>

		<%
			IF application("Svr_Info") = "Dev" THEN
				itemid = 1239226
			Else
				itemid = 1701897
			End If
			set oItem = new CatePrdCls
				oItem.GetItemData itemid
		%>
        <div class="section2 section">
                <div id="rolling1" class="rolling rolling1">
                        <div class="slideWrap">
                                <div class="swiper-container">
                                        <div class="swiper-wrapper"> 
                                                <div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1701897&pEtr=77954"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/img_slide_1_1.jpg" alt="TWIN BAG _ HAY" /></a></div>
                                                <div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1701897&pEtr=77954"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/img_slide_1_2.jpg" alt="TWIN BAG _ HAY" /></a></div>
                                                <div class="swiper-slide"><a href="/shopping/category_prd.asp?itemid=1701897&pEtr=77954"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/img_slide_1_3.jpg" alt="TWIN BAG _ HAY" /></a></div>
                                        </div>
                                        <div class="pagination"></div>
                                </div>
                                <button type="button" class="btnNav btnPrev">이전</button>
                                <button type="button" class="btnNav btnNext">다음</button>
                        </div>
                        <span class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/txt_15_percent.png" alt="15%할인" /></span>
                </div>
                <a href="/shopping/category_prd.asp?itemid=1701897&pEtr=77954">
                <div class="prdTxt">
                        <p class="only2week"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/txt_only_2week.png" alt="5.17 ~ 5.30  단 2주간 단독특가" /></p>
                        <p class="info"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/txt_prd_info_2.png" alt="텐바이텐 단독 TWIN BAG _ HAY" /></p>
                        <p class="price">
						<% If oItem.FResultCount > 0 Then %>
							<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
								<span class="normal"><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></span>
								<span class="sale"><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</span>
							<% Else %>
								<span class="sale"><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></span>
							<% End If %>
						<% End If %>
                        </p>
                        <p class="viewMore"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/txt_view_more.png" alt="VIEW MORE" /></p>
                </div>
                </a>
        </div>
        <%	set oItem = nothing %>

        <div class="brandStory">
                <img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/txt_brand_story.jpg" alt="무심코 지나치는 사소한 순간들 그 순간들이 모여 하루의 대부분이 되고, 그 하루들이 모여 소중한 삶이 되는 것을 알고 있기에 우리는 늘 당신의 순간에 집중합니다. 언제나 곁을 지켜주는 오랜친구처럼 평범하지만 특별한 오늘과 내일을 함께하길 바랍니다." />
                <ul>
                        <li>
                                <img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/txt_brand_1.jpg" alt="#일상" />
                                <span><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/txt_brand_1_on.jpg" alt="" /></span>
                        </li>
                        <li>
                                <img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/txt_brand_2.jpg" alt="#수납" />
                                <span><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/txt_brand_2_on.jpg" alt="" /></span>
                        </li>
                        <li>
                                <img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/txt_brand_3.jpg" alt="#컬러" />
                                <span><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/txt_brand_3_on.jpg" alt="" /></span>
                        </li>
                </ul>
        </div>

        <p class="collabo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/txt_tenbyten_ithinkso.png" alt="tenbyten 콜라보 ithinkso" /></p>
        <div class="gallery">
                <div id="rolling2" class="rolling rolling2">
                        <div class="slideWrap">
                                <div class="swiper-container">
                                        <div class="swiper-wrapper">
                                                <div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/img_slide_2_1.jpg" alt="" /></div>
                                                <div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/img_slide_2_2.jpg" alt="" /></div>
                                                <div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/img_slide_2_3.jpg" alt="" /></div>
                                                <div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/img_slide_2_4.jpg" alt="" /></div>
                                                <div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/img_slide_2_5.jpg" alt="" /></div>
                                        </div>
                                        <div class="pagination"></div>
                                </div>
                                <button type="button" class="btnNav btnPrev">이전</button>
                                <button type="button" class="btnNav btnNext">다음</button>
                        </div>
                </div>
        </div>

        <div class="interview">
                <h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/tit_interview.png" alt="아이띵소와 이야기를 나누고 싶어요" /></h3>
                <img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/txt_interview.png" alt="Q1.아이띵소에게 에코백이란? 누구나 장소와 용도에 상관없이 편안하게 사용을 할 수 있는 가방 Q2. 신제품 출시할 때 주로 어디에서 영감을 받으시나요?늘 주변을 살피고 사람들의 생활 패턴에 대해 고민.Q3 이번 신상 런칭하신 상품의 장점이 궁금해요그 시즌의 기분을 내면서도 과하지 않게 오래 쓸 수 있는 가방 Q4마지막으로 아이띵소를 사랑하는 고객님들께 한마디 해주세요 모든 분들이 사용하면 할수록 더 만족하게 되는 경험" />
        </div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->
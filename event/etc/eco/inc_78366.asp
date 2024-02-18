<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 에코백 시리즈 6월
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
	eCode   =  66398	'<< 5월 테섭 이벤트코드임
Else
	eCode   =  78366
End If

%>
<style type="text/css">
.ecoBag {width:1140px; margin:0 auto; background-color:#fff;}
.ecoBag h2 {padding:90px 0 50px;}
.ecoBag iframe {width:1140px; height:74px; vertical-align:top;}
.main {position:relative; padding-top:47px;}
.main a {display:block; position:absolute; bottom:0; right:0;}
.intro {padding:108px 0 95px; }

.itemInfo {position:relative; height:480px; margin-bottom:12px; text-align:left;}
.itemInfo > a {display:block; height:480px; text-decoration:none;}
.itemInfo .prdImg {position:absolute; top:0;}
.itemInfo .prdImg span {position:absolute; left:0; top:0; opacity:0; transition:all .4s;}
.itemInfo a:hover .prdImg span {opacity:1;}
.itemInfo.type1 .prdImg {left:0;}
.itemInfo.type2 .prdImg {right:0;}
.itemInfo .prdTxt {padding:65px 0 0 648px;}
.itemInfo.type2 .prdTxt {padding-left:40px;}
.itemInfo .prdTxt .price {padding-top:30px; color:#868686; font-size:16px; font-family:arial;} 
.itemInfo .prdTxt .price strong {color:#df4b4b; padding-left:15px;}
.itemInfo .viewMore {padding-top:77px;}

.brandStory {padding-top:180px;}
.brandStory ul {overflow:hidden; margin:0 -6px; padding-bottom:14px;}
.brandStory ul li{float:left; position:relative; margin:0 6px;}
.brandStory ul li span {opacity:0; position:absolute; top:0; left:0;  transition:all 0.6s;}
.brandStory ul li:hover span {opacity:1;}

.collabo {padding:90px 0;}
.gallery .rolling .swiper-container {overflow:hidden; width:1140px; height:640px;}
.gallery .rolling  .slideWrap {position:relative;}
.gallery .rolling .btnNav {display:block; position:absolute; bottom:209px; right:24px; width:16px; height:8.5px; text-indent:-9999em; background:transparent url(http://webimage.10x10.co.kr/eventIMG/2017/75327/btn_nav_v2.png) no-repeat 0 0;}
.gallery .rolling .btnNext {bottom:30px; background-position:100% 100%}
.gallery .rolling .pagination {position:absolute; bottom:36px; right:27px; z-index:50; }
.gallery .rolling .pagination span {display:block; width:10px; height:11px; margin:20px 0; background:url(http://webimage.10x10.co.kr/eventIMG/2017/75327/btn_pagination.png) 0 100% no-repeat; cursor:pointer; transition:0.5s all;}
.gallery .rolling .pagination .swiper-active-switch {background-position:100% 0;}

.interview h3 {padding:123px 0 90px;}
.interview {padding-bottom:100px;}
</style>
</head>
<script type="text/javascript">
$(function(){
        /* swiper */
        var mySwiper = new Swiper('#rolling .swiper-container',{
                mode:'vertical',
                loop:true,
                resizeReInit:true,
                calculateHeight:true,
                pagination:'#rolling .pagination',
                paginationClickable:true,
                speed:1200,
                autoplay:2000
        });
        $('#rolling .btnPrev').on('click', function(e){
                e.preventDefault()
                mySwiper.swipePrev()
        });
        $('#rolling .btnNext').on('click', function(e){
                e.preventDefault()
                mySwiper.swipeNext()
        });
});
</script>
<div class="evt78366 ecoBag">
        <h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/tit_ecobag.png" alt="월간 에코백" /></h2>
        <iframe id="iframe_ecobag" src="/event/etc/group/iframe_ecobag.asp?eventid=78366" width="1140" height="74" frameborder="0" scrolling="no" title="월간 에코백 메뉴"></iframe>

        <div class="main">
                <img src="http://webimage.10x10.co.kr/eventIMG/2017/78366/img_atticmermaid.jpg" alt="#6월호 Atticmermaid 매일 편하게 쓰는 천가방" />
                <a href="#groupBar3"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78366/btn_comment.png" alt="코멘트 남기러가기" /></a>
        </div>

        <div class="intro">
                <img src="http://webimage.10x10.co.kr/eventIMG/2017/78366/txt_brand.png" alt="이번 텐바이텐에서 소개하는 에코백은 아틱머메이드와 함께 했습니다. 항상 가방이 꽉 차는 준비가 철저한 당신. 필요한 것만 간편하게 챙기는 자유로운 당신.짐이 많은 날, 간편하게 외출하는 날. 그날에 따라 때에 맞는 에코백을 들 수 있어요.날마다 담는 물건과 메는 스타일이 다른 만큼, 다양하게 연출할 수 있도록 사용성의 폭을 넓힌 folding ecobag 을 소개합니다." />
        </div>

		<%
			IF application("Svr_Info") = "Dev" THEN
				itemid = 1239226
			Else
				itemid = 1725163
			End If
			set oItem = new CatePrdCls
				oItem.GetItemData itemid
		%>
        <div class="itemInfo type1">
                <a href="/shopping/category_prd.asp?itemid=1725163&pEtr=77954">
                        <div class="prdImg">
                                <img src="http://webimage.10x10.co.kr/eventIMG/2017/78366/img_item01_01.jpg" alt="" />
                                <span><img src="http://webimage.10x10.co.kr/eventIMG/2017/78366/img_item01_02.jpg" alt="" /></span>
                        </div>
                        <div class="prdTxt">
                                <p><img src="http://webimage.10x10.co.kr/eventIMG/2017/78366/txt_item_01.png" alt="folding ecobag _ White" /></p>
                                <p class="price">
									<% If oItem.FResultCount > 0 Then %>
										<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
	                                        <s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
	                                        <strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</strong>
										<% Else %>
											<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
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
				itemid = 1725175
			End If
			set oItem = new CatePrdCls
				oItem.GetItemData itemid
		%>
        <div class="itemInfo type2">
                <a href="/shopping/category_prd.asp?itemid=1725175&pEtr=77954">
                        <div class="prdImg">
                                <img src="http://webimage.10x10.co.kr/eventIMG/2017/78366/img_item02_01.jpg" alt="" />
                                <span><img src="http://webimage.10x10.co.kr/eventIMG/2017/78366/img_item02_02.jpg" alt="" /></span>
                        </div>
                        <div class="prdTxt">
                                <p><img src="http://webimage.10x10.co.kr/eventIMG/2017/78366/txt_item_02.png" alt="folding ecobag _ greenish" /></p>
                                <p class="price">
									<% If oItem.FResultCount > 0 Then %>
										<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
	                                        <s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
	                                        <strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</strong>
										<% Else %>
											<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
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
				itemid = 1725174
			End If
			set oItem = new CatePrdCls
				oItem.GetItemData itemid
		%>
        <div class="itemInfo type1">
                <a href="/shopping/category_prd.asp?itemid=1725174&pEtr=77954">
                        <div class="prdImg">
                                <img src="http://webimage.10x10.co.kr/eventIMG/2017/78366/img_item03_01.jpg" alt="" />
                                <span><img src="http://webimage.10x10.co.kr/eventIMG/2017/78366/img_item03_02.jpg" alt="" /></span>
                        </div>
                        <div class="prdTxt">
                                <p><img src="http://webimage.10x10.co.kr/eventIMG/2017/78366/txt_item_03.png" alt=" folding ecobag _ navy" /></p>
                                <p class="price">
									<% If oItem.FResultCount > 0 Then %>
										<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
	                                        <s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
	                                        <strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %> [<%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%]</strong>
										<% Else %>
											<strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
										<% End If %>
									<% End If %>
                                </p>
                                <p class="viewMore"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/txt_view_more.png" alt="VIEW MORE" /></p>
                        </div>
                </a>
        </div>
        <%	set oItem = nothing %>

        <div class="brandStory">
                <ul>
                        <li>
                                <img src="http://webimage.10x10.co.kr/eventIMG/2017/78366/txt_brand_01.jpg" alt="#숄더백" />
                                <span><img src="http://webimage.10x10.co.kr/eventIMG/2017/78366/txt_brand_01_on.jpg" alt="" /></span>
                        </li>
                        <li>
                                <img src="http://webimage.10x10.co.kr/eventIMG/2017/78366/txt_brand_02.jpg" alt="#크로스백" />
                                <span><img src="http://webimage.10x10.co.kr/eventIMG/2017/78366/txt_brand_02_on.jpg" alt="" /></span>
                        </li>
                        <li>
                                <img src="http://webimage.10x10.co.kr/eventIMG/2017/78366/txt_brand_03.jpg" alt="#컬러" />
                                <span><img src="http://webimage.10x10.co.kr/eventIMG/2017/78366/txt_brand_03_on.jpg" alt="" /></span>
                        </li>
                </ul>
                <div><img src="http://webimage.10x10.co.kr/eventIMG/2017/78366/txt_brand_story.jpg" alt="무심코 지나치는 사소한 순간들 그 순간들이 모여 하루의 대부분이 되고, 그 하루들이 모여 소중한 삶이 되는 것을 알고 있기에 우리는 늘 당신의 순간에 집중합니다. 언제나 곁을 지켜주는 오랜친구처럼 평범하지만 특별한 오늘과 내일을 함께하길 바랍니다." /></div>
        </div>

        <p class="collabo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78366/txt_tenbyren_atticmermaid.png" alt="tenbyten 콜라보 atticmermaid" /></p>
        <div class="gallery">
                <div id="rolling" class="rolling">
                        <div class="slideWrap">
                                <div class="swiper-container">
                                        <div class="swiper-wrapper">
                                                <div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78366/img_slide_01.jpg" alt="" /></div>
                                                <div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78366/img_slide_02.jpg" alt="" /></div>
                                                <div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78366/img_slide_03.jpg" alt="" /></div>
                                                <div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78366/img_slide_04.jpg" alt="" /></div>
                                                <div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78366/img_slide_05.jpg" alt="" /></div>
                                        </div>
                                        <div class="pagination"></div>
                                </div>
                                <button type="button" class="btnNav btnPrev">이전</button>
                                <button type="button" class="btnNav btnNext">다음</button>
                        </div>
                </div>
        </div>

        <div class="interview">
                <h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/78366/tit_interview.png" alt="아틱머메이드와 이야기를 나누고 싶어요" /></h3>
                <img src="http://webimage.10x10.co.kr/eventIMG/2017/78366/txt_interview.jpg" alt="" />
        </div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->
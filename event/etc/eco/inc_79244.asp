<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 에코백 시리즈 7월
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
	eCode   =  79244
End If

%>
<style type="text/css">
.ecoBag {width:1140px; margin:0 auto; background-color:#fff;}
.ecoBag h2 {padding:90px 0 50px;}
.ecoBag iframe {width:1140px; height:74px; vertical-align:top;}
.topic {position:relative; padding-top:47px;}
.topic a {display:block; position:absolute; bottom:0; right:0;}
.intro {padding:108px 0 95px; }

.itemInfo {position:relative; display:table; width:100%; margin-bottom:90px; text-align:left;}
.itemInfo > a {display:block; text-decoration:none;}
.itemInfo .prdImg {position:absolute; top:0; width:520px;}
.itemInfo .prdImg span {position:absolute; left:0; top:0; z-index:30; opacity:0; transition:all .4s;}
.itemInfo .prdImg .discount {position:absolute; left:50%; top:228px; z-index:40; width:60px; height:60px; margin-left:55px; font:bold 18px/60px arial; letter-spacing:1px; text-align:center; color:#fff; background-color:#d50c0c; border-radius:50%;}
.itemInfo a:hover .prdImg span {opacity:1;}
.itemInfo .prdTxt {display:table-cell; height:548px; padding-left:100px; vertical-align:middle;}
.itemInfo .prdTxt h3 {padding:22px 0 44px;}
.itemInfo .prdTxt .price {color:#868686; font-size:16px; font-family:arial;} 
.itemInfo .prdTxt .price strong {color:#df4b4b; padding-left:15px;}
.itemInfo.type1 {padding-left:520px;}
.itemInfo.type1 .prdImg {left:0;}
.itemInfo.type2 .prdImg {right:0;}
.itemInfo.type2 .prdTxt {padding-left:50px;}
.itemInfo .viewMore {padding-top:48px; line-height:11px;}

.brandStory {padding-top:50px;}
.brandStory ul {overflow:hidden; margin:0 -6px; padding-bottom:14px;}
.brandStory ul li{float:left; position:relative; margin:0 6px;}
.brandStory ul li span {opacity:0; position:absolute; top:0; left:0;  transition:all 0.6s;}
.brandStory ul li:hover span {opacity:1;}

.collabo {padding:90px 0;}
.gallery .rolling .slideWrap {position:relative;}
.gallery .rolling .swiper-container {overflow:hidden; width:1140px; height:640px;}
.gallery .rolling .btnNav {display:block; position:absolute; bottom:175px; right:24px; width:14px; height:20px; text-indent:-9999em; background:transparent url(http://webimage.10x10.co.kr/eventIMG/2017/79244/btn_nav.png) no-repeat 0 0;}
.gallery .rolling .btnNext {bottom:25px; background-position:100% 100%}
.gallery .rolling .pagination {position:absolute; bottom:36px; right:25px; z-index:50; }
.gallery .rolling .pagination span {display:block; width:8px; height:8px; margin:20px 0; border:2px solid #252525; border-radius:50%;background-color:transparent; cursor:pointer;}
.gallery .rolling .pagination .swiper-active-switch {background-color:#252525;}

.interview h3 {padding:123px 0 98px;}
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
<div class="evt79244 ecoBag">
        <h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/77954/tit_ecobag.png" alt="월간 에코백" /></h2>
        <iframe id="iframe_ecobag" src="/event/etc/group/iframe_ecobag.asp?eventid=79244" width="1140" height="74" frameborder="0" scrolling="no" title="월간 에코백 메뉴"></iframe>

        <div class="topic">
                <img src="http://webimage.10x10.co.kr/eventIMG/2017/79244/img_ww.jpg" alt="#7월호 WW 일상을 더욱 싱그럽게" />
                <a href="#groupBar1"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78366/btn_comment.png" alt="코멘트 남기러가기" /></a>
        </div>

        <div class="intro">
                <img src="http://webimage.10x10.co.kr/eventIMG/2017/79244/txt_intro.jpg" alt="이번 텐바이텐에서 소개하는 에코백은 W/W 와 함께했습니다. 매일 똑같은 색상의 에코백을 들었다면 내일은 활력을 주는 그린 색상의 에코백은 어떨까요? 작지만 알차게, 밋밋한 일상에 상쾌하고 싱그러운 느낌을 주는 에코백입니다. 싱그러운 하루를 보낼 그대의 일상을 함께 하고 싶습니다. " />
        </div>

        <!-- item -->

		<%
			IF application("Svr_Info") = "Dev" THEN
				itemid = 1239226
			Else
				itemid = 1750035
			End If
			set oItem = new CatePrdCls
				oItem.GetItemData itemid
		%>
        <div class="itemInfo type1">
                <a href="/shopping/category_prd.asp?itemid=1750035&pEtr=79244">
                        <div class="prdImg">
                                <img src="http://webimage.10x10.co.kr/eventIMG/2017/79244/img_item1_1.jpg" alt="" />
                                <span><img src="http://webimage.10x10.co.kr/eventIMG/2017/79244/img_item1_2.jpg" alt="" /></span>
								<% If oItem.FResultCount > 0 Then %>
									<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
                                		<em class="discount"><%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%</em>
									<% End If %>
								<% End If %>
                        </div>
                        <div class="prdTxt">
                                <p><img src="http://webimage.10x10.co.kr/eventIMG/2017/79244/txt_sale.png" alt="7.19 ~ 8.01  단 2주간 특가" /></p>
                                <h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/79244/txt_item_1.png" alt="LINEN MINI ECOBAG_GREEN" /></h3>
                                <p class="price">
									<% If oItem.FResultCount > 0 Then %>
										<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
	                                        <s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
	                                        <strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
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
				itemid = 1721433
			End If
			set oItem = new CatePrdCls
				oItem.GetItemData itemid
		%>
        <div class="itemInfo type2">
                <a href="/shopping/category_prd.asp?itemid=1721433&pEtr=79244">
                        <div class="prdImg">
                                <img src="http://webimage.10x10.co.kr/eventIMG/2017/79244/img_item2_1.jpg" alt="" />
                                <span><img src="http://webimage.10x10.co.kr/eventIMG/2017/79244/img_item2_2.jpg" alt="" /></span>
								<% If oItem.FResultCount > 0 Then %>
									<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
                                		<em class="discount"><%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%</em>
									<% End If %>
								<% End If %>
                        </div>
                        <div class="prdTxt">
                                <p><img src="http://webimage.10x10.co.kr/eventIMG/2017/79244/txt_sale.png" alt="7.19 ~ 8.01  단 2주간 특가" /></p>
                                <h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/79244/txt_item_2.png" alt="LINEN MINI ECOBAG_BEIGE" /></h3>
                                <p class="price">
									<% If oItem.FResultCount > 0 Then %>
										<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
	                                        <s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
	                                        <strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
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
				itemid = 1721438
			End If
			set oItem = new CatePrdCls
				oItem.GetItemData itemid
		%>
        <div class="itemInfo type1">
                <a href="/shopping/category_prd.asp?itemid=1721438&pEtr=79244">
                        <div class="prdImg">
                                <img src="http://webimage.10x10.co.kr/eventIMG/2017/79244/img_item3_1.jpg" alt="" />
                                <span><img src="http://webimage.10x10.co.kr/eventIMG/2017/79244/img_item3_2.jpg" alt="" /></span>
								<% If oItem.FResultCount > 0 Then %>
									<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
                                		<em class="discount"><%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%</em>
									<% End If %>
								<% End If %>
                        </div>
                        <div class="prdTxt">
                                <p><img src="http://webimage.10x10.co.kr/eventIMG/2017/79244/txt_sale.png" alt="7.19 ~ 8.01  단 2주간 특가" /></p>
                                <h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/79244/txt_item_3.png" alt="LINEN MINI ECOBAG_RED" /></h3>
                                <p class="price">
									<% If oItem.FResultCount > 0 Then %>
										<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
	                                        <s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
	                                        <strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
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
				itemid = 1721432
			End If
			set oItem = new CatePrdCls
				oItem.GetItemData itemid
		%>
        <div class="itemInfo type2">
                <a href="/shopping/category_prd.asp?itemid=1721432&pEtr=79244">
                        <div class="prdImg">
                                <img src="http://webimage.10x10.co.kr/eventIMG/2017/79244/img_item4_1.jpg" alt="" />
                                <span><img src="http://webimage.10x10.co.kr/eventIMG/2017/79244/img_item4_2.jpg" alt="" /></span>
								<% If oItem.FResultCount > 0 Then %>
									<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
                                		<em class="discount"><%= Format00(2, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) ) %>%</em>
									<% End If %>
								<% End If %>
                        </div>
                        <div class="prdTxt">
                                <p><img src="http://webimage.10x10.co.kr/eventIMG/2017/79244/txt_sale.png" alt="7.19 ~ 8.01  단 2주간 특가" /></p>
                                <h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/79244/txt_item_4.png" alt="LINEN MINI ECOBAG_BLUE" /></h3>
                                <p class="price">
									<% If oItem.FResultCount > 0 Then %>
										<% If (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice - oItem.Prd.FSellCash > 0) THEN %>
	                                        <s><%= FormatNumber(oItem.Prd.getOrgPrice,0) %></s>
	                                        <strong><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","won") %></strong>
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
                                <img src="http://webimage.10x10.co.kr/eventIMG/2017/79244/txt_brand_01.jpg" alt="#GREENERY" />
                                <span><img src="http://webimage.10x10.co.kr/eventIMG/2017/79244/txt_brand_01_on.jpg" alt="" /></span>
                        </li>
                        <li>
                                <img src="http://webimage.10x10.co.kr/eventIMG/2017/79244/txt_brand_02.jpg" alt="#SUMMER" />
                                <span><img src="http://webimage.10x10.co.kr/eventIMG/2017/79244/txt_brand_02_on.jpg" alt="" /></span>
                        </li>
                        <li>
                                <img src="http://webimage.10x10.co.kr/eventIMG/2017/79244/txt_brand_03.jpg" alt="#FRESH" />
                                <span><img src="http://webimage.10x10.co.kr/eventIMG/2017/79244/txt_brand_03_on.jpg" alt="" /></span>
                        </li>
                </ul>
                <div><img src="http://webimage.10x10.co.kr/eventIMG/2017/79244/txt_story.jpg" alt="Whenever, Wherever 언제 어디서나 함께 소통할 수 있는 디자인으로 편안하게 다가가는 감성 브랜드입니다. 우리는 자체디자인력을 바탕으로, 가방제작 20년 장인과 협업, 내구성 있는 제품과, 정직한 공정으로 디자인력과 생산력을 갖춘 믿을 수 있는 디자인브랜드입니다." /></div>
        </div>

        <p class="collabo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79244/txt_collabo.png" alt="tenbyten 콜라보 WW" /></p>
        <div class="gallery">
                <div id="rolling" class="rolling">
                        <div class="slideWrap">
                                <div class="swiper-container">
                                        <div class="swiper-wrapper">
                                                <div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79244/img_slide_1.jpg" alt="" /></div>
                                                <div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79244/img_slide_2.jpg" alt="" /></div>
                                                <div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79244/img_slide_3.jpg" alt="" /></div>
                                                <div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79244/img_slide_4.jpg" alt="" /></div>
                                        </div>
                                        <div class="pagination"></div>
                                </div>
                                <button type="button" class="btnNav btnPrev">이전</button>
                                <button type="button" class="btnNav btnNext">다음</button>
                        </div>
                </div>
        </div>

        <div class="interview">
                <h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/79244/tit_interview.png" alt="더블유더블유와 이야기를 나누고 싶어요" /></h3>
                <img src="http://webimage.10x10.co.kr/eventIMG/2017/79244/txt_interview_v1.jpg" alt="" />
        </div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->
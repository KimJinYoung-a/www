<%
    '// 키워드
    Dim BizSearchText, BizReSearchText
    BizSearchText = replace(requestCheckVar(request("rect"),100),"%27","") '현재 입력된 검색어
    BizReSearchText = RepWord(BizSearchText,"[^ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9.&%+\-\_\(\)\/\\\[\]\~\s]","")
%>
<div class="header-wrap anniv18 tenBiz">
	<div class="headerV18">
		<div class="inner">
            <div class="head-front">
                <div class="head-menu">
                    <div class="head-sm-menu">
                        <span></span>
                        <span></span>
                        <span></span>
                    </div>
                    <div class="head-sm-gnb">
                        <ul id="sm_gnb_category">
                        </ul>
                    </div>
                </div>
                <h1><a href="/biz/" onclick="fnAmplitudeEventMultiPropertiesAction('click_topmenu','type|landing_url','logo|<%=Request.ServerVariables("PATH_INFO")%>');">10X10</a></h1>
            </div>
            <div class="head-service">
                <div class="search-form">
                    <input id="b2bSearch" type="search" placeholder="텐바이텐 BIZ 상품 검색" onfocus="this.placeholder=''" onblur="this.placeholder='텐바이텐 BIZ 상품 검색'" value="<%=BizReSearchText%>"/>
                    <button type="submit" class="btn-search"><span class="icoV18">검색</span></button>
                </div>
            </div>
			<div class="head-util">
				<ul>
					<!-- 로그인 X -->
					<% If (Not IsUserLoginOK) Then %>
                        <li class="util-log">
                            <a href="/login/loginpage.asp">BIZ 로그인/회원가입</a>
                        </li>

                    <!-- 로그인 -->
                    <% Else %>
                        <li class="util-log">
                            <a href="/login/dologout.asp?backpath=/biz/" class="log-out">로그아웃</a>
                        </li>
                        <li class="util-user">
                            <a href="/my10x10/">마이텐바이텐<span class="bottom1"></span></a>
                        </li>
                    <% End If %>
					<li class="util-order"><a href="/my10x10/order/myorderlist.asp">주문/배송</a></li>
					<li class="util-cart">
						<a href="" onclick="TnGotoShoppingBag();fnAmplitudeEventMultiPropertiesAction('click_topmenu','type|landing_url','basket|<%=Request.ServerVariables("PATH_INFO")%>');return false;"><span class="icoV18"></span> 장바구니 <span id="ibgaCNT" name="ibgaCNT"><%= GetCartCount %></span><span class="arrow-bottom bottom1" id="basketDropIcon"></span></a>
						<!-- #include file="incHeaderShBag_2018.asp" -->
					</li>
				</ul>
			</div>
		</div>
	</div>
	<div class="gnb-wrap">
		<div class="gnbV18">
            <ul id="gnb_category" class="gnbListSlide">
            </ul>
            <!--
            <div class="gnb-notice-biz">
                <span>텐바이텐 BIZ</span>가 무엇인가요?
            </div>
            -->
		</div>
	</div>
</div>
<script>
    const b2bSearch = document.getElementById('b2bSearch');
    b2bSearch.addEventListener('keyup', function(e){
        if( e.keyCode === 13 ) {
            if( e.target.value.trim() !== '' )
                location.href = '/search/search_result.asp?rect=' + encodeURIComponent(e.target.value.trim());
        }
    });

    <% IF application("Svr_Info")="Dev" THEN %>
        const apiUrl =  '//testfapi.10x10.co.kr/api/web/v1/b2b/pc/category/depth1';
        //const apiUrl =  '//localhost:8080/api/web/v1/b2b/pc/category/depth1';
    <% ElseIf application("Svr_Info")="staging" Then %>
        const apiUrl =  '//stgfapi.10x10.co.kr/api/web/v1/b2b/pc/category/depth1';
    <% Else %>
        const apiUrl =  '//fapi.10x10.co.kr/api/web/v1/b2b/pc/category/depth1';
    <% End If %>

    const smGnbCategory = document.getElementById('sm_gnb_category');
    const gnbCategory = document.getElementById('gnb_category');
    // 햄버거 카테고리 리스트 HTML 생성
    function createSmGnbCategory(category) {
        return `<li><a href="/shopping/category_list.asp?disp=${category.category_code}">${category.category_name}</a></li>`;
    }
    // GNB 카테고리 리스트 HTML 생성
    function createGnbCategory(category) {
        return `<li><p><a href="/shopping/category_list.asp?disp=${category.category_code}">${category.category_name}</a></p></li>`;
    }

    $.ajax({
        type: 'get',
        url: apiUrl,
        ContentType: "json",
        crossDomain: true,
        xhrFields: {
            withCredentials: true
        },
        success: function(data){
            for( let i=0; i<data.categories.length ; i++ ) {
                $(smGnbCategory).append(createSmGnbCategory(data.categories[i]));
                $(gnbCategory).append(createGnbCategory(data.categories[i]));
            }
            setB2BCategoryGnb();
        }
    });

    function setB2BCategoryGnb() {
    	//GNB
    	$('.head-util ul li').mouseover(function() {
    		$(this).children('.util-layer').show();
    	});
    	$('.head-util ul li').mouseleave(function() {
    		$(this).children('.util-layer').hide();
    	});

    	$('.gnbV18 li').mouseover(function() {
    		$('.gnbV18 li').removeClass('on');
    		$(this).addClass('on');
    		$('.gnb-sub-wrap').show()
    			.mouseover(function() {$(this).show();})
    			.mouseleave(function() {$(this).hide();});
    		$('.gnb-sub').hide();
    		var subGnbId = $(this).attr('name');
    		$("div[class|='gnb-sub'][id|='"+ subGnbId +"']").show()
    		.mouseover(function() {
    			$(this).show();
    			$('.gnbV18 li[name="'+subGnbId+'"]').addClass('on');
    		})
    		.mouseleave(function() {
    			$(this).hide();
    			$('.gnbV18 li').removeClass('on');
    		});
    	});

    	$('.gnbV18 li').mouseleave(function() {
    		$(this).removeClass('on');
    		$('.gnb-sub-wrap').hide();
    	});
        // scroll 시작할때 gnb 플로팅
        var menu_offset = $('.header-wrap.tenBiz .gnb-wrap').offset();
        $(window).scroll(function() {
        if ($(document).scrollTop() > menu_offset.top) {
            $('.header-wrap.tenBiz').addClass('head-fixed');
            $('.biz-menu-bar').hide();
            $('.header-wrap.tenBiz .gnb-wrap').hide();
            $('.head-front .head-menu').show();
        } else {
            $('.header-wrap.tenBiz').removeClass('head-fixed');
            $('.biz-menu-bar').show();
            $('.header-wrap.tenBiz .gnb-wrap').show();
            $('.head-front .head-menu').hide();
            $('.head-sm-gnb').removeClass('on');
            }
        });

        // 축약된 gnb 메뉴 토글
        $('.head-sm-menu').on('click',function(){
            $('.head-sm-gnb').toggleClass('on');
        });

        // gnb slide
        const ul_width = gnbCategory.offsetWidth;
        let li_width_sum = -16;
        let li_show_count = 1; // 잘리기 전 갯수
        const gnb_li_list = gnbCategory.children;
        for( let i=0 ; i<gnb_li_list.length ; i++ ) {
            li_width_sum += gnb_li_list[i].offsetWidth + 32; // margin : 0 16px;
            if( li_show_count === 1 && li_width_sum > ul_width ) {
                li_show_count = i;
            }
        }

        var toScroll = $('.gnbListSlide li').length - li_show_count -1;

        if( ul_width < li_width_sum ) {
            $('.gnbListSlide').slick({
                dots:false,
                infinite:false,
                speed: 300,
                slidesToShow:li_show_count, // 잘리기 전 갯수
                slidesToScroll:toScroll > 0 ? toScroll : 1, // 전체 - 잘리기전갯수
                centerMode: false,
                variableWidth: true
            });
            // gnb slide 양버튼 노출/비노출
            var btnLeft = $('.gnbListSlide .slick-prev');
            var btnRight = $('.gnbListSlide .slick-next');
            btnLeft.hide();
            btnRight.show();

            $('.gnbListSlide .slick-next').on('click', function(){
                btnLeft.show();
                btnRight.hide();
            });

            $('.gnbListSlide .slick-prev').on('click', function(){
                btnLeft.hide();
                btnRight.show();
            });
        }

    }
</script>
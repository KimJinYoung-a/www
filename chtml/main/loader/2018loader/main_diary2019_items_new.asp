<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
response.charset = "utf-8"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/diarystory2019/lib/classes/diary_class_B.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
'#######################################################
' Discription : pc_main_diarystory2019_items // cache DB경유
' History : 2018-09-04 이종화 생성
'#######################################################

Dim gaParam : gaParam = "&gaparam=main_diarystorybest_" '//GA 체크 변수
Dim gaParamEvent : gaParamEvent = "&gaparam=main_diarystoryevent_" '//GA 체크 변수
dim gaParamDaccu : gaParamDaccu = "&gaparam=main_diarystorydaccu_"
dim bestlist , i , di , lp
dim oDaccuRanking , hoteventlist , sqlStr , vDate

'//DB 시간 타이머 00시부터 00시 5분 사이에는 DB 캐쉬 1분에 한번 읽기
Dim cTime , dummyName
If timer > 10 And Cint(timer/60) < 6 Then
	cTime = 60*1
	dummyName = "diaryBest"&Cint(timer/60)
Else
	cTime = 60*5
	dummyName = "diaryBest"
End If

' vDate
sqlStr = "SELECT MAX(rankdate) as maxRankDate FROM db_temp.dbo.tbl_DiaryDecoItemRanking"
rsget.CursorLocation = adUseClient
rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly
If Not rsget.EOF Then
    If left(Trim(rsget("maxRankDate")),10) <> Trim(vDate) Then
        vDate = left(Trim(rsget("maxRankDate")),10)
    End If
End if
rsget.close

' 다이어리 Pick 상품
'Set bestlist = new cdiary_list
    '아이템 리스트
'    bestlist.FPageSize = 8
'    bestlist.FCurrPage = 1
'    bestlist.fmdpick = "o"
'    bestlist.getDiaryAwardBest

' 다이어리 이벤트
set hoteventlist = new cdiary_list
    hoteventlist.FCurrPage  = 1
    hoteventlist.FPageSize	= 4
    hoteventlist.FselOp		= 0 '0 신규순 1 종료 임박 2 인기순
    hoteventlist.FEvttype   = "1"
    hoteventlist.Fisweb	 	= "0"
    hoteventlist.Fismobile	= "1"
    hoteventlist.Fisapp	 	= "1"
    hoteventlist.fnGetdievent

set oDaccuRanking = new cdiary_list
    oDaccuRanking.frecttoplimit = 8
    oDaccuRanking.FRectRankingDate = vDate
    oDaccuRanking.GetDiaryDaccuItemRanking

on Error Resume Next
If hoteventlist.FResultCount > 0 or oDaccuRanking.FResultCount > 0 Then
%>
<script src="/lib/js/jquery.tinyscrollbar.js"></script>
<script>
// 다이어리스토리
$(function() {
	$('.diary2019-list .rolling').slidesjs({
		height:85,
		navigation:{active:false},
		pagination:{active:false},
		play:{active:false, interval:1400, effect:"fade", auto:1400},
		effect:{fade:{speed:1200, crossfade:true}}
	});
	// rolling
	var evtSwiper = new Swiper('.main-diary-rolling .swiper-container',{
		loop:true,
		slidesPerView:'auto',
		loopedSlides:4,
		centeredSlides:true,
		speed:1400,
		autoplay:5000,
		pagination:'.main-diary-rolling .pagination',
		paginationClickable:true,
		nextButton:'.main-rolling .btn-nxt',
		prevButton:'.main-rolling .btn-prev'
	})
	$('.main-diary-rolling .btn-next').on('click', function(e){
		e.preventDefault();
		evtSwiper.swipeNext();
	});
	$('.main-diary-rolling .btn-prev').on('click', function(e){
		e.preventDefault();
		evtSwiper.swipePrev();
	});
	var bnrTit = ["다이어리 이벤트", "다꾸채널", "베스트 데코템"];
	$('.pagination span').text(function(i){
		return bnrTit[i];
	});

    // gift layer
    function diaryGiftSlide(){
        $('.gift-layer .slide').slidesjs({
            width:"670",
            height:"470",
            pagination:{active:true, effect:"fade"},
            navigation:false,
            play:{interval:1000, effect:"fade", auto:true},
            effect:{fade: {speed:1000, crossfade:true}
            },
            callback: {
                complete: function(number) {
                    var pluginInstance = $('.gift-layer .slide').data('plugin_slidesjs');
                    setTimeout(function() {
                        pluginInstance.play(true);
                    }, pluginInstance.options.play.interval);
                }
            }
        });
    }

    $('.btn-group span a').click(function(){
        diaryGiftSlide();
        $('.scrollbarwrap').tinyscrollbar();
    });
});
</script>
<div class="section diary2019-list">
    <div class="inner-cont">
        <div class="ftLt">
            <a href="/diarystory2019/?gaparam=main_diarystorybest_0">
                <h2><img src="http://fiximage.10x10.co.kr/web2018/diary2019/tit_main_diary.png" alt="2019 다이어리스토리" /></h2>
            </a>
        </div>
        <div class="btn-group">
            <% if date() > "2018-12-11" then %>
            <!--<div class="rolling ftRt">
                <span><a><img src="http://fiximage.10x10.co.kr/web2018/diary2019/img_diary_gift_1_v2.png" alt="스탠다드러브댄스 품절" /></a></span>
                <span><a><img src="http://fiximage.10x10.co.kr/web2018/diary2019/img_diary_gift_2_v2.png" alt="" /></a> </span>
                <span><a><img src="http://fiximage.10x10.co.kr/web2018/diary2019/img_diary_gift_3_v2.png" alt="" /></a> </span>
            </div>-->
            <% else %>
            <div class="ftLt" style="position:relative; top:-18px; left:20px"><img src="http://fiximage.10x10.co.kr/web2018/diary2019/img_diary_gift_1_snoopy.png" alt="스누피 스티커 증정 이벤트 중" /></div>
            <% end if %>
            <!--<a href="/diarystory2019#diary-gift"><span class="ftRt" style="margin-top:-5px;"><img src="http://fiximage.10x10.co.kr/web2018/diary2019/txt_free_delivery.png" alt="다이어리 스토리 속 다이어리 무료 배송" /></span></a>-->
        </div>
    </div>

    <div class="main-diary-rolling">
        <div class="swiper-container">
            <div class="swiper-wrapper">
                <%'!--// 추천 다이어리 --%>
                <!--div class="swiper-slide">
                    <div class="inner items type-thumb">
                        <ul>
                            <%
                            dim link , alink
                            For i = 0 To bestlist.FResultCount - 1

                            IF application("Svr_Info") = "Dev" THEN
                                bestlist.FItemList(i).FImageicon1 = left(bestlist.FItemList(i).FImageicon1,7)&mid(bestlist.FItemList(i).FImageicon1,12)
                            end if

                            link = "/shopping/category_prd.asp?itemid="&bestlist.FItemList(i).Fitemid
                            alink = link & gaparam & i+1
                            %>
                            <li>
                                <a href="<%=alink%>" onclick="fnAmplitudeEventAction('click_maindiarybest_views','bestitems','<%=bestlist.FItemList(i).FItemid%>');">
                                    <div class="thumbnail"><img src="<%= bestlist.FItemList(i).FDiaryBasicImg2 %>" alt="" /><em><%=i+1%></em><% if bestlist.FItemList(i).IsSoldOut then %><b class="soldout">일시 품절</b><% end if %></div>
                                    <div class="desc">
                                        <p class="name">
                                            <% If bestlist.FItemList(i).isSaleItem Or bestlist.FItemList(i).isLimitItem Then %>
                                                <%= chrbyte(bestlist.FItemList(i).FItemName,30,"Y") %>
                                            <% Else %>
                                                <%= bestlist.FItemList(i).FItemName %>
                                            <% End If %>
                                        </p>
                                        <div class="price">
                                            <% if bestlist.FItemList(i).IsSaleItem or bestlist.FItemList(i).isCouponItem Then %>
                                                <% IF bestlist.FItemList(i).IsCouponItem Then %>
                                                    <span class="discount color-green"><%=bestlist.FItemList(i).GetCouponDiscountStr%></span>
                                                    <span class="sum"><%=FormatNumber(bestlist.FItemList(i).GetCouponAssignPrice,0)%><span class="won">원</span></span>                                                
                                                <% else 'bestlist.FItemList(i).IsSaleItem then %>
                                                    <span class="discount color-red"><%=bestlist.FItemList(i).getSalePro%></span>
                                                    <span class="sum"><%=FormatNumber(bestlist.FItemList(i).getRealPrice,0)%><span class="won">원</span></span>
                                                <% End If %>

                                            <% else %>
                                                <span class="sum"><%=FormatNumber(bestlist.FItemList(i).getRealPrice,0) & chkIIF(bestlist.FItemList(i).IsMileShopitem,"Point","<span class='won'>원</span>")%></span>
                                            <% end if %>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <% 
                                Next
                            %>
                        </ul>
                    </div>
                </div-->
                <%'!--// 추천 다이어리 --%>

                <%'!-- 다이어리 이벤트 --%>
                <div class="swiper-slide">
                    <div class="inner list-card">
                        <ul>
                            <% 
                            dim vLink, vName
                            FOR di = 0 to hoteventlist.FResultCount-1
                                vName = ""
                                if ubound(Split(hoteventlist.FItemList(di).FEvt_name,"|"))> 0 Then
                                    If hoteventlist.FItemList(di).fissale Or (hoteventlist.FItemList(di).fissale And hoteventlist.FItemList(di).fiscoupon) then
                                        vName = "<p class='headline'><span class='ellipsis'>"& cStr(chrbyte(Split(hoteventlist.FItemList(di).FEvt_name,"|")(0),80,"Y"))&"</span><b class='discount color-red'>"&cStr(Split(hoteventlist.FItemList(di).FEvt_name,"|")(1)) &"</b></p>"
                                    ElseIf hoteventlist.FItemList(di).fiscoupon Then
                                        vName = "<p class='headline'><span class='ellipsis'>"& cStr(chrbyte(Split(hoteventlist.FItemList(di).FEvt_name,"|")(0),80,"Y"))&"</span><b class='discount color-green'>"&cStr(Split(hoteventlist.FItemList(di).FEvt_name,"|")(1)) &"</b></p>"
                                    end if 
                                else
                                    vName = "<p class='headline'><span class='ellipsis'>"& hoteventlist.FItemList(di).FEvt_name &"</span></p>"
                                end if
                            %>
                            <li>
                                <a href="/event/eventmain.asp?eventid=<%=hoteventlist.FItemList(di).fevt_code%><%=gaParamEvent%><%=di+1%>" onclick="fnAmplitudeEventAction('click_maindiarybest_views','events','<%=hoteventlist.FItemList(di).fevt_code%>');">
                                    <div class="thumbnail"><img src="<%=hoteventlist.FItemList(di).fevt_mo_listbanner %>" alt=""><% If hoteventlist.FItemList(di).fisgift Then %><em>GIFT</em><% End If %></div>
                                    <div class="desc">
                                        <%=vName%>
                                        <p class="subcopy ellipsis"><%=db2html(hoteventlist.FItemList(di).FEvt_subcopyK) %></p>
                                    </div>
                                </a>
                            </li>
                            <%		
                            Next 
                            %>
                        </ul>
                    </div>
                </div>
                <%'!--// 다이어리 이벤트 --%>

                <%'!-- 다꾸채널(수작업영역) --%>
                <div class="swiper-slide">
                    <div class="inner daccu-vod">
                        <a href="/event/eventmain.asp?eventid=94995&gaparam=main_diarystorydaccuchannel">
                            <strong class="vod-tit">
                                <em class="vod-label">
                                    <img src="//fiximage.10x10.co.kr/web2018/diary2019/img_label_youtube_v2.png" alt="youtube">
                                </em>
                                <strong>망고펜슬과 함께하는<br>네온문X헬로키티</strong>
                                <span>두근두근! 네온문X헬로키티<br>비밀일기장 언박싱을 함께해요</span>
                                <b><img src="//fiximage.10x10.co.kr/web2018/diary2019/btn_go_daccu_vod.png" alt="다꾸채널 바로가기"></b>
                            </strong>
                        </a>
                        <ul class="vod-thm-list">
                            <li><a href="/shopping/category_prd.asp?itemid=2358150"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94995/img_vod_item_1.jpg" alt=""></a></li>
                            <li><a href="/shopping/category_prd.asp?itemid=2358154"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94995/img_vod_item_3.jpg" alt=""></a></li>
                            <li><a href="/shopping/category_prd.asp?itemid=2358158"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94995/img_vod_item_2.jpg" alt=""></a></li>
                            <li class="btn-more-item"><a href="/event/eventmain.asp?eventid=94995"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94995/img_vod_item_more.jpg" alt="소개된 상품 보기"><span class="num" style="font-size:13px;">+6</span></a></li>
                        </ul>
                        <div class="vod-area">
                            <iframe width="520" height="315" src="https://www.youtube.com/embed/KBEPurAvNNA" frameborder="0" allowfullscreen></iframe>
                        </div>
                    </div>
                </div>
                <%'!--// 다꾸채널(수작업영역) --%>

                <%'!-- 베스트 데코템 --%>
                <div class="swiper-slide">
                    <div class="inner items type-thumb">
                        <ul>
                            <%	
                                dim dlink , dalink
                                For lp=0 to oDaccuRanking.FResultCount-1 

                                dlink = "/shopping/category_prd.asp?itemid="&oDaccuRanking.FItemList(lp).FItemID
                                dalink = dlink & gaParamDaccu & i+1
                            %>
                            <li>
                                <a href="<%=dalink%>" onclick="fnAmplitudeEventAction('click_maindiarybest_views','daccuitems','<%=oDaccuRanking.FItemList(lp).Fitemid%>');">
                                    <div class="thumbnail"><img src="<%=getThumbImgFromURL(oDaccuRanking.FItemList(lp).FImageBasic,"200","200","true","false") %>" alt="" /><em><%=lp+1%></em></div>
                                    <div class="desc">
                                        <p class="name"><%=oDaccuRanking.FItemList(lp).FItemName %></p>
                                        <div class="price">
                                            <% if oDaccuRanking.FItemList(lp).IsSaleItem or oDaccuRanking.FItemList(lp).isCouponItem Then %>
                                                <% IF oDaccuRanking.FItemList(lp).IsSaleItem then %>
                                                    <span class="discount color-red"><%=oDaccuRanking.FItemList(lp).getSalePro%></span>
                                                    <span class="sum"><%=FormatNumber(oDaccuRanking.FItemList(lp).getRealPrice,0)%><span class="won">원</span></span>
                                                <% End If %>
                                                <% IF oDaccuRanking.FItemList(lp).IsCouponItem Then %>
                                                    <span class="discount color-green"><%=oDaccuRanking.FItemList(lp).GetCouponDiscountStr%></span>
                                                    <span class="sum"><%=FormatNumber(oDaccuRanking.FItemList(lp).GetCouponAssignPrice,0)%><span class="won">원</span></span>
                                                <% end if %>
                                            <% else %>
                                                <span class="sum"><%=FormatNumber(oDaccuRanking.FItemList(lp).getRealPrice,0) & chkIIF(oDaccuRanking.FItemList(lp).IsMileShopitem,"Point","<span class='won'>원</span>")%></span>
                                            <% end if %>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <% next %>
                        </ul>
                    </div>
                </div>
                <%'!--// 베스트 데코템 --%>
            </div>
            <div class="pagination"></div>
            <button class="slide-nav btn-prev" onfocus="this.blur();"></button>
            <button class="slide-nav btn-next" onfocus="this.blur();"></button>
        </div>
    </div>
</div>
<%'!-- 사은품 레이어 --%>
<div id="lyrGift" style="display:none;">
    <div class="gift-layer">
        <div class="slide">
            <div><img src="http://fiximage.10x10.co.kr/web2018/diary2019/img_gift_slide_1.jpg" alt="" /></div>
            <div><img src="http://fiximage.10x10.co.kr/web2018/diary2019/img_gift_slide_2.jpg" alt="" /></div>
            <div><img src="http://fiximage.10x10.co.kr/web2018/diary2019/img_gift_slide_3.jpg" alt="" /></div>
        </div>
        <h3><img src="http://fiximage.10x10.co.kr/web2018/diary2019/tit_gift.png" alt="텐바이텐 일러스트레이터 이공 콜라보 스탠다드러브 댄스" /></h3>
        <div class="scrollbarwrap">
            <div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>
            <div class="viewport">
                <div class="overview">
                    <p><img src="http://fiximage.10x10.co.kr/web2018/diary2019/txt_about_gift_v2.png?v=1.01" alt="" /></p>
                    <ul class="noti">
                        <li>- 기간 : 2018년 9월 17일 ~ 12월 31일 (한정수량으로 조기 품절 될 수 있습니다)</li>
                        <li>- 사은품은 쿠폰 등과 같은 할인 수단 사용 후, 구매확정 금액을 기준으로 증정됩니다.</li>
                        <li>- 다이어리 구매 개수에 관계없이 총 구매금액 조건 충족 시 사은품이 증정됩니다.</li>
                        <li>- 환불 및 교환으로 인해 증정 기준 금액이 미달될 경우, 사은품을 반품해 주셔야 합니다.</li>
                        <li>- 사은품 불량으로 인한 교환은 불가능합니다.</li>
                        <li>- 비회원 구매 시 사은품 증정에서 제외됩니다.</li>
                    </ul>
                </div>
            </div>
        </div>
        <button type="button" class="btn-close" onclick="ClosePopLayer();"><img src="http://fiximage.10x10.co.kr/web2018/diary2019/btn_close.png" alt="닫기" /></button>
    </div>
</div>
<%'!--// 사은품 레이어 --%>
<%
end if 
on Error Goto 0

Set bestlist = Nothing
set hoteventlist = Nothing
Set oDaccuRanking = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
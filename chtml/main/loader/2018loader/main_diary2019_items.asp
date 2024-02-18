<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
response.charset = "utf-8"
Session.Codepage = 65001
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
'#######################################################
' Discription : pc_main_diarystory2019_items // cache DB경유
' History : 2018-09-04 이종화 생성
'#######################################################
Dim intI
Dim sqlStr , rsMem , arrList
Dim gaParam : gaParam = "&gaparam=main_diarystory_item" '//GA 체크 변수
dim topcount : topcount = 8 '// 노출 상품 갯수

'//DB 시간 타이머 00시부터 00시 5분 사이에는 DB 캐쉬 1분에 한번 읽기
Dim cTime , dummyName
If timer > 10 And Cint(timer/60) < 6 Then
	cTime = 60*1
	dummyName = "PdiaryITEM_"&Cint(timer/60)
Else
	cTime = 60*5
	dummyName = "PdiaryITEM"
End If

sqlStr = "EXEC db_diary2010.dbo.usp_www_shuffleDiaryItems_Get @topcount= "&topcount
'Response.write sqlStr

set rsMem = getDBCacheSQL(dbget, rsget, dummyName, sqlStr, cTime)
IF Not (rsMem.EOF OR rsMem.BOF) THEN
	arrList = rsMem.GetRows
END IF
rsMem.close

on Error Resume Next
If IsArray(arrList) and date() > "2018-09-16" Then
%>
<script src="/lib/js/jquery.tinyscrollbar.js"></script>
<script>
$(function() {
	$('.diary2019-list .rolling').slidesjs({
		height:85,
		navigation:{active:false},
		pagination:{active:false},
		play:{active:false, interval:1400, effect:"fade", auto:1400},
		effect:{fade:{speed:1000, crossfade:true}}
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
<div class="section wish-best diary2019-list">
    <div class="inner-cont">
        <div class="ftLt" style="width:360px;">
            <a href="/diarystory2019/?gaparam=diarystory_today_0">
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
        <div class="diary-list">
            <div class="items type-thumb item-240">
                <ul>
                <%
                    '2,3,4,5,6,10,14,15,16
                    Dim itemid , basicimage , itemname , sellcash , orgprice , saleyn , itemcouponyn , itemcouponvalue , itemcoupontype
                    dim alink ,link , totalprice , totalsale

                    For intI = 0 To ubound(arrlist,2)

                        itemid          = arrList(2,intI)
                        basicimage      = webImgUrl & "/image/basic/" & GetImageSubFolderByItemid(itemid) &"/"& arrList(3,intI)
                        itemname        = arrList(4,intI)
                        sellcash        = arrList(5,intI)
                        orgprice        = arrList(6,intI)
                        saleyn          = arrList(10,intI)
                        itemcouponyn    = arrList(14,intI)
                        itemcouponvalue = arrList(15,intI)
                        itemcoupontype  = arrList(16,intI)

                        link = "/shopping/category_prd.asp?itemid="&itemid
                        alink = link & gaparam & intI+1

                        If saleyn = "N" and itemcouponyn = "N" Then
                            totalprice = formatNumber(orgPrice,0)
                        End If
                        If saleyn = "Y" and itemcouponyn = "N" Then
                            totalprice = formatNumber(sellCash,0)
                        End If
                        if itemcouponyn = "Y" And itemcouponvalue>0 Then
                            If itemcoupontype = "1" Then
                                totalprice = formatNumber(sellCash - CLng(itemcouponvalue*sellCash/100),0)
                            ElseIf itemcoupontype = "2" Then
                                totalprice = formatNumber(sellCash - itemcouponvalue,0)
                            ElseIf itemcoupontype = "3" Then
                                totalprice = formatNumber(sellCash,0)
                            Else
                                totalprice = formatNumber(sellCash,0)
                            End If
                        End If
                        If saleyn = "Y" And itemcouponyn = "Y" And itemcouponvalue>0 Then
                            If itemcoupontype = "1" Then
                                '//할인 + %쿠폰
                                totalsale = "<span class='discount color-red'>"& CLng((orgPrice-(sellCash - CLng(itemcouponvalue*sellCash/100)))/orgPrice*100) &"%</span>"
                            ElseIf itemcoupontype = "2" Then
                                '//할인 + 원쿠폰
                                totalsale = "<span class='discount color-red'>"& CLng((orgPrice-(sellCash - itemcouponvalue))/orgPrice*100)&"%</span>"
                            Else
                                totalsale = "<span class='discount color-red'>"& CLng((orgPrice-sellCash)/orgPrice*100)&"%</span>"
                            End If 
                        ElseIf saleyn = "Y" and itemcouponyn = "N" Then
                            If CLng((orgPrice-sellCash)/orgPrice*100)> 0 Then
                                totalsale = "<span class='discount color-red'>"& CLng((orgPrice-sellCash)/orgPrice*100)&"%</span>"
                            End If
                        elseif saleyn = "N" And itemcouponyn = "Y" And itemcouponvalue>0 Then
                            If itemcoupontype = "1" Then
                                totalsale = "<span class='discount color-green'>"& CStr(itemcouponvalue) & "%</span>"
                            End If
                        Else 
                            totalsale = ""
                        End If
                %>
                    <li>
                        <a href="<%=alink%>" onclick="fnAmplitudeEventMultiPropertiesAction('click_maindiaryitems_views','indexnumber|itemid','<%=intI+1%>|<%=itemid%>');">
                            <div class="thumbnail"><img src="<%=basicimage%>" alt="<%=itemname%>" /></div>
                            <div class="desc">
                                <p class="name"><%=itemname%></p>
                                <div class="price">
                                    <%=totalsale%>
                                    <span class="sum"><%=totalprice%></span>
                                </div>
                            </div>
                        </a>
                    </li>
                <%
                    next
                %>
                </ul>
            </div>
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
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
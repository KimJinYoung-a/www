<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 텐텐문방구 메인
' History : 2019.06.17 정태훈 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/classes/event/exhibitionCls.asp" -->
<!-- #include virtual="/stationeryStore/stationeryStoreCls.asp" -->
<%
dim vGaparam, gnbflag
dim strGaParam, strGnbStr
Dim oExhibition, oRealSell, realsellItemList
dim mastercode,  detailcode, bestItemList, eventList, detailGroupList, listType
dim i, y, wishlist , lp
dim arrSwiperList
dim totalPrice , salePercentString , couponPercentString , totalSalePercent '// 할인율 관련
dim getOneDayItemEvent

vGaparam = request("gaparam")
if vGaparam <> "" then strGaParam = "&gaparam=" & vGaparam
if gnbflag <> "" then strGnbStr = "&gnbflag=1"

gnbflag = RequestCheckVar(request("gnbflag"),1)

mastercode =  8
listType = "A"

SET oExhibition = new ExhibitionCls
SET oRealSell = new CstationeryStore

    bestItemList = oExhibition.getItemsListProc( listType, 12, mastercode, "", "1", "" )     '리스트타입, row개수, 마스터코드, 디테일코드, best아이템 구분, 카테고리 정렬 구분 
	eventList = oExhibition.getEventListProc( listType, 8, mastercode, 0 )     '리스트타입, row개수, 마스터코드, 디테일코드
	detailGroupList = oExhibition.getDetailGroupList("1")
	realsellItemList = oRealSell.getNowSellingItems()
	arrSwiperList = oExhibition.getSwiperListProc( mastercode , "P" , "exhibition" ) '마스터코드 , 채널 , 기획전종류
    getOneDayItemEvent = oExhibition.getEventListProc( "B", 1, mastercode, 0 )     '상품 이벤트

	Set wishlist = new CstationeryStore
	'아이템 리스트
	wishlist.FPageSize = 12
	wishlist.FCurrPage = 1
	wishlist.Fbestgubun = "f"
	wishlist.ftectSortMet = "dbest"
	wishlist.getAwardBest

function format(ByVal szString, ByVal Expression)
	if len(szString) < len(Expression) then
	format = left(expression, len(szString)) & szString
	else
	format = szString
	end if
end function


dim OnedayStart, OnedayEnd, OnedayItemID, OnedayTitle, OnedayIMG , OnedayLabel , OneDayDueDate
Dim vTimerDate, targetNum, listenddate, liststartdate
OnedayLabel = "oneday"

if isArray(getOneDayItemEvent) then
    OnedayStart = getOneDayItemEvent(0).Fstartdate
    OnedayEnd = getOneDayItemEvent(0).Fenddate
    OnedayItemID = getOneDayItemEvent(0).Fetc_itemid
    OnedayTitle = getOneDayItemEvent(0).Fitemname
    OnedayIMG = getOneDayItemEvent(0).Frectangleimage
    OneDayDueDate = DateDiff("d",date(),OnedayEnd+1)

    if getOneDayItemEvent(0).Fissale then
        OnedayLabel = "oneday"
    end if

    if getOneDayItemEvent(0).Fisgift then
        OnedayLabel = "gift"
    end if

    if getOneDayItemEvent(0).Fisoneplusone then
        OnedayLabel = "oneplus"
    end if

    liststartdate = DateAdd("d",0,OnedayStart) & " 00:00:00"
    listenddate = DateAdd("d",0,OnedayEnd) & " 23:59:59"
    vTimerDate = DateAdd("d",1,OnedayEnd) & " 23:59:59"
    targetNum = Cint(cint(DateDiff("s", Now(),listenddate) / DateDiff("s", liststartdate, listenddate)* 100) / 5 ) + 1
end if 
%>
<link rel="stylesheet" type="text/css" href="/lib/css/moonbanggu.css?v=1.02" />
<script type="text/javascript" src="/event/etc/json/js_applyItemInfo.js"></script>
<script type="text/javascript" src="/lib/js/TweenMax.min.js"></script>
<script type="text/javascript" src="/lib/js/jquery.easypiechart.min.js"></script>
<script type="text/javascript" src="/event/etc/json/js_applyItemInfo.js"></script>
<script type="text/javascript">

var j1yr = "<%=Year(vTimerDate)%>";
var j1mo = "<%=TwoNumber(Month(vTimerDate))%>";
var j1da = "<%=TwoNumber(Day(vTimerDate))%>";
var montharray=new Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")
var j1today=new Date(<%=Year(now)%>, <%=Month(now)-1%>, <%=Day(now)%>, <%=Hour(now)%>, <%=Minute(now)%>, <%=Second(now)%>);

var j1minus_second = 0;		// 변경될 증가시간(초)
var j1nowDt=new Date();		// 시작시 브라우저 시간

function countdown(){
	var cntDt = new Date(Date.parse(j1today) + (1000*j1minus_second));	//서버시간에 변화값(1초) 증가
	var todayy=cntDt.getYear()

	if(todayy < 1000) todayy+=1900;

	var todaym=cntDt.getMonth();
	var todayd=cntDt.getDate();
	var todayh=cntDt.getHours();
	var todaymin=cntDt.getMinutes();
	var todaysec=cntDt.getSeconds();
	var todaystring=montharray[todaym]+" "+todayd+", "+todayy+" "+todayh+":"+todaymin+":"+todaysec;
	var futurestring=montharray[j1mo-1]+" "+j1da+", "+j1yr+" 00:00:00";
//alert(futurestring);
	var nowdt = new Date();
	var thendt = new Date('<%=Year(vTimerDate)&"-"&Month(vTimerDate)&"-"&Day(vTimerDate)&" "&Hour(vTimerDate)&":"&Minute(vTimerDate)&":"&Second(vTimerDate)%>');
	var gapdt = thendt.getTime() - nowdt.getTime();

	gapdt = Math.floor(gapdt / (1000*60*60*24));

	dd=Date.parse(futurestring)-Date.parse(todaystring);
	dday=Math.floor(dd/(60*60*1000*24)*1);

	dhour=Math.floor((dd%(60*60*1000*24))/(60*60*1000)*1);
	dmin=Math.floor(((dd%(60*60*1000*24))%(60*60*1000))/(60*1000)*1);
	dsec=Math.floor((((dd%(60*60*1000*24))%(60*60*1000))%(60*1000))/1000*1);

	if(dday < 0) {
		$("#countdown").html("00:00:00");
		return;
	}
    if (dday>=1){
        dhour=24*dday+dhour;
    }

	if(dhour < 10) dhour = "0" + dhour;
	if(dmin < 10) dmin = "0" + dmin;
	if(dsec < 10) dsec = "0" + dsec;
	dhour = dhour+'';
	dmin = dmin+'';
	dsec = dsec+'';

	$("#countdown").html(dhour.substr(0,1)+dhour.substr(1,1)+dhour.substr(2,1)+":"+dmin.substr(0,1)+dmin.substr(1,1)+":"+dsec.substr(0,1)+dsec.substr(1,1));

	var usrDt=new Date();	// 현재 브라우저 시간
	var vTerm = parseInt(usrDt.getTime()/1000)-parseInt(j1nowDt.getTime()/1000);	// 시작시 시간과의 차이(초)
	j1minus_second = vTerm;	// 증가시간에 차이 반영

	setTimeout("countdown()",500)
}
$(function(){
    countdown();
	(function(){
        //top slide-bnr
        if($('.main-bnr .slide1 .slider').length > 1){ 
            $('.main-bnr .slide1').slick({
                autoplay: true,
                arrows: true,
                fade: true,
                speed: 800,
                infinite:true,
                pauseOnHover: false,
                dots: true,
                customPaging: function(slick,index) {
                    calc=index+1
                    return '<a> ' + calc +  'ㅣ' + slick.slideCount +'</a>';
                }
            });
        }
        //button-navigator
        $('.items-wrap .nav li').click(function(e){
            i=$(this).index()
            $(this).addClass('on').siblings().removeClass('on')
            $('.order').eq(i).addClass('on').siblings().removeClass('on')
            e.preventDefault();
        })
        //button-more
        $('.btn-more').each(function(){
            $(this).click(function(e){
                $(this).toggleClass('on')
                e.preventDefault();
            })
        })
        //issue vod - timer
        var date = new Date(-32400000);
        setInterval(function() {
            date.setSeconds(date.getSeconds() + 1);
            $('.timer').html(date.toTimeString().substr(0, 8));
        }, 1000);
        //category
        $('.cateList li').click(function(){
            $(this).addClass('on').siblings().removeClass('on')
        })
        $('.cate-area .sort a').click(function(e){
            $(this).parent().addClass('on').siblings().removeClass('on')
            e.preventDefault();
        })
        //timelinemax
        var blink = new TimelineMax({repeat:-1,yoyo: true});
        blink.to((".issue-vod h3 b"), .01,  {'opacity':'0', repeat: -1,repeatDelay:.4, yoyo: true})
        blink.to((".brand7 .ani span"), .01,  {'opacity':'0', repeat: -1,repeatDelay:.4, yoyo: true})

        var circle = new TimelineMax({repeat:-1,yoyo: true});
        circle.to("#circle",5,{transform:"scale(3.3)",ease: Power0.easeNone})

        var brd1 = new TimelineMax({repeat:-1,repeatDelay:1,yoyo: true});
        brd1.staggerFrom( ".brand1 .ani span",.01,{'opacity':'0'},.5)

        var bounce = new TimelineMax({repeat:-1,yoyo: true});
        bounce.to( ".brand3 .ani span",.5,{'transform':'translateY(-1rem)',ease: Power1.easeOut})

        var mickyFace = new TimelineMax({repeat:-1,repeatDelay:.6});
        mickyFace.to( ".brand4 .ani span:nth-child(1)" , .5,{rotation:-15,repeat:2, yoyo:true,ease: Power0.easeNone})
            .to( ".brand4 .ani span:nth-child(1)" , .5,{rotation:0, ease: Power0.easeNone})
        mickyFace.to( ".brand4 .ani span:nth-child(2)" , .5,{rotation:15,repeat:2, yoyo:true,ease: Power0.easeNone},'-=2')
            .to( ".brand4 .ani span:nth-child(2)" , .5,{rotation:0 ,ease: Power0.easeNone},'-=.5')
        mickyFace.to( ".brand4 .ani span:nth-child(4)" , .1,{opacity:0},'-=2.5')
            .to( ".brand4 .ani span:nth-child(4)" , .1,{opacity:1},'+=.1')
    })();
    //스페셜 상품
    fnApplyToTalPriceItem ({
        items:"<%=OnedayItemID%>", //상품코드
        target:"item",
        fields:["price","sale","soldout"],
        unit:"hw",
        saleBracket:false 
    });

    // item list init
    getList();
});

// 전체 상품 리스트
function getList() {
	var str = $.ajax({
			type: "GET",
	        url: "ajaxDataList.asp",
	        data: $("#listfrm").serialize(),
	        dataType: "text",
	        async: false
	}).responseText;

	if(str!="") {
    	$('#catearea').empty().html(str);
    }
}
</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container moonbanggu">
        <%
            if isArray(arrSwiperList) then 
        %>
        <div class="topic">
            <h2>텐텐문방구</h2>
            <div class="main-bnr">
                <div class="slide1">
                    <% 
                        for lp = 0 to ubound(arrSwiperList,2)
                    %>
                    <div class="slider">
                        <a href="/event/eventmain.asp?eventid=<%=arrSwiperList(12,lp)%>" onclick="fnAmplitudeEventMultiPropertiesAction('click_StationeryStore_event','idx|eventcode','<%=lp+1%>|<%=arrSwiperList(12,lp)%>')">
                            <span><img src="<%=arrSwiperList(8,lp)%>" alt="<%=arrSwiperList(5,lp)%>"></span>
                            <div class="desc">
                                <div class="headline">
                                    <p><%=arrSwiperList(5,lp)%></p>
                                    <p class="subcopy"><%=arrSwiperList(21,lp)%></p>
                                </div>
                                <div>
                                    <% if arrSwiperList(22,lp) <> "" and (arrSwiperList(24,lp)) then %><b class="discount bg-red">~<%=arrSwiperList(22,lp)%>%</b><% end if %>
                                    <% if arrSwiperList(23,lp) <> "" and (arrSwiperList(25,lp)) then %><b class="discount bg-green">~<%=arrSwiperList(23,lp)%>%</b><% end if %>
                                </div>
                            </div>
                        </a>
                    </div>
                    <%
                        next 
                    %>
                </div>
            </div>
        </div>
        <% end if %>
        <%
            if isArray(getOneDayItemEvent) then
        %>
        <div class="main-prd item<%=OnedayItemID%>">
            <div class="inner">
                <h3>스페셜 상품</h3>
                <div class="<%=OnedayLabel%>">
                <%
                ' . 1day 상품 : 클래스 oneday 로 교체
                ' . 1+1 상품 : 클래스 oneplus 로 교체
                ' . gift 상품 : 클래스 gift 로 교체
                %>
                    <div class="oneday-chart">
                        <div class="time-line interval-<%=targetNum%>"><span class="time" id="countdown">00:00:00</span></div>
                    </div>
                    <a href="/shopping/category_prd.asp?itemid=<%=OnedayItemID%>" class="clearFix">
                        <div class="desc">
                            <div class="name-area"><span class="name"><%=OnedayTitle%></span></div>
                            <div class="price"><s></s> <span></span></div>
                        </div>
                        <div class="img-cont verNew">
                            <div class="thumbnail">
                                <p><img src="<%=OnedayIMG%>" alt=""></p>
                                <span class="badge day-0<%=OneDayDueDate%>"></span>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </div>
        <%
            end if 
        %>

        <div class="items-wrap">
            <div class="inner">
                <h3 class="nav">
                    <ul>
                        <li class="nav1 on"><a href="">실시간 랭킹</a></li>
                        <li class="nav2"><a href="">장바구니 베스트</a></li>
                        <li class="nav3"><a href="">텐텐문방구 PICK</a></li>
                    </ul>
                </h3>
                <div>
                    <div class="now-ranking order on">
                        <ul class="items">
                        <% if Ubound(realsellItemList) > 0 then %>
							<%  
								for i = 0 to Ubound(realsellItemList) - 1
                                
                                call realsellItemList(i).fnItemPriceInfos(totalPrice , salePercentString , couponPercentString , totalSalePercent)
							%>
                            <li> 
                                <a href="/shopping/category_prd.asp?itemid=<%=realsellItemList(i).Fitemid%>">
                                    <div class="thumbnail">
                                        <img src="<%=realsellItemList(i).FImageBasic%>" alt="" />
                                        <em><%=i+1%></em>
                                    </div>
                                    <div class="desc">
                                        <p class="name"><%=realsellItemList(i).Fitemname%></p>
                                        <div class="price">
                                            <div class="unit">
                                                <b class="sum"><%=formatNumber(totalPrice, 0)%><span class="won">원</span></b>
                                                <% if salePercentString <> "0" then %><span class="discount color-red">[<%=salePercentString%>]</span><% end if%>
									            <% if couponPercentString <> "0" then %><span class="discount color-green">[<%=couponPercentString%>]</span><% end if%>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </li>
							<% next %>                    
                		<% end if %>
                        </ul>
                    </div>
                    <div class="cart-best order">
                        <ul class="items">
							<%
							If wishlist.FResultCount > 0 Then
								For i = 0 To wishlist.FResultCount - 1

								IF application("Svr_Info") = "Dev" THEN
									wishlist.FItemList(i).FImageicon1 = left(wishlist.FItemList(i).FImageicon1,7)&mid(wishlist.FItemList(i).FImageicon1,12)
								end if
							%>
                            <li> 
                                <a href="/shopping/category_prd.asp?itemid=<%= wishlist.FItemList(i).FItemid %>">
                                    <div class="thumbnail">
                                        <img src="<%= wishlist.FItemList(i).FDiaryBasicImg2 %>" alt="" />
                                        <% If wishlist.FItemList(i).Ffavcount > 0 Then %><em><%=formatnumber(wishlist.FItemList(i).Ffavcount,0)%>명</em><% end if %>
                                    </div>
                                    <div class="desc">
                                        <p class="name">
                                            <% If wishlist.FItemList(i).isSaleItem Or wishlist.FItemList(i).isLimitItem Then %>
												<%= chrbyte(wishlist.FItemList(i).FItemName,30,"Y") %>
											<% Else %>
												<%= wishlist.FItemList(i).FItemName %>
											<% End If %>
                                        </p>
                                        <div class="price">
                                            <div class="unit">
                                            	<% if wishlist.FItemList(i).IsSaleItem or wishlist.FItemList(i).isCouponItem Then %>
													<% IF wishlist.FItemList(i).IsCouponItem Then %>
														<b class="sum"><%=FormatNumber(wishlist.FItemList(i).GetCouponAssignPrice,0)%><span class="won">원</span></b>
														<b class="discount color-green"><%=wishlist.FItemList(i).GetCouponDiscountStr%></b>
													<% else %>                                                                            
														<b class="sum"><%=FormatNumber(wishlist.FItemList(i).getRealPrice,0)%><span class="won">원</span></b>
														<b class="discount color-red"><%=wishlist.FItemList(i).getSalePro%></b>
													<% End If %>
												<% else %>
													<b class="sum"><%=FormatNumber(wishlist.FItemList(i).getRealPrice,0) & chkIIF(wishlist.FItemList(i).IsMileShopitem,"Point","<span class='won'>원</span>")%></b>
												<% end if %>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </li>
							<%
								Next
							end If
							%>
                        </ul>
                    </div>
                    <div class="tenten-pic order">
                        <ul class="items">
						<% if Ubound(bestItemList) > 0 then %>
							<%  
								for i = 0 to Ubound(bestItemList) - 1
                                call bestItemList(i).fnItemPriceInfos(totalPrice , salePercentString , couponPercentString , totalSalePercent)
							%>
                            <li>
                                <a href="/shopping/category_prd.asp?itemid=<%= bestItemList(i).FItemid %>">
                                    <div class="thumbnail">
                                        <img src="<%=bestItemList(i).FBasicimage%>" alt="" />
                                        <em><%=i+1%></em>
                                    </div>
                                    <div class="desc">
                                        <p class="name"><%=bestItemList(i).Fitemname%></p>
                                        <div class="price">
                                            <div class="unit">
                                                <b class="sum"><%=formatNumber(totalPrice, 0)%><span class="won">원</span></b>
                                                <% if salePercentString <> "0" then %><span class="discount color-red">[<%=salePercentString%>]</span><% end if%>
									            <% if couponPercentString <> "0" then %><span class="discount color-green">[<%=couponPercentString%>]</span><% end if%>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </li>
							<% next %>                    
                		<% end if %>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <form id="listfrm" name="listfrm" method="get" style="margin:0px;">
            <input type="hidden" name="cpg" value="1" />
            <input type="hidden" name="sortMet" />
            <input type="hidden" name="detailcode" value="" />
		</form>

        <%' 상품 전체 리스트 %>
        <div class="cate-area" id="catearea"></div>
        <%' 상품 전체 리스트 %>

        <% if isArray(eventList) then %>
        <div class="evt-list">
            <div class="inner">
                <h3>기획전</h3>
                <ul class="clearFix">
                    <%
                        for i = 0 to Ubound(eventList) - 1
						if eventList(i).Frectangleimage = "" then
                        else
                    %>
                    <li class="<%=chkIIF(i > 3, "elmore detailElm3", "")%>">
                        <a href="/event/eventmain.asp?eventid=<%=eventList(i).Fevt_code%>" onclick="fnAmplitudeEventMultiPropertiesAction('click_StationeryStore_event','idx|eventcode','<%=i+1%>|<%=eventList(i).Fevt_code%>')" class="clearFix">
                            <% if eventList(i).Fisgift then %><span class="ico-gift"></span><% end if %>
                            <div class="thumbnail">
                                <img src="<%=eventList(i).Fsquareimage%>" alt="<%=cStr(Split(eventList(i).Fevt_name,"|")(0))%>">
                            </div>
                            <div class="desc">
                                <p class="tit"><%=cStr(Split(eventList(i).Fevt_name,"|")(0))%></p>
                                <p class="subcopy"><%=eventList(i).Fevt_subcopy%></p>
                                <div>
                                    <% if eventList(i).Fsaleper <> "" and not(isnull(eventList(i).Fsaleper)) then %><em class="discount color-red"><%=chkIIF(eventList(i).Fsaleper > 0 , "~"&eventList(i).Fsaleper&"%","") %></em><% end if %>
                                </div>
                            </div>
                        </a>
                    </li>
                    <%
						end if
						next
					%>
                </ul>
                <% if Ubound(eventList) > 5 then %>
                <a href="" class="btn-more">더 많은 기획전 보기</a>
                <% end if %>
            </div>
        </div>
        <% end if %>
        <div>
            <div class="inner clearFix">
                <div class="story">
                    <h3>텐텐문방구 스토리</h3>
                    <svg id="circle"><circle></circle></svg>
                    <% if now()>="2019-08-07" then %>
                    <a href="/event/eventmain.asp?eventid=96370" class="clearFix">
                        <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/moonbanggu/tentenstory/190807/img.png" alt=""></div>
                        <div class="desc">
                            <div>
                                <span class="label">이번주 테마</span>
                                <p class="tit">D-100, 격하게 응원해!!</p>
                                <div class="subtxt">
                                    수능 D-100 중요한 지금 딱 필요한 꿀템 추천!
                                </div>
                            </div>
                        </div>
                    </a>
                    <% else %>
                    <a href="/event/eventmain.asp?eventid=96271" class="clearFix">
                        <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/moonbanggu/tentenstory/190724/img.png" alt=""></div>
                        <div class="desc">
                            <div>
                                <span class="label">이번주 테마</span>
                                <p class="tit">비 오는 날의 수채화</p>
                                <div class="subtxt">
                                    비 오는 날의 추억을 추천드립니다.
                                </div>
                            </div>
                        </div>
                    </a>
                    <% end if %>
                </div>
                <div class="story issue-vod flr">
                    <h3><b>·</b>이슈영상
                        <em class="timer">00:00:00</em>
                    </h3>
                    <% if now()>="2019-08-21" then %>
                    <a href="/event/eventmain.asp?eventid=96769" class="clearFix">
                        <div class="thumbnail new"><img src="//webimage.10x10.co.kr/fixevent/event/2019/moonbanggu/vodthumb/190821/img.png" alt=""></div>
                        <div class="desc">
                            <div>
                                <span class="label">다꾸TV 4편</span>
                                <div class="subtxt">
                                    인스타그래머 나키의<br>다이어리꾸미기
                                </div>
                            </div>
                        </div>
                    </a>
                    <% else %>
                    <a href="/event/eventmain.asp?eventid=95898" class="clearFix">
                        <div class="thumbnail new"><img src="//webimage.10x10.co.kr/fixevent/event/2019/moonbanggu/vodthumb/190724/img.png" alt=""></div>
                        <div class="desc">
                            <div>
                                <span class="label">다꾸TV 3편</span>
                                <div class="subtxt">
                                    유튜버 피치보쨘의 <br>상큼달큼 다꾸의 정석!
                                </div>
                            </div>
                        </div>
                    </a>
                    <% end if %>
                </div>
            </div>
        </div>
        <div class="brand-story">
            <div class="inner">
                <h3 class="blind">브랜드 스토리</h3>
                <div class="list-wrap">
                    <span><img src="//fiximage.10x10.co.kr/web2019/moonbanggu/img_brand.jpg" alt=""></span>
                    <ul>
                        <li class="brand1">
                            <h4 class="blind">HIGHTIDE</h4>
                            <a href="/street/street_brand_sub06.asp?makerid=HIGHTIDE" ></a>
                            <div class="ani">
                                <span><img src="//fiximage.10x10.co.kr/web2019/moonbanggu/img_brand1_01.png" alt=""></span>
                                <span><img src="//fiximage.10x10.co.kr/web2019/moonbanggu/img_brand1_02.png" alt=""></span>
                                <span><img src="//fiximage.10x10.co.kr/web2019/moonbanggu/img_brand1_04.png" alt=""></span>
                                <span><img src="//fiximage.10x10.co.kr/web2019/moonbanggu/img_brand1_03.png" alt=""></span>
                            </div>
                        </li>
                        <li class="brand2">
                            <h4 class="blind">TRAVELER'S NOTE</h4>
                            <a href="/street/street_brand_sub06.asp?makerid=tfc2018" ></a>
                        </li>
                        <li class="brand3">
                            <h4 class="blind">MOLESKINE</h4>
                            <a href="/street/street_brand_sub06.asp?makerid=moleskine" ></a>
                            <div class="ani"><span><img src="//fiximage.10x10.co.kr/web2019/moonbanggu/img_brand3_01.png" alt=""></span></div>
                        </li>
                        <li class="brand4">
                            <h4 class="blind">DISNEY</h4>
                            <a href="/street/street_brand_sub06.asp?makerid=disney10x10" ></a>
                            <div class="ani">
                                <span><img src="//fiximage.10x10.co.kr/web2019/moonbanggu/img_brand4_03.png?v=1.01" alt=""></span>
                                <span><img src="//fiximage.10x10.co.kr/web2019/moonbanggu/img_brand4_04.png?v=1.01" alt=""></span>
                                <span><img src="//fiximage.10x10.co.kr/web2019/moonbanggu/img_brand4_01.png?v=1.01" alt=""></span>
                                <span><img src="//fiximage.10x10.co.kr/web2019/moonbanggu/img_brand4_02.png?v=1.01" alt=""></span>
                            </div>
                        </li>
                        <li class="brand5">
                            <h4 class="blind">BT21</h4>
                            <a href="/street/street_brand_sub06.asp?makerid=khstudio8" ></a>
                        </li>
                        <li class="brand6">
                            <h4 class="blind">LAMY</h4>
                            <a href="/street/street_brand_sub06.asp?makerid=lamy2" ></a>
                        </li>
                        <li class="brand7">
                            <h4 class="blind">THENCE</h4>
                            <a href="/street/street_brand_sub06.asp?makerid=onward" ></a>
                            <div class="ani"><span><img src="//fiximage.10x10.co.kr/web2019/moonbanggu/img_brand7_01.png" alt=""></span></div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
	</div>
    <!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<%
    SET oExhibition = nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
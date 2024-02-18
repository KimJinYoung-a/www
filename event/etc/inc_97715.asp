<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 18주년 텐텐데이
' History : 2019.10.07 한용민 생성
'####################################################
%>
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/event/etc/event_97715_cls.asp" -->

<%
dim cevt97715, i, currentdate, parttime, currenthour, isSoldOut
    currentdate = now()     ' #10/10/2019 11:59:59#
    currenthour = hour(currentdate)

isSoldOut=false
parttime="0"
if currenthour>=10 and currenthour<13 then
    parttime="1"
elseif currenthour>=13 and currenthour<15 then
    parttime="2"
elseif currenthour>=15 and currenthour<17 then
    parttime="3"
elseif currenthour>=17 and currenthour<19 then
    parttime="4"
elseif currenthour>=19 and currenthour<22 then
    parttime="5"
end if
if left(currentdate,10)<>"2019-10-10" then parttime="0"     ' 10월 10일 당일날만 할인

function parttimestr(vparttime)
    dim tmpparttimestr

    if vparttime="1" then
        tmpparttimestr="am10:00 ~ pm1:00"
    elseif vparttime="2" then
        tmpparttimestr="pm1:00 ~ pm3:00"
    elseif vparttime="3" then
        tmpparttimestr="pm3:00 ~ pm5:00"
    elseif vparttime="4" then
        tmpparttimestr="pm5:00 ~ pm7:00"
    elseif vparttime="5" then
        tmpparttimestr="pm7:00 ~ pm10:00"
    else
        tmpparttimestr=""
    end if
    parttimestr=tmpparttimestr
end function

set cevt97715 = new Cevent_97715
    cevt97715.fnevent_97715()
%>
<style type="text/css">
.top {height:551px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/97715/bg_tenten.jpg) repeat-x 50% 0;}
.top h2 {padding-top:185px;}
.time-sale {position:relative; background-color:#f1f566;}
.time-sale span {position:absolute; top:0; left:50%; margin-left:-570px;}
.time-sale .step {position:absolute; bottom:-136px; left:50%; margin-left:-660px;}
.time-sale .step a {display:inline-block; position:absolute; top:0; right:164px; width:22.5%; height:100%; text-indent:-999em;}
.time-table {padding:275px 0 98px;}
.time-table h3 {padding-bottom:120px;}
.sale-section {padding:71px 0;}
.sale-section p {padding-bottom:28px;}
.sale-section p, .sale-section .item-list {position:relative; z-index:5;}
.sale-section .item-list {display:flex; justify-content:space-between; width:1048px; margin:0 auto;}
.sale-section.end .item-list li a {display:inline-block; position:relative; width:100%; height:100%;}
.sale-section.end .item-list li a:after {display:inline-block; position:absolute; top:-1px; left:0; width:186px; height:186px; background-color:rgba(0,0,0,.5); border-radius:50%; content:'';}
.sale-section.ing .item-list li a:after {display:none;}
.sale-section.ing .item-list .sold-out a:after, .sale-section.end .item-list .sold-out a:after {display:inline-block; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/97715/txt_sold_out.png); background-size:100%;}
.sale-section.ing {position:relative;}
.sale-section.ing:after, .sale-section.ing:before {display:inline-block; width:1320px; height:474px; position:absolute; top:0; left:50%; z-index:3; margin-left:-660px; background-color:#f1f669; content:'';}
.sale-section.ing:before {z-index:10; width:106px; height:26px; top:35px; left:50%; margin-left:-53px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/97715/txt_sale.png); animation:blink .8s 1000;}
@keyframes blink {
from, to {opacity:1; animation-timing-function:ease-out;}
50% {opacity:0; animation-timing-function:ease-in;}
}
.related-evt {background-color:#00848c;}
</style>

<!-- 텐텐데이 -->
<div class="evt97715">
    <!-- top -->
    <div class="top">
        <h2><img src="//webimage.10x10.co.kr/fixevent/event/2019/97715/tit_tenten.png" alt="10월 10일은 텐텐데이" /></h2>
    </div>
    <!--// top -->
    <!-- time-sale -->
    <div class="time-sale">
        <img src="//webimage.10x10.co.kr/fixevent/event/2019/97715/txt_tenten.jpg" alt="1 Day Time Sale" />
        <span><img src="//webimage.10x10.co.kr/fixevent/event/2019/97715/img_active.gif" alt="" /></span>
        <div class="step"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97715/img_way.png" alt="step1 다음 시간에는 무슨 상품이? 텐텐데이 타임테이블 미리미리 체크하기 step2 품절되기 전 빠른 구매! 고민은 후회만 부를 뿐, 찜해둔 상품이 있다면 서둘러 구매하자 step3 텐바이텐은 개미지옥! 지금 진행되고 있는 18주년 이벤트 확인하고 텐바이텐 10배 더 즐기기!" /><a href="/event/eventmain.asp?eventid=97588">주년이벤트로 이동</a></div>
    </div>
    <!--// time-sale -->

    <% if cevt97715.FResultCount>0 then %>
        <!-- time-table -->
        <div class="time-table">
            <h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/97715/txt_time.png" alt="12시간 동안 팡팡 터지는 릴레이 타임세일"></h3>
            <%
            '<!-- for dev msg 세일 진행중일 때, [ing]클래스  -->
            '<!-- for dev msg 세일 끝났을 때, [end]클래스  -->
            '<!-- for dev msg 품절된 상품에 [sold-out]클래스 추가 -->
            %>
            <div class="sale-section <% if parttime="1" then %>ing<% else %><% if currenthour>=13 or parttime="0" then %>end<% end if %><% end if %>">
                <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/97715/txt_time1.png" alt="<%= parttimestr("1") %>" /></p>
                <ul class="item-list">
                    <% for i = 0 to cevt97715.FResultCount-1 %>
                    <%
                    isSoldOut=false
                    if cevt97715.FItemList(i).isSoldOut then
                        isSoldOut=true
                    else
                        IF cevt97715.FItemList(i).isTempSoldOut Then
                            isSoldOut=true
                        end if
                    end if
                    %>
                    <% if cevt97715.FItemList(i).fsortNo="1" then %>
                        <li <% if isSoldOut then %>class="sold-out"<% end if %>><a href="/shopping/category_prd.asp?itemid=<%= cevt97715.FItemList(i).fitemid %>"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97715/img_item<%= cevt97715.FItemList(i).fitemid %>.png" alt="<%= cevt97715.FItemList(i).FItemName %>" /></a></li>
                    <% end if %>
                    <% next %>
                </ul>
            </div>
            <div class="sale-section <% if parttime="2" then %>ing<% else %><% if currenthour>=15 or parttime="0" then %>end<% end if %><% end if %>">
                <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/97715/txt_time2.png" alt="<%= parttimestr("2") %>" /></p>
                <ul class="item-list">
                    <% for i = 0 to cevt97715.FResultCount-1 %>
                    <%
                    isSoldOut=false
                    if cevt97715.FItemList(i).isSoldOut then
                        isSoldOut=true
                    else
                        IF cevt97715.FItemList(i).isTempSoldOut Then
                            isSoldOut=true
                        end if
                    end if
                    %>
                    <% if cevt97715.FItemList(i).fsortNo="2" then %>
                        <li <% if isSoldOut then %>class="sold-out"<% end if %>><a href="/shopping/category_prd.asp?itemid=<%= cevt97715.FItemList(i).fitemid %>"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97715/img_item<%= cevt97715.FItemList(i).fitemid %>.png" alt="<%= cevt97715.FItemList(i).FItemName %>" /></a></li>
                    <% end if %>
                    <% next %>
                </ul>
            </div>
            <div class="sale-section <% if parttime="3" then %>ing<% else %><% if currenthour>=17 or parttime="0" then %>end<% end if %><% end if %>">
                <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/97715/txt_time3.png" alt="<%= parttimestr("3") %>" /></p>
                <ul class="item-list">
                    <% for i = 0 to cevt97715.FResultCount-1 %>
                    <%
                    isSoldOut=false
                    if cevt97715.FItemList(i).isSoldOut then
                        isSoldOut=true
                    else
                        IF cevt97715.FItemList(i).isTempSoldOut Then
                            isSoldOut=true
                        end if
                    end if
                    %>
                    <% if cevt97715.FItemList(i).fsortNo="3" then %>
                        <li <% if isSoldOut then %>class="sold-out"<% end if %>><a href="/shopping/category_prd.asp?itemid=<%= cevt97715.FItemList(i).fitemid %>"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97715/img_item<%= cevt97715.FItemList(i).fitemid %>.png?v=1.01" alt="<%= cevt97715.FItemList(i).FItemName %>" /></a></li>
                    <% end if %>
                    <% next %>
                </ul>
            </div>
            <div class="sale-section <% if parttime="4" then %>ing<% else %><% if currenthour>=19 or parttime="0" then %>end<% end if %><% end if %>">
                <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/97715/txt_time4.png" alt="<%= parttimestr("4") %>" /></p>
                <ul class="item-list">
                    <% for i = 0 to cevt97715.FResultCount-1 %>
                    <%
                    isSoldOut=false
                    if cevt97715.FItemList(i).isSoldOut then
                        isSoldOut=true
                    else
                        IF cevt97715.FItemList(i).isTempSoldOut Then
                            isSoldOut=true
                        end if
                    end if
                    %>
                    <% if cevt97715.FItemList(i).fsortNo="4" then %>
                        <li <% if isSoldOut then %>class="sold-out"<% end if %>><a href="/shopping/category_prd.asp?itemid=<%= cevt97715.FItemList(i).fitemid %>"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97715/img_item<%= cevt97715.FItemList(i).fitemid %>.png?v=1.01" alt="<%= cevt97715.FItemList(i).FItemName %>" /></a></li>
                    <% end if %>
                    <% next %>
                </ul>
            </div>
            <div class="sale-section <% if parttime="5" then %>ing<% else %><% if currenthour>=22 or parttime="0" then %>end<% end if %><% end if %>">
                <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/97715/txt_time5.png" alt="<%= parttimestr("5") %>" /></p>
                <ul class="item-list">
                    <% for i = 0 to cevt97715.FResultCount-1 %>
                    <%
                    isSoldOut=false
                    if cevt97715.FItemList(i).isSoldOut then
                        isSoldOut=true
                    else
                        IF cevt97715.FItemList(i).isTempSoldOut Then
                            isSoldOut=true
                        end if
                    end if
                    %>
                    <% if cevt97715.FItemList(i).fsortNo="5" then %>
                        <li <% if isSoldOut then %>class="sold-out"<% end if %>><a href="/shopping/category_prd.asp?itemid=<%= cevt97715.FItemList(i).fitemid %>"><img src="//webimage.10x10.co.kr/fixevent/event/2019/97715/img_item<%= cevt97715.FItemList(i).fitemid %>.png" alt="<%= cevt97715.FItemList(i).FItemName %>" /></a></li>
                    <% end if %>
                    <% next %>
                </ul>
            </div>
        </div>
        <!--// time-table -->
    <% end if %>

    <!-- related-evt -->
    <div class="related-evt">
    <img src="//webimage.10x10.co.kr/fixevent/event/2019/97715/img_evt.png" alt="텐바이텐은 지금 18주년 행사 중! 이런 이벤트는 어떠세요?" usemap="#evt-map">
        <map name="evt-map">
            <area on.focus="this.blur();" alt="어서와, 텐바이텐은 처음이지?" href="/event/eventmain.asp?eventid=97607" coords="325,109,549,413" shape="rect">
            <area on.focus="this.blur();" alt="NEW에 눈이 번쩍 ♥에 마음이 콩닥" href="/event/eventmain.asp?eventid=97594" coords="589,111,814,412" shape="0">
            <area on.focus="this.blur();" alt="NO 세일? NO! 지금 바로 세일!" href="/event/eventmain.asp?eventid=97641" coords="856,110,1078,411" shape="0">
        </map>
    </div>
    <!-- related-evt -->
</div>
<!--// 텐텐데이 -->

<%
set cevt97715=nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
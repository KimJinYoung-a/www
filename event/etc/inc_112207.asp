<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  쿠폰 이벤트
' History : 2021-06-17 정태훈 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
dim mktTest, currentDate
IF application("Svr_Info") = "Dev" THEN
    mktTest = true
ElseIf application("Svr_Info")="staging" Then
    mktTest = true
Else
    mktTest = false
End If

if mktTest then
    currentDate = cdate("2021-06-21")
else
    currentDate = date()
end if
%>
<style>
/* common */
.evt112207 .section{position:relative;}
.evt112207 .go_coupon{background:url(//webimage.10x10.co.kr/fixevent/event/2021/112207/go_coupon.jpg)no-repeat 50% 0;height:51px;}
.evt112207 .bg_title{background:url(//webimage.10x10.co.kr/fixevent/event/2021/112207/bg_title.jpg)no-repeat 50% 0;height:818px;}
.evt112207 .section > div{width:1140px; margin:0 auto;padding-top:218px;}
.evt112207 .section .coupon > div{width:570px;float:left;text-align:left;}
.evt112207 .section .coupon > div a{position:relative;width:100%;height:217px;display:block;}
.evt112207 .section .coupon > div a .left{position:absolute;top:112px;left:98px;}
.evt112207 .section .coupon > div a .right{position:absolute;top:112px;left:292px;}
.evt112207 .section .coupon > div.coupon_r a .left{position:absolute;top:112px;left:114px;}
.evt112207 .section .coupon > div.coupon_r a .right{position:absolute;top:112px;left:306px;}
.evt112207 .section .coupon > div a .price{color:#fe3e00;font-size:28px;font-weight:bold;line-height:28px;}
.evt112207 .section .coupon > div a .price s{display:block;color:rgba(255,255,255,0.5);font-size:20px;font-style:italic;font-weight:lighter;}

/* section01 */
.evt112207 .section01{background:url(//webimage.10x10.co.kr/fixevent/event/2021/112207/coupon01.jpg?v=4)no-repeat 50% 0;height:1410px;}/* 2021.06.18 손지수 이미지 업로드 */

/* section02 */
.evt112207 .section02{background:url(//webimage.10x10.co.kr/fixevent/event/2021/112207/coupon02.jpg?v=4)no-repeat 50% 0;height:1539px;}
.evt112207 .section02 .coupon_go{position:absolute;bottom:0;width:1140px;height:220px;}
.evt112207 .section02 .coupon_go a{display:block;width:100%;height:100%;}

/* section03 */
.evt112207 .section03{background:url(//webimage.10x10.co.kr/fixevent/event/2021/112207/coupon_shinhan.jpg?v=2)no-repeat 50% 0;height:390px;}
.evt112207 .section03 a{width:100%;height:100%;display:block;}

/* section04 */
.evt112207 .section04{background:url(//webimage.10x10.co.kr/fixevent/event/2021/112207/banner.jpg)no-repeat 50% 0;height:807px;}
.evt112207 .section04 .banner{padding-top:344px;height:286px;}
.evt112207 .section04 .banner a{width:570px;height:143px;float:left;}
</style>
<script type="text/javascript" src="/event/etc/json/js_applyItemInfo_112207.js?v=1.01"></script>
<script>
$(function(){
    <% IF application("Svr_Info") = "Dev" THEN %>
    codeGrp = [3369684,3369682,3369677,3369670];
    <% Else %>
    codeGrp = [3880883,3818345,3874291,2453471];
    <% End If %>
    var $rootEl = $("#itemList");
    var itemEle = tmpEl = "";
    var ix1 = 1;
    $rootEl.empty();
    codeGrp.forEach(function(item){
        if(ix1%2 == 0){
            tmpEl = '<a href="" onclick="goProduct('+item+');return false;">\
                        <div class="price right"><s>정가</s><em>할인가</em>원</div>\
                    </a>\
                    '
            
        }else{
            tmpEl = '<a href="" onclick="goProduct('+item+');return false;">\
                        <div class="price left"><s>정가</s><em>할인가</em>원</div>\
                    </a>\
                    '
        }
        itemEle += tmpEl;
        ++ix1;
    });
    itemEle = itemEle + '<a href="#mapGroup370939" class="more_items"></a>';
    $rootEl.append(itemEle);

    fnApplyItemInfoList({
        items:codeGrp,
        target:"itemList",
        fields:["price"],
        unit:"none",
        saleBracket:false
    });

    <% IF application("Svr_Info") = "Dev" THEN %>
    codeGrp2 = [3369684,3369682,3369677,3369670];
    <% Else %>
    codeGrp2 = [3471364,3868587,2840663,3466746];
    <% End If %>
    var $rootEl2 = $("#itemList2");
    var itemEle2 = tmpEl2 = "";
    var ix2 = 1;
    $rootEl2.empty();
    codeGrp2.forEach(function(item){
        if(ix2%2 == 0){
            tmpEl2 = '<a href="" onclick="goProduct('+item+');return false;">\
                        <div class="price left"><s>정가</s><em>할인가</em>원</div>\
                    </a>\
                    '
            
        }else{
            tmpEl2 = '<a href="" onclick="goProduct('+item+');return false;">\
                        <div class="price right"><s>정가</s><em>할인가</em>원</div>\
                    </a>\
                    '
        }
        itemEle2 += tmpEl2;
        ++ix2;
    });
    itemEle2 = itemEle2 + '<a href="#mapGroup370940" class="more_items"></a>';
    $rootEl2.append(itemEle2);

    fnApplyItemInfoList2({
        items:codeGrp2,
        target:"itemList2",
        fields:["price"],
        unit:"none",
        saleBracket:false
    });

    <% IF application("Svr_Info") = "Dev" THEN %>
    codeGrp3 = [3369684,3369682,3369677,3369670];
    <% Else %>
    codeGrp3 = [2791610,2255061,3740712,3231840];
    <% End If %>
    var $rootEl3 = $("#itemList3");
    var itemEle3 = tmpEl3 = "";
    var ix3 = 1;
    $rootEl3.empty();
    codeGrp3.forEach(function(item){
        if(ix3%2 == 0){
            tmpEl3 = '<a href="" onclick="goProduct('+item+');return false;">\
                        <div class="price right"><s>정가</s><em>할인가</em>원</div>\
                    </a>\
                    '
            
        }else{
            tmpEl3 = '<a href="" onclick="goProduct('+item+');return false;">\
                        <div class="price left"><s>정가</s><em>할인가</em>원</div>\
                    </a>\
                    '
        }
        itemEle3 += tmpEl3;
        ++ix3;
    });
    itemEle3 = itemEle3 + '<a href="#mapGroup370941" class="more_items"></a>';
    $rootEl3.append(itemEle3);

    fnApplyItemInfoList3({
        items:codeGrp3,
        target:"itemList3",
        fields:["price"],
        unit:"none",
        saleBracket:false
    });

    <% IF application("Svr_Info") = "Dev" THEN %>
    codeGrp4 = [3369684,3369682,3369677,3369670];
    <% Else %>
    codeGrp4 = [3901824,1312203,3853712,2368844];
    <% End If %>
    var $rootEl4 = $("#itemList4");
    var itemEle4 = tmpEl4 = "";
    var ix4 = 1;
    $rootEl4.empty();
    codeGrp4.forEach(function(item){
        if(ix4%2 == 0){
            tmpEl4 = '<a href="" onclick="goProduct('+item+');return false;">\
                        <div class="price left"><s>정가</s><em>할인가</em>원</div>\
                    </a>\
                    '
            
        }else{
            tmpEl4 = '<a href="" onclick="goProduct('+item+');return false;">\
                        <div class="price right"><s>정가</s><em>할인가</em>원</div>\
                    </a>\
                    '
        }
        itemEle4 += tmpEl4;
        ++ix4;
    });
    itemEle4 = itemEle4 + '<a href="#mapGroup370942" class="more_items"></a>';
    $rootEl4.append(itemEle4);

    fnApplyItemInfoList4({
        items:codeGrp4,
        target:"itemList4",
        fields:["price"],
        unit:"none",
        saleBracket:false
    });
});

// 상품 링크 이동
function goProduct(itemid) {
    parent.location.href='/shopping/category_prd.asp?itemid='+itemid;
    return false;
}
</script>
						<div class="evt112207">
							<p class="go_coupon">
								<a href="http://www.10x10.co.kr/my10x10/couponbook.asp?tab=2"></a>
							</p>	
							<p class="bg_title"></p>
							<section class="section section01">
								<div class="coupon">
									<div class="coupon_3000" id="itemList"></div>
									<div class="coupon_10000 coupon_r" id="itemList2"></div>			
								</div>													
							</section>
							<section class="section section02">
								<div class="coupon">
									<div class="coupon_3000" id="itemList3"></div>
									<div class="coupon_10000 coupon_r" id="itemList4"></div>
									<p class="coupon_go">
										<a href="http://www.10x10.co.kr/my10x10/couponbook.asp?tab=2"></a>
									</p>
								</div>								
							</section>
							<% If currentDate >= #2021-06-21 00:00:00# Then %>
							<section class="section section03">
								<a href="/event/eventmain.asp?eventid=112094"></a>
							</section>
                            <% end if %>
							<section class="section section04">
								<div class="banner">
									<a href="/event/eventmain.asp?eventid=111787"></a>
									<a href="/event/eventmain.asp?eventid=111775"></a>
									<a href="/event/eventmain.asp?eventid=112025"></a>
									<a href="/event/eventmain.asp?eventid=111766"></a>
								</div>
							</section>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->
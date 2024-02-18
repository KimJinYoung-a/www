<%
    '// 앱쿠폰 다운 6/10 ~ 6/30
    dim appDownCouponCode, alertMsg, currentDate
    dim bannerImg
    dim bannerLyrImg

    currentDate = date()
    'test
    'currentDate = Cdate("2019-09-13")


    if currentDate <= Cdate("2019-08-31") then
        appDownCouponCode = "1183"
        alertMsg = "쿠폰이 발급되었습니다!\nAPP에서 5만원 이상 구매 시 사용 가능합니다."
        bannerImg = "//fiximage.10x10.co.kr/web2019/common/bnr_coupon_0816.png"
        bannerLyrImg = "//fiximage.10x10.co.kr/web2019/common/bnr_coupon_done_0805.png"            
    end if
    if currentDate >= Cdate("2019-09-01") then
        appDownCouponCode = "1203"
        alertMsg = "쿠폰이 발급되었습니다!\nAPP에서 5만원 이상 구매 시 사용 가능합니다."
        bannerImg = "//fiximage.10x10.co.kr/web2019/common/bnr_coupon_0902.png"
        bannerLyrImg = "//fiximage.10x10.co.kr/web2019/common/bnr_coupon_done_0902.png"            
    end if        
%>
<script>
    function jsEvtCouponDown(stype,idx) {
        <% If IsUserLoginOK() Then %>
            fnAmplitudeEventMultiPropertiesAction("click_appcoupondown_banner","","");

            var str = $.ajax({
                type: "POST",
                url: "/event/etc/coupon/couponshop_process.asp",
                data: "mode=cpok&stype="+stype+"&idx="+idx,
                dataType: "text",
                async: false
            }).responseText;
            var str1 = str.split("||")
            if (str1[0] == "11"){
                viewPoupLayer('modal', $('#lyr-coupon').html())
                return false;
            }else if (str1[0] == "12"){
                alert('기간이 종료되었거나 유효하지 않은 쿠폰입니다.');
                return false;
            }else if (str1[0] == "13"){
                alert('이미 다운로드 받으셨습니다.');
                return false;
            }else if (str1[0] == "02"){
                alert('로그인 후 쿠폰을 받을 수 있습니다!');
                return false;
            }else if (str1[0] == "01"){
                alert('잘못된 접속입니다.');
                return false;
            }else if (str1[0] == "00"){
                alert('정상적인 경로가 아닙니다.');
                return false;
            }else{
                alert('오류가 발생했습니다.');
                return false;
            }
        <% Else %>
            jsChklogin('<%=IsUserLoginOK%>');
            return;
        <% End IF %>
    }
    function linkTo(){
        fnAmplitudeEventMultiPropertiesAction("click_appcoupondown_banner","","");
        <% If IsUserLoginOK() Then %>
            //location.href="/event/eventmain.asp?eventid=96304"
            alert('8/27(화)까지 사용 가능한 쿠폰이 발급되었습니다.\n쿠폰함을 확인해주세요!');return false;
        <% Else %>
            jsChklogin('<%=IsUserLoginOK%>');
            return false;
        <% End If %>
    }
    function popupClose(){
        $("#mask").css("display", "none")
        $('.lyr-coupon').css("display", "none")
    }
    function couponAlert(){
        <% If IsUserLoginOK() Then %>
            alert("오늘 하루만 사용 가능한 쿠폰이 발급되었습니다. 쿠폰함을 확인해주세요!");
        <% Else %>
            jsChklogin('<%=IsUserLoginOK%>');
            return false;
        <% End IF %>
    }
</script>
<style>
.bnr-coupon {display:block; margin-top:10px; margin-bottom:-10px; cursor:pointer;}
.bnr-coupon img {width:440px;}
.lyr-coupon {position:relative;}
.lyr-coupon img {width:412px; height:296px; vertical-align:top;}
.lyr-coupon .btn-close {position:absolute; top:0; right:0; width:60px; height:60px; text-indent:-999em; background-color:transparent;}
</style>
<% If currentDate >= Cdate("2019-08-26") And currentDate < Cdate("2019-08-28") Then %>
    <% If currentDate = Cdate("2019-08-26") Then %>
        <a href="javascript:void(0)" onclick="linkTo()" class="bnr-coupon"><img src="//fiximage.10x10.co.kr/web2019/common/bnr_coupon_0826.png" alt="coupon 40,000원 내일까지 사용 가능한 즉시 할인 쿠폰!"></a>
    <% End if %>
    <% If currentDate = Cdate("2019-08-27") Then %>
        <a href="javascript:void(0)" onclick="linkTo()" class="bnr-coupon"><img src="//fiximage.10x10.co.kr/web2019/common/bnr_coupon_0827.png" alt="coupon 40,000원 오늘 자정까지 즉시 할인 쿠폰!"></a>
    <% End If %>
<% else %>
    <div class="bnr-coupon" onclick="jsEvtCouponDown('evtsel','<%= appDownCouponCode %>');"><img src="<%=bannerImg%>" alt="즉시 할인 쿠폰"></div>
<% end if %>
    <div id="lyr-coupon" style="display:none">
        <div class="lyr-coupon window">
            <img src="<%=bannerLyrImg%>" alt="쿠폰이 발급 되었습니다">
            <button type="button" class="btn-close" onclick="popupClose()">레이어 닫기</button>
        </div>
    </div>
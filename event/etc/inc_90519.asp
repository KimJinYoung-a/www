<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 천원의기적2
' History : 2018-11-16 원승현 
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_evaluatesearchercls.asp" -->
<%
    '// 쇼셜서비스로 글보내기 
    Dim vTitle, vLink, vPre, vImg, vIsEnd, vState, vNowTime, vCouponMaxCount
    Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
    snpTitle	= Server.URLEncode("[천원의 기적]")
    snpLink		= Server.URLEncode("http://www.10x10.co.kr/event/eventmain.asp?eventid=90519")
    snpPre		= Server.URLEncode("10x10 이벤트")
    snpImg		= Server.URLEncode("http://webimage.10x10.co.kr/eventIMG/2018/90519/banMoList20181115102416.JPEG")


    '// Facebook 오픈그래프 메타태그 작성
    strPageTitle = "[천원의 기적]"
    strPageKeyword = "[천원의 기적]"
    strPageDesc = "지금 에어팟을 1,000원에 구매할 수 있는\n이벤트에 도전하세요!"
    strPageUrl = "http://www.10x10.co.kr/event/eventmain.asp?eventid=90519"
    strPageImage = "http://webimage.10x10.co.kr/eventIMG/2018/90519/banMoList20181115102416.JPEG"

    '// 일자별 상품코드 변경
    Dim miracleProductCode
    miracleProductCode = ""
    If left(now(),10)>="2018-11-19" and left(now(),10) < "2018-11-20" Then
        miracleProductCode = "2145838"
    End If
    If left(now(),10)>="2018-11-20" and left(now(),10) < "2018-11-21" Then
        miracleProductCode = "2145984"
    End If
    If left(now(),10)>="2018-11-21" and left(now(),10) < "2018-11-22" Then
        miracleProductCode = "2146034"
    End If        

    Dim userAirPotEventOrderCount
    userAirPotEventOrderCount = 0
    If IsUserLoginOK() Then
        If Trim(miracleProductCode) <> "" Then
            '// 사용자의 해당일자 상품의 결제내역을 확인한다.
            Dim sqlstr
            sqlStr = ""
            sqlStr = sqlStr & " select count(m.userid) from db_order.dbo.tbl_order_master as m " &VBCRLF
            sqlStr = sqlStr & " 	inner join db_order.dbo.tbl_order_detail as d " &VBCRLF
            sqlStr = sqlStr & " 	on m.orderserial=d.orderserial " &VBCRLF
            sqlStr = sqlStr & " 	where m.jumundiv<>'9' and m.ipkumdiv > 3 and m.cancelyn = 'N' " &VBCRLF
            sqlStr = sqlStr & " 	and d.cancelyn<>'Y' and d.itemid<>'0' And m.userid='"&GetEncLoginUserId&"' " &VBCRLF
            sqlStr = sqlStr & " 	and d.itemid='"&miracleProductCode&"' " &VBCRLF
            rsget.Open sqlStr, dbget, 1
            userAirPotEventOrderCount = rsget(0)
            rsget.Close
        End If
    End If
%>
<style type="text/css">
.evt90519 {width:1140px; margin:0 auto;}
.evt90519 .inner {position:relative;}
.evt90519 .inner span {position:absolute; right:360px; top:300px; animation:shake 1.5s linear infinite;}
.evt90519 .bnr-evt {margin-top:10px;}
.evt90519 .btn-deposit {display:block; position:absolute; left:643px; top:866px; width: 113px; height: 35px; text-indent: -9999px;}
.evt90519 .btn-deposit.dday {left:650px; top:1105px;}
.evt90519 .btn-buy {position: absolute; left: 50%; top:665px; margin-left: -209px;}
.evt90519 .btn-buy.after {top: 652px; margin-left: -237px; }
.evt90519 .btn-buy.dday {top: 840px; margin-left: -35px;}
.evt90519 .bnr-sns {position: absolute; top:-1px; right: 38px; width: 157px; height: 135px; padding-top:75px; box-sizing: border-box; background-image: url('http://webimage.10x10.co.kr/fixevent/event/2018/90519/btn_sns.png');}
.evt90519 .bnr-sns a {display: inline-block; width: 54px; height: 37px; text-indent: -9999px }
.evt90519 .vod-area {position: absolute; top:305px; left: 50%; margin-left: -230px; width: 455px; height: 455px; overflow: hidden;}
.evt90519 .noti {position: relative; padding: 60px 0 60px 300px ; background-color: #0f1c5b;}
.evt90519 .noti img {position: absolute; top: 120px; left: 180px;}
.evt90519 .noti li {color: #e6e7f0; text-align: left; font: 12px/27px "malgun Gothic","맑은고딕", Dotum, "돋움", sans-serif; }
.evt90519 .noti li:before {content: '·'; display: inline-block; width: 10px; margin-left: -10px; }
.evt90519 .noti li a {margin-left: 10px; padding: 2px 15px 2px 10px; color: #fff; background-color: #6a00d6;}
.evt90519 .noti li a:hover {text-decoration: none;}
.evt90519 .noti li a em {display: inline-block; position: relative; top: 12px; left: 3px; width: 4px; height: 4px; text-indent: -9999px; transform: rotate(45deg); border-top: solid 1px #fff; border-right: solid 1px #fff;}
@keyframes shake { 0%{transform:translateY(10px);} 50%{transform:translateY(0);} 100%{transform:translateY(10px);} }
</style>
<script type="text/javascript">
function snschk(snsnum) {
	if(snsnum == "tw") {
		popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');
	}else if(snsnum=="fb"){
		popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');
	}else if(snsnum=="pt"){
		pinit('<%=snpLink%>','<%=snpImg%>');
	}
}

function TnAddShoppingBag90519(){
    <% If not(IsUserLoginOK) Then %>
        top.location.href="/login/loginpage.asp?vType=G";
        return false;
    <% end if %>
    <% If userAirPotEventOrderCount > 0 Then %>
        alert('고객님께서는 이벤트 상품을 이미 주문하셨습니다.\n한 ID당 하루에 최대 1개까지 주문 가능');
        return false;
    <% End If %>
    <% If Trim(miracleProductCode) = "" Then %>
        alert('이벤트 기간이 아닙니다.');
        return false;
    <% End If %>

    document.directOrd.submit();
}

function PopupNews90519(){
    var popwin = window.open('/common/news_list.asp?type=03','popupnews', 'width=580,height=800,left=300,top=100,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no');
    popwin.focus();
}

</script>
<%' 90519 천원의기적 에어팟 %>
<div class="evt90519">
    <div class="inner">

        <%'이벤트 응모기간이 끝나고 11월 26일까지 보여줘야 되는 버튼 출력부 %>
        <% If left(now(),10)>="2018-11-22" and left(now(),10) < "2018-11-26" Then %>
            <p><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90519/img_miracle_after.png" alt="천원의 기적" /></p>
            <span><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90519/img_winner_after.png" alt="당첨자 20명" /></span>        
            <a href="#" class="btn-buy after"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90519/btn_buy_after.png" alt="구매하러 가기"></a>
            <a href="/my10x10/myTenCash.asp" class="btn-deposit">예치금이란?</a>                        
        <%'이벤트 당첨자 발표(11월26일)에 보여줘야 되는 출력부 %>
        <% ElseIf left(now(),10)>="2018-11-26" Then %>
            <p><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90519/img_miracle_dday.png" alt="천원의 기적" /></p>
            <%' 영상 %>
            <div class="vod-area">
                <iframe src="https://player.vimeo.com/video/302397662" width="455" height="455" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
            </div>
            <a href="" onclick="PopupNews90519();return false;" class="btn-buy dday"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90519/btn_buy_dday.png" alt="당첨자 확인하러 가기"></a>
            <a href="/my10x10/myTenCash.asp" class="btn-deposit dday">예치금이란?</a>            
        <% Else %>
            <p><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90519/img_miracle.png" alt="천원의 기적" /></p>
            <span><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90519/img_winner.png" alt="당첨자 20명" /></span>        
            <a href="" onclick="TnAddShoppingBag90519();return false;" class="btn-buy"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90519/btn_buy.png" alt="구매하러 가기"></a>
            <a href="/my10x10/myTenCash.asp" class="btn-deposit">예치금이란?</a>            
        <% End If %>
        
        <% If left(now(),10) < "2018-11-22" Then %>
            <div class="bnr-sns">
                <a href="" onclick="snschk('fb');return false;" alt="페이스북 공유하기">facebook</a>
                <a href="" onclick="snschk('tw');return false;" alt="트위트 공유하기">tweet</a>
            </div>
        <% End If %>
    </div>
    <div class="noti">
        <img src="http://webimage.10x10.co.kr/fixevent/event/2018/90519/txt_noti.png" alt="유의사항">
        <ul>
            <li>본 이벤트는 텐바이텐 회원만 참여할 수 있습니다.</li>
            <li>당첨자에게는 상품에 따라 세무 신고에 필요한 개인 정보를   요청할 수 있습니다. (제세공과금은 텐바이텐이 부담합니다.)</li>
            <li>본 이벤트의 상품은 즉시 결제로만 구매할 수 있으며, 해당 이벤트에 응모하신 후 당첨자 발표 이후에는 취소나 환불 처리가 되지 않습니다.</li>
            <li>예치금은 현금 반환 요청이 가능하며, 고객행복센터 또는 1:1 게시판으로 문의하시면 반환 안내를 도와드립니다.</li>
            <li>본 이벤트는 ID 당 하루에 1회만 구매(응모) 가능합니다. 이벤트 기간 동안 총 3회 구매(응모) 가능합니다.</li>
            <li>당첨자 20명은 11월 26일(월) 텐바이텐 웹사이트 하단 공지사항에 공지됩니다. 
                <a href="" onclick="PopupNews90519();return false;">공지사항 바로가기<em>go</em></a>
            </li>
        </ul>
    </div>
</div>
<%' // 90519 천원의기적 에어팟 %>
<form method="post" name="directOrd" action="/inipay/shoppingbag_process.asp">
	<input type="hidden" name="itemid" value="<%=miracleProductCode%>">
	<input type="hidden" name="itemoption" value="0000">
	<input type="hidden" name="itemea" value="1">
	<input type="hidden" name="mode" value="DO1">
</form>
<!-- #include virtual="/lib/db/dbclose.asp" -->
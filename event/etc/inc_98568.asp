<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : MD 기획전 블랙프라이데이 이벤트
' History : 2019-11-14 원승현
'####################################################
%>
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%

dim eCode, userid
IF application("Svr_Info") = "Dev" THEN
	eCode = "90429"
Else
	eCode = "98568"
End If

userid = GetEncLoginUserID()

dim eventEndDate, currentDate, eventStartDate
dim subscriptcount  
dim evtinfo : evtinfo = getEventDate(eCode)

if not isArray(evtinfo) then
	Call Alert_Return("잘못된 이벤트번호입니다.")
	dbget.close()	:	response.End
end if

'변수 초기화
eventStartDate = cdate(evtinfo(0,0))
eventEndDate = cdate(evtinfo(1,0))
currentDate = date()
'currentDate = Cdate("2019-05-04")
'// 오픈시 주석 제거해줘야됨.
'eventStartDate = cdate("2019-11-14")
%>
<style>
.evt98568 {background-color:#fff;}
.evt98568 .topic {position:relative; height:840px; background:#121212 url(//webimage.10x10.co.kr/fixevent/event/2019/98568/bg_topic.jpg) 50% 0 no-repeat;}
.evt98568 .topic h2, .evt98568 .topic p,.evt98568 .topic h2, .evt98568 .topic .line {position:absolute; left:50%; margin-left:-570px; opacity:0; transition:.8s;}
.evt98568 .topic h2 {top:205px; transform:translateX(5px); }
.evt98568 .topic .sub {top:213px; margin-left:-222px; transform:translateX(-10px); transition-delay:0.5s;}
.evt98568 .topic .txt {top:463px; padding-left:20px; transform:translateX(10px);}
.evt98568 .topic .line {display:inline-block; top:463px; width:1px; height:0; background-color:#d0d0d0; transition:1.3s;}
.evt98568 .topic.on h2, .evt98568 .topic.on p {transform:translateY(0); opacity:1;}
.evt98568 .topic.on .sub {top:213px; margin-left:-222px; }
.evt98568 .topic.on .txt {top:463px; padding-left:20px; transition-delay:.7s;}
.evt98568 .topic.on .line {height:70px; opacity:1;}
.evt98568 .date-tab {position:absolute; left:50%; bottom:0; margin-left:-555px;}
.evt98568 .date-tab span {position:absolute; left:50%; top:-58px; margin-left:-61px; animation:bounce 1s 100;}
.evt98568 .friday-container {width:960px; margin:0 auto; padding:95px 0 100px; text-align:left;}
.evt98568 .friday-cont .tit {position:relative; height:40px; margin-bottom:20px; border-bottom:4px solid #000;}
.evt98568 .friday-cont .tit a {position:absolute; right:0; top:-7px;}
.evt98568 .item-list {overflow:hidden; padding-bottom:72px;}
.evt98568 .item-list li {float:left; width:300px; margin-left:30px;}
.evt98568 .item-list li:first-child {margin-left:0;}
.evt98568 .item-list li a {display:block; position:relative; text-decoration:none;}
.evt98568 .item-list li a:after {content:''; position:absolute; right:0; top:250px; width:50px; height:50px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/98568/ico_plus.png) no-repeat 0 0;}
.evt98568 .item-list .price {padding-top:8px; font:bold 18px/1 verdana; color:#ff4040;}
.evt98568 .item-list .price s {padding-right:5px; font-size:16px; font-weight:normal; color:#959595;}
.evt98568 .item-list .price span {display:none;}
.evt98568 .brand-list {overflow:hidden; margin:-20px -20px 0 0;}
.evt98568 .brand-list li {position:relative; float:left; padding:20px 20px 0 0;}
.evt98568 .brand-list li a {display:block; width:235px; height:50px; position:absolute; left:0; bottom:0; text-indent:-999em;}
.evt98568 .brand-list li a.btn-go {left:235px;}
.evt98568 .evt-noti {background-color:#121212;}
@keyframes bounce {
    from, to {transform:translateY(0); animation-timing-function:ease-in;}
    50% {transform:translateY(10px); animation-timing-function:ease-out;}
}
</style>
<script type="text/javascript" src="/event/etc/json/js_applyItemInfo.js"></script>
<script type="text/javascript">
$(function(){
	$('.evt98568 .topic').addClass('on');
	fnApplyItemInfoToTalPriceList({
		items:"2172733,2567787,2453463",
		target:"list1",
		fields:["price","sale"],
		unit:"ew",
		saleBracket:false
    });
    fnApplyToTalPriceItem({
		items:"2368878,1922074",
		target:"item",
		fields:["price","sale"],
		unit:"ew",
		saleBracket:false
    });
});

function jsDownCoupon(cType){
	<% if not (currentDate >= eventStartDate and currentDate <= eventEndDate) then %>	
		alert("이벤트 참여기간이 아닙니다.");
		return false;
    <% end if %>
    
    <% if Not(IsUserLoginOK) then %>
        jsEventLogin();
    <% else %>
        $.ajax({
            type: "post",
            url: "/event/etc/doeventsubscript/doEvenSubscript98568.asp",		
            data: {
                eCode: '<%=eCode%>',
                couponType: cType
            },
            cache: false,
            success: function(resultData) {
                fnAmplitudeEventMultiPropertiesAction('click_coupon_btn','evtcode|couponType','<%=eCode%>|'+cType)
                var reStr = resultData.split("|");				
                
                if(reStr[0]=="OK"){		
                    alert('쿠폰이 발급 되었습니다.\n주문시 사용 가능합니다.');
                }else{
                    var errorMsg = reStr[1].replace(">?n", "\n");
                    alert(errorMsg);					
                }			
            },
            error: function(err) {
                console.log(err.responseText);
            }
        });
    <% end if %>
}

function jsEventLogin(){
	if(confirm("로그인을 하셔야 쿠폰을 발급 받으실 수 있습니다.")){
		location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
		return;
	}
}
</script>
<%' 98568 디지털가전 블랙프라이데이 %>
<div class="evt98568">
    <div class="topic">
        <h2><img src="//webimage.10x10.co.kr/fixevent/event/2019/98568/tit_black_friday.png" alt="TEN'S BLACK FRIDAY"></h2>
        <p class="sub"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98568/tit_every.png" alt="매주 금요일엔 디지털가전 블랙프라이데이"></p>
        <p class="txt"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98568/txt_subcopy.png" alt="11월 8일, 15일, 22일 매주 금요일마다 새로운 특가 상품과 스페셜 쿠폰으로 돌아옵니다 디지털가전 특가 구매찬스를 놓치지마세요!"></p>
        <span class="line"></span>
        <div class="date-tab">
            <img src="//webimage.10x10.co.kr/fixevent/event/2019/98568/txt_tab.png?v=2" alt="">
            <span><img src="//webimage.10x10.co.kr/fixevent/event/2019/98568/txt_onsale.png" alt="ON SALE"></span>
        </div>
    </div>
    <div class="friday-container">
        <div class="friday-cont">
            <div class="tit">
                <h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/98568/tit_digital.png" alt="DIGITAL"></h3>
                <a href="#mapGroup306301"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98568/btn_more.png" alt="MORE ITEM"></a>
            </div>
            <ul id="list1" class="item-list">
                <li>
                    <a href="/shopping/category_prd.asp?itemid=2172733&pEtr=98568">
                        <img src="//webimage.10x10.co.kr/fixevent/event/2019/98568/img_digital_1.jpg" alt="이그닉 바이북">
                        <p class="price"><s>456,000</s>123,000won</p>
                    </a>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=2567787&pEtr=98568">
                        <img src="//webimage.10x10.co.kr/fixevent/event/2019/98568/img_digital_2.jpg" alt="샤오미 에어닷">
                        <p class="price"><s>456,000</s>123,000won</p>
                    </a>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=2453463&pEtr=98568">
                        <img src="//webimage.10x10.co.kr/fixevent/event/2019/98568/img_digital_3.jpg" alt="로지텍 무선마우스">
                        <p class="price"><s>456,000</s>123,000won</p>
                    </a>
                </li>
            </ul>
        </div>
        <div class="friday-cont">
            <div class="tit">
                <h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/98568/tit_design.png" alt="DESIGN"></h3>
                <a href="#mapGroup306302"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98568/btn_more.png" alt="MORE ITEM"></a>
            </div>
            <ul id="list2" class="item-list">
                <li class="item2368878">
                    <a href="/shopping/category_prd.asp?itemid=2368878&pEtr=98568">
                        <img src="//webimage.10x10.co.kr/fixevent/event/2019/98568/img_design_1.jpg" alt="네스프레소 에센자미니 D30 레드">
                        <p class="price"><s>456,000</s>123,000won</p>
                    </a>
                </li>
                <li>
                    <a href="/shopping/category_prd.asp?itemid=2512431&pEtr=98568">
                        <img src="//webimage.10x10.co.kr/fixevent/event/2019/98568/img_design_2.jpg" alt="발뮤다 가습기">
                        <p class="price"><s>699,000won</s>489,000won</p>
                    </a>
                </li>
                <li class="item1922074">
                    <a href="/shopping/category_prd.asp?itemid=1922074&pEtr=98568">
                        <img src="//webimage.10x10.co.kr/fixevent/event/2019/98568/img_design_3.jpg" alt="라쿠진 핸디형 터보 스팀다리미">
                        <p class="price"><s>456,000</s>123,000won</p>
                    </a>
                </li>
            </ul>
        </div>
        <div class="friday-cont">
            <div class="tit">
                <h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/98568/tit_brand.png" alt="BRAND COUPON"></h3>
            </div>
            <%' 브랜드 쿠폰 다운로드 %>
            <%' 쿠폰 받기 클릭 시 메세지:
                '처음 클릭 - 발급 되었습니다. 주문시 사용 가능합니다.
                '중복 클릭 - 이미 발급된 쿠폰입니다. 구매 페이지에서 적용 가능합니다.
            %>
            <ul class="brand-list">
                <li>
                    <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/98568/bnr_brand_1.jpg" alt="BT21"></div>
                    <a href="" onclick="jsDownCoupon('cBt21');return false;" class="btn-coupon">BT21 쿠폰 받기</a>
                    <a href="/event/eventmain.asp?eventid=98770" class="btn-go">BT21 상품 보러가기</a>
                </li>
                <li>
                    <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/98568/bnr_brand_2.jpg" alt="카카오프렌즈"></div>
                    <a href="" onclick="jsDownCoupon('cKakaoF');return false;" class="btn-coupon">카카오프렌즈 쿠폰 받기</a>
                    <a href="/event/eventmain.asp?eventid=98772" class="btn-go">카카오프렌즈 상품 보러가기</a>
                </li>
                <li>
                    <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/98568/bnr_brand_3.jpg" alt="샤오미"></div>
                    <a href="" onclick="jsDownCoupon('cXiaomi');return false;" class="btn-coupon">샤오미 쿠폰 받기</a>
                    <a href="/event/eventmain.asp?eventid=98695" class="btn-go">샤오미 상품 보러가기</a>
                </li>
                <li>
                    <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/98568/bnr_brand_4.jpg" alt="오아"></div>
                    <a href="" onclick="jsDownCoupon('cOa');return false;" class="btn-coupon">오아 쿠폰 받기</a>
                    <a href="/event/eventmain.asp?eventid=98771" class="btn-go">오아 상품 보러가기</a>
                </li>
            </ul>
            <%'// 브랜드 쿠폰 다운로드%>
        </div>
    </div>
    <div class="evt-noti">
        <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/98568/txt_noti.png" alt=""></div>
    </div>
</div>
<%'// 98568 디지털가전 블랙프라이데이 %>
<!-- #include virtual="/lib/db/dbclose.asp" -->
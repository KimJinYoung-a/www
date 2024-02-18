<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : MD 기획전 패션뷰티 할인 이벤트
' History : 2019-12-06 원승현
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
	eCode = "90438"
Else
	eCode = "99159"
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
'// STAFF 아이디는 테스트를 위해 시작일을 테스트 일자로 부터 시작하게 변경
If GetLoginUserLevel() = "7" Then
    eventStartDate = cdate("2019-12-06")
End If
%>
<style>
.evt99159 {position:relative; background-color:#fff;}
.evt99159 .topic {background:#fdcbca url(//webimage.10x10.co.kr/fixevent/event/2019/99159/bg_topic.jpg) 50% 0 no-repeat;}
.evt99159 .topic h2 {opacity:0; transform:scale(1.05); transition:1s;}
.evt99159 .topic.on h2 {opacity:1; transform:scale(1);}
.evt99159 .section {position:relative;}
.evt99159 .s1 {height:1078px; background:#f9f2e6 url(//webimage.10x10.co.kr/fixevent/event/2019/99159/bg_s1.png) 50% 0 no-repeat;}
.evt99159 .s2 {height:1067px; background:#ffcdb8 url(//webimage.10x10.co.kr/fixevent/event/2019/99159/bg_s2.png) 50% 0 no-repeat;}
.evt99159 .s3 {height:1064px; background:#f9f2e6 url(//webimage.10x10.co.kr/fixevent/event/2019/99159/bg_s3.png) 50% 0 no-repeat;}
.evt99159 .s4 {height:1067px; background:#ffcdb8 url(//webimage.10x10.co.kr/fixevent/event/2019/99159/bg_s4.png) 50% 0 no-repeat;}
.evt99159 .slider {position:relative; overflow:hidden; left:50%; width:1680px; height:660px; margin-left:-840px;}
.evt99159 .slider .slick-slide a {display:block; width:540px; margin:0 10px;}
.evt99159 .slider .slick-arrow {top:0; width:540px; height:660px; background:rgba(0,0,0,0.5) url(//webimage.10x10.co.kr/fixevent/event/2019/99159/ico_arrow.png) 30px 50% no-repeat;}
.evt99159 .slider .slick-prev {left:10px; transform:scaleX(-1);}
.evt99159 .slider .slick-next {right:10px;}
.evt99159 .coupon {position:relative; height:1079px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/99159/bg_cpn.png) 50% 0 no-repeat;}
.evt99159 .popup {display:none; position:absolute; left:50%; top:-102px; width:1140px; margin-left:-570px; background-color:#ffebe3; box-shadow:8px 10px 30px rgba(212,94,94,0.3); transition:1s;}
.evt99159 .popup .btn-close {position:absolute; top:56px; right:92px; width:45px; height:45px; font-size:0; color:transparent; background:url(//webimage.10x10.co.kr/fixevent/event/2019/99159/btn_close.gif) 50% no-repeat;}
.evt99159 map area {cursor:pointer; outline:0;}
</style>
<script type="text/javascript" src="/event/etc/json/js_applyItemInfo.js"></script>
<script type="text/javascript">
$(function(){
	$('.evt99159 .topic').addClass('on');
	$('.evt99159 .slider1').slick({
		autoplay: true,
		slidesToShow: 3,
		centerMode: true,
		centerPadding: '0px'
	});
	$('.evt99159 .slider2').slick({
		autoplay: true,
		slidesToShow: 3,
		centerMode: true,
		centerPadding: '0px'
	});
	$('.evt99159 .slider3').slick({
		autoplay: true,
		slidesToShow: 3,
		centerMode: true,
		centerPadding: '0px'
	});
	$('.evt99159 .slider4').slick({
		autoplay: true,
		slidesToShow: 3,
		centerMode: true,
		centerPadding: '0px'
	});
	$('.popup .btn-close').click(function(){
		$('.popup').hide();
	});
});

function getItemInfo(itemId){
	var makerName = []
	var makerID = []
	switch (itemId) {
		case 1 :
			makerName = ["스파오","커먼유니크","유라고","김양리빙","프롬비기닝"]
			makerID = ["spao","commonunique","urago","kimyangliving","beginning0"]
			break;
		case 2 :
			makerName = ["얼모스트블루","아이띵소","닥터마틴","마크모크","폴더"]
			makerID = ["almostblue10","ithinkso","sfootwearhunter","macmoc","folderstyle"]
			break;
		case 3 :
			makerName = ["더블유드레스룸","클레어스","포니이펙트","29데이즈","피에스씨 코스메틱"]
			makerID = ["trendi","klairs","PONYEFFECT","29days","cosmetics"]
			break;
		case 4 :
			makerName = ["마사인더가렛","트랜드메카","JULIUS","OST","CLUE"]
			makerID = ["marthainthegarret","trendmecca","julius10","ost","elandclue"]
			break;
		default :
			break;
	}
	return {
		makerName: makerName,
		makerID: makerID
	}
}

function cpnPopup(idx) {
	$('.popup h4 img').attr("src", "//webimage.10x10.co.kr/fixevent/event/2019/99159/tit_cpn_0"+idx+".png");
	$('.popup p img').attr("src", "//webimage.10x10.co.kr/fixevent/event/2019/99159/img_cpn_0"+idx+".png");
	for (var i = 0; i < 5; i++) {
		var target = $('.link area:nth-child('+(i+1)+')');
		target.attr("href", "/street/street_brand_sub06.asp?makerid=" + getItemInfo(idx).makerID[i] );
		target.attr("alt", getItemInfo(idx).makerName[i] );
	}
	$('.popup').show();
}

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
            url: "/event/etc/doeventsubscript/doEvenSubscript99159.asp",		
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

<%' 99159 패션뷰티 결산베스트 %>
<div class="evt99159">
    <div class="topic">
        <h2><img src="//webimage.10x10.co.kr/fixevent/event/2019/99159/tit_best.png" alt="2019 패션뷰티 결산베스트"></h2>
    </div>
    <section class="section s1">
        <h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/99159/tit_s1.png" alt="패션의류"></h3>
        <div class="slider slider1">
            <div>
                <a href="/shopping/category_prd.asp?itemid=2558780&pEtr=99159">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2019/99159/img_slide1_1.jpg" alt="스파오">
                </a>
            </div>
            <div>
                <a href="/shopping/category_prd.asp?itemid=2583938&pEtr=99159">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2019/99159/img_slide1_2.jpg" alt="커먼유니크">
                </a>
            </div>
            <div>
                <a href="/shopping/category_prd.asp?itemid=2593345&pEtr=99159">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2019/99159/img_slide1_3.jpg" alt="유라고">
                </a>
            </div>
            <div>
                <a href="/shopping/category_prd.asp?itemid=2583915&pEtr=99159">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2019/99159/img_slide1_4.jpg" alt="김양리빙">
                </a>
            </div>
            <div>
                <a href="/shopping/category_prd.asp?itemid=2566592&pEtr=99159">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2019/99159/img_slide1_5.jpg" alt="프롬비기닝">
                </a>
            </div>
        </div>
    </section>
    <section class="section s2">
        <h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/99159/tit_s2.png" alt="패션잡화"></h3>
        <div class="slider slider2">
            <div>
                <a href="/shopping/category_prd.asp?itemid=1984470&pEtr=99159">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2019/99159/img_slide2_1.jpg" alt="얼모스트블루">
                </a>
            </div>
            <div>
                <a href="/shopping/category_prd.asp?itemid=1350644&pEtr=99159">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2019/99159/img_slide2_2.jpg" alt="아이띵소">
                </a>
            </div>
            <div>
                <a href="/shopping/category_prd.asp?itemid=2108758&pEtr=99159">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2019/99159/img_slide2_3.jpg" alt="닥터마틴">
                </a>
            </div>
            <div>
                <a href="/shopping/category_prd.asp?itemid=2565698&pEtr=99159">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2019/99159/img_slide2_4.jpg" alt="마크모크">
                </a>
            </div>
            <div>
                <a href="/shopping/category_prd.asp?itemid=2592365&pEtr=99159">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2019/99159/img_slide2_5_v2.jpg" alt="폴더">
                </a>
            </div>
        </div>
    </section>
    <section class="section s3">
        <h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/99159/tit_s3.png" alt="뷰티"></h3>
        <div class="slider slider3">
            <div>
                <a href="/shopping/category_prd.asp?itemid=1157791&pEtr=99159">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2019/99159/img_slide3_1.jpg" alt="더블유드레스룸">
                </a>
            </div>
            <div>
                <a href="/shopping/category_prd.asp?itemid=863241&pEtr=99159">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2019/99159/img_slide3_2.jpg" alt="클레어스">
                </a>
            </div>
            <div>
                <a href="/shopping/category_prd.asp?itemid=1956792&pEtr=99159">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2019/99159/img_slide3_3.jpg" alt="포니이펙트">
                </a>
            </div>
            <div>
                <a href="/shopping/category_prd.asp?itemid=2522139&pEtr=99159">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2019/99159/img_slide3_4.jpg" alt="29데이즈">
                </a>
            </div>
            <div>
                <a href="/shopping/category_prd.asp?itemid=2593945&pEtr=99159">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2019/99159/img_slide3_5.jpg" alt="피에스씨 코스메틱">
                </a>
            </div>
        </div>
    </section>
    <section class="section s4">
        <h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/99159/tit_s4.png" alt="주얼리"></h3>
        <div class="slider slider4">
            <div>
                <a href="/shopping/category_prd.asp?itemid=1820720&pEtr=99159">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2019/99159/img_slide4_1.jpg" alt="마사인더가렛">
                </a>
            </div>
            <div>
                <a href="/shopping/category_prd.asp?itemid=2501734&pEtr=99159">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2019/99159/img_slide4_2.jpg" alt="TRENDMECCA">
                </a>
            </div>
            <div>
                <a href="/shopping/category_prd.asp?itemid=2599376&pEtr=99159">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2019/99159/img_slide4_3.jpg" alt="CLUE">
                </a>
            </div>
            <div>
                <a href="/shopping/category_prd.asp?itemid=1883102&pEtr=99159">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2019/99159/img_slide4_4.jpg" alt="JULIUS">
                </a>
            </div>
            <div>
                <a href="/shopping/category_prd.asp?itemid=2208460&pEtr=99159">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2019/99159/img_slide4_5.jpg" alt="OST">
                </a>
            </div>
        </div>
    </section>
    <div class="coupon">
        <h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/99159/tit_cpn.png" alt="BRAND COUPON"></h3>
        <div class="cpn-list">
            <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/99159/img_cpn_v2.png" alt="쿠폰북" usemap="#book"></p>
            <map name="book">
                <area shape="rect" coords="80,60,550,250" onclick="cpnPopup(1)" alt="패션의류" />
                <%' for dev msg : 패션의류 쿠폰 ID (1252,1253,1254,1255,1256) %>
                <area shape="rect" coords="80,250,550,300" onclick="jsDownCoupon('cFashioncloth');return false;" alt="패션의류 쿠폰 전체 다운받기" />

                <area shape="rect" coords="590,60,1060,250" onclick="cpnPopup(2)" alt="패션잡화" />
                <%' for dev msg : 패션잡화 쿠폰 ID (1264,1265,1266,1267,1268) %>
                <area shape="rect" coords="590,250,1060,300" onclick="jsDownCoupon('cFashiongoods');return false;" alt="패션잡화 쿠폰 전체 다운받기" />

                <area shape="rect" coords="80,340,550,530" onclick="cpnPopup(3)" alt="뷰티" />
                <%' for dev msg : 뷰티 쿠폰 ID (1263,1259,1260,1261,1262) %>
                <area shape="rect" coords="80,530,550,580" onclick="jsDownCoupon('cBeauty');return false;" alt="뷰티 쿠폰 전체 다운받기" />

                <area shape="rect" coords="590,340,1060,530" onclick="cpnPopup(4)" alt="주얼리" />
                <%' for dev msg : 주얼리 쿠폰 ID (1269,1270,1271,1272,1273) %>
                <area shape="rect" coords="590,530,1060,580" onclick="jsDownCoupon('cJewelry');return false;" alt="주얼리 쿠폰 전체 다운받기" />
            </map>
        </div>
        <div class="popup">
            <h4><img src="//webimage.10x10.co.kr/fixevent/event/2019/99159/tit_cpn_01.png" alt=""></h4>
            <button type="button" class="btn-close">닫기</button>
            <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/99159/img_cpn_01.png" alt="" usemap="#link"></p>
            <map name="link" class="link">
                <area shape="rect" coords="90,40,570,300" href="/street/street_brand_sub06.asp?makerid=spao" target="_blank" alt="스파오" />
                <area shape="rect" coords="570,40,1050,300" href="/street/street_brand_sub06.asp?makerid=commonunique" target="_blank" alt="커먼유니크" />
                <area shape="rect" coords="330,300,810,560" href="/street/street_brand_sub06.asp?makerid=urago" target="_blank" alt="유라고" />
                <area shape="rect" coords="90,560,570,820" href="/street/street_brand_sub06.asp?makerid=kimyangliving" target="_blank" alt="김양리빙" />
                <area shape="rect" coords="570,560,1050,820" href="/street/street_brand_sub06.asp?makerid=beginning0" target="_blank" alt="프롬비기닝" />
            </map>
        </div>
        <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/99159/txt_noti.gif?v=1.0" alt="쿠폰 사용 유의사항"></p>
    </div>
</div>
<%' // 99159 패션뷰티 결산베스트 %>
<!-- #include virtual="/lib/db/dbclose.asp" -->
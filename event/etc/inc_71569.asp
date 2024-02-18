<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
'###########################################################
' Description : [텐바이텐 X 월드비전] Waterful Christimas, 그 세번째 이야기.
' History : 2016.07.25 유태욱
'###########################################################
Dim eCode, cnt, sqlStr, i, vUserID, subsctiptcnt


If application("Svr_Info") = "Dev" Then
	eCode 		= "66174"
Else
	eCode 		= "71569"
End If

vUserID		= GetEncLoginUserID

'총 응모 횟수
sqlstr = "select count(*) as cnt FROM [db_event].[dbo].[tbl_event_subscript] WHERE evt_code="& eCode &" "
rsget.Open sqlstr, dbget, 1
	subsctiptcnt = rsget("cnt")
rsget.close

'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
Dim vTitle, vLink, vPre, vImg
Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
snpTitle	= Server.URLEncode("[텐바이텐] Waterful Christmas!")
snpLink		= Server.URLEncode("http://m.10x10.co.kr/event/eventmain.asp?eventid="&eCode)
snpPre		= Server.URLEncode("10x10 이벤트")
%>
<style type="text/css">
img {vertical-align:top;}

#contentWrap {padding-bottom:0;}

.waterfulChristimas {background:#dffbff url(http://webimage.10x10.co.kr/eventIMG/2016/71569/bg_sky.png) no-repeat 50% 0;}

.waterfulChristimas .topic {position:relative; height:187px; padding-top:120px;}
.waterfulChristimas .topic .collabo {position:absolute; top:34px; left:50%; margin-left:-570px;}
.waterfulChristimas .topic h2 {position:absolute; top:205px; left:50%; margin-left:-315px;}
.waterfulChristimas .topic .date {position:absolute; top:30px; left:50%; margin-left:421px;}
.waterdrop {position:absolute; top:182px; left:50%; margin-left:-491px;}
.waterdrop {animation-name:bubble; animation-duration:5s; animation-timing-function:ease-in-out; animation-iteration-count:infinite; animation-direction:alternate; animation-play-state:running; animation-delay:3s;}
@keyframes bubble{
	0%{margin-top:10px}
	100%{margin-top:-10px}
}

.character {position:absolute; top:182px; left:50%; margin-left:-414px;}
.character {animation-name:bounce; animation-iteration-count:infinite; animation-duration:1.5s; animation-delay:2s;}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:5px; animation-timing-function:ease-in;}
}

.letterDrop {opacity:0.8; transform:rotateX(-90deg); animation:letterDrop 1.5s ease 1 normal forwards;}
@keyframes letterDrop {
	10% {opacity:0.5;}
	20% {opacity:0.8; top:120px; transform:rotateX(-360deg);}
	100% {opacity:1; top:205px; transform:rotateX(360deg);}
}

.item {padding-bottom:45px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71569/bg_pattern_wave.png) repeat-x 0 100%;}
.item p {padding-left:50px;}

.intro {padding-bottom:83px; background-color:#c2f2ff;}

.withYou {height:398px; padding-top:43px; background:#89e1e5 url(http://webimage.10x10.co.kr/eventIMG/2016/71569/bg_mint.png) no-repeat 50% 0;}
.withYou ul {overflow:hidden; width:174px; margin:25px auto 0;}
.withYou ul li {float:left; padding:0 6px;}
.withYou ul li a:hover img {animation-name:pulse; animation-duration:1s;}
@keyframes pulse {
	0% {transform:scale(1);}
	50% {transform:scale(0.9);}
	100% {transform:scale(1);}
}

.count {overflow:hidden; width:566px; margin:0 auto;}
.count .desc {float:left; width:263px; height:71px; margin:30px 10px 0; padding-top:21px; border-radius:20px; background-color:#fff;}
.count .desc p {margin-top:8px;}
.count .desc p b {margin:0 5px; color:#55b5dc; font-family:'Verdana'; font-size:24px; line-height:24px;}

.noti {position:relative; padding:40px 0; background-color:#f0f0f0;}
.noti h3{position:absolute; top:50%; left:50%; margin:-36px 0 0 -256px;}
.noti ul {width:650px; margin:0 auto; padding-left:490px; text-align:left;}
.noti ul li {position:relative; padding-left:21px; color:#555; font-size:11px; line-height:1.688em;}
.noti ul li span {position:absolute; top:7px; left:10px; width:2px; height:2px; background-color:#555;}
</style>
<script type="text/javascript">
$(function(){
	letterDrop();
	$("#animation").css({"opacity":"0"});
	function letterDrop() {
		$("#animation").addClass("letterDrop");
	}
});

function snschk(snsnum) {
	<% If vUserID = "" Then %>
		if ("<%=IsUserLoginOK%>"=="False") {
			if(confirm("로그인을 하셔야 참여할 수 있습니다.")){
				var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
				winLogin.focus();
				return;
			}
		}
	<% End If %>
	<% If vUserID <> "" Then %>
	var reStr;
	var str = $.ajax({
		type: "GET",
		url:"/event/etc/doeventsubscript/doEventSubscript71569.asp",
		data: "mode=snschk&snsnum="+snsnum,
		dataType: "text",
		async: false
	}).responseText;
		reStr = str.split("|");
		if(reStr[0]=="OK"){
			if(reStr[1] == "tw") {
				popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');
				$("#ttcnt").empty().html(reStr[2]);
				$("#ttprice").empty().html(reStr[2]*100);
			}else if(reStr[1]=="fb"){
				popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');
				$("#ttcnt").empty().html(reStr[2]);
				$("#ttprice").empty().html(reStr[2]*100);
			}else if(reStr[1]=="ka"){
				alert('잘못된 접속 입니다.');
				return false;
			}else if(reStr[1] == "end"){
				alert('한 ID당 한번만 참여하실 수 있습니다.');
				return false;
			}else{
				alert('오류가 발생했습니다.');
				return false;
			}
		}else{
			errorMsg = reStr[1].replace(">?n", "\n");
			alert(errorMsg);
			document.location.reload();
			return false;
		}
	<% End If %>
}
</script>
<!--[if lte IE 9]>
	<script type="text/javascript">
		$(function(){
			$("#animation").css({"opacity":"1"});
		});
	</script>
<![endif]-->

	<!-- [W] 71569 Waterful Christimas -->
	<div class="evt71569 waterfulChristimas">
		<div class="topic">
			<p class="collabo"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71569/txt_collabo_v1.png" alt="텐바이텐과 월드비전이 함께 합니다." /></p>
			<p class="discount"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71569/txt_discount.png" alt="2016 S/S 캠페인 런칭기념 20% 할인!" /></p>
			<h2 id="animation"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71569/tit_waterful_christmas.png" alt="Waterful Christimas" /></h2>
			<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71569/txt_date.png" alt="이벤트 기간은 2016년 7월 27일부터 8월 15일까지 진행합니다." /></p>
			<span class="waterdrop"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71569/img_water_drop.png" alt="" /></span>
			<span class="character"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71569/img_character.png" alt="" /></span>
		</div>

		<div class="item">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/71569/img_item_v1.png" alt="깨끗한 물이 필요한 곳에 당신의 마음을 전하세요! 구매금액의 일부가 기부됩니다." usemap="#itemlink" /></p>
			<map name="itemlink" id="itemlink">
				<area shape="rect" coords="106,83,526,570" href="/shopping/category_prd.asp?itemid=1519374&amp;pEtr=71569" alt="스마트폰 케이스 스티커, 워터풀" />
				<area shape="rect" coords="588,109,940,655" href="/shopping/category_prd.asp?itemid=1519372&amp;pEtr=71569" alt="에코백" />
				<area shape="rect" coords="49,602,534,964" href="/shopping/category_prd.asp?itemid=1519375&amp;pEtr=71569" alt="크림 글라스 우산, 나뭇잎" />
				<area shape="rect" coords="609,835,1039,1211" href="/shopping/category_prd.asp?itemid=1519373&amp;pEtr=71569" alt="파우치" />
				<area shape="rect" coords="26,1042,537,1412" href="/shopping/category_prd.asp?itemid=1519376&amp;pEtr=71569" alt="사인 스티커" />
			</map>
		</div>

		<div class="intro">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/71569/tit_intro.gif" alt="Waterful Christimas 캠페인" /></h3>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/71569/txt_intro_01.png" alt="이 캠페인은 더러운 물과 비위생적인 환경 때문에 목숨을 잃는 아이들에게 깨끗한 물과 내일의 희망을 선물하고자 기획되었습니다. 매일매일 우리 모두에게 특별한 크리스마스를 만들어주고 싶은 텐바이텐과 월드비전, 서커스보이밴들의 마음을 가득 담았죠. 본 프로젝트를 통해 런칭하는 상품 판매 수익금 중 일부는 월드비전을 통해 방글라데시 식수 사업에 지원됩니다. 여러분의 기분 좋은 실천으로 Waterful 기적을 만들어 주세요!" /></p>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/71569/txt_intro_02.gif" alt="함께 해주세요! 마음을 담아 Waterful Christmas 굿즈 구매하시면 텐바이텐을 통해 판매 수익금 중 일부를 월드비전에 전달 하여, 방글라데시의 식수가 필요한 마을에 식수펌프 설치 되어 아이들이 보다 쉽게 깨끗한 물을 마실 수 있어요!" /></p>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/71569/txt_intro_03.jpg" alt="이렇게 좋아져요! 식수를 얻기 위해 20km씩 걸어 다니던 시간이 줄어 아이들의 학교 출석률이 높아져요. 농작물도 건강하게 자라기 때문에 수확이 가능하고 아이들 가정의 소득도 증대돼요. 건강하게 클 수 있어요 수인성 질병의 발생이 줄어 유아 사망률이 낮아지고 영양 개선에도 도움이 돼요." /></p>
		</div>

		<div class="withYou">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/71569/tit_event_with_you.png" alt="Event With You Waterful Christmas 캠페인을 여러분의 친구들에게도 소개해주세요! SNS에 공유된 횟수들 만큼 100원씩 기부금으로 적립됩니다." /></h3>

			<!-- for dev msg: sns 공유 -->
			<ul>
				<li><a href="" onclick="snschk('fb'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71569/ico_facebook.png" alt="페이스북에 공유하기" /></a></li>
				<li><a href="" onclick="snschk('tw'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71569/ico_twitter.png" alt="트위터에 공유하기" /></a></li>
			</ul>

			<!-- for dev msg: 카운트 -->
			<div class="count">
				<div class="desc">
					<h4><img src="http://webimage.10x10.co.kr/eventIMG/2016/71569/tit_count_heart.png" alt="현재 공유된 따뜻한 마음" /></h4>
					<p>
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/71569/txt_total.png" alt="총" />
						<b id="ttcnt"><%= subsctiptcnt %></b>
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/71569/txt_no.png" alt="분" />
					</p>
				</div>
				<div class="desc">
					<h4><img src="http://webimage.10x10.co.kr/eventIMG/2016/71569/tit_count_amount.png" alt="현재 적립된 금액" /></h4>
					<p>
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/71569/txt_total.png" alt="총" />
						<b id="ttprice"><%= subsctiptcnt*100 %></b>
						<img src="http://webimage.10x10.co.kr/eventIMG/2016/71569/txt_won.png" alt="원" />
					</p>
				</div>
			</div>
		</div>

		<div class="noti">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/71569/tit_noti.png" alt="이벤트 유의사항" /></h3>
			<ul>
				<li><span></span>2016년 8월 15일 (월) 자정까지 공유된 횟수를 기준으로 합니다.</li>
				<li><span></span>한 ID당 한번만 참여하실 수 있습니다.</li>
				<li><span></span>카카오톡을 이용한 공유는 모바일 웹 또는 APP에서 참여하실 수 있습니다.</li>
				<li><span></span>모인 기부금은 판매 수익금과 합해 월드비전에 전달됩니다.</li>
				<li><span></span>본 이벤트는 상황에 따라 조기종료 될 수 있습니다.</li>
			</ul>
		</div>
	</div>
	<!-- //Waterful Christimas -->
<!-- #include virtual="/lib/db/dbclose.asp" -->
<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 	쿨링을 부탁해
' History : 2017.07.10 유태욱
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
dim eCode, vUserID, itemid, itemcnt

IF application("Svr_Info") = "Dev" THEN
	eCode = "66384"
	itemid = 523796
Else
	eCode = "78942"
	itemid = 1745595
End If

itemcnt = getitemlimitcnt(itemid)

vUserID = getEncLoginUserID
%>
<style>
.evt78942 {background:#f3f3f3 url(http://webimage.10x10.co.kr/eventIMG/2017/78942/bg_cool.png) 50% 0 no-repeat;}
.evt78942 button {background-color:transparent;}
.evt78942 .topic {position:relative; width:1140px; height:262px; margin:0 auto; padding-top:112px;}
.evt78942 .topic h2 {padding:28px 0 54px;}
.evt78942 .topic .date {position:absolute; right:3px; top:45px;}
.section1 {position:relative; width:1140px; height:965px; margin:0 auto; text-align:left;}
.section1 > a {display:block;}
.section1 .slide {overflow:visible !important; position:relative; width:636px; height:657px; margin-left:97px;}
.section1 .slidesjs-pagination {position:absolute; left:46px; bottom:116px; z-index:30; width:512px; height:9px; text-align:center;}
.section1 .slidesjs-pagination li {display:inline-block; width:8px; height:8px; padding:0 6px; vertical-align:top;}
.section1 .slidesjs-pagination li a {display:block; width:6px; height:6px; margin:1px; border-radius:50%; background:#cfcdcd; text-indent:-999em;}
.section1 .slidesjs-pagination li a.active {width:8px; height:8px; margin:0; background:#fff; transition:all .2s;}
.section1 .slidesjs-navigation {display:block; position:absolute; top:288px; z-index:50; width:42px; height:71px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/78942/btn_nav.png) 0 0 no-repeat; text-indent:-999em;}
.section1 .slidesjs-previous {left:-23px;}
.section1 .slidesjs-next {right:9px; background-position:100% 0;}
.section1 .name {position:absolute; right:130px; top:190px;}
.section1 .limit {position:absolute; left:542px; top:57px; z-index:50;}
.section1 .soldout {margin-left:97px;}
.section2 {width:1140px; margin:0 auto; padding-bottom:65px;}
.section2 h3 {padding-bottom:63px;}
.section2 .enterCode {width:996px; height:254px; margin:82px auto 0; padding-top:59px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/78942/bg_box.png) 0 0 no-repeat;}
.section2 .enterCode div {overflow:hidden; position:relative; width:568px;  margin:42px auto 0; border-radius:5px;}
.section2 .enterCode input {width:500px; height:65px; text-align:left; padding:0 40px; font-size:18px; font-weight:bold; line-height:68px; background-color:#fff; }
.section2 .enterCode input::-webkit-input-placeholder {color:#bbb;}
.section2 .enterCode input::-input-placeholder {color:#bbb;}
.section2 .enterCode input::-webkit-input-placeholder {color:#bbb;}
.section2 .enterCode input::-moz-placeholder {color:#bbb;}
.section2 .enterCode input:-ms-input-placeholder {color:#bbb;}
.section2 .enterCode input:-moz-placeholder {color:#bbb;}
.section2 .enterCode .btnSubmit {position:absolute; right:0; top:0;}
.section3 {padding:87px 0 98px; background-color:#a9a9a9;}
.section3 .noti {overflow:hidden; width:930px; margin:0 auto;}
.section3 .noti h3 {float:left;}
.section3 .noti div {float:right;}
.buyLayer {position:fixed; left:0; top:0; z-index:100; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2017/78942/bg_mask.png) 0 0 repeat;}
.buyLayer .layerCont {position:absolute; left:50%; top:50%; margin:-346px 0 0 -276px;}
.buyLayer .layerCont .btnClose {position:absolute; right:-50px; top:-14px;}
</style>
<script type="text/javascript">
$(function(){
	$(".section1 .slide").slidesjs({
		width:636,
		height:657,
		pagination:{effect:'fade'},
		navigation:{effect:'fade'},
		play:{interval:2700, effect:'fade', auto:true},
		effect:{fade: {speed:600, crossfade:true}}
	});

	// 쿠폰레이어
	$(".buyLayer").hide();
	$(".btnClose").click(function(){
		$(".buyLayer").hide();
	});
});

function fnCouponDownload() {
	<% If vUserID = "" Then %>
		if ("<%=IsUserLoginOK%>"=="False") {
			if(confirm("로그인을 하셔야 참여할 수 있습니다.")){
				top.location.href="/login/loginpage.asp?vType=G";
				return false;
			}
		}
	<% End If %>
	<% If vUserID <> "" Then %>
	var reStr;
	var cpn = $("#couponnum").val();
	if (cpn == '' || GetByteLength(cpn) > 16){
		alert("Error05:쿠폰번호를 확인해 주세요.");
		document.location.reload();
		return false;
	}
	var str = $.ajax({
		type: "GET",
		url:"/event/etc/doeventsubscript/doEventSubscript78942.asp",
		data: "mode=down&couponnum="+cpn,
		dataType: "text",
		async: false
	}).responseText;
		reStr = str.split("||");
		if(reStr[0]=="11"){
			$("#buyLayer").fadeIn();
			return false;
		}else if(reStr[0]=="12"){
			alert(reStr[1]);
			document.location.reload();
			return false;
		}else if(reStr[0]=="00"){
			alert(reStr[1]);
			return false;
		}else if(reStr[0]=="13"){
			alert(reStr[1]);
			document.location.reload();
			return false;
		}else{
			errorMsg = reStr[1].replace(">?n", "\n");
			alert(errorMsg);
			document.location.reload();
			return false;
		}
	<% End If %>
}
</script>
	<!-- 쿨링을 부탁해 -->
	<div class="evt78942">
		<div class="topic">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/78942/txt_collabo.png" alt="10x10 X KEB하나은행" /></p>
			<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/78942/tit_cooling.png" alt="쿨링을 부탁해" /></h2>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/78942/txt_subcopy.png" alt="물에 닿기만 해도 시원해지는  마기쏘 쿨링 세라믹 텀블러를 특별한 가격에!" /></p>
			<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78942/txt_date.png" alt="2017.07.12 ~ 08.31" /></p>
		</div>
		<!-- 롤링 -->
		<div class="section section1">
			<a href="/shopping/category_prd.asp?itemid=1745595&pEtr=78942">
				<%'' 판매중(품절시 .slide 영역 노출되지 않음 %>
				<% if itemcnt > 0 then %>
					<div class="slideWrap">
						<div class="slide">
							<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/78942/img_item_1.png" alt="" /></div>
							<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/78942/img_item_2.png" alt="" /></div>
							<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/78942/img_item_3.png" alt="" /></div>
							<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/78942/img_item_4.png" alt="" /></div>
						</div>
						<p class="limit"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78942/txt_limit.png" alt="선착순 5천명" /></p>
					</div>
				<% else %>
					<p class="soldout"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78942/txt_soldout.png" alt="" /></p>
				<% end if %>
				<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78942/txt_item.png" alt="마기쏘 쿨링 세라믹 텀블러 (2개) 쿠폰할인가 25,000원" /></p>
			</a>
		</div>

		<%'' 쿠폰번호 입력 %>
		<div class="section section2">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/78942/txt_tip.png" alt="할인가에 구매하려면?" /></h3>
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/78942/txt_step.png" alt="하나멤버스 or 시럽에서 쿠폰 번호 확인 → 텐바이텐에서 쿠폰 번호 입력 후 등록 → 결제페이지에서 쿠폰 선택하여 결제하면 완료!" /></div>
			<div class="enterCode">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/78942/txt_num.png" alt="쿠폰 번호를 입력해주세요" /></p>
				<div>
					<input type="text" name="couponnum" id="couponnum" value="" maxlength = "16" placeholder="쿠폰번호 입력" />
					<button type="button" onclick="fnCouponDownload(); return false;" class="btnSubmit"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78942/btn_submit.png" alt="등록하기" /></button>
				</div>
			</div>

			<%'' 발급완료 레이어 %>
			<div class="buyLayer" id="buyLayer" style="display:none">
				<div class="layerCont">
					<a href="/shopping/category_prd.asp?itemid=1745595&pEtr=78942"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78942/img_enroll.jpg" alt="쿠폰이 등록되었습니다. 할인가에 구매해보세요!" /></a>
					<button type="button" class="btnClose"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78942/btn_close.png" alt="닫기" /></button>
				</div>
			</div>

		</div>
		<div class="section section3">
			<div class="noti">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/78942/tit_noti.png" alt="이벤트 유의사항" /></h3>
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/78942/txt_noti.png" alt="본 이벤트는 텐바이텐과 하나멤버스, 그리고 시럽회원님을 대상으로 진행됩니다. (비회원 구매 불가)/ID당 한 세트(2개입)씩만 구매가 가능합니다./상품은 즉시결제로만 결제가 가능하며, 배송 후에는 반품/교환/구매취소가 불가능합니다./이벤트는 쿠폰 소지 여부와는 상관없이 재고 소진 시 마감됩니다." /></div>
			</div>
		</div>
	</div>
	<!--// 쿨링을 부탁해 -->
<!-- #include virtual="/lib/db/dbclose.asp" -->
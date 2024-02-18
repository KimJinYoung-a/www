<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  2017년 [VIP gift] for.YOU
' History : 2017-09-15 정태훈 생성
'####################################################
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_userinfocls.asp" -->
<%
	Dim eCode, vQuery, preCode
	IF application("Svr_Info") = "Dev" THEN
		preCode		=  66256 '//지난 이벤트
		eCode		=  66429
	Else
		preCode		=  0  ''75644 '//지난 이벤트
		eCode		=  80598
	End If

	dim oUserInfo, vTotalCount2, allcnt
	set oUserInfo = new CUserInfo
		oUserInfo.FRectUserID = GetEncLoginUserID
	if (GetEncLoginUserID<>"") then
		oUserInfo.GetUserData
	end If
	
	vQuery = "SELECT count(*) FROM [db_temp].[dbo].[tbl_temp_event_addr] WHERE userid = '" & GetEncLoginUserID & "' And evt_code in ('"& eCode &"','"& preCode &"') "
	rsget.Open vQuery,dbget,1
	IF Not rsget.Eof Then
		vTotalCount2 = rsget(0)
	End If
	rsget.close()

	'// 전체 인원수 확인
	vQuery = "SELECT count(*) FROM [db_temp].[dbo].[tbl_temp_event_addr] WHERE evt_code in ('"& eCode &"','"& preCode &"') "
	rsget.Open vQuery,dbget,1
	IF Not rsget.Eof Then
		allcnt = rsget(0)
	End If
	rsget.close()

%>
<base href="http://www.10x10.co.kr/">
<style type="text/css">
img {vertical-align:top;}
.hidden {visibility:hidden; width:0; height:0;}
.vipGift {padding-top:120px; background:#444444 url(http://webimage.10x10.co.kr/eventIMG/2017/80598/bg_tit.jpg) 50% 0 no-repeat;}
.vipGift .topic {width:480px; height:400px; margin:0 auto 118px; border:solid 1px #fff;}
.vipGift .topic h2 {position:relative; padding-top:85px;}
.vipGift .topic h2:after{display:inline-block; content:' '; position:absolute; bottom:-29px; left:75px; width:330px; height:1px; background-color:#fff;}
.vipGift .topic p.subcopy {margin:60px auto 40px;}

.slideWrap {position:relative; padding:87px 0 140px; background-color:#855b35;}
.slideWrap .frameGold {position:absolute; top:265px; left:50%; margin-left:-575px}
.slide {position:relative; width:1130px; height:500px; margin:64px auto 70px;}
.slide .slidesjs-navigation {position:absolute; z-index:10; bottom:15px; width:30px; height:30px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/80598/img_pagination.png); text-indent:-999em;}
.slide .slidesjs-previous {left:445px; background-position:0 50%;}
.slide .slidesjs-next {right:442px; background-position:-33px 50%;}
.slidesjs-pagination {overflow:hidden; position:absolute; bottom:15px; left:50%; z-index:15; width:180px; margin-left:-90px; height:30px;}
.slidesjs-pagination li {float:left; width:30px; height:30px}
.slidesjs-pagination li a {display:inline-block; width:100%; height:100%; font-size:0; line-height:0; color:transparent; cursor:pointer; vertical-align:top; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/80598/img_pagination.png); background-position:-97px 50%;}
.slidesjs-pagination li a.active {background-position:-68px 50%; z-index:15;}

.vipGift .contents {position:relative; padding:92px 0 100px; background-color:#bf844f; text-align:left;}
.vipGift .contents .article {position:relative; width:940px; margin:0 auto;}
.vipGift .contents .btnEnter {position:absolute; top:60px; right:0;}
.vipGift .contents .limited {position:absolute; top:150px; right:135px;}
.vipGift .contents .article .howVip {display:block; margin-top:64px; padding:17px 0 15px; background-color:#9e6d41; text-align:center;}
.vipGift .contents .sold-out {position:absolute; bottom:0; left:50%; width:100%; height:100%; margin-left:-50%; background-color:rgba(0, 0, 0, .75)}
.vipGift .contents .sold-out img {position:absolute; top:200px; left:50%; margin-left:-157px;}

.address {overflow:hidden; margin-top:60px; background-color:#fff;}
.address .form {position:relative; width:848px; height:318px; margin:0 auto; padding:40px 45px 52px 54px;}
.address .selectOption {overflow:hidden; position:absolute; top:40px; left:310px;}
.address .selectOption span {float:left; margin-right:25px; font-size:13px; color:#888888; font-weight:bold;}
.address .selectOption input {margin-top:-2px; vertical-align:middle;}
.address table {float:left; margin-top:30px;}
.address table.userAdd {margin:30px 0 14px 68px;}
.address table.userName img {margin-top:-3px;}
.address table.userAdd th img {margin-top:8px; vertical-align:top;}
.address table th, .address table td {padding-bottom:10px;}
.address table td input {width:282px; margin-bottom:10px; padding:0 14px; height:30px; border:1px solid #ddd; color:#892e2e; font-family:'Dotum', sans-serif; font-size:12px; line-height:32px;}
.address .group {overflow:hidden; position:relative;}
.address .group input, .address .group span {float:left;}
.address .group span {width:20px; height:32px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69274/blt_hypen.png) no-repeat 50% 50%;}
.address .group .btnFind {position:absolute; top:0; right:0;}
.address .note {margin-top:33px;}
.address .btnsubmit {margin-top:30px; text-align:center;}

.hitchhiker {position:relative; padding:204px 0; background:#86807b url(http://webimage.10x10.co.kr/eventIMG/2017/80598/bg_people.jpg) 50% 0 no-repeat;}
.hitchhiker p {width:940px; margin:0 auto; text-align:left;}
.hitchhiker .btnGoHc {position:absolute; top:298px; left:50%; margin-left:168px;}

.noti {position:relative; width:940px; margin:0 auto; padding:66px 0 66px 0; background-color:#444444; text-align:left;}
.noti h3 {position:absolute; top:50%; left:0; margin-top:-12px;}
.noti ul {padding-left:310px;}
.noti ul li {position:relative; color:#f3eee2; font-size:11px; font-family:'Dotum', 'Verdana'; line-height:24px;}
.noti ul li:after {display:inline-block; content:' '; position:absolute; top:9px; left:-18px; width:6px; height:5px; background-color:#f3eee2; border-radius:50%;}
.noti ul li:first-child {margin-top:0;}
</style>
<script type="text/javascript">
	$(function(){
		/* slide js */
		$("#slide").slidesjs({
		width:"1130",
		height:"500",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:3000, effect:"fade", auto:true},
		effect:{fade: {speed:1800, crossfade:true}}
		});

		/* address */
		$("#address").hide();
		/* Label Select */
		$("#address .selectOption label").click(function(){
			labelID = $(this).attr("for");
			$('#'+labelID).trigger("click");
		});
	});

function jsvipgo(){
	<% if Not(Now() > #09/15/2017 00:00:00# And Now() < #09/25/2017 23:59:59#) then %>
		alert("이벤트 기간이 아닙니다.");
		return false;
	<% end if %>

	<% if Not(IsUserLoginOK) then %>
		jsChklogin('<%=IsUserLoginOK%>');
		return false;
	<% else %>
		<% if GetLoginUserLevel() = 3 or GetLoginUserLevel() = 4 or GetLoginUserLevel() = 6 then  %>
			<% if allcnt >= 1000 then %>
				alert("한정 수량으로 조기 소진되었습니다.");
				return false;
			<% else %>
				<% if vTotalCount2 > 0 then %>
					alert("이미 신청하셨습니다.");
					return false;
				<% else %>
					$("#address").show();
					$(".howVip").hide();
					$(this).hide();
					$(".limited").css({"top":"650px","right":"385px"});
					return false;
				<% end if %>
			<% end if %>
		<% else %>
			alert('VIP등급만 신청 가능합니다.\n회원 등급을 높여 다양한 혜택을 경험해 보세요!');
			return false;
		<% end if %>
	<% end if %>
}

//'주소찾기
function searchzip(frmName){
	var popwin = window.open('/common/searchzip_new.asp?target=' + frmName, 'searchzip10', 'width=560,height=680,scrollbars=yes,resizable=yes');
	popwin.focus();
}

//'나의 주소록
function PopOldAddress(){
	var popwin = window.open('/my10x10/MyAddress/popMyAddressList.asp','popMyAddressList','width=600,height=300,scrollbars=yes,resizable=yes');
	popwin.focus();
}

function jsSubmitComment(){
	var frm = document.frmorder
	<% if Not(IsUserLoginOK) then %>
		jsChklogin('<%=IsUserLoginOK%>');
		return false;
	<% end if %>

	if(!frm.reqname.value){
		alert("이름을 입력 해 주세요");
		frm.reqname.focus();
		return false;
	}

	if(!frm.reqhp1.value){
		alert("휴대폰번호를 입력 해주세요");
		frm.reqhp1.focus();
		return false;
	}

	if(!frm.reqhp2.value){
		alert("휴대폰번호를 입력 해주세요");
		frm.reqhp2.focus();
		return false;
	}

	if(!frm.reqhp3.value){
		alert("휴대폰번호를 입력 해주세요");
		frm.reqhp3.focus();
		return false;
	}

	if(!frm.txZip.value){
		alert("우편번호를 입력 해주세요");
		frm.txZip.focus();
		return false;
	}

	if (frm.txAddr1.value.length<1){
        alert('수령지 도시 및 주를  입력하세요.');
        frm.txAddr1.focus();
        return false;
    }

    if (frm.txAddr2.value.length<1){
        alert('수령지 상세 주소를  입력하세요.');
        frm.txAddr2.focus();
        return false;
    }

	frm.mode.value = "inst";
	frm.action = "/event/etc/doeventsubscript/doEventSubscript80598.asp";
	frm.submit();
	return;
}
</script>
						<div class="evt80598 vipGift">
							<div class="topic">
								<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/80598/txt_for_you.png" alt="For.you" /></h2>
								<p class="subcopy"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80598/txt_subcopy.png" alt="우리의 감성이 좋은 다정한 당신 VIP고객님만을 위한 VIP GIFT를 신청하세요" /></p>
								<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80598/txt_date.png" alt="2017.09.18 - 09.25" /></p>
							</div>

							<div class="slideWrap">
								<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/80598/txt_you_vip.png" alt="늘 다정한 VIP 고객님 안녕하세요, 텐바이텐입니다" /></h3>
								<div id="slide" class="slide">
									<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/80598/img_slide1.jpg" alt="" /></div>
									<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/80598/img_slide2.jpg" alt="" /></div>
									<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/80598/img_slide3.jpg" alt="" /></div>
									<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/80598/img_slide4.jpg" alt="" /></div>
									<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/80598/img_slide5.jpg" alt="" /></div>
									<div><img src="http://webimage.10x10.co.kr/eventIMG/2017/80598/img_slide6.jpg" alt="" /></div>
								</div>
								<span class="frameGold"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80598/img_frame.png" alt="" /></span>
								<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/80598/txt_thnx.png" alt="보내주신 따뜻한 마음에 보답하고자 세상에 하나 뿐인 히치하이커tea를 준비해 보았어요 여러분의 일상 속 작은 여유 시간을 함께할 수 있어 정말 행복합니다. 앞으로도 텐바이텐과 함께 즐거운 나날 가득하시길 바랍니다. 감사합니다." /></p>
							</div>

							<div class="contents">
								<div class="article">
									<h3 class="hidden">VIP GIFT 신청하기</h3>
									<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/80598/tit_vip_gift.png" alt="VIP GIFT 신청하기 - 신청대상  9월 현재 VVIP, VIP GOLD, VIP SILVER 고객 - 주소확인기간 2017. 09. 18 (월) - 09. 25 (월) * 배송시작 : 2017. 09. 27 (수)부터 순차배송" /></p>
									<!-- for dev msg : <div id="address" class="address">...</div> 보입니다. -->
									<a href="#address" onclick="jsvipgo();return false;" id="btnEnter" class="btnEnter"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80598/btn_vip_gift.png" alt="VIP신청하기 버트" /></a>
									<p class="limited"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80598/txt_limited.png" alt="* 한정수량 으로 조기 종료 가능 " /></p>
									<a href="/cscenter/membershipGuide/" class="howVip"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80598/txt_how_vip.png" alt="VIP는 어떻게 되나요? 방법 및 혜택 바로 가기 >" /></a>
									<div id="address" class="address">
										<div class="form">
											<%' form %>
											<%If oUserInfo.FresultCount >0 Then %>
											<form name="frmorder" method="post">
											<input type="hidden" name="reqphone1"/>
											<input type="hidden" name="reqphone2"/>
											<input type="hidden" name="reqphone3"/>
											<input type="hidden" name="mode"/>
												<fieldset>
												<legend>배송지 주소 확인하기</legend>
													<h4><img src="http://webimage.10x10.co.kr/eventIMG/2017/80598/tit_confrim_address.png" alt="배송지 주소 확인하기" /></h4>
													<div class="selectOption">
														<span>
															<input type="radio" id="address01" name="addr" value="1" checked />
															<label for="address01"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80598/txt_label_01.png" alt="기본 주소" /></label>
														</span>
														<span>
															<input type="radio" id="address02" name="addr" value="2" onclick="PopOldAddress();" />
															<label for="address02"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80598/txt_label_02.png" alt="나의 주소록" /></label>
														</span>
													</div>
													<table class="userName" style="width:388px;">
														<caption>배송자의 이름, 휴대폰</caption>
														<tbody>
														<tr>
															<th scope="row" style="width:77px;">
																<label for="username"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80598/txt_th_name.png" alt="이름" /></label>
															</th>
															<td style="width:310px;">
																<input type="text" id="username" value="<%=oUserInfo.FOneItem.FUserName%>" name="reqname" />
															</td>
														</tr>
														<tr>
															<th scope="row"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80598/txt_th_mobile.png" alt="휴대폰" /></th>
															<td>
																<div class="group">
																	<input type="text" title="휴대폰번호 앞자리" value="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",0) %>" name="reqhp1" style="width:60px" /><span></span>
																	<input type="text" title="휴대폰번호 가운데 자리" value="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",1) %>" name="reqhp2" style="width:60px" /><span></span>
																	<input type="text" title="휴대폰번호 뒷자리" value="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",2) %>" name="reqhp3" style="width:60px" />
																</div>
															</td>
														</tr>
														</tbody>
													</table>
													<table class="userAdd" style="width:390px;">
														<caption>배송자의 주소 정보</caption>
														<tbody>
														<tr>
															<th scope="row" style="vertical-align:top; width:78px;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80598/txt_th_address.png" alt="주소" /></th>
															<td>
																<div class="group">
																	<input type="text" title="우편번호" value="<%= oUserInfo.FOneItem.FZipCode %>" name="txZip" ReadOnly style="width:178px;" />
																	<a href="" onclick="searchzip('frmorder');return false;" class="btnFind"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80598/btn_search.png" alt="찾기" /></a>
																</div>
																<input type="text" title="기본주소" name="txAddr1" value="<%= doubleQuote(oUserInfo.FOneItem.FAddress1) %>"/>
																<input type="text" title="상세주소" name="txAddr2" value="<%= doubleQuote(oUserInfo.FOneItem.FAddress2) %>" />
															</td>
														</tr>
														</tbody>
													</table>
													<p class="note"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80598/txt_address_noti.png" alt="기본 회원 정보 주소를 불러오며, 수정 가능합니다v. 주소입력 후 VIP GIFT 신청완료를 클릭하셔야 신청이 완료 되며, 완료된 후에는 주소를 변경하실 수 없습니다." /></p>
													<div class="btnsubmit"><input type="image" src="http://webimage.10x10.co.kr/eventIMG/2017/80598/btn_gift.png" alt="VIP GIFT 신청완료" onclick="jsSubmitComment();return false;" /></div>
												</fieldset>
											</form>
											<% End If %>
										</div>
									</div>
								</div>
								<div class="sold-out"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80598/txt_sold_out.png" alt="" /></div>
							</div>

							<div class="hitchhiker">
								<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/80598/txt_hichhiker.png" alt="About ; HITCHHIKER 히치하이커는 격월간으로 발행되는 텐바이텐의 감성매거진입니다. 매 호 다른 주제로 우리 주변의 평범한 이야기와 일상 풍경을 담아냅니다. 히치하이커가 당신에게 소소한 즐거움, 작은 위로가 될 수 있길 바랍니다.히치하이커 바로가기" /></p>
								<a href="/shopping/category_prd.asp?itemid=1496196&amp;pEtr=80598" class="btnGoHc"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80598/btn_hickhicker.png" alt="히치하이커 바로가기" /></a>
							</div>

							<div class="noti">
								<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/80598/tit_noti.png" alt="이벤트 유의사항" /></h3>
								<ul>
									<li>텐바이텐  VVIP, VIP SILVER, VIP GOLD 고객만 신청이 가능합니다.</li>
									<li>본 사은품은 한정수량으로 조기에 선착순 마감 될 수 있으며, 2017.09.26 (화) 부터 순차적으로 배송 될 예정입니다.</li>
									<li> 경품은 현금성 환불 및 옵션 선택이 불가합니다.</li>
									<li>제품명 : 히치하이커 tea 애플 블랙 티 | 원산지 : 스리랑카 / 식품유형 : 침출차(홍차)/ 내용량 0.8g x 4tea bags / <br/ > 성분 및 함량 : 홍차 79%, 사과조각 20%, 천연 사과향 1% / 제조사 : 우신에프티에이엔티 / 판매자 : 텐바이텐 / <br/ > 디자인 : (주)텐바이텐 / 보존방법 : 밀폐하여 건조한 곳에 실온보관 / 품질유지기한 : 함께 동봉되는 안내서 참고</li>
								</ul>
							</div>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->
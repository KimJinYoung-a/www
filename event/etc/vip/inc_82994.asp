<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  감사선물 VIP GIFT
' History : 2017-12-18 정태훈 생성
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
		preCode		=  0 '//지난 이벤트
		eCode		=  67494
	Else
		preCode		=  0 '//지난 이벤트
		eCode		=  82994
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
button {background-color:transparent;}
.hidden {visibility:hidden; width:0; height:0;}

.vvipGift .contents {position:relative;}
.vvipGift .contents .sold-out {position:absolute; top:0; left:50%; width:100%; height:100%; margin-left:-50%; }

.evt-conts {position:relative;}
.evt-conts .gift-detail {display:inline-block; position:absolute; bottom:50px; left:130px; width:335px; height:235px;}
.evt-conts .gift-detail div{position:relative; top:-7px; left:17px; opacity:0; transition:opacity 0.2s ease-in-out 0s;}
.evt-conts .gift-detail:hover div{opacity:1;}

.apply {position:relative; padding-bottom:78px; background:#2f2d51 url(http://webimage.10x10.co.kr/eventIMG/2017/82994/bg_submit.jpg) 0 0 no-repeat;}
.apply .limited {position:absolute; bottom:76px; left:50%; margin-left:-80px; z-index:30;}
.apply .address {padding-bottom:37px; text-align:left;}
.apply .address .form {position:relative; width:820px; height:318px; margin:0 auto; padding:40px 60px 52px; background-color:#fff; border:solid 1px white;}
.apply .address .selectOption {overflow:hidden; position:absolute; top:40px; left:310px;}
.apply .address .selectOption span {float:left; margin-right:25px; font-size:13px; color:#888888; font-weight:bold;}
.apply .address .selectOption input {margin-top:-7px; vertical-align:middle;}
.apply .address table {float:left; margin-top:30px;}
.apply .address table.userAdd {margin:30px 0 14px 42px;}
.apply .address table.userName img {margin-top:-3px;}
.apply .address table.userAdd th img {margin-top:8px; vertical-align:top;}
.apply .address table th, .address table td {padding-bottom:10px;}
.apply .address table td input {width:282px; margin-bottom:10px; padding:0 14px; height:30px; border:1px solid #ddd; color:#3d328f; font-family:'Dotum', sans-serif; font-size:12px; line-height:32px;}
.apply .address .group {overflow:hidden; position:relative;}
.apply .address .group input, .address .group span {float:left;}
.apply .address .group span {width:20px; height:32px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69274/blt_hypen.png) no-repeat 50% 50%;}
.apply .address .group .bnt-find {position:absolute; top:0; right:0;}
.apply .address .note {margin-top:33px;}
.apply .address .btn-submit {margin-top:30px; text-align:center;}

.noti {position:relative; padding:54px 0 54px 532px; background-color:#1c1741; text-align:left;}
.noti h3 {position:absolute; top:50%; left:275px; margin-top:-12px;}
.noti ul li {position:relative; color:#f3eee2; font-size:11px; font-family:'Dotum', 'Verdana'; line-height:24px;}
.noti ul li:after {display:inline-block; content:' '; position:absolute; top:9px; left:-18px; width:6px; height:5px; background-color:#f3eee2; border-radius:50%;}
.noti ul li:first-child {margin-top:0;}
</style>
<script type="text/javascript">
	$(function(){
		/* address */
		$("#address").hide();

		/* Label Select */
		$("#address .selectOption label").click(function(){
			labelID = $(this).attr("for");
			$('#'+labelID).trigger("click");
		});
	});

function jsvipgo(){
	<% if Not(Now() > #12/19/2017 00:00:00# And Now() < #12/22/2017 23:59:59#) then %>
		alert("이벤트 기간이 아닙니다.");
		return false;
	<% end if %>

	<% if Not(IsUserLoginOK) then %>
		jsChklogin('<%=IsUserLoginOK%>');
		return false;
	<% else %>
		<% if GetLoginUserLevel() = 6 then  %>
			<% if allcnt >= 1000 then %>
				alert("한정 수량으로 조기 소진되었습니다.");
				return false;
			<% else %>
				<% if vTotalCount2 > 0 then %>
					alert("이미 신청하셨습니다.");
					return false;
				<% else %>
					$("#address").show();
					$("#btn-gift").hide();
					//$(this).hide();
					$(".limited").css({"top":"650px","right":"385px"});
					return false;
				<% end if %>
			<% end if %>
		<% else %>
			alert('VVIP등급만 신청 가능합니다.\n회원 등급을 높여 다양한 혜택을 경험해 보세요!');
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
	<% else %>

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
	frm.action = "/event/etc/doeventsubscript/doEventSubscript82994.asp";
	frm.submit();
	return;
	<% end if %>
}
</script>
						<div class="evt82994 vvipGift">
							<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/82994/tit_thx_gift.jpg" alt="감사 선물" /></h2>
							<div class="contents">
								<div class="article">
									<h3 class="hidden">VVIP 선물 신청하기</h3>
									<div class="evt-conts">
										<img src="http://webimage.10x10.co.kr/eventIMG/2017/82994/txt_gift_conts_v2.jpg" alt="VVIP 고객님만을 위한 선물을 신청해보세요! 신청대상  l  12월 현재 VVIP 고객 주소확인 기간  l  2017. 12. 19 (화) - 12. 22 (금) * 배송시작 : 2018. 1. 2 (화)부터 순차배송" />
										<a class="gift-detail"><div><img src="http://webimage.10x10.co.kr/eventIMG/2017/82994/txt_gift_detail.png" alt="애플 블랙 티 SET 내용량 : 0.8g x 4tea bags 성분 및 함량 : 홍차 79% 사과조각 20%, 천연 사과향 1%" /></div></a>
									</div>
									<div class="apply">
										<button id="btn-gift" class="btn-gift" onclick="jsvipgo();return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82994/btn_submit_gift.png" alt="VVIP 선물 신청하기" /></button>
										<p class="limited"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82994/txt_limited.png" alt="* 한정수량 으로 조기 종료 가능" /></p>
										<div id="address" class="address">
											<!-- form -->
											<div class="form">
												<%If oUserInfo.FresultCount >0 Then %>
												<form name="frmorder" method="post">
												<input type="hidden" name="reqphone1"/>
												<input type="hidden" name="reqphone2"/>
												<input type="hidden" name="reqphone3"/>
												<input type="hidden" name="mode"/>
													<fieldset>
													<legend>배송지 주소 확인하기</legend>
														<h4><img src="http://webimage.10x10.co.kr/eventIMG/2017/82994/tit_confrim_address.png" alt="배송지 주소 확인하기" /></h4>
														<div class="selectOption">
															<span>
																<input type="radio" id="address01" name="addr" value="1" checked />
																<label for="address01"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82994/txt_address_label_1.png" alt="기본 주소" /></label>
															</span>
															<span>
																<input type="radio" id="address02" name="addr" value="2" onclick="PopOldAddress();" />
																<label for="address02"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82994/txt_address_label_2.png" alt="나의 주소록" /></label>
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
																		<a href="" onclick="searchzip('frmorder');return false;" class="bnt-find"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80598/btn_search.png" alt="찾기" /></a>
																	</div>
																	<input type="text" title="기본주소" name="txAddr1" value="<%= doubleQuote(oUserInfo.FOneItem.FAddress1) %>" />
																	<input type="text" title="상세주소" name="txAddr2" value="<%= doubleQuote(oUserInfo.FOneItem.FAddress2) %>" />
																</td>
															</tr>
															</tbody>
														</table>
														<p class="note"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82994/txt_address_noti.png" alt="기본 회원 정보 주소를 불러오며, 수정 가능합니다 [VVIP 선물 신청하기]를 클릭하셔야 신청이 완료 되며, 완료된 후에는 주소를 변경하실 수 없습니다." /></p>
														<div class="btn-submit"><button onclick="jsSubmitComment();return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82994/btn_submit.png" alt="VVIP 선물 신청하기" /></button></div>
													</fieldset>
												</form>
												<% End If %>
											</div>
										</div>
									</div>
								</div>
								<!-- for dev msg 품절시 --><!-- <div class="sold-out"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82994/txt_sold_out.png" alt="한정수량으로 VVIP 선물 신청이 조기 종료되었습니다" /></div> -->
							</div>


							<div class="noti">
								<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/82994/tit_noti.png" alt="이벤트 유의사항" /></h3>
								<ul>
									<li>본 이벤트는 텐바이텐 VVIP고객만 신청이 가능합니다.</li>
									<li>사은품은 한정수량으로 조기에 선착순 마감 될 수 있습니다.</li>
									<li>사은품은 2018.01.22 (월)부터 순차적으로 배송 될 예정입니다.</li>
								</ul>
							</div>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->
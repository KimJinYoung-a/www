<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  Wedding Membership
' History : 2017.09.28 유태욱
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->

<%
Dim vGubun, i, evt_code, userid, totalbonuscouponcountusingy

userid = GetEncLoginUserID()

IF application("Svr_Info") = "Dev" THEN
	evt_code   =  67439
Else
	evt_code   =  80833
End If

																If date() < "2017-10-12" Then
																'	response.redirect("/")
																End If

dim subscriptcount, subscriptcountsub
subscriptcount=0
subscriptcountsub=0
totalbonuscouponcountusingy=0

'' 실섭 1003-무배, 1004-60만/7만, 1005-100만/15마
'' 테섭 2855-무배, 2856-60만/7만, 2857-100만/15마

'//본인 참여 여부
if userid<>"" then
	subscriptcount = getevent_subscriptexistscount(evt_code, userid, "", "", "")
	subscriptcountsub = getevent_subscriptexistscount(evt_code, userid, "subevt", "", "")
'	totalbonuscouponcountusingy = getbonuscoupontotalcount("1003,1004,1005", "N", "Y","")
end if

%>
<style type="text/css">
img {vertical-align:top;}
.weddingMembership {padding-bottom:180px; background:#ffeacf url(http://webimage.10x10.co.kr/eventIMG/2017/80833/bg_conts.jpg) no-repeat 50% 0;}
.weddingCont {position:relative; width:1140px; margin:0 auto;}
.weddingHead {position:relative; width:1140px;height:345px; padding-top:145px; margin:0 auto; background:url(http://webimage.10x10.co.kr/eventIMG/2017/80833/bg_flower.png) no-repeat 50% 38px;}
.weddingHead h2 {position:relative; width:700px; height:190px; margin:0 auto;}
.weddingHead h2 span {position:absolute; opacity:0;}
.weddingHead h2 .t1 {top:0; left:0; animation:moveRight 1.3s 1 forwards;}
.weddingHead h2 .t2 {bottom:0; right:0; animation:moveLeft 1.3s .3s 1 forwards;}
.weddingHead .subcopy {margin:39px 0 30px;}
.weddingHead .go-evt {position:absolute; top:41px; right:-20px;}
.weddingEvt.coupon-set {margin:100px 0 96px;}
.weddingEvt.coupon-set h3 {margin-bottom:64px;}
.weddingEvt.enroll {padding:100px 0 105px;}
.weddingEvt.enroll #writeInvitation {width:1000px; margin:0 auto;}
.weddingEvt.enroll #writeInvitation dl {overflow:hidden; padding:30px 0; font-weight:bold; border-top:1px solid #f3f3f3; text-align:left;}
.weddingEvt.enroll #writeInvitation dl:first-child {border-top:0;}
.weddingEvt.enroll #writeInvitation dl.wedding-date em {display:inline-block; width:160px; height:30px; padding-left:5px; vertical-align:middle; line-height:1.4;}
.weddingEvt.enroll #writeInvitation dt {float:left; width:120px; padding-left:9px; line-height:30px;}
.weddingEvt.enroll #writeInvitation dt img {vertical-align:middle;}
.weddingEvt.enroll #writeInvitation dd {float:left; width:327px; line-height:30px; text-align:left;}
.weddingEvt.enroll #writeInvitation dd img {vertical-align:middle;}
.weddingEvt.enroll #writeInvitation dd em {font-weight:normal; color:#979797;}
.weddingEvt.enroll #writeInvitation dd input[type="text"] {height:30px; padding:0 10px; font-weight:bold; border:1px solid #ddd; vertical-align:middle;}
.weddingEvt.enroll #writeInvitation dd span {display:inline-block; padding-left:20px;}
.weddingEvt .addFile {width:100%; height:30px; background-color:#fff; border:1px solid #ddd;}
.weddingEvt.enroll #writeInvitation .policy {padding:0; margin-top:19px;  text-align:left; color:#828080;}
.weddingEvt.enroll #writeInvitation .policy .txt {overflow-y:auto; width:393px; height:160px; margin-bottom:15px; padding:0 25px 15px; border:1px solid #ddd; background:#fff; color:#828080;}
.weddingEvt.enroll #writeInvitation .policy .txt h4 {padding:20px 0 10px; color:#828080;}
.submit {margin-top:56px;}
.submit p {color:#f16554; font-weight:600; font-size:12px;}
@keyframes moveRight{
from {transform:translateX(-20px); opacity:0;}
to {transform:translateX(0); opacity:1;}
}
@keyframes moveLeft{
from {transform:translateX(20px); opacity:0;}
to {transform:translateX(0); opacity:1;}
}
</style>
<script>

function frmSubmit() {
	<% If IsUserLoginOK() Then %>
		<% If Now() > #11/01/2017 23:59:59# Then %>
			alert("이벤트 기간이 아닙니다.");
			return;
		<% Else %>
			<% if subscriptcount < 1 then %>
				var frm = document.frmApply;

				// 내 이름
				if (frm.myArea1.value == '' || frm.myArea1.value == 'ex) 홍길동'){
					alert("본인 이름을 입력해 주세요.");
					frm.myArea1.value = '';
					frm.myArea1.focus();
					return;
				}

				//배우자 이름
				if (frm.myArea2.value == '' || frm.myArea2.value == 'ex) 홍길동'){
					alert("배우자 이름을 입력해 주세요.");
					frm.myArea2.value = '';
					frm.myArea2.focus();
					return;
				}

				//결혼 예정일
				if (frm.myArea3.value == ''){
					alert("결혼 예정일을 입력해 주세요");
					frm.myArea3.focus();
					return;
				}

				if (frm.myArea3.value == '' || GetByteLength(frm.myArea3.value) > 8 || frm.myArea3.value == '00000000'){
					alert("결혼 예정일을 숫자로 8자리로 입력해 주세요.");
					frm.myArea3.focus();
					return;
				}

		        if(isNaN(frm.myArea3.value) == true) {
		            alert("결혼 예정일을 숫자로 8자리로 입력해 주세요..!");
		            frm.myArea3.focus();
		            return false;
		        }

				// 체크 되어 있는지 확인

				var tmpagreecheck = $("#agreeY").prop("checked") ;
				if(!tmpagreecheck){
					alert("개인정보 취급방침을 확인해주세요.");
					frm.agreecheck.focus();
					return;
				}

				//* 파일 확장자 체크
				for(var ii=1; ii<2; ii++)
				{
					var frmname		 = eval("frm.imgfile"+ii+"");
			
					if(frmname.value != "")
					{
						var sarry        = frmname.value.split("\\");
						var maxlength    = sarry.length-1;
						var ext = sarry[maxlength].split(".");
			
						if(ext[1].toLowerCase() == "jpg" || ext[1].toLowerCase() == "png"){
							
						}else{
							alert('jpg나png파일만 가능 합니다.');
							return;
						}
					}
					else
					{
						alert('청첩장 이미지 파일을 등록해 주세요.');
						return;
					}
				}

				frm.optname.value = frm.myArea1.value+"/!/"+frm.myArea2.value+"/!/N";
				frm.mode.value = 'addreg';
				frm.submit();
		   <% else %>
				alert("이미 참여 하셨습니다.");
				return;
			<% end if %>
		<% End if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
		}
		return false;
	<% End IF %>
}

function jsCheckLimit(textgb) {
	if ("<%=IsUserLoginOK%>"=="False") {
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
		}
		return false;
	}
	if (textgb =='ta1'){
		if (document.frmApply.myArea1.value == 'ex) 홍길동'){
			document.frmApply.myArea1.value = '';
		}
	}else if(textgb =='ta2'){
		if (document.frmApply.myArea2.value == 'ex) 홍길동'){
			document.frmApply.myArea2.value = '';
		}
	}else if(textgb =='ta3'){
		if (document.frmApply.myArea3.value == '00000000'){
			document.frmApply.myArea3.value = '';
		}
	}else{
		alert('잠시 후 다시 시도해 주세요');
		return;
	}
}

function maxLengthCheck(object){
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if( ( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) )
	{
		return;
	}
	else
	{
		return false;
	}
}
function showKeyCode(event) {
	event = event || window.event;
	var keyID = (event.which) ? event.which : event.keyCode;
	if( ( keyID >=48 && keyID <= 57 ) || ( keyID >=96 && keyID <= 105 ) )
	{
		return;
	}
	else
	{
		return false;
	}
}

</script>
	<!-- WEDDING MEMBERSHIP -->
	<div class="evt80833 weddingMembership">
		<div class="weddingHead">
			<h2>
				<span class="t1"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80833/tit_wedding_mem_1.png" alt="Wedding" /></span>
				<span class="t2"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80833/tit_wedding_mem_2.png" alt="Membership" /></span>
			</h2>
			<p class="subcopy"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80833/txt_subcopy.png" alt="" /></p>
			<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80833/txt_date.png" alt="이벤트기간 : 2017.10.12 – 11.01" /></p>
			<a href="/event/eventmain.asp?eventid=80615" class="go-evt">
				<img src="http://webimage.10x10.co.kr/eventIMG/2017/80833/btn_go_evt.png" alt="웨딩기획전 바로가기" />
			</a>
		</div>

		<!-- 웨딩쿠폰 3종 세트 -->
		<div class="weddingEvt coupon-set">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/80833/tit_coupon.png" alt="웨딩쿠폰 3종 세트" /></h3>
			<div class="coupons"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80833/img_coupon.png" alt="1만원 이상 구매 시 무료배송 60만원 이상 구매 시 70,000원 100만원 이상 구매 시 150,000원" /></div>
		</div>
		<!--// 웨딩쿠폰 3종 세트 -->

		<!-- 청첩장 등록 -->
		<form name="frmApply" method="POST" action="<%=staticImgUpUrl%>/linkweb/enjoy/80833_Contest_upload.asp" onsubmit="return false" enctype="multipart/form-data">
		<input type="hidden" name="mode" value="">
		<input type="hidden" name="userid" value="<%= userid %>">
		<input type="hidden" name="optname" value="">
		<input type="hidden" name="device" value="W">
			<div class="weddingEvt enroll">
				<div id="writeInvitation">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/80833/tit_enroll.png" alt="청첩장 등록" /></h3>
					<div class="overHidden" style="margin-top:60px;">
						<div class="ftLt" style="width:472px; margin:0 18px 0 10px;">
							<dl style="padding-top:24px;">
								<dt><img src="http://webimage.10x10.co.kr/eventIMG/2017/80833/txt_myinfo.png" alt="나의정보" /></dt>
								<dd>
									<p style="margin-bottom:11px;">
										<img src="http://webimage.10x10.co.kr/eventIMG/2017/80833/txt_id.png" alt="아이디" />
										<span><% IF NOT(IsUserLoginOK) THEN %><% else %><%= userid %><% END IF %></span>
									</p>

									<p>
										<img src="http://webimage.10x10.co.kr/eventIMG/2017/80833/txt_name.png" alt="이름" />
										<span><input type="text"  id="myName" name="myArea1" onClick="jsCheckLimit('ta1');" oninput="maxLengthCheck(this)" maxlength="32" onKeyUp="jsCheckLimit('ta1');" <% IF NOT(IsUserLoginOK) THEN %>value="ex) 홍길동"<% else %>value="ex) 홍길동"<% END IF %> style="width:220px;" /></span>
									</p>
								</dd>
							</dl>
							<dl style="height:58px;">
								<dt><img src="http://webimage.10x10.co.kr/eventIMG/2017/80833/txt_partner.png" alt="배우자 정보" /></dt>
								<dd>
									<p>
										<img src="http://webimage.10x10.co.kr/eventIMG/2017/80833/txt_name.png" alt="이름" />
										<span><input type="text" id="spouseName" name="myArea2" onClick="jsCheckLimit('ta2');" oninput="maxLengthCheck(this)" maxlength="32" onKeyUp="jsCheckLimit('ta2');" <% IF NOT(IsUserLoginOK) THEN %>value="ex) 홍길동"<% else %>value="ex) 홍길동"<% END IF %> style="width:220px;" /></span>
									</p>
									<em>※ 청첩장 정보와 일치여부 판단하기 위해 기입</em>
								</dd>
							</dl>
							<dl class="wedding-date" style="height:30px;">
								<dt><img src="http://webimage.10x10.co.kr/eventIMG/2017/80833/txt_duedate.png" alt="결혼(예정)일" /></dt>
								<dd >
									<p>
										<input type="text"  id="weddingDate" placeholder="00000000"  oninput="maxLengthCheck(this)" maxlength="8" name="myArea3" onClick="jsCheckLimit('ta3');" onKeyUp="jsCheckLimit('ta3');" <% IF NOT(IsUserLoginOK) THEN %>value=""<% else %>value="00000000"<% END IF %> style="width:110px;" /></span>
										<em>※ 예시: 2017년 10월 12일▶ 20171012 으로 기입</em>
									</p>
								</dd>
							</dl>
							<dl class="add-invi">
								<dt><img src="http://webimage.10x10.co.kr/eventIMG/2017/80833/txt_attach_invite.png" alt="청첩장 첨부" /></dt>
								<dd>
									<p><input type="file" id="weddingInvitation" name="imgfile1" class="addFile" /></p>
									<em>※ 최대 2MB, JPG(JPEG) 파일</em>
								</dd>
							</dl>
						</div>
						<div class="ftRt" style="width:446px; padding-left:53px; border-left:solid 1px #f1f1f1;">
							<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/80833/txt_notice.png" alt="꼭확인해 주세요! － 2017년 10월 1일 ~ 12월 31일까지가 결혼일(예정일)인 고객님은 모두 등록 가능합니다.－ 기입해주신 고객명, 배우자명이 청첩장과 동일해야 합니다. - 기입한 정보는 비공개이며, 이벤트 종료 후 파기됩니다. - 발급된 쿠폰은 2017년 11월 1일까지 사용 가능합니다." /></p>
							<div class="policy">
								<div class="txt">
									<h4>[수집하는 개인정보 항목 및 수집방법]</h4>
									<div>1. 수집하는 개인정보의 항목<br/>① 회사는 회원가입시 원할한 고객상담, 각종 서비스의 제공을 위해 아래와 같은 최소한의 개인정보를 필수항목을 수집하고 있습니다. - 아이디, 비밀번호, 이름, 성별, 생년월일, 이메일주소, 휴대폰번호, 가입인증정보<br/>② 서비스 이용과정이나 사업 처리과정에서 아래와 같은 정보들이 생성되어 수집될 수 있습니다.<br />- 최근접속일, 접속 IP 정보, 쿠키, 구매로그, 이벤트로그<br />- 물품 주문시 : 이메일주소, 전화번호, 휴대폰번호, 주소<br />- 물품(서비스)구매에 대한 결제 및 환불시 : 은행계좌정보 <br />- 개인맞춤서비스 이용시 : 주소록, 기념일<br />2. 개인정보 수집에 대한 동의<br />회사는 귀하께서 텐바이텐의 개인정보취급방침 및 이용약관의 내용에 대해 「동의한다」버튼 또는 「동의하지 않는다」버튼을 클릭할 수 있는 절차를 마련하여, 「동의한다」버튼을 클릭하면 개인정보 수집에 대해 동의한 것으로 봅니다. 「동의안함」을 선택하실 경우, 회사가 제공하는 기본서비스 제공이 제한됩니다.</div>
									<h4>[개인정보의 수집목적 및 이용 목적]</h4>
									<div>① 회원제 서비스 이용에 따른 본인 식별 절차에 이용<br />② 고지사항 전달, 본인 의사 확인, 불만 처리 등 원활한 의사소통 경로의 확보, 새로운 서비스, 신상품이나 이벤트 정보 등 최신 정보의 안내<br />③ 쇼핑 물품 배송에 대한 정확한 배송지의 확보<br />④ 개인맞춤 서비스를 제공하기 위한 자료<br />⑤ 경품 수령 및 세무신고를 위한 별도의 개인정보 요청</div>
									<h4>[개인정보의 보유, 이용기간]</h4>
									<div>2. 위 개인정보 수집목적 달성시 즉시파기 원칙에도 불구하고 다음과 같이 거래 관련 권리 의무 관계의 확인 등을 이유로 일정기간 보유하여야 할 필요가 있을 경우에는 전자상거래 등에서의 소비자보호에 관한 법률 등에 근거하여 일정기간 보유합니다.<br />① 「전자상거래 등에서의 소비자보호에 관한 법률」에 의한 보관<br />- 계약 또는 청약철회 등에 관한 기록 : 5년<br />- 대금결제 및 재화 등의 공급에 관한 기록 : 5년<br />- 소비자의 불만 또는 분쟁처리에 관한 기록 : 3년<br />② 「통신비밀보호법」 시행령 제41조에 의한 통신사실확인자료 보관 - 컴퓨터통신, 인터넷 로그기록자료, 접속지 추적자료 : 3개월<br />③ 설문조사, 이벤트 등 일시적 목적을 위하여 수집한 경우 : 당해 설문조사, 이벤트 등의 종료 시점</div>
									<h4>[개인정보의 파기 절차]</h4>
									<div>회사는 원칙적으로 개인정보 수집 및 이용목적이 달성되면 해당 정보를 지체 없이 파기합니다. 파기절차 및 방법은 다음과 같습니다.<br />1. 파기절차<br />① 귀하가 회원가입 등을 위해 입력하신 정보는 목적이 달성된 후 내부 방침 및 기타 관련 법령에 의한 정보보호 사유에 따라(제6조 개인정보의 보유, 이용기간 참조) 일정 기간 저장된 후 파기되어집니다.<br />② 동 개인정보는 법률에 의한 경우가 아니고서는 보유되어지는 이외의 다른 목적으로 이용되지 않습니다.<br />2. 파기방법 <br />① 종이에 출력된 개인정보는 분쇄기로 분쇄하거나 소각을 통하여 파기합니다.<br />② 전자적 파일형태로 저장된 개인정보는 기록을 재생할 수 없는 기술적 방법을 사용하여 삭제합니다.</div>
								</div>
								<p><input type="checkbox" id="agreeY" value="Y" id="agreecheck" name="agreecheck" /> <label for="agreeY">텐바이텐 개인정보취급방침에 따라, 본 이벤트 참여를 위한 개인정보 취급방침에 동의합니다.</label></p>
							</div>
						</div>
					</div>
					<div class="submit">
						<button class="btn-submit" onclick="frmSubmit(); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80833/btn_submit.png" alt="청첩장 등록하고 쿠폰받기" /></button>
						<p class="tPad25">* 상단의 공지사항을 꼭 확인 후 제출하세요!</p>
					</div>
				</div>
			</div>
		</form>
		<!--// 청첩장 등록 -->
	</div>
	<!--// WEDDING MEMBERSHIP -->
<!-- #include virtual="/lib/db/dbclose.asp" -->
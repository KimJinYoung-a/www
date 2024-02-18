<%
'/wedding/head.asp 페이지에서 불러옴
%>
<script type="text/javascript">
<!--

	$(function () {
		if($('#gotop').hasClass('btn-top')){
			console.log('ok');
			$('.btn-top').css({'opacity':'0'});
		}
	});

	function fnSelectYear(objval){
		document.wfrm.yyyy.value=objval;
	}
	function fnSelectMonth(objval){
		document.wfrm.mm.value=objval;
	}
	function fnSelectDay(objval){
		document.wfrm.dd.value=objval;
	}
	function fnWeddingInfo(){
		var frm=document.wfrm;
		if(frm.username.value=="")
		{
			alert("이름을 입력해 주세요.");
			frm.username.focus();
		}
		else if(frm.partnername.value=="")
		{
			alert("배우자 이름을 입력해 주세요.");
			frm.partnername.focus();
		}
		else if(frm.yyyy.value=="")
		{
			alert("결혼 예정일을 선택해 주세요.");
		}
		else if(frm.mm.value=="")
		{
			alert("결혼 예정일을 선택해 주세요.");
		}
		else if(frm.dd.value=="")
		{
			alert("결혼 예정일을 선택해 주세요.");
		}
		else if(!$("#agreeY").is(":checked"))
		{
			alert("개인정보 수집에 동의해주세요.");
		}
		else
		{
			var smscheck;
			var emailcheck;
			if($("#sms").is(":checked"))
			{
				 smscheck="Y";
			}
			else
			{
				 smscheck="N";
			}
			if($("#email").is(":checked"))
			{
				 emailcheck="Y";
			}
			else
			{
				 emailcheck="N";
			}
			var str = $.ajax({
				type: "POST",
				url: "/wedding/doweddinginfo.asp",
				data: {
					mode:$("#mode").val(),
					yyyy:$("#yyyy").val(),
					mm:$("#mm").val(),
					dd:$("#dd").val(),
					username:$("#username").val(),
					sex:$("input:radio[name='sex']:checked").val(),
					partnername:$("#partnername").val(),
					sms:smscheck,
					email:emailcheck
				},
				dataType: "text",
				async: false
			}).responseText;
			var str1 = str.split("|")
			if (str1[0] == "98"){
				alert('정상 등록 되었고 쿠폰이 발급되었습니다.');
				event.preventDefault();
				$('.enroll-day').fadeOut();
				$("#mode").val("edit");
				location.reload();
				return false;
			}else if (str1[0] == "99"){
				alert('수정 되었습니다.');
				event.preventDefault();
				$('.enroll-day').fadeOut();
				location.reload();
				return false;
			}else if (str1[0] == "97"){
				alert('삭제 되었습니다.');
				event.preventDefault();
				$('.enroll-day').fadeOut();
				location.reload();
				return false;
			}else if (str1[0] == "02"){
				alert('로그인 후 참여 가능합니다.');
				return false;
			}else if (str1[0] == "01"){
				alert('잘못된 접속입니다.');
				return false;
			}else if (str1[0] == "03"){
				alert('정상적인 경로가 아닙니다.');
				return false;
			}else if (str1[0] == "04"){
				alert('일정이 지난 결혼 예정일은 등록이 불가능합니다.');
				return false;
			}else{
				alert(str1[1]);
				location.reload();
				return false;
			}
		}
	}

	function fnWeddingDel(){
		document.wfrm.mode.value="del";
		fnWeddingInfo();
	}

	function fnCloseWin(){
		event.preventDefault();
		$('.enroll-day').fadeOut();
	}

	function fnAddWeddingInfo(){
		event.preventDefault();
		$('.enroll-day').fadeIn();
		window.parent.$('html,body').animate({scrollTop:$(".enroll-day").offset().top+40},600);
	}
//-->
</script>
			<div class="enroll-day" style="display:none">
			<form method="post" name="wfrm">
			<input type="hidden" name="mode" id="mode" value="<%=mode%>">
			<input type="hidden" name="yyyy" id="yyyy" value="<%=DateArr(0)%>">
			<input type="hidden" name="mm" id="mm" value="<%=DateArr(1)%>">
			<input type="hidden" name="dd" id="dd" value="<%=DateArr(2)%>">
				<div class="inner">
					<div class="enroll-head">
						<h3>
							<span><img src="http://fiximage.10x10.co.kr/web2018/wedding2018/tit_enroll_1_x2.png" alt="wedding" /></span>
							<span><img src="http://fiximage.10x10.co.kr/web2018/wedding2018/tit_enroll_2_x2.png" alt="디데이등록하기" /></span>
						</h3>
						<p><img src="http://fiximage.10x10.co.kr/web2018/wedding2018/txt_enroll_sub_x2.png" alt="웨딩일을 등록하시면 할인크폰을 발급해드립니다." /></p>
					</div>
					<div class="enroll-conts">
						<table>
							<tr>
								<th><span>*</span>본인 이름</th>
								<td><input type="text" name="username" id="username" value="<%=UserName%>" maxlength="7" placeholder="김천생"/></td>
							</tr>
							<tr>
								<th><span>*</span>본인 성별</th>
								<td class="select-sex">
									<p><input type="radio" id="male" name="sex" id="sex" value="M"<% If Sex="M" Then Response.write " checked"%> /><label for="male">남 </label></p>
									<p><input type="radio" id="female" name="sex" id="sex" value="F"<% If Sex="F" Then Response.write " checked"%> /><label for="female">여 </p></label>
								</td>
							</tr>
							<tr>
								<th><span>*</span>배우자 이름</th>
								<td><input type="text" name="partnername" id="partnername" value="<%=PartnerName%>" maxlength="7" placeholder="이연분" /></td>
							</tr>
							<tr>
								<th style="vertical-align:top;"><span>*</span>결혼 예정일</th>
								<td class="select-wd-day">
									<div class="year date">
										<dl class="evtSelect">
											<dt ><span><%=DateArr(0)%></span></dt>
											<dd style="display: none;">
												<ul>
													<% For ix=yyyy To yyyy+1%>
													<li onclick="fnSelectYear('<%=ix%>');"><%=ix%></li>
													<% Next %>
												</ul>
											</dd>
										</dl>
									</div>
									<div class="month date">
										<dl class="evtSelect">
											<dt><span><%=DateArr(1)%></span></dt>
											<dd style="display: none;">
												<ul>
													<% For ix=1 To 12 %>
													<li onclick="fnSelectMonth('<%=ZeroTime(ix)%>');"><%=ZeroTime(Cstr(ix))%></li>
													<% Next %>
												</ul>
											</dd>
										</dl>
									</div>
									<div class="select-day date">
										<dl class="day evtSelect">
											<dt><span><%=DateArr(2)%></span></dt>
											<dd style="display: none;">
												<ul>
													<% For ix=1 To 31 %>
													<li onclick="fnSelectDay('<%=ZeroTime(ix)%>');"><%=ZeroTime(Cstr(ix))%></li>
													<% Next %>
												</ul>
											</dd>
										</dl>
									</div>
								</td>
							</tr>
							<!-- <tr>
								<th style="text-indent:15px; line-height:1; vertical-align:top;">정보 수신 동의</th>
								<td class="agree-info">
									수신 동의를 하시면 텐바이텐의 다양한 혜택과 이벤트/신상품 등의 정보를 만나실 수 있습니다.
									<div class="agree-info">
										<p><input type="checkbox" id="sms" name="sms" value="Y" <% If SMS="Y" Then Response.write " checked"%>><label for="sms">SMS</label></p>
										<p><input type="checkbox" id="email" name="email" value="Y" <% If Email="Y" Then Response.write " checked"%>><label for="email">E-Mail</label></p>
									</div>
								</td>
							</tr> -->
						</table>
					</div>
					<div class="agree-privacy">
						<div class="policy">
							<div class="txt">
								<h4>[수집하는 개인정보 항목 및 수집방법]</h4>
								<div>1. 수집하는 개인정보의 항목<br/> 회사는 해당이벤트의 원활한 고객상담, 각종 서비스의 제공을 위해 아래와 같은 최소한의 개인정보를 필수항목을 수집하고 있습니다. - 아이디, 이름, 성별, 생년월일, 이메일주소, 휴대폰번호, 가입인증정보</div>
								<div>2. 개인정보 수집에 대한 동의<br/>회사는 귀하께서 텐바이텐의 개인정보취급방침에 따른 이벤트 이용약관의 내용에 대해 동의 절차를 마련하여, 「동의」버튼을 클릭하면 개인정보 수집에 대해 동의한 것으로 봅니다.</div>
								<h4>[개인정보의 수집목적 및 이용 목적]</h4>
								<div> 1. 이벤트 참여를 위한 관련 정보 수집 및 증빙 확인 목적 </div>
								<div>2. 고지사항 전달, 본인 의사 확인, 불만 처리 등 원활한 의사소통 경로의 확보</div>
								<h4>[개인정보의 보유 및 파기 절차]</h4>
								<div>1. 설문조사, 이벤트 등 일시적 목적을 위하여 수집한 경우 : 당해 설문조사, 이벤트 등의 종료 시점</div>
								<div>2. 회사는 원칙적으로 개인정보 수집 및 이용목적이 달성되면 해당 정보를 지체 없이 파기합니다. 파기절차 및 방법은 다음과 같습니다.</div>
								<div>① 파기절차 : 귀하가 이벤트등록을 위해 입력하신 정보는 이벤트가 완료 된 후 내부 방침 및 기타 관련 법령에 의한 정보보호 사유에 따라 일정 기간 저장된 후 파기되어집니다.</div>
								<div>② 파기대상 : 배우자 정보, 성별, 결혼 예정일</div>
							</div>
							<div class="btn-agree"><p><input type="checkbox" id="agreeY" name="agreeY" value="Y" checked="checked"><label for="agreeY">본 이벤트 참여를 위한 개인정보 수집에 동의합니다.</label></p></div>
						</div>
					</div>
					<% If UserName<>"" Then %>
					<ul class="btn-enroll">
						<li><button onclick="fnWeddingDel();">삭제하기</button></li>
						<li><button onclick="fnWeddingInfo();return false;">수정하기</button></li>
					</ul>
					<% Else %>
					<button class="btn-enroll" onclick="fnWeddingInfo();return false;">등록하기</button>
					<% End If %>
					<button class="btn-close" onclick="fnCloseWin();">닫기</button>
				</div>
			</form>
			</div>
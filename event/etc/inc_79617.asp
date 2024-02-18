<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#############################################################
' Description : DistroDojo 설문조사 이벤트(전화)
' History : 2017-07-31 원승현 생성
'#############################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<%
	Dim eCode
	IF application("Svr_Info") = "Dev" THEN
		eCode   =  66404
	Else
		eCode   =  79617
	End If

	dim userid, i, UserAppearChk, nowdate, sqlstr, over9score, totalcount, min6score
		userid = GetEncLoginUserID()

	nowdate = Left(Now(), 10)


	'// 이벤트 참여 응모현황
	sqlstr = "Select count(*)" &_
			" From db_temp.dbo.tbl_tenSurvey" &_
			" WHERE evt_code='" & eCode & "' And userid='"&userid&"'  "
			'response.write sqlstr
	rsget.Open sqlStr,dbget,1
		UserAppearChk = rsget(0)
	rsget.Close

%>
<style type="text/css">
.evt79617 {text-align:left; background:#fff url(http://webimage.10x10.co.kr/eventIMG/2017/79617/bg_paper.png) repeat-y 50% 0;}
.survey {width:730px; padding:0 205px 145px;  background:url(http://webimage.10x10.co.kr/eventIMG/2017/79617/bg_btm.png) no-repeat 50% 100%;}
.survey li {padding-bottom:38px;}
.survey textarea {width:674px; height:64px; padding:25px; font-size:12px; line-height:1.3; border:3px solid #e3cfc4;}
.survey .call {position:relative; margin-top:20px;}
.survey .call .inner {position:absolute; left:385px; top:29px; width:345px;}
.survey .call .inner span {display:inline-block; position:relative; vertical-align:top; margin-left:45px;}
.survey .call .inner span:first-child {margin-left:0;}
.survey .call .inner span input {position:absolute; left:0; top:0; width:0; height:0; visibility:hidden;}
.survey .call .inner label {display:inline-block; height:41px; padding-left:56px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/79617/bg_check.png) no-repeat 0 0;}
.survey .call .inner input:checked + label {background-position:0 100%;}
.survey .btnFinish {display:block; width:362px; margin:38px auto 0; vertical-align:top;}
</style>

<script>
function goMinionsIns()
{
	<% If IsUserLoginOK() Then %>
		<% If not( left(now(),10)>="2017-07-31" and left(now(),10)<"2017-08-03" ) Then %>
			alert("설문 응모 기간이 아닙니다.");
			return false;
		<% else %>
			<% if UserAppearChk > 0 then %>
				alert("이미 참여하셨습니다.");
				return false;
			<% else %>

				if ($("#tengoodTxt").val() == '' || GetByteLength($("#tengoodTxt").val()) > 1600){
					alert("텐바이텐의 좋은점을 알려주세요.");
					$("#tengoodTxt").focus();
					return false;
				}

				if ($("#TenorderTxt").val() == '' || GetByteLength($("#TenorderTxt").val()) > 1600){
					alert("텐바이텐 주문시 고려사항을 알려주세요.");
					$("#tengoodTxt").focus();
					return false;
				}

				if ($("#SVSYN").val()=='')
				{
					alert("전화 수신여부를 확인해주세요.");
					return false;
				}

				$("#SVgoodTxt").val($("#tengoodTxt").val());
				$("#SVorderTxt").val($("#TenorderTxt").val());

				$.ajax({
					type:"GET",
					url:"/event/etc/doEventSubscript79617.asp",
					data: $("#frmcom").serialize(),
					dataType: "text",
					async:false,
					cache:true,
					success : function(Data, textStatus, jqXHR){
						if (jqXHR.readyState == 4) {
							if (jqXHR.status == 200) {
								if(Data!="") {
									res = Data.split("|");
									if (res[0]=="OK")
									{
										alert("설문조사에 참여해주셔서 감사합니다.");
										parent.location.reload();
										return false;
									}
									else
									{
										errorMsg = res[1].replace(">?n", "\n");
										alert(errorMsg);
										return false;
									}
								} else {
									alert("잘못된 접근 입니다.");
									parent.location.reload();
									return false;
								}
							}
						}
					},
					error:function(jqXHR, textStatus, errorThrown){
						alert("잘못된 접근 입니다.");
						<% if false then %>
							//var str;
							//for(var i in jqXHR)
							//{
							//	 if(jqXHR.hasOwnProperty(i))
							//	{
							//		str += jqXHR[i];
							//	}
							//}
							//alert(str);
						<% end if %>
						parent.location.reload();
						return false;
					}
				});
			<% end if %>
		<% end if %>
	<% else %>
		if(confirm("로그인 후 설문에 참여하실 수 있습니다.")){
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
		}
		return false;
	<% end if %>
}

function sendSVS(v)
{
	$('input:checkbox[id="callY"]').attr("checked", false);
	$('input:checkbox[id="callN"]').attr("checked", false);
	$('input:checkbox[id="call'+v+'"]').attr("checked", true);
	if (v=="Y")
	{
		$("#SVSYN").val('1');
	}
	else
	{
		$("#SVSYN").val('0');
	}
}

function jsCheckLimit() {
	if ("<%=IsUserLoginOK%>"=="False") {
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
		}
		return false;
	}

	//if (frmcom.txtcomm.value == ''){
	//	frmcom.txtcomm.value = '';
	//}	
}
</script>

<%' 고객설문 이벤트 %>
<div class="evt79617">
	<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/79617/tit_survey.png" alt="고객설문 이벤트" /></h2>
	<div class="survey">
		<ul>
			<li>
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/79617/txt_q1.png" alt="텐바이텐의 좋은점은 무엇일까요?" /></p>
				<textarea cols="50" rows="5" id="tengoodTxt" name="tengoodTxt" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%>><%IF NOT IsUserLoginOK THEN%>로그인 후 설문에 참여하실 수 있습니다.<% else %><%END IF%></textarea>
			</li>
			<li>
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/79617/txt_q2.png" alt="텐바이텐에서 주문할때 고려했던 사항은 무엇인가요?" /></p>
				<textarea cols="50" rows="5" id="TenorderTxt" name="TenorderTxt" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%>><%IF NOT IsUserLoginOK THEN%>로그인 후 설문에 참여하실 수 있습니다.<% else %><%END IF%></textarea>
			</li>
		</ul>
		<p class="tPad10"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79617/txt_gift.png" alt="좋은 의견을 주신 분 중, 전화 인터뷰 요청을 드릴 수도 있습니다. 전화 인터뷰를 해주시는 모든 분들께 [텐바이텐 기프트카드 1만원 권]을 드릴 예정입니다." /></p>
		<div class="call">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/79617/txt_call.png" alt="전화드려도 괜찮을까요?" /></p>
			<div class="inner">
				<span onclick="sendSVS('Y');"><input type="checkbox" id="callY"/><label for="callY"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79617/txt_yes.png" alt="네! 괜찮아요" /></label></span>
				<span onclick="sendSVS('N');"><input type="checkbox" id="callN"/><label for="callN"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79617/txt_no.png" alt="아니요! 전화주지마세요" /></label></span>
			</div>
		</div>
		<button type="button" class="btnFinish" onclick="goMinionsIns();return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/79617/btn_finish.png" alt="설문 완료하기" /></button>
	</div>
</div>
<%'// 고객설문 이벤트%>

<form method="post" name="frmcom" id="frmcom">
<input type="hidden" name="eCode" value="<%=eCode%>">
<input type="hidden" name="mode" value="ins">
<input type="hidden" name="SVSYN" id="SVSYN">
<input type="hidden" name="SVgoodTxt" id="SVgoodTxt">
<input type="hidden" name="SVorderTxt" id="SVorderTxt">
</form>
<!-- #include virtual="/lib/db/dbclose.asp" -->
<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : [휴면고객] 잠자는 사자를 깨워라!
' History : 2015-07-23 이종화
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/base64_u.asp" -->
<!-- #include virtual="/lib/util/tenEncUtil.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_userinfocls.asp" -->
<%
	Dim eCode , allcnt , vQuery , totcnt
	Dim vTmpEmail : vTmpEmail = session("tmpemail")
	IF application("Svr_Info") = "Dev" THEN
		eCode   =  64838
	Else
		eCode   =  65061
	End If

	dim oUserInfo
	set oUserInfo = new CUserInfo
		oUserInfo.FRectUserID = GetLoginUserID
	if (GetLoginUserid<>"") then
		oUserInfo.GetUserData
	end If
	
	vQuery = "SELECT count(*) FROM [db_temp].[dbo].[tbl_temp_event_addr] WHERE evt_code='"&eCode&"' "
	rsget.Open vQuery,dbget,1
	IF Not rsget.Eof Then
		allcnt = rsget(0)
	End If
	rsget.close()

	'//mail 추출 세션때려박기
	Dim vRef, vPostId, vMail, tmpArr, tmpKey, lp
	vRef = request.ServerVariables("HTTP_REFERER")

	'리퍼 분해
	tmpArr = right(vRef,len(vRef)-inStr(vRef,"?"))
	tmpArr = split(tmpArr,"&")

	On Error Resume Next
	For lp=0 to ubound(tmpArr)
		tmpKey = trim(strAnsi2Unicode(Base64decode(strUnicode2Ansi(trim(tmpArr(lp))))))			'(특수코드지원용 > base64_u.asp)
		if inStr(tmpKey,"M_ID")>0 then vMail = right(tmpKey,len(tmpKey)-inStr(tmpKey,"="))
	Next
	On Error Goto 0

	If vTmpEmail = "" Then
		session("tmpemail") = vMail
	End If

	'// 로그인후 휴먼고객 체크
	If GetLoginUserid <> "" Then
		vQuery = "SELECT count(*) FROM [db_user_hold].[dbo].[tbl_UHold_Target] "
		vQuery = vQuery & " WHERE userid = '"& GetLoginUserid &"' "
		rsget.Open vQuery,dbget,1
		IF Not rsget.Eof Then
			totcnt = rsget(0)
		End If
		rsget.close()
	End If 
%>
<style type="text/css">
img {vertical-align:top;}
.sleepingHead {position:relative; height:503px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/65061/bg_lion_head.gif) no-repeat 0 0;}
.sleepingHead h2 {position:absolute; left:300px; top:172px; z-index:20; opacity:0;}
.sleepingHead p {position:absolute; left:311px; top:467px;}
.sleepingHead .deco {display:inline-block; position:absolute;}
.sleepingHead .arm {left:517px; top:231px; z-index:30;}
.sleepingHead .zzz {left:0; top:214px; z-index:10;}
.wakeUp {overflow:hidden; position:relative; min-height:434px; background:#522d13 url(http://webimage.10x10.co.kr/eventIMG/2015/65061/bg_sleeping.gif) no-repeat 0 0;}
.wakeUp .trigger {display:block; position:absolute; left:100px; top:0; width:950px; height:400px; z-index:40; cursor:pointer; text-indent:-999em;}
.wakeUp .hand {position:absolute; left:0; top:71px; width:475px; height:206px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/65061/img_hand.png) no-repeat 0 0;}
.wakeUp .applyWrap {display:none;}
.wakeUp .applyGift {padding:77px 63px 0 62px; margin-bottom:60px; font-size:11px; text-align:left; background:url(http://webimage.10x10.co.kr/eventIMG/2015/65061/bg_paper.gif) no-repeat 0 0;}
.wakeUp .confirmAddr {position:relative; padding:0 55px 30px; color:#000;}
.wakeUp .confirmAddr table {width:680px; margin-top:13px; border-top:2px solid #000;}
.wakeUp .confirmAddr th {text-align:center; border-bottom:1px solid #d9d9d9; background:#efefef;}
.wakeUp .confirmAddr td {padding:13px 26px; border-bottom:1px solid #e8e8e8;}
.wakeUp .btnSubmit {display:inline-block; position:absolute; right:55px ;top:60px;}
.wakeUp .txtInp {height:auto;}
.evtNoti {padding:52px 110px 45px; text-align:left; background:#efefef;}
.evtNoti ul {padding:20px 0 0 4px;}
.evtNoti li {line-height:12px; color:#5e5e5e; padding:0 0 10px 12px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/65061/blt_arrow.gif) no-repeat 0 0;}
.wakeUp .evtNoti {overflow:hidden; padding:30px 60px;}
.wakeUp .evtNoti h3 {float:left;}
.wakeUp .evtNoti ul {float:left; padding:0 0 0 30px;}
.wakeUp .evtNoti li {padding:0 0 6px 0 ; background:none; font-size:11px; color:#797979;}
</style>
<script type="text/javascript">
$(function(){
	$('.sleepingHead h2').animate({"left":"306px", "opacity":"1"}, 1000);
	$('.sleepingHead h2').delay(10).effect( "shake", {times:2}, 600 );
	$('.wakeUp .trigger').mouseover(function(){
		$('.wakeUp .hand').animate({"left":"-92px", "top":"45","width":"567px"}, 500);
	});
	$('.wakeUp .trigger').mouseleave(function(){
		$('.wakeUp .hand').animate({"left":"0", "top":"71px","width":"475px"}, 600);
	});
	$('.wakeUp .trigger').click(function(){
	<% if allcnt >= 2000 then %>
		alert('죄송합니다\n사은품이 모두 소진 되었습니다.');
		return false;
	<% else %>
		<% if totcnt > 0 then %>
			alert('응모가 완료되었습니다.\n선물을 받으려면 주소를 입력해주세요!.');
			$(this).hide();
			$('.hand').hide();
			$('.applyWrap').show();
		<% else %>
			alert('텐바이텐에 2014년 8월 1일 부터 로그인하지 않아 휴면고객으로 분류되신 고객님들만 참여 가능합니다.');
			return false;
		<% end if %>
	<% end if %>
	});
});

$(function(){
    <% if allcnt >= 2000 then %>
        alert('죄송합니다. 마감되었습니다.');
    <% else %>
    	<% if Not(IsUserLoginOK) then %>
    	top.location.href = "/login/loginpage.asp?backpath=<%=server.URLEncode("/event/eventmain.asp?eventid="&eCode&"")%>";
    	return;
    	<% end if %>
    <% end if %>
});

//'주소찾기
function searchzip(frmName){
	var popwin = window.open('/common/searchzip.asp?target=' + frmName, 'searchzip10', 'width=560,height=680,scrollbars=yes,resizable=yes');
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

	if(!frm.txZip1.value){
		alert("우편번호를 입력 해주세요");
		frm.txZip1.focus();
		return false;
	}

	if(!frm.txZip2.value){
		alert("우편번호를 입력 해주세요");
		frm.txZip2.focus();
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
	frm.action = "/event/etc/doeventsubscript/doEventSubscript65061.asp";
	frm.submit();
	return;
}
</script>
<div class="evt65061">
	<div class="sleepingHead">
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2015/65061/tit_sleeping_lion.png" alt="잠자는 사자를 깨워라!" /></h2>
		<span class="deco arm"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65061/img_arm.png" alt="" /></span>
		<span class="deco zzz"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65061/img_zzz.gif" alt="" /></span>
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/65061/txt_account.png" alt="여러분의 계정이 잠자고 있어요! 사자를 깨우면 잠들어있던 선물이 배송됩니다!" /></p>
	</div>
	<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/65061/img_gift.jpg" alt="GIFT - 사은품은 랜덤으로 발송됩니다." /></div>
	<div class="wakeUp">
		<span class="trigger">click 사자 깨우기!</span>
		<div class="hand"></div>
		<!-- 주소 입력하기 -->
		<div class="applyWrap">
			<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/65061/img_enter_addr.gif" alt="사은품 받을 배송지 정보 입력하고 사은품 받으세요!" /></div>
			<div class="applyGift">
				<div class="confirmAddr">
					<%If oUserInfo.FresultCount >0 Then %>
					<form name="frmorder" method="post">
					<input type="hidden" name="reqphone1"/>
					<input type="hidden" name="reqphone2"/>
					<input type="hidden" name="reqphone3"/>
					<input type="hidden" name="mode"/>
					<div class="overHidden">
						<h3 class="ftLt" style="padding-right:70px;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65061/tit_address.gif" alt="배송지 정보" /></h3>
						<span class="ftLt tPad03 fs12 fb">
							<input type="radio" class="radio" id="addr01" name="addr" value="1" checked/> <label for="addr01">기본주소</label>
							<input type="radio" class="radio lMar37" id="addr02" name="addr" value="2" onclick="PopOldAddress();"/> <label for="addr02">새로운 주소</label>
						</span>
					</div>
					<table>
						<colgroup>
							<col width="155px" /><col width="" />
						</colgroup>
						<tbody>
						<tr>
							<th><img src="http://webimage.10x10.co.kr/eventIMG/2015/65061/txt_name.gif" alt="이름" /></th>
							<td><input type="text" class="txtInp" style="width:210px;" value="<%=oUserInfo.FOneItem.FUserName%>" name="reqname" /></td>
						</tr>
						<tr>
							<th><img src="http://webimage.10x10.co.kr/eventIMG/2015/65061/txt_tel.gif" alt="연락처" /></th>
							<td>
								<input type="text" class="txtInp" style="width:48px;" value="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",0) %>" name="reqhp1"/> - 
								<input type="text" class="txtInp" style="width:55px;" value="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",1) %>" name="reqhp2"/> - 
								<input type="text" class="txtInp" style="width:55px;" value="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",2) %>" name="reqhp3"/>
							</td>
						</tr>
						<tr>
							<th><img src="http://webimage.10x10.co.kr/eventIMG/2015/65061/txt_address.gif" alt="주소" /></th>
							<td>
								<p>
									<input type="text" class="txtInp box5" style="width:61px;" title="우편번호 앞자리" value="<%= Splitvalue(oUserInfo.FOneItem.FZipCode,"-",0) %>" name="txZip1" ReadOnly/> - 
									<input type="text" class="txtInp box5" style="width:60px;" title="우편번호 뒷자리" value="<%= Splitvalue(oUserInfo.FOneItem.FZipCode,"-",1) %>" name="txZip2" ReadOnly/> 
									<a href="" onclick="searchzip('frmorder');return false;" class="btn btnS1 btnGry2 lMar10 fs12">우편번호 찾기</a>
								</p>
								<p class="tPad05"><input type="text" class="txtInp box5" style="width:270px;" name="txAddr1" value="<%= doubleQuote(oUserInfo.FOneItem.FAddress1) %>"/></p>
								<p class="tPad05"><input type="text" class="txtInp" style="width:270px;" name="txAddr2" value="<%= doubleQuote(oUserInfo.FOneItem.FAddress2) %>"/></p>
							</td>
						</tr>
						</tbody>
					</table>
					<input type="image" src="http://webimage.10x10.co.kr/eventIMG/2015/65061/btn_apply.gif" alt="신청하기" class="btnSubmit" onclick="jsSubmitComment();return false;"/>
					</form>
					<% End If %>
				</div>
				<div class="evtNoti">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/65061/tit_notice.gif" alt="주소입력시 유의사항" /></h3>
					<ul>
						<li>- 회원정보에 있는 주소를 기본으로 불러옵니다.</li>
						<li>- 다른 주소로 사은품을 받을 시에는 새로운 주소를 클릭 후 주소를 써주세요</li>
						<li>- 사은품 신청하기를 눌러야 신청이 완료되며, 완료된 후에는 주소를 변경하실 수 없습니다.</li>
					</ul>
				</div>
			</div>
		</div>
		<!--// 주소 입력하기 -->
	</div>
	<div class="evtNoti">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/65061/tit_notice02.gif" alt="이벤트 유의사항" /></h3>
		<ul>
			<li>텐바이텐에 2014년 8월 1일 부터 로그인하지 않아 휴면고객으로 분류되신 고객님들만 참여 가능합니다.</li>
			<li>이벤트 기간 동안 ID당 1회만 참여 가능 합니다.</li>
			<li>사은품은 한정 수량이므로, 조기 종료 될 수 있습니다.</li>
		</ul>
	</div>
</div>
<%
	Set oUserInfo = nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
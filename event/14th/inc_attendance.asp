<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 2015 주년이벤트 - 출석 체크
' History : 2015-10-02 이종화 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
Dim eCode , userid
Dim strSql , totcnt , todaycnt
Dim prize1 : prize1 = 0
Dim prize2 : prize2 = 0 
Dim prize3 : prize3 = 0 
Dim prize4 : prize4 = 0 
Dim prize5 : prize5 = 0 
Dim prize6 : prize6 = 0
Dim win1 , win2 , win3 , win4 , win5 , win6
	
	userid = GetEncLoginUserID()

IF application("Svr_Info") = "Dev" THEN
	eCode   =  64908
Else
	eCode   =  66520
End If

	If IsUserLoginOK Then 
		'// 출석 여부
		strSql = "select "
		strSql = strSql & " isnull(sum(case when convert(varchar(10),t.regdate,120) = '"& Date() &"' then 1 else 0 end ),0) as todaycnt "
		strSql = strSql & " , count(*) as totcnt "
		strSql = strSql & " from db_temp.[dbo].[tbl_event_attendance] as t "
		strSql = strSql & " inner join db_event.dbo.tbl_event as e "
		strSql = strSql & " on t.evt_code = e.evt_code and convert(varchar(10),t.regdate,120) between convert(varchar(10),e.evt_startdate,120) and convert(varchar(10),e.evt_enddate,120) "
		strSql = strSql & "	where t.userid = '"& userid &"' and t.evt_code = '"& eCode &"' " 
		rsget.Open strSql,dbget,1
		IF Not rsget.Eof Then
			todaycnt = rsget("todaycnt") '// 오늘 출석 여부 1-ture 0-false
			totcnt = rsget("totcnt") '// 전체 응모수
		End IF
		rsget.close()

		'// 응모 여부
		strSql = " select "
		strSql = strSql & "	isnull(sum(case when sub_opt1 = 1 then 1 else 0 end),0) as prize1 , "
		strSql = strSql & "	isnull(sum(case when sub_opt1 = 1 and sub_opt2 = 1 then 1 else 0 end),0) as win1 , "
		strSql = strSql & "	isnull(sum(case when sub_opt1 = 2 then 1 else 0 end),0) as prize2 , "
		strSql = strSql & "	isnull(sum(case when sub_opt1 = 2 and sub_opt2 = 1 then 1 else 0 end),0) as win2 , "
		strSql = strSql & "	isnull(sum(case when sub_opt1 = 3 then 1 else 0 end),0) as prize3 , "
		strSql = strSql & "	isnull(sum(case when sub_opt1 = 3 and sub_opt2 = 1 then 1 else 0 end),0) as win3 , "
		strSql = strSql & "	isnull(sum(case when sub_opt1 = 4 then 1 else 0 end),0) as prize4 , "
		strSql = strSql & "	isnull(sum(case when sub_opt1 = 4 and sub_opt2 = 1 then 1 else 0 end),0) as win4 , "
		strSql = strSql & "	isnull(sum(case when sub_opt1 = 5 then 1 else 0 end),0) as prize5 , "
		strSql = strSql & "	isnull(sum(case when sub_opt1 = 5 and sub_opt2 = 1 then 1 else 0 end),0) as win5 , "
		strSql = strSql & "	isnull(sum(case when sub_opt1 = 6 then 1 else 0 end),0) as prize6 , "
		strSql = strSql & "	isnull(sum(case when sub_opt1 = 6 and sub_opt2 = 1 then 1 else 0 end),0) as win6  "
		strSql = strSql & "	from db_temp.dbo.tbl_event_66520 "
		strSql = strSql & "	where evt_code = '"& eCode &"' and userid = '"& userid &"' "
		rsget.Open strSql,dbget,1
		IF Not rsget.Eof Then
			prize1	= rsget("prize1")	'// 2일차 응모 - 마일리지 200point - 전원지급
			win1	= rsget("win1")		'// 참여여부
			prize2	= rsget("prize2")	'//	5일차 응모 - 새싹키우기(랜덤) - 200명 - 1%
			win2	= rsget("win2")		'// 참여여부
			prize3	= rsget("prize3")	'//	8일차 응모 - 마일리지 300point - 전원지급
			win3	= rsget("win3")		'// 참여여부
			prize4	= rsget("prize4")	'//	11일차 응모 - 기상예측 유리병 - 100명 - 1%
			win4	= rsget("win4")		'// 참여여부
			prize5	= rsget("prize5")	'//	14일차 응모 - 마일리지 500point -  전원지급
			win5	= rsget("win5")		'// 참여여부
			prize6	= rsget("prize6")	'//	17일차 응모 - 샤오미 공기청정기 50명 - 0.1%
			win6	= rsget("win6")		'// 참여여부
		End IF
		rsget.close()
	End If 

	'//js , class 구분
	Dim scnum
	Dim arrcnt : arrcnt = array(2,5,8,11,14,17) '//필요 별 포인트 배열
	Dim prizenum : prizenum = array(prize1,prize2,prize3,prize4,prize5,prize6) '//상품 응모여부 배열
	ReDim strScript(6) , strClass(6)
	For scnum = 1 To 6 '//응모 가짓수
		If totcnt >= arrcnt(scnum-1) Then '//응모 가능 체크
			If prizenum(scnum-1) = 0 Then '//미참여
				strScript(scnum) = "jsattendance("& arrcnt(scnum-1) &");"
				strClass(scnum) = "class=""call"&scnum&" callOk"""
			Else 
				strScript(scnum) = "alert('이미 응모 하셨습니다.');return false;"
				strClass(scnum) = "class=""call"&scnum&" callEnd"""
			End If 
		Else
			strScript(scnum) = "return false;"
			strClass(scnum) = "class=""call"&scnum&""""
		End If
	Next 
%>
<style type="text/css">
.callChk {position:relative; height:480px; padding:65px 0 60px 0; margin-top:-20px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/14th/index/bg_brown_wave.png) repeat-x 50% 0;}
.callChk h3 {width:1092px; padding-left:48px; margin:0 auto; text-align:left;}

.growTree {position:absolute; left:50%; bottom:509px; margin-left:213px; text-align:center;}
.growCanAct {position:relative; padding-top:275px; margin:0 auto;}
.growCanAct strong {position:absolute; top:0; left:50%; margin-left:-39px; cursor:pointer;}
.growCanAct button {position:absolute; top:56px; left:50%; margin-left:43px; background-color:transparent; outline:none;}
.growCanAct .drop1 {position:absolute; top:160px; left:50%; margin-left:34px;}
.growCanAct .drop2 {position:absolute; top:166px; left:50%; margin-left:-3px;}
.growCanAct .drop3 {position:absolute; top:195px; left:50%; margin-left:16px;}
.treeView {margin:0 auto;}
.growTxt {width:310px; height:39px; margin:0 auto; background:url(http://webimage.10x10.co.kr/eventIMG/2015/14th/index/grow_txt_bg.png) no-repeat 50% 50%; line-height:39px; font-weight:bold; color:#000; text-align:center;}
.growTxt em {padding-left:10px; color:#d50c0c; text-decoration:underline;}

.chkList {width:1116px; height:245px; margin:58px auto 50px auto; background:url(http://webimage.10x10.co.kr/eventIMG/2015/14th/index/call_chk_line.png) no-repeat 50% 0;}
.chkList li {position:relative; float:left; width:186px; height:245px; background-position:50% 0; background-repeat:no-repeat;}
.chkList li dfn {overflow:hidden; display:block; position:absolute; left:0; top:0; width:100%; height:100%; text-indent:-999em;}
.chkList .call1 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/14th/index/call_chk01.png);}
.chkList .call2 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/14th/index/call_chk02.png);}
.chkList .call3 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/14th/index/call_chk03.png);}
.chkList .call4 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/14th/index/call_chk04.png);}
.chkList .call5 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/14th/index/call_chk05.png);}
.chkList .call6 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/14th/index/call_chk06.png);}
.chkList li.callOk {background-position:50% -275px; cursor:pointer;}
.chkList li.callEnd {background-position:50% -550px;}

.note {overflow:hidden; position:relative; width:900px; margin:0 auto; padding:30px 40px 30px 160px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/14th/index/note_bg.png) repeat 0 0;}
.note dt {position:absolute; left:40px; top:50%; width:120px; margin-top:-8px; text-align:left;}
.note dd {width:900px; text-align:left; font-size:11px; color:#fff;}
.note dd ul {overflow:hidden;}
.note dd li {position:relative; float:left; width:48%; padding:3px 0 0 10px; letter-spacing:-0.025em;}
.note dd li:before {position:absolute; left:0; top:50%; width:4px; height:4px; margin-top:-1px; background-color:#fff; content:''; border-radius:50%;}

.callLyr {display:none; position:absolute; left:50%; bottom:242px; width:270px; margin-left:-135px; padding-bottom:11px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/14th/index/call_lyr_btm.png) no-repeat 50% 100%; z-index:100;}
.callLyr .lyrInner {display:block; width:230px; padding:30px 20px 28px 20px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/14th/index/call_lyr_top.png) no-repeat 50% 0; text-align:center;}
.callLyr strong {font-size:16px; color:#000; letter-spacing:-0.05em;}
.callLyr .pdtPhoto {margin-top:12px;}
.callLyr .congMsg {padding-top:20px; font-size:12px; color:#000; font-weight:bold;}
.callLyr .contInfo {padding-top:5px; font-size:11px; color:#666;}
.callLyr .contInfo span {font-weight:bold;}
.callLyr .btnS2 {width:50px; padding:6px 10px 5px 10px;}

.growTree button.water {animation:water 2s ease-in-out 0s 2;}
.growTree strong {animation-iteration-count:infinite; animation-duration:1.5s; animation-name:bounce;}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:-5px; animation-timing-function:ease-in;}
}
@keyframes water {
	0% {transform:rotate(0);}
	50% {transform:rotate(-8deg);}
	100% {transform:rotate(0);}
}
</style>
<script>
$(function(){
	//'출석 체크
	$(".growTree span").css({"opacity":"0"});
	$(".growTree button, .growTree strong").click(function(){
		$(".growTree span").css({"opacity":"0"});
		$(".growTree button").addClass("water");
		$(".growTree .drop1").animate({"opacity":"1"},600);
		$(".growTree .drop2").delay(200).animate({"opacity":"1"},600);
		$(".growTree .drop3").delay(400).animate({"opacity":"1"},600);
		$(".growTree span").delay(500).animate({"opacity":"0"},600);
		$(".growTree .drop1").delay(600).animate({"opacity":"1"},600);
		$(".growTree .drop2").delay(800).animate({"opacity":"1"},600);
		$(".growTree .drop3").delay(1000).animate({"opacity":"1"},600);
		setTimeout(function(){
			$(".growTree button").removeClass("water");
		},5000);
	});
});

<%' 출석체크 %>
function jsdailychk(){
	<% if Date() < "2015-10-10" or Date() > "2015-10-26" then %>
		alert('이벤트 응모 기간이 아닙니다.');
		return;
	<% else %>
		var result;
			$.ajax({
				type:"GET",
				url:"/event/14th/attendance_proc.asp",
				data: "mode=daily",
				dataType: "text",
				async:false,
				cache:false,
				success : function(Data){
					result = jQuery.parseJSON(Data);
					if (result.resultcode=="22")
					{
						alert('매일 한 번 물을 주실 수 있어요!');
						return;
					}
					else if (result.resultcode=="44")
					{
						if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
							var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
							winLogin.focus();
							return false;
						}
						return false;
					}
					else if (result.resultcode=="11")
					{
						setTimeout(function(){
							$(".growCanAct .waterdrops img").attr("src","http://webimage.10x10.co.kr/eventIMG/2015/14th/index/grow_txt_after.png");
						},2000);

						var tcnt = result.Tcnt;
						if (tcnt < 10){ tcnt = "0"+tcnt }
						$(".treeView img").attr("src","http://webimage.10x10.co.kr/eventIMG/2015/14th/index/grow_tree"+tcnt+".png");
						$("#treecnt").text(result.Tcnt+"회");

						$( ".chkList li" ).each( function(index,item){
							if (index == (result.Lcode-1)){
								$(this).attr("class","call"+result.Lcode+" callOk");
								$(this).children('dfn').attr("onclick","jsattendance("+tcnt+");");
							}
						});
						return;
					}
				}
			});
	<% end if %>
}
<%' 응모 %>
function jsattendance(v){
	<% if date() < "2015-10-10" or date() > "2015-10-26" then %>
		alert('이벤트 응모 기간이 아닙니다.');
		return;
	<% else %>
	var result;
		$.ajax({
			type:"GET",
			url:"/event/14th/attendance_proc.asp",
			data: "mode=water&waterdrops="+v,
			dataType: "text",
			async:false,
			cache:false,
			success : function(Data){
				result = jQuery.parseJSON(Data);
				
				<% ' 선택시 모든 레이어 닫기  %>
				$( ".chkList li" ).each( function(index,item){
					$(this).children('.callLyr').hide();
				});

				var txt = result.txt;
				if (result.resultcode=="11")
				{
					$( ".chkList li" ).each( function(index,item){
						if (index == (result.Lcode-1)){
							$(this).children('.callLyr').show();
							$('#lyrInner'+result.Lcode).html(txt);
							$(this).removeClass("callOk");
							$(this).addClass("callEnd");
						}
					});
					return;
				}
				else if (result.resultcode=="22")
				{
					$( ".chkList li" ).each( function(index,item){
						if (index == (result.Lcode-1)){
							$(this).children('.callLyr').show();
							$('#lyrInner'+result.Lcode).html(txt);
							$(this).removeClass("callOk");
							$(this).addClass("callEnd");
						}
					});
					return;
				}
				else if (result.resultcode=="33")
				{
					alert('하루 한번 물을 주세요!');
					return;
				}

				else if (result.resultcode=="88")
				{
					alert('이벤트 응모 기간이 아닙니다.');
					return;
				}

				else if (result.resultcode=="99")
				{
					alert('이미 응모 하셨습니다.');
					return;
				}

			}
		});
	<% end if %>
	}

function clolyr(v){
	<% ' 개별 닫기 버튼  %>
	$('#callLyr'+v).hide();
}
</script>
<div class="callChk">
	<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/tit_call_check.png" alt="출.석.체.크 - 매일 한번씩 물을 주고 횟수에 따라 선물을 받으세요!" /></h3>
	<div class="growTree">
		<div class="growCanAct">
			<strong onclick="jsdailychk();" class="waterdrops"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/grow_txt<%=chkiif(todaycnt,"_after","")%>.png" alt="<%=chkiif(todaycnt,"내일 또 만나요","하루 한번 CLICK!")%>" /></strong>
			<button onclick="jsdailychk();"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/grow_can.png" alt="10x10 물뿌리개" /></button>
			<span class="drop1"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/grow_dropwater.png" alt="물방울1" /></span>
			<span class="drop2"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/grow_dropwater.png" alt="물방울2" /></span>
			<span class="drop3"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/grow_dropwater.png" alt="물방울3" /></span>
		</div>
		<p class="treeView"><% If totcnt > 0 Then %><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/grow_tree<%=chkiif(totcnt < 10 ,"0"&totcnt,totcnt)%>.png" alt="<%=totcnt%>일차 나무" /><% Else %><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/grow_tree00.png" alt="나무 시작전" id="tree" /><% End If %></p>
		<% If IsUserLoginOK Then %>
		<div class="growTxt"><%=userid%> 님이 물을 준 횟수 <em id="treecnt"><%=totcnt%>회</em></div>
		<% Else %>
		<div class="growTxt">로그인을 해주세요! : )</div>
		<% End If %>
	</div>
	<ul class="chkList">
		<li <%=strClass(1)%>>
			<div class="callLyr" id="callLyr1">
				<div class="lyrInner" id="lyrInner1"></div>
			</div>
			<dfn onclick="<%=strScript(1)%>">2회 출석 - 200마일리지 전원증정</dfn>
		</li>
		<li <%=strClass(2)%>>
			<div class="callLyr" id="callLyr2">
				<div class="lyrInner" id="lyrInner2"></div>
			</div>
			<dfn onclick="<%=strScript(2)%>">5회 출석 - 새싹 키우기(랜덤) 200명 증정</dfn>
		</li>
		<li <%=strClass(3)%>>
			<div class="callLyr" id="callLyr3">
				<div class="lyrInner" id="lyrInner3"></div>
			</div>
			<dfn onclick="<%=strScript(3)%>">8회 출석 - 300마일리지 전원증정</dfn>
		</li>
		<li <%=strClass(4)%>>
			<div class="callLyr" id="callLyr4">
				<div class="lyrInner" id="lyrInner4"></div>
			</div>
			<dfn onclick="<%=strScript(4)%>">11회 출석 - 포그링 가습기(랜덤) 100명 증정</dfn>
		</li>
		<li <%=strClass(5)%>>
			<div class="callLyr" id="callLyr5">
				<div class="lyrInner" id="lyrInner5"></div>
			</div>
			<dfn onclick="<%=strScript(5)%>">14회 출석 - 500마일리지 전원증정</dfn>
		</li>
		<li <%=strClass(6)%>>
			<div class="callLyr" id="callLyr6">
				<div class="lyrInner" id="lyrInner6"></div>
			</div>
			<dfn onclick="<%=strScript(6)%>">17회 출석 - 샤오미 공기청정기 10명 증정</dfn>
		</li>
	</ul>
	<dl class="note">
		<dt><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/index/note_tit.png" alt="유의사항" /></dt>
		<dd>
			<ul>
				<li>하루에 한 번만 참여할 수 있습니다.</li>
				<li>물을 준 횟수에 따라서 각 미션에 모두 응모할 수 있습니다.</li>
				<li>이벤트를 통해 받으실 마일리지는 2015년 10월 28일 (수)에 일괄 지급됩니다.</li>
				<li>이벤트 경품에 당첨되신 고객님은 2015년 10월 28일 (수)에 배송지 주소를 입력해주세요.</li>
				<li>비정상적인 참여를 할 경우엔, 당첨이 취소될 수 있습니다.</li>
				<li>상품이 당첨되신 분께는 세무신고를 위해 개인정보를 요청할 수 있습니다.</li>
			</ul>
		</dd>
	</dl>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->
<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  [2016 정기세일] 빙고빙고
' History : 2016.04.11 원승현
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
Dim vGubun, i, evt_code, userid, vQuery, toDateVal
Dim bingochk1, bingochk2, bingochk3, bingochk4, bingochk5, bingochk6, bingochk7, bingochk8, bingochk9, bingochk10, bingochk11, bingochk12, bingochk13, bingochk14, bingochk15, bingochk16
Dim bingoLineA, bingoLineB, bingoLineC, bingoLineD, bingoLineE, bingoLineF, bingoLineG, bingoLineH, bingoLineI, bingoLineJ
Dim vAttendCnt, vBingoCnt

vAttendCnt = 0
vBingoCnt = 0

userid = GetEncLoginUserID()

IF application("Svr_Info") = "Dev" THEN
	evt_code   =  66101
Else
	evt_code   =  70029
End If

'// 해당일자 셋팅
toDateVal = Left(now(), 10)


'// 값 초기화
bingochk1 = False
bingochk2 = False
bingochk3 = False
bingochk4 = False
bingochk5 = False
bingochk6 = False
bingochk7 = False
bingochk8 = False
bingochk9 = False
bingochk10 = False
bingochk11 = False
bingochk12 = False
bingochk13 = False
bingochk14 = False
bingochk15 = False
bingochk16 = False

'// 빙고판에 기본적으로 선택되어져 있는 값이 있음.
bingochk6 = true
bingochk11 = true
bingochk14 = true


'// 빙고 번호 선택값 불러옴
vQuery = "SELECT idx, userid, lineNum, regdate FROM [db_temp].[dbo].[tbl_event_70029] WHERE userid='"&userid&"' "
rsget.CursorLocation = adUseClient
rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
IF Not rsget.Eof Then
	Do Until rsget.eof
		if rsget("lineNum")=1 then bingochk1 = true
		if rsget("lineNum")=2 then bingochk2 = true
		if rsget("lineNum")=3 then bingochk3 = true
		if rsget("lineNum")=4 then bingochk4 = true
		if rsget("lineNum")=5 then bingochk5 = true
		if rsget("lineNum")=7 then bingochk7 = true
		if rsget("lineNum")=8 then bingochk8 = true
		if rsget("lineNum")=9 then bingochk9 = true
		if rsget("lineNum")=10 then bingochk10 = true
		if rsget("lineNum")=12 then bingochk12 = true
		if rsget("lineNum")=13 then bingochk13 = true
		if rsget("lineNum")=15 then bingochk15 = true
		if rsget("lineNum")=16 then bingochk16 = True
		vAttendCnt = vAttendCnt + 1
	rsget.movenext
	Loop
End IF
rsget.close

vQuery = "SELECT sub_opt1, sub_opt3 FROM [db_event].[dbo].[tbl_event_subscript] WHERE userid='"&userid&"' And evt_code='"&evt_code&"' "
rsget.CursorLocation = adUseClient
rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
IF Not rsget.Eof Then
	Do Until rsget.eof
		If Trim(rsget("sub_opt1"))="lineA" Then
			If rsget("sub_opt3")="" Or isnull(rsget("sub_opt3")) Then
				bingoLineA = 1
			Else
				bingoLineA = 2
			End If
		End If

		If Trim(rsget("sub_opt1"))="lineB" Then
			If rsget("sub_opt3")="" Or isnull(rsget("sub_opt3")) Then
				bingoLineB = 1
			Else
				bingoLineB = 2
			End If
		End If

		If Trim(rsget("sub_opt1"))="lineC" Then
			If rsget("sub_opt3")="" Or isnull(rsget("sub_opt3")) Then
				bingoLineC = 1
			Else
				bingoLineC = 2
			End If
		End If

		If Trim(rsget("sub_opt1"))="lineD" Then
			If rsget("sub_opt3")="" Or isnull(rsget("sub_opt3")) Then
				bingoLineD = 1
			Else
				bingoLineD = 2
			End If
		End If

		If Trim(rsget("sub_opt1"))="lineE" Then
			If rsget("sub_opt3")="" Or isnull(rsget("sub_opt3")) Then
				bingoLineE = 1
			Else
				bingoLineE = 2
			End If
		End If

		If Trim(rsget("sub_opt1"))="lineF" Then
			If rsget("sub_opt3")="" Or isnull(rsget("sub_opt3")) Then
				bingoLineF = 1
			Else
				bingoLineF = 2
			End If
		End If

		If Trim(rsget("sub_opt1"))="lineG" Then
			If rsget("sub_opt3")="" Or isnull(rsget("sub_opt3")) Then
				bingoLineG = 1
			Else
				bingoLineG = 2
			End If
		End If

		If Trim(rsget("sub_opt1"))="lineH" Then
			If rsget("sub_opt3")="" Or isnull(rsget("sub_opt3")) Then
				bingoLineH = 1
			Else
				bingoLineH = 2
			End If
		End If

		If Trim(rsget("sub_opt1"))="lineI" Then
			If rsget("sub_opt3")="" Or isnull(rsget("sub_opt3")) Then
				bingoLineI = 1
			Else
				bingoLineI = 2
			End If
		End If

		If Trim(rsget("sub_opt1"))="lineJ" Then
			If rsget("sub_opt3")="" Or isnull(rsget("sub_opt3")) Then
				bingoLineJ = 1
			Else
				bingoLineJ = 2
			End If
		End If

		vBingoCnt = vBingoCnt + 1
	rsget.movenext
	Loop
End If
rsget.close

%>
<style type="text/css">
img {vertical-align:top;}
#contentWrap {padding:0;}
.gnbWrapV15 {height:38px;}

div.navigator {border-bottom:10px solid #f56b5e;}

.bingoWrap {background:#ff867b url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/bg_deco.png) 50% 0 repeat-x;}
.bingoCont {width:1140px; margin:0 auto; padding-top:143px;}
.bingoTit {position:relative;}
.bingoTit .lineAni {position:absolute; left:50%; top:30px; width:365px; height:34px; margin-left:-100px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/tit_bingo_line.png) no-repeat 0 50%; animation:line 1.5s ease-in-out; transform-origin:0 0;}
@keyframes line {
	0% {transform:scaleX(0.1);}
	100% {transform:scaleX(1);}
}
.bingoGift {padding-top:75px;}
.bingoGame {position:relative; width:925px; margin:30px auto 0 auto; padding-bottom:22px;}
.bingoCount {position:absolute; right:50px; bottom:196px; color:#fff; font-size:22px; font-weight:bold; font-family:tahoma, verdana, sans-serif;}
.bingoCount span {display:inline-block; width:50px; padding:0 19px; text-align:center;}

.bingo {overflow:hidden; position:absolute; left:60px; top:42px; width:592px; z-index:1;}
.bingo li {float:left; width:148px; height:148px; text-align:left; cursor:pointer; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/bg_blank.png) 0 0 repeat;}
.bingo li img {display:none;}
.bingo li.selected {cursor:default;}
.bingo li.selected img {display:block;}

.bingoLine {overflow:hidden;}
.bingoLine li {display:none; position:absolute; background-position:0 0; background-repeat:no-repeat; z-index:3; cursor:pointer; display:none;}
.bingoLine li:before {position:absolute; width:65px; height:58px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_hand1.png) 0 0 no-repeat; content:''; }
@keyframes hand1 {
	0% {margin-top:0;}
	100% {margin-top:-5px; transform:rotate(3deg);}
}
@keyframes hand2 {
	0% {margin-left:0;}
	100% {margin-left:-5px; transform:rotate(-3deg);}
}
@keyframes hand3 {
	0% {margin-top:0;}
	100% {margin-top:-5px;}
}
.bingoLine li.rowLine {left:40px; width:605px; height:34px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_line_row.png); z-index:4;}
.bingoLine li.rowLine:before {left:50%; top:95%; animation:500ms hand1 ease-in-out infinite alternate;}
.bingoLine li.colLine {top:28px; width:34px; height:605px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_line_col.png); z-index:5;}
.bingoLine li.colLine:before {left:100%; top:45%; animation:500ms hand2 ease-in-out infinite alternate;}
.bingoLine li.lineA {top:95px;}
.bingoLine li.lineB {top:245px;}
.bingoLine li.lineC {top:390px;}
.bingoLine li.lineD {top:538px;}
.bingoLine li.lineE {left:104px;}
.bingoLine li.lineF {left:252px;}
.bingoLine li.lineG {left:400px;}
.bingoLine li.lineH {left:545px;}
.bingoLine li.lineI {left:50px; top:45px; width:583px; height:583px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_line_diagonal1.png);}
.bingoLine li.lineI:before {left:45%; top:52%; width:63px; height:72px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_hand2.png) 0 0 no-repeat; animation:500ms hand3 ease-in-out infinite alternate;}
.bingoLine li.lineJ {left:48px; top:45px; width:583px; height:583px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_line_diagonal2.png);}
.bingoLine li.lineJ:before {left:52%; top:50%; animation:500ms hand2 ease-in-out infinite alternate;}

.bingoEndLine {overflow:hidden;}
.bingoEndLine li {display:none; position:absolute; background-position:0 0; background-repeat:no-repeat; z-index:0;}
.bingoEndLine li.rowLine {left:115px; width:461px; height:3px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_line_end_row.png);}
.bingoEndLine li.colLine {top:105px; width:3px; height:461px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_line_end_col.png); }
.bingoEndLine li.lineA {top:110px;}
.bingoEndLine li.lineB {top:260px;}
.bingoEndLine li.lineC {top:405px;}
.bingoEndLine li.lineD {top:553px;}
.bingoEndLine li.lineE {left:120px;}
.bingoEndLine li.lineF {left:268px;}
.bingoEndLine li.lineG {left:415px;}
.bingoEndLine li.lineH {left:560px;}
.bingoEndLine li.lineI {left:120px; top:105px; width:442px; height:442px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_line_end_diagonal1.png);}
.bingoEndLine li.lineJ {left:120px; top:105px; width:443px; height:443px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_line_end_diagonal2.png);}

.dimmed {display:none; position:absolute; left:42px; top:35px; width:600px; height:600px; background-color:rgba(255,255,255,0); z-index:2;}
.giftView {display:none; position:fixed; top:50% !important; left:50% !important; width:906px; height:867px; margin:-433px 0 0 -453px;}
.giftView > div {position:relative; width:100%; height:100%;}
.giftView .lyrClose {overflow:hidden; position:absolute; right:55px; top:45px; width:55px; height:55px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/bg_blank.png) 0 0 repeat; text-indent:-999em; outline:none;}

.giftLyr {display:none; position:fixed; top:50% !important; left:50% !important; width:514px; height:574px; margin:-287px 0 0 -257px;}
.giftLyr > div {position:relative; width:100%; height:100%;}
.giftLyr .lyrClose {overflow:hidden; position:absolute; right:-10px; top:-10px; width:31px; height:31px; background:transparent url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/btn_bingo_gift_close.png) 0 0 no-repeat; text-indent:-999em; outline:none;}
.goMyten {overflow:hidden; position:absolute; left:50%; bottom:75px; width:230px; height:52px; margin-left:-115px; text-indent:-999em; outline:none;}
.code {position:absolute; left:0; bottom:40px; width:100%; color:#ccc; text-align:center;}

.noti {background-color:#f56b5e; text-align:left;}
.noti .inner {position:relative; width:1140px; margin:0 auto; padding:40px 0;}
.noti .inner h3 {position:absolute; top:50%; left:160px; margin-top:-12px;}
.noti .inner ul {padding-left:340px; color:#fff;}
.noti .inner ul li {margin-bottom:2px; padding-left:14px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/blt_dot.png) no-repeat 0 6px; color:#fff; font-family:'Dotum', 'Verdana'; font-size:12px; line-height:1.5em;}

.ftContent {position:relative; width:1140px; margin:0 auto;}
.fourtenSns {background-color:#84edc9;}
.fourtenSns button {overflow:hidden; position:absolute; top:40px; width:240px; height:70px; background-color:rgba(0,0,0,0); background-color:transparent; text-indent:-999rem;}
.fourtenSns .ktShare {left:650px;}
.fourtenSns .fbShare {left:890px;}

</style>

<script type="text/javascript">

function BingoNumClick(n)
{
	<% If IsUserLoginOK() Then %>
		$.ajax({
			type:"GET",
			url:"/event/4ten/bingoProc.asp?mode=bingo&userSelVal="+n,
			dataType: "text",
			async:false,
			cache:true,
			success : function(Data, textStatus, jqXHR){
				if (jqXHR.readyState == 4) {
					if (jqXHR.status == 200) {
						if(Data!="") {
							var str;
//							for(var i in Data)
//							{
//								 if(Data.hasOwnProperty(i))
//								{
//									str += Data[i];
//								}
//							}
//							str = str.replace("undefined","");
							res = Data.split("|");
							if (res[0]=="OK")
							{
								$("#b"+n).addClass('selected');
								$("#b"+n).attr('onclick', '').unbind('click');
								$("#attendCnt").empty().html(res[1]);
								$("#bingoCnt").empty().html(res[2]);
								okMsg = res[3].replace(">?n", "\n");
								alert(okMsg);
							}
							else if (res[0]=="OKBINGO")
							{
								$("#b"+n).addClass('selected');
								$("#attendCnt").empty().html(res[1]);
								$("#bingoCnt").empty().html(res[2]);
								$("#"+res[3]).attr('style','display:block');
								if (res[4]!="")
								{
									$("#"+res[4]).attr('style','display:block');
								}
								if (res[5]!="")
								{
									$("#"+res[5]).attr('style','display:block');
								}
								alert("Wow 빙고가 터졌어요\n아래 빙고라인 누르고 상품에 응모해 보세요!");
							}
							else
							{
								errorMsg = res[1].replace(">?n", "\n");
								alert(errorMsg);
								return false;
							}
						} else {
							alert("잘못된 접근 입니다.");
							document.location.reload();
							return false;
						}
					}
				}
			},
			error:function(jqXHR, textStatus, errorThrown){
				alert("잘못된 접근 입니다.");
				var str;
				for(var i in jqXHR)
				{
					 if(jqXHR.hasOwnProperty(i))
					{
						str += jqXHR[i];
					}
				}
				alert(str);
				document.location.reload();
				return false;
			}
		});
	<% else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}
	<% end if %>
}



function BingoRightClick(n)
{
	<% If IsUserLoginOK() Then %>
		$.ajax({
			type:"GET",
			url:"/event/4ten/bingoProc.asp?mode=add&userBingoVal="+n,
			dataType: "text",
			async:false,
			cache:true,
			success : function(Data, textStatus, jqXHR){
				if (jqXHR.readyState == 4) {
					if (jqXHR.status == 200) {
						if(Data!="") {
							var str;
//							for(var i in Data)
//							{
//								 if(Data.hasOwnProperty(i))
//								{
//									str += Data[i];
//								}
//							}
//							str = str.replace("undefined","");
							res = Data.split("|");
							if (res[0]=="OK")
							{
								$("#"+n).hide();
								$('.bingoEndLine').find('.'+ n +'').show();
								$('.dimmed').hide();
								$("#giftLyr").empty().html(res[1]);
								viewPoupLayer('modal',$('#giftLyr').html());
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
							document.location.reload();
							return false;
						}
					}
				}
			},
			error:function(jqXHR, textStatus, errorThrown){
				alert("잘못된 접근 입니다.");
				var str;
				for(var i in jqXHR)
				{
					 if(jqXHR.hasOwnProperty(i))
					{
						str += jqXHR[i];
					}
				}
				alert(str);
				document.location.reload();
				return false;
			}
		});
	<% else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}
	<% end if %>
}

</script>
</head>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt">
		<div id="contentWrap">
			<div class="eventWrapV15">
				<div class="eventContV15">
					<div class="contF contW">
						
						<%' 수작업 영역 %>
						<div class="bingoWrap">
							<%' 세일 이벤트 헤더 영역 %>
							<!-- #include virtual="/event/4ten/nav.asp" -->
							<%'// 세일 이벤트 헤더 영역 %>

							<div class="bingoCont">
								<div class="bingoTit">
									<p class="lineAni"></p>
									<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/tit_bingo.png" alt="빙고 BINGO" /></h2>
								</div>
								<div class="bingoGift">
									<p><a href="#giftView" onclick="viewPoupLayer('modal',$('#giftView').html());return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift.png" alt="당첨 상품 더보기" /></a></p>
								</div>
								<div id="giftView">
									<div class="giftView window">
										<div>
											<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift_lyr.png" alt="당첨 상품 리스트" />
											<button type="button" onclick="ClosePopLayer()" class="lyrClose">닫기</button>
										</div>
									</div>
								</div>
								<div class="bingoGame">
									<ul class="bingoLine">
										<li class="lineA rowLine" name="lineA" id="lineA" <% If bingoLineA=1 Then %>style="display:block" <% End If %> onclick="BingoRightClick('lineA');return false;"></li>
										<li class="lineB rowLine" name="lineB" id="lineB" <% If bingoLineB=1 Then %>style="display:block" <% End If %> onclick="BingoRightClick('lineB');return false;"></li>
										<li class="lineC rowLine" name="lineC" id="lineC" <% If bingoLineC=1 Then %>style="display:block" <% End If %> onclick="BingoRightClick('lineC');return false;"></li>
										<li class="lineD rowLine" name="lineD" id="lineD" <% If bingoLineD=1 Then %>style="display:block" <% End If %> onclick="BingoRightClick('lineD');return false;"></li>
										<li class="lineE colLine" name="lineE" id="lineE" <% If bingoLineE=1 Then %>style="display:block" <% End If %> onclick="BingoRightClick('lineE');return false;"></li>
										<li class="lineF colLine" name="lineF" id="lineF" <% If bingoLineF=1 Then %>style="display:block" <% End If %> onclick="BingoRightClick('lineF');return false;"></li>
										<li class="lineG colLine" name="lineG" id="lineG" <% If bingoLineG=1 Then %>style="display:block" <% End If %> onclick="BingoRightClick('lineG');return false;"></li>
										<li class="lineH colLine" name="lineH" id="lineH" <% If bingoLineH=1 Then %>style="display:block" <% End If %> onclick="BingoRightClick('lineH');return false;"></li>
										<li class="lineI" name="lineI" id="lineI" <% If bingoLineI=1 Then %>style="display:block" <% End If %> onclick="BingoRightClick('lineI');return false;"></li>
										<li class="lineJ" name="lineJ" id="lineJ" <% If bingoLineJ=1 Then %>style="display:block" <% End If %> onclick="BingoRightClick('lineJ');return false;"></li>
									</ul>
									<ul class="bingoEndLine">
										<li class="lineA rowLine" <% If bingoLineA=2 Then %>style="display:block"<% End If %>></li>
										<li class="lineB rowLine" <% If bingoLineB=2 Then %>style="display:block"<% End If %>></li>
										<li class="lineC rowLine" <% If bingoLineC=2 Then %>style="display:block"<% End If %>></li>
										<li class="lineD rowLine" <% If bingoLineD=2 Then %>style="display:block"<% End If %>></li>
										<li class="lineE colLine" <% If bingoLineE=2 Then %>style="display:block"<% End If %>></li>
										<li class="lineF colLine" <% If bingoLineF=2 Then %>style="display:block"<% End If %>></li>
										<li class="lineG colLine" <% If bingoLineG=2 Then %>style="display:block"<% End If %>></li>
										<li class="lineH colLine" <% If bingoLineH=2 Then %>style="display:block"<% End If %>></li>
										<li class="lineI" <% If bingoLineI=2 Then %>style="display:block"<% End If %>></li>
										<li class="lineJ" <% If bingoLineJ=2 Then %>style="display:block"<% End If %>></li>
									</ul>
									<div class="dimmed"></div>
									<ul class="bingo">
										<li class="b01 <% If bingochk1 Then %>selected<% End If %>" id="b1" <% If bingochk1=false Then %>onclick="BingoNumClick('1');"<% End If %>><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_show.png" alt="" /></li>
										<li class="b02 <% If bingochk2 Then %>selected<% End If %>" id="b2" <% If bingochk2=false Then %>onclick="BingoNumClick('2');"<% End If %>><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_show.png" alt="" /></li>
										<li class="b03 <% If bingochk3 Then %>selected<% End If %>" id="b3" <% If bingochk3=false Then %>onclick="BingoNumClick('3');"<% End If %>><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_show.png" alt="" /></li>
										<li class="b04 <% If bingochk4 Then %>selected<% End If %>" id="b4" <% If bingochk4=false Then %>onclick="BingoNumClick('4');"<% End If %>><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_show.png" alt="" /></li>
										<li class="b05 <% If bingochk5 Then %>selected<% End If %>" id="b5" <% If bingochk5=false Then %>onclick="BingoNumClick('5');"<% End If %>><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_show.png" alt="" /></li>
										<li class="b06 <% If bingochk6 Then %>selected<% End If %>" id="b6"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_show.png" alt="" /></li>
										<li class="b07 <% If bingochk7 Then %>selected<% End If %>" id="b7" <% If bingochk7=false Then %>onclick="BingoNumClick('7');"<% End If %>><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_show.png" alt="" /></li>
										<li class="b08 <% If bingochk8 Then %>selected<% End If %>" id="b8" <% If bingochk8=false Then %>onclick="BingoNumClick('8');"<% End If %>><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_show.png" alt="" /></li>
										<li class="b09 <% If bingochk9 Then %>selected<% End If %>" id="b9" <% If bingochk9=false Then %>onclick="BingoNumClick('9');"<% End If %>><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_show.png" alt="" /></li>
										<li class="b10 <% If bingochk10 Then %>selected<% End If %>" id="b10" <% If bingochk10=false Then %>onclick="BingoNumClick('10');"<% End If %>><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_show.png" alt="" /></li>
										<li class="b11 <% If bingochk11 Then %>selected<% End If %>" id="b11"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_show.png" alt="" /></li>
										<li class="b12 <% If bingochk12 Then %>selected<% End If %>" id="b12" <% If bingochk12=false Then %>onclick="BingoNumClick('12');"<% End If %>><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_show.png" alt="" /></li>
										<li class="b13 <% If bingochk13 Then %>selected<% End If %>" id="b13" <% If bingochk13=false Then %>onclick="BingoNumClick('13');"<% End If %>><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_show.png" alt="" /></li>
										<li class="b14 <% If bingochk14 Then %>selected<% End If %>" id="b14"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_show.png" alt="" /></li>
										<li class="b15 <% If bingochk15 Then %>selected<% End If %>" id="b15" <% If bingochk15=false Then %>onclick="BingoNumClick('15');"<% End If %>><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_show.png" alt="" /></li>
										<li class="b16 <% If bingochk16 Then %>selected<% End If %>" id="b16" <% If bingochk16=false Then %>onclick="BingoNumClick('16');"<% End If %>><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_show.png" alt="" /></li>
									</ul>
									<p class="bingoCount">
										<span id="attendCnt"><%=vAttendCnt%></span>
										<span id="bingoCnt"><%=vBingoCnt%></span>
									</p>
									<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_board.png" alt="하루에 한번 빙고숫자 누르고 빙고 한줄 완성 후 누르고 상품 확인합니다." />
								</div>
								<div id="giftLyr"></div>
							</div>
						</div>
						<%'// 수작업 영역 %>

						<div class="noti">
							<div class="inner">
								<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/tit_noti.png" alt="유의사항" /></h3>
								<ul>
									<li>본 이벤트는 ID당 하루에 한 번 빙고 숫자를 선택할 수 있습니다.</li>
									<li>당첨상품은 빙고가 완성될 때마다 확인할 수 있습니다.</li>
									<li>빙고 완성 시, 해당 빙고에 대한 당첨 여부 확인 후 다음 빙고 숫자 선택 가능합니다.</li>
									<li>연속 빙고가 나왔을 시 먼저 누른 순으로 상품을 확인할 수 있습니다.</li>
									<li>당첨된 상품 및 마일리지는 4월 29일(금요일) 일괄 배송 혹은 지급예정입니다.</li>
									<li>5만원 이상의 상품에 당첨되신 분께는 세무신고를 위해 개인정보를 요청할 수 있으며, 제세공과금은 텐바이텐 부담입니다.</li>
									<li>이벤트 내 모든 상품의 컬러는 랜덤으로 발송되며, 선택할 수 없습니다.</li>
								</ul>
							</div>
						</div>
						<!-- #include virtual="/event/4ten/sns.asp" -->
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->
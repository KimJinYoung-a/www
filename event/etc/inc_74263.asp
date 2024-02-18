<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  [이벤트] 모여라 꿈동산2
' History : 2016.11.11 원승현
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%

	Dim eCode, vQuery, nowDate, userid, myAppearCnt, intLoop, intLoop2, winCnt

	IF application("Svr_Info") = "Dev" THEN
		eCode   =  66234
	Else
		eCode   =  74263
	End If

	'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
	if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
		if Not(Request("mfg")="pc" or session("mfg")="pc") then
			if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
				dim mRdSite: mRdSite = requestCheckVar(request("rdsite"),32)
				Response.Redirect "http://m.10x10.co.kr/event/eventmain.asp?eventid=" & eCode & chkIIF(mRdSite<>"","&rdsite=" & mRdSite,"")
				REsponse.End
			end if
		end if
	end if

	'// 아이디
	userid = getEncLoginUserid()
	'// 오늘날짜
	nowDate = Left(Now(), 10)
'	nowDate = "2016-11-14"
	'// 당첨인원
	winCnt = 0
	myAppearCnt = 0

	'// 현재 해당일자 응모 인원수 확인
	vQuery = "SELECT count(*) FROM [db_event].[dbo].[tbl_event_subscript] WHERE evt_code = '" & eCode & "' And convert(varchar(10), regdate, 120) = '"&nowDate&"' "
	rsget.CursorLocation = adUseClient
	rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
	IF Not rsget.Eof Then
		myAppearCnt = rsget(0)
	End IF
	rsget.close

	'myAppearCnt = 10001

	

	'// Facebook 오픈그래프 메타태그 작성
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 다다익선 프로젝트 모여라꿈동산2"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""http://www.10x10.co.kr/event/eventmain.asp?eventid="&eCode&" />" & vbCrLf
	
	strHeaderAddMetaTag = strHeaderAddMetaTag & "<meta property=""og:image"" content=""http://webimage.10x10.co.kr/eventIMG/2016/74263/m/img_kakao.jpg"" />" & vbCrLf &_
												"<link rel=""image_src"" href=""http://webimage.10x10.co.kr/eventIMG/2016/74263/m/img_kakao.jpg"" />" & vbCrLf

	strPageTitle = "[텐바이텐] 다다익선 프로젝트 모여라꿈동산2"
	strPageKeyword = "[텐바이텐] 다다익선 프로젝트 모여라꿈동산2"
	strPageDesc = "[텐바이텐] 모여라 꿈동산2 - 응모자가 많아질수록 당첨자도 늘어납니다!"
	

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
img {vertical-align:top;}
button {background:transparent;}
.dreamHead {position:relative; height:496px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74263/bg_head.png) 0 0 no-repeat;}
.dreamHead h2 {display:block; position:absolute; left:50%; top:123px; width:310px; height:219px; margin-left:-155px;}
.dreamHead h2 span {display:block; position:absolute; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74263/tit_dream_hill.png) 0 0 no-repeat; text-indent:-999em;}
.dreamHead h2 span.t01 {left:0; top:0; width:310px; height:100px;}
.dreamHead h2 span.t02 {left:0; top:100px; width:248px; height:118px; background-position:0 -101px;}
.dreamHead h2 span.t03 {left:255px; top:100px; width:55px; height:118px; background-position:100% 100%;}
.dreamHead p {position:absolute; left:50%;}
.dreamHead .flag {top:57px; margin-left:-130px;}
.dreamHead .winner {top:366px; margin-left:-152px;}
.dreamHead .date {top:408px; margin-left:-113px;}
.dreamCont {position:relative; height:665px; padding-left:374px; text-align:center; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74263/bg_cont.png) 0 0 no-repeat;}
.dreamCont h3 {position:absolute; left:50%; top:66px; z-index:30; margin-left:-142px;}
.dreamCont .winnerGraph {position:absolute; left:90px; top:80px;}
.dreamCont .dreamItem {position:relative;}
.dreamCont .dreamItem .todayIs {padding:93px 0 32px;}
.dreamCont .dreamItem .count {padding-bottom:22px;}
.dreamCont .dreamItem .count span {display:block; padding:2px 0; line-height:25px;}
.dreamCont .dreamItem .count em {display:inline-block; margin:0 6px 0 8px; padding-bottom:4px; color:#8146d7; font:bold italic 25px/21px arial; padding-right:20px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74263/txt_num.png) 100% 0 no-repeat;}
.dreamCont .dreamItem .btnNext {position:absolute; right:72px; top:176px; z-index:30;}
.dreamCont .dreamItem .btnSubmit  {animation:bounce 1s 50;}
.nextDreamhill {display:none; position:absolute; left:0; top:0; width:100%; height:100%;}
.nextDreamhill .bg {position:absolute; left:0; top:0; width:100%; height:100%; z-index:1000; background:url(http://fiximage.10x10.co.kr/web2013/common/mask_bg.png) left top repeat;}
.nextDreamhill .item {position:absolute; left:50%; top:50%; margin:-317px 0 0 -386px; z-index:1005;}
.nextDreamhill .item .btnClose {position:absolute; right:23px; top:17px; z-index:1010;}
.evtNoti {position:relative; padding:40px 0 40px 258px; background:#e4eaea;}
.evtNoti h3 {position:absolute; left:88px; top:50%; margin-top:-33px;}
.evtNoti ul {padding:8px 0 8px 50px; text-align:left; color:#696969; border-left:1px solid #d6dada;}
.evtNoti li {padding:3px 0;}
.evtNoti .share {position:absolute; right:60px; top:78px;}
@keyframes bounce {
	from to {transform:translateY(0); animation-timing-function:ease-out;}
	50% {transform:translateY(-5px); animation-timing-function:ease-in;}
}
</style>
<script type="text/javascript">
$(function(){
	animation();
	$(".dreamHead h2 .t01").css({"margin-left":"10px", "opacity":"0"});
	$(".dreamHead h2 .t02").css({"margin-left":"-10px", "opacity":"0"});
	$(".dreamHead h2 .t03").css({"margin-left":"60px", "opacity":"0"});
	$(".dreamHead .flag").css({"margin-top":"-20px", "opacity":"0"});
	$(".dreamHead .winner").css({"margin-top":"5px", "opacity":"0"});
	$(".dreamHead .date").css({"margin-top":"5px", "opacity":"0"});
	function animation () {
		$(".dreamHead .flag").delay(1000).animate({"margin-top":"0", "opacity":"1"},{duration: 'slow', easing: 'easeOutElastic'}, 800);
		$(".dreamHead h2 .t01").delay(100).animate({"margin-left":"0", "opacity":"1"},500);
		$(".dreamHead h2 .t02").delay(100).animate({"margin-left":"0", "opacity":"1"},500);
		$(".dreamHead h2 .t03").delay(600).animate({"margin-left":"-5px", "opacity":"1"},300).animate({"margin-left":"0"},200);
		$(".dreamHead .winner").delay(800).animate({"margin-top":"0", "opacity":"1"},600);
		$(".dreamHead .date").delay(1000).animate({"margin-top":"0", "opacity":"1"},600);
	}
	$(".btnNext").click(function(){
		$(".nextDreamhill").show();
		window.parent.$('html,body').animate({scrollTop:500}, 500);
	});
	$(".btnClose").click(function(){
		$(".nextDreamhill").hide();
	});
	$(".nextDreamhill .bg").click(function(){
		$(".nextDreamhill").hide();
	});
});

function goDongsanSubmit()
{
	<% If not(IsUserLoginOK()) Then %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
			return;
		}
		return false;
	<% end if %>

	$.ajax({
		type:"GET",
		url:"/event/etc/doEventSubscript74263.asp?mode=ins",
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
							alert("응모가 완료되었습니다.");
							parent.location.reload();
							return false;
						}
						else
						{
							errorMsg = res[1].replace(">?n", "\n");
							alert(errorMsg);
							parent.location.reload();
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
			var str;
			for(var i in jqXHR)
			{
				 if(jqXHR.hasOwnProperty(i))
				{
					str += jqXHR[i];
				}
			}
			alert(str);
			parent.location.reload();
			return false;
		}
	});
}

function goSnsSubmit(gubun, strtitle, strlink)
{
	<% If not(IsUserLoginOK()) Then %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
			return;
		}
		return false;
	<% end if %>

	$.ajax({
		type:"GET",
		url:"/event/etc/doEventSubscript74263.asp?mode=sns",
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
							popSNSPost(gubun,strtitle,strlink,'','');
							return false;
						}
						else
						{
							errorMsg = res[1].replace(">?n", "\n");
							alert(errorMsg);
							parent.location.reload();
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
			var str;
			for(var i in jqXHR)
			{
				 if(jqXHR.hasOwnProperty(i))
				{
					str += jqXHR[i];
				}
			}
			alert(str);
			parent.location.reload();
			return false;
		}
	});
}

</script>
<div class="contF">
	<%' 모여라 꿈동산2 %>
	<div class="evt74263">
		<div class="dreamHead">
			<p class="flag"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74263/txt_project.png" alt="다다익선 프로젝트" /></p>
			<h2>
				<span class="t01">모여라</span>
				<span class="t02">꿈동산</span>
				<span class="t03">2</span>
			</h2>
			<p class="winner"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74263/txt_winner.png" alt="응모자가 늘어날수록 당첨자는 많아집니다!" /></p>
			<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74263/txt_date.png" alt="당첨자 발표:11월 23일 수요일" /></p>
		</div>
		<div class="dreamCont">
			<%' 당첨자 수 %>
			<div class="winnerGraph">
				<%' ~5000명 %>
				<% If myAppearCnt < 5001 Then %>
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/74263/img_graph_01.gif" alt="1명" />
					<% winCnt = 1 %>
				<% End If %>

				<%' ~10000명 %>
				<% if myAppearCnt >= 5001 And myAppearCnt < 10001 then %>
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/74263/img_graph_02.gif" alt="3명" />
					<% winCnt = 3 %>
				<% End If %>

				<%' ~15000명 %>
				<% if myAppearCnt >= 10001 And myAppearCnt < 15001 then %>
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/74263/img_graph_03.gif" alt="5명" />
					<% winCnt = 5 %>
				<% End If %>

				<%' ~20000명 %>
				<% if myAppearCnt >= 15001 And myAppearCnt < 20001 then %>
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/74263/img_graph_04.gif" alt="7명" />
					<% winCnt = 7 %>
				<% End If %>

				<%' ~50000명 %>
				<% if myAppearCnt >= 20001 then %>
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/74263/img_graph_05.gif" alt="10명" />
					<% winCnt = 10 %>
				<% End If %>
			</div>
			<%'// 당첨자 수 %>

			<!-- 응모자수, 응모하기 -->
			<div class="dreamItem">
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/74263/txt_today.png" alt="오늘의 꿈상품" /></h3>
				<div class="todayIs">
					<%' 14일 %>
					<% If nowDate = "2016-11-14" Then %>
						<a href="/shopping/category_prd.asp?itemid=1595561&pEtr=74263" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74263/img_item_01.png" alt="라인프렌즈 브라운 공기청정기 MINI" /></a>
					<% End If %>

					<%' 15일 %>
					<% If nowDate = "2016-11-15" Then %>
						<a href="/shopping/category_prd.asp?itemid=1396943&pEtr=74263" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74263/img_item_02.png" alt="스티키몬스터 보조베터리" /></a>
					<% End If %>

					<%' 16일 %>
					<% If nowDate = "2016-11-16" Then %>
						<a href="/shopping/category_prd.asp?itemid=1597424&pEtr=74263" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74263/img_item_03.png" alt="크리스마스트리 원목 오르골" /></a>
					<% End If %>

					<%' 17일 %>
					<% If nowDate = "2016-11-17" Then %>
						<a href="/shopping/category_prd.asp?itemid=830847&pEtr=74263" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74263/img_item_04.png" alt="Lamy Safari 만년필" /></a>
					<% End If %>

					<%' 18일 %>
					<% If nowDate = "2016-11-18" Then %>
						<a href="/shopping/category_prd.asp?itemid=1384344&pEtr=74263" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74263/img_item_05.png" alt="메모리 래인 캔들 워머" /></a>
					<% End If %>

				</div>
				<p class="count">
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/74263/txt_count_01.png" alt="현재" /><em><%=FormatNumber(myAppearCnt, 0)%></em><img src="http://webimage.10x10.co.kr/eventIMG/2016/74263/txt_count_02.png" alt="명 응모하셨습니다." /></span>
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/74263/txt_count_03.png" alt="당첨 예정자는" /><em><%=winCnt%></em><img src="http://webimage.10x10.co.kr/eventIMG/2016/74263/txt_count_04.png" alt="명 입니다." /></span>
				</p>
				<button type="submit" class="btnSubmit" onclick="goDongsanSubmit();return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74263/btn_apply.png" alt="응모하기" /></button>
				<button type="button" class="btnNext"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74263/btn_next.png" alt="내일의 상품보기" /></button>
			</div>
			<%'// 응모자수, 응모하기 %>
		</div>
		<div class="evtNoti">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/74263/tit_noti.png" alt="이벤트 유의사항" /></h3>
			<ul>
				<li>- 한 ID당 매일 1번만 참여할 수 있습니다.</li>
				<li>- 꿈상품의 당첨자는 11월 23일 공지사항을 통해 공지됩니다.</li>
				<li>- 당첨자 안내를 위해 정확한 개인정보를 입력해주세요.</li>
				<li>- 당첨된 ID가 다르더라도 배송지 또는 전화번호가 동일할 경우 경품 증정이 취소될 수 있습니다.</li>
				<li>- 경품에 대한 제세공과금은 텐바이텐 부담입니다.</li>
				<li>- 당첨자에 한해 개인정보를 취합한 후 경품이 증정됩니다.</li>
			</ul>
			<%' sns 공유 %>
			<%
				'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
				Dim vTitle, vLink, vPre, vImg
				
				dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
				snpTitle = Server.URLEncode("[텐바이텐] 모여라 꿈동산2")
				snpLink = Server.URLEncode("http://www.10x10.co.kr/event/eventmain.asp?eventid="&eCode)
				snpPre = Server.URLEncode("10x10 이벤트")
				
				'기본 태그
				snpTag = Server.URLEncode("텐바이텐")
				snpTag2 = Server.URLEncode("#10x10")
			%>
			<a href="" class="share" onclick="goSnsSubmit('fb','<%=strPageTitle%>','<%=snpLink%>');return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74263/btn_fb.png" alt="페이스북으로 이벤트 공유하면 당첨확률 2배!" /></a>
		</div>
		<%' 내일의 상품 레이어 %>
		<div class="nextDreamhill">
			<div class="item">
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/74263/img_dream_item.png" alt="모여라 꿈상품" /></div>
				<button type="button" class="btnClose"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74263/btn_close.png" alt="닫기" /></button>
			</div>
			<div class="bg"></div>
		</div>
		<%'// 내일의 상품 레이어 %>
	</div>
	<%'// 모여라 꿈동산2 %>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->
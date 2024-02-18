<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 플레잉 내 이름은 KYOTO 스페셜 뱃지 응모
' History : 2017.07.13 유태욱
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
dim eCode, vUserID, myevt, vDIdx, myselect
dim arrList, sqlStr

IF application("Svr_Info") = "Dev" THEN
	eCode = "66394"
Else
	eCode = "79254"
End If

vDIdx = request("didx")
vUserID = getEncLoginUserID
myselect = 0

'참여했는지 체크
myevt = getevent_subscriptexistscount(eCode, vUserID,"","","")

sqlStr = ""
sqlStr = sqlStr & " select isnull([1],0) as '1',isnull([2],0) as '2',isnull([3],0) as '3',isnull([4],0) as '4',isnull([5],0) as '5',isnull([6],0) as '6',isnull([7],0) as '7',isnull([8],0) as '8',isnull([9],0) as '9' " & vbCrlf
sqlStr = sqlStr & " from  " & vbCrlf
sqlStr = sqlStr & " ( " & vbCrlf
sqlStr = sqlStr & "		SELECT  sub_opt2 as so2, COUNT(*) as cnt " & vbCrlf
sqlStr = sqlStr & "			FROM db_event.[dbo].[tbl_event_subscript]  " & vbCrlf
sqlStr = sqlStr & "				where evt_code = '"& eCode &"' " & vbCrlf
sqlStr = sqlStr & "				group by sub_opt2 " & vbCrlf
sqlStr = sqlStr & " ) as a " & vbCrlf
sqlStr = sqlStr & " pivot " & vbCrlf
sqlStr = sqlStr & " ( " & vbCrlf
sqlStr = sqlStr & "		sum(cnt) for so2 in ([1],[2],[3],[4],[5],[6],[7],[8],[9]) " & vbCrlf
sqlStr = sqlStr & " ) as tp "
rsget.Open sqlStr,dbget,1
If not rsget.EOF Then
	arrList = rsget.getRows()
End If
rsget.close

dim numcols, rowcounter, colcounter, thisfield(8)
if isArray(arrList) then
	numcols=ubound(arrList,1)
		FOR colcounter=0 to numcols
			thisfield(colcounter)=arrList(colcounter,0)
			if isnull(thisfield(colcounter)) or trim(thisfield(colcounter))=""then
				thisfield(colcounter)="0"
			end if
		next
end if
'response.write thisfield(8)

sqlstr = "select top 1 sub_opt2 " &_
		"  from db_event.dbo.tbl_event_subscript where evt_code = '" & eCode & "' and userid = '" & vUserID & "' "
		'response.write sqlstr
rsget.Open sqlStr,dbget,1
	IF Not rsget.Eof Then
		myselect = rsget(0)
	end if
rsget.Close
%>
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
.thingVol019 {text-align:center; background:url(http://webimage.10x10.co.kr/playing/thing/vol019/bg_topic.png) 0 0 repeat-x;}
.thingVol019 .section {position:relative;}
.thingVol019 .inner {position:relative; width:1140px; margin:0 auto;}
.topic {height:1527px; background:url(http://webimage.10x10.co.kr/playing/thing/vol019/bg_castle.png) 50% 100% no-repeat;}
.topic .title {padding:123px 0 68px;}
.topic .title h2 {padding:43px 0 32px;}
.topic .title h2 span {position:relative; padding:0 12px;;}
.topic .title p {position:relative; }
.topic .slideWrap {background:url(http://webimage.10x10.co.kr/playing/thing/vol019/txt_special.png) 50% 106px no-repeat;}
.topic .slide {position:relative; width:940px; height:588px; margin:0 auto;}
.topic .slidesjs-pagination {position:absolute; left:0; bottom:30px; z-index:30; width:100%; height:10px;}
.topic .slidesjs-pagination li {display:inline-block; padding:0 6px;}
.topic .slidesjs-pagination li a {display:inline-block; width:10px; height:10px; background-color:#fff; border-radius:50%; text-indent:-999em;}
.topic .slidesjs-pagination li .active {background-color:#fd4f00;}
.topic .item {padding-top:50px;}
.topic .deco span {position:absolute; left:50%; width:25px; height:25px; background:url(http://webimage.10x10.co.kr/playing/thing/vol019/bg_flower.png) 0 0 no-repeat;  opacity:0; animation:spin 3s forwards;}
.topic .deco .f1 {top:438px; margin-left:-852px; animation-delay:.5s;}
.topic .deco .f2 {top:211px; margin-left:-719px;}
.topic .deco .f3 {top:288px; margin-left:-458px; animation-delay:1.4s;}
.topic .deco .f4 {top:137px; margin-left:392px;}
.topic .deco .f5 {top:390px; margin-left:652px; animation-delay:1.2s;}
.topic .deco .f6 {top:270px; margin-left:847px; animation-delay:.8s;}
.aboutHitchhiker {height:258px; background:url(http://webimage.10x10.co.kr/playing/thing/vol019/bg_hitchhiker.jpg) 50% 0 no-repeat;}
.aboutHitchhiker p {padding-top:75px;}
.aboutHitchhiker a {display:block; position:absolute; left:0; top:0; width:100%; height:258px; text-indent:-999em;}
.aboutBadge {height:802px; background:#ffb526 url(http://webimage.10x10.co.kr/playing/thing/vol019/bg_badge.jpg) 50% 0 no-repeat;}
.aboutBadge div {overflow:hidden; position:absolute; left:50%; top:175px; width:449px; height:570px;  margin-left:-490px;}
.aboutBadge a {position:absolute; left:62px; top:353px; z-index:30;}
.pickBadge {padding:90px 0 67px; background-color:#9ce1f7;}
.pickBadge ul {width:1150px; margin:0 auto; padding:52px 0 30px;}
.pickBadge ul:after {content:' '; display:block; clear:both;}
.pickBadge li {position:relative; float:left; padding:0 13px 22px;}
.pickBadge li:after {display:none;}
.pickBadge li:nth-child(6) {margin-left:102px;}
.pickBadge li label {display:block; overflow:hidden; width:204px; background-color:#9ce1f7; cursor:pointer;}
.pickBadge li input[type=radio] {position:absolute; left:0; top:0; visibility:hidden; width:0; height:0; font-size:0; line-height:0;}
.pickBadge li p {padding-top:12px; line-height:1.1; color:#1c5263; font-weight:bold;}
.pickBadge li.current label img {margin-left:-204px;}
.pickBadge li.current:after {content:''; display:inline-block; position:absolute; left:50%; top:-24px; width:41px; height:41px; margin-left:-14px; background:url(http://webimage.10x10.co.kr/playing/thing/vol019/ico_select.png) 0 0 no-repeat; animation:bounce1 .4s;}

.evtNoti {padding:35px 0; text-align:left; background-color:#e6e6e6;}
.evtNoti h3 {position:absolute; left:100px; top:50%; margin-top:-10px;}
.evtNoti ul {margin-left:270px; padding:15px 0 15px 46px; border-left:1px solid #c5c5c5;}
.evtNoti li {padding:6px 0; line-height:1.1; color:#444;}
@keyframes bounce1{
	from,to {transform:translateY(0);}
	50% {transform:translateY(5px);}
}
@keyframes spin{
	from {transform:rotate(0); margin-top:-50px; opacity:0;}
	to {transform:rotate(360deg); margin-top:0; opacity:1;}
}
</style>
<script style="text/javascript">
$(function(){
	// 뱃지 선택
	<% if myselect = "0" then %>
	$(".pickBadge li").click(function(){
		$(".pickBadge li").removeClass("current");
		$(this).addClass("current");
		$("#gubunval").val($(this).val());
	});
	<% end if %>

	$(".slide").slidesjs({
		width:"940",
		height:"588",
		navigation:false,
		pagination:{effect:'fade'},
		play:{interval:2500, effect:"fade", auto:true},
		effect:{fade: {speed:600, crossfade:true}
		}
	});

	titleAnimation();
	$(".title .letter1").css({"top":"-10px","opacity":"0"});
	$(".title .letter2").css({"top":"10px","opacity":"0"});
	$(".title .meet").css({"top":"10px","opacity":"0"});
	function titleAnimation() {
		$(".title .letter1").delay(100).animate({"top":"5px","opacity":"1"},600).animate({"top":"0"},300);
		$(".title .letter2").delay(100).animate({"top":"-5px","opacity":"1"},600).animate({"top":"0"},300);
		$(".title .meet").delay(700).animate({"top":"-5px","opacity":"1"},400).animate({"top":"0"},300);
	}

	$(".aboutBadge div").css({"left":"-490px","margin-left":"0"});
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 1700) {
			$(".aboutBadge div").delay(50).animate({"left":"50%","margin-left":"-490px"},1200);
		}
	});
});

function fnBadge() {
	var badgeval = $("#gubunval").val();
	<% If vUserID = "" Then %>
		if ("<%=IsUserLoginOK%>"=="False") {
			if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
				location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/playing/view.asp?didx="&vDIdx)%>';
				return;
			}
			return false;
		}
	<% End If %>
	<% If vUserID <> "" Then %>
	
	if(!badgeval > 0 && !badgeval < 10){
		alert('뱃지를 선택해 주세요.');
		return false;
	}
	
	var reStr;
	var str = $.ajax({
		type: "GET",
		url:"/playing/sub/doEventSubscript79254.asp",
		data: "mode=down&gubunval="+badgeval,
		dataType: "text",
		async: false
	}).responseText;
		reStr = str.split("|");
		if(reStr[0]=="OK"){
			if(reStr[1] == "dn") {
				$("#badgebtn").hide();
				$("#badgehd").show();
				alert('응모가 완료 되었습니다!');
				document.location.reload();
				return false;
			}else{
				alert('오류가 발생했습니다.');
				document.location.reload();
				return false;
			}
		}else{
			errorMsg = reStr[1].replace(">?n", "\n");
			alert(errorMsg);
			document.location.reload();
			return false;
		}
	<% End If %>
}

function fnBadgeok() {
	alert('응모 완료 되었습니다.');
	return false;
}

function fnaftalt() {
	alert('이미 응모 하셨습니다.');
	return false;
}
</script>
	<!-- Vol.019 내이름은 교토 -->
	<div class="thingVol019 imKyoto">
		<div class="section topic">
			<div class="title">
				<p><img src="http://webimage.10x10.co.kr/playing/thing/vol019/txt_collabo.png" alt="" /></p>
				<h2>
					<span class="letter1"><img src="http://webimage.10x10.co.kr/playing/thing/vol019/txt_myname.png" alt="내 이름은" /></span>
					<span class="letter2"><img src="http://webimage.10x10.co.kr/playing/thing/vol019/txt_kyoto.png" alt="KYOTO" /></span>
				</h2>
				<p class="meet"><img src="http://webimage.10x10.co.kr/playing/thing/vol019/txt_meet.png" alt="월간 THING. 뱃지가 감성 매거진 히치하이커를 만나 스페셜 뱃지가 탄생하였습니다." /></p>
			</div>
			<div class="slideWrap">
				<div class="slide">
					<div><img src="http://webimage.10x10.co.kr/playing/thing/vol019/img_slide_1.jpg" alt="" /></div>
					<div><img src="http://webimage.10x10.co.kr/playing/thing/vol019/img_slide_2.jpg" alt="" /></div>
					<div><img src="http://webimage.10x10.co.kr/playing/thing/vol019/img_slide_3.jpg" alt="" /></div>
					<div><img src="http://webimage.10x10.co.kr/playing/thing/vol019/img_slide_4.jpg" alt="" /></div>
					<div><img src="http://webimage.10x10.co.kr/playing/thing/vol019/img_slide_5.jpg" alt="" /></div>
				</div>
			</div>
			<div class="item">
				<img src="http://webimage.10x10.co.kr/playing/thing/vol019/img_item.jpg" usemap="#itemMap" alt="" />
				<map name="itemMap" id="itemMap">
					<area shape="rect" coords="1,1,232,389" href="/shopping/category_prd.asp?itemid=1750843" onfocus="this.blur();" alt="히치하이커 + PLAYing 뱃지 KYOTO SET" />
					<area shape="rect" coords="349,1,581,389" href="/shopping/category_prd.asp?itemid=1745808" onfocus="this.blur();" alt="PLAYing THING. 스페셜 뱃지 KYOTO" />
					<area shape="rect" coords="698,1,929,389" href="/shopping/category_prd.asp?itemid=1732642" onfocus="this.blur();" alt="10X10 히치하이커 vol.64 KYOTO" />
				</map>
			</div>
			<div class="deco">
				<span class="f1"></span><span class="f2"></span><span class="f3"></span><span class="f4"></span><span class="f5"></span><span class="f6"></span>
			</div>
		</div>
		<div class="section aboutHitchhiker">
			<div class="inner">
				<p><img src="http://webimage.10x10.co.kr/playing/thing/vol019/txt_hitchhiker.png" alt="히치하이커는 격월간으로 발행되는 텐바이텐의 감성 매거진입니다. 매 호 다른 주제로 우리 주변의 평범한 이야기와 일상의 풍경을 담아냅니다. 히치하이커가 당신에게 소소한 즐거움, 작은 위로가 될 수 있길 바랍니다." /></p>
				<% if date() < "2017-08-01" then %>
					<a href="/event/eventmain.asp?eventid=79038">히치하이커 이벤트 바로가기</a>
				<% else %>
					 <a href="/street/street_brand_sub06.asp?makerid=hitchhiker">히치하이커 바로가기</a>
				<% end if %>
			</div>
		</div>
		<div class="section aboutBadge">
			<div>
				<p><img src="http://webimage.10x10.co.kr/playing/thing/vol019/txt_badge_v2.png" alt="THING 뱃지는 텐바이텐이 디자인한 뱃지에 고객님이 지어주신 이름으로 매월 한정수량 출시됩니다. 이름 지어주기 이벤트는 텐바이텐의 다양한 콘텐츠를 만날 수 있는 코너 PLAYing에서 매달 참여할 수 있습니다." /></p>
				<a href="/street/street_brand_sub06.asp?makerid=1010play"><img src="http://webimage.10x10.co.kr/playing/thing/vol019/btn_buy_badge.png" alt="THING 뱃지 구매하러가기" /></a>
			</div>
		</div>
		<!-- 뱃지 선택 -->
		<div class="section pickBadge">
			<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol019/txt_event.png" alt="출시된 THING. 뱃지 중 어떤 뱃지가 가장 마음에 들었나요? 뱃지를 선택해주신 분 중 30분께 교토 뱃지와 히치하이커 교토편이 들어있는 [KYOTO SET]를 드립니다." /></h3>
			<ul>
				<li value="1" <%=chkIIF(myselect="1","class='current'","")%> <%=chkIIF(myselect<>"0"," onclick='fnaftalt(); return false;'","")%>  >
					<input type="radio" id="badge1" name="badge" />
					<label for="badge1"><img src="http://webimage.10x10.co.kr/playing/thing/vol019/img_badge_1.jpg" alt="11월 뱃지 포구미" /></label>
					<p><%= thisfield(0) %>명의 PICK♡</p>
				</li>
				<li value="2" <%=chkIIF(myselect="2","class='current'","")%> <%=chkIIF(myselect<>"0"," onclick='fnaftalt(); return false;'","")%> >
					<input type="radio" id="badge2" name="badge" />
					<label for="badge2"><img src="http://webimage.10x10.co.kr/playing/thing/vol019/img_badge_2.jpg" alt="12월 뱃지 말양말양" /></label>
					<p><%= thisfield(1) %>명의 PICK♡</p>
				</li>
				<li value="3" <%=chkIIF(myselect="3","class='current'","")%> <%=chkIIF(myselect<>"0"," onclick='fnaftalt(); return false;'","")%> >
					<input type="radio" id="badge3" name="badge" />
					<label for="badge3"><img src="http://webimage.10x10.co.kr/playing/thing/vol019/img_badge_3.jpg" alt="1월 뱃지 둥근해가떠썬" /></label>
					<p><%= thisfield(2) %>명의 PICK♡</p>
				</li>
				<li value="4" <%=chkIIF(myselect="4","class='current'","")%> <%=chkIIF(myselect<>"0"," onclick='fnaftalt(); return false;'","")%> >
					<input type="radio" id="badge4" name="badge" />
					<label for="badge4"><img src="http://webimage.10x10.co.kr/playing/thing/vol019/img_badge_4.jpg" alt="2월 뱃지 띵띵빵빵" /></label>
					<p><%= thisfield(3) %>명의 PICK♡</p>
				</li>
				<li value="5" <%=chkIIF(myselect="5","class='current'","")%> <%=chkIIF(myselect<>"0"," onclick='fnaftalt(); return false;'","")%> >
					<input type="radio" id="badge5" name="badge" />
					<label for="badge5"><img src="http://webimage.10x10.co.kr/playing/thing/vol019/img_badge_5.jpg" alt="3월 뱃지 봄달새" /></label>
					<p><%= thisfield(4) %>명의 PICK♡</p>
				</li>
				<li value="6" <%=chkIIF(myselect="6","class='current'","")%> <%=chkIIF(myselect<>"0"," onclick='fnaftalt(); return false;'","")%> >
					<input type="radio" id="badge6" name="badge" />
					<label for="badge6"><img src="http://webimage.10x10.co.kr/playing/thing/vol019/img_badge_6.jpg" alt="4월 뱃지 봄빨간화분이" /></label>
					<p><%= thisfield(5) %>명의 PICK♡</p>
				</li>
				<li value="7" <%=chkIIF(myselect="7","class='current'","")%> <%=chkIIF(myselect<>"0"," onclick='fnaftalt(); return false;'","")%> >
					<input type="radio" id="badge7" name="badge" />
					<label for="badge7"><img src="http://webimage.10x10.co.kr/playing/thing/vol019/img_badge_7.jpg" alt="5월 뱃지 달릴레옹" /></label>
					<p><%= thisfield(6) %>명의 PICK♡</p>
				</li>
				<li value="8" <%=chkIIF(myselect="8","class='current'","")%> <%=chkIIF(myselect<>"0"," onclick='fnaftalt(); return false;'","")%> >
					<input type="radio" id="badge8" name="badge" />
					<label for="badge8"><img src="http://webimage.10x10.co.kr/playing/thing/vol019/img_badge_8.jpg" alt="6월 뱃지 행보캡" /></label>
					<p><%= thisfield(7) %>명의 PICK♡</p>
				</li>
				<li value="9" <%=chkIIF(myselect="9","class='current'","")%> <%=chkIIF(myselect<>"0"," onclick='fnaftalt(); return false;'","")%> >
					<input type="radio" id="badge9" name="badge" />
					<label for="badge9"><img src="http://webimage.10x10.co.kr/playing/thing/vol019/img_badge_9.jpg" alt="7월 뱃지 날아갈꺼에어" /></label>
					<p><%= thisfield(8) %>명의 PICK♡</p>
				</li>
			</ul>

			<% if myevt > 0 and myevt <> 99999 then %>
				<p id="badgeok"><img src="http://webimage.10x10.co.kr/playing/thing/vol019/txt_finish.png" alt="응모완료" /></p>
			<% else %>
				<button type="button" onclick="fnBadge(); return false;" id="badgebtn" ><img src="http://webimage.10x10.co.kr/playing/thing/vol019/btn_submit.png" alt="응모하기" /></button>
			<% end if %>
			<p id="badgehd" style="display:none" ><img src="http://webimage.10x10.co.kr/playing/thing/vol019/txt_finish.png" alt="응모완료" /></p>
			<%' 당첨자발표 했다고 요청오면 응모버튼 없애고 이거 띄움 <p><img src="http://webimage.10x10.co.kr/playing/thing/vol019/txt_end.png" alt="당첨자가 발표되었습니다. 감사합니다" /></p> %>
			<input type="hidden" id="gubunval" name="gubunval">
		</div>
		<!--// 뱃지 선택 -->
		<div class="evtNoti">
			<div class="inner">
				<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol019/tit_noti.png" alt="이벤트 유의사항" /></h3>
				<ul>
					<li>- 본 이벤트는 한 ID 당 1회 응모할 수 있습니다.</li>
					<li>- 당첨자 발표는 8월 2일 사이트에 공지될 예정이며, 메일과 문자로 당첨안내 될 예정입니다.</li>
					<li>- 사은품은 회원 정보상의 기본주소로 사은품이 배송됩니다. MY10X10에서 개인정보를 업데이트해주세요.</li>
				</ul>
			</div>
		</div>
	</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->
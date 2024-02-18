<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 설문조사
' History : 2017-08-17 정태훈 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/event/etc/dysonCls.asp" -->
<%
dim eCode, userid, currenttime, page, i, DayCount
IF application("Svr_Info") = "Dev" THEN
	eCode = "66413"
Else
	eCode = "79832"
End If

page=requestcheckvar(request("page"),5)
If page="" Then  page=1
currenttime = now()
userid = GetEncLoginUserID()

dim subscriptcountend
subscriptcountend=0

'//본인 참여 여부
if userid<>"" then
	subscriptcountend = getevent_subscriptexistscount(eCode, userid, "", "2", "")
end If

Dim cEvtFan
Set cEvtFan = New CDyson
cEvtFan.FECode = eCode	'이벤트 코드
cEvtFan.FRectUserID = userid
cEvtFan.GetDysonCount
DayCount=cEvtFan.FTotalCount
Set cEvtFan = Nothing
%>
<style type="text/css">
.evt79832 {position:relative;}
.evt79832 .header {position:relative; width:1140px; height:827px; border:0; background:url(http://webimage.10x10.co.kr/eventIMG/2017/79832/img_main_v2.jpg) 50% 0 no-repeat;}
.evt79832 .header h2 {position:absolute; left:850px; top:126px;}
.evt79832 .header span {position:absolute; left:254px; top:212px; animation:bounce 1.5s 30;}
.evt79832 .header a {overflow:hidden; display:block; position:absolute; left:254px; top:80px; width:330px; height:600px; z-index:10; text-indent:-999em;}
.evt79832 .mine {position:relative; height:302px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/79832/txt_mine_v3.png) no-repeat 50% 0;}
.evt79832 .mine p {position:absolute; left:641px; top:55px; font-size:27px; color:#ffd32a;}
.evt79832 .mine ul {overflow:hidden; position:absolute; left:50%; top:127px; width:938px; height:110px; margin-left:-469px;}
.evt79832 .mine ul li {overflow:hidden; float:left; width:110px; height:110px; margin:0 12px; text-indent:-999em;}
.evt79832 .mine ul li.entry {background:url(http://webimage.10x10.co.kr/eventIMG/2017/79832/img_sticker_v2.png) no-repeat 0 0;}
.evt79832 .mine ul li + li.entry {background-position:-134px 0;}
.evt79832 .mine ul li + li + li.entry {background-position:-268px 0;}
.evt79832 .mine ul li + li + li + li.entry {background-position:-402px 0;}
.evt79832 .mine ul li + li + li + li + li.entry {background-position:-536px 0;}
.evt79832 .mine ul li + li + li + li + li + li.entry {background-position:-670px 0;}
.evt79832 .mine ul li + li + li + li + li + li + li.entry {background-position:-804px 0;}
.evt79832 .evtNoti {position:relative; padding:78px 0; text-align:left; background-color:#12185e;}
.evt79832 .evtNoti h3 {position:absolute; left:140px; top:50%; margin-top:-13px;}
.evt79832 .evtNoti ul {overflow:hidden; padding-left:420px;}
.evt79832 .evtNoti li {padding-bottom:3px; color:#fff; font-family:dotum, '돋움', sans-serif;}
@keyframes bounce {
	from to {transform:translateY(0);}
	50% {transform:translateY(-20px);}
}
</style>
<script>
function chkevt(){
	<% If not(IsUserLoginOK()) Then %>
		if(confirm("로그인을 해주세요.")){
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
		}
	<% else %>
	jsEventSubmit();
	<% End IF %>
}

function jsEventSubmit(){
	<% If IsUserLoginOK() Then %>
		<% If now() > #08/27/2017 23:59:59# then %>
			alert("이벤트 기간이 아닙니다.");
			return false;
		<% else %>
			var str = $.ajax({
				type: "POST",
				url: "/event/etc/doEventSubscript79832.asp",
				data: $("#frm").serialize(),
				dataType: "text",
				async: false
			}).responseText;
			var str1 = str.split("||")
			console.log(str);
			if (str1[0] == "01"){
				alert(str1[1]);
				return false;
			}else if (str1[0] == "02"){
				alert(str1[1]);
				return false;
			}else if (str1[0] == "03"){
				alert(str1[1]);
				return false;
			}else if (str1[0] == "05"){
				alert(str1[1]);
				location.reload();
				return false;
			}else{
				alert('오류가 발생했습니다.');
				return false;
			}
		<% end if %>
	<% Else %>
		if(confirm("로그인을 해주세요.")){
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
		}
		return false;
	<% End IF %>
}
</script>
						<div class="evt79832">
							<div class="header">
								<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/79832/tit_dyson.png" alt="多다이슨" /></h2>
								<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/79832/txt_balloon.png" alt="多다이슨 - 많이 응모할수록 다이슨에 가까워진다" /></span>
								<a href="/shopping/category_prd.asp?itemid=1750502&pEtr=79832">다이슨V8 앱솔루트 플러스</a>
							</div>
							<div>
								<img src="http://webimage.10x10.co.kr/eventIMG/2017/79832/txt_push_v2.png" alt="하루에 한 번씩 응모하고 다이슨 청소기 득템하세요" usemap="#entryMap" />
								<map name="entryMap">
									<area shape="rect" coords="379,244,760,333" href="javascript:chkevt();" alt="응모하기" />
								</map>
							</div>
							<div class="mine">
								<p><%=DayCount%></p>
								<ul>
									<li class="<% If DayCount > 0 Then Response.write "entry" %>">1Day</li>
									<li class="<% If DayCount > 1 Then Response.write "entry" %>">2Day</li>
									<li class="<% If DayCount > 2 Then Response.write "entry" %>">3Day</li>
									<li class="<% If DayCount > 3 Then Response.write "entry" %>">4Day</li>
									<li class="<% If DayCount > 4 Then Response.write "entry" %>">5Day</li>
									<li class="<% If DayCount > 5 Then Response.write "entry" %>">6Day</li>
									<li class="<% If DayCount > 6 Then Response.write "entry" %>">7Day</li>
								</ul>
							</div>
							<div class="evtNoti">
								<div class="inner">
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/79832/txt_notice.png" alt="이벤트 유의사항 " /></h3>
									<ul>
										<li>- 본 이벤트는 하루에 한 번씩 응모하실 수 있습니다.</li>
										<li>- 응모 횟수가 많을수록 당첨 확률도 높아집니다.</li>
										<li>- 당첨자 발표는 8월 28일(월) 사이트 공지사항에 게시될 예정입니다.</li>
										<li>- 제세공과금은 텐바이텐 부담이며, 세무신고를 위해 개인정보를 취합한 뒤에 경품이 증정됩니다.</li>
									</ul>
								</div>
							</div>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->
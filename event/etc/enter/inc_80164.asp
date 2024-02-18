<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 천고마비
' History : 2017.08.30 정태훈
'###########################################################
%>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim eCode, vUserID, nowdate, sqlstr
dim evtsubscriptcnt, totalevtsubscriptcnt, entercnt22, entercnt55, entercnt77

IF application("Svr_Info") = "Dev" THEN
	eCode = "66421"
Else
	eCode = "80164"
End If

nowdate = date()
												nowdate = "2017-09-10"

vUserID = getEncLoginUserID
evtsubscriptcnt = 0
totalevtsubscriptcnt = 0
entercnt22 = 0
entercnt55 = 0
entercnt77 = 0

if vUserID <> "" then
	sqlstr = ""
	sqlstr = "select count(*) as cnt"
	sqlstr = sqlstr & " from [db_event].[dbo].[tbl_event_subscript] sc"
	sqlstr = sqlstr & " where sc.evt_code="& eCode &""
	sqlstr = sqlstr & " and  convert(varchar(10),sc.regdate,21)='"& nowdate &"'  and sc.userid='"& vUserID &"' and sc.sub_opt2<>77 and sc.sub_opt2<>55 and sc.sub_opt2<>22  "	'

	'response.write sqlstr & "<Br>"
	rsget.Open sqlstr,dbget
	IF not rsget.EOF THEN
		evtsubscriptcnt = rsget("cnt")	'오늘 했는지 카운트
	END IF
	rsget.close

	sqlstr = ""
	sqlstr = "select count(*) as cnt"
	sqlstr = sqlstr & " from [db_event].[dbo].[tbl_event_subscript] sc"
	sqlstr = sqlstr & " where sc.evt_code="& eCode &""
	sqlstr = sqlstr & " and  sc.userid='"& vUserID &"' and sc.sub_opt2<>77 and sc.sub_opt2<>55 and sc.sub_opt2<>22 "	'

	'response.write sqlstr & "<Br>"
	rsget.Open sqlstr,dbget
	IF not rsget.EOF THEN
		totalevtsubscriptcnt = rsget("cnt")	'총 몇번 했는지 카운트
	END IF
	rsget.close

	sqlstr = ""
	sqlstr = "select top 3 sc.sub_opt2 "
	sqlstr = sqlstr & " from [db_event].[dbo].[tbl_event_subscript] sc"
	sqlstr = sqlstr & " where sc.evt_code="& eCode &""
	sqlstr = sqlstr & " and  sc.userid='"& vUserID &"' and (sc.sub_opt2=22 or sc.sub_opt2=55 or sc.sub_opt2=77) "
	sqlstr = sqlstr & " order by sub_opt2 asc "

'	response.write sqlstr & "<Br>"
	rsget.Open sqlstr,dbget

	dim arrList, i
	IF not rsget.EOF THEN
		arrList = rsget.getRows()
'		entercnt22 = rsget(0)'4일 응모했는지
'		entercnt77 = rsget(1)'7일 응모했는지								
	END IF
	rsget.close

	if isarray(arrList)=TRUE then
		For i=0 to ubound(arrList,2)
			if i = 0 then
				entercnt22 = arrList(0,i)'4일 응모했는지
			end If
			if i = 1 then
				entercnt55 = arrList(0,i)'4일 응모했는지
			end if
			if i = 2 then
				entercnt77 = arrList(0,i)'7일 응모했는지								
			end if
		Next
	end if

end if
%>
<style>
.evt80164 {position:relative;}
.evt80164 .attendance {height:672px; background:#fad57e url(http://webimage.10x10.co.kr/eventIMG/2017/80164/bg_brown.jpg)no-repeat;}
.evt80164 .attendance .horse {position:relative; padding-top:11px;}
.evt80164 .attendance .head {position:relative; z-index:30;}
.evt80164 .attendance .body {display:block; position:relative; z-index:10; margin-top:-99px; right:1px;}
.evt80164 .attendance .body span.click {position:absolute; bottom:103px; left:50%; z-index:20; margin-left:-32px; animation:blink .8s 20;}
.evt80164 .attendance .finish.horse {display:block; position:relative; padding-top:45px;}
.evt80164 .attendance .finish .tmr {position:absolute; top:54px; left:50%; margin-left:160px;}
.evt80164 .myNum {position:relative; height:311px; padding-top:50px; background:#f7ab1d url(http://webimage.10x10.co.kr/eventIMG/2017/80164/bg_gift.jpg)no-repeat;}
.evt80164 .myNum .day {position:absolute; top:7px; left:50%; margin-left:60px; font-size:25px; color:#ffef68;}
.evt80164 .myNum ul {overflow:hidden; width:990px; margin:0 auto;}
.evt80164 .myNum ul li {position:relative; float:left; width:320px; height:186px; padding-top:45px;}
.evt80164 .myNum ul li > img {position:absolute; top:45; right:27px;}
.evt80164 .myNum ul li button {position:absolute; width:120px; height:41px; top:130px; left:30px; background-color:transparent;}
.evtNoti {position:relative; padding:55px 0 55px 338px; text-align:left; background:#493c27 url(http://webimage.10x10.co.kr/eventIMG/2017/80164/bg_dark_borwn.jpg) repeat-x;}
.evtNoti h3 {position:absolute; left:123px; top:50%; margin-top:-40px;}
.evtNoti ul {position:relative; padding-left:80px; }
.evtNoti ul:before {display:inline-block; content:' '; position:absolute; top:17px; left:0; width:1px; height:91px; background-color:#7d7768;}
.evtNoti li {padding:3px 0; color:#fff;}
@keyframes blink {
	from to {opacity:1}
	50% {opacity:0;}
}
</style>
<script type="text/javascript">
function fnsubmit(mde,nb) {
	<% If vUserID = "" Then %>
		if(confirm("로그인 후 신청할 수 있습니다.")){
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
		}
	<% End If %>
	<% If vUserID <> "" Then %>
		<% if nowdate >= "2017-09-04" and nowdate <= "2017-09-10" then %>
			var reStr;
			var str = $.ajax({
				type: "GET",
				url:"/event/etc/enter/doeventsubscript/doEventSubscript80164.asp",
				data: "mode="+mde+"&nb="+nb,
				dataType: "text",
				async: false
			}).responseText;
				reStr = str.split("|");
				var ccdaycnt = reStr[2];
				if(reStr[0]=="OK"){
					if(reStr[1] == "dn") {
						$("#ccday").empty().html(ccdaycnt);
						$("#ccbt").hide();
						if(ccdaycnt == 2) {
							$("#2daybfbt").hide();
							$("#2dayafbt1").show();
						}else if(ccdaycnt == 5) {
							$("#5daybfbt").hide();
							$("#5dayafbt1").show();
						}else if(ccdaycnt == 7){
							$("#7daybfbt").hide();
							$("#7dayafbt1").show();
						}
						$("#etimgdv").show();
						$("#etimgdv2").hide();
						//$("#etimg").attr("src", "http://webimage.10x10.co.kr/eventIMG/2017/76770/img_lunchbox_0"+ccdaycnt+".jpg");
						alert('이벤트 참여가 완료되었습니다!');
					}else if(reStr[1] == "et"){
						if(reStr[2] == 22) {
							$("#2daybfbt1").hide();
							$("#2daybfbt2").hide();
							$("#2dayafbt3").show();
						}else if(reStr[2] == 55){
							$("#5daybfbt1").hide();
							$("#5daybfbt2").hide();
							$("#5dayafbt3").show();
						}else if(reStr[2] == 77){
							$("#7daybfbt1").hide();
							$("#7daybfbt2").hide();
							$("#7dayafbt3").show();
						}

						alert('신청이 완료되었습니다!');
						return false;
					}else{
						alert('오류가 발생했습니다.');
						return false;
					}
				}else{
					errorMsg = reStr[1].replace(">?n", "\n");
					alert(errorMsg);
					document.location.reload();
					return false;
				}
		<% else %>
			alert("이벤트 기간이 아닙니다.");
		<% End If %>
	<% End If %>
}
</script>
						<div class="evt80164">
							<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/80164/tit_horse.jpg" alt="천고마비 가을맞이 살이 찌고 있는 말을 매일 한 번씩 운동시켜주세요! 참여 횟수에 따라 다양한 혜택을 드립니다 이벤트 기간 : 09.04 ~ 09.10/당첨자 발표 : 09.13 (수)" /></h2>
							<div class="attendance">
							<% if now() < #09/10/2017 23:59:59#  then %>
								<% if evtsubscriptcnt < 1 then %>
								<div class="horse" id="etimgdv2">
									<div class="head"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80164/img_head.gif" alt="" /></div>
									<a class="btnClick body" href="javascript:fnsubmit('clk','');">
										<img src="http://webimage.10x10.co.kr/eventIMG/2017/80164/img_body.png" alt="" />
										<span class="click" id="ccbt"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80164/txt_click.png" alt="클릭" /></span>
									</a>
								</div>
								<div class="horse finish" style="display:none" id="etimgdv">
									<img src="http://webimage.10x10.co.kr/eventIMG/2017/80164/img_horse_v2.gif" alt="오늘의 운동을 마쳤습니다." />
									<% if now() < #09/09/2017 23:59:59#  then %><p class="tmr"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80164/txt_tomorrow.png" alt="내일 또 운동 시켜주세요!" /></p><% end if %>
								</div>
								<% Else %>
								<div class="horse finish" id="etimgdv">
									<img src="http://webimage.10x10.co.kr/eventIMG/2017/80164/img_horse_v2.gif" alt="오늘의 운동을 마쳤습니다." />
									<% if now() < #09/09/2017 23:59:59#  then %><p class="tmr"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80164/txt_tomorrow.png" alt="내일 또 운동 시켜주세요!" /></p><% end if %>
								</div>
								<% end if %>
							<% end if %>
							</div>
							<div class="myNum">
								<span class="day" id="ccday"><%=totalevtsubscriptcnt%></span>
								<ul>
									<li class="day2">
										<img src="http://webimage.10x10.co.kr/eventIMG/2017/80164/txt_gift1.png" alt="2일차-200마일리지" />
										<% If totalevtsubscriptcnt < 2 Then %>
										<button type="button" class="btnWait" id="2daybfbt"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80164/txt_cant_submit.png" alt="신청하기" /></button>
										<button type="button" class="btnApply" id="2dayafbt1" onClick="fnsubmit('et','f'); return false;" style="display:none;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80164/txt_submit.png" alt="신청하기" /></button>
										<button type="button" class="btnFinish" id="2dayafbt3" style="display:none;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80164/txt_comp.png" alt="신청완료" /></button>
										<% ElseIf totalevtsubscriptcnt >= 2 And entercnt22 <> 22 Then %>
										<button type="button" class="btnApply" id="2dayafbt2" onClick="fnsubmit('et','f'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80164/txt_submit.png" alt="신청하기" /></button>
										<button type="button" class="btnFinish" id="2dayafbt3" style="display:none;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80164/txt_comp.png" alt="신청완료" /></button>
										<% elseif totalevtsubscriptcnt >= 2 and entercnt22 = 22 then %>
										<button type="button" class="btnFinish" id="2dayafbt3"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80164/txt_comp.png" alt="신청완료" /></button>
										<% End If %>
										
									</li>
									<li class="day5">
										<img src="http://webimage.10x10.co.kr/eventIMG/2017/80164/txt_gift2.png" alt="5일차 500마일리지" />
										<% If totalevtsubscriptcnt < 5 Then %>
										<button type="button" class="btnWait" id="5daybfbt"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80164/txt_cant_submit.png" alt="신청하기" /></button>
										<button type="button" class="btnApply" id="5dayafbt1" onclick="fnsubmit('et','s'); return false;" style="display:none;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80164/txt_submit.png" alt="신청하기" /></button>
										<button type="button" class="btnFinish" id="5dayafbt3" style="display:none;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80164/txt_comp.png" alt="신청완료" /></button>
										<% elseif totalevtsubscriptcnt >= 5 and entercnt55 <> 55 then %>
										<button type="button" class="btnApply" id="5dayafbt2" onclick="fnsubmit('et','s'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80164/txt_submit.png" alt="신청하기" /></button>
										<button type="button" class="btnFinish" id="5dayafbt3" style="display:none;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80164/txt_comp.png" alt="신청완료" /></button>
										<% elseif totalevtsubscriptcnt >= 5 and entercnt55 = 55 then %>
										<button type="button" class="btnFinish" id="5dayafbt3"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80164/txt_comp.png" alt="신청완료" /></button>
										<% End If %>
										
									</li>
									<li class="day7">
										<img src="http://webimage.10x10.co.kr/eventIMG/2017/80164/txt_gift3.png" style="display:inline-block; margin:-15px 0 0 52px;position:static;" alt="7일차 선물 증정" />
										<% If totalevtsubscriptcnt < 7 Then %>
										<button type="button" class="btnWait" id="7daybfbt"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80164/txt_cant_submit.png" alt="신청하기" /></button>
										<button type="button" class="btnApply" id="7dayafbt1" onclick="fnsubmit('et','t'); return false;" style="display:none;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80164/txt_submit.png" alt="신청하기" /></button>
										<button type="button" class="btnFinish" id="7dayafbt3" style="display:none;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80164/txt_comp.png" alt="신청완료" /></button>
										<% elseif totalevtsubscriptcnt >= 7 and entercnt77 <> 77 then %>
										<button type="button" class="btnApply" id="7dayafbt1" onclick="fnsubmit('et','t'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80164/txt_submit.png" alt="신청하기" /></button>
										<button type="button" class="btnFinish" id="7dayafbt3" style="display:none;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80164/txt_comp.png" alt="신청완료" /></button>
										<% elseif totalevtsubscriptcnt >= 7 and entercnt77 = 77 then %>
										<button type="button" class="btnFinish" id="7dayafbt3"><img src="http://webimage.10x10.co.kr/eventIMG/2017/80164/txt_comp.png" alt="신청완료" /></button>
										<% End If %>
									</li>
								</ul>
							</div>
							<div class="evtNoti">
								<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/80164/tit_noti.png" alt="이벤트 유의사항" /></h3>
								<ul>
									<li>- 하루에 한 번씩만 참여하실 수 있습니다. </li>
									<li>- 참여한 횟수에 따라서 각 경품을 신청하실 수 있습니다.</li>
									<li>- 이벤트 기간이 지난 뒤에는 신청 및 응모하실 수 없습니다.</li>
									<li>- 마일리지 지급과 경품 당첨자 발표는 2017년 9월 13일(수)에 일괄 진행됩니다.</li>
									<li>- 마사지볼의 제세공과금은 텐바이텐 부담이며, 세무신고를 위해 개인정보를 취합한 뒤에 경품이 증정됩니다.</li>
								</ul>
							</div>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->
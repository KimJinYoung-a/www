<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 매일매일 마일리지
' History : 2016.12.29 유태욱
'###########################################################
%>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim eCode, vUserID, nowdate
dim evtsubscriptcnt1, evtsubscriptcnt2, evtsubscriptcnt3, evtsubscriptcnt4, evtsubscriptcnt5, evtsubscriptcnt6

IF application("Svr_Info") = "Dev" THEN
	eCode = "66257"
Else
	eCode = "75305"
End If

nowdate = date()
'nowdate = "2017-01-01"

vUserID = getEncLoginUserID
evtsubscriptcnt1 = 0
evtsubscriptcnt2 = 0
evtsubscriptcnt3 = 0
evtsubscriptcnt4 = 0
evtsubscriptcnt5 = 0
evtsubscriptcnt6 = 0

if vUserID <> "" then
	evtsubscriptcnt1 = getevent_subscriptexistscount(eCode, vUserID, "1","","")
	evtsubscriptcnt2 = getevent_subscriptexistscount(eCode, vUserID, "2","","")
	evtsubscriptcnt3 = getevent_subscriptexistscount(eCode, vUserID, "3","","")
	evtsubscriptcnt4 = getevent_subscriptexistscount(eCode, vUserID, "4","","")
	evtsubscriptcnt5 = getevent_subscriptexistscount(eCode, vUserID, "5","","")
	evtsubscriptcnt6 = getevent_subscriptexistscount(eCode, vUserID, "6","","")
end if
%>
<style>
button {background:transparent;}
.evt75305 {position:relative;}
.calendar {padding-bottom:68px; background:#fdf080;}
.calendar dl {width:781px; margin:0 auto; text-align:left;}
.calendar dd {height:420px; padding:0 4px 0 3px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/75305/bg_box.png) 0 100% no-repeat;}
.calendar ul:after {content:''; display:block; clear:both;}
.calendar li {position:relative; float:left; width:257px; height:207px; background:#fff; border-top:1px solid #dbdbdb; border-right:1px solid #dbdbdb;}
.calendar li.day03,
.calendar li.day06 {width:258px; border-right:0;}
.calendar li.day04 {border-radius:0 0 0 7px;}
.calendar li.day06 {border-radius:0 0 7px 0;}
.calendar li .date {display:inline-block; padding:20px 0 23px 27px;}
.calendar li .mileage {width:125px; height:48px; margin:0 auto; background-position:50% -50px; background-repeat:no-repeat; text-indent:-999em;}
.calendar li .m50 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/75305/txt_50.png)}
.calendar li .m100 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/75305/txt_100.png)}
.calendar li .m200 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/75305/txt_200.png)}
.calendar .finish {background:#e9e9e9;}
.calendar .finish .mileage {background-position:50% 0;}
.calendar .btnGroup button {position:absolute; left:50%; bottom:21px; z-index:40; margin-left:-61px;}
.calendar .btnGroup .btnApply {display:block;}
.calendar .btnGroup .btnToday {display:none;}
.calendar .btnGroup .btnFinish {display:none;}
.calendar .current .btnGroup .btnToday {display:block; -webkit-animation:bounce1 50 1s;}
.calendar .current .frame {display:inline-block; position:absolute; left:0; bottom:0; width:259px; height:225px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/75305/btn_today.png) 0 0 no-repeat;}
.calendar .current .btnGroup .btnApply {display:none;}
.calendar .finish .btnGroup .btnFinish {display:block;}
.calendar .finish .btnGroup .btnApply {display:none;}
.evtNoti {position:relative; padding:40px 90px 40px 258px; background:#f2f2f2;}
.evtNoti h3 {position:absolute; left:90px; top:50%; margin-top:-34px;}
.evtNoti ul {padding:10px 0 0 50px; border-left:1px solid #dfdfdf;}
.evtNoti li {padding-bottom:10px; font-size:12px; line-height:13px; color:#696969; text-align:left;}
.deco div {position:absolute;}
.deco .d01 {left:746px; top:403px;}
.deco .d02 {left:210px; top:930px;}
.deco .d03 {right:118px; top:840px;}
@-webkit-keyframes bounce1 {
	from, to{margin-bottom:0; animation-timing-function:ease-in;}
	50% {margin-bottom:-5px; animation-timing-function:ease-out;}
}
</style>
<script type="text/javascript">
function fnsubmit() {
	<% If vUserID = "" Then %>
		if(confirm("로그인 후 신청할 수 있습니다.")){
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
		}
		return false;
	<% End If %>
	<% If vUserID <> "" Then %>
		<% if nowdate >= "2017-01-01" and nowdate <= "2017-01-06" then %>
			var reStr;
			var str = $.ajax({
				type: "GET",
				url:"/event/etc/doeventsubscript/doEventSubscript75305.asp",
				data: "mode=down",
				dataType: "text",
				async: false
			}).responseText;
				reStr = str.split("|");
				if(reStr[0]=="OK"){
					if(reStr[1] == "dn") {
						alert('신청이 완료 되었습니다!');
						document.location.reload();
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
			return false;
		<% End If %>
	<% End If %>
}
</script>
	<!-- 매일매일 마일리지 -->
	<div class="evt75305">
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/tit_everyday_mileage.png" alt="매일매일 마일리지" /></h2>
		<div class="calendar">
			<dl>
				<dt><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/txt_january.png" alt="1월" /></dt>
				<dd>
					<ul>
						<%'' for dev msg : 지난날짜 finish, 오늘 current 클래스 붙여주세요 %>
						<%'' 1일 %>
						<li class="day01 <% if nowdate > "2017-01-01" or evtsubscriptcnt1 > 0 then %> finish <% elseif nowdate = "2017-01-01" then %> current<% end if %>">
							<span class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/txt_day_01.png" alt="1일" /></span>
							<div class="mileage m50">50마일리지 받는 날!</div>
							<div class="btnGroup">
								<% if evtsubscriptcnt1 = 0 then %>
									<% if nowdate = "2017-01-01" then %>
										<button type="button" class="btnApply"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/btn_apply.png" alt="신청하기" /></button>
										<button type="button" onclick="fnsubmit(); return false;" class="btnToday"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/btn_apply_02.png" alt="신청하기" /></button>
									<% else %>
										<button type="button" onclick="return false;" class="btnApply"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/btn_apply.png" alt="신청하기" /></button>
										<button type="button" onclick="return false;" class="btnToday"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/btn_apply_02.png" alt="신청하기" /></button>
									<% end if %>
								<% else %>
									<button type="button" class="btnFinish"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/btn_finish.png" alt="신청완료" /></button>
								<% end if %>
							</div>
							<div class="frame"></div>
						</li>

						<%'' 2일 %>
						<li class="day02 <% if nowdate > "2017-01-02" or evtsubscriptcnt2 > 0 then %> finish <% elseif nowdate = "2017-01-02" then %> current<% end if %>">
							<span class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/txt_day_02.png" alt="2일" /></span>
							<div class="mileage m100">100마일리지 받는 날!</div>
							<div class="btnGroup">
								<% if evtsubscriptcnt2 = 0 then %>
									<% if nowdate = "2017-01-02" then %>
										<button type="button" class="btnApply"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/btn_apply.png" alt="신청하기" /></button>
										<button type="button" onclick="fnsubmit(); return false;" class="btnToday"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/btn_apply_02.png" alt="신청하기" /></button>
									<% else %>
										<button type="button" onclick="return false;" class="btnApply"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/btn_apply.png" alt="신청하기" /></button>
										<button type="button" onclick="return false;" class="btnToday"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/btn_apply_02.png" alt="신청하기" /></button>
									<% end if %>
								<% else %>
									<button type="button" class="btnFinish"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/btn_finish.png" alt="신청완료" /></button>
								<% end if %>
							</div>
							<div class="frame"></div>
						</li>

						<%'' 3일 %>
						<li class="day03 <% if nowdate > "2017-01-03" or evtsubscriptcnt3 > 0 then %> finish <% elseif nowdate = "2017-01-03" then %> current<% end if %>">
							<span class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/txt_day_03.png" alt="3일" /></span>
							<div class="mileage m200">200마일리지 받는 날!</div>
							<div class="btnGroup">
								<% if evtsubscriptcnt3 = 0 then %>
									<% if nowdate = "2017-01-03" then %>
										<button type="button" class="btnApply"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/btn_apply.png" alt="신청하기" /></button>
										<button type="button" onclick="fnsubmit(); return false;" class="btnToday"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/btn_apply_02.png" alt="신청하기" /></button>
									<% else %>
										<button type="button" onclick="return false;" class="btnApply"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/btn_apply.png" alt="신청하기" /></button>
										<button type="button" onclick="return false;" class="btnToday"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/btn_apply_02.png" alt="신청하기" /></button>
									<% end if %>
								<% else %>
									<button type="button" class="btnFinish"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/btn_finish.png" alt="신청완료" /></button>
								<% end if %>
							</div>
							<div class="frame"></div>
						</li>

						<%'' 4일 %>
						<li class="day04 <% if nowdate > "2017-01-04" or evtsubscriptcnt4 > 0 then %> finish <% elseif nowdate = "2017-01-04" then %> current<% end if %>">
							<span class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/txt_day_04.png" alt="4일" /></span>
							<div class="mileage m50">50마일리지 받는 날!</div>
							<div class="btnGroup">
								<% if evtsubscriptcnt4 = 0 then %>
									<% if nowdate = "2017-01-04" then %>
										<button type="button" class="btnApply"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/btn_apply.png" alt="신청하기" /></button>
										<button type="button" onclick="fnsubmit(); return false;" class="btnToday"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/btn_apply_02.png" alt="신청하기" /></button>
									<% else %>
										<button type="button" onclick="return false;" class="btnApply"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/btn_apply.png" alt="신청하기" /></button>
										<button type="button" onclick="return false;" class="btnToday"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/btn_apply_02.png" alt="신청하기" /></button>
									<% end if %>
								<% else %>
									<button type="button" class="btnFinish"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/btn_finish.png" alt="신청완료" /></button>
								<% end if %>
							</div>
							<div class="frame"></div>
						</li>

						<%'' 5일 %>
						<li class="day05 <% if nowdate > "2017-01-05" or evtsubscriptcnt5 > 0 then %> finish <% elseif nowdate = "2017-01-05" then %> current<% end if %>">
							<span class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/txt_day_05.png" alt="5일" /></span>
							<div class="mileage m100">100마일리지 받는 날!</div>
							<div class="btnGroup">
								<% if evtsubscriptcnt5 = 0 then %>
									<% if nowdate = "2017-01-05" then %>
										<button type="button" class="btnApply"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/btn_apply.png" alt="신청하기" /></button>
										<button type="button" onclick="fnsubmit(); return false;" class="btnToday"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/btn_apply_02.png" alt="신청하기" /></button>
									<% else %>
										<button type="button" onclick="return false;" class="btnApply"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/btn_apply.png" alt="신청하기" /></button>
										<button type="button" onclick="return false;" class="btnToday"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/btn_apply_02.png" alt="신청하기" /></button>
									<% end if %>
								<% else %>
									<button type="button" class="btnFinish"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/btn_finish.png" alt="신청완료" /></button>
								<% end if %>
							</div>
							<div class="frame"></div>
						</li>

						<%'' 6일 %>
						<li class="day06 <% if nowdate > "2017-01-06" or evtsubscriptcnt6 > 0 then %> finish <% elseif nowdate = "2017-01-06" then %> current<% end if %>">
							<span class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/txt_day_06.png" alt="6일" /></span>
							<div class="mileage m200">200마일리지 받는 날!</div>
							<div class="btnGroup">
								<% if evtsubscriptcnt6 = 0 then %>
									<% if nowdate = "2017-01-06" then %>
										<button type="button" class="btnApply"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/btn_apply.png" alt="신청하기" /></button>
										<button type="button" onclick="fnsubmit(); return false;" class="btnToday"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/btn_apply_02.png" alt="신청하기" /></button>
									<% else %>
										<button type="button" onclick="return false;" class="btnApply"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/btn_apply.png" alt="신청하기" /></button>
										<button type="button" onclick="return false;" class="btnToday"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/btn_apply_02.png" alt="신청하기" /></button>
									<% end if %>
								<% else %>
									<button type="button" class="btnFinish"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/btn_finish.png" alt="신청완료" /></button>
								<% end if %>
							</div>
							<div class="frame"></div>
						</li>
					</ul>
				</dd>
			</dl>
			<p class="tPad30"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/txt_tip.png" alt="※ 마일리지는 해당 일자에만 신청할 수 있습니다. " /></p>
		</div>
		<div class="evtNoti">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/tit_noti.png" alt="매일매일 마일리지" /></h3>
			<ul>
				<li>- 본 이벤트는 로그인 후에 참여할 수 있습니다.</li>
				<li>- 이벤트는 ID당 1회만 참여할 수 있습니다.</li>
				<li>- 주문하시는 상품에 따라, 배송비용은 추가로 발생할 수 있습니다.</li>
				<li>- 지급된 마일리지는 3만원 이상 구매시 현금처럼 사용 가능합니다.</li>
				<li>- 마일리지는 해당일자에만 신청할 수 있습니다.</li>
				<li>- 신청받은 마일리지는 1월 9일 일괄 지급할 예정입니다.</li>
				<li>- 이벤트는 조기 마감될 수 있습니다.</li>
			</ul>
		</div>
		<div class="deco">
			<div class="d01"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/img_deco_01.png" alt="" /></div>
			<div class="d02"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/img_deco_02.png" alt="" /></div>
			<div class="d03"><img src="http://webimage.10x10.co.kr/eventIMG/2016/75305/img_deco_03.png" alt="" /></div>
		</div>
	</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->
<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 꽃구경도 식후경
' History : 2017.03.17 유태욱
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
dim evtsubscriptcnt, totalevtsubscriptcnt, entercnt44, entercnt77

IF application("Svr_Info") = "Dev" THEN
	eCode = "66289"
Else
	eCode = "76770"
End If

nowdate = date()
'												nowdate = "2017-03-20"

vUserID = getEncLoginUserID
evtsubscriptcnt = 0
totalevtsubscriptcnt = 0
entercnt44 = 0
entercnt77 = 0

if vUserID <> "" then
	sqlstr = ""
	sqlstr = "select count(*) as cnt"
	sqlstr = sqlstr & " from [db_event].[dbo].[tbl_event_subscript] sc"
	sqlstr = sqlstr & " where sc.evt_code="& eCode &""
	sqlstr = sqlstr & " and  convert(varchar(10),sc.regdate,21)='"& nowdate &"'  and sc.userid='"& vUserID &"' and sc.sub_opt2<>77 and sc.sub_opt2<>44  "	'

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
	sqlstr = sqlstr & " and  sc.userid='"& vUserID &"' and sc.sub_opt2<>77 and sc.sub_opt2<>44 "	'

	'response.write sqlstr & "<Br>"
	rsget.Open sqlstr,dbget
	IF not rsget.EOF THEN
		totalevtsubscriptcnt = rsget("cnt")	'총 몇번 했는지 카운트
	END IF
	rsget.close

	sqlstr = ""
	sqlstr = "select top 2 sc.sub_opt2 "
	sqlstr = sqlstr & " from [db_event].[dbo].[tbl_event_subscript] sc"
	sqlstr = sqlstr & " where sc.evt_code="& eCode &""
	sqlstr = sqlstr & " and  sc.userid='"& vUserID &"' and (sc.sub_opt2=44 or sc.sub_opt2=77) "
	sqlstr = sqlstr & " order by sub_opt2 asc "

'	response.write sqlstr & "<Br>"
	rsget.Open sqlstr,dbget

	dim arrList, i
	IF not rsget.EOF THEN
		arrList = rsget.getRows()
'		entercnt44 = rsget(0)'4일 응모했는지
'		entercnt77 = rsget(1)'7일 응모했는지								
	END IF
	rsget.close

	if isarray(arrList)=TRUE then
		For i=0 to ubound(arrList,2)
			if i = 0 then
				entercnt44 = arrList(0,i)'4일 응모했는지
			end if
			if i = 1 then
				entercnt77 = arrList(0,i)'7일 응모했는지								
			end if
		Next
	end if

end if
%>
<style type="text/css">
.sikhoo {overflow:hidden; position:relative; background:#afe3f2 url(http://webimage.10x10.co.kr/eventIMG/2017/76770/bg_hill.jpg) 50% 0 no-repeat;}
.sikhoo button {background-color:transparent;}
.cherryBlossom {position:absolute; top:0; left:0; z-index:5; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2017/76770/img_cherry_blossom.png) 112px 99px no-repeat;}
.snowing {animation:snowing 2s linear 1;}
@keyframes snowing {
	0% {background-position:50px 50px;}
	100%{background-position:112px 99px;}
}
.sikhoo .topic {padding-top:115px;}
.sikhoo .topic p {margin-top:25px;}

.sikhoo .lunchbox {position:relative; padding-bottom:67px;}
.sikhoo .lunchbox .day {position:absolute; top:0; left:0;}
.lunchbox .btnClick {display:block; position:absolute; top:226px; left:50%; z-index:5; width:130px; height:140px; margin-left:-65px;}
.lunchbox .btnClick .bg img {animation:pulse 5s infinite; animation-fill-mode:both;}
@keyframes pulse {
	0% {transform:scale(0.6); opacity:0.2;}
	95% {transform:scale(1); opacity:1;}
	100% {transform:scale(1); opacity:1;}
}
.lunchbox .btnClick .hand {position:absolute; top:60px; right:0;}
.lunchbox .btnClick .hand img {animation:bounce 1.2s infinite; animation-delay:1.5s;}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:7px; animation-timing-function:ease-in;}
}

.checkAttendance {position:relative; z-index:10; padding-top:19px;}
.checkAttendance .count {position:absolute; top:0; left:50%; z-index:5; margin-left:-120px; width:240px; height:27px; padding-top:9px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/76770/bg_box_pink.png) 50% 0 no-repeat;}
.checkAttendance .count b {margin:0 3px 0 14px; color:#ffef68; font-family:'Dotum', '돋움', 'Verdana'; font-size:18px; line-height:18px;}
.checkAttendance ol {overflow:hidden; width:980px; margin:0 auto;}
.checkAttendance ol li {position:relative; float:left;}
.checkAttendance ol li .btnCheck {position:absolute; bottom:52px; left:50px; z-index:10;}
.checkAttendance ol li button.btnCheck:hover img {animation:slideUp 1s 1; animation-fill-mode:both;}
@keyframes slideUp {
	0% {transform:translateY(10px); opacity:0;}
	100% {transform:translateY(0); opacity:1;}
}

.noti {position:relative; padding:40px 0; background:#eca7a7 url(http://webimage.10x10.co.kr/eventIMG/2017/76770/bg_indipink.png) 50% 0 repeat-y; text-align:left;}
.noti h3 {position:absolute; top:50%; left:94px; margin-top:-34px;}
.noti ul {margin-left:278px; padding-left:50px; border-left:1px solid #f2c0c2;}
.noti ul li {position:relative; margin-top:7px; padding-left:13px; color:#fff; font-family:'Gulim', '굴림', 'Verdana'; font-size:12px; line-height:1.5em;}
.noti ul li:first-child {margin-top:0;}
.noti ul li span {position:absolute; top:7px; left:0; width:5px; height:1px; background-color:#fff;}
</style>
<script type="text/javascript">
function fnsubmit(mde,nb) {
	<% If vUserID = "" Then %>
		if(confirm("로그인 후 신청할 수 있습니다.")){
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
		}
		return false;
	<% End If %>
	<% If vUserID <> "" Then %>
		<% if nowdate >= "2017-03-20" and nowdate <= "2017-03-26" then %>
			var reStr;
			var str = $.ajax({
				type: "GET",
				url:"/event/etc/enter/doeventsubscript/doEventSubscript76770.asp",
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
						if(ccdaycnt == 4) {
							$("#4daybfbt").hide();
							$("#4dayafbt1").show();
						}else if(ccdaycnt == 7){
							$("#7daybfbt").hide();
							$("#7dayafbt1").show();
						}
						$("#etimgdv").show();
						$("#etimg").attr("src", "http://webimage.10x10.co.kr/eventIMG/2017/76770/img_lunchbox_0"+ccdaycnt+".jpg");
						alert('이벤트 참여가 완료되었습니다!');
						return false;
					}else if(reStr[1] == "et"){
						if(reStr[2] == 44) {
							$("#4daybfbt1").hide();
							$("#4daybfbt2").hide();
							$("#4dayafbt3").show();
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
			return false;
		<% End If %>
	<% End If %>
}
</script>
	<!-- 76770 꽃구경도 식후경 -->
	<div class="evt76770 sikhoo">
		<div class="cherryBlossom snowing"></div>
		<div class="topic">
			<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/76770/tit_sikhoo.png" alt="꽃구경도 식후경" /></h2>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/76770/txt_check.png" alt="매일매일 출석체크하고 봄나들이 도시락을 완성하세요! 참여 횟수에 따라 다양한 혜택을 드립니다. 이벤트 기간은 2017년 3월 20일부터 3월 26일까지" /></p>
		</div>

		<div class="lunchbox">
			<div class="figure"><img src="http://webimage.10x10.co.kr/eventIMG/2017/76770/img_lunchbox.jpg" alt="" /></div>
			<%'' for dev msg : 버튼 클릭 후 버튼은 숨겨주세요. %>
			<% if nowdate < "2017-03-27"  then %>
				<% if evtsubscriptcnt < 1 then %>
					<button type="button" onclick="fnsubmit('clk','');" class="btnClick" id="ccbt">
						<span class="bg"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69445/bg_light.png" alt="" /></span>
						<span class="hand"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69445/img_hand.png" alt="출석체크 하기" /></span>
					</button>
				<% end if %>
			<% end if %>

			<% if totalevtsubscriptcnt > 0 then %>
				<div class="day" id="etimgdv"><img id="etimg" src="http://webimage.10x10.co.kr/eventIMG/2017/76770/img_lunchbox_0<%= totalevtsubscriptcnt %>.jpg" alt="" /></div>
			<% else %>
				<div class="day" id="etimgdv" style="display:none;"><img id="etimg" src="http://webimage.10x10.co.kr/eventIMG/2017/76770/img_lunchbox_0<%= totalevtsubscriptcnt %>.jpg" alt="" /></div>
			<% end if %>

			<div class="checkAttendance">
				<p class="count">
					<img src="http://webimage.10x10.co.kr/eventIMG/2017/76770/txt_count_01.png" alt="나의 출석일수는?" />
					<!-- for dev msg : 출석일자 카운팅 -->
					<b id="ccday"><%= totalevtsubscriptcnt %></b>
					<img src="http://webimage.10x10.co.kr/eventIMG/2017/76770/txt_count_02.png" alt="일" />
				</p>
				<ol>
					<li>
						<img src="http://webimage.10x10.co.kr/eventIMG/2017/76770/txt_check_attendance_01.png" alt="4일 출석시 200마일리지 전원증정" />
						<!-- for dev msg : 태욱대리님! 버튼쪽 마크업 통일 되게하는게 좋을꺼 같긴한데 안그러면 클래스로 컨트롤하거너 스타일로 줘야할꺼같은데... 커서 포인터 없앨라공 ㅋㅋ 어떤게 좋은지 의견 주시면 좋을꺼같아요! -->

						<%'' 4번 응모 안하면 회색 버튼으로 보여짐 %>
						<% if totalevtsubscriptcnt < 4 then %>
							<span class="btnCheck" id="4daybfbt"><img src="http://webimage.10x10.co.kr/eventIMG/2017/76770/btn_wait.png" alt="기다리기" /></span>
							<button type="button" id="4dayafbt1" onclick="fnsubmit('et','f'); return false;" style="display:none;" class="btnCheck"><img src="http://webimage.10x10.co.kr/eventIMG/2017/76770/btn_enter.png" alt="신청하기" /></button>
							<span class="btnCheck" id="4dayafbt3" style="display:none;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/76770/btn_done.png" alt="신청완료" /></span>
						<% elseif totalevtsubscriptcnt >= 4 and entercnt44 <> 44 then %>
							<%'' 4번 응모했을때 보라색 버튼 나옴 %>
							<button type="button" id="4dayafbt2" onclick="fnsubmit('et','f'); return false;" class="btnCheck"><img src="http://webimage.10x10.co.kr/eventIMG/2017/76770/btn_enter.png" alt="신청하기" /></button>
							<span class="btnCheck" id="4dayafbt3"  style="display:none;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/76770/btn_done.png" alt="신청완료" /></span>
						<% elseif totalevtsubscriptcnt >= 4 and entercnt44 = 44 then %>
							<%'' 신청하고나면 신청완료 버튼으로 보여짐 %>
							<span class="btnCheck" id="4dayafbt3"><img src="http://webimage.10x10.co.kr/eventIMG/2017/76770/btn_done.png" alt="신청완료" /></span>
						<% end if %>

					</li>
					<li>
						<img src="http://webimage.10x10.co.kr/eventIMG/2017/76770/txt_check_attendance_02.png" alt="7일 출석시 300마알리지 전원증정 및 PLUSBOX PICNIC PACK 30명 추첨 랜덤발송" usemap="#itemlink" />
						<map name="itemlink" id="itemlink">
							<area shape="rect" coords="394,16,597,209" href="/shopping/category_prd.asp?itemid=1086388&pEtr=76770" alt="PLUSBOX PICNIC PACK" />
						</map>

						<%'' 7번 응모 안하면 회색 버튼으로 보여짐 %>
						<% if totalevtsubscriptcnt < 7 then %>
							<span class="btnCheck" id="7daybfbt"><img src="http://webimage.10x10.co.kr/eventIMG/2017/76770/btn_wait.png" alt="기다리기" /></span>
							<button type="button"  id="7dayafbt1" onclick="fnsubmit('et','s'); return false;" style="display:none;" class="btnCheck"><img src="http://webimage.10x10.co.kr/eventIMG/2017/76770/btn_enter.png" alt="신청하기" /></button>
							<span class="btnCheck" id="7dayafbt3" style="display:none;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/76770/btn_done.png" alt="신청완료" /></span>
						<% elseif totalevtsubscriptcnt >= 7 and entercnt77 <> 77 then %>
							<%'' 7번 응모했을때 보라색 버튼 나옴 %>
							<button type="button" id="7dayafbt2" onclick="fnsubmit('et','s'); return false;" class="btnCheck"><img src="http://webimage.10x10.co.kr/eventIMG/2017/76770/btn_enter.png" alt="신청하기" /></button>
							<span class="btnCheck" id="7dayafbt3" style="display:none;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/76770/btn_done.png" alt="신청완료" /></span>
						<% elseif totalevtsubscriptcnt >= 7 and entercnt77 = 77 then %>
							<%'' 신청하고나면 신청완료 버튼으로 보여짐 %>
							<span class="btnCheck" id="7dayafbt3"><img src="http://webimage.10x10.co.kr/eventIMG/2017/76770/btn_done.png" alt="신청완료" /></span>
						<% end if %>

					</li>
				</ol>
			</div>
		</div>

		<div class="noti">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/76770/tit_noti.png" alt="이벤트 유의사항" /></h3>
			<ul>
				<li><span></span>하루에 한 번씩만 참여하실 수 있습니다.</li>
				<li><span></span>참여한 횟수에 따라서 각 경품을 신청하실 수 있습니다.</li>
				<li><span></span>이벤트 기간이 지난 뒤에는 신청 및 응모하실 수 없습니다.</li>
				<li><span></span>마일리지 지급과 경품 당첨자 발표는 2017년 3월 29일(수)에 일괄 진행됩니다.</li>
			</ul>
		</div>
	</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->
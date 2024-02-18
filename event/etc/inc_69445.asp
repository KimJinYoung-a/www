<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 별헤는밤 출첵 이벤트 W
' History : 2016-02-29 유태욱 생성
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
dim currenttime
	currenttime =  now()
'	currenttime = #03/07/2016 09:00:00#

	userid = GetEncLoginUserID()

IF application("Svr_Info") = "Dev" THEN
	eCode   =  66053
Else
	eCode   =  69445
End If

If IsUserLoginOK Then 
	'// 출석 여부
	strSql = "select "
	strSql = strSql & " isnull(sum(case when convert(varchar(10),t.regdate,120) = '"& DATE() &"' then 1 else 0 end ),0) as todaycnt "
	strSql = strSql & " , count(*) as totcnt "
	strSql = strSql & " from db_temp.[dbo].[tbl_event_attendance] as t "
	strSql = strSql & " inner join db_event.dbo.tbl_event as e "
	strSql = strSql & " on t.evt_code = e.evt_code and convert(varchar(10),t.regdate,120) between convert(varchar(10),e.evt_startdate,120) and convert(varchar(10),e.evt_enddate,120) "
	strSql = strSql & "	where t.userid = '"& userid &"' and t.evt_code = '"& eCode &"' " 
	rsget.Open strSql,dbget,1
	IF Not rsget.Eof Then
		todaycnt = rsget("todaycnt") '// 오늘 출석 여부 1-ture 0-false
		totcnt = rsget("totcnt") '// 내 전체 출석수
	End IF
	rsget.close()

	'// 각 상품 응모 여부
	strSql = " select "
	strSql = strSql & "	isnull(sum(case when sub_opt1 = 2 then 1 else 0 end),0) as prize1 , "
	strSql = strSql & "	isnull(sum(case when sub_opt1 = 4 then 1 else 0 end),0) as prize2 , "
	strSql = strSql & "	isnull(sum(case when sub_opt1 = 7 then 1 else 0 end),0) as prize3  "
	strSql = strSql & "	from db_event.dbo.tbl_event_subscript "
	strSql = strSql & "	where evt_code = '"& eCode &"' and userid = '"& userid &"' "
	rsget.Open strSql,dbget,1
	IF Not rsget.Eof Then
		prize1	= rsget("prize1")	'// 2일차 응모
		prize2	= rsget("prize2")	'//	4일차 응모
		prize3	= rsget("prize3")	'//	7일차 응모
	End IF
	rsget.close()
End If 
%>
<style type="text/css">
img {vertical-align:top;}

.evt69445 button {background-color:transparent;}

.article {min-height:1107px; background:#161e37 url(http://webimage.10x10.co.kr/eventIMG/2016/69445/bg_night.jpg) no-repeat 50% 0;}

.countStar {position:relative; height:730px;}
.countStar h2 {position:absolute; top:139px; left:50%; margin-left:-237px; animation-name:move; animation-duration:3s; animation-fill-mode:both; animation-iteration-count:1;}
.countStar h2 span {position:absolute; top:23px; left:35px;}
@keyframes move {
	0% {transform:translateY(50px); opacity:0;}
	100% {transform:translateY(0); opacity:1;}
}
.countStar h2 span img {animation:spin 3s linear 2; transform-origin:50% 50%;}
@keyframes spin {100% { -webkit-transform: rotate(360deg); transform:rotate(360deg);}}

.countStar .click {position:absolute; top:278px; left:50%; margin-left:-157px;}
.countStar .btnClick {position:absolute; top:0; left:0; width:1140px; height:690px;}
.countStar .btnClick .bg {position:absolute; top:379px; left:516px; width:107px; height:111px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69445/bg_light.png) no-repeat 50% 50%;}
.countStar .btnClick .hand {position:absolute; top:429px; left:571px;}

.painting {animation-name:painting; animation-duration:3s; animation-fill-mode:both; animation-iteration-count:3;}
@keyframes painting {
	0% {opacity:0; background-size:70% 70%;}
	100% {opacity:1; background-size:100% 100%;}
}

.countStar .star {position:absolute;}
.countStar .star {animation-name:twinkle; animation-iteration-count:infinite; animation-duration:2.5s; animation-fill-mode:both;}
.countStar .star1 {top:376px; left:422px;}
.countStar .star2 {top:483px; left:633px; animation-delay:0.2s;}
.countStar .star3 {top:396px; right:351px; animation-delay:0.4s;}
.countStar .star4 {top:340px; left:231px; animation-delay:0.6s;}
.countStar .star5 {top:468px; right:165px; animation-delay:0.2s;}
.countStar .star6 {top:249px; left:130px; animation-delay:0.4s;}
.countStar .star7 {top:309px; right:107px; animation-delay:0.6s;}

@keyframes twinkle {
	0% {opacity:0;}
	100% {opacity:1;}
}

.countStar .count {position:absolute; bottom:0; left:50%; margin-left:-183px; width:366px; height:39px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/69445/bg_round_box.png) no-repeat 50% 0;}
.countStar .count img {margin-top:11px;}
.countStar .count span {color:#ffef68; font-family:'Dotum', '돋움', 'Arial'; font-size:18px; font-weight:bold; line-height:45px;}

.gift {position:relative; margin-top:46px;}
.gift ol {position:absolute; top:53px; left:50%; width:940px; height:216px; margin-left:-470px;}
.gift ol li {float:left; position:relative; width:33.3333%; height:100%;}
.gift ol li p {text-indent:-9999em;}
.gift ol li button {position:absolute; top:108px; right:25px;}

.noti {position:relative; padding:40px 0 42px; background-color:#272727; text-align:left;}
.noti h3 {position:absolute; top:36px; left:0; height:165px; width:271px; border-right:1px solid #686868;}
.noti h3 .ico {position:absolute; top:47px; left:135px;}
.noti h3 .ico img {animation:spinY 5s linear infinite;}
@keyframes spinY {100% {transform:rotateY(360deg);}}

.noti h3 .text {position:absolute; top:98px; left:95px;}
.noti ul {padding-left:316px;}
.noti ul li {margin-top:6px; color:#f8f7f7; font-family:'굴림', 'Gulim', 'Arial'; font-size:12px; line-height:1.5em;}
.noti ul li:first-child {margin-top:0;}
.noti ul li strong {color:#ffef68; font-weight:normal;}
</style>
<script type='text/javascript'>

<%''// 출석체크 %>
function jsdailychk(){
<% If IsUserLoginOK() Then %>
	<% If not( left(currenttime,10)>="2016-03-07" and left(currenttime,10)<"2016-03-14" ) Then %>
		alert('이벤트 응모 기간이 아닙니다.');
		return;
	<% else %>
		var result;
		$.ajax({
			type:"GET",
			url:"/event/etc/doeventsubscript/doEventSubscript69445.asp",
			data: "mode=daily",
			dataType: "text",
			async:false,
			cache:false,
			success : function(Data){
				result = jQuery.parseJSON(Data);
				if (result.resultcode=="22")
				{
					alert('매일 한 번 별을 켜두실 수 있어요!');
					return;
				}
				else if (result.resultcode=="44")
				{
					alert('로그인이 필요한 서비스 입니다.');
					return;
				}
				else if (result.resultcode=="11")
				{
					alert('오늘의 별이 떴어요.');
					location.reload();
					return;
				}
			}
		});
	<% end if %>
<% Else %>
	if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
		var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
		winLogin.focus();
		return false;
	}
	return false;
<% End IF %>
	
}

<%''// 응모 %>
function jsloststars(v){
<% If IsUserLoginOK() Then %>
	<% If not( left(currenttime,10)>="2016-03-07" and left(currenttime,10)<"2016-03-14" ) Then %>
		alert('이벤트 응모 기간이 아닙니다.');
		return;
	<% else %>
		if (v=="starx"){
			alert('별을 더 켜주세요.');
			return;
		}else{
			var result;
			$.ajax({
				type:"GET",
				url:"/event/etc/doeventsubscript/doEventSubscript69445.asp",
				data: "mode=stars&loststars="+v,
				dataType: "text",
				async:false,
				cache:false,
				success : function(Data){
					result = jQuery.parseJSON(Data);
					if (result.resultcode=="77")
					{
						alert('응모가 완료 되었습니다.\n마일리지는 3월 15일에\n일괄 지급될 예정입니다.');
						location.reload();
						return;
					}
					else if (result.resultcode=="55")
					{
						alert('쿠폰이 발급되었습니다.\n발급 후 24시간 이내에 사용해주세요.');
						location.reload();
						return;
					}
					else if (result.resultcode=="11")
					{
						alert('응모가 완료되었습니다.\n당첨자는 추첨을통해\n3월15일에 발표할 예정입니다.');
						location.reload();
						return;
					}
					else if (result.resultcode=="33")
					{
						alert('별을 더 켜주세요.');
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
		}
	<% end if %>
<% Else %>
	if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
		var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
		winLogin.focus();
		return false;
	}
	return false;
<% End IF %>
}
</script>
	<div class="evt69445">
		<div class="article">
			<div class="countStar">
				<h2>
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/69445/tit_count_star.png" alt="별 헤는 밤" />
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/69445/img_star_navy.png" alt="" /></span>
				</h2>
				<p class="click" ><img src="http://webimage.10x10.co.kr/eventIMG/2016/69445/txt_click.png" alt="매일 한 번씩 밤하늘을 클릭하여 별을 켜주세요! 모은 별의 개수에 따라서 응모하실 수 있어요!" /></p>

				<% If not( left(currenttime,10)>="2016-03-07" and left(currenttime,10)<"2016-03-14" ) Then %>
				<% else %>
					<% if todaycnt = 0 then %>
						<%''//  for dev msg : 버튼 클릭 후 버튼은 숨겨주세요. %>
						<button type="button" onclick="jsdailychk(); return flase;" class="btnClick">
							<span class="bg painting"></span>
							<span class="hand"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69445/img_hand.png" alt="" /></span>
						</button>
					<% end if %>
				<% end if %>

				<% If not( left(currenttime,10)>="2016-03-07" and left(currenttime,10)<"2016-03-14" ) Then %>
					<% if totcnt >= 1 then %>
						<span class="star star1"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69445/img_star.png" alt="별 하나" /></span>
					<% end if %>
					<% if totcnt >= 2 then %>
						<span class="star star2"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69445/img_star.png" alt="별 둘" /></span>
					<% end if %>
					<% if totcnt >= 3 then %>
						<span class="star star3"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69445/img_star.png" alt="별 셋" /></span>
					<% end if %>
					<% if totcnt >= 4 then %>
						<span class="star star4"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69445/img_star.png" alt="별 넷" /></span>
					<% end if %>
					<% if totcnt >= 5 then %>
						<span class="star star5"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69445/img_star.png" alt="별 다섯" /></span>
					<% end if %>
					<% if totcnt >= 6 then %>
						<span class="star star6"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69445/img_star.png" alt="별 여섯" /></span>
					<% end if %>
					<% if totcnt >= 7 then %>
						<span class="star star7"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69445/img_star.png" alt="별 일곱" /></span>
					<% end if %>
				<% else %>
					<% if todaycnt = 1 then %>
						<%''// for dev msg : 버튼 클릭 후 별 보여주세요. 버튼 클릭시 별 위치값은 각각 다릅니다. star1 ~ star7 순서대로 보여주세요 %>
						<% if totcnt >= 1 then %>
							<span class="star star1"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69445/img_star.png" alt="별 하나" /></span>
						<% end if %>
						<% if totcnt >= 2 then %>
							<span class="star star2"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69445/img_star.png" alt="별 둘" /></span>
						<% end if %>
						<% if totcnt >= 3 then %>
							<span class="star star3"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69445/img_star.png" alt="별 셋" /></span>
						<% end if %>
						<% if totcnt >= 4 then %>
							<span class="star star4"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69445/img_star.png" alt="별 넷" /></span>
						<% end if %>
						<% if totcnt >= 5 then %>
							<span class="star star5"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69445/img_star.png" alt="별 다섯" /></span>
						<% end if %>
						<% if totcnt >= 6 then %>
							<span class="star star6"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69445/img_star.png" alt="별 여섯" /></span>
						<% end if %>
						<% if totcnt >= 7 then %>
							<span class="star star7"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69445/img_star.png" alt="별 일곱" /></span>
						<% end if %>
					<% end if %>
				<% end if %>

				<% if userid <> "" then %>
					<p class="count">
						<span><%=userid%></span> <img src="http://webimage.10x10.co.kr/eventIMG/2016/69445/txt_count_01.png" alt="님은 총" />
						<span><%=totcnt%></span> <img src="http://webimage.10x10.co.kr/eventIMG/2016/69445/txt_count_02.png" alt="개의 별을 켰습니다." />
					</p>
				<% end if %>
			</div>

			<div class="gift">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/69445/img_gift_v1.png" alt="별 세고 선물 받기 모은 별의 개수에 따라서 응모하실 수 있어요! 별 두개를 모으시면 응모하신 모든 분께 200마일리지를, 별 네개를 모으시면 응모하신 모든 분께 삼만원 이상 구매시 사용할 수 있는 오천원 쿠폰을, 별 7개를 모으시면 추첨을 통해 30분께 더어스 램프를 드립니다." /></p>
				<ol>
					<li>
						<p>별 두개를 모으시면 응모하신 모든 분께 200마일리지를 드립니다.</p>
						<% if totcnt < 2 then %>
							<button onclick="jsloststars('starx'); return false;" type="button">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/69445/btn_wait.png" alt="기다리기" />
							</button>
						<% else %>
							<% if prize1 = 1 then %>
								<button type="button">
									<img src="http://webimage.10x10.co.kr/eventIMG/2016/69445/btn_issue_end.png" alt="발급완료" />
								</button>
							<% else %>
								<button type="button" onclick="jsloststars('2'); return false;">
									<img src="http://webimage.10x10.co.kr/eventIMG/2016/69445/btn_issue.png" alt="발급하기" />
								</button>
							<% end if %>
						<% end if %>
					</li>
					<li>
						<p>별 네개를 모으시면 응모하신 모든 분께 삼만원 이상 구매시 사용할 수 있는 오천원 쿠폰을 드립니다.</p>
						<% if totcnt < 4 then %>
							<button onclick="jsloststars('starx'); return false;" type="button">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/69445/btn_wait.png" alt="기다리기" />
							</button>
						<% else %>
							<% if prize2 = 1 then %>
								<button type="button">
									<img src="http://webimage.10x10.co.kr/eventIMG/2016/69445/btn_issue_end.png" alt="발급완료" />
								</button>
							<% else %>
								<button type="button" onclick="jsloststars('4'); return false;">
									<img src="http://webimage.10x10.co.kr/eventIMG/2016/69445/btn_issue.png" alt="발급하기" />
								</button>
							<% end if %>
						<% end if %>
					</li>
					<li>
						<p>별 7개를 모으시면 추첨을 통해 30분께 더어스 램프를 드립니다.</p>
						<% if totcnt < 7 then %>
							<button onclick="jsloststars('starx'); return false;" type="button">
								<img src="http://webimage.10x10.co.kr/eventIMG/2016/69445/btn_wait.png" alt="기다리기" />
							</button>
						<% else %>
							<% if prize3 = 1 then %>
								<button type="button">
									<img src="http://webimage.10x10.co.kr/eventIMG/2016/69445/btn_enter_end.png" alt="응모완료" />
								</button>
							<% else %>
								<button type="button" onclick="jsloststars('7'); return false;">
									<img src="http://webimage.10x10.co.kr/eventIMG/2016/69445/btn_enter.png" alt="응모하기" />
								</button>
							<% end if %>
						<% end if %>
					</li>
				</ol>
			</div>
		</div>

		<div class="noti">
			<h3>
				<span class="ico"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69445/ico_star.png" alt="" /></span>
				<span class="text"><img src="http://webimage.10x10.co.kr/eventIMG/2016/69445/tit_noti.png" alt="이벤트 유의사항" /></span>
			</h3>
			<ul>
				<li>- 텐바이텐 고객님을 위한 이벤트 입니다.</li>
				<li>- <strong>하루 한 개</strong>의 별만 켤 수 있습니다.</li>
				<li>- 별을 쌓은 개수에 따라서 각 미션에 응모할 수 있습니다.</li>
				<li>- 이벤트 기간 후에 응모하실 수 없습니다.</li>
				<li>- 이벤트를 통해 받으실 마일리지는 <strong>2016년 3월 15일(화요일)</strong>에 일괄 지급됩니다.</li>
				<li>- 당첨자 안내 공지는 2016년 3월 15일(화요일)에 진행됩니다.</li>
			</ul>
		</div>
	</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->
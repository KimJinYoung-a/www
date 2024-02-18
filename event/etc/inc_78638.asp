<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<%
	'#############################
	' Description : 마일리지 뽑기
	' History : 2017.06.22 원승현
	'#############################

	Dim eCode, nowDate, userid, evtChkCnt
	Dim evtStartDate, evtEndDate, sqlstr

	IF application("Svr_Info") = "Dev" THEN
		eCode 		= "66351"
	Else
		eCode 		= "78638"
	End If

	'//현재 일자
	nowDate = Now()

	'//회원아이디
	userid = GetEncLoginUserID

	'//이벤트 응모시작일자
	evtStartDate = #06/26/2017 10:00:00#

	'//이벤트 응모종료일자
	evtEndDate = #07/01/2017 00:00:00#

	If IsUserLoginOK Then
		'// 이벤트에 참여하였는지 확인한다.
		sqlstr = "Select count(*)" &_
				" From db_event.dbo.tbl_event_subscript" &_
				" WHERE evt_code='" & eCode & "' and userid='" & userid & "' And convert(varchar(10), regdate, 120) = '"&Left(nowDate, 10)&"' "
				'response.write sqlstr
		rsget.Open sqlStr,dbget,1
			evtChkCnt = rsget(0)
		rsget.Close
	End If
%>
<style type="text/css">
.hgroup {overflow:hidden; position:relative; width:100%; height:368px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/78638/bg_red.png) no-repeat 50% 0;}
.hgroup h2 {position:relative; width:496px; height:181px; padding-top:93px; margin:0 auto;}
.hgroup h2 span {display:inline-block; position:absolute; opacity:0;}
.hgroup h2 span:first-child {top:93px; left:126px;}
.hgroup h2 span:first-child + span {bottom:0; left:0;}
.hgroup h2 span:first-child + span + span {bottom:25px; right:0;}
.hgroup > span {position:absolute; top:0; right:344px;;}
.dollBox {position:relative;}
.dollBox .pull {position:absolute; top:130px; left:515px; width:108px;}
.dollBox .pull .bar {position:absolute; top:-70px; left:50%; width:9px; height:72px; margin-left:-4.5px; background-color:#aaaaaa;}
.btnJoin {position:relative;}
.btnJoin .button {cursor:pointer;}
.btnJoin .stick {position:absolute; top:45px; left:376px;}
.mileageLayer {position:absolute; top:0; left:0; height:1180px; width:1140px; margin:0 auto; padding-top:243px; background-color:rgba(0,0,0,.5); z-index:10;}
.mileageLayer .btnClose {display:inline-block; position:absolute; top:220px; right:300px; width:115px; height:115px; background-color:transparent; text-indent:-999em;}
.hiddenCode {position:absolute; bottom:510px; left:50%; width:510px;; margin-left:-255px; opacity:0.1;}

.evntNoti {position:relative; padding:38px 0 37px 297px; text-align:left; background:#737374;}
.evntNoti h3 {position:absolute; left:110px; top:50%; margin-top:-36.5px;}
.evntNoti ul {padding:7px 0 7px 60px; border-left:1px solid #9d9d9e;}
.evntNoti li {padding:3px 0; color:#fff;}

.swing {animation:swing 1.8s 15 forwards ease-in-out; transform-origin:50% 0;}
.swing2 {animation:swing 1.2s 15; transform-origin:50% 100%;}
@keyframes swing {
	0%,100%{transform:rotate(8deg);}
	50% {transform:rotate(-3deg);}
}
.bounce {animation:bounce .7s 1; transform-origin: center bottom;}
@keyframes bounce {
	from, 20%, 53%, 80%, to {animation-timing-function: cubic-bezier(0.215, 0.610, 0.355, 1.000); transform: translate3d(0,0,0);}
	40%, 43% {animation-timing-function: cubic-bezier(0.755, 0.050, 0.855, 0.060); transform: translate3d(0, -30px, 0);}
	70% {animation-timing-function: cubic-bezier(0.755, 0.050, 0.855, 0.060); transform: translate3d(0, -15px, 0);}
	90% {transform: translate3d(0,-4px,0);}
}
</style>

<script type="text/javascript">
	$(function(){

		// 타이틀 애니메이션
		titAni();
		$(".hgroup h2 span:nth-child(1)").css({"opacity":"0"});
		$(".hgroup h2 span:nth-child(2)").css({"opacity":"0"});
		$(".hgroup h2 span:nth-child(3)").css({"opacity":"0","bottom":"0"});
		$(".hgroup > span").css({"top":"0"});
		function titAni() {
			$(".hgroup h2 span:nth-child(1)").delay(10).animate({"opacity":"1"},300).addClass("bounce");
			$(".hgroup h2 span:nth-child(2)").delay(500).animate({"opacity":"1"},700);
			 setTimeout(function() {
				$(".hgroup h2 span:nth-child(2)").addClass("bounce");
			}, 300);
			$(".hgroup h2 span:nth-child(3)").delay(700).animate({"opacity":"1","bottom":"25px"},900);
			$(".hgroup > span").delay(800).animate({"top":"-57px"},900);
		}

		// 레이어 팝업
		$(".mileageLayer").hide();
		$(".dollBox .pull > img").addClass("swing");
		$(".btnJoin .button").click(function(){
			// 집게 모션
			pickUp();
			function pickUp() {
			$(".dollBox .pull").delay(100).animate({"top":"90px"},1200);
			$(".dollBox .pull .bar").delay(100).animate({"height":"35px","top":"-30px"},1200);
			}
			 setTimeout(function() {
				$(".dollBox .pull img").removeClass("swing");
				$(".btnJoin .stick").removeClass("swing2");
			}, 1100);

		});
	});

	function checkform(){
		<% If not(IsUserLoginOK()) Then %>
			if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
				location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
				return;
			}
			return false;
		<% End If %>
		<% If userid <> "" Then %>
			<% If nowDate >= evtStartDate And nowDate < evtEndDate Then %>
				<% if evtChkCnt > 0 then %>
					alert("하루에 한 번씩만 참여 가능합니다.");
					return;				
				<% else %>
					$.ajax({
						type:"GET",
						url:"/event/etc/doEventSubscript78638.asp",
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
											$("#mileageLayerArea").empty().html(res[1]);
											window.parent.$('html,body').animate({scrollTop:$(".mEvt78638").offset().top+100},300);
											$(".mileageLayer").delay(900).fadeIn(200);
										}
										else
										{
											errorMsg = res[1].replace(">?n", "\n");
											alert(errorMsg);
											document.location.reload();
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
							<% if false then %>
								//var str;
								//for(var i in jqXHR)
								//{
								//	 if(jqXHR.hasOwnProperty(i))
								//	{
								//		str += jqXHR[i];
								//	}
								//}
								//alert(str);
							<% end if %>
							document.location.reload();
							return false;
						}
					});
				<% end if %>
			<% else %>
				alert("이벤트 응모 기간이 아닙니다.");
				return;				
			<% end if %>
		<% End If %>
	}

	function layerPopClose()
	{
		$(".mileageLayer").hide();
	}
</script>


<%' 꽝 없는 마일리지 뽑기 %>
<div class="mEvt78638">
	<div class="hgroup">
		<h2>
			<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/78638/img_tit_1.png" alt="꽝 없는" /></span>
			<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/78638/img_tit_2.png" alt="마일리지 뽑" /></span>
			<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/78638/img_tit_3.png" alt="기!" /></span>
		</h2>
		<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/78638/img_pull.png" alt="" /></span>
	</div>

	<%' 뽑기 박스 %>
	<div class="dollBox">
		<img src="http://webimage.10x10.co.kr/eventIMG/2017/78638/img_doll_box.jpg" alt="" />
		<span class="pull">
			<span class="bar"></span>
			<img src="http://webimage.10x10.co.kr/eventIMG/2017/78638/img_pull_2.png" alt=""/>
		</span>
	</div>

	<%' 참여하기 버튼 %>
	<div class="btnJoin">
		<a class="button" onclick="checkform();return false;">
			<img src="http://webimage.10x10.co.kr/eventIMG/2017/78638/btn_join.png" alt="참여하기" />
			<span class="stick swing2"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78638/img_stick.png" alt="" /></span>
		</a>
	</div>

	<%' 마일리지 팝업 %>
	<div class="mileageLayer" id="mileageLayerArea"></div>

	<%' 이벤트 유의사항 %>
	<div class="evntNoti">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/78638/tit_notice.png" alt="이벤트 유의사항" /></h3>
		<ul>
			<li>- ID당 하루에 한 번 참여할 수 있습니다.</li>
			<li>- 이벤트는 6월 26일(월) ~ 6월 30일(금) 동안 진행됩니다.</li>
			<li>- 당첨된 마일리지는 7월 5일(수)에 일괄 지급될 예정입니다.</li>
			<li>- 이벤트는 조기 종료될 수 있습니다.</li>
		</ul>
	</div>
</div>
<%'// 꽝 없는 마일리지 뽑기 %>

<!-- #include virtual="/lib/db/dbclose.asp" -->
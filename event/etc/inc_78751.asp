<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'#############################################################
' Description : [컬쳐] 영화 <슈퍼배드 3> in 텐바이텐
' History : 2017-07-06 원승현 생성
'#############################################################
%>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
	Dim eCode
	IF application("Svr_Info") = "Dev" THEN
		eCode   =  66382
	Else
		eCode   =  78751
	End If

	dim userid, i, UserAppearChk, nowdate
		userid = GetEncLoginUserID()

	nowdate = Left(Now(), 10)

	'// 응모여부 확인
	Dim vQuery
	vQuery = "SELECT count(*) FROM [db_event].[dbo].[tbl_event_subscript] WHERE evt_code = '" & eCode & "' And userid='"&userid&"' And convert(varchar(10), regdate, 120) = '"&nowdate&"' "
	rsget.CursorLocation = adUseClient
	rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
	IF Not rsget.Eof Then
		UserAppearChk = rsget(0)
	End IF
	rsget.close

%>

<style type="text/css">
.superbad {background-color:#fff;}
.superbad .head {position:relative; height:780px; background: #fafafa url(http://webimage.10x10.co.kr/eventIMG/2017/78751/bg_grey.jpg) no-repeat 50% 0;}
.superbad .head h2 {position:absolute; top:158px; left:50%; width:385px; margin-left:-193px;}
.superbad .head p {position:absolute; top:112px; left:50%; margin-left:-105px;}
.superbad .head p.subcopy2 {top:366px; margin-left:200px;}
.superbad .head p.subcopy3 {top:432px; margin-left:-148px;}
.superbad .head a {position:absolute; top:65px; left:50%; margin-left:472px;}
.superbad .head a.goMovieInfo {top:605px; margin-left:378px; z-index:10;}
.superbad .deco {position:absolute; top:533px; left:50%; margin-left:-475px;}
.evt1 {height:1075px; padding-top:166px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/78751/bg_yellow.jpg) no-repeat 50% 0;}
.evt1 .inner {width:897px; height:562px;  margin:0 auto 0; padding:50px 110px 0 93px; background-color:#fff;}
.evt1 .inner .txt{margin-top:92px;}
.evt1 .enter .enteredLayer {display:none; position:absolute; top:0; left:50%; width:100%; height:100%; margin-left:-50%; background-color:rgba(0,0,0,.5); z-index:10;}
.evt1 .enter .enteredLayer div {position:relative; padding-top:1010px;}
.evt1 .enter .enteredLayer .btnClose {display:inline-block; position:absolute; top:980px; left:50%; width:115px; height:115px; margin-left:110px; background-color:transparent; text-indent:-999em;}
.evt1 .gift h3 {margin:55px 0 43px; }
.evt1 .gift ul {overflow:hidden; width:1120px; margin:0 auto;}
.evt1 .gift ul li {float:left; margin-right:18px;}
.evt2 {position:relative; height:922px; }
.evt2 .txt {margin:110px 0 75px;}
.evt2 .conts {position:relative;}
.evt2 .conts .goShopping {display:inline-block; height:417px; width:290px; position:absolute; top:0; left:50%; margin-left:-518px; text-indent:-999em;}
.evt2 .dc1 {top:40px; margin-left:354px;}
.evt2 .dc2 {top:665px; margin-left:-882px;}
.evt2 .dc3 {top:715px; margin-left:675px;}
.supuerbadVd {height:420px; padding:98px 20px 0; background-color:#ff9122;}
.supuerbadVd .inner {width:1140px; margin:0 auto;}
.supuerbadVd .video {position:relative; height:335px; z-index:50;}
.supuerbadVd .video .universal {position:absolute; bottom:0; left:0;}
</style>
<script type="text/javascript">
function goMinionsIns()
{
	<% If IsUserLoginOK() Then %>
		<% If not( left(now(),10)>="2017-07-06" and left(now(),10)<"2017-07-18" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
			<% if UserAppearChk > 0 then %>
				alert('이미 이벤트에 응모하셨습니다.');
				return false;
			<% else %>
				$.ajax({
					type:"GET",
					url:"/event/etc/doEventSubscript78751.asp?mode=ins",
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
										window.parent.$('html,body').animate({scrollTop:$("#tgmi").offset().top},300);
										$('.enteredLayer').show();
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
									parent.location.reload();
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
						parent.location.reload();
						return false;
					}
				});
			<% end if %>
		<% end if %>

	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
			return;
		}
		return false;
	<% End IF %>
}

$(function(){
	$(".enteredLayer .btnClose").click(function(){
		$(".enteredLayer").hide();
	});
	$(".enteredLayer").hide();
});
</script>

<div class="evt78751 superbad">
	<div class="head">
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/78751/tit_superbad.png" alt="슈퍼배드" /></h2>
		<p class="subcopy1"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78751/txt_sbcopy_1.png" alt="일루미네이션 제작" /></p>
		<p class="subcopy2"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78751/txt_sbcopy_2.png" alt="in 텐바이텐" /></p>
		<p class="subcopy3"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78751/txt_sbcopy_3.png" alt="텐바이텐과 영화 <슈퍼배드 3>의 만남! 이벤트에 참여하고, 다양한 상품을 받으세요!" /></p>
		<a href="/culturestation/" target="_blank" class="goCulStation"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78751/txt_cult_station.png" alt="컬쳐스테이션 더보기 Go" /></a>
		<a href="/culturestation/culturestation_event.asp?evt_code=3998" target="_blank" class="goMovieInfo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78751/txt_movie_info.png" alt="영화 정보가 궁금해? 보러가기" /></a>
		<span class="deco"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78751/img_superbad.jpg" alt="" /></span>
	</div>
	<div class="evt1">
		<div class="inner">
			<div class="txt ftLt"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78751/txt_evt_1.png" alt="이벤트 하나! 악당으로 변신! 귀여운 미니언들을   Click  해서  다크한 악당으로 변신시켜주세요! 텐바이텐과 영화 <슈퍼배드 3>가 준비한 특별한 선물을 드립니다. 기간은 2017년 7월7일 부터 7월 17일 까지 입니다. 발표일은 2017년 7월 19일" /></div>
			<div class="enter ftRt" id="tgmi">
				<button class="btnEnter" onclick="goMinionsIns();return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78751/btn_click.jpg" alt="Click! * 클릭시 자동 이벤트 응모 (하루에 한 번 참여 가능)" /></button>
				<div class="enteredLayer">
					<%' 7~16일 응모시 %>
					<% If nowdate >= "2017-07-06" And nowdate < "2017-07-17" Then %>
						<div>
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/78751/txt_completed_more.jpg" alt="응모완료! 변신완료! 이벤트에 응모되었습니다! 내일 또 응모하면 당첨 확률UP!" />
							<button type="button" class="btnClose">닫기</button>
						</div>
					<% End If %>
					<%' 17일 응모시 %>
					<% If nowdate = "2017-07-17" Then %>
						<div>
							<img src="http://webimage.10x10.co.kr/eventIMG/2017/78751/txt_completed.jpg" alt="응모완료! 변신완료! 이벤트에 응모되었습니다! 19일 당첨 발표를 기대해주세요!" />
							<button type="button" class="btnClose">닫기</button>
						</div>
					<% End If %>
				</div>
			</div>
		</div>
		<div class="gift">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/78751/tit_gift.png" alt="gift" /></h3>
			<ul>
				<li><img src="http://webimage.10x10.co.kr/eventIMG/2017/78751/img_gift_1.jpg" alt="선물 1 영화 <슈퍼배드 3> 전용 예매권 150명" /></li>
				<li><img src="http://webimage.10x10.co.kr/eventIMG/2017/78751/img_gift_2.jpg" alt="선물 2 영화 <슈퍼배드 3> 키링 or 마그넷 200명" /></li>
				<li><img src="http://webimage.10x10.co.kr/eventIMG/2017/78751/img_gift_3.jpg" alt="선물 3  영화 <슈퍼배드 3> 우산 50명" /></li>
			</ul>
		</div>
	</div>

	<div class="evt2">
		<div class="txt"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78751/txt_evt_2.png" alt="이벤트 두울! 배송박스 속 미니언을 찰칵! 추첨을 통해 30분께 기프트카드 1만원 권을 드립니다.   * '미니언 리플렛'은 텐바이텐 배송상품과 함께 배송되며 소진시 포함되지 않습니다." /> </div>
		<div class="conts">
			<img src="http://webimage.10x10.co.kr/eventIMG/2017/78751/txt_evt_2_conts.png" alt="1. 텐바이텐 배송 상품 쇼핑하기 2. 배송박스 속 ‘미니언’ 인증샷 찍기 3. 인스타그램 업로드 필수 포함 해시태그 #텐바이텐 #슈퍼배드3" />
			<a href="http://www.10x10.co.kr/event/eventmain.asp?eventid=79056" target="_blank" class="goShopping">텐바이텐 쇼핑하러 가기</a>
		</div>
		<span class="deco dc1"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78751/img_deco_1.png" alt="" /></span>
		<span class="deco dc2"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78751/img_deco_2.png" alt="" /></span>
		<span class="deco dc3 "><img src="http://webimage.10x10.co.kr/eventIMG/2017/78751/img_deco_3.png" alt="" /></span>
	</div>

	<div class="supuerbadVd">
		<div class="inner">
			<div class="video ftLt">
				<iframe width="545" height="306" src="https://www.youtube.com/embed/ekrJQ158oug" title="슈퍼배드3 예고편" frameborder="0" allowfullscreen=""></iframe>
				<span class="universal"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78751/txt_copy_right.png" alt="" /></span>
			</div>
			<div class="txt ftRt"><img src="http://webimage.10x10.co.kr/eventIMG/2017/78751/txt_video.png" alt="SYNOPSIS 전 세계를 점령할 놈들이 온다! 최고의 악당만을 보스로 섬기는 ‘미니언’ 가족을 위해 악당 은퇴를 선언한 ‘그루’ 그루의 배신에 실망한 미니언들은 스스로 악당이 되기 위해 그루를 떠난다. 한편, 같은 얼굴 다른 스펙의 쌍둥이 동생 ‘드루’의 등장으로 인해 그루는 자신이 역사상 가장 위대한 악당 가문의 후예임을 알게 되고, 거부할 수 없는 슈퍼배드의 운명을 따르게 되는데… " /></div>
		</div>
	</div>
</div>

<!-- #include virtual="/lib/db/dbclose.asp" -->
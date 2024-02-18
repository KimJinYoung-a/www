<!-- #include virtual="/lib/inc/incNaverOpenDate.asp" -->
<!-- #include virtual="/lib/inc/incDaumOpenDate.asp" -->
<%
	'외부 유입시 sns회원가입 유도 레이어 배너 - 2017-06-23 유태욱
	dim snsrdsite, joinurl
		snsrdsite = Left(request.Cookies("rdsite"), 10)
		joinurl	= request.ServerVariables("URL")
		if date() >= "2017-06-26" and date() < "2018-01-01" then
			If (Not IsUserLoginOK) Then
				If Not(IsGuestLoginOK) Then
					if instr(joinurl,"join.asp")< 1 then
						If snsrdsite = "fbec1" or snsrdsite = "fbec2" or snsrdsite = "fbec3" or snsrdsite = "fbec4" or snsrdsite = "Naverec" or snsrdsite = "nvshop" or snsrdsite = "nvcec" or snsrdsite = "daumkec" or snsrdsite = "googleec" or snsrdsite = "naverMec" or snsrdsite = "mdaumKec" or snsrdsite = "googleMec" or snsrdsite = "gdn" Then
							response.Cookies(snsrdsite).domain = "10x10.co.kr"
							if request.Cookies(snsrdsite)("mode") <> "x" then
								response.Cookies(snsrdsite)("mode") = "o"
%>
								<style type="text/css">
								.bnrNavSignUp {position:fixed; left:50%; top:50%; z-index:99999; width:550px; height:594px; margin:-205px 0 0 -275px;  font-size:11px; color:#999; background-color:#fff; border-top:6px #d50c0c solid;}
								.bnrNavSignUp .bntSignUp {width:240px; margin:0 auto 35px;}
								.bnrNavSignUp .bntSignUp .btnB3 {padding:18px 64px;}
								.bnrNavSignUp .todayNomore {display:table-cell; width:550px; height:30px; padding-right:22px; vertical-align:middle; border-top:1px solid #ddd; background-color:#f5f5f5; font-size:11px; line-height:11px; text-align:right; color:#777;}
								</style>
								<script type="text/javascript">
								$.ajax({
									url: "/member/actsnsLayerCont.asp",
									data: "snsrdsite=<%=snsrdsite%>",
									cache: false,
									success: function(rst) {
										$("#hBoxes").html(rst);
									}
								});
								$(document).ready(function(){
									var maskHeight = $(document).height();
									var maskWidth = $(document).width();
									$('#mask').css({'width':maskWidth,'height':maskHeight});
									$('#boxes').show();
									$('#mask').show();
									$('#mask').click(function(){
										$(".bnrNavSignUp").hide();
									});
								});
								</script>
<%
							end if
						end If
					end if
				end if
			end If
		end if
%>

<%
	'최초 rdsite가 nvshop이라면 
	If Left(request.Cookies("rdsite"), 6) = "nvshop" Then
		'nvshop이라는 쿠키가 비어있거나 쿠키 mode가 o가 아니면.. 
		'####모드 정리 : //디폴트 mode = o ////로그인&회원가입클릭 : mode = x////회원가입이나 기존회원이 로그인해서 쿠폰 받음 : mode= y #######
		If (isempty(request.Cookies("nvshop")("mode"))) OR ((request.Cookies("nvshop")("mode") <> "x") AND (request.Cookies("nvshop")("mode") <> "y")) Then
			'rdsite가 nvshop으로 넘어왔고 로그인,회원가입,1일간 안보기 세개 다 안 눌렀다는 전제..
			'nvshop이라는 쿠키생성
			'쿠키보관 기간은 1주일로..(쿠폰사용기간이 1주일이므로)
			response.Cookies("nvshop").domain = "10x10.co.kr"
			response.Cookies("nvshop")("mode") = "o"
			response.Cookies("nvshop").Expires = Date + 7
		End If

		'상품상세페이지나 메인페이지면서 로그인,회원가입,1일간 안보기 세개 다 안 눌렀고 쿠폰도 안 받았다면..
		'쿠키 변조를 한다해도 백단에 쿠폰 받은 여부확인해서 받았으면 안 보내게 처리
		'mode를 y로 바꾸는 곳 dologin.asp, nvshopCookie_process.asp, dojoin_step2.asp
		If (getThisURL = "/shopping/category_prd.asp" OR getThisURL = "/index.asp") AND (request.Cookies("nvshop")("mode") = "o") Then
			'쿠폰 사용기간 이라면..
			If isNaverOpen Then
				'파라메타 중에 itemid가 있다면
				If request("itemid") <> "" Then
					'로그인에서 backpath에 itemid를 넣음으로 메인페이지로 이동방지 이유
					Dim nvitemid
					nvitemid  = "?nvitemid="&request("itemid")
				End If
%>
		<style style="text/css">
		.nvshopCont {position:relative; width:562px; height:382px; padding-top:97px; text-align:center; background:url(http://webimage.10x10.co.kr/eventIMG/2014/naver/bg_layer.png) left top no-repeat;}
		.nvshopCont .lyrClose {right:24px; top:22px;}
		.nvshopCont p {color:#999; font-size:11px; line-height:1.438em;}
		.nvshopCont .symbol {padding:0 4px;}
		.nvshopCont .btnArea {padding-top:20px;}
		.nvshopCont .todayNomore {position:absolute; left:6px; bottom:8px; width:550px; padding:9px 0 8px; border-top:1px solid #ddd; background-color:#f5f5f5; font-size:11px; text-align:right;}
		.nvshopCont .todayNomore label {padding-right:23px;}
		.nvshopCont .closeArea .lyrClose {width:10px; height:10px; background:url(http://webimage.10x10.co.kr/eventIMG/2014/naver/btn_close_pc.png) left top no-repeat; text-indent:-999em; cursor:pointer;}
		#hBoxes .hWindow {position:fixed; _position:absolute; left:0; top:0; display:none; z-index:99999;}
		#hMask {display:none; position:absolute; left:0; top:0; z-index:90000; background:url(http://fiximage.10x10.co.kr/web2013/common/mask_bg.png) left top repeat;}
		</style>
		<script type="text/javascript">
		$.ajax({
			url: "/member/actnvshopLayerCont.asp<%=nvitemid%>",
			//url: "/member/actnvshopPayLayerCont.asp",
			cache: false,
			success: function(rst) {
				$("#hBoxes").html(rst);
			}
		});
		$(document).ready(function(){
		    if (document.sbagfrm){
		        if ((document.sbagfrm.itemid.value=="lg")||(document.sbagfrm.itemid.value=="one")){
		            document.sbagfrm.itemid.value='<%=request("itemid")%>';
		        }
		    }
		    
			var id = $(this).attr('href');
			var maskHeight = $(document).height();
			var maskWidth = $(window).width();

			$('#hMask').css({'width':maskWidth,'height':maskHeight});
			$('#hMask').show();

			var winH = $(window).height();
			var winW = $(window).width();

			$('#nvshopLyr').css('top', winH/2-$('#nvshopLyr').height()/2);
			$('#nvshopLyr').css('left', winW/2-$('#nvshopLyr').width()/2);
				$('#nvshopLyr').show();
			$('.nvshopCont .lyrClose').click(function (e) {
				e.preventDefault();
				$('#hMask').hide();
				$('.hWindow').hide();
			});
			$('#hMask').click(function () {
				$(this).hide();
				$('.hWindow').hide();
			});
			$(window).resize(function () {
				var box = $('#hBoxes .hWindow');
				var maskHeight = $(document).height();
				var maskWidth = $(window).width();
				$('#hMask').css({'width':maskWidth,'height':maskHeight});
				var winH = $(window).height();
				var winW = $(window).width();
				box.css('top', winH/2 - box.height()/2);
				box.css('left', winW/2 - box.width()/2);
			});
		});
		</script>
<%
			End If
		End If
	ElseIf Left(request.Cookies("rdsite"), 8) = "daumshop" Then
		'daumshop이라는 쿠키가 비어있거나 쿠키 mode가 o가 아니면.. 
		'####모드 정리 : //디폴트 mode = o ////로그인&회원가입클릭 : mode = x////회원가입이나 기존회원이 로그인해서 쿠폰 받음 : mode= y #######
		If (isempty(request.Cookies("daumshop")("mode"))) OR ((request.Cookies("daumshop")("mode") <> "x") AND (request.Cookies("daumshop")("mode") <> "y")) Then
			'rdsite가 daumshop으로 넘어왔고 로그인,회원가입,1일간 안보기 세개 다 안 눌렀다는 전제..
			'daumshop이라는 쿠키생성
			'쿠키보관 기간은 1주일로..(쿠폰사용기간이 1주일이므로)
			response.Cookies("daumshop").domain = "10x10.co.kr"
			response.Cookies("daumshop")("mode") = "o"
			response.Cookies("daumshop").Expires = Date + 7
		End If

		'상품상세페이지나 메인페이지면서 로그인,회원가입,1일간 안보기 세개 다 안 눌렀고 쿠폰도 안 받았다면..
		'쿠키 변조를 한다해도 백단에 쿠폰 받은 여부확인해서 받았으면 안 보내게 처리
		'mode를 y로 바꾸는 곳 dologin.asp, daumshopCookie_process.asp, dojoin_step2.asp
		If (getThisURL = "/shopping/category_prd.asp" OR getThisURL = "/index.asp") AND (request.Cookies("daumshop")("mode") = "o") Then
			'쿠폰 사용기간 이라면..
			If isDaumOpen Then
				'파라메타 중에 itemid가 있다면
				If request("itemid") <> "" Then
					'로그인에서 backpath에 itemid를 넣음으로 메인페이지로 이동방지 이유
					Dim daumitemid
					daumitemid  = "?daumitemid="&request("itemid")
				End If
%>
		<style style="text/css">
		.daumCont {position:relative; width:522px; height:359px; padding-top:73px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/naver/common/bg_layer_pc.png) 50% 0 no-repeat; text-align:center;}
		.daumCont .lyrClose {top:6px; right:6px;}
		.daumCont p {color:#999; font-size:11px; line-height:1.438em;}
		.daumCont .symbol {padding:0 4px;}
		.daumCont .btnArea {padding-top:20px;}
		.daumCont .btnArea .btnW220 {width:246px;}
		.daumCont .todayNomore {position:absolute; left:6px; bottom:6px; width:510px; padding:9px 0 8px; border-top:1px solid #ddd; background-color:#f5f5f5; font-size:11px; text-align:right;}
		.daumCont .todayNomore label {padding-right:23px;}
		.daumCont .closeArea .lyrClose {width:32px; height:32px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/naver/common/btn_close_pc.png) no-repeat 50% 50%; text-indent:-999em; cursor:pointer;}
		#hBoxes .hWindow {display:none; position:fixed; _position:absolute; left:0; top:0; z-index:99999;}
		#hMask {display:none; position:absolute; left:0; top:0; z-index:90000; background:url(http://fiximage.10x10.co.kr/web2013/common/mask_bg.png) repeat 0 0;}
		</style>
		<script type="text/javascript">
		$.ajax({
			url: "/member/actdaumshopLayerCont.asp<%=daumitemid%>",
			cache: false,
			success: function(rst) {
				$("#hBoxes").html(rst);
			}
		});
		$(document).ready(function(){
		    if (document.sbagfrm){
		        if ((document.sbagfrm.itemid.value=="lg")||(document.sbagfrm.itemid.value=="one")){
		            document.sbagfrm.itemid.value='<%=request("itemid")%>';
		        }
		    }
		    
			var id = $(this).attr('href');
			var maskHeight = $(document).height();
			var maskWidth = $(window).width();

			$('#hMask').css({'width':maskWidth,'height':maskHeight});
			$('#hMask').show();

			var winH = $(window).height();
			var winW = $(window).width();

			$('#lyDaum').css('top', winH/2-$('#lyDaum').height()/2);
			$('#lyDaum').css('left', winW/2-$('#lyDaum').width()/2);
				$('#lyDaum').show();
			$('.daumCont .lyrClose').click(function (e) {
				e.preventDefault();
				$('#hMask').hide();
				$('.hWindow').hide();
			});
			$('#hMask').click(function () {
				$(this).hide();
				$('.hWindow').hide();
			});
			$(window).resize(function () {
				var box = $('#hBoxes .hWindow');
				var maskHeight = $(document).height();
				var maskWidth = $(window).width();
				$('#hMask').css({'width':maskWidth,'height':maskHeight});
				var winH = $(window).height();
				var winW = $(window).width();
				box.css('top', winH/2 - box.height()/2);
				box.css('left', winW/2 - box.width()/2);
			});
		});
		</script>
<%
			End If
		End If
	End If
%>
<% If GetLoginUserLevel() <> "" Then %>
<% If GetLoginUserLevel() = "3" OR GetLoginUserLevel() = "4" Then %>
		<%
		If request.Cookies("hitchVIP")("mode") = "o" and IsUserLoginOK() Then
			Dim Hitchcode
			Hitchcode = request.Cookies("hitchVIP")("ecode")
			If request("eventid") <> Hitchcode Then
		 %>

				<style style="text/css">
				.hitchLyrCont {position:relative; width:566px; height:236px; padding-top:245px; text-align:center; color:#999; background:url(http://fiximage.10x10.co.kr/web2013/event/hitchhiker/vip_popup_bg_body.png) left top no-repeat;}
				.hitchLyrCont .lyrClose {right:24px; top:22px;}
				.hitchLyrCont .hitchBtn {padding-bottom:15px;}
				.hitchLyrCont .hitchBtn .btn {margin:0 3px; font-weight:500;}
				.hitchLyrCont .txt {color:#333; padding-bottom:15px;}
				.hitchLyrCont .txt strong {display:block; font-size:16px; line-height:1.4; padding-bottom:10px;}
				.hitchLyrCont .hitchFoot {position:absolute; width:520px; height:30px; line-height:30px; color:#fff; left:7px; bottom:9px; padding:0 15px; text-align:right; background:#3a3a3a;}
				.hitchLyrCont .hitchFoot span {padding-left:15px;}
				.hitchLyrCont .hitchFoot input {vertical-align:middle; margin:-2px 4px 0 0;}
		
				#hBoxes .hWindow {position:fixed; _position:absolute; left:0; top:0; display:none; z-index:99999;}
				#hMask {display:none; position:absolute; left:0; top:0; z-index:90000; background:url(http://fiximage.10x10.co.kr/web2013/common/mask_bg.png) left top repeat;}
				</style>
				<script type="text/javascript">
					<%
					'/히치하이커 메인페이지에서는 열지 않음		'2014.09.16 유태욱 추가
					if request.ServerVariables("SCRIPT_NAME")<>"/hitchhiker/index.asp" then
					%>
						$.ajax({
							url: "/member/actVipLayerCont.asp",
							cache: false,
							success: function(rst) {
								$("#hBoxes").html(rst);
							}
						});
					<% end if %>
			
					$(document).ready(function(){
			
						var id = $(this).attr('href');
						var maskHeight = $(document).height();
						var maskWidth = $(window).width();
			
						$('#hMask').css({'width':maskWidth,'height':maskHeight});
						$('#hMask').show();
			
						var winH = $(window).height();
						var winW = $(window).width();
			
						$('#hitchLyr').css('top', winH/2-$('#hitchLyr').height()/2);
						$('#hitchLyr').css('left', winW/2-$('#hitchLyr').width()/2);
							$('#hitchLyr').show();
			
			
						$('.hitchLyrCont .lyrClose').click(function (e) {
							e.preventDefault();
			
							$('#hMask').hide();
							$('.hWindow').hide();
						});
			
						$('#hMask').click(function () {
							$(this).hide();
							$('.hWindow').hide();
						});
			
						$(window).resize(function () {
							var box = $('#hBoxes .hWindow');
			
							var maskHeight = $(document).height();
							var maskWidth = $(window).width();
			
							$('#hMask').css({'width':maskWidth,'height':maskHeight});
			
							var winH = $(window).height();
							var winW = $(window).width();
			
							box.css('top', winH/2 - box.height()/2);
							box.css('left', winW/2 - box.width()/2);
						});
					});
				</script>
		<%
		 	End If
		End If
		%>
	<% If Now() > #12/17/2013 00:00:00# AND Now() < #01/07/2014 23:59:59# Then %>
	<%
		'If Now() > #12/17/2013 00:00:00# AND Now() < #01/31/2014 23:59:59# Then
		'### vip 캔들
		Dim vipchk, chk11
		vipchk = "SELECT count(*) FROM db_temp.dbo.tbl_user_VVip WHERE userid = '" & GetLoginUserID() & "' AND vvol='vol02'"
		rsget.Open vipchk,dbget,1
		IF Not rsget.Eof Then
			chk11 = rsget(0)
		End IF
		rsget.close

			If chk11=0 then
	%>
			<script>
			if(getCookie("popcandle") != "o"){
			    var pop_candle = window.open('/event/etc/pop_vip.asp','pop_candle','width=900px,height=472px');
			    pop_candle.focus();
			}
			</script>
	<%
			End If
		End IF
	%>

<% Else %>
	<% If GetLoginUserLevel() = "5" OR GetLoginUserLevel() = "0" OR GetLoginUserLevel() = "1" OR GetLoginUserLevel() = "2" OR GetLoginUserLevel() = "7" Then '### 상품후기쓰기 팝업 %>
		<% If Now() > #12/16/2013 00:00:00# AND Now() < #12/31/2013 23:59:59# Then %>
		<script>
		if(getCookie("pop131216") != "o"){
		    //var pop_20131216 = window.open('/event/etc/pop_itemeval.asp','pop_20131216','width=480px,height=350px');
		    //pop_20131216.focus();
		}
		</script>
		<% End If %>
	<% End If %>
<% End If %>
<% End If %>
<%'// 레드 썬데이%>
<% 
	If InStr(request.ServerVariables("URL"),"/") > 0 And InStr(Request.ServerVariables("QUERY_STRING"),"") <= 0 Then
	If Now() > #01/15/2018 00:00:00# AND Now() < #01/16/2018 23:59:59# Then 
	If request.Cookies("evt83578W")<>"x" then
%>
<script>
$(function(){
	// 레드 썬데이 전면배너
	var maskHeight = $(document).height();
	var maskWidth = $(document).width();
	$('#mask').css({'width':maskWidth,'height':maskHeight});
	$('#boxes').show();
	$('#mask').show();
	//$('.shockBnr').hide(); /* 팝업숨김 */
	$('#mask').click(function(){
		$(".front-Bnr").hide();
	});
	$('.front-Bnr .btnClose').click(function(){
		$(".front-Bnr").hide();
		$('#mask').hide();
	});

	//ie8 버전 이하 알림
	$('.version-noti .btn-close').click(function(){
		$(".version-noti").slideUp();
	});
});

function hideLayer83578W(){
	$(".front-Bnr").hide();
	$('#mask').hide();

    var todayDate = new Date('2018/01/16 23:59:59'); 
    document.cookie = "evt83578W=x; path=/; domain=10x10.co.kr; expires=" + todayDate.toGMTString() + ";" 
}
</script>
<style>
/* 레드 썬데이 */
.front-Bnr {position:fixed; left:50%; top:50%; z-index:99999; width:500px; height:500px; margin:-260px 0 0 -250px;}
.front-Bnr .btnGroup {position:absolute; top:500px; left:50%; margin-left:-250px; width:500px; height:40px; background-color:#ededed;}
.front-Bnr .btnClose {margin-right:-10px; padding:8px 30px 11px 0;}
.front-Bnr .btnClose button{margin-right:-10px; padding:5px 11px 3px 24px; background:#999 url(http://fiximage.10x10.co.kr/web2013/common/btn_close_popup.gif) 11px center no-repeat; font-family:Dotum; font-weight:normal;}
</style>
<div class="front-Bnr">
	<p><a href="/event/eventmain.asp?eventid=83578&gaparam=main_layerbanner_83578"><img src="http://webimage.10x10.co.kr/eventIMG/2018/83578/bnr_front.jpg" alt="레드 썬! 데이단 2일 마법에 걸린 특급세일" /></a></p>
	<div class="btnGroup">
		<div class="btnNomore ftLt tPad10 lPad20" onclick="hideLayer83578W();"><label><input type="checkbox" class="check" /> 다시보지 않기</label></div>
		<div class="btnClose ftRt"><button type="button" class="btn btnS1 btnGry2">닫기</button></div>
	</div>
</div>
<%'// 레드 썬데이 %>
<% End If %>
<% End If %>
<% End If %>
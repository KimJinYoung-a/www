<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
'### PLAY #25.TOY_KIDULT 
'### 2015-10-02 원승현
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
	Dim eCode, sqlstr, mycomcnt, totalcnt, myscent

	IF application("Svr_Info") = "Dev" THEN
		eCode   =  64903
	Else
		eCode   =  66569
	End If

	dim LoginUserid
	LoginUserid = getEncLoginUserid()

	''응모 이력 있는지 체크
	sqlstr = "select count(userid) as cnt "
	sqlstr = sqlstr & " from [db_event].[dbo].[tbl_event_subscript]"
	sqlstr = sqlstr & " where evt_code="& eCode &""
	sqlstr = sqlstr & " and userid='"& LoginUserid &"' "

	rsget.Open sqlstr, dbget, 1
	If Not rsget.Eof Then
		mycomcnt = rsget(0)
	End IF
	rsget.close

	''점수
	sqlstr = "select top 1 sub_opt2"
	sqlstr = sqlstr & " from [db_event].[dbo].[tbl_event_subscript]"
	sqlstr = sqlstr & " where evt_code="& eCode &""
	sqlstr = sqlstr & " and userid='"& LoginUserid &"' "

	rsget.Open sqlstr, dbget, 1
		If Not rsget.Eof Then
			myscent = rsget(0)
		End IF
	rsget.close

	''응모자 총 카운트
	sqlStr = "Select count(sub_idx) " &_
			" from [db_event].[dbo].[tbl_event_subscript] " &_
			" where evt_code="& eCode &" "
	rsget.Open sqlStr,dbget,1
	totalcnt = rsget(0)
	rsget.Close

%>

<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
img {vertical-align:top;}
.groundHeadWrap {width:100%; background:#ffe658;}
.groundCont {padding-bottom:0; text-align:center; background:url(http://webimage.10x10.co.kr/play/ground/20151005/bg_square02.gif) 0 0 repeat;}
.groundCont .grArea {width:100%;}
.groundCont .tagView {width:1100px; padding:0 20px 60px;}
.toyCont {position:relative; width:1140px; margin:0 auto;}
.playGr20150810 {overflow:hidden; text-align:center;}
.intro {height:953px; text-align:left; background:url(http://webimage.10x10.co.kr/play/ground/20151005/bg_square01.gif) 0 0 repeat;}
.intro .deco {display:block; position:absolute;}
.intro .title {position:absolute; left:587px; top:264px; width:428px; height:165px; text-align:center;}
.intro .title h2 span {display:inline-block; position:absolute; top:0; margin-top:-5px; opacity:0; filter: alpha(opacity=0);}
.intro .title h2 span.t01 {left:0;}
.intro .title h2 span.t02 {left:79px;}
.intro .title h2 span.t03 {left:146px;}
.intro .title h2 span.t04 {left:221px;}
.intro .title h2 span.t05 {left:310px;}
.intro .title h2 span.t06 {left:367px;}
.intro .title .d01 {left:-80px; top:-88px;}
.intro .title .d02 {right:-40px; top:-76px;}
.intro .title .zigzag {display:inline-block; position:absolute; left:0; bottom:0; width:0; height:39px; background:url(http://webimage.10x10.co.kr/play/ground/20151005/bg_zigzag.png) 0 0 no-repeat;}
.intro .purpose {overflow:hidden; position:absolute; left:587px; top:500px; height:0; opacity:0; filter: alpha(opacity=0);}
.intro .purpose p {margin-bottom:45px;}
.intro .mainPic {position:relative; width:580px; margin-left:-75px;}
.intro .mainPic .man p {position:absolute; left:0; top:0;}
.intro .mainPic .d01 {left:390px; top:30px; width:70px; height:52px; background:url(http://webimage.10x10.co.kr/play/ground/20151005/bg_deco_man02.png) 0 0 no-repeat;}
.intro .mainPic .d02 {left:-17px; bottom:354px; width:60px; height:39px; background:url(http://webimage.10x10.co.kr/play/ground/20151005/bg_deco_man01.png) 100% 0 no-repeat;}
.evtGuide {padding:50px 0; background:#00a4ba;}
.myKidultLevel {height:1011px; padding-top:204px; background:url(http://webimage.10x10.co.kr/play/ground/20151005/bg_test.jpg) 50% 0 no-repeat;}
.kidultTest {position:relative; width:1057px; height:677px; margin:0 auto 128px; background:url(http://webimage.10x10.co.kr/play/ground/20151005/bg_test_box.gif) 0 0 no-repeat;}
.kidultTest h3 {position:absolute; top:-38px; left:50%; margin-left:-193px; z-index:30;}
.kidultTest .btnNext {display:block; position:absolute; right:38px; top:292px; width:74px; height:75px; text-align:left; background: transparent url(http://webimage.10x10.co.kr/play/ground/20151005/btn_next.png) 0 0 no-repeat; text-indent:-9999px;}
.kidultTest .question {display:none; position:absolute; left:12px; top:12px; width:1033px; height:559px; padding-top:94px; background-position:50% 50%; background-repeat:no-repeat;}
.kidultTest .q01 {display:block; background-image:url(http://webimage.10x10.co.kr/play/ground/20151005/bg_question01.jpg);}
.kidultTest .q02 {background-image:url(http://webimage.10x10.co.kr/play/ground/20151005/bg_question02.jpg);}
.kidultTest .q03 {background-image:url(http://webimage.10x10.co.kr/play/ground/20151005/bg_question03.jpg);}
.kidultTest .q04 {background-image:url(http://webimage.10x10.co.kr/play/ground/20151005/bg_question04.jpg);}
.kidultTest .q05 {background-image:url(http://webimage.10x10.co.kr/play/ground/20151005/bg_question05.jpg);}
.kidultTest .q06 {background-image:url(http://webimage.10x10.co.kr/play/ground/20151005/bg_question06.jpg);}
.kidultTest .q07 {background-image:url(http://webimage.10x10.co.kr/play/ground/20151005/bg_question07.jpg);}
.kidultTest .q08 {background-image:url(http://webimage.10x10.co.kr/play/ground/20151005/bg_question08.jpg);}
.kidultTest .q09 {background-image:url(http://webimage.10x10.co.kr/play/ground/20151005/bg_question09.jpg);}
.kidultTest .q10 {background-image:url(http://webimage.10x10.co.kr/play/ground/20151005/bg_question10.jpg);}
.kidultTest .result {background:url(http://webimage.10x10.co.kr/play/ground/20151005/bg_result.gif) 0 240px repeat-x;background-size:2px 192px !important;}
.kidultTest .result .yourLevel {padding:70px 0 80px;}
.kidultTest .result .yourLevel strong {display:inline-block; overflow:hidden; height:75px; margin-bottom:38px;}
.kidultTest .result .yourLevel strong img {display:block; margin-top:75px;}
.kidultTest .result .yourLevel p {opacity:0; filter: alpha(opacity=0);}
.kidultTest .result .icoDown {padding-bottom:54px;}
.kidultTest .selectYN {padding-top:373px;}
.kidultTest .selectYN button {display:inline-block; position:relative; width:165px; height:70px; margin:0 15px; background-position:0 0; background-repeat:no-repeat; text-align:left; text-indent:-9999px; outline:none;}
.kidultTest .selectYN button em {display:none; position:absolute; left:-6px; bottom:-5px; width:177px; height:114px; background-position:0 0; background-repeat:no-repeat; z-index:110;}
.kidultTest .selectYN button.current em {display:block;}
.kidultTest .selectYN .yes {background-image:url(http://webimage.10x10.co.kr/play/ground/20151005/btn_yes.gif);}
.kidultTest .selectYN .no {background-image:url(http://webimage.10x10.co.kr/play/ground/20151005/btn_no.gif);}
.kidultTest .selectYN .yes em {background-image:url(http://webimage.10x10.co.kr/play/ground/20151005/bg_select_yes.png);}
.kidultTest .selectYN .no em {background-image:url(http://webimage.10x10.co.kr/play/ground/20151005/bg_select_no.png);}
.myKidultLevel .total {padding:65px 0; background:#ffd06e url(http://webimage.10x10.co.kr/play/ground/20151005/bg_slash.gif) 0 0 repeat;}
.myKidultLevel .total p {width:657px; height:51px; margin:0 auto; padding-top:25px; color:#fff; background:url(http://webimage.10x10.co.kr/play/ground/20151005/bg_total_box.png) 0 0 no-repeat;}
.myKidultLevel .total strong {font-size:30px; line-height:27px; padding:0 5px 0 14px; font-family:arial;}
.preview {height:429px; border-bottom:5px solid #e6e6e6; background:#ffd06e url(http://webimage.10x10.co.kr/play/ground/20151005/img_museum_preview.jpg) 50% 0 no-repeat;}
.museumInfo {padding:109px 0 148px;}
.museumInfo a {display:inline-block; position:absolute; top:89px; right:159px;}
@media all and (min-width:1920px){
	.preview {background-size:100% 429px;}
}
</style>
<script type="text/javascript">
$(function(){
	// YN 버튼 선택
	$('.selectYN button').click(function(){
		<% if Not(IsUserLoginOK) then %>
		    jsChklogin('<%=IsUserLoginOK%>');
		    return false;
		<% end if %>
		<% if not(left(now(), 10)>="2015-10-02" And left(now(), 10) < "2015-10-15") then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% end if %>

		$('.selectYN button').removeClass('current');
		$(this).addClass('current');
		$('.question').hide();
		$(this).parent('.selectYN').parent('.question').next('.question').show().animate({'opacity':'1',backgroundSize:'100%'}, 800);
	});

	// 테스트 결과
	$('.q10 .selectYN button').click(function(){
		<% if Not(IsUserLoginOK) then %>
		    jsChklogin('<%=IsUserLoginOK%>');
		    return false;
		<% end if %>
		<% if not(left(now(), 10)>="2015-10-02" And left(now(), 10) < "2015-10-15") then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% end if %>

		$.ajax({
			type:"GET",
			url:"/play/groundsub/doEventSubscript66569.asp",
	        data: $("#frmSbS").serialize(),
			dataType: "text",
			async:false,
			cache:true,
			success : function(Data, textStatus, jqXHR){
				if (jqXHR.readyState == 4) {
					if (jqXHR.status == 200) {
						if(Data!="") {
							var str;
							for(var i in Data)
							{
								 if(Data.hasOwnProperty(i))
								{
									str += Data[i];
								}
							}
							str = str.replace("undefined","");
							res = str.split("|");
							if (res[0]=="OK")
							{
								//if($(".kidultTest .result").css("display") == "block"){
									$("#result"+res[1]).show();
									$("#resultLink"+res[1]).show();
									$('.yourLevel strong img').delay(150).animate({"margin-top":"0"}, 900);
									$('.yourLevel p').delay(1100).animate({"opacity":"1"}, 700).effect("pulsate", {times:2},300);
								//}

							}
							else
							{
								errorMsg = res[1].replace(">?n", "\n");
								alert(errorMsg );
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
	});

	//animation
	function intro() {
		conChk = 1;
		$('.intro h2 span.t01').animate({"margin-top":"5px","opacity":"1"},600).animate({"margin-top":"0"},300);
		$('.intro h2 span.t02').delay(200).animate({"margin-top":"5px","opacity":"1"},600).animate({"margin-top":"0"},300);
		$('.intro h2 span.t03').delay(400).animate({"margin-top":"5px","opacity":"1"},600).animate({"margin-top":"0"},300);
		$('.intro h2 span.t04').delay(600).animate({"margin-top":"5px","opacity":"1"},600).animate({"margin-top":"0"},300);
		$('.intro h2 span.t05').delay(300).animate({"margin-top":"5px","opacity":"1"},600).animate({"margin-top":"0"},300);
		$('.intro h2 span.t06').delay(500).animate({"margin-top":"5px","opacity":"1"},600).animate({"margin-top":"0"},300);
		$('.title .zigzag').animate({"width":"428px"}, 2800);

		$('.intro .mainPic .man p').delay(2500).animate({"opacity":"0"},600);
		$('.intro .purpose').delay(2700).animate({"height":"250px","opacity":"1"},1700);
	}
	$('.kidultTest .question').css('background-size','60%');

	var conChk = 0;
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 300 ) {
			if (conChk==0){
				intro();
			}
		}
		if (scrollTop > 1800 ) {
			$('.kidultTest .q01').animate({'opacity':'1',backgroundSize:'100%'}, 800);
			$('.kidultTest .frame').animate({"opacity":"0"},1000);
		}
	});

	<% if mycomcnt > 0 then %>
		<% if IsUserLoginOK then %>
			$(".kidultTest .q01").hide();
			$('.yourLevel strong img').delay(150).animate({"margin-top":"0"}, 900);
			$('.yourLevel p').delay(1100).animate({"opacity":"1"}, 700).effect("pulsate", {times:2},300);
			$(".kidultTest .result").show();
			$("#result<%=myscent%>").show();
			$("#resultLink<%=myscent%>").show();
		<% end if %>
	<% end if %>
});


function fnAnswerChk(qNo, Ans)
{
	if (qNo=="1")
	{
		$("#qAnswer").val(Ans);
	}
	else
	{
		$("#qAnswer").val($("#qAnswer").val().substr(0, qNo-1));
		$("#qAnswer").val($("#qAnswer").val()+Ans);
		if (!$("#qAnswer").val().length==qNo)
		{
			alert("순서대로 TEST에 응모해주세요.");
			return false;
		}
	}
}
</script>
<%' 수작업 영역 시작 %>
<div class="groundCont">
	<div class="grArea"> 
		<!-- TOY #1 -->
		<div class="playGr20151005">
			<div class="intro">
				<div class="toyCont">
					<div class="title">
						<h2>
							<span class="t01"><img src="http://webimage.10x10.co.kr/play/ground/20151005/tit_k.png" alt="k" /></span>
							<span class="t02"><img src="http://webimage.10x10.co.kr/play/ground/20151005/tit_i.png" alt="i" /></span>
							<span class="t03"><img src="http://webimage.10x10.co.kr/play/ground/20151005/tit_d.png" alt="d" /></span>
							<span class="t04"><img src="http://webimage.10x10.co.kr/play/ground/20151005/tit_u.png" alt="u" /></span>
							<span class="t05"><img src="http://webimage.10x10.co.kr/play/ground/20151005/tit_l.png" alt="l" /></span>
							<span class="t06"><img src="http://webimage.10x10.co.kr/play/ground/20151005/tit_t.png" alt="t" /></span>
						</h2>
						<span class="zigzag"></span>
						<span class="deco d01 toggleA"><img src="http://webimage.10x10.co.kr/play/ground/20151005/bg_deco_drop.png" alt="" /></span>
						<span class="deco d02 toggleB"><img src="http://webimage.10x10.co.kr/play/ground/20151005/bg_deco_star.png" alt="" /></span>
					</div>
					<div class="purpose">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20151005/txt_purpose01.png" alt="아이의 감성과 취향을 간직한 어른을 키덜드(KIDULT)라고 합니다. 어린 시절 가지고 놀던 작은 장난감부터 진짜 같은 장난감까지 그 영역은 폭넓고 다양합니다." /></p>
						<p><img src="http://webimage.10x10.co.kr/play/ground/20151005/txt_purpose02.png" alt="키덜트 문화는 어쩌면 어른이 되어가며 탁해진 마음에 순수함을 되살려내고, 각박한 일상에서 벗어나 감성적이고 재미있는 삶을 찾기 위해 생겨났을지도 모르겠습니다." /></p>
						<p><img src="http://webimage.10x10.co.kr/play/ground/20151005/txt_purpose03.png" alt="여기 몇 가지 테스트를 통해 여러분의 '키덜트 지수'를 알아보세요! 당신은 아직 동심을 간직한 어른아이인가요?" /></p>
					</div>
					<div class="mainPic">
						<div class="man">
							<img src="http://webimage.10x10.co.kr/play/ground/20151005/img_man.png" alt="" />
							<p><img src="http://webimage.10x10.co.kr/play/ground/20151005/img_man_gray.png" alt="" /></p>
						</div>
						<span class="deco d01 toggleA"></span>
						<span class="deco d02 toggleC"></span>
					</div>
				</div>
			</div>
			<div class="evtGuide"><img src="http://webimage.10x10.co.kr/play/ground/20151005/txt_your_level.png" alt="재미있는 테스트를 통해 당신의 키덜트지수를 알아보세요!" /></div>
			<%' 키덜트지수 테스트 %>
			<div class="myKidultLevel">
				<div class="kidultTest">
					<h3><img src="http://webimage.10x10.co.kr/play/ground/20151005/tit_kidult_test.png" alt="KIDULT TEST" /></h3>
					<%' 테스트 문항 Q01~Q10 %>
					<div class="question q01">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20151005/txt_question01.gif" alt="1. 나에게 토이는 취미생활 이상의 큰 의미를 가지고 있다" /></p>
						<div class="selectYN">
							<button class="yes" onclick="fnAnswerChk('1','Y');return false;"><em></em>Y</button>
							<button class="no" onclick="fnAnswerChk('1','N');return false;"><em></em>N</button>
						</div>
					</div>
					<div class="question q02">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20151005/txt_question02.gif" alt="2. 피규어 또는 장난감을 위한 장식장/선반이 따로 준비되어 있다" /></p>
						<div class="selectYN">
							<button class="yes" onclick="fnAnswerChk('2','Y');return false;"><em></em>Y</button>
							<button class="no" onclick="fnAnswerChk('2','N');return false;"><em></em>N</button>
						</div>
					</div>
					<div class="question q03">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20151005/txt_question03.gif" alt="3. 수집하는 나만의 컬렉션이 있다" /></p>
						<div class="selectYN">
							<button class="yes" onclick="fnAnswerChk('3','Y');return false;"><em></em>Y</button>
							<button class="no" onclick="fnAnswerChk('3','N');return false;"><em></em>N</button>
						</div>
					</div>
					<div class="question q04">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20151005/txt_question04.gif" alt="4. 키덜트 페어 또는 토이 관련 전시는 필수 관람한다" /></p>
						<div class="selectYN">
							<button class="yes" onclick="fnAnswerChk('4','Y');return false;"><em></em>Y</button>
							<button class="no" onclick="fnAnswerChk('4','N');return false;"><em></em>N</button>
						</div>
					</div>
					<div class="question q05">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20151005/txt_question05.gif" alt="5. 수입의 절반 이상을 장난감을 구매하는데 쓴다" /></p>
						<div class="selectYN">
							<button class="yes" onclick="fnAnswerChk('5','Y');return false;"><em></em>Y</button>
							<button class="no" onclick="fnAnswerChk('5','N');return false;"><em></em>N</button>
						</div>
					</div>
					<div class="question q06">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20151005/txt_question06.gif" alt="6. 각종 만화/영화의 캐릭터나 세계관을 정확히 알고있다" /></p>
						<div class="selectYN">
							<button class="yes" onclick="fnAnswerChk('6','Y');return false;"><em></em>Y</button>
							<button class="no" onclick="fnAnswerChk('6','N');return false;"><em></em>N</button>
						</div>
					</div>
					<div class="question q07">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20151005/txt_question07.gif" alt="7. 새로나올 토이의 발매일 및 정보를 꿰고 있다" /></p>
						<div class="selectYN">
							<button class="yes" onclick="fnAnswerChk('7','Y');return false;"><em></em>Y</button>
							<button class="no" onclick="fnAnswerChk('7','N');return false;"><em></em>N</button>
						</div>
					</div>
					<div class="question q08">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20151005/txt_question08.gif" alt="8. 주기적으로 방문하는 토이 관련 샵이 있다" /></p>
						<div class="selectYN">
							<button class="yes" onclick="fnAnswerChk('8','Y');return false;"><em></em>Y</button>
							<button class="no" onclick="fnAnswerChk('8','N');return false;"><em></em>N</button>
						</div>
					</div>
					<div class="question q09">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20151005/txt_question09.gif" alt="9. 원하는 캐릭터가 나올 때까지 미스터리 피규어를 사 본 적이 있다." /></p>
						<div class="selectYN">
							<button class="yes" onclick="fnAnswerChk('9','Y');return false;"><em></em>Y</button>
							<button class="no" onclick="fnAnswerChk('9','N');return false;"><em></em>N</button>
						</div>
					</div>
					<div class="question q10">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20151005/txt_question10.gif" alt="10. 토이는 오롯이 나를 위해 구매하고 수집한다." /></p>
						<div class="selectYN">
							<button class="yes" onclick="fnAnswerChk('10','Y');return false;"><em></em>Y</button>
							<button class="no" onclick="fnAnswerChk('10','N');return false;"><em></em>N</button>
						</div>
					</div>
					<%'// 테스트 문항 Q01~Q10 %>
					<%' 테스트 결과 %>
					<div class="question result">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20151005/txt_level_is.gif" alt="당신의 키덜트 지수는" /></p>
						<div class="yourLevel">
							<%' 100% %>
							<div id="result100" style="display:none;">
								<strong><img src="http://webimage.10x10.co.kr/play/ground/20151005/txt_level_100.png" alt="100%" /></strong>
								<p><img src="http://webimage.10x10.co.kr/play/ground/20151005/txt_result_100.png" alt="완벽한 키덜트족이시군요! 혹시 찾으시던 토이가 텐바이텐에 숨어 있을지도 몰라요!" /></p>
							</div>

							<%' 80% %>
							<div id="result80" style="display:none;">
								<strong><img src="http://webimage.10x10.co.kr/play/ground/20151005/txt_level_80.png" alt="80%" /></strong>
								<p><img src="http://webimage.10x10.co.kr/play/ground/20151005/txt_result_80.png" alt="본인만의 장난감 컬렉션을 어느 정도 가지고 계시는 군요! 그 컬렉션에 걸맞은 장식장이나 케이스를 준비해보세요!" /></p>
							</div>

							<%' 40% %>
							<div id="result40" style="display:none;">
								<strong><img src="http://webimage.10x10.co.kr/play/ground/20151005/txt_level_40.png" alt="40%" /></strong>
								<p><img src="http://webimage.10x10.co.kr/play/ground/20151005/txt_result_40.png" alt="아직은 입문단계의 키덜트족이시군요! 자 조금 더 예쁜 아가들을 만나보세요!" /></p>
							</div>

							<!-- 20% -->
							<div id="result20" style="display:none;">
								<strong><img src="http://webimage.10x10.co.kr/play/ground/20151005/txt_level_20.png" alt="20%" /></strong>
								<p><img src="http://webimage.10x10.co.kr/play/ground/20151005/txt_result_20.png" alt="키덜트 문화는 알고있지만 자주 구매를 하거나 수집하는 편은 아니시군요! 하지만 때로는 귀여운 토이 하나가 기분을 바꿔줄 수도 있어요!" /></p>
							</div>
						</div>
						<p class="icoDown"><img src="http://webimage.10x10.co.kr/play/ground/20151005/ico_down.gif" alt="" /></p>
						<div id="resultLink100" style="display:none">
							<a href="/event/eventmain.asp?eventid=66614#event_namelink4" target="_blank"><img src="http://webimage.10x10.co.kr/play/ground/20151005/btn_10x10_toy.gif" alt="10X10 토이 보러가기" /></a>
						</div>
						<div id="resultLink80" style="display:none">
							<a href="/event/eventmain.asp?eventid=66614#event_namelink3" target="_blank"><img src="http://webimage.10x10.co.kr/play/ground/20151005/btn_10x10_toy.gif" alt="10X10 토이 보러가기" /></a>
						</div>
						<div id="resultLink40" style="display:none">
							<a href="/event/eventmain.asp?eventid=66614#event_namelink2" target="_blank"><img src="http://webimage.10x10.co.kr/play/ground/20151005/btn_10x10_toy.gif" alt="10X10 토이 보러가기" /></a>
						</div>
						<div id="resultLink20" style="display:none">
							<a href="/event/eventmain.asp?eventid=66614#event_namelink1" target="_blank"><img src="http://webimage.10x10.co.kr/play/ground/20151005/btn_10x10_toy.gif" alt="10X10 토이 보러가기" /></a>
						</div>
					</div>
					<!-- 테스트 결과 -->
				</div>
				<div class="total">
					<p>
						<img src="http://webimage.10x10.co.kr/play/ground/20151005/txt_total01.png" alt="총" />
						<strong><%=FormatNumber(totalcnt, 0)%></strong>
						<img src="http://webimage.10x10.co.kr/play/ground/20151005/txt_total02.png" alt="명이 키덜트 지수를 테스트했습니다." />
					</p>
				</div>
			</div>
			<!--// 키덜트지수 테스트 -->
			<div class="preview"></div>
			<div class="museumInfo">
				<div class="toyCont">
					<div style="margin-left:-100px;"><img src="http://webimage.10x10.co.kr/play/ground/20151005/txt_museum.png" alt="어른들의 즐거운 놀이터 피규어뮤지엄W" /></div>
					<a href="http://www.figuremuseumw.co.kr/" target="_blank"><img src="http://webimage.10x10.co.kr/play/ground/20151005/btn_go_homepage.png" alt="홈페이지 바로가기" /></a>
				</div>
			</div>
		</div>
		<!-- // TOY #1 -->

<%' 수작업 영역 끝 %>
<form method="post" name="frmSbS" id="frmSbS">
	<input type="hidden" name="qAnswer" id="qAnswer">
	<input type="hidden" name="mode" value="add">
</form>

<!-- #include virtual="/lib/db/dbclose.asp" -->
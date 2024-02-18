<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
'### 14주년 이벤트 그것이 알고싶다. 
'### 2015-10-06 원승현
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
	Dim eCode, sqlstr, myanswer, renloop, myfolderCnt

	IF application("Svr_Info") = "Dev" THEN
		eCode   =  64909
	Else
		eCode   =  66518
	End If

	dim LoginUserid
	LoginUserid = getEncLoginUserid()


	''응모 이력이 있으면 입력된 TYPE숫자 가져옴.
	sqlstr = "select top 1 sub_opt2 "
	sqlstr = sqlstr & " from [db_event].[dbo].[tbl_event_subscript]"
	sqlstr = sqlstr & " where evt_code="& eCode &""
	sqlstr = sqlstr & " and userid='"& LoginUserid &"' And convert(varchar(10), regdate, 120) = '"&Left(now(), 10)&"' "
	rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly
	If Not rsget.Eof Then
		myanswer = rsget(0)
	Else
		myanswer = ""
	End IF
	rsget.close


	'현재 로그인한 유저의 폴더갯수 체크
	sqlstr = " SELECT count(userid) FROM [db_my10x10].[dbo].[tbl_myfavorite_folder] WHERE UserID = '"&LoginUserid&"' "
	rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly
		myfolderCnt = rsget(0)
	rsget.close

	randomize
	renloop=int(Rnd*4)+1
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
.curiousCont {position:relative; width:1140px; margin:0 auto;}
.curiousHead {height:370px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/bg_head.gif) repeat 0 0;}
.curiousHead .title {position:relative; width:681px; margin:0 auto; background:url(http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/bg_triangle.png) repeat 0 0;}
.curiousHead .title h3 {position:relative; width:654px; height:115px;}
.curiousHead .title h3 span {display:inline-block; position:absolute; left:0; top:0; opacity:0; filter: alpha(opacity=0);}
.curiousHead .title h3 span.t01 {margin-left:-15px;}
.curiousHead .title h3 span.t02 {margin-left:15px;}
.curiousHead .title .tag {position:absolute; right:-110px; top:49px; z-index:30;opacity:0; filter: alpha(opacity=0);}
.curiousHead .title .qMark {position:absolute; left:262px; top:27px;  z-index:50;}
.curiousHead .only {position:absolute; right:25px; top:25px;}
.curiousHead .copy {padding:97px 0 10px;}
.curiousHead .desc {padding-top:24px;}
.curiousContent {position:relative; padding:70px 0 90px; border-bottom:4px solid #e6b224; background:#ffd236 url(http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/ico_down.gif) no-repeat 50% 0;}
.myShoppingSt {position:relative; width:940px; height:850px; padding:50px 60px 0; margin:0 auto; background:url(http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/bg_paper.png) repeat 0 0;}
.myShoppingSt .question {position:absolute; left:60px; top:50px;}
.myShoppingSt .step {position:absolute; right:3px; top:20px;}
.myShoppingSt .situation {padding-bottom:29px; margin-bottom:20px; text-align:left; border-bottom:2px solid #f5f5f5;}
.myShoppingSt .selectAB {padding:50px 0 48px; border-bottom:2px solid #f5f5f5; background:url(http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/txt_vs.gif) no-repeat 50% 50%;}
.myShoppingSt .selectAB .button {display:inline-block; width:400px; height:80px; font-size:16px; line-height:80px; text-indent:15px; color:#555; font-weight:bold; font-family:dotum;background:transparent url(http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/bg_select.gif) no-repeat 0 0; vertical-align:top; text-decoration:none;}
.myShoppingSt .selectAB .answerA {margin-right:48px;}
.myShoppingSt .selectAB .answerB {margin-left:48px; background-position:0 -80px;}
.myShoppingSt .selectAB .button.current {color:#fff; background-position:0 -160px !important;}
.evtNoti {padding:56px 0 70px; text-align:left; background:url(http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/bg_notice.gif) repeat 0 0;}
.evtNoti .curiousCont {width:1052px; padding-left:88px;}
.evtNoti ul {padding:26px 0 0 11px;}
.evtNoti li {font-size:12px; color:#555; line-height:13px; padding:0 0 10px 14px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/blt_round.png) no-repeat 0 2px;}
.myShoppingSt .viewResult {overflow:hidden; left:30px; top:-30px; width:988px; padding:6px; z-index:100; background:#ddd;}
.myShoppingSt .selectItem {position:relative; padding:40px 44px 25px; background:#fff; text-align:left;}
.myShoppingSt .selectItem .selectAll {position:absolute; right:51px; top:43px; color:#777;}
.myShoppingSt .selectItem .pdtWrap {margin-top:0; padding-bottom:0; background:none;}
.myShoppingSt .selectItem .pdt150V15 .pdtList {width:908px; margin-top:20px; padding:0 0 5px 26px; background:url(http://fiximage.10x10.co.kr/web2015/common/line_pdtlist.gif) 0 0 repeat-x;}
.myShoppingSt .selectItem .pdt150V15 .pdtList > li {position:relative; width:205px; padding:20px 0 0 22px; background:none;}
.myShoppingSt .selectItem .pdt150V15 .check {position:absolute; left:0; top:20px; z-index:10; margin:0;}
.myShoppingSt .selectItem .pdt150V15 .pdtBox {width:150px; height:202px; margin:0;}
.myShoppingSt .selectItem .pdtName {min-height:12px; padding-top:7px; text-overflow:ellipsis; white-space:nowrap; overflow:hidden;}
.myShoppingSt .putMywish {padding:25px 65px 24px; text-align:center; background:url(http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/bg_notice.gif) repeat 0 0;}
.myShoppingSt .putMywish .tip {color:#777; padding-top:25px; margin-top:23px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/bg_line.gif) repeat-x 0 0;}
.mask {position:absolute; left:0; top:0; width:100%; height:100%;background:rgba(0,0,0,.5); z-index:90;}
</style>
<script type="text/javascript">
$(function(){
	$('.mask').hide();
	$('.myShoppingSt .question').hide();
	$('.myShoppingSt .q01').show();
	
	// AB 버튼 선택
	$('.selectAB button').click(function(){
		<% if Not(IsUserLoginOK) then %>
		    jsChklogin('<%=IsUserLoginOK%>');
		    return false;
		<% end if %>
		<% if not(left(now(), 10)>="2015-10-07" And left(now(), 10) < "2015-10-27") then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% end if %>


		$('.selectAB button').removeClass('current');
		$(this).addClass('current');
		$('.question').delay(180).fadeOut(180);
		$(this).parent('.selectAB').parent('.qCont').parent('.question').next('.question').fadeIn(100);
	});


	$('.q05 .selectAB button').click(function(){
		<% if Not(IsUserLoginOK) then %>
		    jsChklogin('<%=IsUserLoginOK%>');
		    return false;
		<% end if %>
		<% if not(left(now(), 10)>="2015-10-07" And left(now(), 10) < "2015-10-27") then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% end if %>

		$.ajax({
			type:"GET",
			url:"/event/14th/shoppingStyleProc.asp",
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
								$("#viewResultImg").attr("src", "http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/txt_result0"+res[1]+".gif");
								fnGetPdList(res[1]);
								$("#vResultVal").fadeIn(100);
								window.parent.$('html,body').animate({scrollTop:950}, 300);
								$('.mask').fadeIn(100);
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


	if($(".myShoppingSt .viewResult").is(":hidden")){
		$('.mask').hide();
	}else{
		$('.mask').show();
	};

	//animation
	function title() {
		$('.title .t01').animate({"margin-left":"0","opacity":"1"},500);
		$('.title .t02').delay(400).animate({"margin-left":"0","opacity":"1"},500);
		$('.title .tag').delay(1000).animate({"opacity":"1"},400);
	}
	
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 100 ) {
			title();
		}
	});

	$("#sAll").click(function()
	{
		if($("#sAll").prop("checked")) {
			$(":checkbox[name=pdFavChk]").prop("checked",true);
		} else {
			$(":checkbox[name=pdFavChk]").prop("checked",false);
		}
	});


	<% if myanswer <> "" then %>
		<% if IsUserLoginOK then %>
			$("#vResultVal").show();
			$("#viewResultImg").attr("src", "http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/txt_result0<%=trim(myanswer)%>.gif");
			fnGetPdList("<%=trim(myanswer)%>");
			$('.mask').fadeIn(100);
			window.parent.$('html,body').animate({scrollTop:950}, 300);
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

function fnGetPdList(vType)
{
	var rstStr = $.ajax({
		type: "GET",
		url: "/event/14th/shoppingStyle_Type"+vType+".asp",
		data: "",
		dataType: "text",
		async: false
	}).responseText;
	$("#vResultList").empty().html(rstStr);
}

function goInsWishData()
{

	<% if Not(IsUserLoginOK) then %>
		jsChklogin('<%=IsUserLoginOK%>');
		return false;
	<% end if %>
	<% if not(left(now(), 10)>="2015-10-07" And left(now(), 10) < "2015-10-27") then %>
		alert("이벤트 응모 기간이 아닙니다.");
		return false;
	<% end if %>

	if (!$(":checkbox[name=pdFavChk]").is(":checked"))
	{
		alert("상품을 체크해주세요.");
		return false;
	}

	<% if myfolderCnt>=19 then %>
		alert("위시폴더의 개수가 초과되었습니다.\n위시폴더를 삭제 후 응모해주세요.");
		return false;
	<% end if %>


	var chked_val = "";

	$(":checkbox[name='pdFavChk']:checked").each(function(pi,po){
		chked_val += ","+po.value;
	});

	$("#qWishItems").val(chked_val)

	$.ajax({
		type:"GET",
		url:"/event/14th/shoppingStyleProc.asp",
		data: $("#frmSbSPrd").serialize(),
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
							okMsg = res[1].replace(">?n", "\n");
							alert(okMsg);
							top.location.href="/my10x10/mywishlist.asp";
							return false;
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

}

</script>
</head>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt">
		<div id="contentWrap">
			<div class="eventWrapV15">
				<div class="eventContV15">
					<div class="contF contW">
						<%' [66518] 그것이 알고싶다%>
						<div class="anniversary14th">
							<%' 14th common : header & nav %>
							<!-- #include virtual="/event/14th/header.asp" -->
							<div class="curiousThat">
								<div class="curiousHead">
									<div class="curiousCont">
										<span class="only"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/tag_only.png" alt="10X10 ONLY" /></span>
										<p class="copy"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/txt_copy.png" alt="그동안 궁금했던 당신의 쇼핑 스타일" /></p>
										<div class="title">
											<h3>
												<span class="t01"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/tit_curious01.png" alt="그것이" /></span>
												<span class="t02"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/tit_curious02.png" alt="알고싶다" /></span>
											</h3>
											<span class="tag"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/tit_tag.png" alt="쇼핑편" /></span>
											<span class="qMark"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/ico_question.png" alt="" /></span>
										</div>
										<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/txt_check_your_style.png" alt="당신의 쇼핑스타일을 알아보세요! 추첨을 통해, 하루 50명에게 기프트카드 1만원권을 드립니다. 지금 바로 참여하세요" /></p>
									</div>
								</div>
								<div class="curiousContent">
									<div class="myShoppingSt">
										<div class="question q01">
											<p class="step"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/txt_step01.gif" alt="" /></p>
											<%' 4가지 중 랜덤 노출(q01A~D)%>
											<% If renloop = "1" Then %>
												<div class="qCont q01A">
													<p class="situation"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/txt_situation01_01.gif" alt="음식점에 갔다. 메뉴가 많은데 과연 무엇을 선택할 것인가?" /></p>
													<div class="pic"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/img_question01_01.gif" alt="" /></div>
													<div class="selectAB">
														<button class="button answerA" onclick="fnAnswerChk('1','A');return false;">오늘의 요리를 먹는다</button>
														<button class="button answerB" onclick="fnAnswerChk('1','B');return false;">베스트 요리를 먹는다</button>
													</div>
												</div>
											<% End If %>

											<% If renloop = "2" Then %>
												<div class="qCont q01B">
													<p class="situation"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/txt_situation01_02.gif" alt="당신은 드라마 광팬! 드라마를 보는 당신의 방법은?" /></p>
													<div class="pic"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/img_question01_02.gif" alt="" /></div>
													<div class="selectAB">
														<button class="button answerA" onclick="fnAnswerChk('1','A');return false;">무조건 본방사수</button>
														<button class="button answerB" onclick="fnAnswerChk('1','B');return false;">다시보기를 이용한다</button>
													</div>
												</div>
											<% End If %>

											<% If renloop = "3" Then %>
												<div class="qCont q01C">
													<p class="situation"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/txt_situation01_03.gif" alt="라면을 먹기 위한 당신만의 조리법은?" /></p>
													<div class="pic"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/img_question01_03.gif" alt="" /></div>
													<div class="selectAB">
														<button class="button answerA" onclick="fnAnswerChk('1','A');return false;">스프 먼저 넣고 끓인다</button>
														<button class="button answerB" onclick="fnAnswerChk('1','B');return false;">면부터 넣고 끓인다</button>
													</div>
												</div>
											<% End If %>
											
											<% If renloop = "4" Then %>
												<div class="qCont q01D">
													<p class="situation"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/txt_situation01_04.gif" alt="애인의 생일! 어떤 선물을 할 것 인가?" /></p>
													<div class="pic"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/img_question01_04.gif" alt="" /></div>
													<div class="selectAB">
														<button class="button answerA" onclick="fnAnswerChk('1','A');return false;">종이학 1000마리</button>
														<button class="button answerB" onclick="fnAnswerChk('1','B');return false;">명품가방</button>
													</div>
												</div>
											<% End If %>
										</div>
										<div class="question q02">
											<p class="step"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/txt_step02.gif" alt="" /></p>
											<div class="qCont">
												<p class="situation"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/txt_situation02.gif" alt="길을 가다가 돈을 주운 당신! 다음 행동은?" /></p>
												<div class="pic"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/img_question02.gif" alt="" /></div>
												<div class="selectAB">
													<button class="button answerA" onclick="fnAnswerChk('2','A');return false;">은행에 저금한다</button>
													<button class="button answerB" onclick="fnAnswerChk('2','B');return false;">바로 쇼핑을 한다</button>
												</div>
											</div>
										</div>
										<div class="question q03">
											<p class="step"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/txt_step03.gif" alt="" /></p>
											<div class="qCont">
												<p class="situation"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/txt_situation03.gif" alt="백화점에서 3시간 동안 쇼핑한 당신, 빈 손으로 나왔다. 왜~?" /></p>
												<div class="pic"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/img_question03.gif" alt="" /></div>
												<div class="selectAB">
													<button class="button answerA" onclick="fnAnswerChk('3','A');return false;">결정 내리기가 어려워서</button>
													<button class="button answerB" onclick="fnAnswerChk('3','B');return false;">인터넷에서 검색 후 구매</button>
												</div>
											</div>
										</div>
										<div class="question q04">
											<p class="step"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/txt_step04.gif" alt="" /></p>
											<div class="qCont">
												<p class="situation"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/txt_situation04.gif" alt="곧 출시 예정인 아이퐁! 당신의 구매 방법은?" /></p>
												<div class="pic"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/img_question04.gif" alt="" /></div>
												<div class="selectAB">
													<button class="button answerA" onclick="fnAnswerChk('4','A');return false;">사전 예약 신청</button>
													<button class="button answerB" onclick="fnAnswerChk('4','B');return false;">출시 후에 구매</button>
												</div>
											</div>
										</div>
										<div class="question q05">
											<p class="step"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/txt_step05.gif" alt="" /></p>
											<div class="qCont">
												<p class="situation"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/txt_situation05.gif" alt="애인과의 첫 데이트! 당신의 저녁 메뉴는?" /></p>
												<div class="pic"><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/img_question05.gif" alt="" /></div>
												<div class="selectAB">
													<button class="button answerA" onclick="fnAnswerChk('5','A');return false;">레스토랑에서 파스타</button>
													<button class="button answerB" onclick="fnAnswerChk('5','B');return false;">삼겹살에 술 한 잔</button>
												</div>
											</div>
										</div>
										<%'결과 레이어 영역 %>
										<div class="question viewResult" id="vResultVal">
											<div class="yourType">
												<p><img src="" alt="" id="viewResultImg"/></p>
											</div>
											<div class="selectItem">
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/txt_put_wish.gif" alt="원하는 상품을 [그것이 알고싶다] 위시폴더에 담으면, 기프트카드 받을 확률이 2배!" /></p>
												<p class="selectAll"><input type="checkbox" class="check" id="sAll" /> <label for="sAll">전체선택</label></p>
												<div class="pdtWrap pdt150V15">
													<%'상품 리스트 영역%>
													<ul class="pdtList" id="vResultList"></ul>
													<%'//상품 리스트 영역%>
												</div>
											</div>
											<div class="putMywish">
												<input type="image" src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/btn_wish.png" alt="위시리스트 담기" class="btnWish" onclick="goInsWishData();return false;" />
												<p class="tip">※ 위시리스트 담기 버튼을 누르면 [그것이 알고싶다] 폴더가 생성됩니다.</p>
											</div>										
										</div>
										<%'//결과 레이어 영역 %>
									</div>
									<div class="mask"></div>
								</div>
								<div class="evtNoti">
									<div class="curiousCont">
										<h4><img src="http://webimage.10x10.co.kr/eventIMG/2015/14th/66518/tit_noti.png" alt="유의사항" /></h4>
										<ul>
											<li>본 이벤트는 ID당 1일 1회 참여할 수 있습니다.</li>
											<li>당첨된 기프트카드는 익일 발송될 예정입니다. 개인정보에 있는 휴대폰 번호를 확인해주세요.</li>
											<li>금, 토, 일에 당첨되신 고객분들께는 다음 월요일에 발송 됩니다.</li>
											<li>추천 상품을 위시에 담으신 고객님들은 당첨확률이 높아집니다.</li>
											<li>위시에 담은 상품은 [그것이 알고싶다] 위시 폴더에서 확인 가능합니다.</li>
										</ul>
									</div>
								</div>
							</div>
						</div>
						<%'// [66518] 그것이 알고싶다 %>

					</div>
					<%' //event area(이미지만 등록될때 / 수작업일때) %>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<form method="post" name="frmSbS" id="frmSbS">
	<input type="hidden" name="qAnswer" id="qAnswer">
	<input type="hidden" name="mode" value="add">
</form>
<form method="post" name="frmSbSPrd" id="frmSbSPrd">
	<input type="hidden" name="mode" value="wish">
	<input type="hidden" name="qWishItems" id="qWishItems">
</form>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->
<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  위시리스트를 부탁해
' History : 2015.04.03 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/event/etc/event61006Cls.asp" -->
<%

	dim eCode, subscriptcount, userid
	IF application("Svr_Info") = "Dev" THEN
		eCode   =  "21536"
	Else
		eCode   =  "61006"
	End If

	Dim ename, emimg, cEvent, blnitempriceyn
	set cEvent = new ClsEvtCont
	cEvent.FECode = eCode
	cEvent.fnGetEvent
	
	eCode		= cEvent.FECode	
	ename		= cEvent.FEName
	emimg		= cEvent.FEMimg
	blnitempriceyn = cEvent.FItempriceYN	
set cEvent = nothing

userid = getloginuserid()

Dim ifr, page, i, y
page = request("page")

If page = "" Then page = 1

set ifr = new evt_wishfolder
	ifr.FPageSize = 5
	ifr.FCurrPage = page
	ifr.FeCode = eCode
	
	ifr.Frectuserid = userid
	
	'if eCode<>"" and userid<>"" then
		ifr.evt_wishfolder_list
	'end if

%>
<!-- #include virtual="/lib/inc/head.asp" -->

<style type="text/css">
img {vertical-align:top;}
.evt61006 {background:url(http://webimage.10x10.co.kr/eventIMG/2015/61006/bg_pattern.png) repeat-y 50% 0;}
.topic {position:relative; padding-top:80px; padding-left:100px; text-align:left;}
.topic h1 {width:665px; height:177px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/61006/bg_txt_topic.png) no-repeat 0 -55px; text-indent:-999em; text-align:left;}
.topic .desc {width:480px; height:51px; margin-top:40px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/61006/bg_txt_topic.png) no-repeat 0 -272px; text-indent:-999em;}
.topic .date {position:absolute; top:25px; right:20px; width:1120px; height:23px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/61006/bg_txt_topic.png) no-repeat 100% 0; text-indent:-999em;}
.topic .btnwish {position:absolute; top:132px; right:20px;}
.topic .btnwish a {display:block; width:317px; height:261px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/61006/bg_txt_topic.png) no-repeat 100% -107px; text-indent:-999em;}
.hint {margin-top:60px; padding-bottom:55px; text-align:center;}
.hint .navigator {overflow:hidden; margin-left:67px;}
.hint .navigator li {float:left; width:166px;}
.hint .navigator li a {overflow:hidden; display:block; position:relative; width:100%; height:62px; font-size:11px; line-height:62px; text-align:center;}
.hint .navigator li a span {display:block; position:absolute; top:0; left:0; width:100%; height:100%; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/61006/bg_tab.png); background-repeat:no-repeat;}
.hint .navigator li.mon {width:171px;}
.hint .navigator li.mon a span {background-position:0 0;}
.hint .navigator li.mon a:hover span, .hint .navigator li.mon a.on span {background-position:0 100%;}
.hint .navigator li.tue a span {background-position:-171px 0;}
.hint .navigator li.tue a span:hover, .hint .navigator li.tue a.on span {background-position:-171px 100%;}
.hint .navigator li.wed a span {background-position:-337px 0;}
.hint .navigator li.wed a span:hover, .hint .navigator li.wed a.on span {background-position:-337px 100%;}
.hint .navigator li.thu a span {background-position:-503px 0;}
.hint .navigator li.thu a span:hover, .hint .navigator li.thu a.on span {background-position:-503px 100%;}
.hint .navigator li.fri {width:167px;}
.hint .navigator li.fri a span {background-position:-669px 0;}
.hint .navigator li.fri a span:hover, .hint .navigator li.fri a.on span {background-position:-669px 100%;}
.hint .navigator li.sat {width:178px;}
.hint .navigator li.sat a span {background-position:100% 0;}
.hint .navigator li.sat a span:hover, .hint .navigator li.sat a.on span {background-position:100% 100%;}
.hint .tabcon {height:398px;}
.hint .item {position:relative; width:1000px; height:312px; margin:8px auto 0; background:url(http://webimage.10x10.co.kr/eventIMG/2015/61006/bg_box.png) no-repeat 5% 0;}
.hint .item {-webkit-box-shadow:8px 8px 5px 0px rgba(216,217,318,0.10);
-moz-box-shadow:8px 8px 5px 0px rgba(216,217,318,0.10);
box-shadow:8px 8px 5px 0px rgba(216,217,318,0.10);}
.hint .item .inner {padding-top:15px;}
.hint .item .folder {margin-bottom:35px;}
.hint .item .folder img {vertical-align:middle;}
.hint .item .folder strong {padding:0 5px; color:#336491; font-family:'Dotum', '돋움', 'Verdana'; font-size:24px; font-weight:normal; vertical-align:middle;}
.hint .item ul {overflow:hidden; margin-top:23px; padding-left:47px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/61006/bg_smile.png) no-repeat 0 0;}
.hint .item ul li {float:left; width:148px; height:148px; margin:0 15px; border:1px solid #ddd;}
.hint .item .btngo {position:absolute; top:22px; right:30px;}
.noti {position:relative; padding-bottom:97px; background:#f5f5f5 url(http://webimage.10x10.co.kr/eventIMG/2015/61006/bg_grey.png) repeat-y 50% 0; text-align:left;}
.noti h2 {padding-top:60px; padding-left:70px; border-top:1px solid #e1e1e1;}
.noti ul {margin-top:26px; padding-left:70px;}
.noti ul li {margin-top:7px; padding-left:15px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/61006/blt_arrow.png) no-repeat 0 4px; color:#000; font-size:11px; line-height:1.375em;}
.noti ul li em {display:inline-block; *display:inline; *zoom:1; width:56px; height:16px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/61006/bg_round_box.png) no-repeat 50% 0; color:#fff; text-align:center;}
.noti .ex {position:absolute; top:50%; right:85px; margin-top:-138px;}
</style>
<Script>
$(function(){

	<% if getnowdate="2015-04-06" then %>
		$("#daymon").addClass("on");
		$("#cont1").show();				
	<% end if %>
	<% if getnowdate="2015-04-07" then %>
		$("#daytue").addClass("on");
		$("#cont2").show();				
	<% end if %>
	<% if getnowdate="2015-04-08" then %>
		$("#daywed").addClass("on");
		$("#cont3").show();				
	<% end if %>
	<% if getnowdate="2015-04-09" then %>
		$("#daythu").addClass("on");
		$("#cont4").show();				
	<% end if %>
	<% if getnowdate="2015-04-10" then %>
		$("#dayfri").addClass("on");
		$("#cont5").show();				
	<% end if %>
	<% if getnowdate>="2015-04-11" then %>
		$("#daysat").addClass("on");
		$("#cont6").show();				
	<% end if %>
	
});		
	
function jsGoPage(iP){
	document.pageFrm.page.value = iP;
	document.pageFrm.submit();
}
<% if page>1 then %>
	setTimeout("$('html,body',parent.document).scrollTop(1260);", 200);
<% end if %>

function jsSubmit()
{
	<% If IsUserLoginOK() Then %>
		<% If Now() > #04/12/2015 23:59:59# Then %>
			alert("이벤트가 종료되었습니다.");
			return;
		<% Else %>
			<% If getnowdate>="2015-04-06" and getnowdate<"2015-04-13" Then %>
				var frm = document.frm;
				frm.action="/my10x10/event/myfavorite_folderProc.asp";
				frm.hidM.value='Z';
				frm.submit();
			<% else %>
				alert("이벤트 응모 기간이 아닙니다.");
				return;
			<% end if %>
		<% end if %>
	<% else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}
	<% end if %>
}

function dayclick(iP){
	if (iP > "<%=getnowdate%>")
	{
		return;
	}	
	
	if(iP=='2015-04-06')
	{
		$("#daymon").addClass("on");
		$("#daytue").removeClass();
		$("#daywed").removeClass();
		$("#daythu").removeClass();
		$("#dayfri").removeClass();
		$("#daysat").removeClass();
		$("#cont1").show();
		$("#cont2").hide();
		$("#cont3").hide();
		$("#cont4").hide();
		$("#cont5").hide();
		$("#cont6").hide();										
		
	}
	if(iP=='2015-04-07')
	{
		$("#daymon").removeClass();
		$("#daytue").addClass("on");
		$("#daywed").removeClass();
		$("#daythu").removeClass();
		$("#dayfri").removeClass();
		$("#daysat").removeClass();
		$("#cont1").hide();
		$("#cont2").show();
		$("#cont3").hide();
		$("#cont4").hide();
		$("#cont5").hide();
		$("#cont6").hide();			
	}
	if(iP=='2015-04-08')
	{
		$("#daymon").removeClass();
		$("#daytue").removeClass();
		$("#daywed").addClass("on");
		$("#daythu").removeClass();
		$("#dayfri").removeClass();
		$("#daysat").removeClass();
		$("#cont1").hide();
		$("#cont2").hide();
		$("#cont3").show();
		$("#cont4").hide();
		$("#cont5").hide();
		$("#cont6").hide();			
	}
	if(iP=='2015-04-09')
	{
		$("#daymon").removeClass();
		$("#daytue").removeClass();
		$("#daywed").removeClass();
		$("#daythu").addClass("on");
		$("#dayfri").removeClass();
		$("#daysat").removeClass();
		$("#cont1").hide();
		$("#cont2").hide();
		$("#cont3").hide();
		$("#cont4").show();
		$("#cont5").hide();
		$("#cont6").hide();			
	}
	if(iP=='2015-04-10')
	{
		$("#daymon").removeClass();
		$("#daytue").removeClass();
		$("#daywed").removeClass();
		$("#daythu").removeClass();
		$("#dayfri").addClass("on");
		$("#daysat").removeClass();
		$("#cont1").hide();
		$("#cont2").hide();
		$("#cont3").hide();
		$("#cont4").hide();
		$("#cont5").show();
		$("#cont6").hide();			
	}
	if(iP>='2015-04-11')
	{
		$("#daymon").removeClass();
		$("#daytue").removeClass();
		$("#daywed").removeClass();
		$("#daythu").removeClass();
		$("#dayfri").removeClass();
		$("#daysat").addClass("on");
		$("#cont1").hide();
		$("#cont2").hide();
		$("#cont3").hide();
		$("#cont4").hide();
		$("#cont5").hide();
		$("#cont6").show();			
	}					
}
</script>
<%
Dim sp, spitemid, spimg
Dim arrCnt, foldername

	foldername = "위시리스트를 부탁해"
	Dim strSql, vCount, vFolderName, vViewIsUsing
	vCount = 0

	strSql = "Select COUNT(fidx) From [db_my10x10].[dbo].[tbl_myfavorite_folder]  WHERE foldername = '" & trim(foldername) & "' and userid='" & userid & "' "
	'response.write strSql
	rsget.Open strSql,dbget,1
	IF Not rsget.Eof Then
		vCount = rsget(0)
	else
		vCount = 0
	END IF
	rsget.Close

%>

</head>
<body>
<form name="frm" method="post">
<input type="hidden" name="hidM" value="Z">
	<div class="contF">
		<!-- iframe : 위시리스트를 부탁해  -->
		<div class="evt61006">
			<div class="topic">
				<h1>본격 위시리스트 담는 이벤트! 위시리스트를 부탁해!</h1>
				<p class="desc">매일 달라지는 미션 상품을 당신의 위시리스트를 부탁해! 폴더에 담아 주세요! 100명 추첨하여 텐바이텐 GIFT카드 5만원 권을 선물로 드립니다.</p>
				<p class="date">기간 :  04.06 - 04.12 당첨자 발표 : 04.16</p>
				<div class="btnwish"><a href="" onclick="jsSubmit(); return false;">위시폴더 만들고 이벤트 참여</a></div>
			</div>

			<div class="hint">
				<ul class="navigator">
					<!-- for dev msg : 해당 요일에 클래스 on 붙여주세요 -->
					<li class="mon"><a href="" onclick="dayclick('2015-04-06');return false;" id="daymon"><span></span>MONDAY</a></li>
					<li class="tue"><a href="" onclick="dayclick('2015-04-07');return false;" id="daytue" ><span></span>TUESDAY</a></li>
					<li class="wed"><a href="" onclick="dayclick('2015-04-08');return false;" id="daywed" ><span></span>WEDNESDAY</a></li>
					<li class="thu"><a href="" onclick="dayclick('2015-04-09');return false;" id="daythu" ><span></span>THURSDAY</a></li>
					<li class="fri"><a href="" onclick="dayclick('2015-04-10');return false;" id="dayfri" ><span></span>FRIDAY</a></li>
					<li class="sat"><a href="" onclick="dayclick('2015-04-11');return false;" id="daysat" ><span></span>STA&amp;SUN</a></li>
				</ul>
				<div class="tab-cont">
					<div id="cont1" class="tabcon" style="display:none;">
						<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/61006/txt_hint_01.png" alt="다음 힌트에 맞는 상품 1개를 찾아서 담아 주세요. 홈 인테리어 &gt; 조명 카테고리 속 인기 상품, 텐바이텐의 동그란 로고와 같은 컬러 코를 올리면 불이 켜지면서 SMILE" /></p>
					</div>
					<div id="cont2" class="tabcon" style="display:none;">
						<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/61006/txt_hint_02.png" alt="갖고 싶었던 상품을 10개만 담아 주세요. 3개 이상의 카테고리에서 골라 보기, 컬러만 다른 같은 상품은 댓츠 노노!, 아쉽지만 품절된 상품은 아웃 오브 위시!" /></p>
					</div>
					<div id="cont3" class="tabcon" style="display:none;">
						<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/61006/txt_hint_03.png" alt="푸드 카테고리 상품을 3개만 담아 주세요. 평소 당신이 자주 먹을 수 없지만 먹어보고 싶은 것, 푸드 카테고리의 BEST 상품들을 강력추천!, 비슷한 상품보단 전혀 다른 상품으로 다양하게 담기" /></p>
					</div>
					<div id="cont4" class="tabcon" style="display:none;">
						<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/61006/txt_hint_04.png" alt="애인이 생기면 사주고 싶은 선물로 3가지를 담아 주세요. 없어도 있는 것처럼 고심해서 정성스럽게 고르기, 금액은 상관없이 일단 고르고 나서 슬퍼하기, 내가 갖고 싶은 건 참아주세요. 상상 속 애인을 위해서!" /></p>
					</div>
					<div id="cont5" class="tabcon" style="display:none;">
						<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/61006/txt_hint_05.png" alt="단 하나만 가질 수 있다면 갖고 싶은 상품 1개만 담아 주세요. 누군가에게 선물 할 생각은 말고 오직 당신을 위해서!, 갖고 싶어서 장바구니에 까지 담았던 상품, 3개월 안에 결제할 것 같은 상품으로 쏙!" /></p>
					</div>
					<div id="cont6" class="tabcon" style="display:none;">
						<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/61006/txt_hint_06.png" alt="다음 힌트에 맞는 상품 2개를 찾아서 담아 주세요. 텐바이텐 PLAY Ground에서 만날 수 있는 상품, 열 여덟번째 주제 PLATE를 테마로 만든 텐바이텐 상품, 음식을 담고 재미있게 놀 수 있는 특별한 상품" /></p>
					</div>
				</div>
				

				<% If IsUserLoginOK() Then %>
					<% if vCount > 0 then %>
						<!-- for dev msg : 개인위시 -->
						<div class="item">
							<div class="inner">
								<p class="folder">
									<img src="http://webimage.10x10.co.kr/eventIMG/2015/61006/ico_cart.png" alt="" />
									<strong><%= userid %></strong>
									<img src="http://webimage.10x10.co.kr/eventIMG/2015/61006/txt_folder.png" alt="<%= userid %>님의 위시리스트를 부탁해 위시 폴더" />
								</p>

								<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/61006/txt_random.png" alt="위시리스트를 부탁해 폴더에 속에 담은 상품 중 10개가 랜덤으로 보여집니다." /></p>
								<ul>
								<% if ifr.FmyTotalCount > 0 then %>
									<%
										if isarray(Split(ifr.Fmylist,",")) then
											arrCnt = Ubound(Split(ifr.Fmylist,","))
										else
											arrCnt=0
										end if
			
										If ifr.FmyTotalCount > 4 Then
											arrCnt = 5
										Else
											arrCnt = ifr.FmyTotalCount
										End IF
			
										For y = 0 to CInt(arrCnt) - 1
											sp = Split(ifr.Fmylist,",")(y)
											spitemid = Split(sp,"|")(0)
											spimg	 = Split(sp,"|")(1)
									%>
									<li><a href="<%=wwwURL%>/<%=spitemid%>" target="_top"><img src="http://webimage.10x10.co.kr/image/icon2/<%=GetImageSubFolderByItemid(spitemid)%>/<%=spimg%>" width="148" height="148" alt="" /></a></li>
									<%
										Next
									%>
								<% else %>
									<li></li>
								<% end if %>
								</ul>
		
								<div class="btngo"><a href="/my10x10/mywishlist.asp" target="_top"><img src="http://webimage.10x10.co.kr/eventIMG/2015/61006/btn_go.png" alt="나의 위시 보러가기" /></a></div>
							</div>
						</div>
					<% End if %>
				<% End if %>
			</div>

			<% If IsUserLoginOK()=false Then %>
				<div class="way">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/61006/txt_way.png" alt="이벤트 참여 방법은 이벤트 페이지에서 미션을 확인 후 텐바이텐 미션에 맞는 상품을 고르고 위시리스트를 부탁해 폴더에 담으면 됩니다. 매일 담아야하는 미션이 달라지며, 본 페이지에서 폴더 생성 후 담아야합니다. 전일의 미션을 수행할 수 있지만 요일의 순차로 담아야 하며, 2015년 4월 16일 오전 10시까지 담겨져 있는 상품을 기준으로 합니다." /></p>
				</div>
			<% elseif vCount < 1 then %>
				<div class="way">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/61006/txt_way.png" alt="이벤트 참여 방법은 이벤트 페이지에서 미션을 확인 후 텐바이텐 미션에 맞는 상품을 고르고 위시리스트를 부탁해 폴더에 담으면 됩니다. 매일 담아야하는 미션이 달라지며, 본 페이지에서 폴더 생성 후 담아야합니다. 전일의 미션을 수행할 수 있지만 요일의 순차로 담아야 하며, 2015년 4월 16일 오전 10시까지 담겨져 있는 상품을 기준으로 합니다." /></p>
				</div>
			<% End if %>
			<div class="noti">
				<h2><img src="http://webimage.10x10.co.kr/eventIMG/2015/61006/tit_noti.png" alt="유의사항은 꼭 읽어주세요!" /></h2>
				<ul>
					<li><em>참여하기</em> 클릭 시, 위시리스트에 &lt;위시리스트를 부탁해&gt; 폴더가 자동 생성됩니다.</li>
					<li>본 이벤트에서 <em>참여하기</em> 를 클릭하셔야만 이벤트 참여가 가능합니다.</li>
					<li>수동으로 생성하시거나 기존에 있던 폴더의 이름을 수정하면 이벤트 참여가 불가합니다.</li>
					<li>위시리스트에 &lt;위시리스트를 부탁해&gt; 폴더는 한 ID당 1개만 생성할 수 있습니다.</li>
					<li>최소 5개 이상의 상품을 담아주셔야 당첨이 됩니다.</li>
					<li>해당 폴더 외에 다른 폴더명에 담으시는 상품은 참여 및 증정 대상에서 제외됩니다.</li>
					<li>당첨자에 한해 개인정보를 요청하게 되며, 개인정보 확인 후 경품이 지급됩니다.</li>
					<li>본 이벤트는 종료일인 4월 16일 오전 10시까지 담겨있는 상품을 기준으로 선정합니다.</li>
				</ul>
				<p class="ex"><img src="http://webimage.10x10.co.kr/eventIMG/2015/61006/img_ex.png" alt="MY TENBYTEN &gt; MY 다이어리 &gt; 위시에서 위시를 부탁해 폴더를 확인하실수 있습니다." /></p>
			</div>
		</div>
		<!-- // iframe : 위시리스트를 부탁해  -->
	</div>
</form>
<script type="text/javascript">
$(function(){
	function moving() {
		$(".btnwish").animate({"top":"132px"},1000).animate({"top":"125px"},1000, moving);
	}
	moving();

	/* tab */
//	$(".hint .navigator li a:first").addClass("on");
//	$(".hint .tab-cont").find(".tabcon").hide();
//	$(".hint .tab-cont").find(".tabcon:first").show();
	
//	$(".hint .navigator li a").click(function(){
//		$(".hint .navigator li a").removeClass("on");
//		$(this).addClass("on");
//		var thisCont = $(this).attr("href");
//		$(".hint .tab-cont").find(".tabcon").hide();
//		$(".hint .tab-cont").find(thisCont).show();
//		return false;
//	});
});
</script>
</body>
</html>
<form name="pageFrm" method="get" action="<%=CurrURL()%>">
<input type="hidden" name="page" value="">
</form>
<!-- #include virtual="/lib/poptailer.asp" -->
<!-- #include virtual="/lib/db/dbclose.asp" -->

<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#############################################################
'	Description : HITCHHIKER
'	History		: 2014.08.06 유태욱 생성
'#############################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/hitchhiker/hitchhikerCls.asp"-->
<!-- #include virtual="/lib/classes/enjoy/hitchhikerCls.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
Dim i, page
Dim olist, intI, iTotCnt, rstArrItemid, rstWishItem, rstWishCnt, blnitempriceyn, sBadges
	page = request("page")
if page="" then page=1

Dim opreview
set opreview = new CHitchhikerlist
	opreview.Frectisusing = "Y"
	opreview.FrectCurrentpreview = "Y"
	opreview.fngetpreview
	'//최근 오픈 인것이 없으면, 종료된것중 최근것을 가져옴
	if opreview.ftotalcount < 1 then
		set opreview = new CHitchhikerlist
			opreview.Frectisusing = "Y"
			opreview.FrectCurrentpreview = ""
			opreview.fngetpreview
	end if

Dim ovideo
set ovideo = new CHitchhikerlist
	ovideo.Frectisusing = "Y"
	ovideo.FrectCurrentpreview = "Y"
	ovideo.FPageSize = 30
	ovideo.Fgubun = 3
	ovideo.fngetvideo
	'//최근 오픈 인것이 없으면, 종료된것중 최근것을 가져옴
	if ovideo.ftotalcount < 1 then
		set ovideo = new CHitchhikerlist
			ovideo.Frectisusing = "Y"
			ovideo.FrectCurrentpreview = ""
			ovideo.Fgubun = 3
			ovideo.FPageSize = 30
			ovideo.fngetvideo
	end if
%>
<%
	strPageTitle = "텐바이텐 10X10 : 히치하이커"		'페이지 타이틀 (필수)
	strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_infomation_v1.jpg"
	strPageDesc = "당신에게 소소한 즐거움, 작은 위로가 되어 드릴께요!"
	'// 오픈그래프 메타태그
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 히치하이커"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""https://www.10x10.co.kr/hitchhiker/"" />" & vbCrLf &_
						"<meta property=""og:description"" content=""" & strPageDesc & """>" & vbCrLf
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
.gnbWrapV15 {height:38px;}
.hitchhiker img {vertical-align:top;}
</style>
<script type="text/javascript" src="/lib/js/jquery.numspinner.min.js"></script>
<script type="text/javascript" src="/lib/js/jquery.slides.min.js"></script>
<script type="text/javascript">


$(function(){

	/* 더블클릭시 최상단으로 이동 이벤트 없애기 */
	$(document).unbind("dblclick").dblclick(function (e) {});

	/* main slide */
	$("#slideMain").slidesjs({
		width:"1140",
		height:"410",
		pagination:{effect:"fade"},
		play: {interval:3500, effect:"fade", auto:true},
		navigation:false,
		effect:{fade: {speed:1000, crossfade:true}}
	});

	/* anchor */
	$(".slide .essayediter a").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top}, 500);
	});

	/*상품리스트*/
	$(".slide .hitlist a").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top}, 500);
	});

	/* layer */
	$("#lyVip").hide();
	$("#lyEssay").hide();
	$("#lyPhoto").hide();
	$("#lyPreview").hide();
	$("#lyVideo").hide();

	// video-play
	var videoplay = function(index){
		var hittchikerVod = $(".vod-player").eq(index);
		var url = $(".videosrc").eq(index).attr("videosrc");
		hittchikerVod.attr("src",url);
	}

	/* video */
	$(".video .btnMore").click(function(){
		videoSlide();
		videoSlideStart01();
		setTimeout(function(){
			videoplay(0);
		},100);
	});
	$(".video ul li:nth-child(1) a").click(function(){
		videoSlide();
		videoSlideStart01();
		setTimeout(function(){
			videoplay(0);
		},100);
	});
	$(".video ul li:nth-child(2) a").click(function(){
		videoSlide();
		videoSlideStart02();
		setTimeout(function(){
			videoplay(1);
		},100);
	});
	$(".video ul li:nth-child(3) a").click(function(){
		videoSlide();
		videoSlideStart03();
		setTimeout(function(){
			videoplay(2);
		},100);
	});
	$(".video ul li:nth-child(4) a").click(function(){
		videoSlide();
		videoSlideStart04();
		setTimeout(function(){
			videoplay(3);
		},100);
	});
	$(".video ul li:nth-child(5) a").click(function(){
		videoSlide();
		videoSlideStart05();
		setTimeout(function(){
			videoplay(4);
		},100);
	});
	$(".video ul li:nth-child(6) a").click(function(){
		videoSlide();
		videoSlideStart06();
		setTimeout(function(){
			videoplay(5);
		},100);
	});

	/* layer - hitchhiker video */
	function videoSlideStart01(){
		$(".videoGallery").css("height", "532px");
		$(".videoGallery .slide").hide();
		$(".videoGallery .slide:first").show();
	}

	function videoSlideStart02(){
		$(".videoGallery").css("height", "532px");
		$(".videoGallery .slide").hide();
		$(".videoGallery .slide:nth-child(2)").show();
	}

	function videoSlideStart03(){
		$(".videoGallery").css("height", "532px");
		$(".videoGallery .slide").hide();
		$(".videoGallery .slide:nth-child(3)").show();
	}

	function videoSlideStart04(){
		$(".videoGallery").css("height", "532px");
		$(".videoGallery .slide").hide();
		$(".videoGallery .slide:nth-child(4)").show();
	}

	function videoSlideStart05(){
		$(".videoGallery").css("height", "532px");
		$(".videoGallery .slide").hide();
		$(".videoGallery .slide:nth-child(5)").show();
	}

	function videoSlideStart06(){
		$(".videoGallery").css("height", "532px");
		$(".videoGallery .slide").hide();
		$(".videoGallery .slide:nth-child(6)").show();
	}

	function videoSlide(){
		$(".btnNext").click(function() {
			$(".videoGallery .slide:first").appendTo(".videoGallery");
			$(".videoGallery .slide").hide().eq(0).show();
			setTimeout(function(){
				videoplay(0);
			},100);
		});
		$(".btnPrev").click(function() {
			$(".videoGallery .slide:last").prependTo(".videoGallery");
			$(".videoGallery .slide").hide().eq(0).show();
			setTimeout(function(){
				videoplay(0);
			},100);
		});
	}

	/* preview */
	$(".preview .btnClick").hide();
	$(".preview .area").mouseover(function(){
		$(".preview .btnClick").show();
	});
	$(".preview .area").mouseleave(function(){
		$(".preview .btnClick").hide();
	});

	$(".preview .btnClick").click(function(){
		previewSlide();
	});
	$(".preview .btnMore").click(function(){
		previewSlide();
	});

	/* layer - hitchhiker preview */
	/* 20140901 */
	function previewSlide(){
		/*$("#slidePreview").slidesjs({
			width:"778",
			height:"550",
			pagination:false,
			play: {interval:3500, effect:"fade", auto:false},
			navigation:{effect:"fade"},
			effect:{fade: {speed:1000, crossfade:true}}
		});*/
		$(".btnNext").click(function() {
			$("#slidePreview .slide p:first").appendTo("#slidePreview .slide");
			$("#slidePreview .slide p").fadeOut("slow").eq(0).fadeIn("slow");
		});
		$(".btnPrev").click(function() {
			$("#slidePreview .slide p:last").prependTo("#slidePreview .slide");
			$("#slidePreview .slide p").fadeOut("slow").eq(0).fadeIn("slow");
		});
	}
});

function topLayer() {
	<% If IsUserLoginOK() Then %>
		var contDtl = $.ajax({
				type: "GET",
		        url: "/hitchhiker/ajax_hitchVIP.asp",
		        dataType: "text",
		        async: false
		}).responseText;

		//현재 윈도우 사이즈 접수
		var maskHeight = $(document).height();
		//var maskWidth = $(document).width();
		var maskWidth = $(window).width();
		//Modal
		var id = $("#freeForm");
		$(id).empty().html(contDtl).find(".window").show();
		$('#mask').css({'width':maskWidth,'height':maskHeight});
		$('#mask').fadeIn();
		var id2 = $(id).children();
		$('#boxes').show();
		var winH = $(window).height();
		var winW = $(document).width();
		$(id2).css('top', winH/2-$(id2).height()/2);
		$(id2).css('left', winW/2-$(id2).width()/2);
		$(id).show();
	<% else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}
	<% end if %>

}

function editerLayer(gb,g_Contest) {
	<% If Not(IsUserLoginOK) Then %>
		if(confirm("로그인 후 지원할 수 있습니다!")){
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
		}
	<% else %>
		var contDtl = $.ajax({
				type: "GET",
		        url: "/hitchhiker/editer/popup_apply.asp?gb="+gb+"&g_Contest="+g_Contest,
		        dataType: "text",
		        async: false
		}).responseText;

		//현재 윈도우 사이즈 접수
		var maskHeight = $(document).height();
		//var maskWidth = $(document).width();
		var maskWidth = $(window).width();
		//Modal
		var id = $("#freeForm");
		$(id).empty().html(contDtl).find(".window").show();
		$('#mask').css({'width':maskWidth,'height':maskHeight});
		$('#mask').fadeIn();
		var id2 = $(id).children();
		$('#boxes').show();
		var winH = $(window).height();
		var winW = $(document).width();
		$(id2).css('top', winH/2-$(id2).height()/2);
		$(id2).css('left', winW/2-$(id2).width()/2);
		$(id).show();
	<% end if %>
}

function pcwallpaper(page){
	if (page==''){
		page=1;
	}

	$.ajax({
	    url : "/hitchhiker/ajax_pcwallpaper.asp?page="+page,
	    dataType : "html",
	    type : "get",
	    success : function(result){
	        $("#pcwallpaper").empty().html(result);
	    }
	});
}
//pcwallpaper(1);

function mowallpaper(page){
	if (page==''){
	page=1;
	}
	$.ajax({
	    url : "/hitchhiker/ajax_mowallpaper.asp?page="+page,
	    dataType : "html",
	    type : "get",
	    success : function(result){
	        $("#mowallpaper").empty().html(result);
	    }
	});
}
//mowallpaper(1);

function hichlist(page,soldoutyn,sortno){
	if (page==''){
		page=1;
	}

	$.ajax({
	    url : "/hitchhiker/ajax_hitchItemList.asp?page="+page+"&soldoutyn="+soldoutyn+"&sortno="+sortno,
	    dataType : "html",
	    type : "get",
	    success : function(result){
	        $("#hichlist").empty().html(result);
	    }
	});
}
//hichlist(1,'','');
</script>
<%
'확인 안된 VIP라면 출력(DB에서 재검사)
Dim chk: chk=false
Dim hitch
Set hitch = new Hitchhiker
	hitch.FUserId = GetLoginUserID
	hitch.fnGetHitchCont
'response.write hitch.FVHVol
	If (hitch.FUserlevel = "3" or hitch.FUserlevel = "4" or hitch.FUserlevel = "6" or hitch.FUserId = "kjy8517" or hitch.FUserId = "okkang77" or hitch.FUserId = "baboytw" or hitch.FUserId = "tozzinet" or hitch.FUserId = "thensi7" or hitch.FUserId = "jj999a" or hitch.FUserId = "dlwjseh") Then
		If isNull(hitch.FVHVol) Then
			chk=true
		Else
			chk=false
		End If
	Else
		chk=false
	End If
'chk=true

'// DB검사 후 출력내용이 있으면 출력
If chk=true And hitch.FAppCount <= 10000 Then
%>
<script>window.onload = topLayer;</script>
<%
end if
%>
</head>
<body>

<div class="wrap" style="overflow:hidden;">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container hitchhikerPage">
		<div id="contentWrap">

			<div class="hitchhiker">
				<div class="row row1">
					<div id="slideMain" class="slide">
						<% ' hitchhiker 메인배너 %>
						<!-- #include virtual="/hitchhiker/inc_main_topbanner.asp" -->
					</div>
					<!--메인배너 하단에 박힌 고정배너-->
					<% If hitch.FHVol <> "" Then %>
						<div class="bnr-addressV18">
							<% If hitch.FAppCount > 10000 Then '// 선착순 마감 %>
								<p><strong>VVIP, VIP GOLD 고객님께 드리는 히치하이커 선착순 신청이 마감되었어요!</strong>많은 관심 감사드립니다, 다음 신청도 기대해주세요 :)</p>
							<% Else %>
								<p><strong>VVIP, VIP GOLD 고객님! 주소입력하고 히치하이커 선물을 받아가세요!</strong>기간 내에 신청해주신 선착순 10,000명의 고객분들께 히치하이커를 드려요.</p>
								<a href="#lyVip" onclick="topLayer(); return false;">주소 입력하기<span></span></a>
							<% End If %>
						</div>
					<% end if %>
				</div>

				<div class="row row2">
					<div class="col col1">
						<div class="group about">
							<h2><img src="http://fiximage.10x10.co.kr/web2013/hitchhiker/tit_about_hitchhiker.gif" alt="about HITCHHIKER" /></h2>
							<p><img src="http://fiximage.10x10.co.kr/web2013/hitchhiker/txt_about_hitchhiker.gif" alt="히치하이커는 격월간으로 발행되는 텐바이텐의 감성매거진입니다. 매 호 다른 주제로 우리 주변의 평범한 이야기와 일상의 풍경을 담아냅니다. 히치하이커가 당신에게 소소한 즐거움, 작은 위로가 될 수 있길 바랍니다." /></p>
						</div>

						<div id="handwork" class="group handwork">
							<% '  for dev msg : 모집이냐 발간이냐 / 수작업 이미지 등록 영역 / 이미지사이즈 560*865 %>
							<!-- #include virtual="/hitchhiker/inc_middle_issue.asp" -->
						</div>

<% '  for dev msg : video 썸네일 %>
						<div class="group itembox video">
							<div class="part">
								<h3><img src="http://fiximage.10x10.co.kr/web2013/hitchhiker/tit_video.gif" alt="VIDEO" /></h3>
								<ul>
									<% if ovideo.FResultCount > 0 then %>
										<% for i = 0 to ovideo.FResultCount-1 %>
											<% if i > 5 then exit for %>
											<li>
												<a href="#lyVideo" id="video00" onclick="viewPoupLayer('modal',$('#lyVideo').html());return false;">
													<span class="figure" style="background-image:url(<%= ovideo.FItemList(i).FReqcon_viewthumbimg %>);"></span>
													<strong class="topic"><%=ovideo.FItemList(i).FReqTitle%></strong>
													<span class="desc"><%=ovideo.FItemList(i).FReqpreview_detail%></span>
<% '  for dev msg : 동영상 NEW 아이콘은 2주동안 노출 %>
													<%
													dim week
													week = dateadd("D",-14,now())
													if ovideo.FItemList(i).FReqSdate >= week then
													%>
														<span class="ico"><img src="http://fiximage.10x10.co.kr/web2013/hitchhiker/ico_new.gif" alt="NEW" /></span>
													<% end if %>
												</a>
											</li>
										<% next %>
									<% end if %>
								</ul>
								<div class="btnMore"><a href="#lyVideo" onclick="viewPoupLayer('modal',$('#lyVideo').html());return false;"><img src="http://fiximage.10x10.co.kr/web2013/hitchhiker/btn_more.gif" alt="히치하이커 비디오 더보기" /></a></div>
							</div>
						</div>

					</div>

					<div class="col col2">
<% '  for dev msg : preview 썸네일 %>

						<div class="group itembox preview">
							<% if opreview.ftotalcount > 0 then %>
								<div class="part">
									<h3><img src="http://fiximage.10x10.co.kr/web2013/hitchhiker/tit_preview.gif" alt="PREVIEW" /></h3>
									<div class="area">
										<span><img src="<%=opreview.FOneItem.FReqpreview_thumbimg %>" width="374" height="252" alt="" /></span>
										<div class="mask"></div>
										<a href="#lyPreview" onclick="viewPoupLayer('modal',$('#lyPreview').html());return false;" class="btnClick">Click to read</a>
									</div>
									<div class="btnMore"><a href="#lyPreview" onclick="viewPoupLayer('modal',$('#lyPreview').html());return false;">
										<img src="http://fiximage.10x10.co.kr/web2013/hitchhiker/btn_more.gif" alt="PREVIEW 더보기" /></a>
									</div>
								</div>
							<% end if %>
						</div>

<% '  for dev msg : wallpaper %>
						<div class="group itembox wallpaper">
							<div class="part" id="pcwallpaper">
							<!-- #include virtual="/hitchhiker/inc_pcwallpaper.asp" -->
							</div>
							<div class="part" id="mowallpaper">
							<!-- #include virtual="/hitchhiker/inc_mowallpaper.asp" -->
							</div>
						</div>
					</div>
				</div>

<% ' for dev msg : 히치하이커 상품 검색옵션 및 상품 리스트 %>
				<div class="row row3" id="hichlist">
				<!-- #include virtual="/hitchhiker/inc_hitchItemList.asp" -->
				</div>
			</div>
			<!-- // hitchhiker -->
		</div>
	</div>
<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>

<% ' for dev msg : Layer Popup for VIP 주소입력 이벤트 %>
<div id="lyVip"></div>

<% ' for dev msg : 히치하이커 고객에디터 모집 ESSAY지원 %>
<div id="lyEssay"></div>

<% ' for dev msg : 히치하이커 고객에디터 모집 PHOTO STICKER지원 %>
<div id="lyPhoto"></div>

<% ' for dev msg : 히치하이커 비디오 디테일 레이어팝업 %>
<div id="lyVideo">
	<% if ovideo.FResultCount > 0 then %>
		<div class="lyHitchhiker window" style="height:670px; margin-top:-335px;">
			<div class="modalBox htype">
				<div class="modalHeader">
					<h1><img src="http://fiximage.10x10.co.kr/web2013/hitchhiker/tit_hitchhiker_video.gif" alt="히치하이커 비디오" /></h1>
				</div>
				<div class="modalBody hitchhikerVideo">
					<div class="videoWrap">
						<div class="videoGallery">
							<% 'for dev msg : 비디오 최근순으로 해주세요. %>
							<% for i = 0 to ovideo.FResultCount - 1 %>
								<div class="slide">
									<div class="movie">
										<iframe class="vod-player" src="" width="660" height="450" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>
										<div class="videosrc" style="display:none" videosrc="<%=ovideo.FItemList(i).FReqmovie%>"></div>
									</div>
									<p class="desc">
										<em><%=i+1 %></em>
										<strong><%=ovideo.FItemList(i).FReqTitle%></strong>
										<span><%=ovideo.FItemList(i).FReqpreview_detail%></span>
									</p>
								</div>
							<% next %>
						</div>
						<button type="button" class="btnPrev">이전 비디오 보기</button>
						<button type="button" class="btnNext">다음 비디오 보기</button>
					</div>
				</div>
				<button onclick="ClosePopLayer()" class="modalClose">닫기</button>
			</div>
		</div>
	<% end if %>
</div>

<% ' for dev msg : 히치하이커 프리뷰 디테일 레이어팝업 %>
<div id="lyPreview">
	<% if opreview.ftotalcount > 0 then %>
		<%
		Dim opreviewdetail
		set opreviewdetail = new CHitchhikerlist
			opreviewdetail.Frectmasteridx = opreview.FOneItem.Fidx
			opreviewdetail.Frectisusing = "Y"
			opreviewdetail.Frectdevice = "W"
			opreviewdetail.fngetpreviewdetail
		%>
		<div class="lyHitchhiker window" style="height:670px; margin-top:-335px;">
			<div class="modalBox htype">
				<div class="modalHeader">
					<h1><img src="http://fiximage.10x10.co.kr/web2013/hitchhiker/tit_hitchhiker_preview.gif" alt="히치하이커 미리보기" /></h1>
				</div>
				<div class="modalBody hitchhikerPreview">
					<% if opreviewdetail.FResultCount > 0 then %>
						<div id="slidePreview">
							<div class="slide">
								<% for i = 0 to opreviewdetail.FResultCount - 1 %>
									<p><img src="<%= staticImgUrl %>/hitchhiker/preview/detail/<%= opreviewdetail.FItemList(i).fpreviewimg %>" width="660" height="468" alt="<%= i %>" /></p>
								<% next %>
							</div>
							<button type="button" class="btnPrev">이전 보기</button>
							<button type="button" class="btnNext">다음 보기</button>
						</div>
					<% end if %>

					<div class="desc">
						<p>
							<strong><%=opreview.FOneItem.FReqTitle%></strong>
							<span class="fs11 ftDotum"><%=opreview.FOneItem.FReqpreview_detail%></span>
						</p>
						<div class="btnArea">
							<a href="http://www.10x10.co.kr/shopping/category_prd.asp?itemid=<%=opreview.FOneItem.FReqcash%>"><img src="http://fiximage.10x10.co.kr/web2018/hitchhiker/btn_buy_cash.gif" alt="삼천원 현금구매하기" /></a>
							<a href="http://www.10x10.co.kr/shopping/category_prd.asp?itemid=<%=opreview.FOneItem.FReqmileage%>"><img src="http://fiximage.10x10.co.kr/web2018/hitchhiker/btn_buy_mileage.gif" alt="천오백포인트 마일리지 구매하기" /></a>
						</div>
					</div>
				</div>
				<button onclick="ClosePopLayer()" class="modalClose">닫기</button>
			</div>
		</div>
	<% end if %>
</div>
</body>
</html>

<%
set opreview = nothing
set opreviewdetail = nothing
set ovideo = nothing
Set hitch = nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
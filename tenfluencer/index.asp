<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/classes/media/mediaCls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
	dim oMedia , arrSwipeList , i
	dim vServiceCode : vServiceCode = 1 'tenfluencer
	dim vChannel : vChannel = 1 '1 pc 2 mobile
	dim bannerimage , maincopy , subcopy , linkurl , profileimage , contentsidx , eventid

	set oMedia = new MediaCls
		arrSwipeList = oMedia.getSwipeBanner(vServiceCode,vChannel)
	set oMedia = nothing
%>
<link rel="stylesheet" type="text/css" href="/lib/css/platform.css?v=1.25">
<script type="text/javascript">
var isloading=true;
$(function(){
	// bg
	$(".plf-top .bg-rolling").slick({
		autoplay: true,
		fade: true,
		arrows: false,
		//zIndex: 1,
		speed: 5000,
		autoplaySpeed: 500
	});

	// banner
	$(".plf-top .bnr-rolling").slick({
		autoplay: true,
		autoplaySpeed: 4000,
		speed: 1000,
		cssEase: 'none',
		arrows: false,
		fade: true,
		dots: true,
		dotsClass:"nav-list",
		customPaging: function(slider, i){
			var owner = $(slider.$slides[i]).data('owner');
			var title = $(slider.$slides[i]).data('title');
			return '<div><div class="owner"><img src="'+owner+'"></div><div class="title">'+title+'</div></div>';
		}
	});

	// timer
	var date = new Date(-32400000);
	setInterval(function() {
		date.setSeconds(date.getSeconds() + 1);
		$('#timer').html(date.toTimeString().substr(0, 8));
	}, 1000);

	// tab
	$(".plf-tab li").click(function(e){
		e.preventDefault();
		$(this).addClass("on").siblings("li").removeClass("on");
	});

	// video-list
	getList();

	//스크롤 이벤트 시작
	$(window).scroll(function() {
		if ($(window).scrollTop() >= $(document).height() - $(window).height() - 350){
			if (isloading==false){
				isloading=true;
				var pg = $("#listfrm input[name='cpg']").val();
				pg++;
				$("#listfrm input[name='cpg']").val(pg);
				getList();
			}
		}
	});
});

function getList() {
	var str = $.ajax({
			type: "GET",
			url: "ajaxDataList.asp",
			data: $("#listfrm").serialize(),
			dataType: "text",
			async: false
	}).responseText;

	if(str!="") {
		($("#listfrm input[name='cpg']").val()=="1") ? $('#vodLists').empty().html(str) : $('#vodLists').append(str);
		isloading=false;
	}
}

function sortChange(num) {
	var frm = document.listfrm;
	if (num == 1) {
		frm.cpg.value = 1;
		frm.sortMet.value = 1;
	} else {
		frm.cpg.value = 1;
		frm.sortMet.value = 2;
	}

	getList();
}

function linkUrl(url, contentsidx, eventid) {
	if (contentsidx != null) {
		location.href = "/tenfluencer/detail.asp?cidx="+contentsidx;
	} else if (eventid != null) {
		location.href = "/event/eventmain.asp?eventid="+eventid;
	} else {
		location.href = url;
	}
}
</script>
</head>
<body class="plfV19">
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
		<div class="plf-top">
			<div class="bg-rolling">
				<div style="background-image:url(//fiximage.10x10.co.kr/web2019/platform/main_bg_01.jpg);"></div>
				<div style="background-image:url(//fiximage.10x10.co.kr/web2019/platform/main_bg_02.jpg);"></div>
				<div style="background-image:url(//fiximage.10x10.co.kr/web2019/platform/main_bg_03.jpg);"></div>
				<div style="background-image:url(//fiximage.10x10.co.kr/web2019/platform/main_bg_04.jpg);"></div>
			</div>
			<div class="plf-head">
				<h2><a href="">tenfluencer</a></h2>
			</div>
			<%
				if isarray(arrSwipeList) then 
			%>
			<div class="inner has-bnr">
				<h3>텐플루언서 핫 이슈!</h3>
				<div class="bnr-rolling">
					<% 
						for i = 0 to ubound(arrSwipeList,2)
							bannerimage = arrSwipeList(1,i)
							maincopy    = arrSwipeList(2,i)
							subcopy     = arrSwipeList(3,i)
							linkurl     = arrSwipeList(4,i)
							contentsidx = arrSwipeList(13,i)
							eventid     = arrSwipeList(14,i)

							profileimage= chkiif(arrSwipeList(13,i)<> "" ,arrSwipeList(11,i) , arrSwipeList(12,i)) 
					%>
					<div data-owner="<%=profileimage%>" data-title="<%=maincopy%>" onclick="linkUrl('<%=linkurl%>','<%=contentsidx%>','<%=eventid%>');">
						<div class="thumbnail"><img src="<%=bannerimage%>" alt=""></div>
						<div class="desc">
							<p class="headline"><%=maincopy%></p>
							<p class="subcopy"><%=subcopy%></p>
						</div>
					</div>
					<% 
						next 
					%>
				</div>
				<span class="rec">REC</span>
			</div>
			<%
				else
			%>
			<div class="inner">
				<div class="txt-tf"><i class="dc1"></i><i class="dc2"></i></div>
				<span class="rec">REC</span>
				<span id="timer" class="plf-timer">00:00:00</span>
			</div>
			<%
				end if 
			%>
		</div>
		<form id="listfrm" name="listfrm" method="get" style="margin:0px;">
		<input type="hidden" name="cpg" value="1" />				
		<input type="hidden" name="sortMet" value="1" />
		</form>
		<div class="plf-tab">
			<ul>
				<li class="on"><a href="" onclick="sortChange(1);return false;">신규순</a></li>
				<li><a href="" onclick="sortChange(2);return false;">인기순</a></li>
			</ul>
		</div>
		<div class="inner">
			<div class="vod-list">
				<ul id="vodLists"></ul>
			</div>
			<%'!-- 박수 30번 축하 레이어 -- %>
			<div class="ly-clap">
				<div class="ly-clap-inner">
					<div class="dots dots1"></div>
					<div class="dots dots2"></div>
					<div class="dots dots3"></div>
					<div class="dots dots4"></div>
					<div class="dots dots5"></div>
					<div class="dots dots6"></div>
					<div class="dots dots7"></div>
					<div class="dots dots8"></div>
					<div class="hand"></div>
					<div class="heart"><i></i></div>
				</div>
				<div class="mask"></div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->
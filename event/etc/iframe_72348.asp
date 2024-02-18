<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
.itemWrap {text-align:center;}
.itemWrap .time {position:relative; text-align:left;}
.itemWrap .time {color:#000; font-family:'Dotum', '돋움', 'Verdana'; font-size:11px; font-weight:bold; line-height:22px; vertical-align:top;}
.itemWrap .time strong {display:block; margin-left:46px; padding-left:18px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/72348/ico_clock.png) no-repeat 0 50%;}
.itemWrap .time .timer {overflow:hidden; position:absolute; top:0; left:117px; width:88px;}
.itemWrap .time .timer span, .itemWrap .time .timer i {float:left; text-align:right;}
.itemWrap .time .timer .left {text-align:left;}
.itemWrap .timer span {width:12px; height:22px; background-color:#000; color:#fff;}
.itemWrap .timer i {width:8px; height:22px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/72348/bg_colon.png) no-repeat 50% 0;}
.itemWrap h1 {margin-top:32px;}
.itemWrap .item {width:186px; margin:0 auto;}
.itemWrap .item a:hover {text-decoration:none;}
.itemWrap .item .figure {position:relative; width:186px; margin-top:18px;}
.itemWrap .item .figure .mask {position:absolute; top:0; left:0; width:186px; height:190px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/72348/bg_mask_v1.png) no-repeat 0 0;}
.itemWrap .item span {display:block; color:#000; font-family:'Dotum', '돋움', 'Verdana'; font-size:11px; font-weight:bold;}
.itemWrap .item .copy ,
.itemWrap .item .price {font-weight:normal;}
.itemWrap .item .copy {margin-top:12px;}
.itemWrap .item .name {overflow:hidden; height:15px; text-overflow:ellipsis; white-space:nowrap;}
.itemWrap .item .price {margin-top:10px;}
.itemWrap .item .price b {color:#ff0000;}
</style>
<%
Dim vTimerDate, nowDate, sNow
Dim todayLinkItem, todayImage, todayCopy, todayItemname, todayOrgprice, todaySalePrice, todaySalePer
nowDate = date()
sNow = now()
'nowDate = "2016-08-22"
'sNow = "2016-08-22 " & Hour(now) & ":" & Minute(now) & ":" & Second(now)

Select Case nowDate
	Case "2016-08-22"
		todayLinkItem		= "710156"
		todayImage			= "http://webimage.10x10.co.kr/eventIMG/2016/72431/img_item_0822_01.jpg"
		todayCopy			= "5가지 맛, 5미자수에서"
		todayItemname		= "효종원 오미자 수 100ml*30포"
		todayOrgprice		= "39,000"
		todaySalePrice		= "33,000"
		todaySalePer		= "15%"
		vTimerDate			= DateAdd("d", 1, nowDate)
	Case "2016-08-23"
		todayLinkItem		= "1285004"
		todayImage			= "http://webimage.10x10.co.kr/eventIMG/2016/72431/img_item_0823_01.jpg"
		todayCopy			= "견과류로 건강해지자"
		todayItemname		= "닥터넛츠 오리지널 뉴 30개입"
		todayOrgprice		= "38,700"
		todaySalePrice		= "29,900"
		todaySalePer		= "23%"
		vTimerDate			= DateAdd("d", 1, nowDate)
	Case "2016-08-24"
		todayLinkItem		= "1101573"
		todayImage			= "http://webimage.10x10.co.kr/eventIMG/2016/72431/img_item_0824_01.jpg"
		todayCopy			= "감사를 전하기 가장 좋은 선물"
		todayItemname		= "반테이블감사세트"
		todayOrgprice		= "27,000"
		todaySalePrice		= "22,950"
		todaySalePer		= "15%"
		vTimerDate			= DateAdd("d", 1, nowDate)
	Case "2016-08-25"
		todayLinkItem		= "1498378"
		todayImage			= "http://webimage.10x10.co.kr/eventIMG/2016/72431/img_item_0825_01.jpg"
		todayCopy			= "감귤의 상큼함을 담은 디저트"
		todayItemname		= "제주감귤파이(14개입)"
		todayOrgprice		= "17,500"
		todaySalePrice		= "10,900"
		todaySalePer		= "38%"
		vTimerDate			= DateAdd("d", 1, nowDate)
	Case "2016-08-26", "2016-08-27", "2016-08-28"
		todayLinkItem		= "1346981"
		todayImage			= "http://webimage.10x10.co.kr/eventIMG/2016/72431/img_item_0826_01.jpg"
		todayCopy			= "모든 사람에게 가장 좋은 견과"
		todayItemname		= "프리미엄 5종 견과 선물세트"
		todayOrgprice		= "60,000"
		todaySalePrice		= "39,900"
		todaySalePer		= "34%"
		vTimerDate			= DateAdd("d", 3, "2016-08-26")
	Case "2016-08-29"
		todayLinkItem		= "1313465"
		todayImage			= "http://webimage.10x10.co.kr/eventIMG/2016/72431/img_item_0829_01.jpg"
		todayCopy			= "간편하게 뜯고 즐기는 커피"
		todayItemname		= "더치팩 세트 30 (50mlx30포)"
		todayOrgprice		= "39,000"
		todaySalePrice		= "19,500"
		todaySalePer		= "50%"
		vTimerDate			= DateAdd("d", 1, nowDate)
	Case "2016-08-30"
		todayLinkItem		= "1552453"
		todayImage			= "http://webimage.10x10.co.kr/eventIMG/2016/72431/img_item_0830_01.jpg"
		todayCopy			= "한손에 쏙 들어오는 튜브타입"
		todayItemname		= "튜브허니 버라이어티 세트"
		todayOrgprice		= "39,000"
		todaySalePrice		= "35,000"
		todaySalePer		= "10%"
		vTimerDate			= DateAdd("d", 1, nowDate)
	Case "2016-08-31"
		todayLinkItem		= "1553422"
		todayImage			= "http://webimage.10x10.co.kr/eventIMG/2016/72431/img_item_0831_01.jpg"
		todayCopy			= "인테이크 베스트상품만 모았어요"
		todayItemname		= "인테이크 건강한 간식 선물세트"
		todayOrgprice		= "49,900"
		todaySalePrice		= "39,900"
		todaySalePer		= "20%"
		vTimerDate			= DateAdd("d", 1, nowDate)
	Case "2016-09-01"
		todayLinkItem		= "1199854"
		todayImage			= "http://webimage.10x10.co.kr/eventIMG/2016/72431/img_item_0901_01.jpg"
		todayCopy			= "신선이 먹던 귀한 과실로 만든"
		todayItemname		= "영귤선물세트B"
		todayOrgprice		= "38,000"
		todaySalePrice		= "30,400"
		todaySalePer		= "20%"
		vTimerDate			= DateAdd("d", 1, nowDate)
	Case "2016-09-02", "2016-09-03", "2016-09-04"
		todayLinkItem		= "1468740"
		todayImage			= "http://webimage.10x10.co.kr/eventIMG/2016/72431/img_item_0902_01.jpg"
		todayCopy			= "귀한 꿀을 귀한 당신께"
		todayItemname		= "당산나무 집벌꿀 답례품 中 세트"
		todayOrgprice		= "42,800"
		todaySalePrice		= "40,600"
		todaySalePer		= "5%"
		vTimerDate			= DateAdd("d", 3, "2016-09-02")
	Case "2016-09-05"
		todayLinkItem		= "1548287"
		todayImage			= "http://webimage.10x10.co.kr/eventIMG/2016/72431/img_item_0905_01.jpg"
		todayCopy			= "정성스럽게 만든 수제잼"
		todayItemname		= "'풍성한 한가위' 수제잼 선물세트"
		todayOrgprice		= "41,500"
		todaySalePrice		= "35,270"
		todaySalePer		= "15%"
		vTimerDate			= DateAdd("d", 1, nowDate)
	Case "2016-09-06"
		todayLinkItem		= "1417458"
		todayImage			= "http://webimage.10x10.co.kr/eventIMG/2016/72431/img_item_0906_01.jpg"
		todayCopy			= "건강을 위한 한첩"
		todayItemname		= "[콜록콜록] 한첩 GIFT SET"
		todayOrgprice		= "36,800"
		todaySalePrice		= "31,280"
		todaySalePer		= "15%"
		vTimerDate			= DateAdd("d", 1, nowDate)
	Case "2016-09-07"
		todayLinkItem		= "915263"
		todayImage			= "http://webimage.10x10.co.kr/eventIMG/2016/72431/img_item_0907_01.jpg"
		todayCopy			= "쫄깃쫄깃 달콤한 간식"
		todayItemname		= "명품감말랭이 선물세트(100g×12봉)"
		todayOrgprice		= "42,000"
		todaySalePrice		= "26,900"
		todaySalePer		= "36%"
		vTimerDate			= DateAdd("d", 1, nowDate)
	Case "2016-09-08"
		todayLinkItem		= "1536907"
		todayImage			= "http://webimage.10x10.co.kr/eventIMG/2016/72431/img_item_0908_01.jpg"
		todayCopy			= "면역력을 높여주는 건강젤리"
		todayItemname		= "인테이크 힘내! 홍삼구미"
		todayOrgprice		= "25,000"
		todaySalePrice		= "15,000"
		todaySalePer		= "40%"
		vTimerDate			= DateAdd("d", 1, nowDate)
	Case "2016-09-09", "2016-09-10", "2016-09-11"
		todayLinkItem		= "1426866"
		todayImage			= "http://webimage.10x10.co.kr/eventIMG/2016/72431/img_item_0909_01.jpg"
		todayCopy			= "향긋한 차 한 잔의 행복"
		todayItemname		= "허브차 3종 선물세트"
		todayOrgprice		= "25,500"
		todaySalePrice		= "21,670"
		todaySalePer		= "15%"
		vTimerDate			= DateAdd("d", 3, "2016-09-09")
End Select
%>
<script type="text/javascript">
var yr = "<%=Year(vTimerDate)%>";
var mo = "<%=TwoNumber(Month(vTimerDate))%>";
var da = "<%=TwoNumber(Day(vTimerDate))%>";
var minus_second = 0;
var montharray=new Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")
var today=new Date(<%=Year(sNow)%>, <%=Month(sNow)-1%>, <%=Day(sNow)%>, <%=Hour(sNow)%>, <%=Minute(sNow)%>, <%=Second(sNow)%>);

function countdown(){
	today = new Date(Date.parse(today) + (1000+minus_second));	//서버시간에 1초씩 증가
	var todayy=today.getYear()

	if(todayy < 1000) todayy+=1900;
		
	var todaym=today.getMonth();
	var todayd=today.getDate();
	var todayh=today.getHours();
	var todaymin=today.getMinutes();
	var todaysec=today.getSeconds();
	var todaystring=montharray[todaym]+" "+todayd+", "+todayy+" "+todayh+":"+todaymin+":"+todaysec;
	var futurestring=montharray[mo-1]+" "+da+", "+yr+" 00:00:00";

	dd=Date.parse(futurestring)-Date.parse(todaystring);
	dday=Math.floor(dd/(60*60*1000*24)*1);

	dhour = Math.floor(((dd%(60*60*1000*24))/(60*60*1000)*1));
	dhour = parseInt(dhour)+parseInt(24*dday);

	dmin=Math.floor(((dd%(60*60*1000*24))%(60*60*1000))/(60*1000)*1);
	dsec=Math.floor((((dd%(60*60*1000*24))%(60*60*1000))%(60*1000))/1000*1);

	if(dday < 0) {
		$(".time .timer span").html("0");
		return;
	}

	if(dhour < 10) dhour = "0" + dhour;
	if(dmin < 10) dmin = "0" + dmin;
	if(dsec < 10) dsec = "0" + dsec;
	dhour = dhour+'';
	dmin = dmin+'';
	dsec = dsec+'';

	// Print Time
	$("#j1dRmH1").html(dhour.substr(0,1));
	$("#j1dRmH2").html(dhour.substr(1,1));
	$("#j1dRmM1").html(dmin.substr(0,1));
	$("#j1dRmM2").html(dmin.substr(1,1));
	$("#j1dRmS1").html(dsec.substr(0,1));
	$("#j1dRmS2").html(dsec.substr(1,1));
	
	minus_second = minus_second + 1;

	if (( String(dhour) == '00' ) && ( String(dmin) == '00' ) && ( String(dsec) == '00' )) {
		document.location.reload();
	}else{
		setTimeout("countdown()",1000)
	}
}
$(function(){
	countdown();
});
</script>
</head>
<body>
	<div class="itemWrap">
		<%' for dev msg : 남은 시간 %>
		<div class="time">
			<strong>남은시간</strong>
			<div class="timer">
				<span id="j1dRmH1">9</span>
				<span id="j1dRmH2" class="left">9</span>
				<i></i>
				<span id="j1dRmM1">9</span>
				<span id="j1dRmM2" class="left">9</span>
				<i></i>
				<span id="j1dRmS1">9</span>
				<span id="j1dRmS2" class="left">9</span>
			</div>
		</div>
		<h1><img src="http://webimage.10x10.co.kr/eventIMG/2016/72348/tit_today_present.png" alt="오늘의 특가 선물" /></h1>
		<div class="item">
			<%' for dev msg : 상품링크 %>
			<a href="/shopping/category_prd.asp?itemid=<%= todayLinkItem %>&amp;pEtr=72348" target="_top">
				<%' for dev msg : 이미지 alt값 생략해주세요 %>
				<div class="figure">
					<img src="<%= todayImage %>" width="180" height="180" alt="" />
					<div class="mask"></div>
				</div>
				<span class="copy"><%= todayCopy %></span>
				<span class="name"><%= todayItemname %></span>
				<span class="price"><s><%= todayOrgprice %>원</s> <b><%= todaySalePrice %>원 [<%= todaySalePer %>]</b></span>
			</a>
		</div>
	</div>
</body>
</html>
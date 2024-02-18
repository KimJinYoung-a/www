<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
.todaySpecial {overflow:hidden; position:relative; width:1140px; height:65px; margin:0 auto;}
.todaySpecial h1,
.todaySpecial .time,
.todaySpecial .item {float:left;}
.todaySpecial h1 {width:152px; padding:24px 0 0 177px;}

.todaySpecial .time {width:114px; margin-left:12px; padding-top:25px; border-bottom:1px solid #c1796f; color:#c56659; font-size:11px; font-weight:bold; text-align:center;}
.todaySpecial .time em {color:#7f3d20;}

.todaySpecial .item {position:relative; width:310px; margin-left:24px; padding-left:168px; font-size:11px;}
.todaySpecial .item a:hover {text-decoration:none;}
.todaySpecial .item .figure {position:absolute; top:0; left:0;}
.todaySpecial .item .desc {display:table; width:165px; height:65px; padding-right:13px;}
.todaySpecial .item .desc .inner {display:table-cell; vertical-align:middle;}
.todaySpecial .item .name,
.todaySpecial .item .price {display:block; color:#7f3d20; font-weight:bold;}
.todaySpecial .item .price {color:#dc2c21;}
.todaySpecial .item .price s {color:#c1796f; font-weight:normal;}
.todaySpecial .item .btnGet {position:absolute; top:18px; right:0;}

.todaySpecial .arrow {position:absolute; top:29px; width:49px; height:7px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/75737/img_arrow.png) 50% 0 no-repeat;}
.todaySpecial .arrow1 {left:97px;}
.todaySpecial .arrow2 {right:97px; background-position:50% 100%;}

.todaySpecial .arrow1 {animation:move1 1s infinite alternate;}
@keyframes move1 {
	0% {transform:translateX(-10px);}
	100% {transform:translateX(0);}
}
.todaySpecial .arrow2 {animation:move2 1s infinite alternate;}
@keyframes move2 {
	0% {transform:translateX(10px);}
	100% {transform:translateX(0);}
}
</style>
<%
Dim vTimerDate, nowDate, sNow
Dim todayLinkItem, todayImage, todayCopy, todayItemname, todayOrgprice, todaySalePrice, todaySalePer
nowDate = date()
sNow = now()
'nowDate = "2016-08-22"
'sNow = "2016-08-22 " & Hour(now) & ":" & Minute(now) & ":" & Second(now)

Select Case nowDate
	Case "2017-01-25" , "2017-01-30"
		todayLinkItem		= "1640286"
		todayImage			= "http://webimage.10x10.co.kr/eventIMG/2017/75737/img_item_0130_01.jpg"
		todayCopy			= "좋은것만 담은 프리미엄"
		todayItemname		= "발렌타인데이 프랄린 수제초콜릿 선물세트 10pcs"
		todayOrgprice		= "24,500"
		todaySalePrice		= "19,600"
		todaySalePer		= "20%"
		vTimerDate			= DateAdd("d", 1, nowDate)
	Case "2017-01-31"
		todayLinkItem		= "1424644"
		todayImage			= "http://webimage.10x10.co.kr/eventIMG/2017/75737/img_item_0131_01.jpg"
		todayCopy			= "한입에 살살녹는 파베초콜렛"
		todayItemname		= "디비디 파베 초콜릿 만들기 세트 - With"
		todayOrgprice		= "27,000"
		todaySalePrice		= "22,950"
		todaySalePer		= "15%"
		vTimerDate			= DateAdd("d", 1, nowDate)
	Case "2017-02-01"
		todayLinkItem		= "1639960"
		todayImage			= "http://webimage.10x10.co.kr/eventIMG/2017/75737/img_item_0201_01.jpg"
		todayCopy			= "앙증맞은 픽이 쏙쏙"
		todayItemname		= "메르시파베 초콜릿만들기세트"
		todayOrgprice		= "31,000"
		todaySalePrice		= "21,700"
		todaySalePer		= "30%"
		vTimerDate			= DateAdd("d", 1, nowDate)
	Case "2017-02-02"
		todayLinkItem		= "1639667"
		todayImage			= "http://webimage.10x10.co.kr/eventIMG/2017/75737/img_item_0202_01.jpg"
		todayCopy			= "달콤하고 건강하게"
		todayItemname		= "2017마이보틀아망드"
		todayOrgprice		= "24,000"
		todaySalePrice		= "20,400"
		todaySalePer		= "15%"
		vTimerDate			= DateAdd("d", 1, nowDate)
	Case "2017-02-03", "2017-02-04", "2017-02-05"
		todayLinkItem		= "999831"
		todayImage			= "http://webimage.10x10.co.kr/eventIMG/2017/75737/img_item_0203_01.jpg"
		todayCopy			= "원하는 메시지를 적어보세요"
		todayItemname		= "발렌타인데이 쿠키만들기세트"
		todayOrgprice		= "23,300"
		todaySalePrice		= "18,640"
		todaySalePer		= "20%"
		vTimerDate			= DateAdd("d", 3, "2017-02-03")


	Case "2017-02-06"
		todayLinkItem		= "1445044"
		todayImage			= "http://webimage.10x10.co.kr/eventIMG/2017/75737/img_item_0207_01.jpg"
		todayCopy			= "사르르 녹는 입 안의 행복"
		todayItemname		= "글라소디 파베초콜릿"
		todayOrgprice		= "16,000"
		todaySalePrice		= "13,600"
		todaySalePer		= "15%"
		vTimerDate			= DateAdd("d", 1, nowDate)
	Case "2017-02-07"
		todayLinkItem		= "1421210"
		todayImage			= "http://webimage.10x10.co.kr/eventIMG/2017/75737/img_item_0206_01.jpg"
		todayCopy			= "사랑하는 만큼 줄 수 있는 1+1"
		todayItemname		= "G 로맨틱 플래그 파베초콜릿만들기"
		todayOrgprice		= "29,600"
		todaySalePrice		= "21,800"
		todaySalePer		= "26%"
		vTimerDate			= DateAdd("d", 1, nowDate)
	Case "2017-02-08"
		todayLinkItem		= "1642984"
		todayImage			= "http://webimage.10x10.co.kr/eventIMG/2017/75737/img_item_0208_01.jpg"
		todayCopy			= "다양하게 골라먹는 초콜릿"
		todayItemname		= "스위트 띵스 초콜릿 만들기 세트"
		todayOrgprice		= "29,800"
		todaySalePrice		= "23,840"
		todaySalePer		= "20%"
		vTimerDate			= DateAdd("d", 1, nowDate)
	Case "2017-02-09"
		todayLinkItem		= "1201699"
		todayImage			= "http://webimage.10x10.co.kr/eventIMG/2017/75737/img_item_0209_01.jpg"
		todayCopy			= "쫄깃한 마시멜로가 숨어있어요"
		todayItemname		= "마시멜로 생초콜릿 만들기세트"
		todayOrgprice		= "19,800"
		todaySalePrice		= "14,900"
		todaySalePer		= "25%"
		vTimerDate			= DateAdd("d", 1, nowDate)
	Case "2017-02-10", "2017-02-11", "2017-02-12"
		todayLinkItem		= "1641123"
		todayImage			= "http://webimage.10x10.co.kr/eventIMG/2017/75737/img_item_0210_01.jpg"
		todayCopy			= "믿을 수 있는 재료로 만든"
		todayItemname		= "땡스롤리 수제 카라멜"
		todayOrgprice		= "13,500"
		todaySalePrice		= "12,820"
		todaySalePer		= "5%"
		vTimerDate			= DateAdd("d", 3, "2017-02-10")


	Case "2017-02-13"
		todayLinkItem		= "1424547"
		todayImage			= "http://webimage.10x10.co.kr/eventIMG/2017/75737/img_item_0213_01_v1.jpg"
		todayCopy			= "사르르 녹는 입 안의 행복"
		todayItemname		= "디비디 초콜릿 만들기 세트 - Dear"
		todayOrgprice		= "45,000"
		todaySalePrice		= "31,500"
		todaySalePer		= "30%"
		vTimerDate			= DateAdd("d", 1, nowDate)
	Case "2017-02-14"
		todayLinkItem		= "1580948"
		todayImage			= "http://webimage.10x10.co.kr/eventIMG/2017/75737/img_item_0214_01.jpg"
		todayCopy			= "원하는 토핑으로 꾸며봐요!"
		todayItemname		= "디비디 초콜릿 만들기 세트 - Mon"
		todayOrgprice		= "25,000"
		todaySalePrice		= "20,000"
		todaySalePer		= "20%"
		vTimerDate			= DateAdd("d", 1, nowDate)
	Case "2017-02-15"
		todayLinkItem		= ""
		todayImage			= ""
		todayCopy			= ""
		todayItemname		= ""
		todayOrgprice		= ""
		todaySalePrice		= ""
		todaySalePer		= "%"
		vTimerDate			= DateAdd("d", 1, nowDate)
	Case "2017-02-16"
		todayLinkItem		= ""
		todayImage			= ""
		todayCopy			= ""
		todayItemname		= ""
		todayOrgprice		= ""
		todaySalePrice		= ""
		todaySalePer		= "%"
		vTimerDate			= DateAdd("d", 1, nowDate)
	Case "2017-02-17", "2017-02-18", "2017-02-19"
		todayLinkItem		= ""
		todayImage			= ""
		todayCopy			= ""
		todayItemname		= ""
		todayOrgprice		= ""
		todaySalePrice		= ""
		todaySalePer		= "%"
		vTimerDate			= DateAdd("d", 3, "2017-02-17")
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
		$("#dtime").html("0");
		return;
	}

	if(dhour < 10) dhour = "0" + dhour;
	if(dmin < 10) dmin = "0" + dmin;
	if(dsec < 10) dsec = "0" + dsec;
	dhour = dhour+'';
	dmin = dmin+'';
	dsec = dsec+'';

	// Print Time
	$("#dtime").html(dhour.substr(0,1)+dhour.substr(1,1)+":"+dmin.substr(0,1)+dmin.substr(1,1)+":"+dsec.substr(0,1)+dsec.substr(1,1));

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
	<div class="todaySpecial">
		<h1><img src="http://webimage.10x10.co.kr/eventIMG/2017/75737/tit_today.png" alt="Today&#39;s Special" /></h1>
		<div class="time">남은시간 <em id="dtime">99:99:99</em></div>
		<div class="item">
			<a href="/shopping/category_prd.asp?itemid=<%= todayLinkItem %>&amp;pEtr=75737" target="_top">
				<%'' 썸네일 이미지 alt값은 비워 주세요 %>
				<span class="figure"><img src="<%= todayImage %>" width="140" height="65" alt="" /></span>
				<div class="desc">
					<div class="inner">
						<!-- 상품명 -->
						<span class="name"><%= todayItemname %></span>
						<span class="price"><s><%= todayOrgprice %></s> <%= todaySalePrice %>원 [<%= todaySalePer %>]</span>
					</div>
				</div>
				<span class="btnGet"><img src="http://webimage.10x10.co.kr/eventIMG/2017/75737/btn_get.png" alt="구매하러 가기" /></span>
			</a>
		</div>
		<span class="arrow arrow1"></span>
		<span class="arrow arrow2"></span>
	</div>
</body>
</html>
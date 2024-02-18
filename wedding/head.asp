<%
Dim yyyy, mm, dd, ix, userid, menuid, DdayTab

yyyy=year(now())
userid = getloginuserid()
menuid=request("menuid")
Function ZeroTime(hs)
	If hs<10 Then
		ZeroTime="0"+hs
	Else
		ZeroTime=hs
	End If
End Function

Dim sqlStr, UserName, Sex, PartnerName, WeddingDate, SMS, Email, DateArr, Dday, mode
sqlStr = "SELECT UserName, Sex, PartnerName, WeddingDate, SMS, Email FROM [db_sitemaster].[dbo].[tbl_wedding_user_info] WHERE isusing='Y' and userid='"&userid&"'"
rsget.CursorLocation = adUseClient
rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly
IF Not rsget.Eof Then
	UserName = rsget("UserName")
	Sex  = rsget("Sex")
	PartnerName = rsget("PartnerName")
	WeddingDate = rsget("WeddingDate")
	SMS = rsget("SMS")
	Email = rsget("Email")
	mode="edit"
Else
	Sex="F"
	WeddingDate=yyyy&"-"&Month(now())&"-"&Day(now())
	SMS="Y"
	Email ="Y"
	mode="add"
End IF
rsget.close

DateArr = split(WeddingDate,"-")
Dday = DateDiff("D",Now(),WeddingDate)

If Dday > 80 Then
	DdayTab = 240250
ElseIf Dday >40 And Dday <= 80 Then
	DdayTab = 240256
ElseIf Dday >20 And Dday <= 40 Then
	DdayTab = 240262
ElseIf Dday >0 And Dday <= 20 Then
	DdayTab = 240268
Else
	DdayTab = 240276
End If

If Dday < 1 Then
	If Dday = 0 Then
		Dday="D-day"
	Else
		Dday="D+" + Cstr(Dday*-1)
	End If
Else
	Dday="D-" + Cstr(Dday)
End If
%>
<script type="text/javascript">
$(function(){
	// fixed nav
	var nav1 = $(".wed-nav").offset().top+100;
	$(window).scroll(function() {
		var y = $(window).scrollTop();
		if (nav1 < y ) {
			$(".wed-nav").addClass("fixed-nav");
		}
		else {
			$(".wed-nav").removeClass("fixed-nav");
		}
	});
	// wed-nav스크롤시모션
	$(function () {
		var navbarH = $('.wed-nav').offset().top
		var lastScrollTop = 0,
		delta = 15;
		$(window).scroll(function (event) {
			var st = $(this).scrollTop();
			if (Math.abs(lastScrollTop - st) <= delta) return;
			if ((st > lastScrollTop) && (navbarH < st)) {
				$(".wed-nav").css("top", "-72px");
			} else {
				$(".wed-nav").css("top", "0px");
			}
			lastScrollTop = st;
		});
	});

	// 드롭다운박스
	$(".date dt").click(function(){
		if($(".date dd").is(":hidden")){
			$(this).parent().children('dd').show("slide", {direction:"up"}, 300);
			$(this).addClass("over");
		}else{
			$(this).parent().children('dd').hide("slide", {direction:"up"}, 200);
			$(this).removeClass("over");

		};
	});
	$(".date dd li").click(function(){
		var evtName = $(this).text();
		$(this).parent().parent().parent().children('dt').children('span').empty().append(evtName);
		$(this).parent().parent().hide("slide", { direction: "up" }, 200);
		$(".date dt").removeClass("over");
	});
	// '디데이등록'탭팝업
	$('.enroll-day').hide();
});
</script>
<div class="wed-top">
	<div class="wed-head">
		<h2>
			<a href="/wedding/">
				<span class="t1"><img src="http://fiximage.10x10.co.kr/web2018/wedding2018/tit_all_about_x2.png" alt="all about" /></span>
				<span class="t2"><img src="http://fiximage.10x10.co.kr/web2018/wedding2018/tit_wedding_x2.png" alt="wedding" /></span>
			</a>
		</h2>
		<p class="sub"><img src="http://fiximage.10x10.co.kr/web2018/wedding2018/txt_sub_copy_x2.png" alt="당신의 행복한 시작을 위한 텐바이텐 웨딩 바이블" /></p>
		<% If UserName="" Then %>
		<% If userid<>"" Then %>
		<button class="wd-day" onclick="fnAddWeddingInfo();"><span>D-Day</span><em>웨딩일 등록하고 </br >쿠폰 받기</em></button>
		<% Else %>
		<button class="wd-day" onclick="top.location.href='/login/loginpage.asp?vType=G';"><span>D-Day</span><em>웨딩일 등록하고 </br >쿠폰 받기</em></button>
		<% End If %>
		<% Else %>
		<a href="" onclick="fnAddWeddingInfo();"><div class="wd-day my-wd-day" ><em><%=UserName%>님의 웨딩</em><span><%=Dday%></span></div></a>
		<% End If %>
	</div>

	<!-- 상단탭 -->
	<div class="wed-nav">
		<ul>
			<li<% If menuid="" Or menuid="m1" Then %> class="on"<% End If %>><a href="/wedding/">웨딩 쇼핑리스트</a></li>
			<li<% If menuid="m2" Then %> class="on"<% End If %>><a href="/wedding/kit.asp?menuid=m2">웨딩 세트</a></li>
			<li<% If menuid="m3" Then %> class="on"<% End If %>><a href="/wedding/wedding_evt.asp?menuid=m3">웨딩 기획전</a></li>
			<% If userid<>"" Then %>
			<li class="<% If UserName<>"" Then %>comp<% End If %>" onclick="fnAddWeddingInfo();">
				<a href="">D-day 등록</a>
				<a href=""><span><%=Dday%></span><i></i></a>
			</li>
			<% Else %>
			<% If UserName<>"" Then %>
			<li onclick="fnAddWeddingInfo();">
				<a href=""><span>D-<%=Dday%></span></a>
			</li>
			<% Else %>
			<li onclick="top.location.href='/login/loginpage.asp?vType=G';return false;">
				<a href="">D-day 등록</a>
			</li>
			<% End If %>
			<% End If %>
		</ul>
	</div>
</div>
<!-- 디데이등록하기(4번째탭(팝업)) -->
<!-- #include virtual="/wedding/wedding_info_reg.asp" -->
<!--// 디데이등록하기 -->
<!--// wedding2 상단 -->
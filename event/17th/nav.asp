<%
	dim pageCode	
	dim currentPath
	currentPath = request.ServerVariables("PATH_INFO")	
	
	if currentPath <> "" then
		select case currentPath
			case "/event/17th/index.asp" 		'0 : 메인
				pagecode = 0		
			case "/event/17th/maeliage17th.asp" '1 : 매일받자 마일리지
				pagecode = 1
			case "/event/17th/gacha.asp"		'2 : 100원에 도전하라
				pagecode = 2
			case "/event/17th/gift.asp"			'3 : 구매하고 선물받자	 
				pagecode = 3			
			case "/event/17th/today.asp" 	'4 : 매일매일 화제의 상품 //링크변경
				pagecode = 4
		end select	
	end if	

'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then			
			select case pagecode
				case 0 	
					Response.Redirect "http://m.10x10.co.kr/event/17th/" 
				case 1 	
					Response.Redirect "http://m.10x10.co.kr/event/eventmain.asp?eventid=89073" 
				case 2 	
					Response.Redirect "http://m.10x10.co.kr/event/eventmain.asp?eventid=89309" 
				case 3 	
					Response.Redirect "http://m.10x10.co.kr/event/17th/gift.asp" 
				case 4 	
					Response.Redirect "http://m.10x10.co.kr/event/eventmain.asp?eventid=89541" 
			end select			
			dbget.Close
			REsponse.End
		end if
	end if
end if
%>
<style type="text/css">
.tenten-nav {position:relative; z-index:10; height:203px;  background-image:url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/nav_bg.jpg);background-position: 50% 0;}
.tenten-nav .inner {position:relative; width:1140px; margin:0 auto;}
.tenten-nav strong {position:absolute; left:27px; top:27px;}
.tenten-nav strong a {position:relative;}
.tenten-nav strong a:after {display:inline-block; position:absolute; top:-10px; right:-82px; z-index:5; width:120px; height:115px; background:url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/tit_coupon.png?v=1.01) no-repeat 0 0; content:' '; animation:moveX .8s 500 ease-in-out;}
.tenten-nav strong img {position:relative; z-index:7;}
.tenten-nav .navigator {padding-left:375px;}
.tenten-nav .navigator:after {visibility:hidden; display:block; clear:both; height:0; content:'';}
.tenten-nav .navigator li {position:relative; float:left; width:190px; height:203px;}
.tenten-nav .navigator li a {display:block; height:100%;background:url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/txt_nav_off.png) 0 0 no-repeat; text-indent:-999em;}
.tenten-nav .navigator li a:hover,
.tenten-nav .navigator li a.current {background-image:url(http://webimage.10x10.co.kr/fixevent/event/2018/17th/txt_nav_on.png);}
.tenten-nav .navigator li.nav2 a {background-position:-190px 0;}
.tenten-nav .navigator li.nav3 a {background-position:-380px 0;}
.tenten-nav .navigator li.nav4 a {background-position:-570px 0;}
.tenten-nav .navigator li.nav5 a {background-position:-760px 0;}
@keyframes moveX {from, to{transform:translateX(0);}	50%{transform:translateX(6px)}}
</style>
<div class="tenten-nav">
	<div class="inner">
		<strong><a href="/event/17th/"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/17th/tit_nav_tenten_v2.png" alt="17th 슬기로운 텐텐생활" /></a></strong>
		<ul class="navigator">
			<%'<!-- for dev msg : 현재 보고 있는 페이지에는 클래스 current 붙여주세요 -->%>
			<li class="nav1"><a href="/event/17th/maeliage17th.asp" <%=chkIIF(pageCode=1, "class=""current""","")%> onclick="fnAmplitudeEventMultiPropertiesAction('click_ten17th_nav','evtname','매일받자 마일리지')">매일받자 마일리지</a></li>
			<li class="nav2"><a href="/event/17th/gacha.asp" <%=chkIIF(pageCode=2, "class=""current""","")%> onclick="fnAmplitudeEventMultiPropertiesAction('click_ten17th_nav','evtname','100원에 도전하라')">100원에 도전하라</a></li>
			<li class="nav3"><a href="/event/17th/gift.asp" <%=chkIIF(pageCode=3, "class=""current""","")%> onclick="fnAmplitudeEventMultiPropertiesAction('click_ten17th_nav','evtname','구매하고 선물받자')">구매하고 선물받자</a></li>
			<% if now() < #10/15/2018 00:00:00# then %>
				<li class="nav4"><a href="/diarystory2019/" onclick="fnAmplitudeEventMultiPropertiesAction('click_ten17th_nav','evtname','다이어리스토리')">다이어리 스토리</a></li>      
			<% else %>
				<li class="nav5"><a href="/event/17th/today.asp" <%=chkIIF(pageCode=4, "class=""current""","")%> onclick="fnAmplitudeEventMultiPropertiesAction('click_ten17th_nav','evtname','매일 화제의 상품')">매일매일 화제의 상품</a></li>
			<% end if %>			
			<%'<!-- for dev msg : 10월 14일 이후에 위에 nav4 빼주시고 밑에 nav5 주석 풀어주세요 --> %>			
		</ul>
	</div>
</div>
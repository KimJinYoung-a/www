<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
dim currentdate
	currentdate = date()
	'currentdate = "2016-10-24"
	
	'response.write currentdate
%>
<%
'#######################################################################
'	작업자 전달 사항
'
'	* 어드민에 소스 넣을때 뭐뭐뭐.asp 뒤에 ?eventid=코드 꼭 넣으세요!!
'	* 이 페이지에 소스 수정시 몇 탄이벤트코드 에 해당 코드 넣어주면 됩니다.
'
'#######################################################################
	Dim vEventID, vStartNo
	vEventID = requestCheckVar(Request("eventid"),9)

	If vEventID = "73797" Then
		vStartNo = "0"
	ElseIf vEventID = "73827" Then
		vStartNo = "0"
	ElseIf vEventID = "73828" Then
		vStartNo = "0"
	ElseIf vEventID = "73829" Then
		vStartNo = "0"
	ElseIf vEventID = "73830" Then
		vStartNo = "4"
	ElseIf vEventID = "73832" Then
		vStartNo = "4"
	ElseIf vEventID = "73833" Then
		vStartNo = "5"
	ElseIf vEventID = "73834" Then
		vStartNo = "5"
	else
		vStartNo = "0"
	End IF

%>
<!-- #include virtual="/lib/inc/head.asp" -->
</head>
<body>
<!-- iframe area -->
<script type="text/javascript">
$(function(){
    newBrSwiper = new Swiper('.newBrandNav .swiper-container',{
        initialSlide:<%=vStartNo%>, /* 변경가능하도록 해주세요 */
        loop:false,
        autoplay:false,
        speed:500,
        slidesPerView:'5',
        pagination:false,
        nextButton:'.newBrandNav .btnNext',
        prevButton:'.newBrandNav .btnPrev'
    });

    $('.newBrandNav .btnPrev').on('click', function(e){
        e.preventDefault()
        newBrSwiper.swipePrev()
    });

    $('.newBrandNav .btnNext').on('click', function(e){
        e.preventDefault()
        newBrSwiper.swipeNext()
    });
});
</script>
<style>
.newBrandNav {position:relative; width:1140px; height:75px; margin:0 auto; z-index:1;}
.newBrandNav .swiper-container {width:1000px; height:75px; margin:0 auto;}
.newBrandNav li {position:relative; float:left; width:190px; height:75px; background-position:50% 0; background-repeat:no-repeat; text-indent:-999em;}
.newBrandNav li a {overflow:hidden; display:none; width:190px; height:75px; text-indent:-999em;}
.newBrandNav li.nav1 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73797/tab_nav01.png);}
.newBrandNav li.nav2 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73797/tab_nav02.png);}
.newBrandNav li.nav3 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73797/tab_nav03.png);}
.newBrandNav li.nav4 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73797/tab_nav04.png);}
.newBrandNav li.nav5 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73797/tab_nav05.png);}
.newBrandNav li.nav6 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73797/tab_nav06.png);}
.newBrandNav li.nav7 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73797/tab_nav07.png);}
.newBrandNav li.nav8 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73797/tab_nav08.png);}
.newBrandNav li.current {background-position:50% 100%;}
.newBrandNav li.open a {display:block;}
.newBrandNav .slideNav {overflow:hidden; position:absolute; top:0; width:70px; height:75px; background-position:50% 50%; background-repeat:no-repeat; background-color:transparent; text-indent:-999em; outline:none;}
.newBrandNav .btnPrev {left:0; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73797/btn_nav_prev.png);}
.newBrandNav .btnNext {right:0; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73797/btn_nav_next.png);}
</style>

    <div class="newBrandNav">
        <div class="swiper-container">
            <ul class="swiper-wrapper">
                <!-- for dev msg : 오픈된 페이지 open / 현재 보고있는 페이지 current 클래스 붙여주세요-->
                <li class="swiper-slide nav1 open <%=CHKIIF(vEventID="73797"," current","")%>"><a href="/event/eventmain.asp?eventid=73797" target="_top">10.24 (월)</a></li>

				<% if currentdate < "2016-10-25" then %>
					<li class="swiper-slide nav2">10.25 (화)</li>
				<% Else %>
                    <li class="swiper-slide nav2 open <%=CHKIIF(vEventID="73827"," current","")%>"><a href="/event/eventmain.asp?eventid=73827" target="_top">10.25 (화)</a></li>
                <% end if %>

				<% if currentdate < "2016-10-26" then %>
					<li class="swiper-slide nav3">10.26 (수)</li>
				<% Else %>
                    <li class="swiper-slide nav3 open <%=CHKIIF(vEventID="73828"," current","")%>"><a href="/event/eventmain.asp?eventid=73828" target="_top">10.26 (수)</a></li>
                <% end if %>

				<% if currentdate < "2016-10-27" then %>
					<li class="swiper-slide nav4">10.27 (목)</li>
				<% Else %>
                    <li class="swiper-slide nav4 open <%=CHKIIF(vEventID="73829"," current","")%>"><a href="/event/eventmain.asp?eventid=73829" target="_top">10.27 (목)</a></li>
				<% end if %>

				<% if currentdate < "2016-10-28" then %>
					<li class="swiper-slide nav5">10.28 (금)</li>
				<% Else %>
                    <li class="swiper-slide nav5 open <%=CHKIIF(vEventID="73830"," current","")%>"><a href="/event/eventmain.asp?eventid=73830" target="_top">10.28 (금)</a></li>
                <% end if %>

				<% if currentdate < "2016-10-31" then %>
					<li class="swiper-slide nav6">10.31 (월)</li>
				<% Else %>
                    <li class="swiper-slide nav6 open <%=CHKIIF(vEventID="73832"," current","")%>"><a href="/event/eventmain.asp?eventid=73832" target="_top">10.31 (월)</a></li>
                <% end if %>

				<% if currentdate < "2016-11-01" then %>
					<li class="swiper-slide nav7">11.1 (화)</li>
				<% Else %>
                    <li class="swiper-slide nav7 open <%=CHKIIF(vEventID="73833"," current","")%>"><a href="/event/eventmain.asp?eventid=73833" target="_top">11.1 (화)</a></li>
                <% end if %>

				<% if currentdate < "2016-11-02" then %>
					<li class="swiper-slide nav8">11.2 (수)</li>
				<% Else %>
                    <li class="swiper-slide nav8 open <%=CHKIIF(vEventID="73834"," current","")%>"><a href="/event/eventmain.asp?eventid=73834" target="_top">11.2 (수)</a></li>
                <% end if %>
            </ul>
        </div>
        <button type="button" class="slideNav btnPrev">이전</button>
        <button type="button" class="slideNav btnNext">다음</button>
    </div>
    <!--// iframe area -->
</body>
</html>
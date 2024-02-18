<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#######################################################
'   History :  2019.03.19 정태훈
'   Description : culturestation
'#######################################################
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/classes/culturestation/culturestation_class.asp" -->
<!-- #include virtual="/lib/classes/culturestation/vieweventCls.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
dim oevent , eventstats, listisusing
dim page, evt_code, evt_type, eCode, cEvent, cEventadd
    page = getNumeric(requestCheckVar(request("page"),10))
    if page = "" then page = 1
    evt_code = getNumeric(requestCheckVar(request("evt_code"),10))
	eCode = evt_code
'// 이벤트코드가 숫자인지 체크 아니면 팅겨냄
if evt_code = ""  or not(IsNumeric(evt_code)) then
    response.write "<script>"
    response.write "alert('이벤트코드가 없거나 승인된 페이지가 아닙니다.');"
    response.write "history.go(-1);"
    response.write "</script>"
    dbget.close()   :   response.End
end if

dim vSArray, vSArray2, vSArray3, intSL
'// 이벤트 세부내용
set oevent = new cevent_list
    oevent.frectevt_type = evt_type
    oevent.frectevt_code =  evt_code
    oevent.frectevent_limit = 1
    oevent.fevent_view()

'// 이벤트 시작전이면 STAFF를 제외한 이벤트 메인으로 리다이렉션
if datediff("d",oevent.FOneItem.fstartdate,date)<0 and GetLoginUserLevel<>"7" then
	response.redirect("/culturestation/index.asp")
	dbget.close()   :   response.End
end If

if oevent.FOneItem.fevt_state<7 and GetLoginUserLevel<>"7" then
	response.redirect("/culturestation/index.asp")
	dbget.close()   :   response.End
end If

if oevent.ftotalcount = 0 then
    response.write "<script>"
    response.write "alert('존재 하지 않는 이벤트 입니다');"
    response.write "history.go(-1);"
    response.write "</script>"
    dbget.close()   :   response.End
end if

	set cEvent = new ClsEvtCont
		cEvent.FECode = eCode
	vSArray = oevent.fnGetEventMultiContentsMaster

    If isArray(vSArray) THEN
        For intSL = 0 To UBound(vSArray,2)
            oevent.FMenuIDX = vSArray(0,intSL)
            if vSArray(1,intSL)="1" then
                vSArray2 = oevent.fnGetEventMultiContentsSwife
            end if
            if vSArray(1,intSL)="2" then
                vSArray3 = oevent.fnGetEventMultiContentsVideo
            end if
        Next
	end if

'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 컬쳐스테이션 - " & replace(oevent.FOneItem.fevt_name,"""","")        '페이지 타이틀 (필수)
strPageImage = ""       '페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = "http://10x10.co.kr/cts/" & evt_code           '페이지 URL(SNS 퍼가기용)

eventstats = datediff("d",oevent.FOneItem.fenddate,date())

evt_type= oevent.FOneItem.fevt_type
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<script type="text/javascript">
$(function(){
	$('.evt-sliderV19 .pagination-progressbar-fill').css('background', '<%=oevent.FOneItem.fnEventBarColorCode%>'); // for dev msg : 테마색상 등록

	// 상세 상단 bg
	var posterImg = $('.poster img').attr('src');
	$('.cult-bg .bg-img').css('background-image','url('+posterImg+')');
	
	// contents slider
	$('.evt-sliderV19').each(function(){
		var slider = $(this).find('.slider');
		var amt = slider.find('.slide-item').length;
		var progress = $(this).find('.pagination-progressbar-fill');
		if (amt > 1) {
			slider.on('init', function(){
				var init = (1 / amt).toFixed(2);
				progress.css('transform', 'scaleX(' + init + ') scaleY(1)');
			});
			slider.on('beforeChange', function(event, slick, currentSlide, nextSlide){
				var calc = ( (nextSlide+1) / slick.slideCount ).toFixed(2);
				progress.css('transform', 'scaleX(' + calc + ') scaleY(1)');
			});
			slider.slick({
				autoplay: true,
				arrows: true,
				speed: 750,
				adaptiveHeight: true
			});
		} else {
			$(this).find('.pagination-progressbar').hide();
		}
	});
});
</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container cultureStation">
		<div id="contentWrap">
			<div class="cult-head">
				<h2><a href=""><img src="http://fiximage.10x10.co.kr/web2017/culturestation/tit_cult.png" alt="CULTURE STATION" /></a></h2>
				<p><img src="http://fiximage.10x10.co.kr/web2017/culturestation/txt_cult.png" alt="" /></p>
				<ul class="nav">
					<li class="all<%=chkIIF(evt_type=""," on","")%>"><a href="/culturestation/">전체</a></li>
					<li class="feel<%=chkIIF(evt_type="0"," on","")%>"><a href="/culturestation/?etype=0">느껴봐</a></li>
					<li class="read<%=chkIIF(evt_type="1"," on","")%>"><a href="/culturestation/?etype=1">읽어봐</a></li>
				</ul>
			</div>

			<div class="cultureContent cultureEvt">
				<!-- #include virtual="/culturestation/inc_culturestation_leftmenu.asp" -->
				<div class="content">
					<% IF eventstats > 0 THEN %>
					<% IF NOT(evt_code="2068") THEN %>
					<div class="evtEndWrap">
						<div class="evtEnd">
							<p><strong>앗! 죄송합니다! 종료된 이벤트 입니다.</strong></p>
							<p class="addInfo"><a href="/culturestation/"><span>이벤트 더 둘러보기</span></a></p>
						</div>
					</div>
					<% END IF %>
					<% END IF%>

					<!-- for dev msg : 컨텐츠에 이미지만 등록 될 경우 클래스 fullImg 넣어주세요
					<p class="fullImg"><img src="http://fiximage.10x10.co.kr/web2013/@temp/img_culture_feel.jpg" alt="컬쳐스테이션 이미지" /></p> -->
					<div class="typeI">
						<div class="cult-desc">
							<span class="label"><%=oevent.FOneItem.GetKindName%></span>
							<p class="title"><%=oevent.FOneItem.fevt_name%></p>
                            <div class="poster"><img src="<%=oevent.FOneItem.fimage_main%>" alt=""></div>
						</div>
						<div class="cult-bg"><i class="bg-img"></i></div>
						<% If oevent.FOneItem.fevt_html<>"" Then %>
						<div class="cult-text2"><%=oevent.FOneItem.fevt_html%></div>
                    	<% end if %>
						<!--//<p style="color:#661da7;" class="cult-text1">줄거리</p> -->
						<% If oevent.FOneItem.fevt_html_mo<>"" Then %>
						<div class="cult-text2"><%=oevent.FOneItem.fevt_html_mo%></div>
                    	<% end if %>
						<!-- 멀티 컨텐츠 -->
						<% sbCultureMultiContentsView %>
					</div>
					<!--// typeI -->
					<% if oevent.FOneItem.fcomm_isusing="Y" then %>
					<!-- 코멘트 박스 --> <!-- for dev msg : 컬쳐스테이션 에서는 cmt-group-barV19a 도 같이 붙여주세요 -->
					<div class="cmt-group-barV19 cmt-group-barV19a">
						<div style="background:<%=oevent.FOneItem.fnEventBarColorCode%>;" class="inner"> <!-- for dev msg : 테마색상 등록 -->
							<p class="tit">Comment Event</p>
							<p class="txt"><%=oevent.FOneItem.fcomm_text%></p>
							<p class="date">
								<span><strong>작성 기간 :</strong> <%=formatdate(oevent.FOneItem.fcomm_start,"0000.00.00")%> ~ <%=formatdate(oevent.FOneItem.fcomm_end,"0000.00.00")%></span>
								<span><strong>당첨자 발표 :</strong> <%=formatdate(oevent.FOneItem.fevt_prizedate,"0000.00.00")%></span>
							</p>
							<div class="thumbnail"><% if oevent.FOneItem.ffreebie_img<>"" then %><img src="<%=oevent.FOneItem.ffreebie_img%>" alt=""><% end if %></div>
						</div>
					</div>
                    <% end if %>
					<% if oevent.foneitem.fiscomment then %>
                    <!--코멘트 시작-->
                    <div class="basicCmtWrap tMar50" id="cmt">
						<iframe id="evt_cmt" src="/event/lib/iframe_comment.asp?eventid=<%=evt_code%>&epdate=<%=oevent.FOneItem.fevt_prizedate%>" width="100%" class="autoheight"  frameborder="0" scrolling="no"></iframe>
                        <script type="text/javascript" src="/lib/js/jquery.iframe-auto-height.js"></script>
                    </div>
                    <% end if %>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->
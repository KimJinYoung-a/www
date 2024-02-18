<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			dim mRdSite: mRdSite = requestCheckVar(request("rdsite"),32)
			Response.Redirect "http://m.10x10.co.kr/event/18th/" & chkIIF(mRdSite<>"","?rdsite=" & mRdSite,"")
			REsponse.End
		end if
	end if
end if
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/anniversary18th.css?v=3.00">
</head>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt">
		<div id="contentWrap">
			<div class="eventWrapV15">
				<div class="eventContV15">
					<!-- event area(이미지만 등록될때 / 수작업일때) -->
					<div class="contW">
                        <!-- 18주년댓글이벤트:나에게 텐바이텐은? -->
                        <div class="anniversary18th">
                            <!--// 주년 헤드 -->
                            <div class="intro">
                                <div class="inner">
                                    <h2><a href="/"><img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/tit_18th.png" alt="18th Your 10X10"></a></h2>
                                    <ul class="nav">
                                        <li><a href="/event/eventmain.asp?eventid=97589">스누피의 선물 <span class="icon-chev"></span></a></li>
                                        <li><a href="/event/eventmain.asp?eventid=97588">나에게 텐바이텐은? <span class="icon-chev"></span></a></li>
                                    </ul>
                                </div>
                            </div>
                            <!--// 주년 헤드 -->

                            <!-- 취향 -->
                            <div class="taste">
                                <div class="inner">
                                    <h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/tit_taste.png" alt="오늘, 당신의 취향"></h3>
                                    <div class="qr-code"><img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/img_qr_code.png" alt="qr 코드"></div>
                                    <div class="bnfit"><img src="//webimage.10x10.co.kr/fixevent/event/2019/18th/txt_benefit.png" alt="special gift, gift card"></div>
                                </div>
                            </div>
                            <!--// 취향 -->
                        </div>
                        <!-- // 18주년댓글이벤트:나에게 텐바이텐은? -->
					</div>
					<!-- //event area(이미지만 등록될때 / 수작업일때) -->
				</div>
			</div>
		</div>
	</div>

	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->
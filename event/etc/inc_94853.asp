<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'###########################################################
' Description : 토이스토리4 이벤트 
' History : 2019-06-07 원승현 생성
'###########################################################
%>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
dim oItem
dim evtStartDate, evtEndDate, currentDate
	currentDate =  date()

    evtStartDate = Cdate("2019-06-07")
    evtEndDate = Cdate("2019-06-30")

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  90310
Else
	eCode   =  94853
End If

dim userid, commentcount, i
	userid = GetEncLoginUserID()

commentcount = getcommentexistscount(userid, eCode, "", "", "", "Y")

dim cEComment ,blnFull, cdl, com_egCode, bidx, blnBlogURL, strBlogURL
dim iCTotCnt, arrCList,intCLoop, pagereload
dim iCPageSize, iCCurrpage, isMyComm
dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	cdl			= requestCheckVar(Request("cdl"),3)
	blnFull		= requestCheckVar(Request("blnF"),10)
	blnBlogURL	= requestCheckVar(Request("blnB"),10)
	isMyComm	= requestCheckVar(request("isMC"),1)
	pagereload	= requestCheckVar(request("pagereload"),2)

IF blnFull = "" THEN blnFull = True
IF blnBlogURL = "" THEN blnBlogURL = False

IF iCCurrpage = "" THEN
	iCCurrpage = 1
END IF
IF iCTotCnt = "" THEN
	iCTotCnt = -1
END IF

iCPerCnt = 10		'보여지는 페이지 간격
'한 페이지의 보여지는 열의 수
if blnFull then
	iCPageSize = 9		'풀단이면 15개			'/수기이벤트 둘다 강제 12고정
else
	iCPageSize = 9		'메뉴가 있으면 10개			'/수기이벤트 둘다 강제 12고정
end if

'데이터 가져오기
set cEComment = new ClsEvtComment
	cEComment.FECode 		= eCode
	cEComment.FComGroupCode	= com_egCode
	cEComment.FEBidx    	= bidx
	cEComment.FCPage 		= iCCurrpage	'현재페이지
	cEComment.FPSize 		= iCPageSize	'페이지 사이즈
	if isMyComm="Y" then cEComment.FUserID = userid
	cEComment.FTotCnt 		= iCTotCnt  '전체 레코드 수

	arrCList = cEComment.fnGetComment		'리스트 가져오기
	iCTotCnt = cEComment.FTotCnt '리스트 총 갯수
set cEComment = nothing

iCTotalPage 	=  Int(iCTotCnt/iCPageSize)	'전체 페이지 수
IF (iCTotCnt MOD iCPageSize) > 0 THEN	iCTotalPage = iCTotalPage + 1

'// 전체 유저 참여수(unique user)
Dim strSql, uniqueUserCnt
strSql = " SELECT COUNT(DISTINCT userid) as userCnt FROM db_event.dbo.tbl_event_comment WITH(NOLOCK) WHERE evtcom_using='Y' AND evt_code='"&eCode&"' "
rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly
uniqueUserCnt = rsget("userCnt")
rsget.close
%>
<style type="text/css">
<% If Now() > #06/19/2019 00:00:00# AND Now() < #06/26/2019 00:00:00# Then %>
    .evt94853 {overflow: hidden;}
    .evt94853, .evt94853>div {position: relative; box-sizing: border-box; background-position: 50% 0;}
    .inner {width: 1140px; margin: 0 auto; text-align-last: left;}
    .slick-slide {outline:none;}
    .topic {height: 905px; background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/94853/bg_top.jpg); }
    .topic h2 {position: absolute; bottom: 60px; left: 50%; margin-left: -123px;}
    .topic h2.on { animation:topicani 2.5s  forwards ease-out }
    @keyframes topicani {
        0% {transform:translateY(-1000px); animation-timing-function: ease-in}
        18%,42%,70%,100% {transform:translateY(0); animation-timing-function: ease-out}
        29%{transform:translateY(-110px); animation-timing-function: ease-in}
        55% {transform:translateY(-60px); animation-timing-function: ease-in}
        85% {transform:translateY(-30px); animation-timing-function: ease-in}
    }
    .vod-area {height: 953px; padding-top: 63px; background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/94853/bg_vod.jpg);}
    .vod-area iframe {margin: 43px auto 35px;}
    .info {height: 696px; padding-top: 96px; background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/94853/bg_info.jpg);}
    .info .inner {position: relative;}
    .info .txt {margin-right: 78px;}
    .info.ani .txt {margin-left: -500px; opacity: 1; transition-duration: 1s}
    .info.ani.on .txt {margin-left: 0; opacity: 1;}
    .info .img {position: absolute; top: 20px; right: 80px;}
    .snss {height: 1492px; padding-top: 93px; background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/94853/bg_snss.jpg);}
    .snss:after {content: ''; display: block; clear: both;}
    .snss .rolling {float: left; margin: 50px 25px 0;}
    .snss .rolling.snss1 {width:1082px; height:516px;}
    .snss .rolling.snss2 {width:421px; height:557px;}
    .snss .rolling.snss3 {width:609px; height:397px;}
    .snss span {position: absolute; left: 50%; bottom: 85px; margin-left: -50px;}
    .frd {height: 743px; padding-top:113px; background-color:#fff179;}
    .frd h3 {margin-bottom:130px;}
    .frd .slick-slider {position:relative; width:1125px; height:394px; margin:0 auto;}
    .frd .slick-arrow {position:absolute; top:170px; width:26px; fill:#f3ecb2;}
    .frd .slick-prev {left: 30px; transform: rotateY(180deg);}
    .frd .slick-next{right: 30px;}
    .frd .slick-dots {width: 1125px; height: 68px; margin-top: -462px; }
    .frd .slick-dots li {width: 20%; height: 68px;}
    .frd .slick-dots button {width: 100%; height: 100%;}
    .frd .slick-dots li button {background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/94853/btn_frd.png);}
    .frd .slick-dots li.slick-active button {background-position-y:100%;}
    .frd .slick-dots li:nth-child(2) button {background-position-x: -225px;}
    .frd .slick-dots li:nth-child(3) button {background-position-x: -450px;}
    .frd .slick-dots li:nth-child(4) button {background-position-x: -675px;}
    .frd .slick-dots li:nth-child(5) button {background-position-x: 100%;}
    .evt1 {height: 1540px; padding-top: 123px; background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/94853/bg_evt1.jpg);}
    .evt1 > a {position: absolute;top: 405px;left: 50%;width: 600px;height: 270px;margin-left: -300px;text-indent: -9999px;}
    .evt1 div p + a {display: block; margin-top: 40px;}
    .evt1 .rolling {width: 310px;}
    .evt1 .boxtape {margin-top: 65px;}
    .evt1 .boxtape > div,
    .evt1 .boxtape > a {display: inline-block; vertical-align: middle; margin:0  15px;}
    .evt1 .soldout {display:none; position:absolute; top:880px; left:50%; margin-left:-463px;}

    .evt94853 > .evt2 {min-height: 771px; padding-top: 83px; background: url(//webimage.10x10.co.kr/fixevent/event/2019/94853/bg_evt2.jpg) #793df5  50% -70px;}
    .cmt-area {background-color: #793df5;}
    .cmt-area .cmt-write {width: 1141px; height: 533px; margin: 0 auto; padding-top: 53px; background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/94853/img_slt.jpg); box-sizing: border-box;}
    .cmt-area .cmt-write .radio-area {width: 1035px; margin:0  auto;}
    .cmt-area .cmt-write .radio-area:after {content: ''; display: block; clear: both;}
    .cmt-area .cmt-write .radio-area span {float: left;}
    .cmt-area .cmt-write .radio-area input {position: absolute;left: -9999px;}
    .cmt-area .cmt-write .radio-area label{position: relative; display: inline-block; cursor: pointer; width: 191px; height: 230px; margin: 0 8px; text-indent: -9999px; }
    .cmt-area .cmt-write .radio-area label:before {content: '';display: block; position: absolute; top: -9px; left: 84px; width: 28px;height: 20px; background-color: transparent; background-repeat: no-repeat;}
    .cmt-area .cmt-write .radio-area input:checked+label:before{background-image: url('//webimage.10x10.co.kr/fixevent/event/2019/94853/ico_chk.png');}
    .cmt-area .cmt-write form {text-align: left;}
    .cmt-area .cmt-write form textarea {width: 670px; height: 70px; margin: 94px 0 0 94px; font-size: 18px; color: #444;}
    .cmt-area textarea {display: inline-block; width:770px; height:190px; margin-top: 25px; box-sizing: border-box; border:0; color:#444; font-size:16px; line-height:1.4; font-weight:bold; vertical-align: top;}
    .cmt-area textarea::-webkit-input-placeholder {color: #888;} 
    .cmt-area textarea:-moz-placeholder {color: #888;} 
    .cmt-area textarea::-moz-placeholder {color: #888;} 
    .cmt-area textarea:-ms-input-placeholder {color: #888 !important;} 
    .cmt-area textarea:focus::-webkit-input-placeholder {opacity: 0;} 
    .cmt-area form {position: relative;}
    .cmt-area .now-txt {position:absolute; bottom:10px; left:720px; z-index:150; color:#a2a2a2; font-size:14px;}
    .cmt-area form button {width: 295px; height: 130px; margin: 65px 0 0 30px; background-color: transparent;  text-indent: -9999px;}
    .cmt-list {background-color:#6722f3; padding-top:75px;}
    .cmt-list ul {width: 1110px; margin: 0 auto;}
    .cmt-list ul:after {content:''; display:block; clear:both;}
    .cmt-list li {position: relative; float:left; display: block; width: 333px; height: 304px; padding: 117px 31px 38px; margin: 60px 18px 50px 19px; box-sizing: border-box;}
    .cmt-list li .desc {    overflow: hidden;    font-family: verdana;}
    .cmt-list li .desc .num {    float: left;    font-weight: bold; font-size: 17px;}
    .cmt-list li .desc .writer {    float: right; font-size: 14px;}
    .cmt-list .conts {font-size: 2px; font-family: 'AppleSDGothicNeo-Medium';color:#383838; overflow: hidden;}
    .cmt-list .conts p {margin-top:20px; text-align:left; font-size:16px;}
    .cmt-list li .delete {position: absolute; top: 0; right: 0; padding:10px 20px; font-size: 24px; transform: scaleY(.75);}
    .cmt-list li .delete:hover {text-decoration:none;}
    .cmt-list li.toy-01 {background-color:#ffe9da;}
    .cmt-list li.toy-02 {background-color:#f3d9ff;}
    .cmt-list li.toy-03 {background-color:#ffdcdc;}
    .cmt-list li.toy-04 {background-color:#d6f7ff;}
    .cmt-list li.toy-05 {background-color:#d9ffe0;}
    .cmt-list li:before {content:''; position:absolute; top: 0; left:50%;  display:block; width:148px; height:148px; margin-left:-74px; margin-top: -60px;}
    .cmt-list li.toy-01:before {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/94853/img_cmt_01.png); }
    .cmt-list li.toy-02:before {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/94853/img_cmt_02.png); }
    .cmt-list li.toy-03:before {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/94853/img_cmt_03.png); }
    .cmt-list li.toy-04:before {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/94853/img_cmt_04.png); }
    .cmt-list li.toy-05:before {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/94853/img_cmt_05.png); }
    .paging {height:34px; padding-bottom: 65px; background-color: #6722f3;}
    .paging a {height:34px; line-height:34px; border:0; font-weight:bold; background-color:transparent;}
    .paging a span {width:34px; height:34px; padding:0; font-size:16px; color:#aabdfc; font-family:"malgun Gothic","맑은고딕";}
    .paging a.current {background-color:#0ed14e; border:0; color:#fff; border-radius:580%;}
    .paging a.current span {color:#fff;}
    .paging a.current:hover {background-color:#0ed14e;}
    .paging a:hover {background-color:transparent;}
    .paging a.arrow {width:29px; height:34px; margin:0 8px; background-color:transparent;}
    .paging a.arrow span {display:inline-block; width:28px; height:28px; margin-bottom:2px; background-size:100%; background-position:0 0; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/94853/btn_next.png);}
    .paging a.arrow.first,
    .paging a.arrow.end{display:none;}
    .paging a.arrow.prev span {transform: rotateY(180deg);}
    .pageMove {display:none;}
    .evt94853 .notice {padding: 60px 0; background-color: #1ab5e9; text-align: left; color: #fff; line-height: 2;}
    .evt94853 .notice strong {color: #feffb8; font-weight: normal;}
    .evt94853 .notice .inner {position:relative;}
    .evt94853 .notice h3 {position:absolute; left:0; top:50%; margin-top:-15px; padding-left:220px;}
    .evt94853 .notice ul {margin-left:420px;}
    .evt94853 .notice li {font-size:14px; text-indent:-10px;}
    .evt94853 .notice li + li {margin-top:10px;}
    .evt94853 .bnr-float {position: fixed; right: 50%; bottom: 94px; margin-right: -700px; z-index: 999;}
    .bounce{animation:bounce .7s 20;}
    @keyframes bounce {
        from, to {transform:translateX(0);}
        50% {transform:translateX(-10px);}
    }
    .eventContV15 .bnrTemplate {position: fixed;right: 50%;bottom: 94px;margin-right: -700px;z-index: 999;}
<% Else %>
    .evt94853 {overflow: hidden;}
    .evt94853, .evt94853>div {position: relative; box-sizing: border-box; background-position: 50% 0;}
    .inner {width: 1140px; margin: 0 auto; text-align-last: left;}
    .slick-slide {outline:none;}
    .topic {height: 905px; background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/94853/bg_top.jpg); }
    .topic h2 {position: absolute; bottom: 60px; left: 50%; margin-left: -123px;}
    .topic h2.on { animation:topicani 2.5s  forwards ease-out }
    @keyframes topicani {
        0% {transform:translateY(-1000px); animation-timing-function: ease-in}
        18%,42%,70%,100% {transform:translateY(0); animation-timing-function: ease-out}
        29%{transform:translateY(-110px); animation-timing-function: ease-in}
        55% {transform:translateY(-60px); animation-timing-function: ease-in}
        85% {transform:translateY(-30px); animation-timing-function: ease-in}
    }
    .vod-area {height: 953px; padding-top: 63px; background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/94853/bg_vod.jpg);}
    .vod-area iframe {margin: 43px auto 35px;}
    .info {height: 696px; padding-top: 96px; background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/94853/bg_info.jpg);}
    .info .inner {position: relative;}
    .info .txt {margin-right: 78px;}
    .info.ani .txt {margin-left: -500px; opacity: 1; transition-duration: 1s}
    .info.ani.on .txt {margin-left: 0; opacity: 1;}
    .info .img {position: absolute; top: 20px; right: 80px;}
    .snss {height: 1492px; padding-top: 93px; background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/94853/bg_snss.jpg);}
    .snss:after {content: ''; display: block; clear: both;}
    .snss .rolling {float: left; margin: 50px 25px 0;}
    .snss .rolling.snss1 {width:1082px; height:516px;}
    .snss .rolling.snss2 {width:421px; height:557px;}
    .snss .rolling.snss3 {width:609px; height:397px;}
    .snss span {position: absolute; left: 50%; bottom: 85px; margin-left: -50px;}
    .frd {height: 743px; padding-top:113px; background-color:#fff179;}
    .frd h3 {margin-bottom:130px;}
    .frd .slick-slider {position:relative; width:1125px; height:394px; margin:0 auto;}
    .frd .slick-arrow {position:absolute; top:170px; width:26px; fill:#f3ecb2;}
    .frd .slick-prev {left: 30px; transform: rotateY(180deg);}
    .frd .slick-next{right: 30px;}
    .frd .slick-dots {width: 1125px; height: 68px; margin-top: -462px; }
    .frd .slick-dots li {width: 20%; height: 68px;}
    .frd .slick-dots button {width: 100%; height: 100%;}
    .frd .slick-dots li button {background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/94853/btn_frd.png);}
    .frd .slick-dots li.slick-active button {background-position-y:100%;}
    .frd .slick-dots li:nth-child(2) button {background-position-x: -225px;}
    .frd .slick-dots li:nth-child(3) button {background-position-x: -450px;}
    .frd .slick-dots li:nth-child(4) button {background-position-x: -675px;}
    .frd .slick-dots li:nth-child(5) button {background-position-x: 100%;}
    .evt1 {height: 1540px; padding-top: 123px; background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/94853/bg_evt1.jpg);}
    .evt1 > a {position: absolute;top: 384px;left: 50%;width: 560px;height: 330px;margin-left: -280px;text-indent: -9999px;}
    .evt1 div p + a {display: block; margin-top: 40px;}
    .evt1 .rolling {width: 310px;}
    .evt1 .boxtape {margin-top: 65px;}
    .evt1 .boxtape > div,
    .evt1 .boxtape > a {display: inline-block; vertical-align: middle; margin:0  15px;}
    .evt94853 > .evt2 {min-height: 771px; padding-top: 83px; background: url(//webimage.10x10.co.kr/fixevent/event/2019/94853/bg_evt2.jpg) #793df5  50% -70px;}
    .cmt-area {background-color: #793df5;}
    .cmt-area .cmt-write {width: 1141px; height: 533px; margin: 0 auto; padding-top: 53px; background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/94853/img_slt.jpg); box-sizing: border-box;}
    .cmt-area .cmt-write .radio-area {width: 1035px; margin:0  auto;}
    .cmt-area .cmt-write .radio-area:after {content: ''; display: block; clear: both;}
    .cmt-area .cmt-write .radio-area span {float: left;}
    .cmt-area .cmt-write .radio-area input {position: absolute;left: -9999px;}
    .cmt-area .cmt-write .radio-area label{position: relative; display: inline-block; cursor: pointer; width: 191px; height: 230px; margin: 0 8px; text-indent: -9999px; }
    .cmt-area .cmt-write .radio-area label:before {content: '';display: block; position: absolute; top: -9px; left: 84px; width: 28px;height: 20px; background-color: transparent; background-repeat: no-repeat;}
    .cmt-area .cmt-write .radio-area input:checked+label:before{background-image: url('//webimage.10x10.co.kr/fixevent/event/2019/94853/ico_chk.png');}
    .cmt-area .cmt-write form {text-align: left;}
    .cmt-area .cmt-write form textarea {width: 670px; height: 70px; margin: 94px 0 0 94px; font-size: 18px; color: #444;}
    .cmt-area textarea {display: inline-block; width:770px; height:190px; margin-top: 25px; box-sizing: border-box; border:0; color:#444; font-size:16px; line-height:1.4; font-weight:bold; vertical-align: top;}
    .cmt-area textarea::-webkit-input-placeholder {color: #888;} 
    .cmt-area textarea:-moz-placeholder {color: #888;} 
    .cmt-area textarea::-moz-placeholder {color: #888;} 
    .cmt-area textarea:-ms-input-placeholder {color: #888 !important;} 
    .cmt-area textarea:focus::-webkit-input-placeholder {opacity: 0;} 
    .cmt-area form {position: relative;}
    .cmt-area .now-txt {position:absolute; bottom:10px; left:720px; z-index:150; color:#a2a2a2; font-size:14px;}
    .cmt-area form button {width: 295px; height: 130px; margin: 65px 0 0 30px; background-color: transparent;  text-indent: -9999px;}
    .cmt-list {background-color:#6722f3; padding-top:75px;}
    .cmt-list ul {width: 1110px; margin: 0 auto;}
    .cmt-list ul:after {content:''; display:block; clear:both;}
    .cmt-list li {position: relative; float:left; display: block; width: 333px; height: 304px; padding: 117px 31px 38px; margin: 60px 18px 50px 19px; box-sizing: border-box;}
    .cmt-list li .desc {    overflow: hidden;    font-family: verdana;}
    .cmt-list li .desc .num {    float: left;    font-weight: bold; font-size: 17px;}
    .cmt-list li .desc .writer {    float: right; font-size: 14px;}
    .cmt-list .conts {font-size: 2px; font-family: 'AppleSDGothicNeo-Medium';color:#383838; overflow: hidden;}
    .cmt-list .conts p {margin-top:20px; text-align:left; font-size:16px; word-wrap: break-word; word-break: break-all;}
    .cmt-list li .delete {position: absolute; top: 0; right: 0; padding:10px 20px; font-size: 24px; transform: scaleY(.75);}
    .cmt-list li .delete:hover {text-decoration:none;}
    .cmt-list li.toy-01 {background-color:#ffe9da;}
    .cmt-list li.toy-02 {background-color:#f3d9ff;}
    .cmt-list li.toy-03 {background-color:#d6f7ff;}
    .cmt-list li.toy-04 {background-color:#ffdcdc;}
    .cmt-list li.toy-05 {background-color:#d9ffe0;}
    .cmt-list li:before {content:''; position:absolute; top: 0; left:50%;  display:block; width:148px; height:148px; margin-left:-74px; margin-top: -60px;}
    .cmt-list li.toy-01:before {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/94853/img_cmt_01.png); }
    .cmt-list li.toy-02:before {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/94853/img_cmt_02.png); }
    .cmt-list li.toy-03:before {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/94853/img_cmt_03.png?v=1.00); }
    .cmt-list li.toy-04:before {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/94853/img_cmt_04.png?v=1.00); }
    .cmt-list li.toy-05:before {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/94853/img_cmt_05.png); }
    .paging {height:34px; padding-bottom: 65px; background-color: #6722f3;}
    .paging a {height:34px; line-height:34px; border:0; font-weight:bold; background-color:transparent;}
    .paging a span {width:34px; height:34px; padding:0; font-size:16px; color:#aabdfc; font-family:"malgun Gothic","맑은고딕";}
    .paging a.current {background-color:#0ed14e; border:0; color:#fff; border-radius:580%;}
    .paging a.current span {color:#fff;}
    .paging a.current:hover {background-color:#0ed14e;}
    .paging a:hover {background-color:transparent;}
    .paging a.arrow {width:29px; height:34px; margin:0 8px; background-color:transparent;}
    .paging a.arrow span {display:inline-block; width:28px; height:28px; margin-bottom:2px; background-size:100%; background-position:0 0; background-image:url(http://webimage.10x10.co.kr/fixevent/event/2019/94853/btn_next.png);}
    .paging a.arrow.first,
    .paging a.arrow.end{display:none;}
    .paging a.arrow.prev span {transform: rotateY(180deg);}
    .pageMove {display:none;}
    .evt94853 .notice {padding: 60px 0; background-color: #1ab5e9; text-align: left; color: #fff; line-height: 2;}
    .evt94853 .notice strong {color: #feffb8; font-weight: normal;}
    .evt94853 .notice h3, .evt94853 .notice ul {display: inline-block; vertical-align: middle;}
    .evt94853 .notice h3 {width: 440px; padding-left: 220px; box-sizing: border-box;}
    .evt94853 .notice li {margin-bottom: 10px; font-size: 14px;}
    .bounce{animation:bounce .7s 20;}
    @keyframes bounce {
        from to {transform:translateX(0);}
        50% {transform:translateX(-10px);}
    }
    .eventContV15 .bnrTemplate {position: fixed;right: 50%;bottom: 94px;margin-right: -700px;z-index: 999;}
<% End If %>
</style>
<script type="text/javascript" src="/lib/js/jquery.flowslider.js"></script>
<script>
$(function(){
    $('.topic h2').addClass('on');
    //시놉시스
    $('.rolling').each(function(){
        $(this).slick({
            infinite:true,
            autoplay: true,
            pauseOnHover: false,
        });
    });
    //친구
    $('.slide2').slick({
        fade:true,
        speed: 200,	
        infinite:true,
        pauseOnHover: false,
        dots: true,
        arrows: true,
    });
    $('.frd .slick-arrow').html('<svg xmlns="http://www.w3.org/2000/svg" width="100%" viewBox="0 0 25.969 47"><path id="_" data-name="&gt;"  class="btnArrow" d="M661.533,5242.8l23.807-23.48,2.174,2.15-23.808,23.48Zm0-42.67,2.173-2.15,23.808,23.49-2.174,2.15Z" transform="translate(-661.531 -5197.97)"/></svg>')
    $(window).scroll(function() {
        var st=$(this).scrollTop();
        var wh=window.innerHeight;
        $('.ani').each(function(){
            if(st>$(this).offset().top-wh&& $(this).offset().top+$(this).innerHeight()>st){
                $(this).addClass('on')
            }
            else{$(this).removeClass('on')}
        })
    });

    $('input[name=toy]').click(function(){	        
        $("#spoint").val($(this).val())
    })        
})
</script>
<script>
$(function() {
	<% if pagereload<>"" then %>
		setTimeout("pagedown()",500);
	<% end if %>
});

function pagedown(){
	window.$('html,body').animate({scrollTop:$(".cmt-list").offset().top}, 0);
}

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% If not( currentDate >= evtStartDate and currentDate <= evtEndDate ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
            if(frm.txtcomm1.value == ""){
                alert('내용을 넣어주세요')
                frm.txtcomm1.focus()
                return false;
            }
            frm.txtcomm.value = frm.txtcomm1.value
            frm.action = "/event/lib/comment_process.asp";
            frm.submit();
		<% end if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
		}
		return false;
	<% End IF %>
}

function jsDelComment(cidx)	{
	if(confirm("삭제하시겠습니까?")){
		document.frmdelcom.Cidx.value = cidx;
   		document.frmdelcom.submit();
	}
}

function jsCheckLimit() {
	if ("<%=IsUserLoginOK%>"=="False") {
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
		}
		return false;
	}
}

function fnChkByte(obj) {
    var maxByte = 100; //최대 입력 바이트 수
    var str = obj.value;
    var str_len = str.length;
 
    var rbyte = 0;
    var rlen = 0;
    var one_char = "";
    var str2 = "";
 
    for (var i = 0; i < str_len; i++) {
        one_char = str.charAt(i);
 
        if (escape(one_char).length > 4) {
            rbyte += 2; //한글2Byte
        } else {
            rbyte++; //영문 등 나머지 1Byte
        }
 
        if (rbyte <= maxByte) {
            rlen = i + 1; //return할 문자열 갯수
        }
    }    
 
    if (rbyte > maxByte) {
        alert("한글 "+ (maxByte / 2) +"자 이내로 작성 가능합니다.");
        str2 = str.substr(0, rlen); //문자열 자르기
        obj.value = str2;
        fnChkByte(obj, maxByte);
    } else {
        document.getElementById('byteInfo').innerText = Math.ceil(rbyte / 2);
    }
}
</script>
                                <%' 94853 토이스토리 %>
                                <div class="evt94853">
                                    <div class="topic ani">
                                        <h2><img src="//webimage.10x10.co.kr/fixevent/event/2019/94853/tit.png" alt="토이스토리4"></h2>
                                    </div>
                                    <div class="vod-area">
                                        <h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/94853/tit_vod.png" alt="우리의 여행은 아직 끝나지 않았다!"></h3>
                                        <iframe width="780" height="475" src="https://www.youtube.com/embed/yO7RbAq9uV4" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                                        <div>
                                            <a href="#toy-evt1"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94853/btn_join.png" alt="다양한 이벤트 참여하러 가기"></a>
                                            <a href="#groupBar1"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94853/btn_goods_01.png" alt="토이 스토리 굿즈 구경하기"></a>
                                        </div>
                                    </div>
                                    <div class="info ani">
                                        <div class="inner">
                                            <span class="txt"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94853/txt_info.png" alt="movie info"></span>
                                            <span class="img"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94853/img_info.jpg" alt=""></span>
                                        </div>
                                    </div>
                                    <div class="snss ani">
                                        <div class="inner">
                                            <h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/94853/tit_snss.png" alt="시놉시스"></h3>
                                            <div class="snss1 rolling">
                                                <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/94853/img_snss1_01.jpg" alt="" /></div>
                                                <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/94853/img_snss1_02.jpg" alt="" /></div>
                                                <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/94853/img_snss1_03.jpg" alt="" /></div>
                                                <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/94853/img_snss1_04.jpg" alt="" /></div>
                                            </div>
                                            <div class="snss2 rolling">
                                                <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/94853/img_snss2_01.jpg" alt="" /></div>
                                                <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/94853/img_snss2_02.jpg" alt="" /></div>
                                            </div>
                                            <div class="snss3 rolling">
                                                <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/94853/img_snss3_01.jpg" alt="" /></div>
                                                <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/94853/img_snss3_02.jpg" alt="" /></div>
                                                <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/94853/img_snss3_03.jpg" alt="" /></div>
                                            </div>
                                            <span><img src="//webimage.10x10.co.kr/fixevent/event/2019/94853/txt_snss.png" alt="우리의 여행은 아직 끝나지 않았다!  장난감의 운명을 거부하고 떠난 새 친구 ‘포키’를 찾기 위해 길 위에 나선 "></span>
                                        </div>
                                    </div>
                                    <div class="frd">
                                        <h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/94853/tit_frd.png?" alt="토이 스토리 4의 친구들을 만나보자!"></h3>
                                        <div class="slide2">
                                            <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/94853/img_frd_01.png" alt="우디"></div>
                                            <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/94853/img_frd_02.png" alt="버즈"></div>
                                            <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/94853/img_frd_03.png" alt="보핍"></div>
                                            <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/94853/img_frd_04.png" alt="포키"></div>
                                            <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/94853/img_frd_05.png" alt="버니더키"></div>
                                        </div>
                                    </div>
                                    <% If Now() > #06/19/2019 00:00:00# AND Now() < #06/26/2019 00:00:00# Then %>
                                        <div class="evt1" id="toy-evt1" style="background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/94853/bg_evt1_v1.jpg);">
                                            <div>
                                                <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/94853/img_evt1_v1.png" alt="텐바이텐 배송 박스에 토이 스토리 4 친구들이!?"></p>
                                                <a href="/event/eventmain.asp?eventid=89269" class="bounce"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94853/btn_tenship.png" alt="텐바이텐 배송상품 구경가기"></a>
                                            </div>
                                            <a href="/shopping/category_prd.asp?itemid=2332627&pEtr=94853">박스테이프</a>
                                            <%' for msg : 품절시 레이어 (요청오면 display만 지워주면 됨) %>
                                            <div class="soldout" style="display:none;"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94853/txt_soldout.png" alt="품절"></div>
                                        </div>
                                    <% Else %>
                                        <div class="evt1" id="toy-evt1">
                                            <div>
                                                <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/94853/img_evt1.png?v=1.01" alt="텐바이텐 배송 박스에 <토이 스토리 4> 친구들이!?"></p>
                                                <a href="/event/eventmain.asp?eventid=89269" class="bounce"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94853/btn_tenship.png" alt="텐바이텐 배송상품 구경가기"></a>
                                            </div>
                                            <a href="/shopping/category_prd.asp?itemid=2332627&pEtr=94853">박스테이프</a>
                                        </div>
                                    <% End If %>
                                    <% If Now() > #06/19/2019 00:00:00# AND Now() < #06/26/2019 00:00:00# Then %>

                                    <% Else %>
                                        <div class="evt2">
                                            <p><img src="http://webimage.10x10.co.kr/fixevent/event/2019/94853/img_evt2.png?v=1.01" alt="나만의 최애 <토이 스토리 4> 캐릭터는?"></p>
                                            <!-- 코멘트 영역 -->
                                            <div class="cmt-area">
                                                <!-- 쓰기 -->
                                                <div class="cmt-write">
                                                    <div class="radio-area">
                                                        <span>
                                                            <input type="radio" name="toy" checked="checked" id="toy-01" value="1" />
                                                            <label for="toy-01">우디</label>
                                                        </span>
                                                        <span>
                                                            <input type="radio" name="toy" id="toy-02" value="2" /> 
                                                            <label for="toy-02">버즈</label>
                                                        </span>
                                                        <span>
                                                            <input type="radio" name="toy" id="toy-03" value="3" /> 
                                                            <label for="toy-03">보핍</label>
                                                        </span>
                                                        <span>
                                                            <input type="radio" name="toy" id="toy-04" value="4" /> 
                                                            <label for="toy-04">포키</label>
                                                        </span>
                                                        <span>
                                                            <input type="radio" name="toy" id="toy-05" value="5" /> 
                                                            <label for="toy-05">버니</label>
                                                        </span>
                                                    </div>
                                                    <form name="frmcom" method="post" onSubmit="return false;" >
                                                        <input type="hidden" name="eventid" value="<%=eCode%>">
                                                        <input type="hidden" name="com_egC" value="<%=com_egCode%>">
                                                        <input type="hidden" name="bidx" value="<%=bidx%>">
                                                        <input type="hidden" name="iCC" value="<%=iCCurrpage%>">
                                                        <input type="hidden" name="iCTot" value="">
                                                        <input type="hidden" name="mode" value="add">
                                                        <input type="hidden" id="spoint" name="spoint" value="1">
                                                        <input type="hidden" name="isMC" value="<%=isMyComm%>">
                                                        <input type="hidden" name="pagereload" value="ON">
                                                        <input type="hidden" name="txtcomm">
                                                        <input type="hidden" name="gubunval"> 
                                                        <%' for dev msg : 50자 이내  %> 
                                                        <textarea name="txtcomm1" id="txtcomm1" onClick="jsCheckLimit();" onKeyUp="fnChkByte(this);" maxlength="50" placeholder="띄어쓰기 포함 50자 이내 작성 " ></textarea>
                                                        <%' 글자수 보여주는 영역 %> <p class="now-txt"><span id="byteInfo">0</span> / 50자</p>
                                                        <button type="button" onclick="jsSubmitComment(document.frmcom);return false;">포토 카드 만들기</button>
                                                    </form>
                                                    <form name="frmdelcom" method="post" action = "/event/lib/comment_process.asp" style="margin:0px;">
                                                        <input type="hidden" name="eventid" value="<%=eCode%>">
                                                        <input type="hidden" name="com_egC" value="<%=com_egCode%>">
                                                        <input type="hidden" name="bidx" value="<%=bidx%>">
                                                        <input type="hidden" name="Cidx" value="">
                                                        <input type="hidden" name="mode" value="del">                                        
                                                    </form>
                                                </div>
                                                <!-- 리스트 9개씩 노출 -->
                                                <div class="cmt-list">
                                                    <% IF isArray(arrCList) THEN %>
                                                    <ul>
                                                        <% 
                                                            dim tmpImgCode
                                                            For intCLoop = 0 To UBound(arrCList,2) 

                                                            tmpImgCode = Format00(2, arrCList(3,intCLoop))
                                                        %>                                                
                                                                <li class="toy-<%=tmpImgCode%>">
                                                                    <div class="desc">
                                                                        <p class="num">NO. <%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></p>
                                                                        <p class="writer"><%=printUserId(arrCList(2,intCLoop),2,"*")%></p>
                                                                    </div>
                                                                    <div class="conts">
                                                                        <p><%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%></p>
                                                                    </div>
                                                                    <% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
                                                                        <a href="javascript:jsDelComment('<% = arrCList(0,intCLoop) %>');" class="delete">X</a>
                                                                    <% End If %>
                                                                </li>
                                                        <%
                                                            next
                                                        %>
                                                    </ul>
                                                    <% End If %>
                                                </div>
                                                <div class="pageWrapV15">
                                                    <% IF isArray(arrCList) THEN %>
                                                        <%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
                                                    <% End If %>
                                                </div>
                                            </div>
                                            <!-- // 코멘트 영역 -->
                                        </div>
                                    <% End If %>
                                    <div class="notice">
                                        <div class="inner">
                                            <h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/94853/tit_notice.png" alt="유의사항"></h3>
                                            <ul>
                                                <li>- 당첨자와 수령자는 동일해야 하며, 양도는 불가합니다.</li>
                                                <li>- 정확한 발표를 위해 마이텐바이텐의 개인정보를 업데이트해주세요.</li>
                                                <li>- 이벤트 경품은 내부 사정에 의해 변경될 수 있습니다.</li>
                                                <% If Now() > #06/19/2019 00:00:00# Then %>
                                                    <li>- 텐바이텐 배송 박스에 &lt;토이 스토리 4&gt; 친구들이!? 이벤트 당첨 발표 : 2019년 6월 26일 수요일 <br>(텐바이텐 공지사항 및 인스타그램 DM)</li>
                                                    <li>- 나만의 최애 &lt;토이 스토리 4&gt; 캐릭터는? 이벤트 당첨 발표 : 2019년 6월 19일 수요일 <br>(텐바이텐 공지사항 기재)</li>
                                                <% Else %>
                                                    <li>- 당첨자 발표는 2019년 6월 19일 수요일 공지사항을 통해 진행됩니다.</li>
                                                <% End If %>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <%' // 94853 토이스토리 %>
                                <% if userid="ley330" or userid="greenteenz" or userid="rnldusgpfla" or userid="thensi7" Then %>
                                <div>
                                    참여자수(유니크) : <%=formatnumber(uniqueUserCnt,0)%>명
                                </div>
                                <% End If %>
<!-- #include virtual="/lib/db/dbclose.asp" -->
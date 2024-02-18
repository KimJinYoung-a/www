<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  부모님 모의고사 결과 페이지
' History : 2019-04-29 원승현 
'####################################################
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_evaluatesearchercls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_myfavoriteEventCls.asp" -->
<!-- #include virtual="/lib/classes/enjoy/shoppingchanceCls_B.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%

dim eCode, userid, currenttime
IF application("Svr_Info") = "Dev" THEN
	eCode = "90272"
Else
	eCode = "91452"	
End If

currenttime = now()
userid = requestcheckvar(request("userid"),1000)

'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			dim mRdSite: mRdSite = requestCheckVar(request("rdsite"),32)
			Response.Redirect "https://m.10x10.co.kr/event/etc/parentgraderesult.asp?userid="&server.URLEncode(userid)
			REsponse.End
		end if
	end if
end if

on error resume next

Dim vQuery, examCheck, masterIdx
Dim userNm, parentNm, parentAge, sltvalue, sltyear, sltmonth, sltday, blood, clothsize, footsize, fafood, fadrama
examCheck = FALSE
'// 해당 이벤트를 참여했는지 확인한다.
vQuery = "SELECT idx, userid, userName, parentName FROM [db_temp].[dbo].[tbl_event_parentdayexam_master] WITH (NOLOCK) WHERE userid = '" & Server.URLEncode(tenDec(userid)) & "' "
rsget.CursorLocation = adUseClient
rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
IF Not rsget.Eof Then
    examCheck = TRUE
    userNm = rsget("userName")
    parentNm = rsget("parentName")
    masterIdx = rsget("idx")
Else
    response.write "<script>alert('모의고사 참여 정보가 없습니다.');location.href='https://www.10x10.co.kr/event/etc/parentmocktest.asp';</script>"
    response.end
End If
rsget.close

If Err.Number <> 0 then 
    response.write "<script>alert('모의고사 참여 정보가 없습니다.');location.href='https://www.10x10.co.kr/event/etc/parentmocktest.asp';</script>"
    response.end
End If
On Error Goto 0

Dim c1Result, c2Result, c3Result, c4Result, c5Result, c6Result, c7Result
Dim parentGradeRightCount, parentGradeScore
parentGradeRightCount = 0
If examCheck Then
    vQuery = "SELECT idx, masterIdx, userid, questionNumber, Answer, ISNULL(marking,'') as marking FROM [db_temp].[dbo].[tbl_event_parentdayexam_detail] WITH (NOLOCK) WHERE userid = '" & Server.URLEncode(tenDec(userid)) & "' And masterIdx ='"&masterIdx&"' "
    rsget.CursorLocation = adUseClient
    rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
    IF Not rsget.Eof Then
        do until rsget.Eof
            If Trim(rsget("questionNumber")) = 1 Then
                parentAge = rsget("answer")
                c1Result = rsget("marking")
                If Trim(rsget("marking")) = "O" Then
                    parentGradeRightCount = parentGradeRightCount + 1
                End If
            End If
            If Trim(rsget("questionNumber")) = 2 Then
                sltvalue = split(rsget("answer"),"-")(0)
                sltyear = split(rsget("answer"),"-")(1)
                sltmonth = split(rsget("answer"),"-")(2)
                sltday = split(rsget("answer"),"-")(3)
                c2Result = rsget("marking")
                If Trim(rsget("marking")) = "O" Then
                    parentGradeRightCount = parentGradeRightCount + 1
                End If                
            End If
            If Trim(rsget("questionNumber")) = 3 Then
                blood = rsget("answer")
                c3Result = rsget("marking")
                If Trim(rsget("marking")) = "O" Then
                    parentGradeRightCount = parentGradeRightCount + 1
                End If
            End If
            If Trim(rsget("questionNumber")) = 4 Then
                clothsize = rsget("answer")
                c4Result = rsget("marking")
                If Trim(rsget("marking")) = "O" Then
                    parentGradeRightCount = parentGradeRightCount + 1
                End If
            End If
            If Trim(rsget("questionNumber")) = 5 Then
                footsize = rsget("answer")
                c5Result = rsget("marking")
                If Trim(rsget("marking")) = "O" Then
                    parentGradeRightCount = parentGradeRightCount + 1
                End If
            End If
            If Trim(rsget("questionNumber")) = 6 Then
                fafood = rsget("answer")
                c6Result = rsget("marking")
                If Trim(rsget("marking")) = "O" Then
                    parentGradeRightCount = parentGradeRightCount + 1
                End If
            End If
            If Trim(rsget("questionNumber")) = 7 Then
                fadrama = rsget("answer")
                c7Result = rsget("marking")
                If Trim(rsget("marking")) = "O" Then
                    parentGradeRightCount = parentGradeRightCount + 1
                End If
            End If
        rsget.movenext
        loop
    End If
    rsget.close
End If
parentGradeScore = cInt((parentGradeRightCount/7)*100)
%>
<%
    Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
    snpTitle	= Server.URLEncode("[텐바이텐] 부모님 모의고사")
    snpLink		= Server.URLEncode("https://www.10x10.co.kr/event/etc/parentmocktest.asp")
    snpPre		= Server.URLEncode("10x10 이벤트")
    snpImg		= Server.URLEncode("http://webimage.10x10.co.kr/eventIMG/2019/94152/banMoList20190425161639.JPEG")

    '// Facebook 오픈그래프 메타태그 작성
    strPageTitle = "[텐바이텐 이벤트] 부모님 모의고사"
    strPageKeyword = "[텐바이텐 이밴트] 부모님 모의고사"
    strPageDesc = "나는 부모님에 대해서 얼마나 알고 있을까? 지금 1분 만에 테스트해보세요! "
    strPageUrl = "https://www.10x10.co.kr/event/etc/parentmocktest.asp"
    strPageImage = "http://webimage.10x10.co.kr/eventIMG/2019/94152/banMoList20190425161639.JPEG"
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
.evt94152.result {height:1867px; background-color:#feb6b7; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/94152/bg_02.png), url(//webimage.10x10.co.kr/fixevent/event/2019/94152/bg_pat.png); background-position:50% 0; background-repeat:no-repeat, repeat-x;}
.topic {position:relative; width:1140px; margin:0 auto; padding:106px 0 54px;}
.topic h2 {animation:fadeDown 1.5s 0.1s both;}
.topic p {margin-top:32px;}
@keyframes fadeDown {
	from {transform:translateY(-20px); opacity:0;}
	10% {opacity:0;}
	to {transform:translateY(0); opacity:1;}
}
.topic .dc01 {position:absolute; top:129px; left:22px;}
.topic .dc01 img {animation:dc01 5s infinite both; transform-origin:right bottom;}
.topic .dc01:after {content:' '; position:absolute; bottom:-33px; left:23px; width:200px; height:73px; background:#fff;}
.topic .dc02 {position:absolute; top:245px; right:25px;}
.topic .dc02 img {animation:dc02 4s infinite both;}
.topic .dc02:before {content:' '; position:absolute; bottom:17px; right:21px; z-index:5; width:200px; height:73px; background:#fff;}
.topic .dc02:after {content:' '; position:absolute; top:192px; right:21px; width:48px; height:100px; background:#fff;}
@keyframes dc01 {
	from,to {transform:rotate(0deg);}
	50% {transform:rotate(-3deg);}
}
@keyframes dc02 {
	from,to {transform:rotate(0deg);}
	50% {transform:rotate(3deg);}
}

.evt94152 .inner {position:relative; width:1050px; height:1783px; margin-right:auto; margin-left:auto;}
.evt94152 .hidden {position:absolute; font-size:0; color:transparent; visibility:hidden;}
.evt94152 button {vertical-align:top; background-color:transparent;}

.evt94152 input[type=text] {width:100%; height:36px; font-family:'Roboto','Noto Sans KR'; font-weight:bold; font-size:19px; text-align:center; background-color:transparent; box-sizing:border-box;}
.evt94152 input[type=text]::-webkit-input-placeholder {font-weight:normal; font-size:18px; color:#bab9b9;}
.evt94152 input[type=text]:-ms-input-placeholder {font-weight:normal; font-size:18px; color:#bab9b9;}
.evt94152 input[type=text]::placeholder {font-weight:normal; font-size:18px; color:#bab9b9;}
.evt94152 input[type=text]:read-only {cursor:default;}

.slt {position:relative; font-family:'Roboto','Noto Sans KR';}
.slt dt {position:relative; cursor:default;}
.slt dt span {display:block; overflow:hidden; margin-right:10px; font-size:18px; line-height:36px; color:#bab9b9; white-space:nowrap;}
.slt dt.on span {font-weight:bold; font-size:19px; color:#000;}
.slt dt:after {content:' '; display:inline-block; position:absolute; top:15px; right:9px; width:11px; height:7px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/94152/ico_arr.png) 0 0 no-repeat;}
.slt dt.focus:after {transform:rotate(180deg);}
.slt dd {display:none; position:absolute; top:37px; left:0; z-index:10; width:100%; background:#fff;}
.slt dd ul {padding:5px 0; border:1px solid #000; border-top:0;}
.slt dd ul li {font-size:17px; line-height:30px; cursor:pointer;}

.step1 {position:absolute; top:73px; left:47px; width:955px; height:155px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/94152/tit_step1.png) 0 0 no-repeat;}
.step1 .area {position:absolute; top:60px; left:820px; width:90px;}
.step1 .area input[type=text] {height:30px;}

.quiz {position:absolute; top:228px; left:47px; width:955px; height:637px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/94152/txt_question.png) 125px 66px no-repeat;}
.quiz .area {position:absolute;}
.quiz .area1, .quiz .area7, .quiz .area8 {left:383px;}
.quiz .area2, .quiz .area3, .quiz .area5, .quiz .area6 {left:266px;}
.quiz .area1 {top:54px; width:220px;}
.quiz .area2 {top:120px; width:106px;}
.quiz .area3 {top:187px;}
.quiz .area3 .slt {width:105px; float:left;}
.quiz .area3 .slt:first-child {margin-right:20px;}
.quiz .area3 .slt:nth-child(2) {margin-right:50px;}
.quiz .area3 .slt:nth-child(3) {margin-right:48px;}
.quiz .area4 {top:260px; left:255px;}
.quiz .rdo {float:left; position:relative;}
.quiz .rdo input {position:absolute; width:0; height:0; opacity:0;}
.quiz .rdo label {display:block; position:relative; width:82px; height:36px; font-size:0; color:transparent; cursor:pointer;}
.quiz .rdo label:before {content:' '; display:inline-block; position:absolute; top:10px; left:10px; width:16px; height:16px; border:1px solid #a5a4a0; border-radius:8px; box-sizing:border-box;}
.quiz .rdo input:checked + label:before {border:0; background:#e04a4a;}
.quiz .rdo input:checked + label:after {content:' '; display:inline-block; position:absolute; top:15px; left:15px; width:6px; height:6px; background:#fff; border-radius:3px;}
.quiz .area5 {top:323px; width:106px;}
.quiz .area6 {top:391px; width:106px;}
.quiz .area7 {top:460px; width:229px;}
.quiz .area8 {top:527px; width:229px;}
.quiz .num {position:absolute; top:31px; right:-7px; width:256px; height:144px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/94152/bg_num.png) left bottom no-repeat;}
.quiz .area:after {content:' '; display:inline-block; position:absolute; top:-15px; width:114px; height:86px; background-position:center; background-repeat:no-repeat;}
.quiz .area2:after, .quiz .area3:after, .quiz .area5:after, .quiz .area6:after {left:-164px;}
.quiz .area4:after {left:-153px;}
.quiz .area7:after, .quiz .area8:after {left:-281px;}
.quiz .area.correct:after {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/94152/ico_o.png);}
.quiz .area.wrong:after {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/94152/ico_x.png);}
.txt-result {position:relative; top:888px;}
.share {position:absolute; top:1041px; left:138px;}
.share map area {outline:none;}
</style>
<script>
    $(function(){
        $('#urlshareLink').hide();
    });

    function snschk(snsnum) {
        if(snsnum == "tw") {
            popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');		
        }else if(snsnum=="fb"){
            popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');		
        }else if(snsnum=="url"){
            $('#urlshareLink').show();
            $('#urlshareLink').select();
            document.execCommand('Copy');
            $('#urlshareLink').hide();
            alert("링크 복사가 완료되었습니다.");
            return false;
        }
    }
</script>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt">
		<div id="contentWrap">
            <div class="eventContV15" align="center">
                <div class="contF contW">
                    <div class="evt94152 result">
                        <div class="topic">
                            <h2><img src="//webimage.10x10.co.kr/fixevent/event/2019/94152/tit_parents.png" alt="부모님 모의고사"></h2>
                            <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/94152/subtit.png" alt=""></p>
                            <i class="dc01"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94152/img_deco_01.png" alt=""></i>
                            <i class="dc02"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94152/img_deco_02.png" alt=""></i>
                        </div>
                        <div class="inner">
                            <div class="step1">
                                <h3 class="hidden">부모님에 대해 얼만큼 알고 있나요?</h3>
                                <div class="area"><input type="text" name="" id="" value="<%=userNm%>" readonly></div>
                            </div>
                            <div class="quiz">
                                <div class="area area1"><input type="text" name="" id="" value="<%=parentNm%>" readonly></div>
                                <%' for dev msg : 맞으면 correct / 틀리면 wrong %>
                                <div class="area area2 <% If Trim(c1Result)="O" Then %>correct<% End If %><% If Trim(c1Result)="X" Then %>wrong<% End If %>"><input type="text" name="" id="" value="<%=parentAge%>" readonly></div>
                                <div class="area area3 <% If Trim(c2Result)="O" Then %>correct<% End If %><% If Trim(c2Result)="X" Then %>wrong<% End If %>">
                                    <dl class="slt">
                                        <dt class="on"><span><%=sltvalue%></span></dt>
                                    </dl>
                                    <div class="slt"><input type="text" name="" id="" value="<%=sltyear%>" readonly></div>
                                    <div class="slt"><input type="text" name="" id="" value="<%=sltmonth%>" readonly></div>
                                    <div class="slt"><input type="text" name="" id="" value="<%=sltday%>" readonly></div>
                                </div>
                                <div class="area area4 <% If Trim(c3Result)="O" Then %>correct<% End If %><% If Trim(c3Result)="X" Then %>wrong<% End If %>">
                                    <span class="rdo"><input type="radio" name="blood" id="blood-a" disabled <% If Trim(blood)="A" Then %>checked<% End If %>><label for="blood-a">A형</label></span>
                                    <span class="rdo"><input type="radio" name="blood" id="blood-b" disabled <% If Trim(blood)="B" Then %>checked<% End If %>><label for="blood-b">B형</label></span>
                                    <span class="rdo"><input type="radio" name="blood" id="blood-o" disabled <% If Trim(blood)="O" Then %>checked<% End If %>><label for="blood-o">O형</label></span>
                                    <span class="rdo"><input type="radio" name="blood" id="blood-ab" disabled <% If Trim(blood)="AB" Then %>checked<% End If %>><label for="blood-ab">AB형</label></span>
                                </div>
                                <div class="area area5 <% If Trim(c4Result)="O" Then %>correct<% End If %><% If Trim(c4Result)="X" Then %>wrong<% End If %>">
                                    <div class="slt"><input type="text" name="" id="" value="<%=clothsize%>" readonly></div>
                                </div>
                                <div class="area area6 <% If Trim(c5Result)="O" Then %>correct<% End If %><% If Trim(c5Result)="X" Then %>wrong<% End If %>"><input type="text" name="" id="" value="<%=footsize%>" readonly></div>
                                <div class="area area7 <% If Trim(c6Result)="O" Then %>correct<% End If %><% If Trim(c6Result)="X" Then %>wrong<% End If %>"><input type="text" name="" id="" value="<%=fafood%>" readonly></div>
                                <div class="area area8 <% If Trim(c7Result)="O" Then %>correct<% End If %><% If Trim(c7Result)="X" Then %>wrong<% End If %>"><input type="text" name="" id="" value="<%=fadrama%>" readonly></div>
                                <div class="num">
                                    <!-- for dev msg : 점수 ( 파일명 숫자 _10,20,30,40,50,60,70 ) -->
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2019/94152/txt_<%=parentGradeScore%>.png" alt="">
                                </div>
                            </div>
                            <!-- //quiz -->
                            <p class="txt-result"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94152/txt_result.png" alt="오늘은 부모님과 따뜻한 식사 한 끼 해보세요"></p>
                            <div class="share">
                                <input type="text" id="urlshareLink" value="https://www.10x10.co.kr/event/etc/parentmocktest.asp">
                                <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/94152/txt_share.jpg" alt="친구들에게도 공유해보세요" usemap="#share"></p>
                                <map name="share">
                                    <area shape="rect" coords="450,50,540,130" href="" onclick="snschk('fb');return false;"  alt="페이스북" title="페이스북" />
                                    <area shape="rect" coords="545,50,635,130" href="" onclick="snschk('url');return false;" alt="URL 복사" title="URL 복사" />
                                    <area shape="rect" coords="640,50,730,130" href="" onclick="snschk('tw');return false;" alt="트위터" title="트위터" />
                                </map>
                            </div>
                        </div>
                        <!-- //inner -->
                    </div>
                </div>
            </div> 
            <!-- #include virtual="/lib/inc/incfooter.asp" -->
        </div>
    </div>
</div>
</body>
</html>

<!-- #include virtual="/lib/db/dbclose.asp" -->
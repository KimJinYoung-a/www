<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  부모님 모의고사
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
userid = GetEncLoginUserID()
%>
<%
'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			dim mRdSite: mRdSite = requestCheckVar(request("rdsite"),32)
			Response.Redirect "https://m.10x10.co.kr/event/etc/parentmocktest.asp"
			REsponse.End
		end if
	end if
end if


Dim vQuery, examCheck, masterIdx
Dim userNm, parentNm, parentAge, sltvalue, sltyear, sltmonth, sltday, blood, clothsize, footsize, fafood, fadrama
examCheck = FALSE
'// 해당 이벤트를 참여했는지 확인한다.
vQuery = "SELECT idx, userid, userName, parentName FROM [db_temp].[dbo].[tbl_event_parentdayexam_master] WITH (NOLOCK) WHERE userid = '" & userid & "' "
rsget.CursorLocation = adUseClient
rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
IF Not rsget.Eof Then
    examCheck = TRUE
    userNm = rsget("userName")
    parentNm = rsget("parentName")
    masterIdx = rsget("idx")
End If
rsget.close
Dim c1Result, c2Result, c3Result, c4Result, c5Result, c6Result, c7Result
If examCheck Then
    vQuery = "SELECT idx, masterIdx, userid, questionNumber, Answer, ISNULL(marking,'') as marking FROM [db_temp].[dbo].[tbl_event_parentdayexam_detail] WITH (NOLOCK) WHERE userid = '" & userid & "' And masterIdx ='"&masterIdx&"' "
    rsget.CursorLocation = adUseClient
    rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
    IF Not rsget.Eof Then
        do until rsget.Eof
            If Trim(rsget("questionNumber")) = 1 Then
                parentAge = rsget("answer")
                c1Result = rsget("marking")
            End If
            If Trim(rsget("questionNumber")) = 2 Then
                sltvalue = split(rsget("answer"),"-")(0)
                sltyear = split(rsget("answer"),"-")(1)
                sltmonth = split(rsget("answer"),"-")(2)
                sltday = split(rsget("answer"),"-")(3)
                c2Result = rsget("marking")
            End If
            If Trim(rsget("questionNumber")) = 3 Then
                blood = rsget("answer")
                c3Result = rsget("marking")
            End If
            If Trim(rsget("questionNumber")) = 4 Then
                clothsize = rsget("answer")
                c4Result = rsget("marking")
            End If
            If Trim(rsget("questionNumber")) = 5 Then
                footsize = rsget("answer")
                c5Result = rsget("marking")
            End If
            If Trim(rsget("questionNumber")) = 6 Then
                fafood = rsget("answer")
                c6Result = rsget("marking")
            End If
            If Trim(rsget("questionNumber")) = 7 Then
                fadrama = rsget("answer")
                c7Result = rsget("marking")
            End If
        rsget.movenext
        loop
    End If
    rsget.close
End If

'// 전체 채점이 됐다면 result 페이지로 이동 시킨다.
If Trim(c1Result) <> "" And Trim(c2Result) <> "" And Trim(c3Result) <> "" And Trim(c4Result) <> "" And Trim(c5Result) <> "" And Trim(c6Result) <> "" And Trim(c7Result) <> "" Then
    Response.redirect "/event/etc/parentgraderesult.asp?userid="&Server.URLEncode(tenEnc(userid))
    response.end
End If
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
    dim snpTitle, snpLink, snpPre, snpImg, snptag2
%>
<style type="text/css">
.evt94152.exam {height:2350px; background-color:#feb6b7; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/94152/bg_01.png), url(//webimage.10x10.co.kr/fixevent/event/2019/94152/bg_pat.png); background-position:50% 0; background-repeat:no-repeat, repeat-x;}
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
.slt dt {position:relative; cursor:pointer;}
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

.terms {position:absolute; top:865px; left:137px;}
.terms .box {position:relative; width:777px; height:294px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/94152/bg_terms.png) 0 0 no-repeat;}
.terms .box input {position:absolute; width:0; height:0; opacity:0;}
.terms label {display:block; width:100%; height:100%; font-size:0; background:url(//webimage.10x10.co.kr/fixevent/event/2019/94152/txt_agree.png) 322px 208px no-repeat; cursor:pointer;}
.terms .box label:after {content:' '; display:block; position:absolute; left:322px; bottom:80px; width:18px; height:10px; border-width:0 0 3px 3px; border-style:solid; border-color:#ff4d4d; transform:rotate(-45deg); opacity:0;}
.terms .box input:checked + label:after {opacity:1;}
.terms .btn-terms {position:absolute; top:98px; right:45px;}
.terms .btn-save {display:block; margin:39px auto 0;}
.lyr-terms {display:none; position:absolute; top:771px; left:-1px; z-index:10; width:1050px; padding:92px 0 82px; background-color:rgba(0,0,0,0.8);}
.lyr-terms .btn-close {position:absolute; right:0; top:0; width:100px; height:100px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/94152/btn_close.png) 40% 50% no-repeat; font-size:0;}
.lyr-terms .btn-detail {position:absolute; bottom:96px; right:157px; width:110px; height:50px; font-size:0;}

.step2 {position:absolute; top:1344px; left:47px;}
.step2 h3 {width:955px; height:155px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/94152/tit_step2.png) 0 0 no-repeat; font-size:0; color:transparent;}
.step2:after {content:' '; display:block; width:76px; height:65px; position:absolute; top:48px; right:309px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/94152/ico_correct.png) 0 0 no-repeat; opacity:0; transition:all 1s;}
.step2.active:after {opacity:1;}
.step2 .share {margin-top:48px; font-size:0;}
.step2 button:first-child {margin-right:33px;}

#mask-score {position:absolute; top:0; left:0; z-index:20; width:100%; height:100%; background-color:rgba(0,0,0,0.8);}
.score {position:absolute; top:64px; left:50%; z-index:30; width:980px; height:918px; margin-left:-490px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/94152/bg_score.jpg);}
.card-list {overflow:hidden; width:454px; height:480px; margin:0 262px 0 264px;}
.card-list li {display:none; width:454px; height:480px;}
.tit-card {position:relative; overflow:hidden; width:454px; height:146px; background-position:50%; background-repeat:no-repeat; box-sizing:border-box;}
.c1 .tit-card {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/94152/tit_c1.png);}
.c2 .tit-card {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/94152/tit_c2.png);}
.c3 .tit-card {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/94152/tit_c3.png);}
.c4 .tit-card {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/94152/tit_c4.png);}
.c5 .tit-card {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/94152/tit_c5.png);}
.c6 .tit-card {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/94152/tit_c6.png);}
.c7 .tit-card {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/94152/tit_c7.png);}
.tit-card span {display:inline-block; font-family:'Roboto','Noto Sans KR'; font-weight:bold; font-size:38px; line-height:60px; color:#fb9a1d; letter-spacing:-1px;}
.c1 .tit-card span {position:relative; top:50px; left:50px;}
.c2 .tit-card span {position:absolute; top:50px;}
.c2 .tit-card span:nth-child(1) {right:215px;}
.c2 .tit-card span:nth-child(2) {right:127px;}
.c2 .tit-card span:nth-child(3) {right:47px;}
.c3 .tit-card span {position:relative; top:50px; left:65px;}
.c4 .tit-card span {position:relative; top:50px; left:55px;}
.c5 .tit-card span {position:relative; top:50px; left:75px;}
.c6 .tit-card span {position:relative; top:75px;}
.c7 .tit-card span {position:relative; top:75px;}

.lyr-ing {position:absolute; top:700px; left:50%; z-index:10; height:1050px; margin-left:-478px; background:rgba(216,216,216,0.65);}
</style>
<script>
    $(function(){

        $('#urlshareLink').hide();
        // select
        $(".slt dt").click(function(){
            if( $(this).siblings("dd").is(":hidden") ){
                $(".slt dd").hide();
                $(this).siblings("dd").show();
                $(this).addClass("focus");
            } else {
                $(this).siblings("dd").hide();
                $(this).removeClass("focus");
            };
        });
        $(".slt dd li").click(function(){
            var answer = $(this).text();
            $("#sltvalue").val(answer);
            $(this).parent().parent().siblings("dt").children("span").empty().append(answer);
            $(this).parent().parent().hide();
            $(this).parent().parent().siblings("dt").removeClass("focus").addClass("on");
        });

        <% If sltvalue <> "" Then %>
            $(".slt dd li").parent().parent().siblings("dt").children("span").empty().append('<%=sltvalue%>');
            $(".slt dd li").parent().parent().siblings("dt").removeClass("focus").addClass("on");
        <% End If %>

        <% If examCheck Then %>
            $(".lyr-ing").show();
        <% Else %>
            $(".lyr-ing").hide();
        <% End If %>

        // 약관 popup
        $(".btn-terms").click(function(){
            $(".lyr-terms").show();
        });
        $(".btn-close").click(function(){
            $(".lyr-terms").hide();
        });
        
        // icon
        $(window).scroll(function(){
            var sT = $(this).scrollTop();
            var step2 = $(".terms").offset().top;
            if ( sT > step2 ) {
                $(".step2").addClass("active");
            }
        });

        // 채점카드
        $("#mask-score, .score").hide();
        $(".card-list li").hide();
        $(".card-list li:first").show();
        $(".score .btn-next").click(function(){
            if ($(this).closest("li").hasClass("c7")){
                return false;
            } else {
                $(".card-list li").hide();
                $(this).closest("li").next().show();
            }
        });
    });

    function snschk(snsnum) {
        if(snsnum == "tw") {
            popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');		
        }else if(snsnum=="fb"){
            popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');		
        }else if(snsnum=="pt"){
            pinit('<%=snpLink%>','<%=snpImg%>');
        }
    }

    function saveAnswerParent() {
	    <% If IsUserLoginOK() Then %>
            if ($("#userNm").val()=="") {
                alert("작성자 이름을 입력해주세요.");
                $("#userNm").focus();
                return false;
            }
           if ($("#parentNm").val()=="") {
                alert("부모님 성함을 입력해주세요.");
                $("#parentNm").focus();
                return false;
            }
           if ($("#parentAge").val()=="") {
                alert("부모님 연세를 입력해주세요.");
                $("#parentAge").focus();
                return false;
            }
           if ($("#sltvalue").val()=="") {
                alert("부모님 생년월일을 입력해주세요.");
                return false;
            }
           if ($("#sltyear").val()=="") {
                alert("부모님 생년월일을 입력해주세요.");
                $("#sltyear").focus();
                return false;
            }
           if ($("#sltmonth").val()=="") {
                alert("부모님 생년월일을 입력해주세요.");
                $("#sltmonth").focus();
                return false;
            }
           if ($("#sltday").val()=="") {
                alert("부모님 생년월일을 입력해주세요.");
                $("#sltday").focus();
                return false;
            }
           if ($("#clothsize").val()=="") {
                alert("부모님 옷 사이즈를 입력해주세요.");
                $("#clothsize").focus();
                return false;
            }
           if ($("#footsize").val()=="") {
                alert("부모님 발 사이즈를 입력해주세요.");
                $("#footsize").focus();
                return false;
            }
           if ($("#fafood").val()=="") {
                alert("부모님이 가장 좋아하시는 음식을 입력해주세요.");
                $("#fafood").focus();
                return false;
            }
           if ($("#fadrama").val()=="") {
                alert("부모님이 가장 좋아하시는 드라마를 입력해주세요.");
                $("#fadrama").focus();
                return false;
            }
            if (!$("input:checkbox[name='agree']").is(":checked")) {
                alert("개인정보수집에 동의해 주세요.");
                return false;
            }
            if(confirm("답변을 저장하시면 수정이 불가합니다.\n저장하시겠습니까?")){
                $.ajax({
                    type:"POST",
                    url:"/event/etc/doparentmocktest.asp",
                    data: $("#frmparent").serialize(),
                    dataType: "text",
                    async:false,
                    cache:true,
                    success : function(Data, textStatus, jqXHR){
                        if (jqXHR.readyState == 4) {
                            if (jqXHR.status == 200) {
                                if(Data!="") {
                                    res = Data.split("|");
                                    if (res[0]=="OK")
                                    {
                                        $('.btn-save').hide();
                                        $(".lyr-ing").show();
                                        alert("답변이 저장되었습니다.\n부모님께 페이지를 공유하여 채점을 받아보세요.");
                                        window.$('html,body').animate({scrollTop:$(".step2").offset().top}, 10);
                                        return false;
                                    }
                                    else
                                    {
                                        errorMsg = res[1].replace(">?n", "\n");
                                        alert(errorMsg);
                                        return false;
                                    }
                                } else {
                                    alert("잘못된 접근 입니다.");
                                    parent.location.reload();
                                    return false;
                                }
                            }
                        }
                    },
                    error:function(jqXHR, textStatus, errorThrown){
                        alert("잘못된 접근 입니다.");
                        <% if false then %>
                            //var str;
                            //for(var i in jqXHR)
                            //{
                            //	 if(jqXHR.hasOwnProperty(i))
                            //	{
                            //		str += jqXHR[i];
                            //	}
                            //}
                            //alert(str);
                        <% end if %>
                        return false;
                    }
                });
            }
            else {
                return false;
            }    

            
        <% Else %>
            if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
                top.location.href="/login/loginpage.asp?vType=G";
                return false;
            }
            return false;
        <% End If %>
    }

    function copyUrlSend() {
        <% If IsUserLoginOK() Then %>
            $.ajax({
                type:"GET",
                url:"/event/etc/doparentmocktest.asp?mode=urlcopycheck",
                dataType: "text",
                async:false,
                cache:true,
                success : function(Data, textStatus, jqXHR){
                    if (jqXHR.readyState == 4) {
                        if (jqXHR.status == 200) {
                            if(Data!="") {
                                res = Data.split("|");
                                if (res[0]=="OK")
                                {
                                    $('#urlshareLink').show();
                                    $('#urlshareLink').select();
                                    document.execCommand('Copy');
                                    $('#urlshareLink').hide();
                                    alert("링크 복사가 완료되었습니다.");
                                    return false;
                                }
                                else
                                {
                                    errorMsg = res[1].replace(">?n", "\n");
                                    alert(errorMsg);
                                    return false;
                                }
                            } else {
                                alert("잘못된 접근 입니다.");
                                parent.location.reload();
                                return false;
                            }
                        }
                    }
                },
                error:function(jqXHR, textStatus, errorThrown){
                    alert("잘못된 접근 입니다.");
                    <% if false then %>
                        //var str;
                        //for(var i in jqXHR)
                        //{
                        //	 if(jqXHR.hasOwnProperty(i))
                        //	{
                        //		str += jqXHR[i];
                        //	}
                        //}
                        //alert(str);
                    <% end if %>
                    return false;
                }
            });
        <% Else %>
            if(confirm("로그인을 하셔야 링크 복사가 가능합니다. 로그인 하시겠습니까?")){
                top.location.href="/login/loginpage.asp?vType=G";
                return false;
            }
            return false;
        <% End If %>
    }
</script>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt">
		<div id="contentWrap">
            <div class="eventContV15" align="center">
                <div class="contF contW">
                    <div class="evt94152 exam">
                        <div class="topic">
                            <h2><img src="//webimage.10x10.co.kr/fixevent/event/2019/94152/tit_parents.png" alt="부모님 모의고사"></h2>
                            <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/94152/subtit.png" alt=""></p>
                            <i class="dc01"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94152/img_deco_01.png" alt=""></i>
                            <i class="dc02"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94152/img_deco_02.png" alt=""></i>
                        </div>

                        <div class="inner">
                            <form method="post" name="frmparent" id="frmparent">
                            <input type="hidden" name="sltvalue" id="sltvalue">
                            <input type="hidden" name="mode" value="mocktest">
                            <div class="step1">
                                <h3 class="hidden">부모님에 대해 얼만큼 알고 있나요?</h3>
                                <div class="area"><input type="text" name="userNm" id="userNm" value="<%=userNm%>" placeholder="이름작성"></div>
                            </div>
                            <div class="quiz">
                                <div class="area area1"><input type="text" name="parentNm" id="parentNm" value="<%=parentNm%>" placeholder="부모님 성함 작성"></div>
                                <div class="area area2"><input type="text" name="parentAge" id="parentAge" value="<%=parentAge%>" placeholder="숫자 입력"></div>
                                <div class="area area3">
                                    <dl class="slt">
                                        <dt><span>양력</span></dt>
                                        <dd>
                                            <ul>
                                                <li>양력</li>
                                                <li>음력</li>
                                            </ul>
                                        </dd>
                                    </dl>
                                    <div class="slt"><input type="text" name="sltyear" id="sltyear" value="<%=sltyear%>" placeholder="YYYY"></div>
                                    <div class="slt"><input type="text" name="sltmonth" id="sltmonth"  value="<%=sltmonth%>" placeholder="MM"></div>
                                    <div class="slt"><input type="text" name="sltday" id="sltday"  value="<%=sltday%>" placeholder="DD"></div>
                                </div>
                                <div class="area area4">
                                    <span class="rdo"><input type="radio" name="blood" id="blood-a" value="A" <% If blood="" or blood="A" Then %>checked<% End If %>><label for="blood-a">A형</label></span>
                                    <span class="rdo"><input type="radio" name="blood" id="blood-b" value="B" <% If blood="B" Then %>checked<% End If %>><label for="blood-b">B형</label></span>
                                    <span class="rdo"><input type="radio" name="blood" id="blood-o" value="O" <% If blood="O" Then %>checked<% End If %>><label for="blood-o">O형</label></span>
                                    <span class="rdo"><input type="radio" name="blood" id="blood-ab" value="AB" <% If blood="AB" Then %>checked<% End If %>><label for="blood-ab">AB형</label></span>
                                </div>
                                <div class="area area5">
                                    <div class="slt"><input type="text" name="clothsize" id="clothsize" value="<%=clothsize%>" placeholder="S"></div>
                                </div>
                                <div class="area area6"><input type="text" name="footsize" id="footsize" value="<%=footsize%>" placeholder="숫자 입력"></div>
                                <div class="area area7"><input type="text" name="fafood" id="fafood" value="<%=fafood%>" placeholder="좋아하시는 음식을 작성"></div>
                                <div class="area area8"><input type="text" name="fadrama" id="fadrama" value="<%=fadrama%>" placeholder="즐겨보시는 드라마 작성"></div>
                            </div>
                            </form>
                            <!-- //quiz -->
                            <div class="terms">
                                <div class="box">
                                    <input type="checkbox" name="agree" id="agree"><label for="agree">예, 동의합니다</label>
                                    <button class="btn-terms" title="정보수집 항목 확인"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94152/btn_terms.png" alt="정보수집 항목 확인"></button>
                                </div>
                                <button class="btn-save" onclick="saveAnswerParent();return false;"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94152/btn_save.png" alt="답변 저장하기"></button>
                            </div>
                            <div class="lyr-terms">
                                <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/94152/txt_terms.gif" alt="개인정보약관"></p>
                                <a href="/common/private.asp" class="btn-detail" title="자세히보기" target="_blank">자세히보기</a>
                                <button class="btn-close" title="닫기">닫기</button>
                            </div>
                            <div class="step2">
                                <h3>부모님께 페이지를 공유해서 채점을 받아보세요</h3>
                                <div class="share">
                                    <input type="text" id="urlshareLink" value="https://www.10x10.co.kr/event/etc/parentgrade.asp?userid=<%=Server.URLEncode(tenEnc(userid))%>">
                                    <button onclick="copyUrlSend();return false;"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94152/btn_url.png" alt=""></button>
                                </div>
                            </div>
                        </div>
                        <!-- //inner -->
                        <%'!-- for dev msg : 채점중 %>
                        <div class="lyr-ing"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94152/txt_ing.png?v=1.0" alt="채점 중입니다"></div>
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
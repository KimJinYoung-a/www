<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 오늘도 달콤한 텐몽카페!
' History : 2021.04.23 정태훈 생성
'####################################################
%>
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim currentDate, eventStartDate, eventEndDate
dim eCode, userid, mktTest, subscriptcount, sqlstr, myTeaSet

IF application("Svr_Info") = "Dev" THEN
	eCode = "105351"
    mktTest = true
ElseIf application("Svr_Info")="staging" Then
	eCode = "110793"
    mktTest = true    
Else
	eCode = "110793"
    mktTest = false
End If

if mktTest then
    currentDate = #04/28/2021 09:00:00#
else
    currentDate = date()
end if

eventStartDate = cdate("2021-04-28")		'이벤트 시작일
eventEndDate = cdate("2021-05-11")		'이벤트 종료일

userid = GetEncLoginUserID()

if userid<>"" then
	subscriptcount = getevent_subscriptexistscount(eCode, userid, left(currentDate,10), 2, "")
	sqlstr = "select top 1 sub_opt2"
	sqlstr = sqlstr & " from [db_event].[dbo].[tbl_event_subscript]"
	sqlstr = sqlstr & " where evt_code="& eCode &""
	sqlstr = sqlstr & " and userid='"& userid &"'"
    sqlstr = sqlstr & " and sub_opt1='"& left(currentDate,10) &"'"
	rsget.Open sqlstr,dbget
	IF not rsget.EOF THEN
		myTeaSet = rsget("sub_opt2")
	END IF
	rsget.close
end if
%>
<style type="text/css">
    .evt110793 {max-width:1920px; margin:0 auto; background:#fff;}
    .evt110793 .txt-hidden {text-indent: -9999px; font-size:0;}
    .evt110793 .animate-txt {opacity:0; transform:translateY(10%); transition:all 1s;}
    .evt110793 .animate-txt.on {opacity:1; transform:translateY(0);}

    .evt110793 .topic {position:relative; width:100%; height:751px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/110793/bg_main.jpg) no-repeat 50% 0;}
    .evt110793 .topic h2 {position:absolute; left:50%; top:70px; margin-left:-111px; transform: translateY(1rem); transition:all 1s; opacity:0;}
    .evt110793 .topic h2.on {transform: translateY(0); opacity:1;}
    .evt110793 .topic p {position:absolute; left:50%; top:127px; margin-left:-187.5px; transform: translateY(1rem); transition:all 1s .5s; opacity:0;}
    .evt110793 .topic p.on {transform: translateY(0); opacity:1;}

    .evt110793 .flex {display:flex;}
    .evt110793 .section-01 {position:relative; width:100%; height:1227px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/110793/bg_sub01.jpg) no-repeat 50% 0;}
    .evt110793 .section-01 .contents {position:relative; width:1140px; height:1227px; margin:0 auto;}
    .evt110793 .section-01 .contents .item-01 {position:absolute; left:33px; top:257px; animation: circle 2.5s linear infinite;}
    .evt110793 .section-01 .contents .item-02 {position:absolute; right:61px; top:611px; animation: circle 2s linear infinite reverse;}
    .evt110793 .section-01 .contents .item-03 {position:absolute; left:255px; top:920px; animation: circle 1.8s linear infinite;}

    .evt110793 .section-02 {position:relative; width:100%; height:1551px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/110793/bg_sub02.jpg) no-repeat 50% 0;}
    .evt110793 .section-02 .contents {position:relative; width:1140px; height:1551px; margin:0 auto;}
    .evt110793 .section-02 .contents .item-01 {position:absolute; right:131px; top:390px; animation: updown 1s ease-in-out infinite alternate;}
    .evt110793 .section-02 .contents .btn-grp button {width:240px; height:180px;}
    .evt110793 .section-02 .contents .btn-grp button:nth-child(1) {position:absolute; bottom:230px; left:170px; background:transparent;}
    .evt110793 .section-02 .contents .btn-grp button:nth-child(2) {position:absolute; bottom:230px; left:450px; background:transparent;}
    .evt110793 .section-02 .contents .btn-grp button:nth-child(3) {position:absolute; bottom:230px; left:725px; background:transparent;}
    .evt110793 .section-02 .btn-grp button::before {content:""; display:inline-block; position:absolute; left:103px; top:6px; width:61px; height:59px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/110793/icon_check.png) no-repeat 50% 0; opacity:0;}
    .evt110793 .section-02 .btn-grp button:nth-child(2)::before {left:95px;}
    .evt110793 .section-02 .btn-grp button:nth-child(3)::before {left:91px;}
    .evt110793 .section-02 .btn-grp button.on::before {opacity:1;}
    .evt110793 .section-02 .btn-apply {width:480px; height:88px; position:absolute; left:50%; bottom:132px; transform: translate(-50%,0); background:transparent;}
    .evt110793 .section-02 .contents .item-02 {position:absolute; right:350px; bottom:205px; animation: updown 1s ease-in-out infinite alternate;}

    .evt110793 .section-03 {position:relative; display:none; background:#3d281d;}
    .evt110793 .section-03 .contents {position:relative; width:1140px; height:auto; margin:0 auto;}
    .evt110793 .section-03 .contents .img-arrow {position:absolute; left:50%; top:-30px; transform: translate(-50%,0);}
    .evt110793 .section-03 .select-conts {position:relative;}
    .evt110793 .section-03 .select-conts .tit {position:absolute; left:50%; top:100px; transform: translate(-50%,0);}
    .evt110793 .section-03 .select-conts .sub-txt {display:flex; position:absolute; left:50%; top:140px; transform: translate(-50%,0);}
    .evt110793 .section-03 .select-conts .user-name {padding:0 23px; font-size:33px; color:#fff; font-weight:700;}
    .evt110793 .section-03 .time-select {position:relative;}
    .evt110793 .section-03 .time-select .btn-look {position:absolute; left:50%; bottom:56px; transform: translate(-50%,0); width:440px; height:105px; background:transparent;}
    .evt110793 .section-03 .time-select .icon-arrow {position:absolute; left:329px; bottom:38px;}
    .evt110793 .section-03 .time-select .icon-arrow.on {transform: rotate(180deg);}
    .evt110793 .section-03 .time-more {display:none; padding-bottom:130px;}
    .evt110793 .section-03 .time-more.on {display:block;}

    .evt110793 .sec-tip {position:relative; width:100%; height:463px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/110793/img_tip.jpg?v=2) no-repeat 50% 0;}
    .evt110793 .sec-tip .item-01 {position:absolute; left:50%; top:-50px; transform: translate(-50%,0);}

    .evt110793 .section-04 {position:relative; width:100%; height:831px; margin-top:-1px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/110793/bg_sub03.jpg?v=2) no-repeat 50% 0;}
    .evt110793 .section-04 .contents {position:relative; width:1140px; height:831px; margin:0 auto;}
    .evt110793 .section-04 .contents .item-01 {position:absolute; right:131px; top:230px; animation: updown 1s ease-in-out infinite alternate;}
    .evt110793 .section-04 .contents .btn-goprd {position:absolute; left:235px; top:641px; width:230px; height:57px;}

    .evt110793 .section-05 {position:relative; width:100%; height:1000px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/110793/bg_sub04.jpg) no-repeat 50% 0;}
    .evt110793 .section-05 .contents {position:relative; width:1140px; height:1000px; margin:0 auto;}
    .evt110793 .section-05 .contents .item-01 {position:absolute; right:131px; top:490px; animation: updown 1s ease-in-out infinite alternate;}

    .evt110793 .section-06 {width:100%; height:627px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/110793/img_noti.jpg?v=1.01) no-repeat 50% 0;} 

    @keyframes updown {
        0% {transform: translateY(.5rem);}
        100% {transform: translateY(-.5rem);}
    }
    @keyframes circle {
        0% {transform:rotate(0);}
        100% {transform:rotate(360deg);}
    }
</style>
<script>
$(function() {
    $('.topic h2,.topic p').addClass('on');
    /* 글자,이미지 스르륵 모션 */
    $(window).scroll(function(){
        $('.animate-txt').each(function(){
        var y = $(window).scrollTop() + $(window).height() * 1;
        var imgTop = $(this).offset().top;
        if(y > imgTop) {
            $(this).addClass('on');
        }
        });
    });
    /* event 버튼 선택 */
    $('.btn-grp button').on("click",function(){
        $(this).toggleClass("on").siblings().removeClass("on");
    });
    /* 내가선택한 티타임 보기 */
    $('.btn-apply').on('click',function(){

    });
    /* 다른 컨셉 티타임 구경하기 */
    $('.btn-look').on('click',function(){
        $('.time-more').addClass('on');
        $('.icon-arrow').addClass('on');
    });
    <% if myTeaSet <> "" then %>
    $("#teaImg1").attr("src","//webimage.10x10.co.kr/fixevent/event/2021/110793/tit_txt_0<%=myTeaSet%>.png?v=1.01");
    $("#teaImg2").attr("src","//webimage.10x10.co.kr/fixevent/event/2021/110793/img_select_0<%=myTeaSet%>.jpg?v=2.1");
    $("#teaRest").attr("src","//webimage.10x10.co.kr/fixevent/event/2021/110793/img_event0<%=myTeaSet%>.jpg?v=3.1");
    $('.section-03').show();
    $('.section-02').addClass('on');
    <% end if %>
});

function fnSelectTeaTime(num){
    $("#teaTimeNum").val(num);
    $("#teaImg1").attr("src","//webimage.10x10.co.kr/fixevent/event/2021/110793/tit_txt_0"+num+".png?v=1.01");
    $("#teaImg2").attr("src","//webimage.10x10.co.kr/fixevent/event/2021/110793/img_select_0"+num+".jpg?v=2.1");
    $("#teaRest").attr("src","//webimage.10x10.co.kr/fixevent/event/2021/110793/img_event0"+num+".jpg?v=3.1");
}

var numOfTry="<%=subscriptcount%>";
function doAction() {
	<% if not ( currentDate >= eventStartDate and currentDate <= eventEndDate ) then %>	
		alert("이벤트 참여기간이 아닙니다.");
		return false;
	<% end if %>
    <% If IsUserLoginOK() Then %>
        if(numOfTry == "1"){
			alert("오늘의 이벤트 참여는 완료되었습니다. 내일 또 참여해주세요!");
			return false;
		};
        if($("#teaTimeNum").val()==""){
			alert("티타임을 즐기고 싶은 상황을 골라주세요!");
			return false;
		};
        $.ajax({
            type: "POST",
            url:"/event/etc/doeventsubscript/doEventSubscript110793.asp",
            data: {
                mode: 'add',
                teaTimeNum: $("#teaTimeNum").val()
            },
            dataType: "JSON",
            success: function(data){
                if(data.response == "ok"){
                    fnAmplitudeEventMultiPropertiesAction('click_event_apply','evtcode|option','<%=eCode%>|'+$("#teaTimeNum").val())
                    $('.section-03').show();
                    $('.section-02').addClass('on');
                }else if(data.response == "retry"){
                    alert("오늘의 이벤트 참여는 완료되었습니다. 내일 또 참여해주세요!");
                }
            },
            error: function(data){
                alert('시스템 오류입니다.');
            }
        })
    <% else %>
        jsEventLogin();
        return false;
    <% end if %>
}
function jsEventLogin(){
    if(confirm("로그인을 하셔야 이벤트에 참여하실 수 있습니다.")){
        location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
        return;
    }
}
</script>
                <div class="evt110793">
                    <div class="topic">
                        <h2><img src="//webimage.10x10.co.kr/fixevent/event/2021/110793/tit_logo.png" alt=""></h2>
                        <p><img src="//webimage.10x10.co.kr/fixevent/event/2021/110793/tit_txt.png" alt=""></p>
                    </div>
                    <div class="section-01">
                        <div class="contents">
                            <div class="item-01"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110793/item_01.png" alt="몽쉘"></div>
                            <div class="item-02"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110793/item_02.png" alt="몽쉘"></div>
                            <div class="item-03"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110793/item_02.png" alt="몽쉘"></div>
                        </div>
                    </div>
                    <div class="section-02">
                        <div class="contents">
                            <div class="item-01"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110793/item_03.png" alt="당첨자 100명"></div>
                            <div class="btn-grp">
                                <button type="button" onClick="fnSelectTeaTime(1);"<% if myTeaSet="1" then response.write " class='on'" %>></button>
                                <button type="button" onClick="fnSelectTeaTime(2);"<% if myTeaSet="2" then response.write " class='on'" %>></button>
                                <button type="button" onClick="fnSelectTeaTime(3);"<% if myTeaSet="3" then response.write " class='on'" %>></button>
                                <input type="hidden" id="teaTimeNum">
                            </div>
                            <button type="button" class="btn-apply" onClick="doAction();"></button>
                            <div class="item-02"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110793/icon_click.png" alt="click"></div>
                        </div>
                    </div>
                    <div class="section-03">
                        <div class="contents">
                            <div class="img-arrow"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110793/img_arrow.jpg" alt=""></div>
                            <div class="time-select">
                                <div class="select-conts select-01">
                                    <div class="tit"><img src="" id="teaImg1"></div>
                                    <div class="sub-txt">
                                        <p><img src="//webimage.10x10.co.kr/fixevent/event/2021/110793/tit_txt_sub01.png" alt="즐기고 싶은"></p>
                                        <p class="user-name"><%=GetLoginUserName()%></p>
                                        <p><img src="//webimage.10x10.co.kr/fixevent/event/2021/110793/tit_txt_sub02.png" alt="님"></p>
                                    </div>
                                    <img src="" id="teaImg2">
                                </div>
                                <button type="button" class="btn-look"><span class="icon-arrow"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110793/icon_arrow.png" alt=""></span></button>
                            </div>
                            <div class="time-more">
                                <img src="" id="teaRest">
                            </div>
                        </div>
                    </div>
                    <div class="sec-tip">
                        <div class="item-01"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110793/item_06.png" alt=""></div>
                    </div>
                    <div class="section-04">
                        <div class="contents">
                            <div class="item-01"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110793/item_04.png" alt="선착순 증정"></div>
                            <a href="#mapGroup364759" class="btn-goprd"></a>
                        </div>
                    </div>
                    <div class="section-05">
                        <div class="contents">
                            <div class="item-01"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110793/item_05.png" alt="당첨자 5명"></div>
                        </div>
                    </div>
                    <div class="section-06"><p class="txt-hidden">유의사항</p></div>
                    

                </div>
<!-- #include virtual="/lib/db/dbclose.asp" -->
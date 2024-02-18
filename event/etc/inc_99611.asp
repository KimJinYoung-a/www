<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 이벤트 위시리스트
' History : 2019-09-05 이종화 
'####################################################
%>
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
dim eCode, userid, currentDate , subscriptcount , eventStartDate , eventEndDate
IF application("Svr_Info") = "Dev" THEN
	eCode = "90448"
Else
	eCode = "99611"
End If

userid = GetEncLoginUserID()
dim objCmd , shoppingawardlist , loopInt
dim myordercount , myselectcategoryorderitemscount , myevaluatecount , mygifttalkactioncount

Set objCmd = Server.CreateObject("ADODB.COMMAND")
    With objCmd
        .ActiveConnection = dbget
        .CommandType = adCmdText
        .CommandText = "SELECT userid , summarycount , ranknumber ,gubuncode , startdate , enddate from db_temp.dbo.tbl_event_tenbytenhistory"
        .Prepared = true
        rsget.Open objCmd
        if not rsget.eof then
            shoppingawardlist = rsget.getRows
        end if
        rsget.Close
    End With
Set objCmd = Nothing



if userid <> "" then
    Set objCmd = Server.CreateObject("ADODB.COMMAND")
		With objCmd
			.ActiveConnection = dbget
			.CommandType = adCmdStoredProc
			.CommandText = "[db_log].[dbo].[usp_WWW_MYHistory_List_Get]"
			.Parameters.Append .CreateParameter("@vUserId", adVarChar, adParamInput, Len(userid), userid)
            .Parameters.Append .CreateParameter("@vStartdate", adVarChar, adParamInput, 10, "2019-01-01")
            .Parameters.Append .CreateParameter("@VEnddate", adVarChar, adParamInput, 10, "2019-12-31")
            rsget.Open objCmd
            if not rsget.eof then
                myordercount = rsget(1)
                myselectcategoryorderitemscount = rsget(2)
                myevaluatecount = rsget(3)
                mygifttalkactioncount = rsget(4)
            end if
            rsget.Close
		End With
	Set objCmd = Nothing
end if
%>
<style>
.evt99611 {position: relative;  background-color: #121212;}
.evt99611 > div {position: relative;}
.evt99611 b {font-weight: inherit;}
.evt99611 .hide {display: none; opacity: 0; height: 0; font-size: 0;}
.evt99611 .topic h2 {position: relative; display: block; left: 50%; width: 1920px; margin-left: -960px;}
.evt99611 .topic .ani-bounce {position: absolute; top: 350px; left: 50%; margin-left: 150px; animation:bounce .7s 20;}
.evt99611 .rank-area {position: relative; width: 100%; height: 1600px; margin: -30px auto 0; background: url(//webimage.10x10.co.kr/fixevent/event/2019/99611/bg.png) no-repeat center 0; z-index: 9;}
.evt99611 .rank-area .section {height: 218px; padding-top: 160px;}
.evt99611 .rank-area .section ul {position: relative; left: 50%; width: 850px; height: 86px; margin-left: -335px; text-align: left; overflow: hidden;}
.evt99611 .rank-area .section li {display: inline-block; width: 270px; font-size: 13px; color: #fff;}
.evt99611 .rank-area .section li .score {font-size: 38px; font-weight: bold; line-height: 1.15;}
.evt99611 .rank-area .section li:first-child {width: 330px; font-size: 17px; color: #fff711;}
.evt99611 .rank-area .section li:first-child  .score {font-size: 52px;}
.evt99611 .rank-area .section li:last-child {width: 200px; }
.evt99611 .rank-area .section.sc2 ul, .evt99611 .rank-area .section.sc4 ul {margin-left: -310px;}
.evt99611 .rank-area .section.sc2 ul li, .evt99611 .rank-area .section.sc4 ul li {width: 240px;}
.evt99611 .rank-area .section.sc2 ul li:first-child, .evt99611 .rank-area .section.sc4 ul li:first-child {width: 300px;}
.evt99611 .rank-area .section .bottom {display: block; width: 410px; height: 50px; margin: 30px auto 0; padding: 10px 15px; box-sizing: border-box; font-size: 19px; color: #fff; }
.evt99611 .rank-area .section .bottom > span {float: left;}
.evt99611 .rank-area .section .bottom > .score {float: right;}
.evt99611 .rank-area .section .bottom > .score:after {content: ''; display: inline-block; width: 8px; height: 13px; background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/99611/ico_arrow_wh.png); background-size: contain; background-repeat: no-repeat;}
.evt99611 .rank-area .section .bottom.myscore .score {color: #ff3131;}
.evt99611 .rank-area .section .bottom.myscore > .score:after { background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/99611/ico_arrow_red.png);}
.evt99611 .rank-area .section .bottom:after {content: ''; display: block; clear: both;}
.evt99611 .snow-area {position: absolute; top: 0; left: 0; height: 100%; width: 100%; background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/99611/bg_snow1.png),url(//webimage.10x10.co.kr/fixevent/event/2019/99611/bg_snow2.png),url(//webimage.10x10.co.kr/fixevent/event/2019/99611/bg_snow3.png),url(//webimage.10x10.co.kr/fixevent/event/2019/99611/bg_snow4.png); animation: snow 90s linear infinite;}
@keyframes snow {
	0% {background-position-y: 0,0,0,0;}
	0%, 40%, 80% {background-position-x: -200px, 200px, 200px, -200px;}
    20%, 60%, 100% {background-position-x:0,0,0,0}
    100% {background-position-y: 8000px,7000px,8000px,9000px;}
}
@keyframes bounce {
	from to {transform:translateY(0); animation-timing-function:ease-out;}
	50% {transform:translateY(-10px); animation-timing-function:ease-in;}
}
</style>
<div class="evt99611">
    <div class="topic">
        <h2><img src="//webimage.10x10.co.kr/fixevent/event/2019/99611/tit.jpg?v=1.02" alt="2019텐텐쇼핑대상"></h2>
        <span class="ani-bounce"><img src="//webimage.10x10.co.kr/fixevent/event/2019/99611/ico_bounce.png" alt="12명"></span>
    </div>
    <span class="snow-area"></span>
    <div class="rank-area">
        <div class="section sc1">
            <p class="hide">쇼핑천재</p>
            <ul>
                <% 
                    for loopInt = 0 to ubound(shoppingawardlist,2) 
                        if shoppingawardlist(3,loopInt) = "order" then 
                %>
                <li>
                    <span><%=printUserId(shoppingawardlist(0,loopInt),2,"*")%></span>
                    <p class="score"><b><%=formatnumber(shoppingawardlist(1,loopInt),0)%></b>회</p>
                </li>
                <%
                        end if 
                    next 
                %>
            </ul>
            <% if IsUserLoginOK then %>
            <a href="/my10x10/order/myorderlist.asp" class="bottom myscore">
                <span><b><%=GetLoginUserName%></b>님의 기록</span>
                <div class="score">
                    <b><%=myordercount%></b>회
                </div>
            </a>
            <% else %>
            <a href="/login/loginpage.asp" class="bottom">
                <span>나의 기록은?</span>
                <div class="score">
                    확인하기
                </div>
            </a>
            <% end if %>
        </div>
        <div class="section sc2">
            <p class="hide">문구덕후</p>
            <ul>
                <% 
                    for loopInt = 0 to ubound(shoppingawardlist,2) 
                        if shoppingawardlist(3,loopInt) = "ordercate" then 
                %>
                <li>
                    <span><%=printUserId(shoppingawardlist(0,loopInt),2,"*")%></span>
                    <p class="score"><b><%=formatnumber(shoppingawardlist(1,loopInt),0)%></b>개</p>
                </li>
                <%
                        end if 
                    next 
                %>
            </ul>
            <% if IsUserLoginOK then %>
            <a href="/my10x10/order/order_myItemList.asp" class="bottom myscore">
                <span><b><%=GetLoginUserName%></b>님의 기록</span>
                <div class="score">
                    <b><%=myselectcategoryorderitemscount%></b>개
                </div>
            </a>
            <% else %>
            <a href="/login/loginpage.asp" class="bottom">
                <span>나의 기록은?</span>
                <div class="score">
                    확인하기
                </div>
            </a>
            <% end if %>
        </div>
        <div class="section sc3">
            <p class="hide">후기왕</p>
            <ul>
                <% 
                    for loopInt = 0 to ubound(shoppingawardlist,2) 
                        if shoppingawardlist(3,loopInt) = "evaluate" then 
                %>
                <li>
                    <span><%=printUserId(shoppingawardlist(0,loopInt),2,"*")%></span>
                    <p class="score"><b><%=formatnumber(shoppingawardlist(1,loopInt),0)%></b>개</p>
                </li>
                <%
                        end if 
                    next 
                %>
            </ul>
            <% if IsUserLoginOK then %>
            <a href="/my10x10/goodsusing.asp" class="bottom myscore">
                <span><b><%=GetLoginUserName%></b>님의 기록</span>
                <div class="score">
                    <b><%=myevaluatecount%></b>개
                </div>
            </a>
            <% else %>
            <a href="/login/loginpage.asp" class="bottom">
                <span>나의 기록은?</span>
                <div class="score">
                    확인하기
                </div>
            </a>
            <% end if %>
        </div>
        <div class="section sc4">
            <p class="hide">프로선택러</p>
            <ul>
                <% 
                    for loopInt = 0 to ubound(shoppingawardlist,2) 
                        if shoppingawardlist(3,loopInt) = "gifttalk" then 
                %>
                <li>
                    <span><%=printUserId(shoppingawardlist(0,loopInt),2,"*")%></span>
                    <p class="score"><b><%=formatnumber(shoppingawardlist(1,loopInt),0)%></b>회</p>
                </li>
                <%
                        end if 
                    next 
                %>
            </ul>
            <% if IsUserLoginOK then %>
            <a href="/gift/talk/" class="bottom myscore">
                <span><b><%=GetLoginUserName%></b>님의 기록</span>
                <div class="score">
                    <b><%=mygifttalkactioncount%></b>회
                </div>
            </a>
            <% else %>
            <a href="/login/loginpage.asp" class="bottom">
                <span>나의 기록은?</span>
                <div class="score">
                    확인하기
                </div>
            </a>
            <% end if %>
        </div>
    </div>
    <div class="bnr-area">
        <ul>
            <li style="background-color: #de1482;"><a href="/event/eventmain.asp?eventid=99242" ><img src="//webimage.10x10.co.kr/fixevent/event/2019/99611/bnr_1.jpg?v=1.04" alt="지금 가장 핫한 텐바이텐 BEST 20"></a></li>
            <li style="background-color: #4015a3;"><a href="/event/eventmain.asp?eventid=99222" ><img src="//webimage.10x10.co.kr/fixevent/event/2019/99611/bnr_2.jpg" alt="텐바이텐이 처음이세요? 제가 도와드릴게요!"></a></li>
            <li style="background-color: #0f1c3c;"><a href="/christmas/" ><img src="//webimage.10x10.co.kr/fixevent/event/2019/99611/bnr_3.jpg" alt="당신이 찾고 있는 크리스마스 소품의 모든 것"></a></li>
        </ul>
    </div>
    <p style="background-color: #121212;"><img src="//webimage.10x10.co.kr/fixevent/event/2019/99611/txt_noti.jpg" alt="유의사항"></p>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->
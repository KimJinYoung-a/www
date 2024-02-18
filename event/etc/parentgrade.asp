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

dim eCode, userid, currenttime, questionNumber
IF application("Svr_Info") = "Dev" THEN
	eCode = "90272"
Else
	eCode = "91452"	
End If

currenttime = now()
userid = requestcheckvar(request("userid"),1000)
questionNumber = requestcheckvar(request("qn"),500)
%>
<%
'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			dim mRdSite: mRdSite = requestCheckVar(request("rdsite"),32)
			Response.Redirect "https://m.10x10.co.kr/event/etc/parentgrade.asp?userid="&Server.URLEncode(userid)
			REsponse.End
		end if
	end if
end if

on error resume next

Dim vQuery, examCheck, userNm, parentNm, masterIdx
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


Dim parentAge, sltvalue, sltyear, sltmonth, sltday, blood, clothsize, footsize, fafood, fadrama
Dim c1Result, c2Result, c3Result, c4Result, c5Result, c6Result, c7Result
If examCheck Then
    vQuery = "SELECT idx, masterIdx, userid, questionNumber, Answer, ISNULL(marking,'') as marking FROM [db_temp].[dbo].[tbl_event_parentdayexam_detail] WITH (NOLOCK) WHERE userid = '" & Server.URLEncode(tenDec(userid)) & "' And masterIdx ='"&masterIdx&"' "
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

'// 전체 채점을 했다면 result 페이지로 이동 시킨다.
If Trim(c1Result) <> "" And Trim(c2Result) <> "" And Trim(c3Result) <> "" And Trim(c4Result) <> "" And Trim(c5Result) <> "" And Trim(c6Result) <> "" And Trim(c7Result) <> "" Then
    Response.redirect "/event/etc/parentgraderesult.asp?userid="&Server.URLEncode(userid)
    response.end
End If

If Trim(questionNumber)="" Then
    questionNumber = 1
End If
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
%>
<style type="text/css">
.evt94152 {height:1128px; background-color:#fee9df; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/94152/bg_03.jpg), url(//webimage.10x10.co.kr/fixevent/event/2019/94152/bg_pat.png); background-position:50% 0; background-repeat:no-repeat, repeat-x;}
.evt94152 button {background-color:transparent;}
.score {position:absolute; top:95px; left:50%; z-index:30; width:980px; height:918px; margin-left:-491px;}
.card-list {overflow:hidden; width:454px; height:480px; margin:0 262px 0 264px;}
.card-list li {display:none; width:454px; height:480px;}
.tit-card {position:relative; overflow:hidden; width:454px; height:146px; background-position:50%; background-repeat:no-repeat; box-sizing:border-box;}
.c1 .tit-card {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/94152/tit_c1.png);}
.c2 .tit-card {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/94152/tit_c2.png?v=1.0);}
.c3 .tit-card {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/94152/tit_c3.png?v=1.0);}
.c4 .tit-card {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/94152/tit_c4.png?v=1.0);}
.c5 .tit-card {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/94152/tit_c5.png);}
.c6 .tit-card {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/94152/tit_c6.png);}
.c7 .tit-card {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/94152/tit_c7.png);}
.tit-card span {display:inline-block; font-family:'Roboto','Noto Sans KR'; font-weight:bold; font-size:38px; line-height:60px; color:#fb9a1d; letter-spacing:-1px;}
.c1 .tit-card span {position:relative; top:50px; left:50px;}
.c2 .tit-card span {position:absolute; top:75px;}
.c2 .tit-card span:nth-child(1) {right:337px; font-size:36px;}
.c2 .tit-card span:nth-child(2) {right:245px;}
.c2 .tit-card span:nth-child(3) {right:157px;}
.c2 .tit-card span:nth-child(4) {right:77px;}
.c3 .tit-card span {position:relative; top:50px; left:70px;}
.c4 .tit-card span {position:relative; top:50px; left:60px;}
.c5 .tit-card span {position:relative; top:50px; left:75px;}
.c6 .tit-card span {position:relative; top:75px;}
.c7 .tit-card span {position:relative; top:75px;}
.score .rdo {float:left; position:relative;}
.score .rdo:first-child {margin-right:31px;}
.score .rdo input {position:absolute; width:0; height:0; opacity:0;}
.score .rdo label {display:block; width:115px; height:115px; font-size:0; color:transparent; background:url(//webimage.10x10.co.kr/fixevent/event/2019/94152/bg_ox.png) 100% 0 no-repeat; cursor:pointer;}
.score .rdo:first-child label {background-position-x:0;}
.score .rdo input:checked + label {background-position-y:100%;}
.score .ox {overflow:hidden; width:261px; margin:0 auto;}
.score .btn-next {display:block; margin:43px auto 0;}
.score .page {margin-top:45px; font-family:'Roboto','Noto Sans KR'; font-size:17px; color:#828188;}
.score .page b {position:relative; top:-17px; padding-right:8px; font-weight:bold; color:#ff790d;}
.score .page b:after {content:' '; position:absolute; right:5px; top:5px; width:1px; height:28px; background-color:#7f7e85; transform:rotate(45deg);}
</style>
<script>
$(function(){
	// score
	$(".card-list li").hide();
	$(".card-list .c<%=questionNumber%>").show();
});

function gradeCheck(qn, chk) {
    var marking = $(':radio[name="c'+qn+'"]:checked').val();
    if (marking=="" || typeof marking=="undefined") {
        if (qn=="7") {
            alert("O/X를 선택하신 후 채점완료 버튼을 클릭 해주세요.");
        } else {
            alert("O/X를 선택하신 후 다음버튼을 클릭 해주세요.");
        }
        return false;
    } else {
        $.ajax({
            type:"GET",
            url:"/event/etc/doparentmocktest.asp?mode=grade&qnuserid=<%=Server.URLEncode(userid)%>&qnmasteridx=<%=masterIdx%>&qn="+qn+"&marking="+marking,
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
                                if ($(chk).closest("li").hasClass("c7")){
                                    location.href='/event/etc/parentgraderesult.asp?userid=<%=server.URLEncode(userid)%>'
                                    return false;
                                } else {
                                    $(".card-list li").hide();
                                    $(chk).closest("li").next().show();
                                }
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
}
</script>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt">
		<div id="contentWrap">
            <div class="eventContV15" align="center">
                <div class="contF contW">
                    <div class="evt94152">
                        <div class="score">
                            <h2><img src="//webimage.10x10.co.kr/fixevent/event/2019/94152/tit_score.png" alt="부모님 모의고사"></h2>
                            <ol class="card-list">
                                <li class="c1">
                                    <div class="tit-card">
                                        <span><%=parentAge%></span>
                                    </div>
                                    <div class="ox">
                                        <span class="rdo"><input type="radio" name="c1" id="c1_o" value="O"><label for="c1_o">O</label></span>
                                        <span class="rdo"><input type="radio" name="c1" id="c1_x" value="X"><label for="c1_x">X</label></span>
                                    </div>
                                    <button class="btn-next" title="다음" onclick="gradeCheck('1', this);"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94152/btn_next.png" alt="다음"></button>
                                    <div class="page"><b>1</b>7</div>
                                </li>
                                <li class="c2">
                                    <div class="tit-card">
                                        <span><%=sltvalue%></span>
                                        <span><%=sltyear%></span>
                                        <span><%=sltmonth%></span>
                                        <span><%=sltday%></span>
                                    </div>
                                    <div class="ox">
                                        <span class="rdo"><input type="radio" name="c2" id="c2_o" value="O"><label for="c2_o">O</label></span>
                                        <span class="rdo"><input type="radio" name="c2" id="c2_x" value="X"><label for="c2_x">X</label></span>
                                    </div>
                                    <button class="btn-next" title="다음" onclick="gradeCheck('2', this);"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94152/btn_next.png" alt="다음"></button>
                                    <div class="page"><b>2</b>7</div>
                                </li>
                                <li class="c3">
                                    <div class="tit-card">
                                        <span><%=blood%></span>
                                    </div>
                                    <div class="ox">
                                        <span class="rdo"><input type="radio" name="c3" id="c3_o" value="O"><label for="c3_o">O</label></span>
                                        <span class="rdo"><input type="radio" name="c3" id="c3_x" value="X"><label for="c3_x">X</label></span>
                                    </div>
                                    <button class="btn-next" title="다음" onclick="gradeCheck('3', this);"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94152/btn_next.png" alt="다음"></button>
                                    <div class="page"><b>3</b>7</div>
                                </li>
                                <li class="c4">
                                    <div class="tit-card">
                                        <span><%=clothsize%></span>
                                    </div>
                                    <div class="ox">
                                        <span class="rdo"><input type="radio" name="c4" id="c4_o" value="O"><label for="c4_o">O</label></span>
                                        <span class="rdo"><input type="radio" name="c4" id="c4_x" value="X"><label for="c4_x">X</label></span>
                                    </div>
                                    <button class="btn-next" title="다음" onclick="gradeCheck('4', this);"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94152/btn_next.png" alt="다음"></button>
                                    <div class="page"><b>4</b>7</div>
                                </li>
                                <li class="c5">
                                    <div class="tit-card">
                                        <span><%=footsize%></span>
                                    </div>
                                    <div class="ox">
                                        <span class="rdo"><input type="radio" name="c5" id="c5_o" value="O"><label for="c5_o">O</label></span>
                                        <span class="rdo"><input type="radio" name="c5" id="c5_x" value="X"><label for="c5_x">X</label></span>
                                    </div>
                                    <button class="btn-next" title="다음" onclick="gradeCheck('5', this);"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94152/btn_next.png" alt="다음"></button>
                                    <div class="page"><b>5</b>7</div>
                                </li>
                                <li class="c6">
                                    <div class="tit-card">
                                        <span><%=fafood%></span>
                                    </div>
                                    <div class="ox">
                                        <span class="rdo"><input type="radio" name="c6" id="c6_o" value="O"><label for="c6_o">O</label></span>
                                        <span class="rdo"><input type="radio" name="c6" id="c6_x" value="X"><label for="c6_x">X</label></span>
                                    </div>
                                    <button class="btn-next" title="다음" onclick="gradeCheck('6', this);"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94152/btn_next.png" alt="다음"></button>
                                    <div class="page"><b>6</b>7</div>
                                </li>
                                <li class="c7">
                                    <div class="tit-card">
                                        <span><%=fadrama%></span>
                                    </div>
                                    <div class="ox">
                                        <span class="rdo"><input type="radio" name="c7" id="c7_o" value="O"><label for="c7_o">O</label></span>
                                        <span class="rdo"><input type="radio" name="c7" id="c7_x" value="X"><label for="c7_x">X</label></span>
                                    </div>
                                    <a href="" class="btn-next" title="채점완료" onclick="gradeCheck('7', this);"><img src="//webimage.10x10.co.kr/fixevent/event/2019/94152/btn_fin.png" alt="채점완료"></a>
                                    <div class="page"><b>7</b>7</div>
                                </li>
                            </ol>
                        </div>
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
<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'###########################################################
' Description : 대림미술관
' History : 2019-07-08
'###########################################################
%>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim oItem
dim evtStartDate, evtEndDate, currentDate
	currentDate =  date()
    evtStartDate = Cdate("2019-07-23")
    evtEndDate = Cdate("2019-08-06")

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  90350
Else
	eCode   =  96191
End If

dim userid, commentcount, i , totalsubscriptcount , sqlstr
	userid = GetEncLoginUserID()

commentcount = getcommentexistscount(userid, eCode, "", "", "", "Y")

if (GetLoginUserID="greenteenz") or (GetLoginUserID="ley330") or (GetLoginUserID="rnldusgpfla") or (GetLoginUserID="motions") then
    '//전체 참여수
    sqlstr = "select count(*) as cnt"
    sqlstr = sqlstr & " from db_event.dbo.tbl_event_comment c with(nolock)"
    sqlstr = sqlstr & " where c.evt_code="& eCode &""
    rsget.Open sqlstr,dbget
    IF not rsget.EOF THEN
        totalsubscriptcount = rsget("cnt")
    END IF
    rsget.close
end if 

%>
<style>
.evt95609 .input-area {display:flex; align-items:center; justify-content:center; font-size:0; padding-bottom:88px; background-color:#5579ff;}
.evt95609 .input-area label {display:flex; align-items: center; padding:27px 18px; margin:0 7px; background-color:#fff; border-radius:9px; color:#000; font-size:17px; font-weight:700; font-family:'Roboto', 'malgun Gothic', '맑은고딕', sans-serif;}
.evt95609 .input-area label input {font-size:24px;}
.evt95609 .input-area input[type=text] {letter-spacing:-2px;}
.evt95609 .input-area input[type=text],
.evt95609 .input-area input[type=number] {display:inline-block; width:88px; height:28px; margin-left:30px; font-size:23px; line-height:1.2; text-align:right;}
.evt95609 .input-area input[type=number] {margin-left:10px;}
.evt95609 .input-area input::-webkit-input-placeholder {color:#b8b8b8;}
.evt95609 .input-area em {margin-left:8px;}
.evt95609 button {display:inline-block; background-color:#0600ff; width:133px; height:80px; margin-left:9px; border-radius:9px; font-size:20px; color:#fff;}
</style>
<script type="text/javascript" src="/lib/js/TweenMax.min.js"></script>
<script>
function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% If not( currentDate >= evtStartDate and currentDate <= evtEndDate ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
            if(frm.txtcomm1.value == ""){
                alert('이름을 입력해주세요!')
                frm.txtcomm1.focus()
                return false;
            }
			if(frm.txtcomm2.value == ""){
                alert('나이를 입력해주세요!')
                frm.txtcomm2.focus()
                return false;
            }
			if(frm.txtcomm3.value == ""){
                alert('견종를 입력해주세요!')
                frm.txtcomm3.focus()
                return false;
            }
			if(frm.txtcomm4.value == ""){
                alert('몸무게를 입력해주세요!')
                frm.txtcomm4.focus()
                return false;
            }

            frm.txtcomm.value = frm.txtcomm1.value + '||' + frm.txtcomm2.value + '||' + frm.txtcomm3.value + '||' + frm.txtcomm4.value
            frm.action = "/event/lib/comment_process.asp";
            frm.submit();
		<% end if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			top.location.href="/login/loginpage.asp?vType=G&backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>";
			return false;
		}
		return false;
	<% End IF %>
}

function jsCheckLimit() {
	if ("<%=IsUserLoginOK%>"=="False") {
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			top.location.href="/login/loginpage.asp?vType=G&backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>";
			return false;
		}
		return false;
	}
}
</script>
<% if (GetLoginUserID="greenteenz") or (GetLoginUserID="ley330") or (GetLoginUserID="rnldusgpfla") or (GetLoginUserID="motions") then %>
<div style="color:red">*스태프만 노출</div>
<div>전체 응모 수 : <%=totalsubscriptcount%></div>
<% end if %>
<% If currentDate >= evtStartDate and currentDate <= evtEndDate Then %>
<div class="evt95609">
    <img src="http://webimage.10x10.co.kr/eventIMG/2019/96191/main20190723091153.JPEG" usemap="#Mainmap" class="gpimg">
    <map name="Mainmap">
        <area shape="rect" coords="240,1448,447,1498" href="#mapGroup293314" onfocus="this.blur();">
        <area shape="rect" coords="561,1227,1010,1563" href="javascript:TnGotoProduct('2385163');" onfocus="this.blur();">
        <area shape="rect" coords="133,1641,582,1976" href="javascript:TnGotoProduct('2385163');" onfocus="this.blur();">
        <area shape="rect" coords="714,1877,875,1921" href="#mapGroup293312" onfocus="this.blur();">
        <area shape="rect" coords="558,2047,1014,2384" href="javascript:TnGotoProduct('2385163');" onfocus="this.blur();">
        <area shape="rect" coords="236,2269,446,2316" href="#mapGroup293315" onfocus="this.blur();">
        <area shape="rect" coords="131,2460,582,2802" href="javascript:TnGotoProduct('2385163');" onfocus="this.blur();">
        <area shape="rect" coords="688,2684,903,2733" href="#mapGroup293316" onfocus="this.blur();">
    </map>
    <div class="cmt-evt">
        <img src="//webimage.10x10.co.kr/fixevent/event/2019/95609/txt_cmt_evt.png" alt="여러분과 반려견에게 행복한 호캉스를 보내드려요! 아래의 멍견정보를 입력해주신 분 중 추첨을 통해   호텔 카푸치노 1박 숙박권(17만원 상당)  을 드립니다!">
        <form name="frmcom" method="post" onSubmit="return false;" >
        <input type="hidden" name="eventid" value="<%=eCode%>">
        <input type="hidden" name="mode" value="add">
        <input type="hidden" id="spoint" name="spoint" value="1">
        <input type="hidden" name="txtcomm">
        <div class="input-area">
            <label for="pet-name">이름<input type="text" id="pet-name" placeholder="토토" name="txtcomm1" onkeyup="chkword(this,10);" autocomplete="off" onClick="jsCheckLimit();"/></label>
            <label for="pet-age">나이<input type="number" id="pet-age" placeholder="7" name="txtcomm2" onkeyup="chkword(this,10);" autocomplete="off" onClick="jsCheckLimit();"/><em>살</em></label>
            <label for="pet-breed">견종<input type="text" id="pet-breed" placeholder="말티즈" name="txtcomm3" onkeyup="chkword(this,10);" autocomplete="off" onClick="jsCheckLimit();"/></label>
            <label for="pet-weight">몸무게<input type="number" id="pet-weight" placeholder="3.2" name="txtcomm4" onkeyup="chkword(this,10);" autocomplete="off" onClick="jsCheckLimit();"/><em>kg</em></label>
            <button type="submit" onClick="jsSubmitComment(document.frmcom);return false;">등록</button>
        </div>
        </form>
    </div>
</div>
<% end if %>
<!-- #include virtual="/lib/db/dbclose.asp" -->
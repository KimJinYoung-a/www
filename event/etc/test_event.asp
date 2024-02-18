<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
'####################################################
' Description : 2000 마일리지 이벤트
' History : 2021-01-18 정태훈
'####################################################
dim eventStartDate, eventEndDate, LoginUserid, currentDate, eCode
eventStartDate  = cdate("2021-03-23")		'이벤트 시작일
eventEndDate 	= cdate("2021-03-24")		'이벤트 종료일
currentDate = date()
LoginUserid		= getencLoginUserid()
eCode = request("eventid")
%>

<script>
function eventTry(){
    <% If Not(IsUserLoginOK) Then %>
        calllogin();
        return false;
    <% else %>
        <% If (currentDate >= eventStartDate And currentDate <= eventEndDate) Then %>

            if(!$("#oitemid").val()){
                alert("상품코드를 입력해주세요!");
                return false;
            }

            var makehtml="";
            var returnCode, itemid, data
            var data={
                mode: "add",
                evt_code: "<%=eCode%>",
                itemid: $("#oitemid").val()
            }
            $.ajax({
                type:"POST",
                url:"/event/etc/doeventsubscript/doEventSubscriptTEST.asp",
                data: data,
                dataType: "JSON",
                success : function(res){
                        if(res!="") {
                            // console.log(res)
                            if(res.response == "ok"){
                                $("#itemid").val($("#oitemid").val());
								document.directOrd.submit();
                            }else{
                                alert(res.faildesc);
                                return false;
                            }
                        } else {
                            alert("잘못된 접근 입니다.1");
                            document.location.reload();
                            return false;
                        }
                },
                error:function(err){
                    console.log(err)
                    alert("잘못된 접근 입니다2.");
                    return false;
                }
            });
        <% Else %>
            alert("이벤트 응모 기간이 아닙니다.");
            return;
        <% End If %>
    <% End If %>
}
function goDirOrdItem(){
<% If IsUserLoginOK() Then %>
	<% If (currentDate >= eventStartDate And currentDate <= eventEndDate) Then %>
        $("#itemid").val($("#oitemid").val());
		document.directOrd.submit();
	<% else %>
		alert("이벤트 응모 기간이 아닙니다.");
		return;
	<% end if %>
<% End IF %>
}
</script>
<p>타임세일 테스트 페이지</p> <br>
상품코드 : <input type="text" id="oitemid" style="color:#ff0000;border:1px solid #000;"><a href="#" onclick="eventTry();return false;">응모하기</a>
<form method="post" name="directOrd" action="/inipay/shoppingbag_process.asp">
    <input type="hidden" name="itemid" id="itemid" value="">
    <input type="hidden" name="itemoption" value="0000">
    <input type="hidden" name="itemea" readonly value="1">
    <input type="hidden" name="sitename" value="<%= session("rd_sitename") %>" />
    <input type="hidden" name="isPresentItem" value="" />
    <input type="hidden" name="mode" value="DO1">
</form>
<!-- #include virtual="/lib/db/dbclose.asp" -->
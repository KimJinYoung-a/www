<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 리마인드쿠폰
' History : 2019-11-01 최종원
'####################################################
%>
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim eCode, userid, couponIdx, couponType
IF application("Svr_Info") = "Dev" THEN
	eCode = "90421"
	couponIdx = "2903,2909"
Else
	eCode = "98366"
	couponIdx = "1223,1224"
End If
couponType = "evtsel,evtsel"

userid = GetEncLoginUserID()

dim eventEndDate, currentDate, eventStartDate
dim subscriptcount, totalsubscriptcount
dim evtinfo : evtinfo = getEventDate(eCode)

if not isArray(evtinfo) then
	Call Alert_Return("잘못된 이벤트번호입니다.")
	dbget.close()	:	response.End
end if

'변수 초기화
eventStartDate = cdate(evtinfo(0,0))
eventEndDate = cdate(evtinfo(1,0))
currentDate = date()
'currentDate = Cdate("2019-05-04")
eventStartDate = cdate("2019-05-10")
%>
<style type="text/css">
.evt98366 {position: relative; font-family: 'Roboto','Noto Sans KR','malgun Gothic','맑은고딕',sans-serif}
.evt98366 .topic {position: relative; height: 961px; background: #f8dcac url(//webimage.10x10.co.kr/fixevent/event/2019/98366/bg_top.jpg?v=1.02) no-repeat center 0;}
.evt98366 .topic .inner {width: 921px; margin: 0 auto; text-align: left;}
.evt98366 .topic button {position: absolute; bottom: 120px; left: 50%; transform: translateX(-50%); background: none;}
.evt98366 .topic .txt1 {padding-top: 105px; margin-bottom: 160px; font-size: 55px; color: #222222; line-height: 1;}
.evt98366 .topic .txt2 {font-size: 20px; color: #755b2f; line-height: 39px;}
.evt98366 .topic .txt2 .name {font-size: 21px; font-weight: bold; color: #43300f;}
.evt98366 .topic .ani {position: absolute; top: 130px; left: 50%; width: 90px; height: 90px; margin-left: -55px; overflow: hidden; border-radius: 50%; animation: fire 1.5s ease infinite; transform-origin: 50%; background: url(//webimage.10x10.co.kr/fixevent/event/2019/98366/img_ani.png?v=1.02) center /90px;} 
.evt98366 .noti {background-color: #9b845c;}
@keyframes fire {from {transform: scale(.85); opacity: 0;} 25% {opacity: 1;} 85% {transform: scale(1); opacity: 1;}	to {transform: scale(1); opacity: 0;}}
</style>
<script type="text/javascript">
function handleClickCoupon(stype,idx){
    <% If not IsUserLoginOK() Then %>
		if(confirm("로그인을 하셔야 쿠폰발급이 가능 합니다. 로그인 하시겠습니까?")){
			top.location.href="/login/loginpage.asp?vType=G&backpath=<%=Server.URLencode("/event/benefit/")%>";
			return false;
		}
		return false;
    <% end if %>
    var str = $.ajax({
        type: "POST",
        url: "/event/etc/coupon/couponshop_process.asp",
        data: "mode=cpok&stype="+stype+"&idx="+idx,
		dataType: "text",
		success: function(str){
			var str1 = str.split("||")
			if (str1[0] == "11"){
				fnAmplitudeEventMultiPropertiesAction("click_event_coupondown","evtcode","<%=eCode%>");
				alert("쿠폰이 발급되었습니다.\n잊지 말고 11월 8일까지 사용해주세요!")
				return false;
			}else if (str1[0] == "12"){
				alert('기간이 종료되었거나 유효하지 않은 쿠폰입니다.');
				return false;
			}else if (str1[0] == "13"){
				alert('이미 다운로드 받으셨습니다.');
				return false;
			}else if (str1[0] == "02"){
				alert('로그인 후 쿠폰을 받을 수 있습니다!');
				return false;
			}else if (str1[0] == "01"){
				alert('잘못된 접속입니다.');
				return false;
			}else if (str1[0] == "00"){
				alert('정상적인 경로가 아닙니다.');
				return false;
			}else{
				alert('오류가 발생했습니다.');
				return false;
			}           
		},
		error: function(data){
			alert('오류가 발생했습니다.');
		}
    })
}
</script>
	<!-- 98366 리마인드쿠폰 -->
						<div class="evt98366">
                            <div class="topic">
                                <div class="inner">
                                    <div class="txt1">
                                        <span class="name"><%=chkIIF(IsUserLoginOK(), GetLoginUserName(), "고객")%></span>님
                                    </div>
                                    <div class="txt2">
                                        10월 한 달 동안, 텐바이텐 18주년을 <br>
                                        함께한  <span class="name"><%=chkIIF(IsUserLoginOK(), GetLoginUserName(), "고객")%></span>님께 감사의 쿠폰을 드립니다. <br>
                                        앞으로도 다양한 즐거움을 드리는 텐바이텐이 되도록 하겠습니다!
                                    </div>
                                    <span class="ani"></span>
                                </div>
                                <button onclick="handleClickCoupon('<%=couponType%>','<%= couponIdx %>')"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98366/btn.png" alt="쿠폰 받기"></button>
                            </div>
                            <div class="noti">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2019/98366/txt_noti.jpg" alt="유의사항">
                            </div>
                                
						</div>
						<!-- // 98366 리마인드쿠폰 -->
<!-- #include virtual="/lib/db/dbclose.asp" -->
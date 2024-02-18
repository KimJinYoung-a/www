<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : MD 기획전 카카오 브랜드 쿠폰
' History : 2019-12-12 원승현
'####################################################
%>
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%

dim eCode, userid
IF application("Svr_Info") = "Dev" THEN
	eCode = "90445"
Else
	eCode = "99403"
End If

userid = GetEncLoginUserID()

dim eventEndDate, currentDate, eventStartDate
dim subscriptcount  
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
'// STAFF 아이디는 테스트를 위해 시작일을 테스트 일자로 부터 시작하게 변경
If GetLoginUserLevel() = "7" Then
    eventStartDate = cdate("2019-12-12")
End If
%>
<style>
.evt99403 {position: relative; background-color: #533112;}
.evt99403 > div {position: relative;}
.evt99403 area {outline: none;}
.evt99403 .img-bg {position: relative; display: block; left: 50%; width: 1920px; margin-left: -960px;}
.evt99403 .topic {width: 100%; height: 1812px; padding-top: 140px; background: url(//webimage.10x10.co.kr/fixevent/event/2019/99403/bg.jpg) center 0 repeat-x; box-sizing: border-box;}
.evt99403 .btn-cpn {position: absolute; top: 70px; left: 50%; margin-left: 40px; width: 295px; height: 160px; text-indent: -9999px;}
.evt99403 .prd-area {padding-top: 408px;}
</style>
<script type="text/javascript" src="/event/etc/json/js_applyItemInfo.js"></script>
<script type="text/javascript">
function jsDownCoupon(cType){
	<% if not (currentDate >= eventStartDate and currentDate <= eventEndDate) then %>	
		alert("이벤트 참여기간이 아닙니다.");
		return false;
    <% end if %>
    
    <% if Not(IsUserLoginOK) then %>
        jsEventLogin();
    <% else %>
        $.ajax({
            type: "post",
            url: "/event/etc/doeventsubscript/doEvenSubscript99403.asp",		
            data: {
                eCode: '<%=eCode%>',
                couponType: cType
            },
            cache: false,
            success: function(resultData) {
                fnAmplitudeEventMultiPropertiesAction('click_coupon_btn','evtcode|couponType','<%=eCode%>|'+cType)
                var reStr = resultData.split("|");				
                
                if(reStr[0]=="OK"){		
                    alert('쿠폰이 발급 되었습니다.\n주문시 사용 가능합니다.');
                }else{
                    var errorMsg = reStr[1].replace(">?n", "\n");
                    alert(errorMsg);					
                }			
            },
            error: function(err) {
                console.log(err.responseText);
            }
        });
    <% end if %>
}

function jsEventLogin(){
	if(confirm("로그인을 하셔야 쿠폰을 발급 받으실 수 있습니다.")){
		location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
		return;
	}
}
</script>
<%' 99403 연말 선물도 카카오프렌즈 %>
<div class="evt99403">
    <div class="topic">
        <h2><img src="//webimage.10x10.co.kr/fixevent/event/2019/99403/tit.png" alt="연말 선물도 카카오프렌즈"></h2>
        <div class="prd-area">
            <span class="img-prd"><img src="//webimage.10x10.co.kr/fixevent/event/2019/99403/img_prd.png" usemap="#Map" alt="따뜻한 마음을 전하는 연말을 여러분과 함께 하고 싶어요! 카카오프렌즈 X 텐바이텐이 제안하는 연말 선물 추천"></span>
            <map name="Map" id="Map">
                <area shape="rect" coords="11,30,336,460" href="/shopping/category_prd.asp?itemid=2503401&pEtr=99403" />
                <area shape="rect" coords="819,26,1143,465" href="/shopping/category_prd.asp?itemid=2503356&pEtr=99403" />
                <area shape="rect" coords="9,513,338,949" href="/shopping/category_prd.asp?itemid=2503396&pEtr=99403" />
                <area shape="rect" coords="410,511,742,950" href="/shopping/category_prd.asp?itemid=2503333&pEtr=99403" />
                <area shape="rect" coords="812,509,1145,953" href="/shopping/category_prd.asp?itemid=2503386&pEtr=99403" />
            </map>
        </div>
    </div>
    <div class="cpn-area">
        <span class="img-bg"><img src="//webimage.10x10.co.kr/fixevent/event/2019/99403/img_coupon.jpg" alt="카카오프렌즈 10%쿠폰 행사 중! 쿠폰 다운 받고 바로 사용해보세요!"></span>
        <a href="" onclick="jsDownCoupon('cKakaoFriends');return false;" class="btn-cpn">쿠폰 다운받기</a>
        <%' for dev msg 클릭 시 장바구니 쿠폰 발급 > 팝업 오픈 (쿠폰 ID: 1275) %>
    </div>
</div>
<%' // 99403 연말 선물도 카카오프렌즈 %>
<!-- #include virtual="/lib/db/dbclose.asp" -->
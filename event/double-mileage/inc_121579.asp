<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  더블 마일리지
' History : 2022.12.21 조유림 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_evaluatesearchercls.asp" -->
<%
dim eCode, vUserID, cMil, vMileValue, vMileArr
dim eventStartDate, eventEndDate, currentDate, mktTest
vUserID = GetEncLoginUserID()
'vUserID = "10x10yellow"

IF application("Svr_Info") = "Dev" THEN
mktTest = True
ElseIf application("Svr_Info")="staging" Then
mktTest = True
Else
mktTest = False
End If
eventStartDate  = cdate("2022-12-26")		'이벤트 시작일
eventEndDate 	= cdate("2022-12-29")		'이벤트 종료일

if mktTest then
currentDate = cdate("2022-12-26")
else
currentDate = date()
end if

If currentDate >= eventStartDate And currentDate <= eventEndDate Then
    vMileValue = 400
Else
    vMileValue = 100
End If

Set cMil = New CEvaluateSearcher
cMil.FRectUserID = vUserID
cMil.FRectMileage = vMileValue

If vUserID <> "" Then
    vMileArr = cMil.getDoubleEvtEvaluatedTotalMileCnt
End If
Set cMil = Nothing
%>
<link rel="stylesheet" href="/event/double-mileage/styles.css"/>
<script type="text/javascript">
function jsSubmitlogin(){
	top.location.href="/login/loginpage.asp?vType=G";
	return false;
}
function eventTry(){
	<% If Not(IsUserLoginOK) Then %>
        jsSubmitlogin();
		return false;
	<% else %>
		<% If (currentDate >= eventStartDate And currentDate <= eventEndDate) Then %>
		var returnCode, itemid, data
		var data={
			mode: "add"
		}
		$.ajax({
			type:"POST",
			url:"/event/double-mileage/doEventSubscript121579.asp",
			data: data,
			dataType: "JSON",
			success : function(res){
					if(res!="") {
						// console.log(res)
						if(res.response == "ok"){
							alert('신청이 완료되었습니다.\n01월 04일에 마일리지가 지급되면 알림톡이 발송됩니다.');
							return false;
						}else{
							alert(res.faildesc);
							return false;
						}
					} else {
						alert("잘못된 접근 입니다.");
						document.location.reload();
						return false;
					}
			},
			error:function(err){
				console.log(err)
				alert("잘못된 접근 입니다.");
				return false;
			}
		});
		<% Else %>
			alert("이벤트 참여기간이 아닙니다.");
			return;
		<% End If %>
	<% End If %>
}
</script>
<div class="mEvtDoubleMileage">
  <article class="img-section-01">
    <img src="//webimage.10x10.co.kr/fixevent/event/2022/121579/pc/img-section-01.jpg?var=1.1" alt="더블 마일리지">
    <p class="sub-text"><strong>단 4일간</strong> 포토후기 작성하면 <strong>마일리지 4배 적립!</strong></p>
    <p class="sub-dscrp">이벤트 기간 : 12월 26일 – 29일</p>
  </article>
  <article class="img-section-02">
    <img src="//webimage.10x10.co.kr/fixevent/event/2022/121579/pc/img-section-02.jpg" alt="상품후기 마일리지">
    <p class="sub-dscrp">&#42;추가 혜택 300p는 1월 4일 일괄 지급</p>
  </article>
  <article class="img-section-03">
    <img src="//webimage.10x10.co.kr/fixevent/event/2022/121579/pc/img-section-03.jpg" alt="포토후기 마일리지">
    <p class="sub-dscrp">&#42;추가 혜택 100p는 1월 4일 일괄 지급</p>
  </article>
  <article class="img-section-04">
    <div class="benefit">
      <h2 class="benefit-title">
        <% If IsUserLoginOK Then %>
        지금 <span class="user-id"><%= vUserID %></span> 님이 <em>후기 작성하면 받을 수 있는 혜택</em>
        <% Else %>
        <b>나의 예상 적립 마일리지</b>를 확인하세요!
        <% End If %>
      </h2>
      <div class="flex-box">
        <div class="point">
          <div class="point-list">
            <label class="point-label">&middot; 작성 가능한 후기 개수</label>
            <p class="point-num"><% If IsUserLoginOK Then %><%=vMileArr(0,0)%><% End if %><span>개</span></p>
          </div>
          <div class="point-list">
            <label class="point-label">&middot; 최대 예상 마일리지<br/><span class="font-xs">*포토 후기일 경우</span></label>
            <p class="point-num self-start"><% If IsUserLoginOK Then %><%=FormatNumber(vMileArr(1,0),0)%><% End if %><span>P</span></p>
          </div>
        </div>
        <div class="btn-group">
          <% If IsUserLoginOK Then %>
            <a href="/my10x10/goodsusing.asp" target="_blank">
              상품후기 쓰러 가기
              <i class="icon-arrow">
                <img src="//webimage.10x10.co.kr/fixevent/event/2022/121579/m/btn-review-arrow.png" alt="" />
              </i>
            </a>
          <% Else %>
            <a href="" onclick="jsSubmitlogin(); return false;" class="btn-login">
              로그인 하기
              <i class="icon-arrow">
                <img src="//webimage.10x10.co.kr/fixevent/event/2022/121579/m/btn-login-arrow.png" alt="" />
              </i>
            </a>
          <% End If %>
        </div>
      </div>
      <span class="icon-coin"><img src="//webimage.10x10.co.kr/fixevent/event/2022/121579/pc/icon-coin.png" alt=""></span>
    </div>
  </article>
  <article class="aram">
    <div class="text-box">
      <p class="sub-text">추가 마일리지 혜택 지급일 : 1월 4일 오후</p>
      <p class="sub-dscrp">&#42;추가 지급된 마일리지는 1월 31일까지 사용이 가능하며, 미사용 시 2월 1일 00:00에 소멸됩니다.</p>
    </div>
    <img src="//webimage.10x10.co.kr/fixevent/event/2022/121579/pc/img-event-info.jpg" alt="이벤트 안내">
    <button type="button" onclick="eventTry();"></button>
  </article>
  <article class="info">
    <h2>유의사항</h2>
    <ul>
      <li>이벤트 기간 내에 새롭게 작성하신 상품 후기에 한해서만 더블 마일리지가 적용됩니다.</li>
      <li>기존에 작성했던 상품후기 수정은 적용되지 않습니다.</li>
      <li class="point-color">상품 후기 및 포토후기가 작성된 이후에 삭제된 경우에는 마일리지 지급이 되지 않습니다.</li>
      <li>상품 후기는 배송정보 [출고완료] 이후부터 작성 하실 수 있습니다.</li>
      <li>상품과 관련 없는 내용이나 이미지를 올리거나, 직접 찍은 사진이 아닐 경우 삭제 및 마일리지 지급이 취소 될 수 있습니다.</li>
      <li><strong>이벤트로 추가 지급되는 마일리지(기본 후기는 100p, 포토 후기는 300p)는 후기 작성 후 바로 지급되지 않으며, 1월 4일 오후에 일괄 지급됩니다.</strong></li>
      <li><strong>이벤트로 추가 지급되는 마일리지는 1월 31일까지 사용이 가능하며, 미사용 시 2월 1일 00:00에 소멸됩니다.</strong></li>
      <li><p>이벤트 기간 내 첫 상품 후기 작성할 경우, 혜택은 <strong>최대 400p</strong>로 지급됩니다.</p></li>
    </ul>
  </article>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->
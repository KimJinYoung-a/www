<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/classes/tenquiz/TenQuizCls.asp" -->
<%
'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			dim mQrParam: mQrParam = request.QueryString		'// 유입 전체 파라메터 접수
			Response.Redirect "http://m.10x10.co.kr/tenquiz/index.asp?" & mQrParam
			REsponse.End
		end if
	end if
end if	

	dim nowChasu, nowMonthGroup, tenquizObj, currenttime, i 
	dim totalParticipants, totalWinner, userid, isSolvedChasu, isChallengeable

    dim tempDate
    dim tempMileage
    dim tempParticipants, tempWinners, tempChasu

	dim idx
	dim chasu
	dim TopTitle
	dim QuizDescription
	dim BackGroundImage
	dim QuestionHintNumber
	dim TotalMileage
	dim QuizStartDate
	dim QuizEndDate
	dim TotalQuestionCount
	dim StartDescription
	dim AdminRegister
	dim AdminName
	dim AdminModifyer
	dim AdminModifyerName
	dim RegistDate
	dim LastUpDate
	dim QuizStatus

	nowChasu = replace(FormatDateTime(now(), 2), "-","")  
	nowMonthGroup = left(now(),4) & mid(now(), 6, 2)		
	userid = GetEncLoginUserID()    
	currenttime = now()	

	set tenquizObj = new TenQuiz
	
	tenquizObj.FRectChasu = nowChasu 
	tenquizObj.FmonthGroupOption = nowMonthGroup
	tenquizObj.GetOneQuiz()
	tenquizObj.GetQuizList()	

	if tenquizObj.FoneItem.Fidx <> "" then 
		idx					= tenquizObj.FoneItem.Fidx											
		chasu				= tenquizObj.FoneItem.Fchasu								
		TopTitle			= tenquizObj.FoneItem.FTopTitle				
		QuizDescription		= tenquizObj.FoneItem.FQuizDescription					
		BackGroundImage		= tenquizObj.FoneItem.FPCWbackGroundImage					
		QuestionHintNumber	= tenquizObj.FoneItem.FQuestionHintNumber					
		TotalMileage		= tenquizObj.FoneItem.FTotalMileage								
		QuizStartDate		= tenquizObj.FoneItem.FQuizStartDate					
		QuizEndDate			= tenquizObj.FoneItem.FQuizEndDate						
		TotalQuestionCount	= tenquizObj.FoneItem.FTotalQuestionCount			
		StartDescription	= tenquizObj.FoneItem.FStartDescription
		AdminRegister		= tenquizObj.FoneItem.FAdminRegister	
		AdminName			= tenquizObj.FoneItem.FAdminName
		AdminModifyer		= tenquizObj.FoneItem.FAdminModifyer		
		AdminModifyerName	= tenquizObj.FoneItem.FAdminModifyerName	
		RegistDate			= tenquizObj.FoneItem.FRegistDate	
		LastUpDate			= tenquizObj.FoneItem.FLastUpDate	
		QuizStatus			= tenquizObj.FoneItem.FQuizStatus		
	else 		
		QuizDescription		= ""
		BackGroundImage		= "http://fiximage.10x10.co.kr/web2018/tenquiz/bg_tenquiz_1.png"		
		QuizStatus			= "1"
	end if

    totalParticipants = tenquizObj.GetNumberOfParticipants(nowChasu)
    totalWinner = tenquizObj.GetNumberOfWinner(nowChasu, TotalQuestionCount)
	isSolvedChasu = tenquizObj.isSolvedQuizChasu(userid, nowChasu)
	isChallengeable = (QuizStatus = 2 and (currenttime > QuizStartDate and currenttime < QuizEndDate)) 'QuizStatus - 1 : 등록 대기,  2 : 오픈, 3 : 종료

%>
<script src="/lib/js/jquery.tinyscrollbar.js"></script>
<script type="text/javascript">
$(document).ready(function(){
    fnAmplitudeEventMultiPropertiesAction("view_17th_tenquiz","","");
	// scroll
	$('.scrollbarwrap').tinyscrollbar();

    // 'coming soon' position
    var totalH = $('.viewport').outerHeight();
    var titH = $('.history h3').outerHeight();
    var historyH = $('.history ol').outerHeight();
    var comingH = (totalH - titH - historyH)/2;
    $('.txt-coming').css({'height': comingH});
});
</script>

</head>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt"><!-- for dev msg : 왼쪽메뉴(카테고리명) 사용시 클래스 : partEvt / 왼쪽메뉴(카테고리명) 사용 안할때 클래스 : fullEvt -->
		<div id="contentWrap" style="padding-top:0">
			<div class="eventWrapV15">				
				<div class="eventContV15">
					<div class="contF contW">

                        <!-- 텐퀴즈 -->
                        <div class="tenquiz">
                            <!-- 
                                tit_tenquiz_1.jpg #FF7EB4
                                tit_tenquiz_2.jpg #BF64FF
                                tit_tenquiz_3.jpg #FA5D72
                                tit_tenquiz_4.jpg #23DE9F
                            -->                                                    
                            <div class="tenquiz-head" style="background-image:url(<%=BackGroundImage%>);"> <!--for dev msg 모바일과 동일하게 4종류의 이미지가 있을 예정입니다. -->
                                <div class="topic">
                                    <h2>TEN QUIZ</h2>
                                    <p class="sub"><img src="http://fiximage.10x10.co.kr/web2018/tenquiz/txt_sub.png" alt="10시부터 10시까지" /></p>
                                    <span><img src="http://fiximage.10x10.co.kr/web2018/tenquiz/txt_only_app.png" alt="APP 전용" /></span>
                                </div>                                

                                <!-- 히스토리 -->
                                <div class="history">
                                    <div class="scrollbarwrap">
                                        <div class="scrollbar"><div class="track"><div class="thumb"></div></div></div>
                                        <div class="viewport">
                                            <div class="overview">
                                                <h3>
                                                    <span><%=FormatNumber(right(nowMonthGroup, 2), 0)%>월</span>
                                                    <p>이달의 퀴즈 일정</p>
                                                </h3>
                                                <% If tenquizObj.FTotalCount > 0 Then %>				                                                    
                                                <ol>
                                                    <%
                                                    for i=0 to tenquizObj.FResultCount-1	
                                                        tempDate 		 = FormatNumber(mid(tenquizObj.FItemList(i).Fchasu,5 ,2),0) & "월" & FormatNumber(mid(tenquizObj.FItemList(i).Fchasu,7 ,2),0) & "일"				
                                                        tempMileage		 = left(tenquizObj.FItemList(i).FTotalMileage, len(tenquizObj.FItemList(i).FTotalMileage) - 4) & "만"
                                                        tempParticipants = FormatNumber(tenquizObj.GetNumberOfParticipants(tenquizObj.FItemList(i).Fchasu), 0)
                                                        tempWinners 	 = FormatNumber(tenquizObj.GetNumberOfWinner(tenquizObj.FItemList(i).Fchasu, tenquizObj.FItemList(i).FTotalQuestionCount), 0) 					
                                                        tempChasu 		 = tenquizObj.FItemList(i).Fchasu
                                                    %>              
                                                        <% If nowChasu = tenquizObj.FItemList(i).Fchasu Then '오늘%>
                                                        <li class="today">
                                                            <span class="date"><%=tempDate%></span>
                                                            <span class="mileage"><%=tempMileage%></span>
                                                        </li>                                                    
                                                        <% Elseif nowChasu > tenquizObj.FItemList(i).Fchasu then '종료%> 
                                                        <li class="end">
                                                            <span class="date"><%=tempDate%></span>
                                                            <span class="record"><%=tempParticipants%>명 중<br /> <%=tempWinners%>명 성공</span>
                                                        </li>                                                    
                                                        <% else '다음%>	                                 
                                                        <li class="coming">
                                                            <span class="date"><%=tempDate%></span>
                                                            <span class="mileage"><%=tempMileage%></span>
                                                        </li>
                                                        <% end if %>
                                                    <% next %>                                                    
                                                </ol>
                                                <% end if %>                                                
                                                <% if tenquizObj.FTotalCount < 3 then %>
                                                <p class="txt-coming"><span>coming soon</span></p> <!-- 3개 이상의 히스토리 있을 때 나타나지 않게 해주세요. -->
                                                <% end if %>                                                
                                            </div>
                                        </div>
                                    </div>
                                    <i class="dc1"><img src="http://fiximage.10x10.co.kr/web2018/tenquiz/img_coin_1.png" alt=""></i>
                                    <i class="dc2"><img src="http://fiximage.10x10.co.kr/web2018/tenquiz/img_coin_2.png" alt=""></i>
                                    <i class="dc3"><img src="http://fiximage.10x10.co.kr/web2018/tenquiz/img_coin_3.png" alt=""></i>
                                </div>
                            </div>

                            <!-- qr 코드 -->
                            <div class="go-app">
                                <span><img src="http://fiximage.10x10.co.kr/web2018/tenquiz/img_qr_code_v2.png" alt=""></span>
                                <p><img src="http://fiximage.10x10.co.kr/web2018/tenquiz/txt_qr_code.png" alt=""></p>
                            </div>

                            <!-- 이벤트유의사항 -->
                            <div class="noti">
                                <div class="inner">
                                    <h3><img src="http://fiximage.10x10.co.kr/web2018/tenquiz/tit_noti.png" alt=""></h3>
                                    <ul>
                                        <li>- 텐바이텐 APP에서만 진행 가능한 이벤트입니다.</li>
                                        <li>- 본 이벤트는 매달 진행하는 이벤트로, 해당일에 1회만 참여할 수 있습니다.</li>
                                        <li>- 오전 10시부터 오후 10시까지 진행합니다.</li>
                                        <li>- 상금은 10문제를 모두 맞춘 고객들과 N분의 1로 나누어 갖습니다.</li>
                                        <li>- 상금은 마일리지로 진행됩니다.  </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <!-- 텐퀴즈 -->
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->
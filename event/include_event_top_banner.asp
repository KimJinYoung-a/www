<%
'#######################################################
' Discription : pc_event_top_banner // cache DB경유
' History : 2019-02-18 원승현 생성
'#######################################################
Dim baIntI
Dim baSqlStr , baRsMem , baArrList, baPoscode
Dim baGaParam : baGaParam = "gaparam=event_top_banner" '//GA 체크 변수

'//DB 시간 타이머 00시부터 00시 5분 사이에는 DB 캐쉬 1분에 한번 읽기
Dim baCTime , baDummyName
If timer > 10 And Cint(timer/60) < 6 Then
	baCTime = 60*1
	baDummyName = "MBETBAN_"&Cint(timer/60)
Else
	baCTime = 60*1
	baDummyName = "MBETBAN_"
End If

If IsUserLoginOK Then
    baPoscode = "728"
Else
    baPoscode = "730"
End If

baSqlStr = " SELECT idx " & vbcrlf
baSqlStr = baSqlStr & "	, poscode, linktype, fixtype " & vbcrlf
baSqlStr = baSqlStr & "	, posVarname, imageurl, linkurl " & vbcrlf
baSqlStr = baSqlStr & "	, imagewidth, imageheight, startdate " & vbcrlf
baSqlStr = baSqlStr & "	, enddate, regdate, reguserid " & vbcrlf
baSqlStr = baSqlStr & "	, isusing, orderidx, linkText " & vbcrlf
baSqlStr = baSqlStr & "	, itemDesc, workeruserid, imageurl2 " & vbcrlf
baSqlStr = baSqlStr & "	, linkText2, linkText3, linkText4 " & vbcrlf
baSqlStr = baSqlStr & "	, altname, lastupdate, bgcode " & vbcrlf
baSqlStr = baSqlStr & "	, xbtncolor, maincopy, maincopy2 " & vbcrlf
baSqlStr = baSqlStr & "	, subcopy, etctag, etctext " & vbcrlf
baSqlStr = baSqlStr & "	, ecode, bannertype, altname2 " & vbcrlf
baSqlStr = baSqlStr & "	, bgcode2, linkurl2, evt_code " & vbcrlf
baSqlStr = baSqlStr & "	, tag_only, targetOS, targetType " & vbcrlf
baSqlStr = baSqlStr & "	, imageurl3, altname3, linkurl3 " & vbcrlf
baSqlStr = baSqlStr & "	, categoryOptions " & vbcrlf
baSqlStr = baSqlStr & "	, couponidx " & vbcrlf
baSqlStr = baSqlStr & " FROM db_sitemaster.dbo.tbl_main_contents " & vbcrlf
baSqlStr = baSqlStr & " WHERE poscode='"&baPoscode&"' " & vbcrlf
baSqlStr = baSqlStr & "	    AND getdate() >= startdate AND getdate() <= enddate " & vbcrlf
baSqlStr = baSqlStr & "	    AND isusing='Y' " & vbcrlf
baSqlStr = baSqlStr & " ORDER BY orderidx ASC, idx DESC "

set baRsMem = getDBCacheSQL(dbget, rsget, "MAINEVTTOPBAN16", baSqlStr, baCTime)
IF Not (baRsMem.EOF OR baRsMem.BOF) THEN
    baArrList = baRsMem.GetRows
END IF
baRsMem.close

on Error Resume Next
Dim baidx, balinktype, bafixtype, baposVarname, baimageurl, baimagewidth, baimageheight, bastartdate, baenddate, baregdate, bareguserid, baisusing, baorderidx, balinkText, balinkurl, layerId
Dim baitemDesc, baworkeruserid, baimageurl2, balinkText2, balinkText3, balinkText4, baaltname, balastupdate, babgcode, baxbtncolor, bamaincopy, bamaincopy2, basubcopy, baetctag, baetctext
Dim baecode, babannertype, baaltname2, babgcode2, balinkurl2, baevt_code, batag_only, batargetOS, batargetType, baimageurl3, baaltname3, balinkurl3, bacategoryOptions, baCouponIdx
Dim cateCheckBaIdx, allCheckBaIdx, checkBaIdx, couponInfo, couponVal, couponMin
checkBaIdx = ""
cateCheckBaIdx = ""
allCheckBaIdx = ""
%>
<%' 쿠폰배너 스타일, 스크립트%>
<style>
.bnr-coupon {display:block; margin-top:10px; margin-bottom:-10px; cursor:pointer;}
.bnr-coupon img {width:440px;}
.popup-lyr {display:none;}
.lyr-coupon {display:none; position:relative; width:412px; padding:40px 0; font-family:'Roboto', 'Noto Sans KR'; text-align:center; background-color:#fff; -webkit-border-radius:5px; border-radius:5px;}
.lyr-coupon h2 {font-weight:normal; font-family:inherit; font-size:21px; color:#444;}
.lyr-coupon .btn-close1 {position:absolute; top:0; right:0; width:60px; height:60px; font-size:0; color:transparent; background:url(//fiximage.10x10.co.kr/web2019/common/ico_x.png) no-repeat 50% / 20px;}
.lyr-coupon .cpn {width:189px; height:96px; margin:20px auto 18px; background:url(//fiximage.10x10.co.kr/web2019/common/bg_cpn.png) no-repeat 50% / 100%;}
.lyr-coupon .cpn .amt {padding-top:12px; font-size:24px; color:#fff; line-height:1.3;}
.lyr-coupon .cpn .amt b {margin-right:3px; font-weight:bold; font-size:37px; vertical-align:-2px;}
.lyr-coupon .cpn .txt1 {font-size:11px; color:#919ff2; letter-spacing:-1px;}
.lyr-coupon .cpn .txt1 b {display:inline-block; margin-right:2px; font-size:12px; vertical-align:-0.5px;}
.lyr-coupon .txt2 {font-size:14px; color:#999; line-height:1.6;}
.lyr-coupon .txt2 strong {font-weight:normal; color:#ff3434;}
.lyr-coupon .btn-area {margin-top:20px; font-size:0;}
.lyr-coupon .btn-area button {height:48px; font:inherit; font-size:15px; -webkit-border-radius:5px; border-radius:5px;}
.lyr-coupon .btn-area .btn-close2 {width:113px; background-color:#c2c2c2; color:#444;}
.lyr-coupon .btn-area .btn-down {width:149px; margin-left:9px; background-color:#222; color:#fff;}
</style>
<script>
function jsEvtCouponDown(stype, idx, cb) {
	<% If IsUserLoginOK() Then %>
	$.ajax({
			type: "POST",
			url: "/event/etc/coupon/couponshop_process.asp",
			data: "mode=cpok&stype="+stype+"&idx="+idx,
			dataType: "text",
			success: function(message) {
				if(message) {
					var str1 = message.split("||")
					if (str1[0] == "11"){
						fnAmplitudeEventMultiPropertiesAction('click_marketing_top_bnr','','')
						cb();
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
				}
			}
	})
	<% Else %>
		jsChklogin('<%=IsUserLoginOK%>');
		return;
	<% End IF %>
}
function handleClicKBanner(link, bannerType, couponidx, lyrId, ecode){
	var couponType

	fnAmplitudeEventMultiPropertiesAction('click_eventtop_banner','eventcode',ecode);
	if(bannerType == 1){ // 링크배너
			window.location.href = link
	}else if(bannerType == 2){ // 쿠폰배너
		couponType = couponidx == 1190 ? 'month' : 'evtsel'
		jsEvtCouponDown(couponType, couponidx, function(){
			popupLayer(lyrId)
		})
	}else{ // 레이어팝업배너
		popupLayer(lyrId);
	}
}
function popupLayer(lyrId){
	viewPoupLayer('modal', $("#"+lyrId).html())
}
function handleClickBtn(url){
	window.location.href = url
}
</script>
<%' 쿠폰배너 스타일, 스크립트%>
<%
If IsArray(baArrList) Then
    If (request.Cookies("evtPrdLowBanner") <> "done" or request.Cookies("evtPrdLowBanner")="") Then
        '// 카테고리에 맞는 이벤트 배너가 있는지 확인
        If vDisp <> "" Then
            For baIntI = 0 To ubound(baArrList,2)
                If instr(baArrList(43, baIntI),left(vDisp, 3))>0 Then
                    cateCheckBaIdx = baArrList(0, baIntI)
                    Exit For
                End If
            Next
        End If

        '// 전체로 등록된 이벤트가 있는지 확인
        If checkBaIdx = "" Then
            For baIntI = 0 To ubound(baArrList,2)
                If baArrList(43, baIntI) = "" Then
                    allCheckBaIdx = baArrList(0, baIntI)
                    Exit For
                End If
            Next
        End If

        '// 둘다 있을경우 가장 상위값 불러옴
        If cateCheckBaIdx<>"" And allCheckBaIdx<>"" THen
            checkBaIdx = baArrList(0, 0)
        Else
            If cateCheckBaIdx <> "" Then
                checkBaIdx = cateCheckBaIdx
            End If

            If allCheckBaIdx <> "" Then
                checkBaIdx = allCheckBaIdx
            End If
        End If

        For baIntI = 0 To ubound(baArrList,2)
            baidx             = baArrList(0, baIntI)  '// 고유값
            baposcode         = baArrList(1, baIntI)  '// 배너코드
            balinktype        = baArrList(2, baIntI)  '// 링크구분
            bafixtype         = baArrList(3, baIntI)  '// 적용구분
            baposVarname      = baArrList(4, baIntI)  '// 배너변수명
            baimageurl        = baArrList(5, baIntI)  '// 이미지1url
            balinkurl         = baArrList(6, baIntI)  '// 이미지1linkurl
            baimagewidth      = baArrList(7, baIntI)  '// 이미지 가로사이즈
            baimageheight     = baArrList(8, baIntI)  '// 이미지 세로사이즈
            bastartdate       = baArrList(9, baIntI)  '// 시작일
            baenddate         = baArrList(10, baIntI) '// 종료일
            baregdate         = baArrList(11, baIntI) '// 등록일
            bareguserid       = baArrList(12, baIntI) '// 등록자아이디
            baisusing         = baArrList(13, baIntI) '// 사용여부
            baorderidx        = baArrList(14, baIntI) '// 정렬순서
            balinkText        = baArrList(15, baIntI) '// 링크텍스트1
            baitemDesc        = baArrList(16, baIntI) '// 작업요청사항
            baworkeruserid    = baArrList(17, baIntI) '// 최종작업자
            baimageurl2       = baArrList(18, baIntI) '// 이미지2url
            balinkText2       = baArrList(19, baIntI) '// 링크텍스트2
            balinkText3       = baArrList(20, baIntI) '// 링크텍스트3
            balinkText4       = baArrList(21, baIntI) '// 링크텍스트4
            baaltname         = baArrList(22, baIntI) '// 알트명1
            balastupdate      = baArrList(23, baIntI) '// 최종수정일
            babgcode          = baArrList(24, baIntI) '// 배경색상코드
            baxbtncolor       = baArrList(25, baIntI) '// 폰트컬러
            bamaincopy        = baArrList(26, baIntI) '// 메인카피
            bamaincopy2       = baArrList(27, baIntI) '// 메인카피2
            basubcopy         = baArrList(28, baIntI) '// 서브카피
            baetctag          = baArrList(29, baIntI) '// 태그
            baetctext         = baArrList(30, baIntI) '// 기타 텍스트(검색상단마케팅에선 키워드로 사용)
            baecode           = baArrList(31, baIntI) '// 컬쳐스테이션이벤트id
            babannertype      = baArrList(32, baIntI) '// 배너타입(갯수)
            baaltname2        = baArrList(33, baIntI) '// 알트명2
            babgcode2         = baArrList(34, baIntI) '// 배경색상코드2
            balinkurl2        = baArrList(35, baIntI) '// 이미지2linkurl2
            baevt_code        = baArrList(36, baIntI) '// 이벤트 코드
            batag_only        = baArrList(37, baIntI) '// 태그여부
            batargetOS        = baArrList(38, baIntI) '// 노출할 플랫폼
            batargetType      = baArrList(39, baIntI) '// 노출할 유저타겟
            baimageurl3       = baArrList(40, baIntI) '// 이미지3url
            baaltname3        = baArrList(41, baIntI) '// 알트명3
            balinkurl3        = baArrList(42, baIntI) '// 링크url3
            bacategoryOptions = baArrList(43, baIntI) '// 카테고리 코드(","구분자로 여러개의 카테고리 1뎁스 코드가 들어가 있음)
            baCouponIdx = baArrList(44, baIntI) '// 쿠폰 
            layerId			= "lyrCoupon" & baidx
            If checkBaIdx = baidx Then
                Exit For
            Else
                balinkurl = ""
                baimageurl = ""
            End If
        Next

        '// link에 파라미터 있는지 체크
        If instr(balinkurl, "?")>0 Then
            balinkurl = db2Html(balinkurl) & "&" &bagaParam & "1"
        Else
            balinkurl = db2Html(balinkurl) & "?" &bagaParam & "1"
        End If
%>
        <% If instr(balinkurl, ecode) < 1 Then '// 동일 이벤트 일 경우는 표시하지 않음 %>
            <% If balinkurl <> "" And baimageurl <> "" Then %>
                <script>
                    // 하단 기획전 배너 (20180319)
                    function bnrAni() {
                        if(!$(".bnr-evtV19").hasClass("evt-toast")){
                            $(".bnr-evtV19").addClass("evt-toast");
                            setTimeout(function(){$(".bnr-evtV19").removeClass("evt-toast");}, 6200);
                        }
                    }
                    $(function() {
                        bnrAni();
                    });
                    $(window).scroll(function(){
                        var nowSt = $(this).scrollTop();
                        if (nowSt == 0) {
                            bnrAni();
                        }
                    });
                    function setPopupCookie( name, value, expiredays ) {
                        var todayDate = new Date();
                        todayDate = new Date(parseInt(todayDate.getTime() / 86400000) * 86400000 + 54000000);
                        if (todayDate > new Date() ) {
                            expiredays = expiredays - 1;
                        }
                        todayDate.setDate( todayDate.getDate() + expiredays );
                        document.cookie = name + "=" + escape( value ) + "; path=/; expires=" + todayDate.toGMTString() + ";"
                    }
                    function bannerCloseToSevenDay(){	//오늘 하루 보지 않기
                        setPopupCookie("evtPrdLowBanner", "done", 1)
                        $(".bnr-evtV19").hide();
                    }
                </script>
                <div class="bnr-evtV19">
                    <a href="javascript:handleClicKBanner('<%=balinkurl%>', '<%=babannertype%>', '<%=baCouponIdx%>', '<%=layerId%>', '<%=ecode%>');"><img src="<%=staticImgUrl & "/main/" + db2Html(baimageurl)%>" alt="<%=baaltname%>"></a>
                    <button class="btn-close" onclick="bannerCloseToSevenDay();">오늘 하루 보지 않기</button>
                </div>
                <div id="<%=layerId%>" class="popup-lyr">
                    <div class="lyr-coupon window">
                        <h2><%=bamaincopy%></h2>
                        <button type="button" class="btn-close1" onclick="ClosePopLayer();">닫기</button>
                        <%
                            if babannertype = "2" then						
                            couponInfo = getCouponInfo(baCouponIdx)                            
                                if IsArray(couponInfo) then
                                    for i=0 to ubound(couponInfo,2)
                                        couponVal = formatNumber(couponInfo(1, i), 0)
                                        couponMin = formatNumber(couponInfo(3, i), 0)
                                    next
                        %>
                        <div class="cpn">
                            <p class="amt"><b><%=couponVal%></b>원</p>
                            <% if couponMin <> "0" and couponMin <> "" then%><p class="txt1"><b><%=couponMin%></b>원 이상 구매 시 사용 가능</p><% end if %>
                        </div>
                        <%
                                end if
                            end if
                        %>
                        <p class="txt2"><%=bamaincopy2%></p>
                        <div class="btn-area">			
                            <button type="button" class="btn-close2" onclick="ClosePopLayer();">닫기</button>
                            <% if baetctag = "1" then %><button type="button" onclick="handleClickBtn('<%=balinkurl2%>');" class="btn-down"><%=basubcopy%></button><% end if %>
                        </div>				
                    </div>
                </div>	                
            <% End If %>
        <% End If %>
    <% End If %>
<% End If %>
<% on Error Goto 0 %>
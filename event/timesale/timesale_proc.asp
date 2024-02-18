<%@codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
Response.CharSet = "UTF-8"
'###########################################################
' Description : 타임세일 
' History : 2019-10-22
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/base64.asp" -->
<!-- #include virtual="/lib/classes/ordercls/smscls.asp" -->
<!-- #include virtual="/event/timesale/timesaleCls.asp" -->
<!-- #include virtual="/lib/util/JSON_2.0.4.asp"-->
<%
	dim mode : mode = requestCheckVar(request("mode"),5)
    dim phoneNumber : phoneNumber = requestCheckVar(request("phoneNumber"),100)
    dim sendCount : sendCount = requestCheckVar(request("sendCount"),1)
    dim isAdmin : isAdmin = requestCheckVar(request("isAdmin"),1)
    dim currentDate : currentDate = "2019-12-16" '// 이벤트일
    dim LoginUserid : LoginUserid = GetEncLoginUserID()
    dim eCode : eCode = "99312"

    dim oJson , refer
    Set oJson = jsObject()

    refer = request.ServerVariables("HTTP_REFERER") '// 레퍼러

    IF application("Svr_Info") <> "Dev" THEN
        If InStr(refer, "10x10.co.kr") < 1 Then
            oJson("response") = "err"
            oJson("faildesc") = "잘못된 접속입니다."
            oJson.flush
            Set oJson = Nothing
            dbget.close() : Response.End
        End If
    END IF

    '// 카카오 메시지
    if mode = "kamsg" then 
        phoneNumber = left(Base64decode(phoneNumber),13)

        IF isAdmin <> "1" THEN
            IF Not(fnIsSendKakaoAlarm(eCode,phoneNumber)) THEN
                oJson("response") = "err"
                oJson("faildesc") = "이미 알림톡 서비스를 신청 하셨습니다."
                oJson.flush
                Set oJson = Nothing
                dbget.close() : Response.End
            END IF
        END IF

        if isnull(sendCount) or sendCount < 1 Then
            oJson("response") = "err"
            oJson("faildesc") = "알림톡 서비스를 받을 수 없습니다."
            oJson.flush
            Set oJson = Nothing
            dbget.close() : Response.End
        end if

        if isnull(phoneNumber) or len(phoneNumber) > 13 Then
            oJson("response") = "err"
            oJson("faildesc") = "전화 번호를 확인 해주세요."
            oJson.flush
            Set oJson = Nothing
            dbget.close() : Response.End
        end if

        dim fullText, failText, btnJson , requestDate , loopCnt
        dim eventCount , eventTime

        for loopCnt = 1 to sendCount
            select case loopCnt
                case 1 
                    eventCount = "마지막"
                    eventTime = "저녁 8시"
                    if isAdmin = "1" then 
                        requestDate = formatdate(DateAdd("n",5,now()),"0000.00.00 00:00:00")
                    else
                        requestDate = formatdate(DateAdd("n",-40,DateAdd("h",20,Cdate(currentDate))),"0000.00.00 00:00:00")
                    end if 
                case 2
                    eventCount = "세 번째"
                    eventTime = "오후 4시"
                    if isAdmin = "1" then 
                        requestDate = formatdate(DateAdd("n",4,now()),"0000.00.00 00:00:00")
                    else
                        requestDate = formatdate(DateAdd("n",-40,DateAdd("h",16,Cdate(currentDate))),"0000.00.00 00:00:00")
                    end if 
                case 3
                    eventCount = "두 번째"
                    eventTime = "오후 1시"
                    if isAdmin = "1" then 
                        requestDate = formatdate(DateAdd("n",3,now()),"0000.00.00 00:00:00")
                    else
                        requestDate = formatdate(DateAdd("n",-40,DateAdd("h",13,Cdate(currentDate))),"0000.00.00 00:00:00")
                    end if 
                case 4
                    eventCount = "첫 번째"
                    eventTime = "아침 9시"
                    if isAdmin = "1" then 
                        requestDate = formatdate(DateAdd("n",2,now()),"0000.00.00 00:00:00")
                    else
                        requestDate = formatdate(DateAdd("n",-40,DateAdd("h",9,Cdate(currentDate))),"0000.00.00 00:00:00")
                    end if 
            end select

            fullText = "신청하신 타임세일 알림입니다." & vbCrLf & vbCrLf &_
                    eventCount & " 타임세일이" & vbCrLf &_
                    eventTime & "에 곧 시작됩니다. " & vbCrLf &_
                    "판매 수량이 한정되어 빠르게 품절될 수 있으니 놓치지 않게 서둘러주세요!"
            failText = "[텐바이텐] 타임세일 안내입니다."
            btnJson = "{""button"":[{""name"":""바로가기"",""type"":""WL"",""url_mobile"":""https://tenten.app.link/KteXJGyFS0""}]}"

            Call SendKakaoMsg_LINKForMaketing(phoneNumber,requestDate,"1644-6030","E-0004",fullText,"SMS","",failText,btnJson)
        next 

        oJson("response") = "ok"
        oJson("sendCount") = loopCnt
		oJson.flush
		Set oJson = Nothing
		dbget.close() : Response.End
    elseif mode = "fair" then 
        dim fairPlayHtml
        dim inputBoxLocation , ButtonLocation

        isAdmin = chkiif(isAdmin = "1" , true , false)

        SELECT CASE fnGetCurrentType(isAdmin,sendCount)
            CASE 1
                inputBoxLocation = "top:437px; left:80px;"
                ButtonLocation = "top:506px; left:80px;"
            CASE 2
                inputBoxLocation = "top:472px; left:80px;"
                ButtonLocation = "top:557px; left:80px;"
            CASE 3
                inputBoxLocation = "top:437px; left:172px;"
                ButtonLocation = "top:506px; left:228px;"
            CASE 4
                inputBoxLocation = "top:472px; left:172px;"
                ButtonLocation = "top:557px; left:228px;"
            CASE ELSE
                inputBoxLocation = ""
                ButtonLocation = ""
        END SELECT

        IF inputBoxLocation = "" and ButtonLocation = "" THEN
            response.end 
        END IF

        fairPlayHtml = "<div class=""inner"">"
        fairPlayHtml = fairPlayHtml & "<p><img src=""//webimage.10x10.co.kr/fixevent/event/2019/99312/txt_fair_play.png"" alt=""우리, 페어플레이해요!""></p>"
        fairPlayHtml = fairPlayHtml & "<div class=""input-box4"" style="""& inputBoxLocation &"""><input type=""checkbox"" name=""notRobot4"" id=""notRobot4""><label for=""notRobot4""></label></div>"
        fairPlayHtml = fairPlayHtml & "<button class=""btn-get4"" style="""& ButtonLocation &""" onclick=""goDirOrdItem();""><img src=""//webimage.10x10.co.kr/fixevent/event/2019/99312/btn_get.png"" alt=""구매하기""></button>"
        fairPlayHtml = fairPlayHtml & "<button onclick=""fnBtnClose();"" class=""btn-close""></button>"
        fairPlayHtml = fairPlayHtml & "</div>"
        
        response.write fairPlayHtml
    ELSEIF mode = "order" THEN
        isAdmin = chkiif(isAdmin = "1" , true , false)
        
        dim itemid : itemid = fnGetCurrentItemId(isAdmin,sendCount)

        IF itemid = "" THEN
            oJson("response") = "fail"
            oJson("message") = "상품코드가 없습니다."
        END IF
        
        oJson("response") = "ok"
        oJson("message") = itemid
		oJson.flush
		Set oJson = Nothing
		dbget.close() : Response.End
    END IF
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
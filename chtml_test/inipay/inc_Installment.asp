<!-- #include virtual="/chtml/inipay/fun_Installment.asp" -->
<%

On Error Resume Next
''application("APP_INSTALLMENT")="" '' For Reset

if (Not IsDate(application("APP_INSTALLMENT"))) then ''값이 없으면 재생성
    CALL ReMakeInstallMentHtml(LEFT(now(),10))
elseif (DateDiff("d",application("APP_INSTALLMENT"),now())>0) then ''날짜가 바뀌면 재생성
    CALL ReMakeInstallMentHtml(LEFT(now(),10))
end if

IF application("Svr_Info")="Dev" THEN
    server.Execute "/chtml/inipay/html/inc_installment_TEST.html"
ELSE
    server.Execute "/chtml/inipay/html/inc_installment.html"
ENd IF

IF (ERR) then
    'response.write "<dl class=""cardInfoList box3 tBdr4 tMar07""></dl>"
END IF
On Error Goto 0
%>
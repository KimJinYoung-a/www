<%
Function replaceToSSLImage(orgimg)
    IF application("Svr_Info")="Dev" THEN
        replaceToSSLImage = replace(orgimg,"http://testwebimage.10x10.co.kr/","/webimage/")
    else
        replaceToSSLImage = replace(orgimg,"http://webimage.10x10.co.kr/","/webimage/")
    end if
end function

Function ReMakeInstallMentHtml(imatchDate)
    Dim savePath, FileName
    Dim BufStr, fso, tFile
    Dim sqlStr

    savePath = server.mappath("/chtml/inipay/html/") + "\"
    IF application("Svr_Info")="Dev" THEN
        FileName = "inc_installment_TEST.html"
    else
    	FileName = "inc_installment.html"
    end if

    BufStr = getInstallMentHtml(imatchDate)

    '// 기존 EUC-KR 저장
    'Set fso = CreateObject("Scripting.FileSystemObject")
	'	Set tFile = fso.CreateTextFile(savePath & FileName )
	'	tFile.Write BufStr
	'	tFile.Close
	'	Set tFile = Nothing
	'Set fso = Nothing

	'// New UTF-8 저장
	Set fso = Server.CreateObject("ADODB.Stream")
		fso.Open
		fso.Type = 2
		fso.Charset = "UTF-8"
		fso.WriteText (BufStr)
		fso.SaveToFile savePath & FileName, 2
	Set fso = nothing	

    application("APP_INSTALLMENT")=NOW()
end Function


function getInstallMentHtml(imatchDate)
    Dim sqlStr, ArrRows, i,j,irowCnt

    sqlStr = "select top 20" + vbcrlf
    sqlStr = sqlStr + " p.idx,p.cimage,p.pgprogbn,p.cardcd,p.sDt,p.eDt,p.conts,p.contlink,p.isusing,p.regdate " + vbcrlf
    sqlStr = sqlStr + " from db_sitemaster.dbo.tbl_pg_promotion p " + vbcrlf
    sqlStr = sqlStr + " where 1=1 "
    sqlStr = sqlStr&" and isusing='Y'"
    sqlStr = sqlStr&" and sDt<='"&imatchDate&"'"
    sqlStr = sqlStr&" and eDt>='"&imatchDate&"'"
    sqlStr = sqlStr&" and ((pgprogbn='m' and idx in ("  ''날짜가 겹칠경우 최종idx기준
    sqlStr = sqlStr&" 	select Max(idx)"
    sqlStr = sqlStr&" 	from db_sitemaster.dbo.tbl_pg_promotion"
    sqlStr = sqlStr&" 	where 1=1 and isusing='Y' "
    sqlStr = sqlStr&" 	and sDt<='"&imatchDate&"' " + vbcrlf
    sqlStr = sqlStr&" 	and eDt>='"&imatchDate&"' " + vbcrlf
    sqlStr = sqlStr&" 	and pgprogbn in ('m')"
    sqlStr = sqlStr&" 	group by cardCd"
    sqlStr = sqlStr&" )) or (pgprogbn='a' and idx in ("
    sqlStr = sqlStr&" 	select Max(idx)"
    sqlStr = sqlStr&" 	from db_sitemaster.dbo.tbl_pg_promotion"
    sqlStr = sqlStr&" 	where 1=1 and isusing='Y' "
    sqlStr = sqlStr&" 	and sDt<='"&imatchDate&"' " + vbcrlf
    sqlStr = sqlStr&" 	and eDt>='"&imatchDate&"' " + vbcrlf
    sqlStr = sqlStr&" 	and pgprogbn in ('a')"
    sqlStr = sqlStr&" )) or (pgprogbn='b'))"
    sqlStr = sqlStr&" order by p.pgprogbn desc, p.CardCd asc, p.idx desc"

    rsget.Open sqlStr,dbget,1
    if Not (rsget.Eof) then
        ArrRows = rsget.getRows()
    end if
    rsget.close

    Dim BufStr : BufStr= ""
    Dim BufMoo : BufMoo= ""
    Dim BufBan : BufBan= ""
    Dim BufDft : BufDft= ""

    if IsArray(ArrRows) then
        irowCnt = UBound(ArrRows,2)


    	'' 컨텐츠 시작
    	for i=0 to irowCnt
    	    if ArrRows(2,i)="m" then
            	BufMoo = BufMoo & "<li>"
            	BufMoo = BufMoo & "<span class='cardImg'><img src='"&getCardCd2ImgURL(ArrRows(3,i))&"' alt='"&getCardCd2Name(ArrRows(3,i))&"' /></span>"
            	BufMoo = BufMoo & "<strong class='cardName'>"&getCardCd2Name(ArrRows(3,i))&"</strong>"
            	BufMoo = BufMoo & "<p class='cardInfo'>"&(ArrRows(6,i))&"</p>"
            	BufMoo = BufMoo & "</li>"
            end if


        	''관련 배너가 있는경우
        	if ArrRows(2,i)="b" then
            	BufBan = BufBan & "<dd>"
            	BufBan = BufBan & "<img src='"&replaceToSSLImage(ArrRows(1,i))&"' alt='"&getCardCd2Name(ArrRows(6,i))&"' />"
            	BufBan = BufBan & "</dd>"
            end if

            ''미지정시 배너가 있는경우
        	if ArrRows(2,i)="a" then
            	BufDft = BufDft & "<dd>"
            	if (ArrRows(7,i)<>"") then
            	    BufDft = BufDft & "<a href='"&ArrRows(7,i)&"' target='_blank'><img src='"&replaceToSSLImage(ArrRows(1,i))&"' alt='"&getCardCd2Name(ArrRows(6,i))&"' /></a>"
            	else
                	BufDft = BufDft & "<img src='"&replaceToSSLImage(ArrRows(1,i))&"' alt='"&getCardCd2Name(ArrRows(6,i))&"' />"
                end if
            	BufDft = BufDft & "</dd>"
            end if


        next

        BufStr =""
        if (BufMoo<>"") then
            BufStr = BufStr & "<dt>카드 무이자 할부 안내</dt>"
        	BufStr = BufStr & "<dd>"
        	BufStr = BufStr & "<ul>"
        	BufStr = BufStr & BufMoo
            BufStr = BufStr & "</ul>"
            BufStr = BufStr & "</dd>"
        end if

        if (BufBan<>"") then
            BufStr = BufStr & BufBan
        end if

        if (BufMoo="") and (BufBan="") and (BufDft<>"") then
            BufStr = BufStr & BufDft
        end if

        if (BufStr<>"") then
            BufStr = "<dl class=""cardInfoList box3 tBdr4 tMar07"">"&BufStr&"</dl>"
        end if

    end if
    getInstallMentHtml = BufStr
end function

function getCardCd2Name(icdCode)
    select CASE icdCode
        CASE "01"
            getCardCd2Name = "신한카드"
        CASE "02"
            getCardCd2Name = "외환카드"
        CASE "03"
            getCardCd2Name = "비씨카드"
        CASE "04"
            getCardCd2Name = "삼성카드"
        CASE "05"
            getCardCd2Name = "국민카드"
        CASE "06"
            getCardCd2Name = "농협카드"
        CASE "07"
            getCardCd2Name = "하나SK카드"
        CASE "08"
            getCardCd2Name = "롯데카드"
        CASE "09"
            getCardCd2Name = "현대카드"
        CASE ELSE
            getCardCd2Name = ""
    end Select
end function

function getCardCd2ImgURL(icdCode)
    getCardCd2ImgURL = "/fiximage/web2013/cart/card_img"&icdCode&".gif"
end function
%>
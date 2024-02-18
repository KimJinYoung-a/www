<%
 DIM CAddDetailSpliter : CAddDetailSpliter= CHR(3)&CHR(4)

 Dim staticImgUrl,uploadUrl,wwwUrl,SSLUrl,www1Url,webImgUrl,mobileUrl
 Dim NaverSCRIPT ''네이버 웹로그 관련 변수 선언
 Dim DaumSCRIPT	''다음 관련 변수 선언
 Dim RecoPickSCRIPT	''RecoPick 관련 변수 선언
 Dim facebookSCRIPT	''FaceBook 관련 변수 선언
 Dim googleADSCRIPT	''Google ADS 관련 변수 선언
 Dim googleANAL_PRESCRIPT ''Google analytics 관련 변수 선언 _trackPageview 이전
 Dim googleANAL_ADDSCRIPT ''Google analytics 관련 변수 선언 _trackPageview 이후
 Dim googleANAL_EXTSCRIPT ''Google analytics 관련 변수 선언 신규 GA관련
 Dim appBoy_ADDPurchases ''앱보이 결제로그 전송
 Dim appBoyCustomEvent	''앱보이 CustomEvent 값 전송
 Dim kakaoAnal_AddScript ''Kakao Analytics 관련변수
 Dim CriteoUserMailMD5	''크리테오에 전송할 유저 이메일 MD5값
 Dim dataDive_IniApiKey ''Datadive용 initApiKey(현재(2021.12.31기준)는 사용안하지만 혹시 몰라서 변수는 남겨둠)

 Dim cFlgDBUse : cFlgDBUse = true		'페이지 내 DB사용 항목들의 표시(사용) 여부

 Dim DocSvrAddr, DocSvrPort, DocAuthCode , uploadImgUrl, staticImgUpUrl
 Dim G_IsLocalDev : G_IsLocalDev = False

 IF application("Svr_Info")="Dev" THEN
 	staticImgUrl	= "http://testimgstatic.10x10.co.kr"	'테스트
 	uploadUrl		= "http://testimgstatic.10x10.co.kr"
 	staticImgUpUrl	= "http://testimgstatic.10x10.co.kr"
 	webImgUrl		= "http://testwebimage.10x10.co.kr"
 	wwwUrl			= "http://2015www.10x10.co.kr"
 	SSLUrl			= "https://2015www.10x10.co.kr"
 	www1Url			= "http://2015www.10x10.co.kr"
 	DocSvrAddr      = "61.252.133.4"
 	DocSvrPort      = "6167"
	uploadImgUrl    = "http://testupload.10x10.co.kr"
	mobileUrl		= "http://testm.10x10.co.kr"

    if (request.ServerVariables("LOCAL_ADDR")="::1") or (request.ServerVariables("LOCAL_ADDR")="127.0.0.1") then
        wwwUrl= ""
        SSLUrl =""
        G_IsLocalDev = True
    end if
 ELSE
 	staticImgUrl	= "http://imgstatic.10x10.co.kr"
	staticImgUpUrl	= "https://oimgstatic.10x10.co.kr"
 	uploadUrl		= "http://upload.10x10.co.kr"
 	webImgUrl		= "http://webimage.10x10.co.kr"
 	wwwUrl			= "http://www.10x10.co.kr"
	SSLUrl			= "https://www.10x10.co.kr"
	www1Url			= "http://www1.10x10.co.kr"
 	DocSvrAddr      = ""	'110.93.128.107
 	DocSvrPort      = ""
	uploadImgUrl    = "http://upload.10x10.co.kr"          '' upload.10x10.co.kr 통해서 Nas Server로 업로드
	mobileUrl		= "http://m.10x10.co.kr"
 END IF

 IF (application("Svr_Info")="staging") THEN
    wwwUrl			= "http://stgwww.10x10.co.kr"
	SSLUrl			 = "https://www.10x10.co.kr"
	www1Url			= "http://stgwww.10x10.co.kr"
 END IF
    
function fnPasingStaticContents(linktype,fixtype,posVarName,imageUrl,linkUrl,imagewidth,imageheight,posname)
    dim ret

    if (linktype="L") then
        ret = "<img src='" & staticImgUrl & "/main/" & db2html(rsget("imageurl")) & "'"

        if imagewidth>0 then ret = ret & " width='" & imagewidth & "'"
        if imageheight>0 then ret = ret & " height='" & imageheight & "'"
        if posname<>"" then ret = ret & " alt='" & posname & "'"
        ret = ret & " >"

        if (Not IsNULL(linkUrl)) and (linkUrl<>"") then
            ret = "<a href='" & linkUrl & "' onFocus='blur()' text='" & db2html(rsget("linkText")) & "' logoTp='" & db2html(rsget("linkText2")) & "'><span class='imgOverV15'>" & ret & "</span></a>"		'절대 onfocus 지우지 마세요~
        end if

        fnPasingStaticContents = ret

    elseif (linktype="M") then
        ret = "<img src='" & staticImgUrl & "/main/" & db2html(rsget("imageurl")) & "'"

        if imagewidth>0 then ret = ret & " width='" & imagewidth & "'"
        if imageheight>0 then ret = ret & " height='" & imageheight & "'"
        if posname<>"" then ret = ret & " alt='" & posname & "'"
        ret = ret & " border='0' usemap='#Map_" + posVarName + "'>"

        if (Not IsNULL(linkUrl)) and (linkUrl<>"") then
            ret = ret & Replace(linkUrl,VbCrlf," ")
        end if
        fnPasingStaticContents = ret

    elseif (linktype="T") then
        if (Not IsNULL(linkUrl)) and (linkUrl<>"") then
            ret = "<a href='" & linkUrl & "' onFocus='blur()'>" & db2html(rsget("linkText")) & "</a>"
        end if

        fnPasingStaticContents = ret
    end if

 end function

 '' 헤더 App Data - 3Contents
 function fnGetHeaderContents(byref iArrVar, byval iArrKey)
    dim sqlStr, i, cnt, poscode
    dim ArrayKeyStr

    cnt = UBound(iArrKey)+1

    'Application("chk_header_Contents")= -1 ''초기화 may be 1899.01.01
    ''''하루 한번 0시 3분쯤 WebSV 시간이 DB시간보다 느린경우 처리?
    if (Application("chk_header_Contents")= -1) _
        or (Application("chk_header_Contents")= "") _
        or ((dateDiff("d",Application("chk_header_Contents"),now())) and (DateDiff("n",DateSerial(Year(date),Month(date),Day(date)), now())>3)) then
        '파일 생성 시간 저장
	    Application("chk_header_Contents") = now()

	    for i=0 to cnt-1
	        ArrayKeyStr = ArrayKeyStr & iArrKey(i) & "','"
	    next
	    ArrayKeyStr = "'" & ArrayKeyStr & "'"

	    sqlStr = "select C.*,p.posname from [db_sitemaster].[dbo].tbl_main_contents C"
        sqlStr = sqlStr & " Join ("
        sqlStr = sqlStr & " 	select max(idx) as Midx, poscode "
        sqlStr = sqlStr & " 	from [db_sitemaster].[dbo].tbl_main_contents"
        sqlStr = sqlStr & " 	where poscode in (" & ArrayKeyStr & ")"
        sqlStr = sqlStr & " 	and startdate<=getdate()"
        sqlStr = sqlStr & " 	and enddate>getdate()"
        sqlStr = sqlStr & " 	and isusing='Y'"
        sqlStr = sqlStr & " 	and (IsNULL(imageurl,'')<>'' or isNull(linkText,'')<>'')"
        sqlStr = sqlStr & " 	group by poscode"
        sqlStr = sqlStr & " 	Union"
        ''sqlStr = sqlStr & " 	-- 종료후 등록 안했을경우 대비."
        sqlStr = sqlStr & " 	select  max(idx) as Midx, poscode "
        sqlStr = sqlStr & " 	from [db_sitemaster].[dbo].tbl_main_contents"
        sqlStr = sqlStr & " 	where poscode in (" & ArrayKeyStr & ")"
        sqlStr = sqlStr & " 	and startdate<=getdate()"
        ''sqlStr = sqlStr & " 	--and enddate>getdate()"
        sqlStr = sqlStr & " 	and isusing='Y'"
        sqlStr = sqlStr & " 	and (IsNULL(imageurl,'')<>'' or isNull(linkText,'')<>'')"
        sqlStr = sqlStr & " 	and poscode not in ("
		sqlStr = sqlStr & " 	    select distinct poscode "
		sqlStr = sqlStr & " 	    from [db_sitemaster].[dbo].tbl_main_contents"
		sqlStr = sqlStr & " 	    where poscode in (" & ArrayKeyStr & ")"
		sqlStr = sqlStr & " 	    and startdate<=getdate()"
		sqlStr = sqlStr & " 	    and enddate>getdate()"
		sqlStr = sqlStr & " 	    and isusing='Y'"
		sqlStr = sqlStr & " 	    and (IsNULL(imageurl,'')<>'' or isNull(linkText,'')<>'')"
	    sqlStr = sqlStr & " 	)"
        sqlStr = sqlStr & " 	group by poscode"
        sqlStr = sqlStr & " ) T on C.idx=T.Midx"
        sqlStr = sqlStr & " left join [db_sitemaster].dbo.tbl_main_contents_poscode p"
        sqlStr = sqlStr & " 	on c.poscode=p.poscode"

        'response.write ".."
        rsget.Open sqlStr, dbget, 1
        if Not rsget.Eof then
            do until rsget.Eof
                poscode = rsget("poscode")
                for i=0 to cnt-1
                    if (poscode=iArrKey(i)) then
                        iArrVar(i) = fnPasingStaticContents(rsget("linktype"),rsget("fixtype"),rsget("posVarName"),db2Html(rsget("imageUrl")),db2Html(rsget("linkUrl")),rsget("imagewidth"),rsget("imageheight"),db2html(rsget("posname")))
                        Exit For
                    end if
                next
                rsget.moveNext
            loop
            Application("Dat_header_Contents") = iArrVar
            Application("Key_header_Contents") = iArrKey
        end if
        rsget.Close
	end if

	if IsArray(Application("Dat_header_Contents")) then
	    for i=0 to cnt-1
	        if UBound(Application("Dat_header_Contents"))>=i then iArrVar(i) = Application("Dat_header_Contents")(i)
	    next
	end if
 end function

 '' 인덱스 App Data - 20 Contents Max(REAL)
 function fnGetIdxContents(byref iArrVar, byval iArrKey)
    dim sqlStr, i, cnt, poscode
    dim ArrayKeyStr

    cnt = UBound(iArrKey)+1

    'Application("chk_idx_Contents")= -1 ''초기화 may be 1899.01.01
    ''하루 한번 0시 3분쯤
    if (Application("chk_idx_Contents")= -1) _
        or (Application("chk_idx_Contents")= "") _
        or ((dateDiff("d",Application("chk_idx_Contents"),now())) and (DateDiff("n",DateSerial(Year(date),Month(date),Day(date)), now())>3)) then
        '파일 생성 시간 저장
	    Application("chk_idx_Contents") = now()

	    for i=0 to cnt-1
	        ArrayKeyStr = ArrayKeyStr & iArrKey(i) & "','"
	    next

	    ArrayKeyStr = "'" & ArrayKeyStr & "'"

	    sqlStr = "select C.* ,p.posname from [db_sitemaster].[dbo].tbl_main_contents C"
        sqlStr = sqlStr & " Join ("
        sqlStr = sqlStr & " 	select max(idx) as Midx, poscode "
        sqlStr = sqlStr & " 	from [db_sitemaster].[dbo].tbl_main_contents"
        sqlStr = sqlStr & " 	where poscode in (" & ArrayKeyStr & ")"
        sqlStr = sqlStr & " 	and startdate<=getdate()"
        sqlStr = sqlStr & " 	and enddate>getdate()"
        sqlStr = sqlStr & " 	and isusing='Y'"
        sqlStr = sqlStr & " 	and (IsNULL(imageurl,'')<>'' or isNull(linkText,'')<>'')"
        sqlStr = sqlStr & " 	group by poscode"
        sqlStr = sqlStr & " 	Union"
        ''sqlStr = sqlStr & " 	-- 종료후 등록 안했을경우 대비."
        sqlStr = sqlStr & " 	select  max(idx) as Midx, poscode "
        sqlStr = sqlStr & " 	from [db_sitemaster].[dbo].tbl_main_contents"
        sqlStr = sqlStr & " 	where poscode in (" & ArrayKeyStr & ")"
        sqlStr = sqlStr & " 	and startdate<=getdate()"
        ''sqlStr = sqlStr & " 	--and enddate>getdate()"
        sqlStr = sqlStr & " 	and isusing='Y'"
        sqlStr = sqlStr & " 	and (IsNULL(imageurl,'')<>'' or isNull(linkText,'')<>'')"
        sqlStr = sqlStr & " 	and poscode not in ("
		sqlStr = sqlStr & " 	    select distinct poscode "
		sqlStr = sqlStr & " 	    from [db_sitemaster].[dbo].tbl_main_contents"
		sqlStr = sqlStr & " 	    where poscode in (" & ArrayKeyStr & ")"
		sqlStr = sqlStr & " 	    and startdate<=getdate()"
		sqlStr = sqlStr & " 	    and enddate>getdate()"
		sqlStr = sqlStr & " 	    and isusing='Y'"
		sqlStr = sqlStr & " 	    and (IsNULL(imageurl,'')<>'' or isNull(linkText,'')<>'')"
	    sqlStr = sqlStr & " 	)"
        sqlStr = sqlStr & " 	group by poscode"
        sqlStr = sqlStr & " ) T on C.idx=T.Midx"
        sqlStr = sqlStr & " left join [db_sitemaster].dbo.tbl_main_contents_poscode p"
        sqlStr = sqlStr & " 	on c.poscode=p.poscode"

        'response.write sqlStr
        rsget.Open sqlStr, dbget, 1
        if Not rsget.Eof then
            do until rsget.Eof
                poscode = rsget("poscode")
                for i=0 to cnt-1
                    if (poscode=iArrKey(i)) then
                        iArrVar(i) = fnPasingStaticContents(rsget("linktype"),rsget("fixtype"),rsget("posVarName"),db2Html(rsget("imageUrl")),db2Html(rsget("linkUrl")),rsget("imagewidth"),rsget("imageheight"),db2html(rsget("posname")))
                        Exit For
                    end if
                next
                rsget.moveNext
            loop
            Application("Dat_idx_Contents") = iArrVar
            Application("Key_idx_Contents") = iArrKey
        end if
        rsget.Close
	end if

	if IsArray(Application("Dat_idx_Contents")) then
	    for i=0 to cnt-1
	        if UBound(Application("Dat_idx_Contents"))>=i then iArrVar(i) = Application("Dat_idx_Contents")(i)
	    next
	end if
end function

'' 인덱스 App Data - 20 Contents Max(TEST)
function fnGetIdxContents_TEST(byref iArrVar, byval iArrKey)
    dim sqlStr, i, cnt, poscode
    dim ArrayKeyStr

    cnt = UBound(iArrKey)+1

	'// TEST TEST 항상 새로고침
	Application("chk_idx_Contents_TEST") = -1

    if (Application("chk_idx_Contents_TEST")= -1) _
        or (Application("chk_idx_Contents_TEST")= "") _
        or ((dateDiff("d",Application("chk_idx_Contents_TEST"),now())) and (DateDiff("n",DateSerial(Year(date),Month(date),Day(date)), now())>3)) then
        '파일 생성 시간 저장
	    Application("chk_idx_Contents_TEST") = now()

	    for i=0 to cnt-1
	        ArrayKeyStr = ArrayKeyStr & iArrKey(i) & "','"
	    next

	    ArrayKeyStr = "'" & ArrayKeyStr & "'"

	    sqlStr = "select C.* ,p.posname from [db_sitemaster].[dbo].tbl_main_contents C"
        sqlStr = sqlStr & " Join ("
        sqlStr = sqlStr & " 	select max(idx) as Midx, poscode "
        sqlStr = sqlStr & " 	from [db_sitemaster].[dbo].tbl_main_contents"
        sqlStr = sqlStr & " 	where poscode in (" & ArrayKeyStr & ")"
        sqlStr = sqlStr & " 	and startdate<=getdate()"
        sqlStr = sqlStr & " 	and enddate>getdate()"
        sqlStr = sqlStr & " 	and isusing='Y'"
        sqlStr = sqlStr & " 	and (IsNULL(imageurl,'')<>'' or isNull(linkText,'')<>'')"
        sqlStr = sqlStr & " 	group by poscode"
        sqlStr = sqlStr & " 	Union"
        ''sqlStr = sqlStr & " 	-- 종료후 등록 안했을경우 대비."
        sqlStr = sqlStr & " 	select  max(idx) as Midx, poscode "
        sqlStr = sqlStr & " 	from [db_sitemaster].[dbo].tbl_main_contents"
        sqlStr = sqlStr & " 	where poscode in (" & ArrayKeyStr & ")"
        sqlStr = sqlStr & " 	and startdate<=getdate()"
        ''sqlStr = sqlStr & " 	--and enddate>getdate()"
        sqlStr = sqlStr & " 	and isusing='Y'"
        sqlStr = sqlStr & " 	and (IsNULL(imageurl,'')<>'' or isNull(linkText,'')<>'')"
        sqlStr = sqlStr & " 	and poscode not in ("
		sqlStr = sqlStr & " 	    select distinct poscode "
		sqlStr = sqlStr & " 	    from [db_sitemaster].[dbo].tbl_main_contents"
		sqlStr = sqlStr & " 	    where poscode in (" & ArrayKeyStr & ")"
		sqlStr = sqlStr & " 	    and startdate<=getdate()"
		sqlStr = sqlStr & " 	    and enddate>getdate()"
		sqlStr = sqlStr & " 	    and isusing='Y'"
		sqlStr = sqlStr & " 	    and (IsNULL(imageurl,'')<>'' or isNull(linkText,'')<>'')"
	    sqlStr = sqlStr & " 	)"
        sqlStr = sqlStr & " 	group by poscode"
        sqlStr = sqlStr & " ) T on C.idx=T.Midx"
        sqlStr = sqlStr & " left join [db_sitemaster].dbo.tbl_main_contents_poscode p"
        sqlStr = sqlStr & " 	on c.poscode=p.poscode"

        'response.write sqlStr
        rsget.Open sqlStr, dbget, 1
        if Not rsget.Eof then
            do until rsget.Eof
                poscode = rsget("poscode")
                for i=0 to cnt-1
                    if (poscode=iArrKey(i)) then
                        iArrVar(i) = fnPasingStaticContents(rsget("linktype"),rsget("fixtype"),rsget("posVarName"),db2Html(rsget("imageUrl")),db2Html(rsget("linkUrl")),rsget("imagewidth"),rsget("imageheight"),db2html(rsget("posname")))
                        Exit For
                    end if
                next
                rsget.moveNext
            loop
            Application("Dat_idx_Contents_TEST") = iArrVar
            Application("Key_idx_Contents_TEST") = iArrKey
        end if
        rsget.Close
	end if

	if IsArray(Application("Dat_idx_Contents_TEST")) then
	    for i=0 to cnt-1
	        if UBound(Application("Dat_idx_Contents_TEST"))>=i then iArrVar(i) = Application("Dat_idx_Contents_TEST")(i)
	    next
	end if
end function

	'// 사용자 브라우저 언어 코드
	Dim cUserLangCd
	cUserLangCd = LCase(Request.ServerVariables("HTTP_ACCEPT_LANGUAGE"))

	'브라우저 언어의 우선순위로 주언어 접수(세미콜론으로 구분)
	if cUserLangCd<>"" then cUserLangCd = split(cUserLangCd,";")(0)

	'언어 분기 	>> 언어코드 참고 (http://www.todal.net/26)
	if Instr(cUserLangCd,"ko")>0 then
		cUserLangCd = "ko"		'한국어
	elseif Instr(cUserLangCd,"zh")>0 then
		cUserLangCd = "zh"		'중국어
	elseif Instr(cUserLangCd,"jp")>0 then
		cUserLangCd = "jp"		'일본어
	elseif Instr(cUserLangCd,"en")>0 then
		cUserLangCd = "en"		'영어
	else
		cUserLangCd = "ko"		'기본값(한국어)
	end if
%>

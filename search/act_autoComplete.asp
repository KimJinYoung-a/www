<%@ codepage="65001" language="VBScript" %>
<%
option Explicit
Response.Buffer = True
Response.CharSet = "utf-8"
%>
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
	dim Docruzer, seed_str

	'검색어 접수	
	seed_str = Request("str")
''seed_str = "노"
	'독크루저 컨퍼넌트 선언
	''SET Docruzer = Server.CreateObject("ATLDocruzer_3_2.Client")
	SET Docruzer = Server.CreateObject("ATLKSearch.Client")
	
	if Docruzer.BeginSession()<0 then
		'에러시 메세지 표시
		Response.Write "BeginSession: " & Docruzer.GetErrorMessage()
	else
				
		IF NOT DocSetOption(Docruzer) THEN
			Response.Write "SetOption: " & Docruzer.GetErrorMessage()
		ELSE
		    '실행
		    Call doMain(seed_str)
		    Call Docruzer.EndSession()
		End If
	end if
	
	'독크루저 종료
	Set Docruzer = Nothing

    public function DocSetOption(iDocruzer)
        dim ret 
        ret = iDocruzer.SetOption(iDocruzer.OPTION_REQUEST_CHARSET_UTF8,1)
        DocSetOption = (ret>=0)
    end function
    
	'메인실행 함수
	Sub doMain(seed_str)
		Dim SvrAddr, SvrPort
		Dim ret, i, nFlag, cnv_str, max_count
		Dim kwd_count, kwd_list
		Dim objXML, objXMLv

		IF application("Svr_Info")	= "Dev" THEN
		    ''SvrAddr = "110.93.128.108"''2차실서버
			''SvrAddr = "61.252.133.4"'DocSvrAddr(테섭)
			SvrAddr = "192.168.50.10"       'ksearch
		ELSE
			''SvrAddr = "192.168.0.109"'DocSvrAddr(실섭)
			SvrAddr = "192.168.0.206"  ''"192.168.0.206"
			'SvrAddr = "110.93.128.106"
		END IF

		if (Application("G_ORGSCH_ADDR")="") then
			Application("G_ORGSCH_ADDR")=SvrAddr
		end if

		SvrAddr = Application("G_ORGSCH_ADDR")

		SvrPort = "6167"			'DocSvrPort

		nFlag = 2		'검색방법 (0:앞부터, 1: 뒤부터, 2:앞or뒤)
		cnv_str = ""	'한영자동변환 결과
		max_count = 10	'최대 검색 수

		'자동완성 검색
		ret = Docruzer.CompleteKeyword( _
					SvrAddr & ":" & SvrPort _
					,kwd_count, kwd_list, cnv_str, max_count, seed_str, nFlag, 5) '' TEST -4
			
		'에러 출력
		if(ret<0) then
			Response.Write "Error: " & Docruzer.GetErrorMessage()
			exit Sub
		end if

			'----- XML 컨퍼넌트 선언
			Set objXML = server.CreateObject("Microsoft.XMLDOM")
			objXML.async = False

			'----- XML 해더 생성
			objXML.appendChild(objXML.createProcessingInstruction("xml","version=""1.0"""))
			objXML.appendChild(objXML.createElement("categoryPage"))
			
			'-----프로세스 시작
			for i=0 to kwd_count-1
				Set objXMLv = objXML.createElement("item")
				
				objXMLv.appendChild(objXML.createElement("No"))
				objXMLv.appendChild(objXML.createElement("Flag"))
				objXMLv.appendChild(objXML.createElement("Word"))
				objXMLv.appendChild(objXML.createElement("Seed"))
				objXMLv.appendChild(objXML.createElement("Conv"))
				
				objXMLv.childNodes(0).text = i
				objXMLv.childNodes(1).text = nFlag
				objXMLv.childNodes(2).text = kwd_list(i)
				objXMLv.childNodes(3).text = seed_str
				if cnv_str<>"" then
					objXMLv.childNodes(4).text = "null" ''cnv_str ''ksearch4 동작방식 다름
				else
					objXMLv.childNodes(4).text = "null"
				end if
				
				objXML.documentElement.appendChild(objXMLv.cloneNode(True))
				Set objXMLv = Nothing
			next

			'----- 생성된 내용 출력
			Response.ContentType = "text/xml"
			Response.Write(objXML.xml)
			
			'-----객체 해제
			Set objXML = Nothing

			Set kwd_list = Nothing
	end Sub
%>
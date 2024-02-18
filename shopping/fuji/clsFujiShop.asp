<%
'후지필름에서 템플릿 경로와 업로드 정보 데이터를 받아오기 위한 클래스 파일입니다.
'XML 로 통신을 하게 되며, 편집 팝업창에서 생성하셔서 이용하시면됩니다.

function getFujiCode(byval itemid, byval itemoption, byref pcode, byref tplcode, byref tplname)
    dim sqlStr
    sqlStr = " select top 1 * from db_item.dbo.tbl_fuji_templete_code" & VbCrlf
    sqlStr = sqlStr & " where itemid="&itemid & VbCrlf
    sqlStr = sqlStr & " and itemoption='"&itemoption&"'" & VbCrlf
    
    rsget.Open sqlStr, dbget, 1
    if Not (rsget.Eof) then
        pcode = rsget("pcode")
        tplcode = rsget("tplcode")
        tplname = rsget("tplname")
    end if   
    rsget.Close
end function

Class clsFujiShop
	Public ShopID '샵 아이디
	Public RequestURL '정보를 받아오기 위한 URL 정의
	public objXML, objDom, objDoc 'XML 객체변수
	public ErrCode, ErrMsg '에러코드 및 에러 메시지 (ErrCode 값이 "0" 이 아닌 경우 에러를 리턴합니다.)
	Public DocPath '리턴 받는 문서의 경로
	Public UpPath '리턴받는 업로드 경로
	Public UpFileName '업로드하는 파일명
	Public TemplateCode '템플릿 코드
	Public ProductCode '제품 코드
	Public Enckey '연동할 암호화 키	
    Public AXCls, AXPath 'ActiveX 의 클래스아이디, 최근 버전, 위치
    
	'객체 생성 초기화시 변수 값 정의 (값을 변경하지 마세요)
	Sub Class_Initialize()
		ShopID = "910005"
		Enckey = "5XEPR0Ya59O0PuBHu3Bo5TW1jO0gM2JXvld48T4bs2zYmQL1" '후지필름에서 제공받은 암호화 키
		RequestURL = "http://info.photolooks.kr/provider/ajax/get_template.asp"
	End Sub

	'객체 해제시 정의 (명시적으로 해제하지 않아도 페이지 종료시 해제됨)
	Sub Class_Terminate()
		Set objDoc = Nothing
		Set objDom = Nothing
		Set objXML = Nothing		
	End sub

	'XML 객체 생성 함수
	'Param - url : 호출하는 URL
	Sub MakeXMLHTTP(byVal url)
		Dim param
		param = "enc="& Me.Enckey &"&shopid="& Me.ShopID &"&tplcode="& Me.TemplateCode & "&pcode="& Me.ProductCode & "&cartfile="& Me.DocPath
		set objXML = CreateObject("Microsoft.XMLHTTP")
		with objXML
			.open "POST", url, false
			.setRequestHeader "Content-Type","application/x-www-form-urlencoded"
			.send param
		end with

		Set objDom = CreateObject("Microsoft.XMLDOM")
		with objDom
			.async = False ' 동기식 호출
			.load objXML.responseBody
			set objDoc = .DocumentElement
		end with	
	End Sub


	'실제 요청하는 프로시저 - 파라미터는 모두 필수는 아니지만 
	'm_tpl 과 _pcd 는 쌍으로 입력되어야 하며, (m_tpl and m_pcd) 와 m_cartfile 은 둘중에 하나 필수
	'm_tpl : 템플릿코드 (필수X)
	'm_pcd : 제품코드 (필수X)
	'm_cartfile : 장바구니 파일명 (필수X), 우선순위
	Sub RequsetTemplate(ByVal m_tpl, ByVal m_pcd, ByVal m_cartfile)
		Me.TemplateCode = m_tpl
		Me.ProductCode = m_pcd
		Me.DocPath = m_cartfile '장바구니에서 읽어온다면 파일

		'파라미터 값이 올바르지 않다면 에러 리턴
		If (m_tpl = "" or m_pcd = "") and Len(m_cartfile) < 5 Then
			Me.ErrCode = "-9"
			ME.ErrMsg = "파라미터 값이 올바르지 않습니다."
			Exit Sub
		End if

		Call Me.MakeXMLHTTP(Me.RequestURL) 'XML 통신 연결 및 리턴 데이터 세팅
        Dim statNode, ActXNode
		set statNode = objDoc.getElementsByTagName("stat")(0)
		Set ActXNode = objDoc.getElementsByTagName("axinfo")(0)

		Me.ErrCode = statNode.getAttribute("errcd") '리턴 에러 코드
		Me.ErrMsg = statNode.getAttribute("errmsg")	 '리턴 에러 메시지
		Me.AXCls = ActXNode.getAttribute("clsid")	 '리턴 
		Me.AXPath = ActXNode.getAttribute("axurl")	 '리턴 
		
		Me.DocPath = objDoc.getElementsByTagName("downpath")(0).Text '다운로드 경로
		Me.UpPath = objDoc.getElementsByTagName("uppath")(0).Text '업로드 경로 및 파일명
		Me.UpFileName = objDoc.getElementsByTagName("upfile")(0).Text '업로드 경로 및 파일명

		Set statNode = Nothing
	End Sub

End Class

%>
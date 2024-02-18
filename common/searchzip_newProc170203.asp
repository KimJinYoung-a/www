<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 주소검색 처리 페이지
' History : 2016.06.16 원승현
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbEVTopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/search/Zipsearchcls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
	Dim i '// for문 변수
	Dim refer '// 리퍼러
	Dim strsql '// 쿼리문
	Dim sGubun '// 주소구분(지번, 도로명+건물번호, 동+지번, 건물명)
	Dim tmpconfirmVal '// 리스트 리턴값 저장
	Dim tmppagingVal '// 페이징값 저장
	Dim tmpsReturnCnt '// 리턴값 검색갯수 카운트
	Dim sSidoGubun '// 시군구 구분을 위한 시도값
	Dim tmpReturngungu '// 시군구 리턴값
	Dim sSido '// 시도값
	Dim sGungu '// 시군구값
	Dim sRoadName '// 도로명값
	Dim sRoadBno '// 빌딩번호값
	Dim sRoaddong '// 도로명 동 검색값
	Dim sRoadjibun '// 도로명 지번 검색값
	Dim sRoadBname '// 도로명 건물명 검색값
	Dim sJibundong '// 지번주소의 검색어
	Dim tmpOfficial_bld '// 건물명 임시저장값
	Dim tmpJibun '// 지번 합친값
	Dim zipcodeTableVal '// 우편번호 테이블
	Dim zipcodeGugunVal '// 우편번호 구군

	Dim tmpsRoadBno
	Dim tmpsJibundong
	Dim tmpsJibundongjgubun
	Dim qrysJibundong

	dim PageSize	: PageSize = getNumeric(requestCheckVar(request("psz"),5))
	dim CurrPage : CurrPage = getNumeric(requestCheckVar(request("cpg"),8))
	if CurrPage="" then CurrPage=1
	if PageSize="" then PageSize=10

	tmpconfirmVal = ""
	tmpReturngungu = ""
	qrysJibundong = ""

	refer = request.ServerVariables("HTTP_REFERER")
	sGubun = requestCheckVar(Request("sGubun"),32)
	sJibundong = requestCheckVar(Request("sJibundong"),512)
	sSidoGubun = requestCheckVar(Request("sSidoGubun"),128)
	sSido = requestCheckVar(Request("sSido"),128)
	sGungu = requestCheckVar(Request("sGungu"),128)
	sRoadName = requestCheckVar(Request("sRoadName"),256)
	sRoadBno = requestCheckVar(Request("sRoadBno"),128)
	sRoaddong = requestCheckVar(Request("sRoaddong"),512)
	sRoadjibun = requestCheckVar(Request("sRoadjibun"),128)
	sRoadBname = requestCheckVar(Request("sRoadBname"),256)

	zipcodeTableVal = "new_zipcode_160823"
	zipcodeGugunVal = "new_zipCode_Gungu160823"

	'// 바로 접속시엔 오류 표시
	If InStr(refer, "10x10.co.kr") < 1 Then
		Response.Write "Err|잘못된 접속입니다."
		Response.End
	End If

	Select Case Trim(sGubun)

		Case "jibun" '// 통합검색
			sJibundong = RepWord(sJibundong,"[^가-힣a-zA-Z0-9.&%\-\_\s]","")


			'// 상품검색
			dim oDoc,iLp
			set oDoc = new SearchItemCls
			oDoc.FRectSearchTxt = sJibundong        '' search field allwords
			oDoc.FCurrPage = CurrPage
			oDoc.FPageSize = PageSize
			oDoc.getSearchList


			if oDoc.FTotalCount>0 Then
				Dim ii
				IF oDoc.FResultCount >0 then
				    For ii=0 To oDoc.FResultCount -1 
						If IsNull(tmpOfficial_bld)="" Then
							tmpOfficial_bld = ""
						Else
							tmpOfficial_bld = " "&oDoc.FItemList(ii).Fofficial_bld
						End If

						If Trim(oDoc.FItemList(ii).Fjibun_sub)>0 Then
							tmpJibun = oDoc.FItemList(ii).Fjibun_main&"-"&oDoc.FItemList(ii).Fjibun_sub
						Else
							tmpJibun = oDoc.FItemList(ii).Fjibun_main
						End If

						tmpconfirmVal = tmpconfirmVal&"<li><span class='postcode'><span><i>"&Trim(oDoc.FItemList(ii).Fzipcode)&"</i></span></span>"
						tmpconfirmVal = tmpconfirmVal&"<a href="""" onclick=""setAddr('"&Trim(oDoc.FItemList(ii).Fzipcode)&"','"&Trim(oDoc.FItemList(ii).Fsido)&"','"&Trim(oDoc.FItemList(ii).Fgungu)&"','"&Trim(oDoc.FItemList(ii).Fdong)&"','"&Trim(oDoc.FItemList(ii).Feupmyun)&"','"&Replace(Trim(oDoc.FItemList(ii).Fri), "'", "")&"','"&Replace(Trim(tmpOfficial_bld), "'","")&"','"&Replace(Trim(tmpJibun), "'", "")&"', '"&Trim(oDoc.FItemList(ii).Froad)&"', '"&Trim(oDoc.FItemList(ii).Fbuilding_no)&"', 'road', 'jibunDetailtxt','jibunDetailAddr2');return false;"";>"
						tmpconfirmVal = tmpconfirmVal&"<em>[도로]</em><div>"&oDoc.FItemList(ii).Fsido&" "&oDoc.FItemList(ii).Fgungu
						tmpconfirmVal = tmpconfirmVal&" "&oDoc.FItemList(ii).Froad
						If Trim(oDoc.FItemList(ii).Fbuilding_no)<>"" Then
							tmpconfirmVal = tmpconfirmVal&" "&Trim(oDoc.FItemList(ii).Fbuilding_no)
						End If
						If Trim(oDoc.FItemList(ii).Fofficial_bld) <> "" Then
							tmpconfirmVal = tmpconfirmVal&" "&Trim(oDoc.FItemList(ii).Fofficial_bld)
						End If
						If Trim(oDoc.FItemList(ii).Feupmyun) <> "" Then
							tmpconfirmVal = tmpconfirmVal&"("&oDoc.FItemList(ii).Feupmyun&")"
						End If
						tmpconfirmVal = tmpConfirmVal&"</div></a>"

						tmpconfirmVal = tmpconfirmVal&"<a href="""" onclick=""setAddr('"&Trim(oDoc.FItemList(ii).Fzipcode)&"','"&Trim(oDoc.FItemList(ii).Fsido)&"','"&Trim(oDoc.FItemList(ii).Fgungu)&"','"&Trim(oDoc.FItemList(ii).Fdong)&"','"&Trim(oDoc.FItemList(ii).Feupmyun)&"','"&Replace(Trim(oDoc.FItemList(ii).Fri), "'", "")&"','"&Replace(Trim(tmpOfficial_bld), "'","")&"','"&Replace(Trim(tmpJibun), "'", "")&"', '', '', 'jibun', 'jibunDetailtxt','jibunDetailAddr2');return false;"";><em>[지번]</em><div>"&oDoc.FItemList(ii).Fsido&" "&oDoc.FItemList(ii).Fgungu
						If Trim(oDoc.FItemList(ii).Fdong) = "" Then
							tmpconfirmVal = tmpconfirmVal&" "&oDoc.FItemList(ii).Feupmyun
						Else
							tmpconfirmVal = tmpconfirmVal&" "&oDoc.FItemList(ii).Fdong
						End If

						If Trim(oDoc.FItemList(ii).Fri) <> "" Then
							tmpconfirmVal = tmpconfirmVal&" "&oDoc.FItemList(ii).Fri
						End If
						tmpconfirmVal = tmpconfirmVal&" "&Trim(tmpOfficial_bld)&" "&tmpJibun
						tmpconfirmVal = tmpConfirmVal&"</div></a>"
						tmpconfirmVal = tmpconfirmVal&"</li>"
				    Next
					tmppagingVal = fnDisplayPaging_New_nottextboxdirect(CurrPage,oDoc.FTotalCount,PageSize,5,"jsPageGo")
			    end If
				Response.write "OK|"&tmpconfirmVal&"|"&oDoc.FTotalCount&"|"&tmppagingVal
				Response.End
			Else
				Response.write "OK|<p>검색된 주소가 없습니다</p>"
				Response.End
			End If
			oDoc.close
		Case "gungureturn" '// 시군구 리스트 보냄
			strsql = " Select gungu From db_zipcode.dbo.["&zipcodeGugunVal&"] Where sido='"&sSidoGubun&"' order by gungu "
			rsEVTget.Open strsql, dbEVTget, adOpenForwardOnly, adLockReadOnly
			If Not(rsEVTget.bof Or rsEVTget.eof) Then
				Do Until rsEVTget.eof
					tmpReturngungu = tmpReturngungu&"<option value='"&rsEVTget("gungu")&"'>"&rsEVTget("gungu")&"</option>"
				rsEVTget.movenext
				Loop

				Response.write "OK|"&tmpReturngungu
				Response.End
			Else
				Response.write "Err|검색된 값이 없습니다."
				Response.End
			End If

			rsEVTget.close
		
	End Select

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
<!-- #include virtual="/lib/db/dbEVTclose.asp" -->
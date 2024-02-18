<%
	Dim uAgent, flgDevice
	'///// 접속기종 및 브라우져 종류 가져오기 /////
	uAgent = Lcase(Request.ServerVariables("HTTP_USER_AGENT"))
	if instr(uAgent,"windows ce")>0 or instr(uAgent,"lgtelecom")>0 or instr(uAgent,"midp")>0 or instr(uAgent,"wipi")>0 or instr(uAgent,"android")>0 or instr(uAgent,"ipod")>0 or instr(uAgent,"iphone")>0 or instr(uAgent,"ipad")>0 or instr(uAgent,"playstation") or instr(uAgent,"blackberry") then
		'휴대기기
		if instr(uAgent,"ppc")>0 or instr(uAgent,"iemobile")>0 then
			flgDevice = "P"	'PDA
		elseif instr(uAgent,"ipod")>0 or instr(uAgent,"iphone")>0 then
			flgDevice = "I" 'iPhone,iPod
		elseif instr(uAgent,"ipad")>0 then
			flgDevice = "D" 'iPad
		elseif instr(uAgent,"android")>0 then
			if instr(uAgent,"mobile")>0 then
				flgDevice = "A" 'Android
			else
				flgDevice = "T" 'Android Tab
			end if
		else
			flgDevice = "M"	'Mobile
		end if
	else
		'일반
		flgDevice = "W"
	end if

	'///// Arachni 웹스캐너 접근시 차단 /////
	if instr(uAgent,"Arachni")>0 then
		Response.End
	end if
	
	Dim vMailRefURL : vMailRefURL = request.ServerVariables("HTTP_REFERER")
	if InStr(LCase(vMailRefURL),"tmailer.10x10.co.kr") > 0 or InStr(LCase(vMailRefURL),"tms.10x10.co.kr") > 0 then
	    if flgDevice = "P" OR flgDevice = "I" OR flgDevice = "A" OR flgDevice = "M" then
	    	If fnChangePCtoMURL(CurrURLQ()) <> "" Then
	    		response.redirect "http://m.10x10.co.kr" & fnChangePCtoMURL(CurrURLQ())
	    	End If
	    end if
	end if
	
	Function fnChangePCtoMURL(u)
		Dim vvuTmp
		If InStr(LCase(u),"/street/street_brand_sub06.asp") > 0 Then
			vvuTmp = Replace(u,"street_brand_sub06.asp","street_brand.asp")
		ElseIf InStr(LCase(u),"/shopping/category_prd.asp") > 0 Then
			vvuTmp = Replace(u,"/shopping/category_prd.asp","/category/category_itemPrd.asp")
		ElseIf InStr(LCase(u),"/shopping/category_main.asp") > 0 Then
			vvuTmp = Replace(u,"/shopping/category_main.asp","/category/category_main.asp")
		ElseIf InStr(LCase(u),"/shopping/category_list.asp") > 0 Then
			vvuTmp = Replace(u,"/shopping/category_list.asp","/category/category_list.asp")
		ElseIf InStr(LCase(u),"/play/playtepisodephotopick.asp") > 0 Then
			vvuTmp = Replace(u,"playtepisodephotopick.asp","playTEpisode.asp")
		ElseIf InStr(LCase(u),"/play/playstyleplusview.asp") > 0 Then
			vvuTmp = Replace(u,"playstyleplusview.asp","playStylePlus.asp")
		ElseIf InStr(LCase(u),"/gift/talk/") > 0 Then
			vvuTmp = Replace(u,"/gift/talk/","/gift/gifttalk/")
		ElseIf InStr(LCase(u),"/gift/hint/") > 0 Then
			vvuTmp = Replace(u,"/gift/hint/","/gift/gifthint/")
		ElseIf InStr(LCase(u),"/award/awardlist.asp") > 0 Then
			vvuTmp = Replace(u,"/award/awardlist.asp","/award/awarditem.asp")
		ElseIf InStr(LCase(u),"/award/awardbrandlist.asp") > 0 Then
			vvuTmp = Replace(u,"/award/awardbrandlist.asp","/award/awardBrand.asp")
		ElseIf InStr(LCase(u),"/my10x10/popularwish.asp") > 0 Then
			vvuTmp = Replace(u,"/my10x10/popularwish.asp","/wish/")
		ElseIf InStr(LCase(u),"/event/eventmain.asp") > 0 Then
			vvuTmp = u
		ElseIf InStr(LCase(u),"/play/playground.asp") > 0 Then
			vvuTmp = u
		ElseIf InStr(LCase(u),"/just1day/") > 0 Then
			vvuTmp = u
		ElseIf InStr(LCase(u),"/clearancesale/") > 0 Then	''2016-02-02 유태욱 추가
			vvuTmp = u
		ElseIf InStr(LCase(u),"/hsproject/") > 0 Then		''2016-03-16 김진영 추가
			vvuTmp = Replace(u,"/HSProject/index.asp","/event/eventmain.asp")
		Else
			vvuTmp = ""
		End IF
		fnChangePCtoMURL = vvuTmp
	End Function
%>
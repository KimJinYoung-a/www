<!-- #include virtual="/lib/util/commlib.asp" -->
<%

if ((Not IsUserLoginOK) and (session("isguestorderflag") = "")) then
  '// 2009.04.15  정윤정 수정. post data 값 추가
	dim checklogin_backpath
  	dim strBackPath, strGetData, strPostData	
   		strBackPath 	= request.ServerVariables("URL")
   		strGetData  	= request.ServerVariables("QUERY_STRING")
   		strPostData 	= fnMakePostData 'post data를 get string 형태로 변경
    
    	if (request.Form("itemid")<>"") then session("r_itemid") = request.Form("itemid")
	if (request.Form("itemoption")<>"") then session("r_itemoption") = request.Form("itemoption")
	if (request.Form("itemea")<>"") then session("r_itemea") = request.Form("itemea")
	if (request.Form("requiredetail")<>"") then session(CStr(request.Form("itemid")) + "_" + CStr(request.Form("itemoption")) + "_req") = request.Form("requiredetail")
	
	checklogin_backpath = "backpath="+ server.URLEncode(strBackPath) + "&strGD=" +  server.URLEncode(strGetData) + "&strPD="+  server.URLEncode(strPostData)  +"&isopenerreload=on" 
	response.redirect "/login/poploginpage.asp?vType=B&" + checklogin_backpath
   dbget.Close: response.end
end if

%> 
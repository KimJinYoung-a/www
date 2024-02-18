<%  
Class CMyFavoriteEvent 
	public FTotalCount
	public FCurrPage
	public FTotalPage
	public FPageSize
	public FSPageNo
	public FEPageNo
	public FselOp

	public FUserId

	'//관심Play 리스트  
	public Function fnGetMyFavoritePlayList
  		Dim strSql
		strSql ="[db_my10x10].[dbo].[sp_Ten_myfavorite_play_getListCnt]('"&Fuserid&"')"
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF Not (rsget.EOF OR rsget.BOF) THEN
			FTotalCount = rsget(0)
		END IF
		rsget.close
		 
		IF FTotalCount > 0 THEN
		FSPageNo = (FPageSize*(FCurrPage-1)) + 1
		FEPageNo = FPageSize*FCurrPage		
		
		strSql ="[db_my10x10].[dbo].[sp_Ten_myfavorite_play_getList]('"&Fuserid&"',"&FSPageNo&","&FEPageNo&",'"&FselOp&"')"	 
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF Not (rsget.EOF OR rsget.BOF) THEN
			fnGetMyFavoritePlayList = rsget.getRows()
		END IF
		rsget.close
		END IF
	End Function  
End Class

Class CProcMyFavoritePlay
public FUserID
public FFavCode
	
	'//관심이벤트 삭제
	public Function fnDelMyFavoriteEvent 
	 Dim objCmd,returnValue, arrevtcode, i
	 Dim iRValue
	 iRValue = 1
	 
	 arrevtcode = split(FFavCode,",")
	 
	 For i = 0 To UBound(arrevtcode)
  	Set objCmd = Server.CreateObject("ADODB.COMMAND")  					
		With objCmd
			.ActiveConnection = dbget
			.CommandType = adCmdText  		
			.CommandText = "{?= call db_my10x10.[dbo].[sp_Ten_myfavorite_play_Delete]('"&FUserID&"',"&Trim(arrevtcode(i))&")}"							 
			.Parameters.Append .CreateParameter("RETURN_VALUE", adInteger, adParamReturnValue)
			.Execute, , adExecuteNoRecords
			End With	
		    returnValue = objCmd(0).Value	
		Set objCmd = nothing 
		IF returnValue = 0 THEN
			iRValue = 0
		END IF
		Next 
		fnDelMyFavoriteEvent = iRValue 
	End Function
 
End Class 
%>
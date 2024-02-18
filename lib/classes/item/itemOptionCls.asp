<%
''-------------------------------------------------------------------
'' 상품 옵션 종류 ProtoType
Class CItemOptionMultipleItem
    public Fitemid
    public FTypeSeq
    public FKindSeq
    public FoptionTypeName
    public FoptionKindName
    public Foptaddprice
    public Foptaddbuyprice
    
    public FoptionKindCount
    public FAvailOptCNT
    
    Private Sub Class_Initialize()

	End Sub

	Private Sub Class_Terminate()

	End Sub
End Class


'' 상품 옵션 ProtoType
Class CItemOptionItem
    public Fitemid
    public Fitemoption
    public Fisusing
    public Foptsellyn
    public Foptlimityn
    public Foptlimitno
    public Foptlimitsold
    public FoptionTypeName
    public Foptionname
    public Foptaddprice
    public Foptaddbuyprice
	public Fitemdiv
    
    public function IsOptionSoldOut()
        IsOptionSoldOut = (Fisusing="N") or (Foptsellyn="N") or ((IsLimitSell) and (GetOptLimitEa<1))
    end function
    
    public function IsLimitSell()
        IsLimitSell = (Foptlimityn="Y")
    end function

	public function GetOptLimitEa()
		if FOptLimitNo-FOptLimitSold<0 then
			GetOptLimitEa = 0
		else
			GetOptLimitEa = FOptLimitNo-FOptLimitSold
		end if
	end function
	
    Private Sub Class_Initialize()

	End Sub

	Private Sub Class_Terminate()

	End Sub
End Class


''상품 옵션
Class CItemOption
    public FOneItem
	public FItemList()
	
	public FTotalCount
	public FCurrPage
	public FTotalPage
	public FPageSize
	public FResultCount
	public FScrollCount
	
	public FRectItemID
	public FRectIsUsing
	
	public function GetOptionMultipleTypeList()
        dim sqlStr, i
        
        sqlStr = "exec [db_item].[dbo].sp_Ten_ItemOptionMultipleTypeList " & FRectItemID
        
        rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
        rsget.Open sqlStr, dbget
        
        FTotalCount  = rsget.RecordCount
        FResultCount = FTotalCount
        
        redim preserve FItemList(FResultCount)
        if  not rsget.EOF  then
            do until rsget.eof
    			set FItemList(i) = new CItemOptionMultipleItem
    			FItemList(i).Fitemid           = rsget("itemid")
                FItemList(i).FTypeSeq          = rsget("TypeSeq")
                FItemList(i).FoptionTypeName   = db2Html(rsget("optionTypeName"))
                FItemList(i).FoptionKindCount  = rsget("cnt")
                
    			i=i+1
    			rsget.moveNext
    		loop
    	end if
        rsget.Close
    end function
    
    function IsValidOptionTypeExists(iTypeSeq, iKindseq)
        dim i, opt
        IsValidOptionTypeExists = False
        for i=LBound(FItemList) to UBound(FItemList)-1
            if (Not FItemList(i) is Nothing) then
                opt = FItemList(i).FItemoption
                IF (LEFT(opt,1) = "Z") and (Mid(opt,iTypeSeq+1,1)=CStr(iKindseq)) then
                    IsValidOptionTypeExists = true
                    Exit function
                End if 
            end if
        next
    end function

    public function GetOptionMultipleList()
        dim sqlStr, i
        
        sqlStr = "exec [db_item].[dbo].sp_Ten_ItemOptionMultipleList " & FRectItemID
        
        rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
        rsget.Open sqlStr, dbget
        
        FTotalCount  = rsget.RecordCount
        FResultCount = FTotalCount
        
        redim preserve FItemList(FResultCount)
        if  not rsget.EOF  then
            do until rsget.eof
    			set FItemList(i) = new CItemOptionMultipleItem
    			FItemList(i).Fitemid           = rsget("itemid")
                FItemList(i).FTypeSeq          = rsget("TypeSeq")
                FItemList(i).FKindSeq          = rsget("KindSeq")
                FItemList(i).FoptionTypeName   = db2Html(rsget("optionTypeName"))
                FItemList(i).FoptionKindName   = db2Html(rsget("optionKindName"))
                FItemList(i).Foptaddprice      = rsget("optaddprice")
                FItemList(i).Foptaddbuyprice   = rsget("optaddbuyprice")
                
                FItemList(i).FAvailOptCNT      = rsget("AvailOptCNT")
                
    			i=i+1
    			rsget.moveNext
    		loop
    	end if
        rsget.Close
    end function

    public function GetOptionList()
        dim sqlStr, i
        dim dumiKey, PreKey
        
        sqlStr = "exec [db_item].[dbo].sp_Ten_ItemOptionList " & FRectItemID & ",'" & FRectIsUsing & "'"
        
        rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
        rsget.Open sqlStr, dbget

        FTotalCount  = rsget.RecordCount
        FResultCount = FTotalCount
        
        redim preserve FItemList(FResultCount)
        if  not rsget.EOF  then
            do until rsget.eof
    			set FItemList(i) = new CItemOptionItem
    			FItemList(i).Fitemid         = rsget("itemid")
                FItemList(i).Fitemoption     = rsget("itemoption")
                FItemList(i).Fisusing        = rsget("isusing")
                FItemList(i).Foptsellyn      = rsget("optsellyn")
                FItemList(i).Foptlimityn     = rsget("optlimityn")
                FItemList(i).Foptlimitno     = rsget("optlimitno")
                FItemList(i).Foptlimitsold   = rsget("optlimitsold")
                FItemList(i).FoptionTypeName = db2Html(rsget("optionTypeName"))
                FItemList(i).Foptionname     = db2Html(rsget("optionname"))
                FItemList(i).Foptaddprice    = rsget("optaddprice")
                FItemList(i).Foptaddbuyprice = rsget("optaddbuyprice")
                
    			i=i+1
    			rsget.moveNext
    		loop
    	end if
        rsget.Close
    end function

    public function GetOptionList2()
        dim sqlStr, i
        dim dumiKey, PreKey
        
        sqlStr = "exec [db_item].[dbo].sp_Ten_ItemOptionList_deal " & FRectItemID & ",'" & FRectIsUsing & "'"
        
        rsget.CursorLocation = adUseClient
		rsget.CursorType = adOpenStatic
		rsget.LockType = adLockOptimistic
        rsget.Open sqlStr, dbget

        FTotalCount  = rsget.RecordCount
        FResultCount = FTotalCount
        
        redim preserve FItemList(FResultCount)
        if  not rsget.EOF  then
            do until rsget.eof
    			set FItemList(i) = new CItemOptionItem
    			FItemList(i).Fitemid         = rsget("itemid")
				FItemList(i).Fitemdiv         = rsget("itemdiv")
                FItemList(i).Fitemoption     = rsget("itemoption")
                FItemList(i).Fisusing        = rsget("isusing")
                FItemList(i).Foptsellyn      = rsget("optsellyn")
                FItemList(i).Foptlimityn     = rsget("optlimityn")
                FItemList(i).Foptlimitno     = rsget("optlimitno")
                FItemList(i).Foptlimitsold   = rsget("optlimitsold")
                FItemList(i).FoptionTypeName = db2Html(rsget("optionTypeName"))
                FItemList(i).Foptionname     = db2Html(rsget("optionname"))
                FItemList(i).Foptaddprice    = rsget("optaddprice")
                FItemList(i).Foptaddbuyprice = rsget("optaddbuyprice")
                
    			i=i+1
    			rsget.moveNext
    		loop
    	end if
        rsget.Close
    end function

    Private Sub Class_Initialize()
        redim  FItemList(0)
		FCurrPage       = 1
		FPageSize       = 100
		FResultCount    = 0
		FScrollCount    = 10
		FTotalCount     = 0
		
	End Sub

	Private Sub Class_Terminate()

	End Sub
End Class

'' 상품 페이지 에서 사용
function GetOptionBoxHTML(byVal iItemID, byVal isItemSoldOut)
    GetOptionBoxHTML = ""
    
    dim oItemOption, oItemOptionMultiple, oItemOptionMultipleType
    dim IsMultipleOption
    dim i, j, MultipleOptionCount
    dim optionHtml, optionTypeStr, optionKindStr, optionSoldOutFlag, optionBoxStyle, ScriptHtml, optionBoxValue
    
    set oItemOption = new CItemOption
    oItemOption.FRectItemID = iItemID
    oItemOption.FRectIsUsing = "Y"
    oItemOption.GetOptionList
    
    if (oItemOption.FResultCount<1) then Exit Function
    
    set oItemOptionMultiple = new CItemOption
    oItemOptionMultiple.FRectItemID = iItemID
    oItemOptionMultiple.GetOptionMultipleList
    
    ''이중 옵션인지..
    IsMultipleOption = (oItemOptionMultiple.FResultCount>0)
    
    optionHtml = ""
    
    IF (Not IsMultipleOption) then
    ''단일 옵션.
        optionTypeStr = oItemOption.FItemList(0).FoptionTypeName
        if (Trim(optionTypeStr)="") then 
            optionTypeStr = "옵션 선택" 
        else
            optionTypeStr = optionTypeStr + " 선택"
        end if
        
        optionHtml = optionHtml + "<select name='item_option' class='optSelect2 select' style='max-width:230px;'>"
	    optionHtml = optionHtml + "<option value='' selected>" + optionTypeStr + "</option>"
	    
	    for i=0 to oItemOption.FResultCount-1
    	    optionKindStr       = oItemOption.FItemList(i).FOptionName
    	    optionSoldOutFlag   = ""
    	    optionBoxStyle      = ""
    	    optionBoxValue		= ""
    
    		if (oItemOption.FItemList(i).IsOptionSoldOut) then optionSoldOutFlag="S"
    
    		''품절일경우 한정표시 안함
        	if ((isItemSoldOut) or (oItemOption.FItemList(i).IsOptionSoldOut)) then
        		optionKindStr = optionKindStr + " (품절)"
        		optionBoxStyle = "style='color:#DD8888'"
        		optionBoxValue = " soldout='Y'"
        	else
        	    optionBoxValue = " soldout='N'"
        	    if (oitemoption.FItemList(i).Foptaddprice>0) then
        	    '' 추가 가격
        	        optionKindStr = optionKindStr + " (" + FormatNumber(oitemoption.FItemList(i).Foptaddprice,0)  + "원 추가)"
        	        optionBoxValue = optionBoxValue & " addPrice='" & oitemoption.FItemList(i).Foptaddprice & "'"
        	    end if
        	
        	    if (oitemoption.FItemList(i).IsLimitSell) then
        		''옵션별로 한정수량 표시
        			optionKindStr = optionKindStr + " (한정 " + CStr(oItemOption.FItemList(i).GetOptLimitEa) + " 개)"
        			optionBoxValue = optionBoxValue & " limitEa='" & oItemOption.FItemList(i).GetOptLimitEa & "'"
            	end if
            end if
    
            optionHtml = optionHtml + "<option id='" + optionSoldOutFlag + "' " + optionBoxStyle + optionBoxValue + " value='" + oItemOption.FItemList(i).FitemOption + "'>" + optionKindStr + "</option>"
    	next    
	    
	    optionHtml = optionHtml + "</select>"
    ELSE
    ''이중 옵션.
        set oItemOptionMultipleType = new CItemOption
        oItemOptionMultipleType.FRectItemId = iItemID
        oItemOptionMultipleType.GetOptionMultipleTypeList
        
        MultipleOptionCount = oItemOptionMultipleType.FResultCount
        
        ScriptHtml = VbCrlf + "<script language='javascript'>" + VbCrlf
        ScriptHtml = ScriptHtml + " var Mopt_Code = new Array(" + CStr(oItemOption.FResultCount) +");" + VbCrlf
        ScriptHtml = ScriptHtml + " var Mopt_Name = new Array(" + CStr(oItemOption.FResultCount) +");" + VbCrlf
        ScriptHtml = ScriptHtml + " var Mopt_addprice = new Array(" + CStr(oItemOption.FResultCount) +");" + VbCrlf
        ScriptHtml = ScriptHtml + " var Mopt_S = new Array(" + CStr(oItemOption.FResultCount) +");" + VbCrlf
        ScriptHtml = ScriptHtml + " var Mopt_LimitEa = new Array(" + CStr(oItemOption.FResultCount) +");" + VbCrlf
        for i=0 to oItemOption.FResultCount-1
            optionSoldOutFlag   = "false"
            optionBoxStyle      = ""
            
            if (oItemOption.FItemList(i).IsOptionSoldOut) then optionSoldOutFlag="true"
            
'            ScriptHtml = ScriptHtml + " Mopt_Code[" + CStr(i) + "] = '" + oItemOption.FItemList(i).FItemOption + "';"
'            ScriptHtml = ScriptHtml + " Mopt_Name[" + CStr(i) + "] = """ + doubleQuote(oItemOption.FItemList(i).FOptionName) + """;"
'            ScriptHtml = ScriptHtml + " Mopt_addprice[" + CStr(i) + "] = '" + CStr(oItemOption.FItemList(i).Foptaddprice) + "';"
'            ScriptHtml = ScriptHtml + " Mopt_S[" + CStr(i) + "] = " + optionSoldOutFlag + ";"
'            ScriptHtml = ScriptHtml + " Mopt_LimitEa[" + CStr(i) + "] = '" + CHKIIF(oItemOption.FItemList(i).IsLimitSell,CStr(oItemOption.FItemList(i).GetOptLimitEa),"") + "';" + VbCrlf

            ScriptHtml = ScriptHtml & ( " Mopt_Code[" & CStr(i) & "] = """ & oItemOption.FItemList(i).FItemOption & """;" _
                                    & " Mopt_Name[" & CStr(i) & "] = """ & doubleQuote(oItemOption.FItemList(i).FOptionName) & """;" _
                                    & " Mopt_addprice[" & CStr(i) & "] = """ & CStr(oItemOption.FItemList(i).Foptaddprice) & """;" _
                                    & " Mopt_S[" & CStr(i) & "] = " & optionSoldOutFlag & ";" _
                                    & " Mopt_LimitEa[" & CStr(i) & "] = """ & CHKIIF(oItemOption.FItemList(i).IsLimitSell,CStr(oItemOption.FItemList(i).GetOptLimitEa),"") & """;" & VbCrlf )
        next
        ScriptHtml = ScriptHtml + "</script>" + VbCrlf
        
        for j=0 to MultipleOptionCount - 1
            optionTypeStr = oItemOptionMultipleType.FItemList(j).FoptionTypeName
            if (Trim(optionTypeStr)="") then 
                optionTypeStr="옵션 선택" 
            else
                optionTypeStr = optionTypeStr + " 선택"
            end if
        
        
        	'// 행구분(2012년 DIV레이아웃에 맞춤)
            if (optionHtml<>"") then optionHtml=optionHtml + "</p><p class='tPad05 itemoption'>"
            
            optionHtml = optionHtml + "<select name='item_option' id='" + cstr(j) + "'  class='optSelect2 select' style='max-width:230px;' onChange='CheckMultiOption(this)'>"
    	    optionHtml = optionHtml + "<option value='' selected>" + optionTypeStr + "</option>"
    	    for i=0 to oItemOptionMultiple.FResultCount-1
    	        if (oItemOptionMultiple.FItemList(i).FAvailOptCNT>0) and (oItemOptionMultiple.FItemList(i).FTypeSeq=oItemOptionMultipleType.FItemList(j).FTypeSeq) then
    	            
    	            ''옵션 타입 전체가 품절인 경우 체크. => 디비에서 체크(FAvailOptCNT)
    	            ''if (oItemOption.IsValidOptionTypeExists(oItemOptionMultiple.FItemList(i).FTypeSeq, oItemOptionMultiple.FItemList(i).FKindSeq)) then 
    	            
        	            optionKindStr     = oItemOptionMultiple.FItemList(i).FOptionKindName
                	    
                	    if (oItemOptionMultiple.FItemList(i).Foptaddprice>0) then
                	    '' 추가 가격
                	        optionKindStr = optionKindStr + " (" + FormatNumber(oItemOptionMultiple.FItemList(i).Foptaddprice,0)  + "원 추가)"
                	    end if
                	    
        	            optionHtml = optionHtml + "<option id='' " + optionBoxStyle + " value='" + CStr(oItemOptionMultiple.FItemList(i).FTypeSeq) + CStr(oItemOptionMultiple.FItemList(i).FKindSeq) + optionKindStr + "'>" + optionKindStr + "</option>"
    	            ''end if
    	        end if
    	    Next 
    	    optionHtml = optionHtml + "</select>"

    	Next
    	
    	set oItemOptionMultipleType = Nothing
    END IF
    
    GetOptionBoxHTML = ScriptHtml + optionHtml
    
    set oItemOption = Nothing
    set oItemOptionMultiple = Nothing
    
end function

''옵션별 한정 수량 표시 안할경우 사용 -- SM Case ;
function GetOptionBoxDpLimitHTML(byVal iItemID, byVal isItemSoldOut, byVal isLimitView)
    GetOptionBoxDpLimitHTML = ""
    
    dim oItemOption, oItemOptionMultiple, oItemOptionMultipleType
    dim IsMultipleOption
    dim i, j, MultipleOptionCount
    dim optionHtml, optionTypeStr, optionKindStr, optionSoldOutFlag, optionBoxStyle, ScriptHtml, optionBoxValue
    
    set oItemOption = new CItemOption
    oItemOption.FRectItemID = iItemID
    oItemOption.FRectIsUsing = "Y"
    oItemOption.GetOptionList
    
    if (oItemOption.FResultCount<1) then Exit Function
    
    set oItemOptionMultiple = new CItemOption
    oItemOptionMultiple.FRectItemID = iItemID
    oItemOptionMultiple.GetOptionMultipleList
    
    ''이중 옵션인지..
    IsMultipleOption = (oItemOptionMultiple.FResultCount>0)
    
    optionHtml = ""
    
    IF (Not IsMultipleOption) then
    ''단일 옵션.
        optionTypeStr = oItemOption.FItemList(0).FoptionTypeName
        if (Trim(optionTypeStr)="") then 
            optionTypeStr = "옵션 선택" 
        else
            optionTypeStr = optionTypeStr + " 선택"
        end if
        
        optionHtml = optionHtml + "<select name='item_option' class='optSelect2 select'>"
	    optionHtml = optionHtml + "<option value='' selected>" + optionTypeStr + "</option>"
	    
	    for i=0 to oItemOption.FResultCount-1
    	    optionKindStr       = oItemOption.FItemList(i).FOptionName
    	    optionSoldOutFlag   = ""
    	    optionBoxStyle      = ""
    	    optionBoxValue		= ""
    
    		if (oItemOption.FItemList(i).IsOptionSoldOut) then optionSoldOutFlag="S"
    
    		''품절일경우 한정표시 안함
        	if ((isItemSoldOut) or (oItemOption.FItemList(i).IsOptionSoldOut)) then
        		optionKindStr = optionKindStr + " (품절)"
        		optionBoxStyle = "style='color:#DD8888'"
        		optionBoxValue = " soldout='Y'"
        	else
        	    optionBoxValue = " soldout='N'"
        	    if (oitemoption.FItemList(i).Foptaddprice>0) then
        	    '' 추가 가격
        	        optionKindStr = optionKindStr + " (" + FormatNumber(oitemoption.FItemList(i).Foptaddprice,0)  + "원 추가)"
        	        optionBoxValue = optionBoxValue & " addPrice='" & oitemoption.FItemList(i).Foptaddprice & "'"
        	    end if
        	
        	    if (oitemoption.FItemList(i).IsLimitSell) then
        		''옵션별로 한정수량 표시
        		    if (isLimitView) then
            			optionKindStr = optionKindStr + " (한정 " + CStr(oItemOption.FItemList(i).GetOptLimitEa) + " 개)"
            		end if
        			optionBoxValue = optionBoxValue & " limitEa='" & oItemOption.FItemList(i).GetOptLimitEa & "'"
            	end if
            end if
    
            optionHtml = optionHtml + "<option id='" + optionSoldOutFlag + "' " + optionBoxStyle + optionBoxValue + " value='" + oItemOption.FItemList(i).FitemOption + "'>" + optionKindStr + "</option>"
    	next    
	    
	    optionHtml = optionHtml + "</select>"
    ELSE
    ''이중 옵션.
        set oItemOptionMultipleType = new CItemOption
        oItemOptionMultipleType.FRectItemId = iItemID
        oItemOptionMultipleType.GetOptionMultipleTypeList
        
        MultipleOptionCount = oItemOptionMultipleType.FResultCount
        
        ScriptHtml = VbCrlf + "<script language='javascript'>" + VbCrlf
        ScriptHtml = ScriptHtml + " var Mopt_Code = new Array(" + CStr(oItemOption.FResultCount) +");" + VbCrlf
        ScriptHtml = ScriptHtml + " var Mopt_Name = new Array(" + CStr(oItemOption.FResultCount) +");" + VbCrlf
        ScriptHtml = ScriptHtml + " var Mopt_addprice = new Array(" + CStr(oItemOption.FResultCount) +");" + VbCrlf
        ScriptHtml = ScriptHtml + " var Mopt_S = new Array(" + CStr(oItemOption.FResultCount) +");" + VbCrlf
        ScriptHtml = ScriptHtml + " var Mopt_LimitEa = new Array(" + CStr(oItemOption.FResultCount) +");" + VbCrlf
        for i=0 to oItemOption.FResultCount-1
            optionSoldOutFlag   = "false"
            optionBoxStyle      = ""
            
            if (oItemOption.FItemList(i).IsOptionSoldOut) then optionSoldOutFlag="true"
            
            ScriptHtml = ScriptHtml + " Mopt_Code[" + CStr(i) + "] = '" + oItemOption.FItemList(i).FItemOption + "';"
            ScriptHtml = ScriptHtml + " Mopt_Name[" + CStr(i) + "] = """ + doubleQuote(oItemOption.FItemList(i).FOptionName) + """;"
            ScriptHtml = ScriptHtml + " Mopt_addprice[" + CStr(i) + "] = '" + CStr(oItemOption.FItemList(i).Foptaddprice) + "';"
            ScriptHtml = ScriptHtml + " Mopt_S[" + CStr(i) + "] = " + optionSoldOutFlag + ";"
            ScriptHtml = ScriptHtml + " Mopt_LimitEa[" + CStr(i) + "] = '" + CHKIIF(oItemOption.FItemList(i).IsLimitSell,CStr(oItemOption.FItemList(i).GetOptLimitEa),"") + "';" + VbCrlf
        next
        ScriptHtml = ScriptHtml + "</script>" + VbCrlf
        
        for j=0 to MultipleOptionCount - 1
            optionTypeStr = oItemOptionMultipleType.FItemList(j).FoptionTypeName
            if (Trim(optionTypeStr)="") then 
                optionTypeStr="옵션 선택" 
            else
                optionTypeStr = optionTypeStr + " 선택"
            end if
        
        
        	'// 행구분(2012년 DIV레이아웃에 맞춤)
            if (optionHtml<>"") then optionHtml=optionHtml + "</p><p class='tPad05 itemoption'>"
            
            optionHtml = optionHtml + "<select name='item_option' id='" + cstr(j) + "'  class='optSelect2 select' style='max-width:230px;' onChange='CheckMultiOption(this)'>"
    	    optionHtml = optionHtml + "<option value='' selected>" + optionTypeStr + "</option>"
    	    for i=0 to oItemOptionMultiple.FResultCount-1
    	        if (oItemOptionMultiple.FItemList(i).FAvailOptCNT>0) and (oItemOptionMultiple.FItemList(i).FTypeSeq=oItemOptionMultipleType.FItemList(j).FTypeSeq) then
    	            
    	            ''옵션 타입 전체가 품절인 경우 체크. => 디비에서 체크(FAvailOptCNT)
    	            ''if (oItemOption.IsValidOptionTypeExists(oItemOptionMultiple.FItemList(i).FTypeSeq, oItemOptionMultiple.FItemList(i).FKindSeq)) then 
    	            
        	            optionKindStr     = oItemOptionMultiple.FItemList(i).FOptionKindName
                	    
                	    if (oItemOptionMultiple.FItemList(i).Foptaddprice>0) then
                	    '' 추가 가격
                	        optionKindStr = optionKindStr + " (" + FormatNumber(oItemOptionMultiple.FItemList(i).Foptaddprice,0)  + "원 추가)"
                	    end if
                	    
        	            optionHtml = optionHtml + "<option id='' " + optionBoxStyle + " value='" + CStr(oItemOptionMultiple.FItemList(i).FTypeSeq) + CStr(oItemOptionMultiple.FItemList(i).FKindSeq) + optionKindStr + "'>" + optionKindStr + "</option>"
    	            ''end if
    	        end if
    	    Next 
    	    optionHtml = optionHtml + "</select>"

    	Next
    	
    	set oItemOptionMultipleType = Nothing
    END IF
    
    GetOptionBoxDpLimitHTML = ScriptHtml + optionHtml
    
    set oItemOption = Nothing
    set oItemOptionMultiple = Nothing
    
end function



'' OldType Option Box를 한 콤보로 표시
function getOneTypeOptionBoxHtml(byVal iItemID, byVal isItemSoldOut, byval iOptionBoxStyle)
	dim i, optionHtml, optionTypeStr, optionKindStr, optionSoldOutFlag, optionSubStyle
    dim oItemOption
    
	set oItemOption = new CItemOption
    oItemOption.FRectItemID = iItemID
    oItemOption.FRectIsUsing = "Y"
    oItemOption.GetOptionList
    
    if (oItemOption.FResultCount<1) then Exit Function
    
    optionTypeStr = oItemOption.FItemList(0).FoptionTypeName
    if (Trim(optionTypeStr)="") then 
        optionTypeStr = "옵션 선택" 
    else
        optionTypeStr = optionTypeStr + " 선택"
    end if
        
	optionHtml = "<select name='item_option' " + iOptionBoxStyle + ">"
    optionHtml = optionHtml + "<option value='' selected>" & optionTypeStr & "</option>"
    
    
    for i=0 to oItemOption.FResultCount-1
	    optionKindStr       = oItemOption.FItemList(i).FOptionName
	    optionSoldOutFlag   = ""

		if (oItemOption.FItemList(i).IsOptionSoldOut) then optionSoldOutFlag="S"

		''품절일경우 한정표시 안함
    	if ((isItemSoldOut) or (oItemOption.FItemList(i).IsOptionSoldOut)) then
    		optionKindStr = optionKindStr + " (품절)"
    		optionSubStyle = "style='color:#DD8888' soldout='Y'"
    	else
    	    optionSubStyle = "soldout='N'"
    	    if (oitemoption.FItemList(i).Foptaddprice>0) then
    	    '' 추가 가격
    	        optionKindStr = optionKindStr + " (" + FormatNumber(oitemoption.FItemList(i).Foptaddprice,0)  + "원 추가)"
    	        optionSubStyle = optionSubStyle & " addPrice=" & oitemoption.FItemList(i).Foptaddprice
    	    end if
    	
    	    if (oitemoption.FItemList(i).IsLimitSell) then
    		''옵션별로 한정수량 표시
    			optionKindStr = optionKindStr + " (한정 " + CStr(oItemOption.FItemList(i).GetOptLimitEa) + " 개)"
    			optionSubStyle = optionSubStyle & " limitEa=" & CStr(oItemOption.FItemList(i).GetOptLimitEa)
        	end if
        end if

        optionHtml = optionHtml + "<option id='" + optionSoldOutFlag + "' " + optionSubStyle + " value='" + oItemOption.FItemList(i).FitemOption + "'>" + optionKindStr + "</option>"
	next
	
	optionHtml = optionHtml + "</select><br class='clearfix' />"
    	
	getOneTypeOptionBoxHtml = optionHtml
	set oItemOption = Nothing
end function

'' OldType Option Box를 한 콤보로 표시
''옵션별 한정 수량 표시 안할경우 사용 -- SM Case ;
function getOneTypeOptionBoxDpLimitHtml(byVal iItemID, byVal isItemSoldOut, byval iOptionBoxStyle, byVal isLimitView)
	dim i, optionHtml, optionTypeStr, optionKindStr, optionSoldOutFlag, optionSubStyle
    dim oItemOption
    
	set oItemOption = new CItemOption
    oItemOption.FRectItemID = iItemID
    oItemOption.FRectIsUsing = "Y"
    oItemOption.GetOptionList
    
    if (oItemOption.FResultCount<1) then Exit Function
    
    optionTypeStr = oItemOption.FItemList(0).FoptionTypeName
    if (Trim(optionTypeStr)="") then 
        optionTypeStr = "옵션 선택" 
    else
        optionTypeStr = optionTypeStr + " 선택"
    end if
        
	optionHtml = "<select name='item_option' " + iOptionBoxStyle + ">"
    optionHtml = optionHtml + "<option value='' selected>" & optionTypeStr & "</option>"
    
    
    for i=0 to oItemOption.FResultCount-1
	    optionKindStr       = oItemOption.FItemList(i).FOptionName
	    optionSoldOutFlag   = ""

		if (oItemOption.FItemList(i).IsOptionSoldOut) then optionSoldOutFlag="S"

		''품절일경우 한정표시 안함
    	if ((isItemSoldOut) or (oItemOption.FItemList(i).IsOptionSoldOut)) then
    		optionKindStr = optionKindStr + " (품절)"
    		optionSubStyle = "style='color:#DD8888' soldout='Y'"
    	else
    	    optionSubStyle = "soldout='N'"
    	    if (oitemoption.FItemList(i).Foptaddprice>0) then
    	    '' 추가 가격
    	        optionKindStr = optionKindStr + " (" + FormatNumber(oitemoption.FItemList(i).Foptaddprice,0)  + "원 추가)"
    	        optionSubStyle = optionSubStyle & " addPrice=" & oitemoption.FItemList(i).Foptaddprice
    	    end if
    	
    	    if (oitemoption.FItemList(i).IsLimitSell) then
    		''옵션별로 한정수량 표시
    		    if (isLimitView) then
        			optionKindStr = optionKindStr + " (한정 " + CStr(oItemOption.FItemList(i).GetOptLimitEa) + " 개)"
        		end if
    			optionSubStyle = optionSubStyle & " limitEa=" & CStr(oItemOption.FItemList(i).GetOptLimitEa)
        	end if
        end if

        optionHtml = optionHtml + "<option id='" + optionSoldOutFlag + "' " + optionSubStyle + " value='" + oItemOption.FItemList(i).FitemOption + "'>" + optionKindStr + "</option>"
	next
	
	optionHtml = optionHtml + "</select><br class='clearfix' />"
    	
	getOneTypeOptionBoxDpLimitHtml = optionHtml
	set oItemOption = Nothing
end function

%>

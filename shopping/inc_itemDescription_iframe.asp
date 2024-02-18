<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "utf-8" %>

<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->

<%
    Dim itemid, oItem, oAdd, i, itemVideos

    itemid = requestCheckVar(request("itemid"),9)

'======================================== 상품코드 정확성체크 및 상품관련내용 ====================================
    if itemid="" or itemid="0" then
    	Call Alert_Return("상품번호가 없습니다.")
    	response.End
    elseif Not(isNumeric(itemid)) then
    	Call Alert_Return("잘못된 상품번호입니다.")
    	response.End
    else	'정수형태로 변환
    	itemid=CLng(getNumeric(itemid))
    end if

    if itemid=0 then
    	Call Alert_Return("잘못된 상품번호입니다.")
    	response.End
    end if

    set oItem = new CatePrdCls
    oItem.GetItemData itemid

    '// 상품상세설명 동영상 추가
    Set itemVideos = New catePrdCls
    itemVideos.fnGetItemVideos itemid, "video1"
'================================================================================================================
'=============================== 추가 이미지 & 추가 이미지-메인 이미지 ==========================================
    set oADD = new CatePrdCls
    oADD.getAddImage itemid

    function ImageExists(byval iimg)
        if (IsNull(iimg)) or (trim(iimg)="") or (Right(trim(iimg),1)="\") or (Right(trim(iimg),1)="/") then
            ImageExists = false
        else
            ImageExists = true
        end if
    end function
%>
<style>
    body{margin:0 auto !important;}
    td img{display:block;margin:0 auto;max-width:1000px;}
</style>
<div class="tPad10">
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<%
        '# 상품 설명
        IF oItem.Prd.FUsingHTML="Y" THEN
            Response.write "<tr><td>" & oItem.Prd.FItemContent & "</td></tr>"
        ELSEIF oItem.Prd.FUsingHTML="H" THEN
            Response.write "<tr><td>" & nl2br(oItem.Prd.FItemContent) & "</td></tr>"
        ELSE
            Response.write "<tr><td>" & nl2br(ReplaceBracket(oItem.Prd.FItemContent)) & "</td></tr>"
        END IF

        '설명 이미지(추가)
        IF oAdd.FResultCount > 0 THEN
            FOR i= 0 to oAdd.FResultCount-1
                IF oAdd.FADD(i).FAddImageType=1 AND oAdd.FADD(i).FIsExistAddimg THEN
                    Response.Write "<tr><td align=""center"">"
                    Response.Write "<img src=""" & oAdd.FADD(i).FAddimage & """ border=""0"" />"
                    Response.Write "</td></tr>"
                End IF
            NEXT
        END IF

        '설명 이미지(기본)
        if ImageExists(oItem.Prd.FImageMain) then
            Response.Write "<tr><td align=""center"">"
            Response.Write "<img src=""" & oItem.Prd.FImageMain & """ border=""0"" id=""filemain"" />"
            Response.Write "</td></tr>"
        end if
        if ImageExists(oItem.Prd.FImageMain2) then
            Response.Write "<tr><td align=""center"">"
            Response.Write "<img src=""" & oItem.Prd.FImageMain2 & """ border=""0"" id=""filemain2"" />"
            Response.Write "</td></tr>"
        end if
        if ImageExists(oItem.Prd.FImageMain3) then
            Response.Write "<tr><td align=""center"">"
            Response.Write "<img src=""" & oItem.Prd.FImageMain3 & """ border=""0"" id=""filemain3"" />"
            Response.Write "</td></tr>"
        end If

        If Not(itemVideos.Prd.FvideoFullUrl="") Then
            Response.write "<tr><td height=30></td></tr>"
            Response.Write "<tr><td align=""center"">"
            Response.write "<iframe width='640' height='360' src='"&itemVideos.Prd.FvideoUrl&"' frameborder='0' allowfullscreen></iframe>"
            Response.Write "</td></tr>"
        End If
    %>
    </table>
</div>

<script type="text/javascript" src="/lib/js/jquery-1.7.1.min.js"></script>

<!-- #include virtual="/lib/db/dbclose.asp" -->
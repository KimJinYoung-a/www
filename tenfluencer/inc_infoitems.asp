<%
    dim arrItems , wishItemList , ip , wishItemStr , il
    dim itemID , basicImage , tentenImage400 , itemName , evalCount , wishCount , totalPoint , isWishItem
    dim folderName : folderName = "텐플루언서"

    arrItems = oMedia.getContentsItemsList(vContentsidx)
    wishItemList = oMedia.getMyMediaWishList(GetEncLoginUserID(), folderName)

    if isarray(wishItemList) then
		for il = 0 to ubound(wishItemList,2)
			wishItemStr = wishItemStr & wishItemList(0,il) & "|" 
		next
	end if

    if isarray(arrItems) then
%>
<div class="related-prd">
    <h4>영상에 등장한 상품</h4>
    <div class="prd-list">
        <ul>
            <%
                for ip = 0 to ubound(arrItems,2)

                itemID          = arrItems(0,ip)
                basicImage      = webImgUrl & "/image/basic/" + GetImageSubFolderByItemid(db2Html(itemID)) + "/" + db2Html(arrItems(1,ip))
                tentenImage400  = webImgUrl & "/image/tenten400/" + GetImageSubFolderByItemid(db2Html(itemID)) + "/" + db2Html(arrItems(2,ip))
                itemName        = db2Html(arrItems(3,ip))
                evalCount       = arrItems(4,ip)
                wishCount       = arrItems(5,ip)
                totalPoint      = arrItems(6,ip)
                isWishItem      = chkiif(InStr(wishItemStr, itemid) > 0,true,false)
            %>
            <li>
                <a href="/shopping/category_prd.asp?itemid=<%=itemID%>">
                    <div class="thumbnail"><img src="<%=chkiif(arrItems(2,ip) = "" or isnull(arrItems(2,ip)) , basicimage , tentenimage400)%>" alt="<%=itemName%>"></div>
                    <div class="desc">
                        <p class="name"><%=itemName%></p>
                        <span class="plf-rating"><i style="width:<%=totalPoint%>%;"><%=totalPoint%>점</i></span>
                    </div>
                </a>
                <button class="btn-wish <%=chkiif(isWishItem,"on","")%>" onclick="setWishItem('<%=itemid%>','<%=folderName%>',event);"><i>wish</i><span><%=wishCount%></span></button>
            </li>
            <%
                next
            %>
        </ul>
    </div>
</div>
<script>
function setWishItem(itemid , foldername , event) {
    // chechlogin
    jsChklogin('<%=IsUserLoginOK%>');
    <% if not(IsUserLoginOK) then %>
        return false;
    <% end if %>

    var el = $(event.currentTarget);
    var totalCount = el.find('span').text();
   
    el.toggleClass('on');
    el.find('span').text((el.hasClass('on')) ? parseInt(totalCount)+1 : parseInt(totalCount)-1);

    var data_likeCount = "/apps/webapi/media/setWishProc.asp";
    var _data = {itemId : itemid , mediaName : foldername};
    
    $.ajax({
        type: "POST",
        url: data_likeCount,
        async : false,
        data : _data,
        success : function(data, textStatus, jqXHR) {
                    if (data.response == 'ok'){
                        console.log("addWish");
                    } else if(data.response == 'fail') {
                        if(data.faildesc == 'login') {
                            jsChklogin(false);
                        } else {
                            alert('시스템 에러입니다.');
                        }
                    } else {
                        alert('시스템 에러입니다.');
                    }                    
				},
        error : function(jqXHR, textStatus, errorThrown) {
            alert("잘못된 접근 입니다.");					
        }
    });
}
</script>
<%
    end if 
%>
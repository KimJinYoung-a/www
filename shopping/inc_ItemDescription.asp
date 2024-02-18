<% If (Not IsTicketItem) Then '티켓아닌경우 - 일반상품 %>
<h3<%=chkIIF(vOrderBody="",""," class=""tMar50""")%>>상품 설명</h3>
	<%' 2017 다이어리 스토리 : 다이어리 프리뷰 %>
	<% If clsDiaryPrdCheck.FResultCount  > 0 Then %>
		<% If DiaryPreviewImgLoad.FTotalCount > 0 Then %>
			<div class="diaryPreview">
				<div class="diaryHead">
					<h3><img src="http://fiximage.10x10.co.kr/web2016/diarystory2017/tit_preview.png" alt="DIARY PREVIEW" /></h3>
				</div>
				<div class="slideWrap">
					<div class="slide">
						<% For i = 0 To DiaryPreviewImgLoad.FTotalCount - 1 %>
							<div><img src="http://imgstatic.10x10.co.kr/diary/preview/detail/<%= DiaryPreviewImgLoad.FItemList(i).FpreviewImg %>" alt=""  /></div>
						<% Next %>
					</div>
				</div>
			</div>

			<script type="text/javascript">
				$('.diaryPreview .slide').slidesjs({
					width:"670",
					height:"470",
					pagination:{effect:"fade"},
					navigation:{effect:"fade"},
					play:{interval:2800, effect:"fade", auto:true},
					effect:{fade: {speed:800, crossfade:true}
					},
					callback: {
						complete: function(number) {
							var pluginInstance = $('.diaryPreview .slide').data('plugin_slidesjs');
							setTimeout(function() {
								pluginInstance.play(true);
							}, pluginInstance.options.play.interval);
						}
					}
				});
			</script>
		<% End If %>
	<% End If %>

	<iframe id="itemPrdDetail" style="width:100%;" src="/shopping/inc_itemDescription_iframe.asp?itemid=<%=itemid%>" frameborder="0" scrolling="no"></iframe>
    <script>
        (function(){
            // 브라우저 상태에 따라 iframe 높이값 조정
            var frm = document.getElementById("itemPrdDetail");
            // 초기 로드시
            frm.onload = function() {
                resizeIframe(frm);
            }
            function resizeIframe(obj) {
                obj.style.height = 0;
                obj.style.height = obj.contentWindow.document.body.scrollHeight + 'px';
            }
        })(jQuery);
    </script>
<% else %>
<h3 class="tMar50">상세 설명</h3>
<div class="tPad10">
<%
	'# 공연 설명
	IF oItem.Prd.FUsingHTML="Y" THEN
		Response.write oItem.Prd.FItemContent
	ELSEIF oItem.Prd.FUsingHTML="H" THEN
		Response.write nl2br(oItem.Prd.FItemContent)
	ELSE
		Response.write nl2br(ReplaceBracket(oItem.Prd.FItemContent))
	END IF

	'설명 이미지(추가)
	IF oAdd.FResultCount > 0 THEN
		FOR i= 0 to oAdd.FResultCount-1
			IF oAdd.FADD(i).FAddImageType=1 THEN
				Response.Write "<img src=""" & oAdd.FADD(i).FAddimage & """ border=""0"" style=""max-width:1000px;"" />"
			End IF
		NEXT
	END IF

	'설명 이미지(기본)
	if ImageExists(oItem.Prd.FImageMain) then
		Response.Write "<img src=""" & oItem.Prd.FImageMain & """ border=""0"" id=""filemain"" style=""max-width:1000px;"" />"
	end if
	if ImageExists(oItem.Prd.FImageMain2) then
		Response.Write chkIIF(ImageExists(oItem.Prd.FImageMain),"<br />","")
		Response.Write "<img src=""" & oItem.Prd.FImageMain2 & """ border=""0"" id=""filemain2"" style=""max-width:1000px;"" />"
	end if

	If Not(itemVideos.Prd.FvideoFullUrl="") Then
		Response.write "<iframe width='640' height='360' src='"&itemVideos.Prd.FvideoUrl&"' frameborder='0' allowfullscreen></iframe>"
	End If
%>
</div>
<% end if %>
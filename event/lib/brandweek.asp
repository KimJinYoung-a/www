<%
Dim rtCode , rtAlt , rCnt , rtDate
Dim superRookieNum

Select Case CStr(Date())
	Case "2017-04-18"
		rtCode = array(77515,77298,77456,77490,77487)
		rtAlt  = array("감사한 마음 가득 담은 꽃 카네이션","PHILIPS LAUNCHING GIFT","베이직 하지만, 특별하고싶어","봄의 길 위에서","달콤한 피크닉 MELLOW MOMENT")
		rCnt   = "5"
		rtDate = Replace(Date(),"-","")
	Case "2017-04-19"
		rtCode = array(77457,77387,77448,77492,77313)
		rtAlt  = array("간결함과 순수함을 담다 LUMI","PINK VARIED BERRY","MOLESKINE PETER PEN","SOCKSAPPEAL X SML","놓칠 수 없는 달콤함 M&M's")
		rCnt   = "5"
		rtDate = Replace(Date(),"-","")
	Case "2017-04-20"
		rtCode = array(77482,77458,77449,77481,77522)
		rtAlt  = array("요정을 분양합니다","봄바람에 살랑, 내마음도 살랑","흩날리는 벚꽃잎이","아이의 가벼운 발걸음을 위해서","여행이 있는 주말")
		rCnt   = "5"
		rtDate = Replace(Date(),"-","")
	Case "2017-04-21"
		rtCode = array(77485,77322,77533,77513,77514)
		rtAlt  = array("무한도전 X DECOVIEW","살림 차이, 정리로 부터","덜어내니 아름답다. RAWROW","FOR THE BLOOM","이런 매력적인 뱃지들을 보았나~")
		rCnt   = "5"
		rtDate = Replace(Date(),"-","")
	Case "2017-04-22"
		rtCode = array(77485,77322,77533,77513,77514)
		rtAlt  = array("무한도전 X DECOVIEW","살림 차이, 정리로 부터","덜어내니 아름답다. RAWROW","FOR THE BLOOM","이런 매력적인 뱃지들을 보았나~")
		rCnt   = "5"
		rtDate = "20170421"
	Case "2017-04-23"
		rtCode = array(77485,77322,77533,77513,77514)
		rtAlt  = array("무한도전 X DECOVIEW","살림 차이, 정리로 부터","덜어내니 아름답다. RAWROW","FOR THE BLOOM","이런 매력적인 뱃지들을 보았나~")
		rCnt   = "5"
		rtDate = "20170421"
	Case "2017-04-24"
		rtCode = array(77507,77534,77573,77634,77388)
		rtAlt  = array("KAKAO FRIENDS KITCHEN","어른부터 아이까지! STICKY LEMON","꼬까참새가 널 위해 준비했어!","봄을 위한 선물 La vie est belle","BEAN BROTHERS LAUNCHING")
		rCnt   = "5"
		rtDate = Replace(Date(),"-","")
	Case "2017-04-25"
		rtCode = array(77599,77673,77647,77489,77543)
		rtAlt  = array("한손에 쏙! 마음에 쏙!","Stereo Vinyls X Hellow Kitty","파리와 사랑에 빠진 고양이가구","Fill the vistic","More Basic More Modern")
		rCnt   = "5"
		rtDate = Replace(Date(),"-","")
	Case "2017-04-26"
		rtCode = array(77542,77539,77583,77620,77654)
		rtAlt  = array("나는 널 원해 JIHONG","티격태격 톰과제리의 폭풍케미!","돌멩이를 닮은 캔들","THANK YOU LOVE YOU","시카고 타자기 X 허츠앤베이")
		rCnt   = "5"
		rtDate = Replace(Date(),"-","")
	Case "2017-04-27"
		rtCode = array(77674,77521,77507,77388,77543)
		rtAlt  = array("버켄스탁 여름을 부탁해 !","봄날의 솜사탕","KAKAO FRIENDS KITCHEN","BEAN BROTHERS LAUNCHING","more basic more modern")
		rCnt   = "5"
		rtDate = Replace(Date(),"-","")
	Case "2017-04-28"
		rtCode = array(77511,77684,77564,77588,77676)
		rtAlt  = array("오래도록 기억에 남을 마음","느린 만큼 더 소중한 slow moments","너의 주름까지 사랑스러워","12개의 성분으로도 충분합니다!","따뜻한 봄의 시작")
		rCnt   = "5"
		rtDate = Replace(Date(),"-","")
	Case "2017-04-29"
		rtCode = array(77511,77684,77564,77588,77676)
		rtAlt  = array("오래도록 기억에 남을 마음","느린 만큼 더 소중한 slow moments","너의 주름까지 사랑스러워","12개의 성분으로도 충분합니다!","따뜻한 봄의 시작")
		rCnt   = "5"
		rtDate = "20170428"
	Case "2017-04-30"
		rtCode = array(77511,77684,77564,77588,77676)
		rtAlt  = array("오래도록 기억에 남을 마음","느린 만큼 더 소중한 slow moments","너의 주름까지 사랑스러워","12개의 성분으로도 충분합니다!","따뜻한 봄의 시작")
		rCnt   = "5"
		rtDate = "20170428"
	Case Else
		rtCode = array(77515,77298,77456,77490,77487)
		rtAlt  = array("감사한 마음 가득 담은 꽃 카네이션","PHILIPS LAUNCHING GIFT","베이직 하지만, 특별하고싶어","봄의 길 위에서","달콤한 피크닉 MELLOW MOMENT")
		rCnt   = "5"
		rtDate = "20170418"
end Select

'//배너 노출 랜덤
superRookieNum = int(Rnd*(rCnt))+1

'//html 출력
Function innerhtml()
	Dim ii	
	For ii = 0 To rCnt-1
		innerhtml = innerhtml & "<a href=""/event/eventmain.asp?eventid="& rtCode(ii) &"&gaparam=main_sr_"&rtDate&"_"&ii&"""><p class=""imgOverV15""><img src=""http://fiximage.10x10.co.kr/web2017/main/bwbnr_"& rtDate &"_"& ii &".jpg"" alt="""& rtAlt(ii) &""" /></p></a>" & vbCrlf
	Next 
	Response.write innerhtml
End Function
%>
<style>
.bwBnrV17 {overflow:hidden; position:relative; width:630px; height:120px; padding-left:392px; margin:30px auto 0;}
.bwBnrV17 h2 {position:absolute; left:0; top:0; width:503px; height:120px; z-index:10;}
.bwBnrV17 .mainBrWeekSlideV17 {position:relative; width:630px; height:120px; z-index:9;}
.bwBnrV17 .mainBrWeekSlideV17 .slidesjs-navigation {overflow:hidden; position:absolute; top:0; width:75px; height:100%; background-image:url(http://fiximage.10x10.co.kr/web2017/main/bwbnr_navi.png); background-repeat:no-repeat; text-indent:-999em; z-index:10;}
.bwBnrV17 .mainBrWeekSlideV17 .slidesjs-previous {left:92px; background-position:0 50%;}
.bwBnrV17 .mainBrWeekSlideV17 .slidesjs-next {right:0; background-position:100% 50%;}
</style>
<script>
$(function(){
	$('.mainBrWeekSlideV17').slidesjs({
		width:630,
		height:120,
		start:<%=superRookieNum%>,<%'start 랜덤 값 넣으면됨 %>
		navigation:{active:true, effect:"fade"},
		pagination:{active:false},
		play:{active:false, interval:4000, effect:"fade", auto:true},
		stop:{active:false},
		effect:{
			fade:{speed:700, crossfade:true}
		}
	});
});
</script>
<%'!-- 슈퍼루키 위크 기획전 배너(20170418~) --%>
<div class="bwBnrV17">
	<h2><a href="/shoppingtoday/shoppingchance_allevent.asp?scT=bw"><img src="http://fiximage.10x10.co.kr/web2017/main/bwbnr_tit.png" alt="Unique Wrapping paper" /></a></h2>
	<div class="mainBrWeekSlideV17">
		<% innerhtml() %>
	</div>
</div>
<%'!--// 슈퍼루키 위크 기획전 배너(20170418~) --%>
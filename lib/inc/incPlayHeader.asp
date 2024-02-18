<div class="playHeaderWrapV15">
	<div class="playHeaderV15">
		<h2>
			<a href="/play/">
				<span><img src="http://fiximage.10x10.co.kr/web2015/play/tit_play.gif" alt="PLAY" /></span>
				<p><img src="http://fiximage.10x10.co.kr/web2015/play/txt_play_slogan.gif" alt="즐거운 텐바이텐 감성놀이터" /></p>
			</a>
		</h2>
		<div class="playGnbWrapV15">
			<ul class="playGnbV15">
				<!-- for dev msg : 현재 페이지에 클래스 current 넣어주세요 -->
				<li class="gnbGroundV15 <%=chkiif(inStr(current_url,"Ground") > 0,"current","")%>" onclick="location.href='/play/playGround.asp';">
					<p>Ground<span></span></p>
				</li>
				<li class="gnbStyleV15 <%=chkiif(inStr(current_url,"Style") > 0,"current","")%>" onclick="location.href='/play/playStylePlus.asp';">
					<p>Style+<span></span></p>
				</li>
				<li class="gnbColorV15 <%=chkiif(inStr(current_url,"Color") > 0,"current","")%>" onclick="location.href='/play/playColorTrend.asp';">
					<p>Color trend<span></span></p>
				</li>
				<li class="gnbDFingersV15 <%=chkiif(inStr(current_url,"Fingers")>0,"current","")%>" onclick="location.href='/play/playDesignFingers.asp';">
					<p>Design fingers<span></span></p>
				</li>
				<li class="gnbDiaryV15 <%=chkiif(inStr(current_url,"Diary") > 0,"current","")%>" onclick="location.href='/play/playPicDiary.asp';">
					<p>그림 일기<span></span></p>
				</li>
				<li class="gnbVideoV15 <%=chkiif(inStr(current_url,"Video") > 0,"current","")%>" onclick="location.href='/play/playVideoClipList.asp';">
					<p>Video clip<span></span></p>
				</li>
				<li class="gnbEpisodeV15 <%=chkiif(inStr(current_url,"Episode") > 0,"current","")%>" onclick="location.href='/play/playtEpisodePhotopick.asp';">
					<p>T-episode<span></span></p>
				</li>
			</ul>
		</div>
	</div>
</div>
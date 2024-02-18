<% Dim Curl  : Curl = Request.ServerVariables("url") %>
					<li class="photoPick">
						<a href="/play/playtEpisodePhotopick.asp" <%= Chkiif(inStr(lcase(Curl),"photopick") > 0,"class='on'","") %>>
							<span>PHOTO PICK</span>
						</a>
					</li>
					<li class="wallpaper">
						<a href="/play/playtEpisodeWallpaperPc.asp" <%= Chkiif(inStr(lcase(Curl),"wallpaper") > 0,"class='on'","") %>>
							<span>WALLPAPER</span>
						</a>
					</li>
					<li class="screenSaver">
						<a href="/play/playtEpisodeScreensaver.asp" <%= Chkiif(inStr(lcase(Curl),"screensaver") > 0,"class='on'","") %>>
							<span>SCREEN SAVER</span>
						</a>
					</li>
					<li class="tenFont">
						<a href="/play/playtEpisodeFont.asp" <%= Chkiif(inStr(lcase(Curl),"font") > 0,"class='on'","") %> >
							<span>10X10 FONT</span>
						</a>
					</li>
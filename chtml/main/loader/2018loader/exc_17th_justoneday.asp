<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
response.charset = "utf-8"
Session.Codepage = 65001
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
			<%'<!-- 저스트원데이 17주년 (10/15~31) -->%>
			<% if not ((date() = "2018-10-20") or (date() = "2018-10-21") or (date() = "2018-10-27") or (date() = "2018-10-28")) then %>
			<script type="text/javascript" src="/event/etc/json/js_89541.js"></script>
			<div class="section just1dayV17th" id="17thSpecialItems">
				<div class="inner-cont">
					<h2></h2>
					<div class="time">남은 시간 <span id="time"></span></div>					
					<div class="items ftLt">
						<a href="" id="17thItemLink">
							<div class="thumbnail" id="specialItemThumbnail"><img src="" alt=""></div>
							<div class="desc">
								<p class="name" id="specialItemName"></p>
								<div class="price" id="specialItemPrice">
									<s></s><b></b>
								</div>
								<div class="discount" id="17thSpecialItemSalePer"></div>
							</div>
						</a>
					</div>
					<div class="items ftRt">
						<h3>스페셜 <b>브랜드 세일</b></h3>
						<ul id="17thBrnadEventList">
							<li>
								<a href="">
									<div class="thumbnail"><img src="" alt=""></div>
									<div class="desc">
										<p class="subname"></p>
										<p class="name"></p>
										<div class="discount"></div>
									</div>
								</a>
							</li>
							<li>
								<a href="">
									<div class="thumbnail"><img src="" alt=""></div>
									<div class="desc">
										<p class="subname"></p>
										<p class="name"></p>
										<div class="discount"></div>
									</div>
								</a>
							</li>
							<li>
								<a href="">
									<div class="thumbnail"><img src="" alt=""></div>
									<div class="desc">
										<p class="subname"></p>
										<p class="name"></p>
										<div class="discount"></div>
									</div>
								</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<!--// 저스트원데이 -->	
			<% end if %>
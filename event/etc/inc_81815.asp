<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 2017 크리스마스 기획전
' History : 2017-11-16 유태욱 생성
'####################################################
%>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%

dim currenttime
	currenttime =  date()
'	currenttime = "2017-11-20"

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  67461
Else
	eCode   =  81815
End If

dim group1item1, group1item2, group1item3, group1item4, group1item5, group1item6
dim group1item1img, group1item2img, group1item3img, group1item4img, group1item5img, group1item6img
dim group1item1name, group1item2name, group1item3name, group1item4name, group1item5name, group1item6name

dim group2item1, group2item2, group2item3, group2item4, group2item5, group2item6
dim group2item1img, group2item2img, group2item3img, group2item4img, group2item5img, group2item6img
dim group2item1name, group2item2name, group2item3name, group2item4name, group2item5name, group2item6name

dim group3item1, group3item2, group3item3, group3item4, group3item5, group3item6
dim group3item1img, group3item2img, group3item3img, group3item4img, group3item5img, group3item6img
dim group3item1name, group3item2name, group3item3name, group3item4name, group3item5name, group3item6name

if currenttime <= "2017-11-26" then
	'혼자서 여유롭게-------------------------------------------------------------------------
	group1item1 = "1380085"
	group1item1img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_alone_item_1.jpg"
	group1item1name = "사슴 웜 무드 램프"

	group1item2 = "1609775"
	group1item2img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_alone_item_2.jpg"
	group1item2name = "초대형 크리스마스 태피스트리"

	group1item3 = "1835885"
	group1item3img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_alone_item2_4.jpg"
	group1item3name = "디어 캔들워머 무드등"

	group1item4 = "1822342"
	group1item4img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_alone_item_4.jpg"
	group1item4name = "루나 카페라떼 잔"

	group1item5 = "1828470"
	group1item5img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_alone_item_5.jpg"
	group1item5name = "베리 &amp; 시더콘 미니 캔들링"

	group1item6 = "1210615"
	group1item6img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_alone_item_6.jpg"
	group1item6name = "데일리 플레이트 (23cm)"
	'----------------------------------------------------------------------------------------

	'둘이서 오붓하게-------------------------------------------------------------------------
	group2item1 = "1790815"
	group2item1img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_couple_item_1.jpg"
	group2item1name = "오리엔트 커트러리(4style)"

	group2item2 = "1807163"
	group2item2img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_couple_item_2.jpg"
	group2item2name = "새우 로제 파스타 (2인분)"

	group2item3 = "1598258"
	group2item3img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_couple_item_3.jpg"
	group2item3name = "크리스마스 테이블 커버"

	group2item4 = "1707851"
	group2item4img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_couple_item_4.jpg"
	group2item4name = "훗카이도 눈꽃 레어 치즈케익"

	group2item5 = "1825991"
	group2item5img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_couple_item_5.jpg"
	group2item5name = "로즈 홀리데이 부쉬 조화"

	group2item6 = "1808742"
	group2item6img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_couple_item_6.jpg"
	group2item6name = "볼볼 빈티지 2인 홈세트"
	'--------------------------------------------------------------------------------------

	'여럿이 즐겁게-------------------------------------------------------------------------
	group3item1 = "1437191"
	group3item1img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_many_item_1_v2.jpg"
	group3item1name = "우드 2단 케이크 스탠드"

	group3item2 = "1601295"
	group3item2img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_many_item_2.jpg"
	group3item2name = "마블 헥사곤 플레이트(12p)"


	group3item3 = "1618624"
	group3item3img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_many_item_4.jpg"
	group3item3name = "윈터 스윗 선인장 트리"

	group3item4 = "1781009"
	group3item4img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_many_item_3.jpg"
	group3item4name = "코튼볼 LED조명(S/M)"

	group3item5 = "973844"
	group3item5img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_many_item_6.jpg"
	group3item5name = "포레스트 가랜드"

	group3item6 = "1599409"
	group3item6img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_many_item_5.jpg"
	group3item6name = "컨페티풍선set-메탈릭"
	'--------------------------------------------------------------------------------------
elseif currenttime >= "2017-11-27" and currenttime <= "2017-12-03" then
	'혼자서 여유롭게-------------------------------------------------------------------------
	group1item1 = "1835928"
	group1item1img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_alone_item2_1.jpg"
	group1item1name = "솔방울, 크리스마스 캔들"

	group1item2 = "1829171"
	group1item2img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_alone_item2_2.jpg"
	group1item2name = "드리머+캔디드랍스 쉐이드커버"

	group1item3 = "1824407"
	group1item3img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_alone_item2_3.jpg"
	group1item3name = "크리스마스 낮잠 곰돌이 머그"

	group1item4 = "1835885"
	group1item4img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_alone_item2_4.jpg"
	group1item4name = "디어 캔들워머 무드등"

	group1item5 = "1311291"
	group1item5img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_alone_item2_5.jpg"
	group1item5name = "사계절 티팟 700ml"

	group1item6 = "1838501"
	group1item6img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_alone_item2_6.jpg"
	group1item6name = "아기양 브라운베이지 트리세트"
	'----------------------------------------------------------------------------------------

	'둘이서 오붓하게-------------------------------------------------------------------------
	group2item1 = "1830384"
	group2item1img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_couple_item2_1.jpg"
	group2item1name = "비젼글래스 골드에디션"

	group2item2 = "1598256"
	group2item2img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_couple_item2_2.jpg"
	group2item2name = "크리스마스 베이직 에이프런"

	group2item3 = "1696321"
	group2item3img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_couple_item2_3.jpg"
	group2item3name = "핑크브라운 2인 홈세트 (9P)"

	group2item4 = "1781568"
	group2item4img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_couple_item2_4.jpg"
	group2item4name = "포르치니 버섯 크림파스타"

	group2item5 = "1837445"
	group2item5img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_couple_item2_5.jpg"
	group2item5name = "골드라인 클리어 롱 화병"

	group2item6 = "1707849"
	group2item6img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_couple_item2_6.jpg"
	group2item6name = "훗카이도 수제 밀크 롤케이크"
	'--------------------------------------------------------------------------------------

	'여럿이 즐겁게-------------------------------------------------------------------------
	group3item1 = "1837420"
	group3item1img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_many_item2_1.jpg"
	group3item1name = "DIY 크리스마스 벽트리"

	group3item2 = "1402973"
	group3item2img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_many_item2_2.jpg"
	group3item2name = "케이크토퍼 - 메리크리스마스"

	group3item3 = "1838282"
	group3item3img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_many_item2_3.jpg"
	group3item3name = "베리 골드 리스"

	group3item4 = "1837440"
	group3item4img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_many_item2_4.jpg"
	group3item4name = "컨페티풍선 세트(12p)"

	group3item5 = "1809394"
	group3item5img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_many_item2_5.jpg"
	group3item5name = "스트링 전구"

	group3item6 = "1828472"
	group3item6img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_many_item2_6.jpg"
	group3item6name = "레드별 로핑 내츄럴 갈란드"
	'--------------------------------------------------------------------------------------
elseif currenttime >= "2017-12-04" and currenttime <= "2017-12-10" then
	'혼자서 여유롭게-------------------------------------------------------------------------
	group1item1 = "1835882"
	group1item1img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_alone_item3_1.jpg"
	group1item1name = "크리스마스트리 돔 - 아기사슴"

	group1item2 = "1707372"
	group1item2img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_alone_item3_2.jpg"
	group1item2name = "포터리어 머그 + 플레이트 세트"

	group1item3 = "1835481"
	group1item3img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_alone_item3_3_v2.jpg"
	group1item3name = "메리 윈터 캔들 + 타블렛 세트"

	group1item4 = "1585320"
	group1item4img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_alone_item3_4.jpg"
	group1item4name = "슬로우커피 커피서버 (600ml)"

	group1item5 = "1835538"
	group1item5img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_alone_item3_5.jpg"
	group1item5name = "LED 니켈 사슴(전구포함)"

	group1item6 = "1827588"
	group1item6img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_alone_item3_6.jpg"
	group1item6name = "메탈 골드 스퀘어 트레이"
	'----------------------------------------------------------------------------------------

	'둘이서 오붓하게-------------------------------------------------------------------------
	group2item1 = "1834722"
	group2item1img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_couple_item3_1.jpg"
	group2item1name = "어반데일리 플레이트+머그세트"

	group2item2 = "1752800"
	group2item2img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_couple_item3_2.jpg"
	group2item2name = "살룻 미니 담금주 키트 5종"

	group2item3 = "1841610"
	group2item3img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_couple_item3_3.jpg"
	group2item3name = "반짝이는지금, 눈꽃 플레이트"

	group2item4 = "1844482"
	group2item4img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_couple_item3_4.jpg"
	group2item4name = "트윙클 골든볼 부케"

	group2item5 = "1846430"
	group2item5img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_couple_item3_5.jpg"
	group2item5name = "크리스마스 기프트세트"

	group2item6 = "1845189"
	group2item6img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_couple_item3_6.jpg"
	group2item6name = "치킨세트"
	'--------------------------------------------------------------------------------------

	'여럿이 즐겁게-------------------------------------------------------------------------
	group3item1 = "1847049"
	group3item1img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_many_item3_1.jpg"
	group3item1name = "크리스마스 트리+오너먼트 세트"

	group3item2 = "1550780"
	group3item2img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_many_item3_2.jpg"
	group3item2name = "푸드커버 무드등"

	group3item3 = "1848732"
	group3item3img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_many_item3_3.jpg"
	group3item3name = "크리스마스 미니리스"

	group3item4 = "1835969"
	group3item4img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_many_item3_4.jpg"
	group3item4name = "눈꽃결정 원목조각 데코"

	group3item5 = "1847026"
	group3item5img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_many_item3_5.jpg"
	group3item5name = "메리 브라이트 크리스마스 토퍼"

	group3item6 = "1837441"
	group3item6img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_many_item3_6.jpg"
	group3item6name = "블랙 &amp; 골드 파티웨어 4종세트"
	'--------------------------------------------------------------------------------------
elseif currenttime >= "2017-12-11" and currenttime <= "2017-12-17" then
	'혼자서 여유롭게-------------------------------------------------------------------------
	group1item1 = "1835882"
	group1item1img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_alone_item3_1.jpg"
	group1item1name = "크리스마스트리 돔 - 아기사슴"

	group1item2 = "1707372"
	group1item2img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_alone_item3_2.jpg"
	group1item2name = "포터리어 머그 + 플레이트 세트"

	group1item3 = "1835481"
	group1item3img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_alone_item3_3_v2.jpg"
	group1item3name = "메리 윈터 캔들 + 타블렛 세트"

	group1item4 = "1585320"
	group1item4img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_alone_item3_4.jpg"
	group1item4name = "슬로우커피 커피서버 (600ml)"

	group1item5 = "1835538"
	group1item5img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_alone_item3_5.jpg"
	group1item5name = "LED 니켈 사슴(전구포함)"

	group1item6 = "1827588"
	group1item6img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_alone_item3_6.jpg"
	group1item6name = "메탈 골드 스퀘어 트레이"
	'----------------------------------------------------------------------------------------

	'둘이서 오붓하게-------------------------------------------------------------------------
	group2item1 = "1834722"
	group2item1img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_couple_item3_1.jpg"
	group2item1name = "어반데일리 플레이트+머그세트"

	group2item2 = "1752800"
	group2item2img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_couple_item3_2.jpg"
	group2item2name = "살룻 미니 담금주 키트 5종"

	group2item3 = "1841610"
	group2item3img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_couple_item3_3.jpg"
	group2item3name = "반짝이는지금, 눈꽃 플레이트"

	group2item4 = "1844482"
	group2item4img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_couple_item3_4.jpg"
	group2item4name = "트윙클 골든볼 부케"

	group2item5 = "1846430"
	group2item5img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_couple_item3_5.jpg"
	group2item5name = "크리스마스 기프트세트"

	group2item6 = "1845189"
	group2item6img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_couple_item3_6.jpg"
	group2item6name = "치킨세트"
	'--------------------------------------------------------------------------------------

	'여럿이 즐겁게-------------------------------------------------------------------------
	group3item1 = "1847049"
	group3item1img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_many_item3_1.jpg"
	group3item1name = "크리스마스 트리+오너먼트 세트"

	group3item2 = "1550780"
	group3item2img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_many_item3_2.jpg"
	group3item2name = "푸드커버 무드등"

	group3item3 = "1848732"
	group3item3img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_many_item3_3.jpg"
	group3item3name = "크리스마스 미니리스"

	group3item4 = "1835969"
	group3item4img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_many_item3_4.jpg"
	group3item4name = "눈꽃결정 원목조각 데코"

	group3item5 = "1847026"
	group3item5img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_many_item3_5.jpg"
	group3item5name = "메리 브라이트 크리스마스 토퍼"

	group3item6 = "1837441"
	group3item6img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_many_item3_6.jpg"
	group3item6name = "블랙 &amp; 골드 파티웨어 4종세트"
	'--------------------------------------------------------------------------------------
elseif currenttime >= "2017-12-18" then
	'혼자서 여유롭게-------------------------------------------------------------------------
	group1item1 = "1835882"
	group1item1img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_alone_item3_1.jpg"
	group1item1name = "크리스마스트리 돔 - 아기사슴"

	group1item2 = "1707372"
	group1item2img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_alone_item3_2.jpg"
	group1item2name = "포터리어 머그 + 플레이트 세트"

	group1item3 = "1835481"
	group1item3img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_alone_item3_3_v2.jpg"
	group1item3name = "메리 윈터 캔들 + 타블렛 세트"

	group1item4 = "1585320"
	group1item4img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_alone_item3_4.jpg"
	group1item4name = "슬로우커피 커피서버 (600ml)"

	group1item5 = "1835538"
	group1item5img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_alone_item3_5.jpg"
	group1item5name = "LED 니켈 사슴(전구포함)"

	group1item6 = "1827588"
	group1item6img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_alone_item3_6.jpg"
	group1item6name = "메탈 골드 스퀘어 트레이"
	'----------------------------------------------------------------------------------------

	'둘이서 오붓하게-------------------------------------------------------------------------
	group2item1 = "1834722"
	group2item1img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_couple_item3_1.jpg"
	group2item1name = "어반데일리 플레이트+머그세트"

	group2item2 = "1752800"
	group2item2img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_couple_item3_2.jpg"
	group2item2name = "살룻 미니 담금주 키트 5종"

	group2item3 = "1841610"
	group2item3img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_couple_item3_3.jpg"
	group2item3name = "반짝이는지금, 눈꽃 플레이트"

	group2item4 = "1844482"
	group2item4img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_couple_item3_4.jpg"
	group2item4name = "트윙클 골든볼 부케"

	group2item5 = "1846430"
	group2item5img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_couple_item3_5.jpg"
	group2item5name = "크리스마스 기프트세트"

	group2item6 = "1845189"
	group2item6img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_couple_item3_6.jpg"
	group2item6name = "치킨세트"
	'--------------------------------------------------------------------------------------

	'여럿이 즐겁게-------------------------------------------------------------------------
	group3item1 = "1847049"
	group3item1img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_many_item3_1.jpg"
	group3item1name = "크리스마스 트리+오너먼트 세트"

	group3item2 = "1550780"
	group3item2img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_many_item3_2.jpg"
	group3item2name = "푸드커버 무드등"

	group3item3 = "1848732"
	group3item3img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_many_item3_3.jpg"
	group3item3name = "크리스마스 미니리스"

	group3item4 = "1835969"
	group3item4img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_many_item3_4.jpg"
	group3item4name = "눈꽃결정 원목조각 데코"

	group3item5 = "1847026"
	group3item5img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_many_item3_5.jpg"
	group3item5name = "메리 브라이트 크리스마스 토퍼"

	group3item6 = "1837441"
	group3item6img = "http://webimage.10x10.co.kr/eventIMG/2017/81815/img_many_item3_6.jpg"
	group3item6name = "블랙 &amp; 골드 파티웨어 4종세트"
	'--------------------------------------------------------------------------------------
end if
%>
<style type="text/css">
.christmas2017 {background-color:#fff;}
.christmas2017 .hidden {visibility:hidden; position:absolute; left:0; top:0; width:0; height:0;}
.christmas2017 .inner {position:relative; width:1140px; margin:0 auto;}
.christmas2017 .topic {height:763px; background:#1c1b26 url(http://webimage.10x10.co.kr/eventIMG/2017/81815/bg_topic_v2.jpg) 50% 0 no-repeat;}
.christmas2017 .topic h2 {padding:290px 0 68px; animation:titAnim 1s .3s forwards; opacity:0;}
.christmas2017 .topic p {animation:titAnim 1s .8s forwards; opacity:0;}

.christmas2017 .section {background-position:0 0; background-repeat:repeat;}
.christmas2017 #alone {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/81815/bg_noise_1.png);}
.christmas2017 #couple {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/81815/bg_noise_2.png);}
.christmas2017 #many {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/81815/bg_noise_3.png);}
.christmas2017 .section .inner {padding:125px 0 110px;}
.christmas2017 .section .num {position:absolute; left:-4px; top:-38px;}
.christmas2017 .section .items {width:792px; padding-left:348px;}
.christmas2017 .section .items ul {overflow:hidden;}
.christmas2017 .section .items li {float:left; width:250px; height:390px; margin:0 0 15px 14px; font:bold 14px/1 dotum; text-align:center; background:#f2f2f2;}
.christmas2017 .section .items li a {display:block; height:390px; color:#222; text-decoration:none;}
.christmas2017 .section .items li .name {padding-top:25px;}
.christmas2017 .section .items li .price {padding-top:10px; color:#575757; line-height:17px;}
.christmas2017 .section .items li .price s {display:none;}
.christmas2017 .section .items li .price span {display:inline-block; position:relative; height:17px; top:-1px; margin-left:5px; padding:0 6px; color:#e4e2e2; font-size:13px; line-height:18px; background-color:#ce2828; border-radius:8px;}
.christmas2017 .section .navigation {position:absolute; left:12px; top:224px; width:217px; height:290px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_nav.png) 0 0 no-repeat;}
.christmas2017 .section .navigation li {height:31px; margin-top:100px;}
.christmas2017 .section .navigation li:first-child {margin-top:0;}
.christmas2017 .section .navigation li a {display:block; height:100%; text-indent:-999em;}
.christmas2017 .section .story {position:absolute; left:12px; top:618px; text-align:left;}
.christmas2017 .section .story p {padding-bottom:40px;}

.christmas2017 .represent {height:778px; background-position:50% 0; background-repeat:no-repeat;}
.christmas2017 #alone .represent {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/81815/bg_alone.jpg);}
.christmas2017 #couple .represent {height:746px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/81815/bg_couple.jpg);}
.christmas2017 #many .represent {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/81815/bg_many.jpg);}
.christmas2017 .represent li {position:absolute;}
.christmas2017 .represent li i {display:inline-block; position:relative; width:10px; height:10px; background:#fff; border-radius:50%; animation:bounce1 1.5s infinite;}
.christmas2017 .represent li i:after {content:''; display:inline-block; position:absolute; left:-5px; top:-5px; width:20px; height:20px; background:#fff; border-radius:50%; box-shadow:0 0 4px 2px rgba(0,0,0,.1); animation:bounce2 1.8s infinite; opacity:0;}

.christmas2017 .represent li span {position:absolute; opacity:0; transition:all .3s;}
.christmas2017 .represent li span img {position:relative; transition:all .3s;}
.christmas2017 .represent li span.top {left:-5px; top:-72px;}
.christmas2017 .represent li span.top img {top:10px;}
.christmas2017 .represent li span.left {left:-90px; top:0;}
.christmas2017 .represent li span.left img {left:10px;}
.christmas2017 .represent li span.right {right:-88px; top:0px;}
.christmas2017 .represent li span.right img {left:-10px;}
.christmas2017 .represent li span.bottom {left:-5px; top:19px;}
.christmas2017 .represent li span.bottom img {top:10px;}
.christmas2017 .represent li a:hover span {opacity:1;}
.christmas2017 .represent li a:hover span img {left:0; top:0; right:0;}

.christmas2017 .represent li.pdt1 i,.christmas2017 .represent li.pdt2 i,
.christmas2017 .represent li.pdt5 i,.christmas2017 .represent li.pdt7 i,
.christmas2017 .represent li.pdt1 i:after,.christmas2017 .represent li.pdt2 i:after,
.christmas2017 .represent li.pdt5 i:after,.christmas2017 .represent li.pdt7 i:after {animation-delay:.8s;}

.christmas2017 #alone .represent li.pdt1 {left:13px; top:590px;}
.christmas2017 #alone .represent li.pdt2 {left:545px; top:183px;}
.christmas2017 #alone .represent li.pdt3 {left:568px; top:572px;}
.christmas2017 #alone .represent li.pdt4 {left:695px; top:246px;}
.christmas2017 #alone .represent li.pdt5 {left:798px; top:706px;}
.christmas2017 #alone .represent li.pdt6 {left:877px; top:547px;}
.christmas2017 #alone .represent li.pdt7 {left:1066px; top:463px;}
.christmas2017 #alone .represent li.pdt8 {left:1084px; top:384px;}

.christmas2017 #couple .represent li.pdt1 {left:-86px; top:546px;}
.christmas2017 #couple .represent li.pdt2 {left:80px; top:458px;}
.christmas2017 #couple .represent li.pdt3 {left:188px; top:62px;}
.christmas2017 #couple .represent li.pdt4 {left:337px; top:308px;}
.christmas2017 #couple .represent li.pdt5 {left:650px; top:513px;}
.christmas2017 #couple .represent li.pdt6 {left:756px; top:251px;}
.christmas2017 #couple .represent li.pdt7 {left:772px; top:406px;}
.christmas2017 #couple .represent li.pdt8 {left:910px; top:670px;}
.christmas2017 #couple .represent li.pdt9 {left:1351px; top:375px;}

.christmas2017 #many .represent li.pdt1 {left:62px; top:600px;}
.christmas2017 #many .represent li.pdt2 {left:185px; top:320px;}
.christmas2017 #many .represent li.pdt3 {left:236px; top:535px;}
.christmas2017 #many .represent li.pdt4 {left:397px; top:453px;}
.christmas2017 #many .represent li.pdt5 {left:536px; top:70px;}
.christmas2017 #many .represent li.pdt6 {left:819px; top:415px;}
.christmas2017 #many .represent li.pdt7 {left:990px; top:502px;}
.christmas2017 #many .represent li.pdt8 {left:1099px; top:238px;}
.christmas2017 #many .represent li.pdt9 {left:1384px; top:73px;}

.christmas2017 #couple .items {margin-left:-15px; padding-left:0;}
.christmas2017 #couple .navigation {left:907px; background-position:-217px 0;}
.christmas2017 #couple .story {left:860px; width:268px; text-align:right;}
.christmas2017 #many .navigation {background-position:100% 0;}

.christmas-event {background:url(http://webimage.10x10.co.kr/eventIMG/2017/81815/bg_noise_4.png) 0 0 repeat;}
.christmas-event .inner {height:626px; padding:125px 95px 0; background:url(http://webimage.10x10.co.kr/eventIMG/2017/81815/bg_bnr.jpg) 0 0 no-repeat;}
.christmas-event ul {position:relative; overflow:hidden; background:#132648;}
.christmas-event ul:after {content:''; display:block; position:absolute; right:0; top:0; width:1px; height:500px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/81815/bg_blank.png) 0 0 no-repeat}
.christmas-event li {position:relative; overflow:hidden; float:left; width:85px; height:500px;}
.christmas-event li.active {width:885px;}
.christmas-event li:after {content:''; display:block; position:absolute; left:0; top:0; width:85px; height:500px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_event_1.jpg) 0 0 no-repeat; opacity:1; transition:all .4s;}
.christmas-event li.bnr2:after {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_event_2.jpg);}
.christmas-event li.bnr3:after {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_event_3.jpg);}
.christmas-event li.bnr4:after {background-image:url(http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_event_4.jpg);}
.christmas-event li.hover:after {opacity:0;}

.christmas-item {padding-top:140px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/81815/bg_bnr_arrow.png) 50% 0 no-repeat;}
.christmas-item .type {overflow:hidden; width:822px; margin:0 auto; padding:62px 0 70px;}
.christmas-item .type li {float:left; width:137px; height:145px;}
.christmas-item .type li input {visibility:hidden; position:absolute; left:0; top:0; width:0; height:0;}
.christmas-item .type li label {display:inline-block; overflow:hidden; height:145px; cursor:pointer;}
.christmas-item .type li input[type=radio]:checked + label img {margin-top:-155px;}
.christmas-item .type li.on label img {margin-top:-155px;}

.christmas-item .pdtWrap {width:1140px; margin:0 auto; padding-bottom:0; background:none;}
.christmas-item .pdtWrap .pdtList li {width:20%; height:345px; padding:30px 0 0;}
.christmas-item .pdtBox {width:180px;}
.christmas-item .pdtPhoto img {width:180px; height:180px;}

@keyframes bounce1 {
	from,to {transform:translateY(0);}
	50% {transform:translateY(5px);}
}
@keyframes bounce2 {
	from {transform:scale(0); opacity:1;}
	to {transform:scale(1.8); opacity:0;}
}
@keyframes titAnim {
	from {transform:translateY(10px); opacity:0;}
	to {transform:translateY(0); opacity:1;}
}
</style>
<script type="text/javascript" src="/event/etc/json/js_applyItemInfo.js"></script>
<script>
$(function(){
	activeItem = $(".christmas-event li:first");
	$(activeItem).addClass('active');
	$(".christmas-event li").hover(function(){
		$(".christmas-event li").removeClass("hover");
		$(this).addClass("hover");
		$(activeItem).animate({width:"85px"},{duration:300, queue:false});
		$(this).animate({width: "885px"},{duration:300, queue:false});
		activeItem = this;
	});

	$(".navigation li a").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top}, 800);
	});

	fnApplyItemInfoToTalPriceList({
		items:"<%=group1item1%>,<%=group1item2%>,<%=group1item3%>,<%=group1item4%>,<%=group1item5%>,<%=group1item6%>,<%=group2item1%>,<%=group2item2%>,<%=group2item3%>,<%=group2item4%>,<%=group2item5%>,<%=group2item6%>,<%=group3item1%>,<%=group3item2%>,<%=group3item3%>,<%=group3item4%>,<%=group3item5%>,<%=group3item6%>", // 상품코드
		target:"code",
		fields:["price","sale"],
		unit:"hw"
	});
	bestitemlist('type1','224155');
});

function bestitemlist(tp,gb){
//	if(gb=="224155"){
//		$("#type1").prop("checked",true);
//	}
	$.ajax({
		type: "get",
		url: "/event/etc/ajax_inc_81815.asp",
		data: "srm="+gb,
		cache: false,
		success: function(message) {
			if(message!="") {
				$('#ajaxlist').empty().html(message);
				$(".christmas-item li").removeClass("on");
				$("#"+tp+"li").addClass("on");
				return false;
			}
		},
		error: function(err) {
			console.log(err.responseText);
		}
	});
}
</script>
	<!-- 2017 크리스마스 기획전 -->
	<div class="evt81815 christmas2017">
		<div class="topic">
			<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/tit_christmas_v2.png" alt="I wish We Feel Christmas" /></h2>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_subcopy.png" alt="크리스마스를 즐기는 세가지 방법" /></p>
		</div>

		<!-- 1.혼자서 여유롭게 -->
		<div id="alone" class="section">
			<h3 class="hidden">혼자서 여유롭게</h3>
			<div class="represent">
				<ul class="inner">
					<li class="pdt1"><a href="/shopping/category_prd.asp?itemid=1797423&pEtr=81815" target="_blank"><i></i><span class="top"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_rep_alone_1.png" alt="blanket" /></span></a></li>
					<li class="pdt2"><a href="/shopping/category_prd.asp?itemid=1366309&pEtr=81815" target="_blank"><i></i><span class="left" style="margin-left:-13px;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_rep_alone_2.png" alt="candle" /></span></a></li>
					<li class="pdt3"><a href="/shopping/category_prd.asp?itemid=1782597&pEtr=81815" target="_blank"><i></i><span class="right" style="margin-top:-26px;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_rep_alone_3.png" alt="cup" /></span></a></li>
					<li class="pdt4"><a href="/shopping/category_prd.asp?itemid=1823631&pEtr=81815" target="_blank"><i></i><span class="right"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_rep_alone_4.png" alt="candle stick" /></span></a></li>
					<li class="pdt5"><a href="/shopping/category_prd.asp?itemid=1761652&pEtr=81815" target="_blank"><i></i><span class="right" style="margin:-43px -9px 0 0;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_rep_alone_5.png" alt="cutting board" /></span></a></li>
					<li class="pdt6"><a href="/shopping/category_prd.asp?itemid=972555&pEtr=81815" target="_blank"><i></i><span class="right"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_rep_alone_6.png" alt="candle" /></span></a></li>
					<li class="pdt7"><a href="/shopping/category_prd.asp?itemid=1826134&pEtr=81815" target="_blank"><i></i><span class="left"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_rep_alone_7.png" alt="tree" /></span></a></li>
					<li class="pdt8"><a href="/shopping/category_prd.asp?itemid=1822919&pEtr=81815" target="_blank"><i></i><span class="left"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_rep_alone_8.png" alt="deco" /></span></a></li>
				</ul>
			</div>
			<div class="inner">
				<div class="num"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_num_1.png" alt="1" /></div>
				<ul class="navigation">
					<li><a href="#alone">혼자서 여유롭게</a></li>
					<li><a href="#couple">둘이서 오붓하게</a></li>
					<li><a href="#many">여럿이 즐겁게</a></li>
				</ul>
				<div class="story">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_story_1.png" alt="혼자라면 무조건 외롭다는 편견을 뒤로하고 한 해 동안의 나를 돌아보는 시간을 가져요. 향 좋은 캔들 하나 켜두고 쉼을 갖는 하루는 지친 마음을 여유롭게 만들어 줄 거예요." /></p>
					<a href="/event/eventmain.asp?eventid=81817" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/btn_more_1.png" alt="상품 더 보기" /></a>
				</div>
				<div class="items">
					<ul>
						<li class="code<%= group1item1 %>">
							<a href="/shopping/category_prd.asp?itemid=<%= group1item1 %>&pEtr=81815" target="_blank">
								<div class="pdtPhoto"><img src="<%= group1item1img %>" alt="" /></div>
								<p class="name"><%= group1item1name %></p>
								<p class="price"><span></span></p>
							</a>
						</li>
						<li class="code<%= group1item2 %>">
							<a href="/shopping/category_prd.asp?itemid=<%= group1item2 %>&pEtr=81815" target="_blank">
								<div class="pdtPhoto"><img src="<%= group1item2img %>" alt="" /></div>
								<p class="name"><%= group1item2name %></p>
								<p class="price"><span></span></p>
							</a>
						</li>
						<li class="code<%= group1item3 %>">
							<a href="/shopping/category_prd.asp?itemid=<%= group1item3 %>&pEtr=81815" target="_blank">
								<div class="pdtPhoto"><img src="<%= group1item3img %>" alt="" /></div>
								<p class="name"><%= group1item3name %></p>
								<p class="price"><span></span></p>
							</a>
						</li>
						<li class="code<%= group1item4 %>">
							<a href="/shopping/category_prd.asp?itemid=<%= group1item4 %>&pEtr=81815" target="_blank">
								<div class="pdtPhoto"><img src="<%= group1item4img %>" alt="" /></div>
								<p class="name"><%= group1item4name %></p>
								<p class="price"><span></span></p>
							</a>
						</li>
						<li class="code<%= group1item5 %>">
							<a href="/shopping/category_prd.asp?itemid=<%= group1item5 %>&pEtr=81815" target="_blank">
								<div class="pdtPhoto"><img src="<%= group1item5img %>" alt="" /></div>
								<p class="name"><%= group1item5name %></p>
								<p class="price"><span></span></p>
							</a>
						</li>
						<li class="code<%= group1item6 %>">
							<a href="/shopping/category_prd.asp?itemid=<%= group1item6 %>&pEtr=81815" target="_blank">
								<div class="pdtPhoto"><img src="<%= group1item6img %>" alt="" /></div>
								<p class="name"><%= group1item6name %></p>
								<p class="price"><span></span></p>
							</a>
						</li>
					</ul>
				</div>
			</div>
		</div>

		<!-- 2.둘이서 오붓하게 -->
		<div id="couple" class="section">
			<div class="represent">
				<ul class="inner">
					<li class="pdt1"><a href="/shopping/category_prd.asp?itemid=1734955&pEtr=81815" target="_blank"><i></i><span class="bottom"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_rep_couple_1.png" alt="cutlery" /></span></a></li>
					<li class="pdt2"><a href="/shopping/category_prd.asp?itemid=1783467&pEtr=81815" target="_blank"><i></i><span class="right"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_rep_couple_2.png" alt="bowl" /></span></a></li>
					<li class="pdt3"><a href="/shopping/category_prd.asp?itemid=1496208&pEtr=81815" target="_blank"><i></i><span class="right"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_rep_couple_3.png" alt="dessert bowl" /></span></a></li>
					<li class="pdt4"><a href="/shopping/category_prd.asp?itemid=1756450&pEtr=81815" target="_blank"><i></i><span class="right" style="margin:-26px -15px 0 0;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_rep_couple_4.png" alt="food (LAMB)" /></span></a></li>
					<li class="pdt5"><a href="/shopping/category_prd.asp?itemid=1741337&pEtr=81815" target="_blank"><i></i><span class="right" style="margin:-25px -72px 0 0;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_rep_couple_5.png" alt="food (oven chicken)" /></span></a></li>
					<li class="pdt6"><a href="/shopping/category_prd.asp?itemid=1781554&pEtr=81815" target="_blank"><i></i><span class="right" style="margin:-25px -67px 0 0;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_rep_couple_6.png" alt="food (brustchetta)" /></span></a></li>
					<li class="pdt7"><a href="/shopping/category_prd.asp?itemid=1781560&pEtr=81815" target="_blank"><i></i><span class="right" style="margin:-26px -33px 0 0;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_rep_couple_7.png" alt="food (gambas)" /></span></a></li>
					<li class="pdt8"><a href="/shopping/category_prd.asp?itemid=956205&pEtr=81815" target="_blank"><i></i><span class="right" style="margin-top:-25px;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_rep_couple_8.png" alt="table runner" /></span></a></li>
					<li class="pdt9"><a href="/shopping/category_prd.asp?itemid=1819748&pEtr=81815" target="_blank"><i></i><span class="left" style="margin-left:2px;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_rep_couple_9.png" alt="glass" /></span></a></li>
				</ul>
			</div>
			<div class="inner">
				<div class="num"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_num_2.png" alt="2" /></div>
				<ul class="navigation">
					<li><a href="#alone">혼자서 여유롭게</a></li>
					<li><a href="#couple">둘이서 오붓하게</a></li>
					<li><a href="#many">여럿이 즐겁게</a></li>
				</ul>
				<div class="story">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_story_2.png" alt="소란스럽게 북적거리는 사람들 틈 속이 아닌 둘만이 간직할 수 있는 저녁 식사는 어떤가요? 함께 장을 보고, 서툴지만 요리 실력을 뽐내어 아껴 두었던 그릇을 꺼내 식탁을 채워 보세요. 그리고 사랑하는 사람과 마주 앉아 그 순간을 공유해보세요." /></p>
					<a href="/event/eventmain.asp?eventid=81818" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/btn_more_2.png" alt="상품 더 보기" /></a>
				</div>
				<div class="items">
					<ul>
						<li class="code<%= group2item1 %>">
							<a href="/shopping/category_prd.asp?itemid=<%= group2item1 %>&pEtr=81815" target="_blank">
								<div class="pdtPhoto"><img src="<%= group2item1img %>" alt="" /></div>
								<p class="name"><%= group2item1name %></p>
								<p class="price"><span></span></p>
							</a>
						</li>
						<li class="code<%= group2item2 %>">
							<a href="/shopping/category_prd.asp?itemid=<%= group2item2 %>&pEtr=81815" target="_blank">
								<div class="pdtPhoto"><img src="<%= group2item2img %>" alt="" /></div>
								<p class="name"><%= group2item2name %></p>
								<p class="price"><span></span></p>
							</a>
						</li>
						<li class="code<%= group2item3 %>">
							<a href="/shopping/category_prd.asp?itemid=<%= group2item3 %>&pEtr=81815" target="_blank">
								<div class="pdtPhoto"><img src="<%= group2item3img %>" alt="" /></div>
								<p class="name"><%= group2item3name %></p>
								<p class="price"><span></span></p>
							</a>
						</li>
						<li class="code<%= group2item4 %>">
							<a href="/shopping/category_prd.asp?itemid=<%= group2item4 %>&pEtr=81815" target="_blank">
								<div class="pdtPhoto"><img src="<%= group2item4img %>" alt="" /></div>
								<p class="name"><%= group2item4name %></p>
								<p class="price"><span></span></p>
							</a>
						</li>
						<li class="code<%= group2item5 %>">
							<a href="/shopping/category_prd.asp?itemid=<%= group2item5 %>&pEtr=81815" target="_blank">
								<div class="pdtPhoto"><img src="<%= group2item5img %>" alt="" /></div>
								<p class="name"><%= group2item5name %></p>
								<p class="price"><span></span></p>
							</a>
						</li>
						<li class="code<%= group2item6 %>">
							<a href="/shopping/category_prd.asp?itemid=<%= group2item6 %>&pEtr=81815" target="_blank">
								<div class="pdtPhoto"><img src="<%= group2item6img %>" alt="" /></div>
								<p class="name"><%= group2item6name %></p>
								<p class="price"><span></span></p>
							</a>
						</li>
					</ul>
				</div>
			</div>
		</div>

		<!-- 3.여럿이 즐겁게 -->
		<div id="many" class="section">
			<div class="represent">
				<ul class="inner">
					<li class="pdt1"><a href="/shopping/category_prd.asp?itemid=1759875&pEtr=81815" target="_blank"><i></i><span class="left" style="margin-top:-25px;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_rep_many_1.png" alt="blanket" /></span></a></li>
					<li class="pdt2"><a href="/shopping/category_prd.asp?itemid=1829889&pEtr=81815" target="_blank"><i></i><span class="left" style="margin-top:-25px;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_rep_many_2.png" alt="tree" /></span></a></li>
					<li class="pdt3"><a href="/shopping/category_prd.asp?itemid=1617876&pEtr=81815" target="_blank"><i></i><span class="left" style="margin-top:-25px;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_rep_many_3.png" alt="crown" /></span></a></li>
					<li class="pdt4"><a href="/shopping/category_prd.asp?itemid=1823627&pEtr=81815" target="_blank"><i></i><span class="top" style="margin-left:-57px;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_rep_many_4.png" alt="wreath" /></span></a></li>
					<li class="pdt5"><a href="/shopping/category_prd.asp?itemid=1607164&pEtr=81815" target="_blank"><i></i><span class="right"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_rep_many_5.png" alt="deco" /></span></a></li>
					<li class="pdt6"><a href="/shopping/category_prd.asp?itemid=1696297&pEtr=81815" target="_blank"><i></i><span class="top" style="margin-left:-55px;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_rep_many_6.png" alt="deco" /></span></a></li>
					<li class="pdt7"><a href="/shopping/category_prd.asp?itemid=1607129&pEtr=81815" target="_blank"><i></i><span class="left"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_rep_many_7.png" alt="cup" /></span></a></li>
					<li class="pdt8"><a href="/shopping/category_prd.asp?itemid=1384659&pEtr=81815" target="_blank"><i></i><span class="left"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_rep_many_8.png" alt="tree" /></span></a></li>
					<li class="pdt9"><a href="/shopping/category_prd.asp?itemid=1822917&pEtr=81815" target="_blank"><i></i><span class="bottom" style="margin-left:-53px;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_rep_many_9.png" alt="deco" /></span></a></li>
				</ul>
			</div>
			<div class="inner">
				<div class="num"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_num_3.png" alt="3" /></div>
				<ul class="navigation">
					<li><a href="#alone">혼자서 여유롭게</a></li>
					<li><a href="#couple">둘이서 오붓하게</a></li>
					<li><a href="#many">여럿이 즐겁게</a></li>
				</ul>
				<div class="story">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_story_3.png" alt="편한 사람들과 가장 편안한 모습으로 조금은 시끌벅적한 크리스마스를 즐겨요. 맛있는 음식을 나누고, 소소한 이야기를 나누며 오래도록 간직할 추억거리를 하나 더 쌓아 보세요. " /></p>
					<a href="/event/eventmain.asp?eventid=81819" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/btn_more_3.png" alt="상품 더 보기" /></a>
				</div>
				<div class="items">
					<ul>
						<li class="code<%= group3item1 %>">
							<a href="/shopping/category_prd.asp?itemid=<%= group3item1 %>&pEtr=81815" target="_blank">
								<div class="pdtPhoto"><img src="<%= group3item1img %>" alt="" /></div>
								<p class="name"><%= group3item1name %></p>
								<p class="price"><span></span></p>
							</a>
						</li>
						<li class="code<%= group3item2 %>">
							<a href="/shopping/category_prd.asp?itemid=<%= group3item2 %>&pEtr=81815" target="_blank">
								<div class="pdtPhoto"><img src="<%= group3item2img %>" alt="" /></div>
								<p class="name"><%= group3item2name %></p>
								<p class="price"><span></span></p>
							</a>
						</li>
						<li class="code<%= group3item3 %>">
							<a href="/shopping/category_prd.asp?itemid=<%= group3item3 %>&pEtr=81815" target="_blank">
								<div class="pdtPhoto"><img src="<%= group3item3img %>" alt="" /></div>
								<p class="name"><%= group3item3name %></p>
								<p class="price"><span></span></p>
							</a>
						</li>
						<li class="code<%= group3item4 %>">
							<a href="/shopping/category_prd.asp?itemid=<%= group3item4 %>&pEtr=81815" target="_blank">
								<div class="pdtPhoto"><img src="<%= group3item4img %>" alt="" /></div>
								<p class="name"><%= group3item4name %></p>
								<p class="price"><span></span></p>
							</a>
						</li>
						<li class="code<%= group3item5 %>">
							<a href="/shopping/category_prd.asp?itemid=<%= group3item5 %>&pEtr=81815" target="_blank">
								<div class="pdtPhoto"><img src="<%= group3item5img %>" alt="" /></div>
								<p class="name"><%= group3item5name %></p>
								<p class="price"><span></span></p>
							</a>
						</li>
						<li class="code<%= group3item6 %>">
							<a href="/shopping/category_prd.asp?itemid=<%= group3item6 %>&pEtr=81815" target="_blank">
								<div class="pdtPhoto"><img src="<%= group3item6img %>" alt="" /></div>
								<p class="name"><%= group3item6name %></p>
								<p class="price"><span></span></p>
							</a>
						</li>
					</ul>
				</div>
			</div>
		</div>

		<!-- 연동 이벤트 -->
		<div class="christmas-event">
			<div class="inner">
				<ul>
					<li class="bnr1 hover"><a href="/event/eventmain.asp?eventid=81823" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/bnr_special.jpg" alt="01 SPECIAL" /></a></li>
					<li class="bnr2"><a href="/event/eventmain.asp?eventid=81820" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/bnr_alone.jpg" alt="02 ALONE" /></a></li>
					<li class="bnr3"><a href="/event/eventmain.asp?eventid=81821" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/bnr_couple.jpg" alt="03 COUPLE" /></a></li>
					<li class="bnr4"><a href="/event/eventmain.asp?eventid=81822" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/bnr_message.jpg" alt="04 MESSAGE" /></a></li>
				</ul>
			</div>
		</div>

		<!-- 크리스마스 아이템 -->
		<div class="christmas-item">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/tit_item.png" alt="Christmas Item" /></h3>
			<ul class="type">
				<li class="type1" id="type1li" ><input type="radio" id="type1" name="bestitemlist" value="type1" /><label for="type1"onclick="bestitemlist('type1','224155'); return false; " ><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_type_1.jpg" alt="조명" /></label></li>
				<li class="type2" id="type2li"><input type="radio" id="type2" name="bestitemlist" value="type2"  /><label for="type2"onclick="bestitemlist('type2','224156');return false; "><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_type_2.jpg" alt="트리,리스" /></label></li>
				<li class="type3" id="type3li"><input type="radio" id="type3" name="bestitemlist" value="type3" /><label for="type3" onclick="bestitemlist('type3','224157');return false; "><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_type_3.jpg" alt="오너먼트" /></label></li>
				<li class="type4" id="type4li"><input type="radio" id="type4" name="bestitemlist" value="type4"/><label for="type4" onclick="bestitemlist('type4','224158');return false; " ><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_type_4.jpg" alt="캔들,디퓨저" /></label></li>
				<li class="type5" id="type5li"><input type="radio" id="type5" name="bestitemlist" value="type5" /><label for="type5" onclick="bestitemlist('type5','224159');return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_type_5.jpg" alt="선물" /></label></li>
				<li class="type6" id="type6li"><input type="radio" id="type6" name="bestitemlist" value="type6" /><label for="type6" onclick="bestitemlist('type6','224160');return false; "><img src="http://webimage.10x10.co.kr/eventIMG/2017/81815/txt_type_6.jpg" alt="카드" /></label></li>
			</ul>
			<%'best 상품 리스트 영역 %>
			<div class="pdtWrap" id="ajaxlist"></div>

		</div>
	</div>
	<!--// 2017 크리스마스 기획전 -->
<!-- #include virtual="/lib/db/dbclose.asp" -->
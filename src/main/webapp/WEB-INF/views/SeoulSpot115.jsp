<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>SeoulSpot115</title>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=9ade7672753121e728b8c8e50142aa27&libraries=services,clusterer,drawing"></script>
	
    <style>
		* {
		    margin: 0;
		    padding: 0;
		    box-sizing: border-box;
		}    	
		.area {
		    position: absolute;
		    background: #fff;
		    border: 1px solid #888;
		    border-radius: 10px;
		    font-size: 12px;
		    top: 0px;
		    left: 0px;
		    padding: 5px;
		}
		.radio {		
			margin: 0px 3px 0px 5px;
			width: 13px;
			height: 13px;
			vertical-align: -2px;
		}
		td {
			padding: 2px 1px 2px 1px;
		}
		td:hover {
			font-weight: 700;
			background-color: #F0FFFF;
		}
		td:has(input[type="radio"]:checked) {
			background-color: #F0FFF0;
		}
	</style>	
	
</head>
<body>

	<%-- 
	<div style="position:relative;width:1000px;background-color:#FFFF00;">
		<table border="1">
			<tr>
				<th colspan="12">세부 도로소통현황</th>
			</tr>
			<tr>
				<th>도로구간 LINK ID</th>
				<th>도로명</th>
				<th>도로노드시작지점 코드</th>
				<th>도로노드시작명</th>
				<th>도로노드시작지점좌표</th>
				<th>도로노드종료지점 코드</th>
				<th>도로노드종료명</th>
				<th>도로노드종료지점좌표</th>
				<th>도로구간길이</th>
				<th>도로구간평균속도</th>
				<th>도로구간소통지표</th>
				<th>링크아이디 좌표(보간점)</th>
			</tr>
			<c:forEach items="${roadList }" var="dto">
				<tr>
					<td>${dto.linkId }</td>
					<td>${dto.roadNm }</td>
					<td>${dto.startNdCd }</td>
					<td>${dto.startNdNm }</td>
					<td>${dto.startNdXy }</td>
					<td>${dto.endNdCd }</td>
					<td>${dto.endNdNm }</td>
					<td>${dto.endNdXy }</td>
					<td>${dto.dist }</td>
					<td>${dto.spd }</td>
					<td>${dto.idx }</td>
					<td>${dto.xyList }</td>					
				</tr>
			</c:forEach>
		</table>	
	</div>  
	--%>

	<div style="display:flex;justify-content:center;align-items:center;">
	 
		<div style="position:relative;width:1800px;text-align:center;">
	 		
	 		<h3 style="margin:30px 0px 30px 0px;">서울 실시간 도시데이터 - 주요 115 장소</h3>
	 			
				<form action="SeoulSpot115" method="get">
		
			 		<div style="display:inline-flex;flex-direction:row;justify-content:space-between;
			 					position:relative;width:1750px;margin:0px 0px 30px 0px;">
				
						<div style="position:relative;text-align:left;font-size:12px;">
							<table border="1">
								<tr><th colspan="1" style="text-align:center;background-color:#F0FFFF;">관광특구</th></tr>
								<tr><td><input type="radio" class="radio" name="area" value="POI001" />1. 강남 MICE 관광특구</td></tr>
								<tr><td><input type="radio" class="radio" name="area" value="POI002" />2. 동대문 관광특구</td></tr>
								<tr><td><input type="radio" class="radio" name="area" value="POI003" />3. 명동 관광특구</td></tr>
								<tr><td><input type="radio" class="radio" name="area" value="POI004" />4. 이태원 관광특구</td></tr>								
								<tr><td><input type="radio" class="radio" name="area" value="POI005" />5. 잠실 관광특구</td></tr>
								<tr><td><input type="radio" class="radio" name="area" value="POI006" />6. 종로·청계 관광특구</td></tr>								
								<tr><td><input type="radio" class="radio" name="area" value="POI007" />7. 홍대 관광특구</td></tr>
							</table>
						</div>
						
						<div style="position:relative;text-align:left;font-size:12px;">
							<table border="1">
								<tr><th colspan="1" style="text-align:center;background-color:#F0FFFF;">고궁·문화유산</th></tr>
								<tr><td><input type="radio" class="radio" name="area" value="POI008" />8. 경복궁</td></tr>
								<tr><td><input type="radio" class="radio" name="area" value="POI009" />9. 광화문·덕수궁</td></tr>
								<tr><td><input type="radio" class="radio" name="area" value="POI010" />10. 보신각</td></tr>
								<tr><td><input type="radio" class="radio" name="area" value="POI011" />11. 서울 암사동 유적</td></tr>
								<tr><td><input type="radio" class="radio" name="area" value="POI012" />12. 창덕궁·종묘</td></tr>
							</table>
						</div>
						
						<div style="position:relative;text-align:left;font-size:12px;">
							<table border="1">
								<tr>
									<th colspan="4" style="text-align:center;background-color:#F0FFFF;">인구밀집지역</th>
								</tr>
								<tr>
									<td><input type="radio" class="radio" name="area" value="POI013" />13. 가산디지털단지역</td>
									<td><input type="radio" class="radio" name="area" value="POI014" />14. 강남역</td>
									<td><input type="radio" class="radio" name="area" value="POI015" />15. 건대입구역</td>
								</tr>
								<tr>
									<td><input type="radio" class="radio" name="area" value="POI016" />16. 고덕역</td>								
									<td><input type="radio" class="radio" name="area" value="POI017" />17. 고속터미널역</td>								
									<td><input type="radio" class="radio" name="area" value="POI018" />18. 교대역</td>						
								</tr>
								<tr>
									<td><input type="radio" class="radio" name="area" value="POI019" />19. 구로디지털단지역</td>								
									<td><input type="radio" class="radio" name="area" value="POI020" />20. 구로역</td>								
									<td><input type="radio" class="radio" name="area" value="POI021" />21. 군자역</td>
								</tr>
								<tr>
									<td><input type="radio" class="radio" name="area" value="POI022" />22. 남구로역</td>									
									<td><input type="radio" class="radio" name="area" value="POI023" />23. 대림역</td>
									<td><input type="radio" class="radio" name="area" value="POI024" />24. 동대문역</td>
								</tr>
								<tr>	
									<td><input type="radio" class="radio" name="area" value="POI025" />25. 뚝섬역</td>
									<td><input type="radio" class="radio" name="area" value="POI026" />26. 미아사거리역</td>								
									<td><input type="radio" class="radio" name="area" value="POI027" />27. 발산역</td>								
								</tr>
								<tr>
									<td><input type="radio" class="radio" name="area" value="POI028" />28. 북한산우이역</td>								
									<td><input type="radio" class="radio" name="area" value="POI029" />29. 사당역</td>
									<td><input type="radio" class="radio" name="area" value="POI030" />30. 삼각지역</td>
								</tr>
								<tr>
									<td><input type="radio" class="radio" name="area" value="POI031" />31. 서울대입구역</td>
									<td><input type="radio" class="radio" name="area" value="POI032" />32. 서울식물원·마곡나루역</td>								
									<td><input type="radio" class="radio" name="area" value="POI033" />33. 서울역</td>			
								</tr>
								<tr>					
									<td><input type="radio" class="radio" name="area" value="POI034" />34. 선릉역</td>
									<td><input type="radio" class="radio" name="area" value="POI035" />35. 성신여대입구역</td>
									<td><input type="radio" class="radio" name="area" value="POI036" />36. 수유역</td>
								</tr>
								<tr>
									<td><input type="radio" class="radio" name="area" value="POI037" />37. 신논현역·논현역</td>								
									<td><input type="radio" class="radio" name="area" value="POI038" />38. 신도림역</td>
									<td><input type="radio" class="radio" name="area" value="POI039" />39. 신림역</td>															
								</tr>
								<tr>
									<td><input type="radio" class="radio" name="area" value="POI040" />40. 신촌·이대역</td>								
									<td><input type="radio" class="radio" name="area" value="POI041" />41. 양재역</td>
									<td><input type="radio" class="radio" name="area" value="POI042" />42. 역삼역</td>										
								</tr>
								<tr>
									<td><input type="radio" class="radio" name="area" value="POI043" />43. 연신내역</td>
									<td><input type="radio" class="radio" name="area" value="POI044" />44. 오목교역·목동운동장</td>								
									<td><input type="radio" class="radio" name="area" value="POI045" />45. 왕십리역</td>
								</tr>
								<tr>
									<td><input type="radio" class="radio" name="area" value="POI046" />46. 용산역</td>
									<td><input type="radio" class="radio" name="area" value="POI047" />47. 이태원역</td>								
									<td><input type="radio" class="radio" name="area" value="POI048" />48. 장지역</td>
								</tr>
								<tr>
									<td><input type="radio" class="radio" name="area" value="POI049" />49. 장한평역</td>
									<td><input type="radio" class="radio" name="area" value="POI050" />50. 천호역</td>
									<td><input type="radio" class="radio" name="area" value="POI051" />51. 총신대입구(이수)역</td>
								</tr>
								<tr>
									<td><input type="radio" class="radio" name="area" value="POI052" />52. 충정로역</td>								
									<td><input type="radio" class="radio" name="area" value="POI053" />53. 합정역</td>
									<td><input type="radio" class="radio" name="area" value="POI054" />54. 혜화역</td>
								</tr>
								<tr>								
									<td><input type="radio" class="radio" name="area" value="POI055" />55. 홍대입구역(2호선)</td>
									<td><input type="radio" class="radio" name="area" value="POI056" />56. 회기역</td>
									<td></td>
								</tr>					
							</table>
						</div>						
							
						<div style="position:relative;text-align:left;font-size:12px;">
							<table border="1">
								<tr>
									<th colspan="2" style="text-align:center;background-color:#F0FFFF;">발달상권</th>
								</tr>						
								<tr>
									<td><input type="radio" class="radio" name="area" value="POI057" />57. 4·19 카페거리</td>
									<td><input type="radio" class="radio" name="area" value="POI058" />58. 가락시장</td>
								</tr>
								<tr>
									<td><input type="radio" class="radio" name="area" value="POI059" />59. 가로수길</td>								
									<td><input type="radio" class="radio" name="area" value="POI060" />60. 광장(전통)시장</td>
								</tr>
								<tr>
									<td><input type="radio" class="radio" name="area" value="POI061" />61. 김포공항</td>								
									<td><input type="radio" class="radio" name="area" value="POI062" />62. 낙산공원·이화마을</td>
								</tr>
								<tr>
									<td><input type="radio" class="radio" name="area" value="POI063" />63. 노량진</td>								
									<td><input type="radio" class="radio" name="area" value="POI064" />64. 덕수궁길·정동길</td>								
								</tr>
								<tr>
									<td><input type="radio" class="radio" name="area" value="POI065" />65. 방배역 먹자골목</td>								
									<td><input type="radio" class="radio" name="area" value="POI066" />66. 북촌한옥마을</td>
								</tr>
								<tr>								
									<td><input type="radio" class="radio" name="area" value="POI067" />67. 서촌</td>
									<td><input type="radio" class="radio" name="area" value="POI068" />68. 성수카페거리</td>
								</tr>
								<tr>
									<td><input type="radio" class="radio" name="area" value="POI069" />69. 수유리 먹자골목</td>
									<td><input type="radio" class="radio" name="area" value="POI070" />70. 쌍문동 맛집거리</td>																
								</tr>
								<tr>
									<td><input type="radio" class="radio" name="area" value="POI071" />71. 압구정로데오거리</td>								
									<td><input type="radio" class="radio" name="area" value="POI072" />72. 여의도</td>		
								</tr>
								<tr>						
									<td><input type="radio" class="radio" name="area" value="POI073" />73. 연남동</td>
									<td><input type="radio" class="radio" name="area" value="POI074" />74. 영등포 타임스퀘어</td>
								</tr>		
								<tr>
									<td><input type="radio" class="radio" name="area" value="POI075" />75. 외대앞</td>
									<td><input type="radio" class="radio" name="area" value="POI076" />76. 용리단길</td>								
								</tr>
								<tr>								
									<td><input type="radio" class="radio" name="area" value="POI077" />77. 이태원 앤틱가구거리</td>								
									<td><input type="radio" class="radio" name="area" value="POI078" />78. 인사동·익선동</td>
								</tr>
								<tr>
									<td><input type="radio" class="radio" name="area" value="POI079" />79. 창동 신경제 중심지</td>
									<td><input type="radio" class="radio" name="area" value="POI080" />80. 청담동 명품거리</td>
								</tr>	
								<tr>
									<td><input type="radio" class="radio" name="area" value="POI081" />81. 청량리 제기동 일대 전통시장</td>								
									<td><input type="radio" class="radio" name="area" value="POI082" />82. 해방촌·경리단길</td>
								</tr>
								<tr>							
									<td><input type="radio" class="radio" name="area" value="POI083" />83. DDP(동대문디자인플라자)</td>								
									<td><input type="radio" class="radio" name="area" value="POI084" />84. DMC(디지털미디어시티)</td>	
								</tr>
								<tr>								
									<td><input type="radio" class="radio" name="area" value="POI114" />85. 북창동 먹자골목</td>
									<td><input type="radio" class="radio" name="area" value="POI115" />86. 남대문시장</td>
								</tr>											
							</table>
						</div>
							
						<div style="position:relative;text-align:left;font-size:12px;">
							<table border="1">
								<tr>
									<th colspan="2" style="text-align:center;background-color:#F0FFFF;">공원</th>
								</tr>
								<tr>
									<td><input type="radio" class="radio" name="area" value="POI085" />87. 강서한강공원</td>
									<td><input type="radio" class="radio" name="area" value="POI086" />88. 고척돔</td>
								</tr>
								<tr>
									<td><input type="radio" class="radio" name="area" value="POI087" />89. 광나루한강공원</td>								
									<td><input type="radio" class="radio" name="area" value="POI088" />90. 광화문광장</td>	
								</tr>
								<tr>
									<td><input type="radio" class="radio" name="area" value="POI089" />91. 국립중앙박물관·용산가족공원</td>								
									<td><input type="radio" class="radio" name="area" value="POI090" />92. 난지한강공원</td>
								</tr>
								<tr>
									<td><input type="radio" class="radio" name="area" value="POI091" />93. 남산공원</td>								
									<td><input type="radio" class="radio" name="area" value="POI092" />94. 노들섬</td>								
								</tr>
								<tr>
									<td><input type="radio" class="radio" name="area" value="POI093" />95. 뚝섬한강공원</td>								
									<td><input type="radio" class="radio" name="area" value="POI094" />96. 망원한강공원</td>
								</tr>
								<tr>								
									<td><input type="radio" class="radio" name="area" value="POI095" />97. 반포한강공원</td>
									<td><input type="radio" class="radio" name="area" value="POI096" />98. 북서울꿈의숲</td>									
								</tr>
								<tr>
									<td><input type="radio" class="radio" name="area" value="POI097" />99. 불광천</td>
									<td><input type="radio" class="radio" name="area" value="POI098" />100. 서리풀공원·몽마르뜨공원</td>								
								</tr>
								<tr>
									<td><input type="radio" class="radio" name="area" value="POI099" />101. 서울광장</td>								
									<td><input type="radio" class="radio" name="area" value="POI100" />102. 서울대공원</td>
								</tr>
								<tr>								
									<td><input type="radio" class="radio" name="area" value="POI101" />103. 서울숲공원</td>
									<td><input type="radio" class="radio" name="area" value="POI102" />104. 아차산</td>
								</tr>
								<tr>
									<td><input type="radio" class="radio" name="area" value="POI103" />105. 양화한강공원</td>
									<td><input type="radio" class="radio" name="area" value="POI104" />106. 어린이대공원</td>								
								</tr>
								<tr>								
									<td><input type="radio" class="radio" name="area" value="POI105" />107. 여의도한강공원</td>								
									<td><input type="radio" class="radio" name="area" value="POI106" />108. 월드컵공원</td>
								</tr>
								<tr>
									<td><input type="radio" class="radio" name="area" value="POI107" />109. 응봉산</td>
									<td><input type="radio" class="radio" name="area" value="POI108" />110. 이촌한강공원</td>
								</tr>
								<tr>
									<td><input type="radio" class="radio" name="area" value="POI109" />111. 잠실종합운동장</td>								
									<td><input type="radio" class="radio" name="area" value="POI110" />112. 잠실한강공원</td>
								</tr>
								<tr>				
									<td><input type="radio" class="radio" name="area" value="POI111" />113. 잠원한강공원</td>									
									<td><input type="radio" class="radio" name="area" value="POI112" />114. 청계산</td>		
								</tr>
								<tr>							
									<td><input type="radio" class="radio" name="area" value="POI113" />115. 청와대</td>
									<td></td>
								</tr>
							</table>
						</div>						
					
	 				</div>
	 				
				</form>
	 	 
			<div style="display:flex;justify-content:center;
						position:relative;width:1800px;height:700px;margin:0px 0px 30px 0px;">
			
				<div style="position:relative;width:1000px;height:100%;">
					<div id="map" 
						 style="position:relative;width:1000px;height:100%;text-align:left;">
					</div>
				</div>
			
				<div style="position:relative;width:750px;height:100%;">

					<div style="position:relative;width:750px;">
						<div style="position:relative;left:50%;transform:translate(-50%,0%);
									width:735px;font-size:12px;margin:0px 0px 20px 0px;">
							<table border="1" width="735px">
								<tr>
									<th colspan="2" style="background-color:#F0FFFF;">장소</th>
								</tr>
								<tr>
									<td>장소명</td>
									<td>${areaNm }</td>
								</tr>
								<tr>
									<td>장소 혼잡도 지표</td>
									<td>${areaCongestLvl }</td>
								</tr>
								<tr>
									<td>장소 혼잡도 지표 관련 메세지</td>
									<td>${areaCongestMsg }</td>
								</tr>						
							</table>
						</div>		
					</div>
				
	 				<div style="position:relative;width:750px;">
	 					<div style="position:relative;left:50%;transform:translate(-50%,0%);
	 								width:735px;font-size:12px;margin:0px 0px 20px 0px;">
							<table border="1" width="735px">
								<tr>
									<th colspan="2" style="background-color:#F0FFFF;">도로소통현황</th>
								</tr>
								<tr>
									<td>도로소통현황 업데이트 시간</td>
									<td>${roadTrfficTime }</td>
								</tr>			
								<tr>
									<td>전체도로소통평균현황</td>
									<td>${roadTrafficIdx }</td>
								</tr>
								<tr>
									<td>전체도로소통평균현황 메세지</td>
									<td>${roadMsg }</td>
								</tr>
								<tr>
									<td>전체도로소통평균속도</td>
									<td>${roadTrafficSpd } km/h</td>
								</tr>						
							</table>	
						</div>	
					</div>
					
					<div style="position:relative;width:750px;">
						
						<div style="position:relative;left:50%;transform:translate(-50%,0%);width:740px;">
						
							<div style="display:inline-flex;flex-direction:column;position:relative;width:430px;">
							
								<div style="position:relative;width:430px;font-size:12px;margin:0px 0px 20px 0px;">
									<table border="1" width="430px">
										<tr>
											<th colspan="2" style="background-color:#F0FFFF;">실시간 인구 데이터</th>
										</tr>
										<tr>
											<td>실시간 인구 데이터 업데이트 시간</td>
											<td>${ppltnTime }</td>
										</tr>
										<tr>
											<td>실시간 인구 지표</td>
											<td>${areaPpltnMin } ~ ${areaPpltnMax }</td>
										</tr>							
									</table>				
								</div>
								
								<div style="position:relative;width:430px;font-size:12px;margin:0px 0px 20px 0px;">
									<table border="1" width="430px">
										<tr>
											<th colspan="3" style="background-color:#F0FFFF;">인구 예측값</th>
										</tr>
										<tr>
											<th>예측시점</th>
											<th>장소 혼잡도 지표</th>
											<!--
											<th>예측 실시간 인구 지표 최소값</th>
											<th>예측 실시간 인구 지표 최대값</th> 
											-->
											<th>실시간 인구 지표</th>
										</tr>
										<c:forEach items="${fcstList }" var="dto">
											<tr>
												<td>${dto.fcstTime }</td>
												<td>${dto.fcstCongestLvl }</td>
																
												<%-- 											
												<td>${dto.fcstPpltnMin }</td>
												<td>${dto.fcstPpltnMax }</td>  
												--%>
												
												<td>${dto.fcstPpltnMin } ~ ${dto.fcstPpltnMax }</td>
											</tr>
										</c:forEach>
									</table>				
								</div>
								
							</div>
						
 		 					<div style="display:inline-flex;flex-direction:column;position:relative;width:300px;">
						
								<div style="position:relative;width:300px;font-size:12px;margin:0px 0px 20px 0px;">
									<table border="1" width="300px">
										<tr>
											<th colspan="2" style="background-color:#F0FFFF;">연령 - 실시간 인구 비율</th>
										</tr>
										<tr>
											<td>0~10세 실시간 인구 비율</td>
											<td>${ppltnRate0 }</td>
										</tr>
										<tr>
											<td>10대 실시간 인구 비율</td>
											<td>${ppltnRate10 }</td>
										</tr>	
										<tr>
											<td>20대 실시간 인구 비율</td>
											<td>${ppltnRate20 }</td>
										</tr>	
										<tr>
											<td>30대 실시간 인구 비율</td>
											<td>${ppltnRate30 }</td>
										</tr>	
										<tr>
											<td>40대 실시간 인구 비율</td>
											<td>${ppltnRate40 }</td>
										</tr>	
										<tr>
											<td>50대 실시간 인구 비율</td>
											<td>${ppltnRate50 }</td>
										</tr>
										<tr>
											<td>60대 실시간 인구 비율</td>
											<td>${ppltnRate60 }</td>
										</tr>
										<tr>
											<td>70대 실시간 인구 비율</td>
											<td>${ppltnRate70 }</td>
										</tr>																								
									</table>					
								</div>
								
								<div style="position:relative;width:300px;font-size:12px;margin:0px 0px 20px 0px;">
									<table border="1" width="300px">
										<tr>
											<th colspan="2" style="background-color:#F0FFFF;">성별 - 실시간 인구 비율</th>
										</tr>
										<tr>
											<td>남성 인구 비율</td>
											<td>${malePpltnRate }</td>
										</tr>
										<tr>
											<td>여성 인구 비율</td>
											<td>${femalePpltnRate }</td>
										</tr>		
									</table>								
								</div>
						
								<div style="position:relative;width:300px;font-size:12px;margin:0px 0px 20px 0px;">
									<table border="1" width="300px">
										<tr>
											<th colspan="2" style="background-color:#F0FFFF;">상주 여부 - 실시간 인구 비율</th>
										</tr>
										<tr>
											<td>상주 인구 비율</td>
											<td>${resntPpltnRate }</td>	
										</tr>
										<tr>
											<td>비상주 인구 비율</td>
											<td>${nonResntPpltnRate }</td>	
										</tr>		
									</table>								
								</div>
						
							</div>					
							
						</div>
					
					</div>
					
				</div>
				
			</div>
		
		</div>
		
		<script>
		
			window.addEventListener('DOMContentLoaded', function() {
				// 장소 선택
				var areaValue = "${area_cd}";
				console.log("areaValue: ", areaValue);
				if (areaValue) {
					var areaSelector = 'input[name="area"][value=\"' + areaValue + '\"]';
					var areaInput = document.querySelector(areaSelector);
					console.log("areaInput: ", areaInput);
					if (areaInput) {
						areaInput.checked = true;
					}
				}
			});			
		
			// HTML 코드에서 input 태그를 클릭하면 자동으로 submit이 실행되도록 하는 JavaScript 코드
			// 모든 input 요소 선택
			const inputs = document.querySelectorAll('input[type="radio"]');
			// 각 input 요소에 클릭 이벤트 리스너 추가
			inputs.forEach(function(input) {
				input.addEventListener('click', function() {
					// 클릭 이벤트가 발생하면, input.closest('form')을 사용하여, 
					// 해당 input 요소의 가장 가까운 조상 <form> 요소를 찾고,
					// 폼 요소 가져오기
					const form = input.closest('form');
					// 폼 제출
					form.submit();
				});
			});			
			
			var coordinateLatitude = ${coordinateLatitude};
			var coordinateLongitude = ${coordinateLongitude}; 
			
			// 지도를 담을 영역의 DOM 레퍼런스
			var mapContainer = document.getElementById('map');
			
			// 지도를 생성할 때 필요한 기본 옵션
			var mapOption = { 
				// 지도의 중심좌표, 생성인자는 위도(latitude), 경도(longitude) 순으로 넣어주세요.
				center: new kakao.maps.LatLng(coordinateLatitude, coordinateLongitude),
				// 지도의 레벨(확대, 축소 정도)
				level: 5 
			};
			
			// 지도 생성 및 객체 리턴
			var map = new kakao.maps.Map(mapContainer, mapOption); 		
			
			var customOverlay = null;
			
			var jsonData = ${json};
			// console.log("jsonData: ", jsonData);			
			
			var jsonObject = JSON.stringify(jsonData);
			
			var jData = JSON.parse(jsonObject);
			
			var obj = null;
			
			var starNode = null;
			var endNode = null;
			
			var starNodeLatitude = new Array();
			var starNodeLongitude = new Array();			
			
			// XYLIST - 링크아이디 좌표(보간점)
			// var xyListNodeLatitude = new Array();
			// var xyListNodeLongitude = new Array();				
			
			var endNodeLatitude = new Array();
			var endNodeLongitude = new Array();			
			
			var linePath = null;
			var lineColor = null;
			
			var polyline = null;;
			
			var positions = new Array();
			
			for (var i = 0; i < jData.length; i++) {
				
				obj = jData[i];
				
				starNode =  obj.START_ND_XY;
				// console.log("starNode: ", starNode);

				[starNodeLongitude[i], starNodeLatitude[i]] = starNode.split("_");
				// console.log("starNodeLatitude: ", starNodeLatitude);
				// console.log("starNodeLongitude: ", starNodeLongitude);
				
				// XYLIST - 링크아이디 좌표(보간점)
				// var xyList = obj.XYLIST;
				// console.log("xyList: ", xyList);
				// var xyList2 = new Array(); 
				// xyList2 = xyList.split("|");
				// console.log("xyList2: ", xyList2);
				// xyListNodeLatitude = [];
				// xyListNodeLongitude = [];				
				// var xyNode = ""; 
				
				// XYLIST - 링크아이디 좌표(보간점)
				/*
				for (var j = 0; j < xyList2.length; j++) {
					xyNode = xyList2[j];
					// console.log("xyNode: ", xyNode);
					[xyListNodeLongitude[j], xyListNodeLatitude[j]] = xyNode.split("_");
				}; 
				*/
				// console.log("xyListNodeLatitude: ", xyListNodeLatitude);
				// console.log("xyListNodeLongitude: ", xyListNodeLongitude);				
				
				
				endNode =  obj.END_ND_XY;
				// console.log("endNode: ", endNode);

				[endNodeLongitude[i], endNodeLatitude[i]] = endNode.split("_");
				// console.log("endNodeLatitude: ", endNodeLatitude);
				// console.log("endNodeLongitude: ", endNodeLongitude);
				
				//선을 구성하는 좌표 배열입니다. 이 좌표들을 이어서 선을 표시합니다
				linePath = [];
				
				// START_ND_XY - 도로노드시작지점좌표
				linePath.push(new kakao.maps.LatLng(starNodeLatitude[i], starNodeLongitude[i]));
				
				// XYLIST - 링크아이디 좌표(보간점)
				/*  
				for (var k = 0; k < xyListNodeLatitude.length; k++) {
					linePath.push(new kakao.maps.LatLng(xyListNodeLatitude[k], xyListNodeLongitude[k]));
				}; 
				*/
				
				// END_ND_XY - 도로노드종료지점좌표
				linePath.push(new kakao.maps.LatLng(endNodeLatitude[i], endNodeLongitude[i]));
				
				// console.log("linePath: ", linePath);
				
				// 노선 색 구분 - "원활", "서행", "정체"
				lineColor = "";
				
				if (obj.IDX == "원활") {
					lineColor = "#008000";
				} else if (obj.IDX == "서행") {
					lineColor = "#FFA500";
				} else if (obj.IDX == "정체") {
					lineColor = "#FF0000";
				};
				
				// 지도에 표시할 선을 생성합니다.
				polyline = new kakao.maps.Polyline({
					map: map,
					// 선을 구성하는 좌표배열 입니다.
				    path: linePath, 
				 	// 선의 두께 입니다.
				    strokeWeight: 4, 
				 	// 선의 색깔입니다.
				    strokeColor: lineColor,
				 	// 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다.
				    strokeOpacity: 0.5,
				 	// 선의 스타일입니다.
				    strokeStyle: 'solid', 
				});

				// 지도에 선을 표시합니다 
				// polyline.setMap(map);  
				
				// 커스텀 오버레이에 표시할 내용입니다     
				// HTML 문자열 또는 Dom Element 입니다 
				 
				var x = Math.abs(starNodeLatitude[i] - endNodeLatitude[i]) / 2;
				precisionX = Number(x.toPrecision(17));
				// console.log("precisionX: " + precisionX);
				x2 = Number(starNodeLatitude[i]) + Number(precisionX);
				// console.log("x2: " + x2);
				
				var y = Math.abs(starNodeLongitude[i] - endNodeLongitude[i]) / 2;
				precisionY = Number(y.toPrecision(17));				
				// console.log("precisionY: " + precisionY);
				y2 = Number(starNodeLongitude[i]) + Number(precisionY);
				// console.log("y2: " + y2); 
				
				var z = '<div class ="area">' +
				  		'<div>도로명: ' + obj.ROAD_NM + '</div>' +
				  		'<div>도로노드시작명: ' + obj.START_ND_NM + '</div>' +
				  		'<div>도로노드종료명: ' + obj.END_ND_NM + '</div>' +
				  		'<div>도로구간길이: ' + obj.DIST + '(m)</div>' +
				  		'<div>도로구간평균속도: ' + obj.SPD + '(km/h)</div>' +
				  		'<div>도로구간소통지표: ' + obj.IDX + '</div>' +
						'</div>';
				
				var a = {
					content: z,
					position: new kakao.maps.LatLng(x2, y2)
				};
				
				positions.push(a);
				// console.log("positions: " + positions);
				   
				// 커스텀 오버레이를 생성합니다
				customOverlay = new kakao.maps.CustomOverlay({
				    content: positions[i].content, 
					position: positions[i].position
				});
				
			    // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
			    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
			    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
				kakao.maps.event.addListener(polyline, 'mouseover', makeOverListener(map, polyline, customOverlay));
				kakao.maps.event.addListener(polyline, 'mouseout', makeOutListener(map, polyline, customOverlay));
				
			}
 
			// 커스텀 오버레이를 표시하는 클로저를 만드는 함수입니다 
			function makeOverListener(map, polyline, customOverlay) {
			    return function() {
			    	polyline.setOptions({strokeWeight: 6});
			    	polyline.setOptions({strokeOpacity: 0.7});
					customOverlay.setMap(map);
			    };
			}			

			// 커스텀 오버레이를 닫는 클로저를 만드는 함수입니다 
			function makeOutListener(map, polyline, customOverlay) {
			    return function() {
			    	polyline.setOptions({strokeWeight: 4});	
			    	polyline.setOptions({strokeOpacity: 0.5});
					customOverlay.setMap(null);
			    };
			}						
			
		</script>	
	
	</div>
	
</body>
</html>
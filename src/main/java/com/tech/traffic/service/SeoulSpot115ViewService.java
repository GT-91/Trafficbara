package com.tech.traffic.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.tech.traffic.dao.TrafficInterfaceDao;
import com.tech.traffic.dto.SeoulSpot115FCST;
import com.tech.traffic.dto.SeoulSpot115Road;

public class SeoulSpot115ViewService implements TrafficInterfaceService {

	private SqlSession sqlSession;	
	
	public SeoulSpot115ViewService(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}	
	
	@Override
	public void execute(Model model) {
		System.out.println("SeoulSpot115ViewService");
		System.out.println("------------------------------");
		
		// Return the current set of model attributes as a Map.
		Map<String, Object> map = model.asMap();		
		
		// request
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		
		// TrafficInterfaceDao, SqlSession 연결		
		TrafficInterfaceDao dao = sqlSession.getMapper(TrafficInterfaceDao.class);
				
		String area_cd = request.getParameter("area");
		System.out.println("area_cd: " + area_cd);
		// null Check
		if(area_cd == null) {
			area_cd = "POI001";
			System.out.println("area_cd: " + area_cd);
		}		
		
		model.addAttribute("area_cd", area_cd);
		
		StringBuilder urlBuilder;
		
		URL url;
		
		HttpURLConnection conn;
		
		// Reads text from a character-input stream, buffering characters so as to provide for the efficient reading of characters, arrays, and lines. 
		BufferedReader rd;	
		
		// java.lang.StringBuilder
		// A mutable sequence of characters. 
		// This class provides an API compatible with StringBuffer, but with no guarantee of synchronization.
		StringBuilder sb = new StringBuilder();		
		
		String line;
		
		try {
			// URL
			urlBuilder = new StringBuilder("http://openapi.seoul.go.kr:8088");
			// 인증키
			urlBuilder.append("/" + URLEncoder.encode("78746471477361633538446a776954", "UTF-8"));
			// 요청 파일 타입 - xml, xmlf, xls, json
			urlBuilder.append("/" + URLEncoder.encode("json", "UTF-8"));
			// 서비스명 (대소문자 구분 필수)
			urlBuilder.append("/" + URLEncoder.encode("citydata", "UTF-8"));
			// 요청 시작 위치
			urlBuilder.append("/" + URLEncoder.encode("1", "UTF-8"));
			// 요청 종료 위치
			urlBuilder.append("/" + URLEncoder.encode("1", "UTF-8"));
			// 상위 5개는 필수적으로 순서 바꾸지 않고 호출해야 된다.
			// 서비스별 추가 요청 인자이며 자세한 내용은 각 서비스별 '요청인자' 부분에 자세히 나와 있다.
			// 서비스별 추가 요청 인자들
			urlBuilder.append("/" + URLEncoder.encode(area_cd, "UTF-8"));
		
			url = new URL(urlBuilder.toString());
		
			conn = (HttpURLConnection) url.openConnection();
		
			conn.setRequestMethod("GET");
		
			conn.addRequestProperty("Content-type", "application/json");
			// 연결 자체에 대한 확인이 필요하므로 추가한다.
			System.out.println("Response code: " + conn.getResponseCode());
		
			// 서비스 코드가 정상이면 200 ~ 300 사이의 숫자가 나온다.
			if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				rd = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
			} else {
				rd = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "UTF-8"));
			}
			
			while ((line = rd.readLine()) != null) {
				sb.append(line);
			}
			
			rd.close();
			conn.disconnect();	
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// String java.lang.StringBuilder.toString()
		// Returns a string containing the characters in this sequence in the same order as this sequence. 
		// The length of the string will be the length of this sequence.
		JsonObject parser = (JsonObject) JsonParser.parseString(sb.toString());		
		// System.out.println(parser);		
	
		// 공통. list_total_count - 총 데이터 건수 (정상조회 시 출력됨)
		int listTotalCount = parser.get("list_total_count").getAsInt();
		System.out.println("공통. list_total_count - 총 데이터 건수 (정상조회 시 출력됨): " + listTotalCount);
	
		// RESULT - 요청결과
		JsonObject result = parser.get("RESULT").getAsJsonObject();
		// System.out.println("RESULT - 요청결과: " + result);
	
		// 공통. RESULT.CODE - 요청결과 코드
		String resultCode =  result.get("RESULT.CODE").getAsString();
		System.out.println("공통. RESULT.CODE - 요청결과 코드: " + resultCode);
	
		// 공통. RESULT.MESSAGE - 요청결과 메시지
		String resultMessage = result.get("RESULT.MESSAGE").getAsString();
		System.out.println("공통. RESULT.MESSAGE - 요청결과 메시지: " + resultMessage);
		
		// CITYDATA - 핫스팟 정보
		JsonObject cityData = parser.get("CITYDATA").getAsJsonObject();
		// System.out.println("CITYDATA - 핫스팟 정보: " + cityData);
		
		// 1. AREA_NM - 핫스팟 장소명
		String areaNm = cityData.get("AREA_NM").getAsString();
		System.out.println("1. AREA_NM - 핫스팟 장소명: " + areaNm);
	
		// ***** model *****
		model.addAttribute("areaNm", areaNm);
		
		// 2. AREA_CD - 핫스팟 코드명
		String areaCd = cityData.get("AREA_CD").getAsString();
		System.out.println("2. AREA_CD - 핫스팟 코드명: " + areaCd);
	
		// 3. LIVE_PPLTN_STTS - 실시간 인구현황
		JsonArray livePpltnStts = cityData.get("LIVE_PPLTN_STTS").getAsJsonArray();
		// System.out.println("3. LIVE_PPLTN_STTS - 실시간 인구현황: " + livePpltnStts);
		// 3. LIVE_PPLTN_STTS - 실시간 인구현황, 형변환 JsonObject
		JsonObject livePpltnSttsToJsonObject = livePpltnStts.get(0).getAsJsonObject();
		// System.out.println("3. LIVE_PPLTN_STTS - 실시간 인구현황: " + livePpltnSttsToJsonObject);
	
		// 4. AREA_CONGEST_LVL - 장소 혼잡도 지표
		String areaCongestLvl = livePpltnSttsToJsonObject.get("AREA_CONGEST_LVL").getAsString();
		System.out.println("4. AREA_CONGEST_LVL - 장소 혼잡도 지표: " + areaCongestLvl);

		// ***** model *****		
		model.addAttribute("areaCongestLvl", areaCongestLvl);
		
		// 5. AREA_CONGEST_MSG - 장소 혼잡도 지표 관련 메세지
		String areaCongestMsg = livePpltnSttsToJsonObject.get("AREA_CONGEST_MSG").getAsString();
		System.out.println("5. AREA_CONGEST_MSG - 장소 혼잡도 지표 관련 메세지: " + areaCongestMsg);
		
		// ***** model *****		
		model.addAttribute("areaCongestMsg", areaCongestMsg);		
		
		// 6. AREA_PPLTN_MIN - 실시간 인구 지표 최소값
		String areaPpltnMin = livePpltnSttsToJsonObject.get("AREA_PPLTN_MIN").getAsString();
		System.out.println("6. AREA_PPLTN_MIN - 실시간 인구 지표 최소값: " + areaPpltnMin);

		// ***** model *****		
		model.addAttribute("areaPpltnMin", areaPpltnMin);		
		
		// 7. AREA_PPLTN_MAX - 실시간 인구 지표 최대값
		String areaPpltnMax = livePpltnSttsToJsonObject.get("AREA_PPLTN_MAX").getAsString();
		System.out.println("7. AREA_PPLTN_MAX - 실시간 인구 지표 최대값: " + areaPpltnMax);

		// ***** model *****		
		model.addAttribute("areaPpltnMax", areaPpltnMax);			
		
		// 8. MALE_PPLTN_RATE - 남성 실시간 인구 비율(남성)
		String malePpltnRate = livePpltnSttsToJsonObject.get("MALE_PPLTN_RATE").getAsString();
		System.out.println("8. MALE_PPLTN_RATE - 남성 실시간 인구 비율(남성): " + malePpltnRate);

		// ***** model *****		
		model.addAttribute("malePpltnRate", malePpltnRate);			
		
		// 9. FEMALE_PPLTN_RATE - 여성 실시간 인구 비율(여성)
		String femalePpltnRate = livePpltnSttsToJsonObject.get("FEMALE_PPLTN_RATE").getAsString();
		System.out.println("9. FEMALE_PPLTN_RATE - 여성 실시간 인구 비율(여성): " + femalePpltnRate);
		
		// ***** model *****		
		model.addAttribute("femalePpltnRate", femalePpltnRate);			
		
		// 10. PPLTN_RATE_0 - 0~10세 실시간 인구 비율
		String ppltnRate0 = livePpltnSttsToJsonObject.get("PPLTN_RATE_0").getAsString();
		System.out.println("10. PPLTN_RATE_0 - 0~10세 실시간 인구 비율: " + ppltnRate0);
		
		// ***** model *****		
		model.addAttribute("ppltnRate0", ppltnRate0);			
		
		// 11. PPLTN_RATE_10 - 10대 실시간 인구 비율
		String ppltnRate10 = livePpltnSttsToJsonObject.get("PPLTN_RATE_10").getAsString();
		System.out.println("11. PPLTN_RATE_10 - 10대 실시간 인구 비율: " + ppltnRate10);		
	
		// ***** model *****		
		model.addAttribute("ppltnRate10", ppltnRate10);			
		
		// 12. PPLTN_RATE_20 - 20대 실시간 인구 비율
		String ppltnRate20 = livePpltnSttsToJsonObject.get("PPLTN_RATE_20").getAsString();
		System.out.println("12. PPLTN_RATE_20 - 20대 실시간 인구 비율: " + ppltnRate20);				
		
		// ***** model *****		
		model.addAttribute("ppltnRate20", ppltnRate20);			
		
		// 13. PPLTN_RATE_30 - 30대 실시간 인구 비율
		String ppltnRate30 = livePpltnSttsToJsonObject.get("PPLTN_RATE_30").getAsString();
		System.out.println("13. PPLTN_RATE_30 - 30대 실시간 인구 비율: " + ppltnRate30);				
		
		// ***** model *****		
		model.addAttribute("ppltnRate30", ppltnRate30);			
		
		// 14. PPLTN_RATE_40 - 40대 실시간 인구 비율
		String ppltnRate40 = livePpltnSttsToJsonObject.get("PPLTN_RATE_40").getAsString();
		System.out.println("14. PPLTN_RATE_40 - 40대 실시간 인구 비율: " + ppltnRate40);		
	
		// ***** model *****		
		model.addAttribute("ppltnRate40", ppltnRate40);				
		
		// 15. PPLTN_RATE_50 - 50대 실시간 인구 비율
		String ppltnRate50 = livePpltnSttsToJsonObject.get("PPLTN_RATE_50").getAsString();
		System.out.println("15. PPLTN_RATE_50 - 50대 실시간 인구 비율: " + ppltnRate50);		

		// ***** model *****		
		model.addAttribute("ppltnRate50", ppltnRate50);			
		
		// 16. PPLTN_RATE_60 - 60대 실시간 인구 비율
		String ppltnRate60 = livePpltnSttsToJsonObject.get("PPLTN_RATE_60").getAsString();
		System.out.println("16. PPLTN_RATE_60 - 60대 실시간 인구 비율: " + ppltnRate60);
		
		// ***** model *****		
		model.addAttribute("ppltnRate60", ppltnRate60);			
		
		// 17. PPLTN_RATE_70 - 70대 실시간 인구 비율
		String ppltnRate70 = livePpltnSttsToJsonObject.get("PPLTN_RATE_70").getAsString();
		System.out.println("17. PPLTN_RATE_70 - 70대 실시간 인구 비율: " + ppltnRate70);

		// ***** model *****		
		model.addAttribute("ppltnRate70", ppltnRate70);			
		
		// 18. RESNT_PPLTN_RATE - 상주 인구 비율
		String resntPpltnRate = livePpltnSttsToJsonObject.get("RESNT_PPLTN_RATE").getAsString();
		System.out.println("18. RESNT_PPLTN_RATE - 상주 인구 비율: " + resntPpltnRate);

		// ***** model *****		
		model.addAttribute("resntPpltnRate", resntPpltnRate);			
		
		// 19. NON_RESNT_PPLTN_RATE - 비상주 인구 비율
		String nonResntPpltnRate = livePpltnSttsToJsonObject.get("NON_RESNT_PPLTN_RATE").getAsString();
		System.out.println("19. NON_RESNT_PPLTN_RATE - 비상주 인구 비율: " + nonResntPpltnRate);

		// ***** model *****		
		model.addAttribute("nonResntPpltnRate", nonResntPpltnRate);			
		
		// 20. REPLACE_YN - 대체 데이터 여부
		String replaceYn = livePpltnSttsToJsonObject.get("REPLACE_YN").getAsString();
		System.out.println("20. REPLACE_YN - 대체 데이터 여부: " + replaceYn);

		// 21. PPLTN_TIME - 실시간 인구 데이터 업데이트 시간
		String ppltnTime = livePpltnSttsToJsonObject.get("PPLTN_TIME").getAsString();
		System.out.println("21. PPLTN_TIME - 실시간 인구 데이터 업데이트 시간: " + ppltnTime);		
		
		// ***** model *****		
		model.addAttribute("ppltnTime", ppltnTime);			
		
		// 22. FCST_YN - 예측값 제공 여부
		String fcstYn = livePpltnSttsToJsonObject.get("FCST_YN").getAsString();
		System.out.println("22. FCST_YN - 예측값 제공 여부: " + fcstYn);
		
		// 23. FCST_PPLTN - 인구 예측값
		JsonArray fcstPpltn = livePpltnSttsToJsonObject.get("FCST_PPLTN").getAsJsonArray();
		// System.out.println("23. FCST_PPLTN - 인구 예측값: " + fcstPpltn);
		
		ArrayList<SeoulSpot115FCST> fcstList = new ArrayList<SeoulSpot115FCST>();
		
		// 24 ~ 27 - 출력
		for (int i = 0; i < fcstPpltn.size(); i++) {
			
			SeoulSpot115FCST fcst = new SeoulSpot115FCST();
			
			JsonObject fcstPpltnToJsonObject = fcstPpltn.get(i).getAsJsonObject();
			// System.out.println("23. FCST_PPLTN - 인구 예측값[" + i + "]: " + fcstPpltnToJsonObject);
			System.out.println("------- 23. FCST_PPLTN - 인구 예측값[" + i + "] -------");
			
			// 24. FCST_TIME - 인구 예측시점
			String fcstTime = fcstPpltnToJsonObject.get("FCST_TIME").getAsString();
			System.out.println("24. FCST_TIME - 인구 예측시점: " + fcstTime);
			
			fcst.setFcstTime(fcstTime);
			
			// 25. FCST_CONGEST_LVL - 장소 예측 혼잡도 지표
			String fcstCongestLvl = fcstPpltnToJsonObject.get("FCST_CONGEST_LVL").getAsString();
			System.out.println("25. FCST_CONGEST_LVL - 장소 예측 혼잡도 지표: " + fcstCongestLvl);
			
			fcst.setFcstCongestLvl(fcstCongestLvl);
			
			// 26. FCST_PPLTN_MIN - 예측 실시간 인구 지표 최소값
			String fcstPpltnMin = fcstPpltnToJsonObject.get("FCST_PPLTN_MIN").getAsString();
			System.out.println("26. FCST_PPLTN_MIN - 예측 실시간 인구 지표 최소값: " + fcstPpltnMin);
		
			fcst.setFcstPpltnMin(fcstPpltnMin);
			
			// 27. FCST_PPLTN_MAX - 예측 실시간 인구 지표 최대값
			String fcstPpltnMax = fcstPpltnToJsonObject.get("FCST_PPLTN_MAX").getAsString();
			System.out.println("27. FCST_PPLTN_MAX - 예측 실시간 인구 지표 최대값: " + fcstPpltnMax);
			
			fcst.setFcstPpltnMax(fcstPpltnMax);
			
			System.out.println("--------------------------------------------");
			
			fcstList.add(fcst);
			
		}

		// ***** model *****		
		model.addAttribute("fcstList", fcstList);		
		
		// 28. ROAD_TRAFFIC_STTS - 도로소통현황
		JsonObject roadTrafficStts = cityData.get("ROAD_TRAFFIC_STTS").getAsJsonObject();
		// System.out.println("28. ROAD_TRAFFIC_STTS - 도로소통현황: " + roadTrafficStts);
	
		// AVG_ROAD_DATA - 전체도로소통평균
		JsonObject avgRoadData = roadTrafficStts.get("AVG_ROAD_DATA").getAsJsonObject();
		// System.out.println("AVG_ROAD_DATA - 전체도로소통평균: " + avgRoadData);
		
		// 29. ROAD_MSG - 전체도로소통평균현황 메세지
		String roadMsg = avgRoadData.get("ROAD_MSG").getAsString();
		System.out.println("29. ROAD_MSG - 전체도로소통평균현황 메세지: " + roadMsg);
		
		// ***** model *****		
		model.addAttribute("roadMsg", roadMsg);			
		
		// 30. ROAD_TRAFFIC_IDX - 전체도로소통평균현황
		String roadTrafficIdx = avgRoadData.get("ROAD_TRAFFIC_IDX").getAsString();
		System.out.println("30. ROAD_TRAFFIC_IDX - 전체도로소통평균현황: " + roadTrafficIdx);
		
		// ***** model *****		
		model.addAttribute("roadTrafficIdx", roadTrafficIdx);				
		
		// 31. ROAD_TRFFIC_TIME - 도로소통현황 업데이트 시간
		String roadTrfficTime = avgRoadData.get("ROAD_TRFFIC_TIME").getAsString();
		System.out.println("31. ROAD_TRFFIC_TIME - 도로소통현황 업데이트 시간: " + roadTrfficTime);
	
		// ***** model *****		
		model.addAttribute("roadTrfficTime", roadTrfficTime);						
		
		// 32. ROAD_TRAFFIC_SPD - 전체도로소통평균속도
		String roadTrafficSpd = avgRoadData.get("ROAD_TRAFFIC_SPD").getAsString();
		System.out.println("32. ROAD_TRAFFIC_SPD - 전체도로소통평균속도: " + roadTrafficSpd);
	
		// ***** model *****		
		model.addAttribute("roadTrafficSpd", roadTrafficSpd);		
		
		// ROAD_TRAFFIC_STTS(Detail) - 세부 도로소통현황
		JsonArray roadTrafficSttsDetail = roadTrafficStts.get("ROAD_TRAFFIC_STTS").getAsJsonArray();
		// System.out.println("ROAD_TRAFFIC_STTS(Detail) - 세부 도로소통현황: " + roadTrafficSttsDetail);
	
		Gson gson = new Gson();
		
		String json = gson.toJson(roadTrafficSttsDetail);
		
		System.out.println(json);
		
		model.addAttribute("json", json);		
		
		ArrayList<SeoulSpot115Road> roadList = new ArrayList<SeoulSpot115Road>();
		
		JsonObject coordinateJsonObject  = roadTrafficSttsDetail.get(0).getAsJsonObject();
		String coordinateString = coordinateJsonObject.get("START_ND_XY").getAsString();
		System.out.println("coordinateString: " + coordinateString);
		String[] coordinateParts = coordinateString.split("_");
		System.out.println("첫 번째 부분: " + coordinateParts[0]);
		System.out.println("두 번째 부분: " + coordinateParts[1]);
		
		model.addAttribute("coordinateLongitude",coordinateParts[0]);
		model.addAttribute("coordinateLatitude",coordinateParts[1]);
		
		// 33 ~ 44 - 출력
		for (int i = 0; i < roadTrafficSttsDetail.size(); i++) {
			
			SeoulSpot115Road road = new SeoulSpot115Road();
			
			JsonObject roadTrafficSttsDetailToJsonObject = roadTrafficSttsDetail.get(i).getAsJsonObject();
			// System.out.println("ROAD_TRAFFIC_STTS(Detail) - 세부 도로소통현황[" + i + "]: " + roadTrafficSttsDetailToJsonObject);
			System.out.println("------- ROAD_TRAFFIC_STTS(Detail) - 세부 도로소통현황[" + i + "] -------");						
		
			// 33. LINK_ID - 도로구간 LINK ID
			String linkId = roadTrafficSttsDetailToJsonObject.get("LINK_ID").getAsString();
			System.out.println("33. LINK_ID - 도로구간 LINK ID: " + linkId);
			
			road.setLinkId(linkId);
			
			// 34. ROAD_NM - 도로명
			String roadNm = roadTrafficSttsDetailToJsonObject.get("ROAD_NM").getAsString();
			System.out.println("34. ROAD_NM - 도로명: " + roadNm);

			road.setRoadNm(roadNm);
			
			// 35. START_ND_CD - 도로노드시작지점 코드
			String startNdCd = roadTrafficSttsDetailToJsonObject.get("START_ND_CD").getAsString();
			System.out.println("35. START_ND_CD - 도로노드시작지점 코드: " + startNdCd);
			
			road.setStartNdCd(startNdCd);
			
			// 36. START_ND_NM - 도로노드시작명
			String startNdNm = roadTrafficSttsDetailToJsonObject.get("START_ND_NM").getAsString();			
			System.out.println("36. START_ND_NM - 도로노드시작명: " + startNdNm);
			
			road.setStartNdNm(startNdNm);
			
			// 37. START_ND_XY - 도로노드시작지점좌표
			String startNdXy = roadTrafficSttsDetailToJsonObject.get("START_ND_XY").getAsString();
			System.out.println("37. START_ND_XY - 도로노드시작지점좌표: " + startNdXy);
			
			road.setStartNdXy(startNdXy);
			
			// 38. END_ND_CD - 도로노드종료지점 코드
			String endNdCd = roadTrafficSttsDetailToJsonObject.get("END_ND_CD").getAsString();
			System.out.println("38. END_ND_CD - 도로노드종료지점 코드: " + endNdCd);
			
			road.setEndNdCd(endNdCd);
			
			// 39. END_ND_NM - 도로노드종료명
			String endNdNm = roadTrafficSttsDetailToJsonObject.get("END_ND_NM").getAsString();
			System.out.println("39. END_ND_NM - 도로노드종료명: " + endNdNm);
			
			road.setEndNdNm(endNdNm);
			
			// 40. END_ND_XY - 도로노드종료지점좌표
			String endNdXy = roadTrafficSttsDetailToJsonObject.get("END_ND_XY").getAsString();
			System.out.println("40. END_ND_XY - 도로노드종료지점좌표: " + endNdXy);
			
			road.setEndNdXy(endNdXy);
			
			// 41. DIST - 도로구간길이
			String dist = roadTrafficSttsDetailToJsonObject.get("DIST").getAsString();
			System.out.println("41. DIST - 도로구간길이: " + dist);

			road.setDist(dist);
			
			// 42. SPD - 도로구간평균속도
			String spd = roadTrafficSttsDetailToJsonObject.get("SPD").getAsString();
			System.out.println("42. SPD - 도로구간평균속도: " + spd);
			
			road.setSpd(spd);
			
			// 43. IDX - 도로구간소통지표
			String idx = roadTrafficSttsDetailToJsonObject.get("IDX").getAsString();
			System.out.println("43. IDX - 도로구간소통지표: " + idx);
			
			road.setIdx(idx);
			
			// 44. XYLIST - 링크아이디 좌표(보간점)
			String xyList = roadTrafficSttsDetailToJsonObject.get("XYLIST").getAsString();
			System.out.println("44. XYLIST - 링크아이디 좌표(보간점): " + xyList);
			
			road.setXyList(xyList);
			
			System.out.println("-----------------------------------------------------------");
			
			roadList.add(road);
			
		}
		
		// ***** model *****		
		model.addAttribute("roadList", roadList);	
			
	}

}

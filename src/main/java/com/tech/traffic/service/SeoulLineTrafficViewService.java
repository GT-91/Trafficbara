package com.tech.traffic.service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.tech.traffic.dao.TrafficInterfaceDao;
import com.tech.traffic.dto.SeoulLineTraffic;

public class SeoulLineTrafficViewService implements TrafficInterfaceService {

	private SqlSession sqlSession;
	
	public SeoulLineTrafficViewService(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	@Override
	public void execute(Model model) {
		System.out.println("SeoulLineTrafficViewService");
		System.out.println("------------------------------");
		
		// Return the current set of model attributes as a Map.
		Map<String, Object> map = model.asMap();		
		
		// request
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		
		// TrafficInterfaceDao, SqlSession 연결		
		TrafficInterfaceDao dao = sqlSession.getMapper(TrafficInterfaceDao.class);
		
		// month
		String contstraintMonth = request.getParameter("month");
		System.out.println("contstraintMonth: " + contstraintMonth);
		// null Check
		if(contstraintMonth == null) {
			contstraintMonth = "1";
			System.out.println("contstraintMonth: " + contstraintMonth);
		}
		
		model.addAttribute("contstraintMonth", contstraintMonth);
		
		// line
		String contstraintLine = request.getParameter("line");
		System.out.println("contstraintLine: " + contstraintLine);
		// null Check
		if(contstraintLine == null) {
			contstraintLine = "강남순환로";
			System.out.println("contstraintLine: " + contstraintLine);
		}

		model.addAttribute("contstraintLine", contstraintLine);
		
		ArrayList<SeoulLineTraffic> dtoList = dao.getSeoulLineTraffic(contstraintMonth, contstraintLine);
	
		for (SeoulLineTraffic seoulLineTraffic : dtoList) {
			System.out.println("year: " + seoulLineTraffic.getYear()
							   + " month: " + seoulLineTraffic.getMonth()
							   + " line: " + seoulLineTraffic.getLine()
							   + " traffic: " + seoulLineTraffic.getTraffic()
							   + " day: " + seoulLineTraffic.getDay());
		}
		
		Gson gson = new Gson();
		
		JsonArray jsonArray = new JsonArray();
		
		Iterator<SeoulLineTraffic> it = dtoList.iterator();
		
		while(it.hasNext()) {
			
			SeoulLineTraffic dto = it.next();
			
			JsonObject jsonObject = new JsonObject();
			
			int year = dto.getYear();
			int month = dto.getMonth();
			String line = dto.getLine();
			int traffic = dto.getTraffic();
			String day = dto.getDay();
			
			jsonObject.addProperty("YEAR", year);
			jsonObject.addProperty("MONTH", month);
			jsonObject.addProperty("LINE", line);
			jsonObject.addProperty("TRAFFIC", traffic);
			jsonObject.addProperty("DAY", day);
			
			jsonArray.add(jsonObject);
			
		}
		
		String json = gson.toJson(jsonArray);
		
		System.out.println(json);
		
		model.addAttribute("json", json);
		
	}

}

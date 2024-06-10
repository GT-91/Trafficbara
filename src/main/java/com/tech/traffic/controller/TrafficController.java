package com.tech.traffic.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.tech.traffic.service.SeoulLineTrafficViewService;
import com.tech.traffic.service.SeoulSpot115ViewService;
import com.tech.traffic.service.TrafficInterfaceService;

@Controller
public class TrafficController {
	
	TrafficInterfaceService trafficInterfaceService;
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		// 서버 실행 - 메인 페이지 출력		
		return "home";
	}
	
	// ---------- SeoulSpot115.jsp ----------	
	@RequestMapping(value = "SeoulSpot115", method = RequestMethod.GET)
	public String SeoulSpot115(HttpServletRequest request, Model model) {
		// Console 출력
		System.out.println("SeoulSpot115 Controller");
		System.out.println("------------------------------");
		
		// Model - request
		model.addAttribute("request", request);
		
		// Service
		trafficInterfaceService = new SeoulSpot115ViewService(sqlSession);
		trafficInterfaceService.execute(model);		
		
		return "SeoulSpot115";
	}

	// ---------- SeoulLineTraffic.jsp ----------	
	@RequestMapping(value = "SeoulLineTraffic", method = RequestMethod.GET)
	public String SeoulLineTraffic(HttpServletRequest request, Model model) {
		// Console 출력
		System.out.println("SeoulLineTraffic Controller");
		System.out.println("------------------------------");
		
		// Model - request
		model.addAttribute("request", request);
		
		// Service
		trafficInterfaceService = new SeoulLineTrafficViewService(sqlSession);
		trafficInterfaceService.execute(model);
		
		return "SeoulLineTraffic";
	}	
	
}

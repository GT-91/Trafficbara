package com.tech.traffic.dao;

import java.util.ArrayList;

import com.tech.traffic.dto.SeoulLineTraffic;

public interface TrafficInterfaceDao {

	// ---------- SeoulLineTraffic.jsp ----------	
	public ArrayList<SeoulLineTraffic> getSeoulLineTraffic(String contstraintMonth, String contstraintLine);
	
}

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Seoul Line Traffic</title>
</head>
<body>

	<div style="display:flex;flex-direction:column;align-items:center;">

		<h3>서울도시고속도로 노선별 요일별 교통량</h3>	
	
		<form action="SeoulLineTraffic" method="get">
		
			<fieldset style="width:1000px;text-align:center;">
				<legend style="font-size:15px;font-weight:700;">노선</legend>
				<div style="display:flex;justify-content:space-around;font-size:12px;">
					<input type="radio" name="line" value="강남순환로" />강남순환로
					<input type="radio" name="line" value="강변북로" />강변북로
					<input type="radio" name="line" value="경부고속도로" />경부고속도로
					<input type="radio" name="line" value="내부순환로" />내부순환로
					<input type="radio" name="line" value="동부간선도로" />동부간선도로
					<input type="radio" name="line" value="북부간선도로" />북부간선도로
					<input type="radio" name="line" value="분당수서고속화도로" />분당수서고속화도로
					<input type="radio" name="line" value="분당수서로" />분당수서로
					<input type="radio" name="line" value="서부간선도로" />서부간선도로
					<input type="radio" name="line" value="올림픽대로" />올림픽대로
				</div>
			</fieldset>
			
			<br />
			
			<fieldset style="width:1000px;text-align:center;">
				<legend style="font-size:15px;font-weight:700;">월</legend>
				<div style="display:flex;justify-content:space-around;font-size:12px;">
					<input type="radio" name="month" value="1" />1월
					<input type="radio" name="month" value="2" />2월
					<input type="radio" name="month" value="3" />3월
					<input type="radio" name="month" value="4" />4월
					<input type="radio" name="month" value="5" />5월
					<input type="radio" name="month" value="6" />6월
					<input type="radio" name="month" value="7" />7월
					<input type="radio" name="month" value="8" />8월
					<input type="radio" name="month" value="9" />9월
					<input type="radio" name="month" value="10" />10월
					<input type="radio" name="month" value="11" />11월
					<input type="radio" name="month" value="12" />12월
				</div>				
			</fieldset>
			
		</form>
	
		<br />
	
		<div style="width:1000px;">
		  <canvas id="myChart"></canvas>
		</div>
	
	</div>
	
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	
	<script>
	
		window.addEventListener('DOMContentLoaded', function() {
			// 월 선택
			var monthValue = ${contstraintMonth};
			console.log("monthValue: ", monthValue);
			if (monthValue) {
				var monthSelector = 'input[name="month"][value=\"' + monthValue + '\"]';
				var monthInput = document.querySelector(monthSelector);
				console.log("monthInput: ", monthInput);
				if (monthInput) {
					monthInput.checked = true;
				}
			}
			// 노선 선택
			var lineValue = `${contstraintLine}`;
			console.log("lineValue: ", lineValue);
			if (lineValue) {
				var lineSelector = 'input[name="line"][value=\"' + lineValue + '\"]';
				var lineInput = document.querySelector(lineSelector);
				console.log("lineInput: ", lineInput);
				if (lineInput) {
					lineInput.checked = true;
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
	
		var jsonData = ${json};
		var lineValue = `${contstraintLine}`;
		var monthValue = ${contstraintMonth};
		
		var jsonObject = JSON.stringify(jsonData);
		
		var jData = JSON.parse(jsonObject);
	
		var traffic2013 = new Array(7); 
		var traffic2014 = new Array(7);
		var traffic2015 = new Array(7);
		var traffic2016 = new Array(7);
		var traffic2017 = new Array(7);
		var traffic2018 = new Array(7);
		var traffic2022 = new Array(7);		
		var traffic2023 = new Array(7);		
		
		for (var i = 0; i < jData.length; i++) {
			
			var obj = jData[i];
			
			console.log(obj);
			
			if (obj.YEAR == "2013") {
				console.log("2013년 데이터 처리")
				if (obj.DAY == "일요일") {
					traffic2013[0] = obj.TRAFFIC;	
				} else if (obj.DAY == "월요일") {
					traffic2013[1] = obj.TRAFFIC;
				} else if (obj.DAY == "화요일") {
					traffic2013[2] = obj.TRAFFIC;
				} else if (obj.DAY == "수요일") {
					traffic2013[3] = obj.TRAFFIC;
				} else if (obj.DAY == "목요일") {
					traffic2013[4] = obj.TRAFFIC;
				} else if (obj.DAY == "금요일") {
					traffic2013[5] = obj.TRAFFIC;
				} else if (obj.DAY == "토요일") {
					traffic2013[6] = obj.TRAFFIC;
				} else {
					
				}
			}
			
			if (obj.YEAR == "2014") {
				console.log("2014년 데이터 처리")
				if (obj.DAY == "일요일") {
					traffic2014[0] = obj.TRAFFIC;	
				} else if (obj.DAY == "월요일") {
					traffic2014[1] = obj.TRAFFIC;
				} else if (obj.DAY == "화요일") {
					traffic2014[2] = obj.TRAFFIC;
				} else if (obj.DAY == "수요일") {
					traffic2014[3] = obj.TRAFFIC;
				} else if (obj.DAY == "목요일") {
					traffic2014[4] = obj.TRAFFIC;
				} else if (obj.DAY == "금요일") {
					traffic2014[5] = obj.TRAFFIC;
				} else if (obj.DAY == "토요일") {
					traffic2014[6] = obj.TRAFFIC;
				}
			}			

			if (obj.YEAR == "2015") {
				console.log("2015년 데이터 처리")
				if (obj.DAY == "일요일") {
					traffic2015[0] = obj.TRAFFIC;	
				} else if (obj.DAY == "월요일") {
					traffic2015[1] = obj.TRAFFIC;
				} else if (obj.DAY == "화요일") {
					traffic2015[2] = obj.TRAFFIC;
				} else if (obj.DAY == "수요일") {
					traffic2015[3] = obj.TRAFFIC;
				} else if (obj.DAY == "목요일") {
					traffic2015[4] = obj.TRAFFIC;
				} else if (obj.DAY == "금요일") {
					traffic2015[5] = obj.TRAFFIC;
				} else if (obj.DAY == "토요일") {
					traffic2015[6] = obj.TRAFFIC;
				}
			}
			
			if (obj.YEAR == "2016") {
				console.log("2016년 데이터 처리")
				if (obj.DAY == "일요일") {
					traffic2016[0] = obj.TRAFFIC;	
				} else if (obj.DAY == "월요일") {
					traffic2016[1] = obj.TRAFFIC;
				} else if (obj.DAY == "화요일") {
					traffic2016[2] = obj.TRAFFIC;
				} else if (obj.DAY == "수요일") {
					traffic2016[3] = obj.TRAFFIC;
				} else if (obj.DAY == "목요일") {
					traffic2016[4] = obj.TRAFFIC;
				} else if (obj.DAY == "금요일") {
					traffic2016[5] = obj.TRAFFIC;
				} else if (obj.DAY == "토요일") {
					traffic2016[6] = obj.TRAFFIC;
				}
			}
			
			if (obj.YEAR == "2017") {
				console.log("2017년 데이터 처리")
				if (obj.DAY == "일요일") {
					traffic2017[0] = obj.TRAFFIC;	
				} else if (obj.DAY == "월요일") {
					traffic2017[1] = obj.TRAFFIC;
				} else if (obj.DAY == "화요일") {
					traffic2017[2] = obj.TRAFFIC;
				} else if (obj.DAY == "수요일") {
					traffic2017[3] = obj.TRAFFIC;
				} else if (obj.DAY == "목요일") {
					traffic2017[4] = obj.TRAFFIC;
				} else if (obj.DAY == "금요일") {
					traffic2017[5] = obj.TRAFFIC;
				} else if (obj.DAY == "토요일") {
					traffic2017[6] = obj.TRAFFIC;
				}
			}
			
			if (obj.YEAR == "2018") {
				console.log("2018년 데이터 처리")
				if (obj.DAY == "일요일") {
					traffic2018[0] = obj.TRAFFIC;	
				} else if (obj.DAY == "월요일") {
					traffic2018[1] = obj.TRAFFIC;
				} else if (obj.DAY == "화요일") {
					traffic2018[2] = obj.TRAFFIC;
				} else if (obj.DAY == "수요일") {
					traffic2018[3] = obj.TRAFFIC;
				} else if (obj.DAY == "목요일") {
					traffic2018[4] = obj.TRAFFIC;
				} else if (obj.DAY == "금요일") {
					traffic2018[5] = obj.TRAFFIC;
				} else if (obj.DAY == "토요일") {
					traffic2018[6] = obj.TRAFFIC;
				}
			}
			
			if (obj.YEAR == "2022") {
				console.log("2022년 데이터 처리")
				if (obj.DAY == "일요일") {
					traffic2022[0] = obj.TRAFFIC;	
				} else if (obj.DAY == "월요일") {
					traffic2022[1] = obj.TRAFFIC;
				} else if (obj.DAY == "화요일") {
					traffic2022[2] = obj.TRAFFIC;
				} else if (obj.DAY == "수요일") {
					traffic2022[3] = obj.TRAFFIC;
				} else if (obj.DAY == "목요일") {
					traffic2022[4] = obj.TRAFFIC;
				} else if (obj.DAY == "금요일") {
					traffic2022[5] = obj.TRAFFIC;
				} else if (obj.DAY == "토요일") {
					traffic2022[6] = obj.TRAFFIC;
				}
			}
			
			if (obj.YEAR == "2023") {
				console.log("2023년 데이터 처리")
				if (obj.DAY == "일요일") {
					traffic2023[0] = obj.TRAFFIC;	
				} else if (obj.DAY == "월요일") {
					traffic2023[1] = obj.TRAFFIC;
				} else if (obj.DAY == "화요일") {
					traffic2023[2] = obj.TRAFFIC;
				} else if (obj.DAY == "수요일") {
					traffic2023[3] = obj.TRAFFIC;
				} else if (obj.DAY == "목요일") {
					traffic2023[4] = obj.TRAFFIC;
				} else if (obj.DAY == "금요일") {
					traffic2023[5] = obj.TRAFFIC;
				} else if (obj.DAY == "토요일") {
					traffic2023[6] = obj.TRAFFIC;
				}
			}			
			
		};
	
		console.log("traffic2013: ", traffic2013);
		console.log("traffic2014: ", traffic2014);
		console.log("traffic2015: ", traffic2015);
		console.log("traffic2016: ", traffic2016);
		console.log("traffic2017: ", traffic2017);
		console.log("traffic2018: ", traffic2018);
		console.log("traffic2022: ", traffic2022);
		console.log("traffic2023: ", traffic2023);
		
		const ctx = document.getElementById('myChart');
		
		const title = lineValue + " " + monthValue + "월 요일별 교통량";
		
		const labels = ['일', '월', '화', '수', '목', '금', '토'];
		
		// traffic2013
		if (traffic2013[0] == undefined) {
			console.log("traffic2013 undefined");
			var dataset2013 = null;
		} else {
			var dataset2013 = {
								   label: '2013년',
								   data: traffic2013,
								   fill: false,
								   borderColor: 'rgb(245, 93, 66)',
								   tension: 0.1
							  }
		};
		// traffic2014
		if (traffic2014[0] == undefined) {
			console.log("traffic2014 undefined");
			var dataset2014 = null;
		} else {
			var dataset2014 = {
								   label: '2014년',
								   data: traffic2014,
								   fill: false,
								   borderColor: 'rgb(245, 230, 66)',
							   	   tension: 0.1
							  }
		};
		// traffic2015
		if (traffic2015[0] == undefined) {
			console.log("traffic2015 undefined");
			var dataset2015 = null;
		} else {
			var dataset2015 = {
								   label: '2015년',
								   data: traffic2015,
								   fill: false,
								   borderColor: 'rgb(138, 245, 66)',
							   	   tension: 0.1
							  }
		};		
		// traffic2016
		if (traffic2016[0] == undefined) {
			console.log("traffic2016 undefined");
			var dataset2016 = null;
		} else {
			var dataset2016 = {
								   label: '2016년',
								   data: traffic2016,
								   fill: false,
								   borderColor: 'rgb(66, 245, 239)',
							   	   tension: 0.1
							  }
		};			
		// traffic2017
		if (traffic2017[0] == undefined) {
			console.log("traffic2017 undefined");
			var dataset2017 = null;
		} else {
			var dataset2017 = {
								   label: '2017년',
								   data: traffic2017,
								   fill: false,
								   borderColor: 'rgb(66, 144, 245)',
							   	   tension: 0.1
							  }
		};		
		// traffic2018
		if (traffic2018[0] == undefined) {
			console.log("traffic2018 undefined");
			var dataset2018 = null;
		} else {
			var dataset2018 = {
								   label: '2018년',
								   data: traffic2018,
								   fill: false,
								   borderColor: 'rgb(215, 66, 245)',
							   	   tension: 0.1
							  }
		};		
		// traffic2022
		if (traffic2022[0] == undefined) {
			console.log("traffic2022 undefined");
			var dataset2022 = null;
		} else {
			var dataset2022 = {
								   label: '2022년',
								   data: traffic2022,
								   fill: false,
								   borderColor: 'rgb(245, 66, 150)',
							   	   tension: 0.1
							  }
		};		
		// traffic2023
		if (traffic2023[0] == undefined) {
			console.log("traffic2023 undefined");
			var dataset2023 = null;
		} else {
			var dataset2023 = {
								   label: '2023년',
								   data: traffic2023,
								   fill: false,
								   borderColor: 'rgb(66, 188, 245)',
							   	   tension: 0.1
							  }
		};			
		
		console.log("dataset2013: ", dataset2013);
		console.log("dataset2014: ", dataset2014);
		console.log("dataset2015: ", dataset2014);		
		console.log("dataset2016: ", dataset2014);
		console.log("dataset2017: ", dataset2014);
		console.log("dataset2018: ", dataset2014);
		console.log("dataset2022: ", dataset2014);
		console.log("dataset2023: ", dataset2014);

		var datasetAll = []; 
		
		if (dataset2013 !== null) { datasetAll.push(dataset2013); };
		if (dataset2014 !== null) { datasetAll.push(dataset2014); };
		if (dataset2015 !== null) { datasetAll.push(dataset2015); };
		if (dataset2016 !== null) { datasetAll.push(dataset2016); };
		if (dataset2017 !== null) { datasetAll.push(dataset2017); };
		if (dataset2018 !== null) { datasetAll.push(dataset2018); };
		if (dataset2022 !== null) { datasetAll.push(dataset2022); };
		if (dataset2023 !== null) { datasetAll.push(dataset2023); };
		
		console.log("datasetAll: ", datasetAll);
		
		const data = {
						 labels: labels,
						 datasets: datasetAll		
					 };
		  
		const config = {
					  	  type: 'line',
					  	  data: data,	
					  	  options: {
						  	           responsive: true,
						   	           plugins: {
						  			  	            legend: {
						  					  	            	position: 'top',
						  					  	            },
						  			  	            title: {
						  						  	           display: true,
						  						  	           text: title,
						  						  	           font: {
						  						  	        	   size: 20,
						  					  	               	   weight: 'bold'
						  						  	           }
						  			  	                   }
						  				  	    }
					  	           },
		               };
		
		new Chart(ctx, config);
	  
	</script>	

</body>
</html>
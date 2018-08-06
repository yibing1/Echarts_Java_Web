<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>选择一个要素进行动态观测</title>
</head>
<script src="echarts.min.js"></script>
<script src="jquery-3.3.1.min.js"></script>
<body>

	<p style="font-weight:bold;">选取一个要素为横坐标</p>
	<form action="DynamicServlet">
		<input type="hidden" value="load" /> <select id="input">
			<option value="temperature">温度</option>
			<option value="conduct">电导率</option>
			<option value="depth">深度</option>
			<option value="volts1">第一外部电压</option>
			<option value="volts2">第二外部电压</option>
			<option value="NTU">浊度</option>
			<option value="oxy">溶解氧</option>
		</select>
		<button type="button" id="btn" onclick="loadGraph();"
			disabled='disabled'>提交并查看数据</button>
	</form>
	<p>
	<div id="main"
		style="width: 1200px; height: 800px; align: center; margin: 0px auto;"></div>
	<!-- initialize my chart -->
	<script type="text/javascript">
	var myChart= echarts.init(document.getElementById('main'));
		option = {
			title : {
				text : '同济大学海底科学观测网'
			},
			tooltip : {
				trigger : 'axis',
				formatter : {},
				axisPointer : {
					animation : false
				}
			},
			xAxis : {
				type : 'time',
				splitLine : {
					show : false
				}
			},
			yAxis : {
				name : 'Y轴',
				type : 'value',
				boundaryGap : [ 0, '100%' ],
				splitLine : {
					show : false
				}
			},
			series : [ {
				name : '数据',
				type : 'line',
				showSymbol : false,
				hoverAnimation : false,
				data : []
			} ]
		};
		myChart.setOption(option);
		myChart.showLoading();

		var xmlRequest = null;
		if (window.XMLHttpRequest) {// code for all new browsers
			xmlRequest = new XMLHttpRequest();
		} else if (window.ActiveXObject) {// code for IE5 and IE6
			xmlRequest = new ActiveXObject("Microsoft.XMLHTTP");
		}
		if (xmlRequest != null) {
			xmlRequest.open("GET",
					"${pageContext.request.contextPath}/DynamicGraphServlet?input="
							+ "load", true);
			xmlRequest.send();
		} else {
			alert("Your brower doesn't support XMLHTTP; You'd better change to another brower");
			location.reload();
		}
		<!--温度-->
		var dataset1 = [];
		<!--电导率-->
		var dataset2 = [];
		<!--深度-->
		var dataset3 = [];
		<!--第一电压-->
		var dataset4 = [];
		<!--第二电压-->
		var dataset5 = [];
		<!--浊度-->
		var dataset6 = [];
		<!--溶解氧-->
		var dataset7 = [];
		var time = [];
		var intervalID=null;
		xmlRequest.onreadystatechange = function() {
			if (xmlRequest.readyState == 4 && xmlRequest.status == 200) {
				document.getElementById("btn").disabled = false;
				var result = eval('(' + xmlRequest.responseText + ')');
				var count = 0;
				for ( var i in result) {
					dataset1.push(result[i].temperature);
					dataset2.push(result[i].conduct);
					dataset3.push(result[i].depth);
					dataset4.push(result[i].volts1);
					dataset5.push(result[i].volts2);
					dataset6.push(result[i].NTU);
					dataset7.push(result[i].oxy);
					time.push(result[i].date);
				}

				function passData() {
					now = new Date(Date.parse(time[count]));
					value = dataset1[count];
					return {
						name : now.toString(),
						value : [ now, value ]
					}
				}
				var data = [];
				var now = null;
				var value = null;
				for (var i = 0; i < dataset1.length / 2; i++) {
					data.push(passData());
					count++;
				}
				myChart.setOption({
					yAxis : {
						name : '温度(摄氏度)'
					},
					series : [ {
						name : '温度',
						data : data
					} ]
				});
				myChart.hideLoading();
				intervalID=setInterval(function() {
					for (var i = 0; i < 5; i++) {
						data.shift();
						data.push(passData());
						count++;
					}

				myChart.setOption({
						series : [ {
							data : data
						} ]
					});
				}, 1000);
			}
		};
		function loadGraph() {
			window.clearInterval(intervalID);
			var message = document.getElementById("input").value;
			var info = null;
			var unit=null;
			var dataset;
			switch (message) {
			case "temperature":
				info = '温度';
				unit='(摄氏度)';
				dataset=dataset1;
				break;
			case "conduct":
				info = '电导率';
				unit='(S/m)';
				dataset=dataset2;
				break;
			case "depth":
				info = '深度';
				unit='(米)';				
				dataset=dataset3;
				break;
			case "volts1":
				info = '第一外部电压';
				unit='(volts)';
				dataset=dataset4;
				break;
			case "volts2":
				info = '第二外部电压';
				unit='(volts)';
				dataset=dataset5;
				break;
			case "NTU":
				info = '浊度';
				unit='NTU';
				dataset=dataset6;
				break;
			case "oxy":
				info = '溶解氧';
				unit='(umol/kg)';
				dataset=dataset7;
				break;
			}
			
			var count=0;
			
			function passData2() {
				now = new Date(Date.parse(time[count]));
				value = dataset[count];
				return {
					name : now.toString(),
					value : [ now, value ]
				}
			}
			var data = [];
			var now = null;
			var value = null;
			for (var i = 0; i < dataset1.length / 2; i++) {
				data.push(passData2());
				count++;
			}
			myChart.setOption({
				yAxis : {
					name : info+' '+unit
				},
				series : [ {
					name : info,
					data : data
				} ]
			});
			myChart.hideLoading();
			intervalID=setInterval(function() {
				for (var i = 0; i < 5; i++) {
					data.shift();
					data.push(passData2());
					count++;
				}
				
				myChart.setOption({
					series : [ {
						data : data
					} ]
				});
			}, 1000);
		}
	</script>
</body>
</html>
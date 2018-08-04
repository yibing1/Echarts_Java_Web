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

	<form action="DynamicGraphServlet">
		<select id="input">
			<option value="temperature">温度</option>
			<option value="conduct">电导率</option>
			<option value="depth">深度</option>
			<option value="volts1">第一外部电压</option>
			<option value="volts2">第二外部电压</option>
			<option value="NTU">浊度</option>
			<option value="oxy">溶解氧</option>
		</select>
		<button type="button" id="btn" onclick="loadGraph();">提交并查看数据</button>
	</form>
	<p>
	<div id="main"
		style="width: 1200px; height: 800px; align: center; margin: 0px auto;"></div>
	<!-- initialize my chart -->
	<script type="text/javascript">
		var myChart = echarts.init(document.getElementById('main'));

		option = {
			title : {
				text : '同济大学海底缆系观测网'
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
				name:'Y轴',
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
	</script>

<!-- main function to load the graph and several other stuff-->
	<script>
		function loadGraph() {
			$("#btn").attr("disabled","true");
			var message = document.getElementById("input").value;
			var xmlRequest=null;
			if (window.XMLHttpRequest)
			  {// code for all new browsers
				xmlRequest=new XMLHttpRequest();
			  }
			else if (window.ActiveXObject)
			  {// code for IE5 and IE6
				xmlRequest=new ActiveXObject("Microsoft.XMLHTTP");
			  }
			if (xmlRequest!=null)
			  {
				xmlRequest.open("GET",
						"${pageContext.request.contextPath}/LineGraphServlet?input="+message, true);
				xmlRequest.send();
			  }else{
				  alert("Your brower doesn't support XMLHTTP; You'd better change to another brower");
				  location.reload();
			  }
			xmlRequest.open("GET",
					"${pageContext.request.contextPath}/DynamicGraphServlet?input="
							+ message, true);
			xmlRequest.send();
			xmlRequest.onreadystatechange = function() {
				if (xmlRequest.readyState == 4 && xmlRequest.status == 200) {
					var result = eval('(' + xmlRequest.responseText + ')');
					var dataset1 = [];
					var dataset2 = [];
					var count = 0;
					for ( var i in result) {
						if (message == 'temperature') {
							dataset1.push(result[i].temperature);
						} else if (message == 'conduct') {
							dataset1.push(result[i].conduct);
						} else if (message == 'depth') {
							dataset1.push(result[i].depth);
						} else if (message == 'volts1') {
							dataset1.push(result[i].volts1);
						} else if (message == 'volts2') {
							dataset1.push(result[i].volts2);
						} else if (message == 'NTU') {
							dataset1.push(result[i].NTU);
						} else if (message == "oxy") {
							dataset1.push(result[i].oxy);
						}
						dataset2.push(result[i].date);
					}

					function passData() {
					    now = new Date(Date.parse(dataset2[count]));
					    value = dataset1[count];
					    return {
					        name: now.toString(),
					        value: [now,
					            value
					        ]
					    }
					}
					var data = [];
					var now = null;
					var value = null;
					for (var i = 0; i < dataset1.length/2; i++) {
					    data.push(passData());
					    count++;
					}
					var info=null;
					switch (message) {
					case "temperature":
						info='温度(摄氏度)';
						break;
					case "conduct":
						info='电导率(S/m)';
						break;
					case "depth":
						fo='深度(米)';
						break;
					case "volts1":
						info='第一外部电压(volts)';
						break;
					case "volts2":
						info='第二外部电压(volts)';
						break;
					case "NTU":
						info='浊度(NTU)';
						break;
					case "oxy":
						info='溶解氧(umol/kg)';
						break;
					};
					myChart.setOption({
						yAxis:{
							name:info
						},
						series : [ {
							name:info,
							data : data
						} ]
					});
					myChart.hideLoading();
					setInterval(function() {
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
		};
	</script>
</body>
</html>
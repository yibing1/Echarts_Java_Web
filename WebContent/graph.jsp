<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>观测要素之间的关系图</title>
</head>
<script src="echarts.min.js"></script>
<script src="jquery-3.3.1.min.js"></script>
<body>
	<p>选取一个要素作为X轴</p>
	<form action="GraphServlet">
		<select
			id="input">
			<option value="temperature">温度</option>
			<option value="conduct">电导率</option>
			<option value="depth">深度</option>
			<option value="NTU">浊度</option>
			<option value="oxy">溶解氧</option>
		</select>
		<button type="button" id="btn" onclick="loadGraph();"
			disabled="disabled">提交并查看数据</button>
	</form>
	<p>
	<div id="main"
		style="width: 1400px; height: 800px; align: center; margin: 0px auto;"></div>
	<!-- initialize my chart -->
	<script type="text/javascript">
		var myChart=null;
		function initialize(){
			myChart = echarts.init(document.getElementById('main'));
			var colors = [ '#5793f3', '#d14a61', '#675bba', '#9400D3' ];
			option = {
				color : colors,
				title : {
					text : '同济大学海底科学观测网',
					x : 'left'
				},
				tooltip : {
					trigger : 'axis',
					axisPointer : {
						type : 'cross'
					}
				},dataZoom: [
			        {
			            show: true,
			            realtime: true,
			            start: 30,
			            end: 70,
			        }
			    ],
				grid : {
					right : '20%'
				},
				toolbox : {
					feature : {
						dataView : {
							show : true,
							readOnly : false
						},
						restore : {
							show : true
						},
						saveAsImage : {
							show : true
						}
					}
				},
				legend : {
					data : [],
					x : 'center'
				},
				xAxis : [ {
					type : 'category',
					name : '',
					data : []
				} ],
				yAxis : [ {
					type : 'value',
					name : '',
					position : 'left',
					axisLine : {
						lineStyle : {
							color : colors[0]
						}
					}
				}, {
					type : 'value',
					name : '',
					position : 'right',
					axisLine : {
						lineStyle : {
							color : colors[2]
						}
					}
				}, {
					type : 'value',
					name : '',
					position : 'right',
					axisLine : {
						lineStyle : {
							color : colors[3]
						}
					},
					offset : 90
				}, {
					type : 'value',
					name : '',
					position : 'right',
					axisLine : {
						lineStyle : {
							color : colors[1]
						}
					},
					offset : 180
				} ],
				series : [ {
					name : '',
					type : 'line',
					data : []
				}, {
					name : '',
					type : 'line',
					yAxisIndex : 1,
					data : []
				}, {
					name : '',
					type : 'line',
					yAxisIndex : 2,
					data : []
				}, {
					name : '',
					type : 'line',
					yAxisIndex : 3,
					data : []
				} ]
			};		myChart.setOption(option);
			myChart.showLoading();
		}
		initialize();
		<!--温度-->
		var dataset1 = [];
		<!--电导率-->
		var dataset2 = [];
		<!--深度-->
		var dataset3 = [];
		<!--浊度-->
		var dataset4 = [];
		<!--溶解氧-->
		var dataset5 = [];
		var xmlRequest = null;
		if (window.XMLHttpRequest) {// code for all new browsers
			xmlRequest = new XMLHttpRequest();
		} else if (window.ActiveXObject) {// code for IE5 and IE6
			xmlRequest = new ActiveXObject("Microsoft.XMLHTTP");
		}
		if (xmlRequest != null) {
			xmlRequest.open("GET",
					"${pageContext.request.contextPath}/GraphServlet?input="
							+ "load", true);
			xmlRequest.send();
		} else {
			alert("Your brower doesn't support XMLHTTP; You'd better change to another brower");
			location.reload();
		}
		xmlRequest.onreadystatechange = function() {
			if (xmlRequest.readyState == 4 && xmlRequest.status == 200) {
				document.getElementById("btn").disabled = false;
				var result = eval('(' + xmlRequest.responseText + ')');
				for ( var i in result) {
					dataset1.push(result[i].temperature);
					dataset2.push(result[i].conduct);
					dataset3.push(result[i].depth);
					dataset4.push(result[i].NTU);
					dataset5.push(result[i].oxy);
				}
				myChart.hideLoading();
				myChart.setOption({
					legend : {
						data : [ '电导率', '浊度', '溶解氧', '深度' ],
					},
					xAxis : [ {
						name : '   温度\n   (℃)',
						data : dataset1,
					} ],
					yAxis : [ {
						name : '电导率(S/m)',				
						min:4.4,
						max:4.6,
						position : 'left'
					}, {
						name : '浊度 (NTU)',
						position : 'right',
						min:24,
						max:28,
						offset : 0
					}, {
						name : '溶解氧 (umol/kg)',
						min:0.7,
						max:1,
						position : 'right',
						offset : 90
					}, {
						name : '深度(米)',
						min:30,
						max:50,
						position : 'right',
						offset : 180
					} ],
					series : [ {
						name : '电导率',
						data : dataset2
					}, {
						name : '浊度',
						data : dataset4
					}, {
						name : '溶解氧',
						data : dataset5
					}, {
						name : '深度',
						data : dataset3
					} ]

				});
			}
		};
		function loadGraph() {
			var message = document.getElementById("input").value;
			myChart.dispose();
			initialize();
			switch (message) {
			case "temperature":
				myChart.setOption({
					legend : {
						data : [ '电导率', '浊度', '溶解氧', '深度' ],
					},
					xAxis : [ {						
						name : '   温度\n   (℃)',
						data : dataset1
					} ],
					yAxis : [ {
						name : '电导率(S/m)',
						min:4.4,
						max:4.6,
						position : 'left'
					}, {
						name : '浊度 (NTU)',
						min:24,
						max:28,
						position : 'right',
						offset : 0
					}, {
						name : '溶解氧 (umol/kg)',
						min:0.7,
						max:1,
						position : 'right',
						offset : 90
					}, {
						name : '深度(米)',
						min:30,
						max:50,
						position : 'right',
						offset : 180
					} ],
					series : [ {
						name : '电导率',
						data : dataset2
					}, {
						name : '浊度',
						data : dataset4
					}, {
						name : '溶解氧',
						data : dataset5
					}, {
						name : '深度',
						data : dataset3
					} ]

				});
				break;
			case "conduct":
				myChart.setOption({
					legend : {
						data : [ '温度', '浊度', '溶解氧', '深度' ],
					},
					xAxis : [ {
						name : '  电导率 \n   (S/m)',
						data : dataset2,

					} ],
					yAxis : [ {
						name : '温度 (℃)',
						min:17,
						max:22,
						position : 'left'
					}, {
						name : '浊度 (NTU)',
						min:24,
						max:28,
						position : 'right',
						offset : 0
					}, {
						name : '溶解氧 (umol/kg)',
						min:0.7,
						max:1,
						position : 'right',
						offset : 90
					}, {
						name : '深度(米)',
						min:30,
						max:50,
						position : 'right',
						offset : 180
					} ],
					series : [ {
						name : '温度',
						data : dataset1
					}, {
						name : '浊度',
						data : dataset4
					}, {
						name : '溶解氧',
						data : dataset5
					}, {
						name : '深度',
						data : dataset3
					} ]

				});
				break;
			case "depth":
				myChart.setOption({
					legend : {
						data : [ '温度', '电导率', '浊度', '溶解氧' ],
					},
					xAxis : [ {
						name : '   深度\n   (米)',
						data : dataset3
					} ],
					yAxis : [ {
						name : '温度(℃)',
						min:17,
						max:22,
						position : 'left'
					}, {
						name : '电导率 (S/m)',
						min:4.4,
						max:4.6,
						position : 'right',
						offset : 0
					}, {
						name : '浊度 (NTU)',
						min:24,
						max:28,
						position : 'right',
						offset : 90
					}, {
						name : '溶解氧 (umol/kg)',
						min:0.7,
						max:1,
						position : 'right',
						offset : 180
					} ],
					series : [ {
						name : '温度',
						data : dataset1
					}, {
						name : '电导率',
						data : dataset2
					}, {
						name : '浊度',
						data : dataset4
					}, {
						name : '溶解氧',
						data : dataset5
					} ]

				});
				break;
			case "NTU":
				myChart.setOption({
					legend : {
						data : [ '温度', '电导率', '溶解氧', '深度' ],
					},
					xAxis : [ {
						name : '   浊度\n   (NTU)',
						data : dataset4
					} ],
					yAxis : [ {
						name : '温度(℃)',
						min:17,
						max:22,
						position : 'left'
					}, {
						name : '电导率 (S/m)',
						min:4.4,
						max:4.6,
						position : 'right',
						offset : 0
					}, {
						name : '溶解氧 (umol/kg)',
						min:0.7,
						max:1,
						position : 'right',
						offset : 90
					}, {
						name : '深度  (米)',
						min:30,
						max:50,
						position : 'right',
						offset : 180
					} ],
					series : [ {
						name : '温度',
						data : dataset1
					}, {
						name : '电导率',
						data : dataset2
					}, {
						name : '溶解氧',
						data : dataset5
					}, {
						name : '深度',
						data : dataset3
					} ]

				});
				break;
			case "oxy":
				myChart.setOption({
					legend : {
						data : [ '温度', '电导率', '浊度', '深度' ],
					},
					xAxis : [ {
						name : '   溶解氧\n   (umol/kg)',
						data : dataset4
					} ],
					yAxis : [ {
						name : '温度(℃)',
						min:17,
						max:22,
						position : 'left'
					}, {
						name : '电导率 (S/m)',						
						min:4.4,
						max:4.6,
						position : 'right',
						offset : 0
					}, {
						name : '浊度  (NTU)',
						min:24,
						max:28,
						offset : 90
					}  ,{
						name : '深度  (米)',						
						min:30,
						max:50,
						position : 'right',
						offset : 180
					}],
					series : [ {
						name : '温度',
						data : dataset1
					}, {
						name : '电导率',
						data : dataset2
					}, {
						name : '浊度',
						data : dataset4
					}, {
						name : '深度',
						data : dataset3
					} ]

				});
				break;
			}
			myChart.hideLoading();
		};
	</script>

</body>
</html>
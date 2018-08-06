<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>各个要素之间关系图</title>
</head>
<script src="echarts.min.js"></script>
<script src="jquery-3.3.1.min.js"></script>
<body>

	<p>
	<div id="main"
		style="width: 1400px; height: 800px; align: center; margin: 0px auto;"></div>
	<!-- initialize my chart -->
	<script type="text/javascript">
		var myChart = echarts.init(document.getElementById('main'));
		var colors = [ '#5793f3', '#d14a61', '#675bba', '#9400D3' ,'#D2691E'];
		option = {
				color : colors,
			    title: {
			        text: '同济大学海底科学观测网',
			        x: 'left'
			    },
			    tooltip: {
			        trigger: 'axis',
			        axisPointer: {
			            animation: false
			        }
			    },
			    legend: {
			        data:['温度','电导率','溶解氧','浊度','深度'],
			        x: 'center'
			    },
			    toolbox: {
			        feature: {
			            dataZoom: {
			                yAxisIndex: 'none'
			            },
			            restore: {show: true},
			            saveAsImage: {show: true}
			        }
			    },
			    dataZoom: [
			        {
			            show: true,
			            realtime: true,
			            start: 30,
			            end: 70,
			            xAxisIndex: [0, 1]
			        },
			        {
			            type: 'inside',
			            realtime: true,
			            start: 30,
			            end: 70,
			            xAxisIndex: [0, 1]
			        }
			    ],
			    grid: [{
			        left: 50,
			        right: 200,
			        height: '40%'
			    }, {
			        left: 50,
			        right: 200,
			        top: '55%',
			        height: '40%'
			    }
			    ],
			    xAxis : [
			        {
			            type : 'category',
			            boundaryGap : false,
			            axisLine: {onZero: true},
			            data: []
			        },
			        {
			            gridIndex: 1,
			            type : 'category',
			            boundaryGap : false,
			            axisLine: {onZero: true},
			            data: [],
			            position: 'top'
			        }
			    ],
			yAxis : [ {
				name : '溫度 (℃)',
				type : 'value',	
				min:17,
				max:22,
				axisLine : {
					lineStyle : {
						color : colors[0]
					}
				}
			},{	gridIndex : 1,
				name : '电导率 (S/m)',
				type : 'value',
				min:4.4,
				max:4.6,
				axisLine : {
					lineStyle : {
						color : colors[1]
					}
				},
				inverse : true
			}, {
				name : '溶解氧 (umol/kg)',
				type : 'value',
				min:0.7,
				max:1,
				axisLine : {
					lineStyle : {
						color : colors[2]
					}
				}
			}, {
				gridIndex : 1,
				name : '浊度 (NTU)',
				type : 'value',
				min:24,
				max:28,
				axisLine : {
					lineStyle : {
						color : colors[3]
					}
				},
				inverse : true
			}, {
				gridIndex : 1,
				name : '深度 (米)',
				type : 'value',
				min:30,
				max:50,
				axisLine : {
					lineStyle : {
						color : colors[4]
					}
				},
				offset:60,
				inverse : true
			}],
			series : [ {
				name : '温度',
				type : 'line',
				hoverAnimation : false,
				data : []
			},  {
				name : '电导率',
				type : 'line',
				xAxisIndex : 1,
				yAxisIndex : 1,
				hoverAnimation : false,
				data : []
			},{
				name : '溶解氧',
				type : 'line',
				xAxisIndex : 0,
				yAxisIndex : 2,
				hoverAnimation : false,
				data : []
			},{
				name : '浊度',
				type : 'line',
				xAxisIndex : 1,
				yAxisIndex : 3,
				hoverAnimation : false,
				data : []
			},{
				name : '深度',
				type : 'line',
				xAxisIndex : 1,
				yAxisIndex : 4,
				hoverAnimation : false,
				data : []
			}
			]
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
						"${pageContext.request.contextPath}/GraphServlet?input="
								+ "load", true);
				xmlRequest.send();
			} else {
				alert("Your brower doesn't support XMLHTTP; You'd better change to another brower");
				location.reload();
			}
			xmlRequest.onreadystatechange = function() {
				if (xmlRequest.readyState == 4 && xmlRequest.status == 200) {
					var result = eval('(' + xmlRequest.responseText + ')');
					<!--温度 -->
					var dataset1 = [];
					<!--电导率-->
					var dataset2 = [];
					<!--深度-->
					var dataset3 = [];
					<!--浊度-->
					var dataset4 = [];
					<!--溶解氧-->
					var dataset5 = [];
					var now = [];
					for ( var i in result) {
							dataset1.push(result[i].temperature);
							dataset2.push(result[i].conduct);
							dataset3.push(result[i].depth);
							dataset4.push(result[i].NTU);
							dataset5.push(result[i].oxy);
						now.push(result[i].date);
					}
					myChart.hideLoading();
					myChart.setOption({
						xAxis : [ {
							data : now
						}, {
							data : now,
						} ],
						series : [ {
							name : '温度',
							data : dataset1
						}, {
							name : '电导率',
							data : dataset2
						},{
							name : '溶解氧',
							data : dataset5
						},{
							name : '浊度',
							data : dataset4
						},{
							name : '深度',
							data : dataset3
						} ]
					});

				}
			};
	</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>选择两个要素观察</title>
</head>
<script src="echarts.min.js"></script>
<script src="jquery-3.3.1.min.js"></script>
<body>

	<form id="input">
		<input type="checkbox" name="elements" value="temperature"><span>温度</span>
		<input type="checkbox" name="elements" value="conduct"><span>电导率</span>
		<input type="checkbox" name="elements" value="depth"><span>深度</span>
		<input type="checkbox" name="elements" value="volts1"><span>第一外部电压</span>
		<input type="checkbox" name="elements" value="volts2"><span>第二外部电压</span>
		<input type="checkbox" name="elements" value="NTU"><span>浊度</span>
		<input type="checkbox" name="elements" value="oxy"><span>溶解氧</span>
		<p>
			<button type="button" onclick="loadGraph();">提交并查看数据</button>
	</form>
	<p>
	<div id="main"
		style="width: 1200px; height: 800px; align: center; margin: 0px auto;"></div>
	<!-- initialize my chart -->
	<script type="text/javascript">
		var myChart = echarts.init(document.getElementById('main'));
		var colors = [ '#5793f3', '#d14a61' ];
		option = {
			color : colors,
			title : {
				text : '',
				x : 'center'
			},
			tooltip : {
				trigger : 'axis',
				axisPointer : {
					animation : false
				}
			},
			legend : {
				data : [],
				x : 'left'
			},
			toolbox : {
				feature : {
					dataZoom : {
						yAxisIndex : 'none'
					},
					restore : {},
					saveAsImage : {}
				}
			},
			axisPointer : {
				link : {
					xAxisIndex : 'all'
				}
			},
			dataZoom : [ {
				show : true,
				realtime : true,
				start : 30,
				end : 70,
				xAxisIndex : [ 0, 1 ]
			}, {
				type : 'inside',
				realtime : true,
				start : 30,
				end : 70,
				xAxisIndex : [ 0, 1 ]
			} ],
			grid : [ {
				left : 50,
				right : 50,
				height : '35%'
			}, {
				left : 50,
				right : 50,
				top : '55%',
				height : '35%'
			} ],
			xAxis : [ {
				type : 'category',
				boundaryGap : false,
				axisLine : {
					onZero : true,
					lineStyle : {
						color : colors[0]
					}
				},
				data : []
			}, {
				gridIndex : 1,
				type : 'category',
				boundaryGap : false,
				axisLine : {
					onZero : true,
					lineStyle : {
						color : colors[0]
					}
				},
				data : [],
				position : 'top'
			} ],
			yAxis : [ {
				name : '',
				type : 'value',
			}, {
				gridIndex : 1,
				name : '',
				type : 'value',
				inverse : true
			} ],
			series : [ {
				name : '',
				type : 'line',
				hoverAnimation : false,
				data : []
			}, {
				name : '',
				type : 'line',
				xAxisIndex : 1,
				yAxisIndex : 1,
				hoverAnimation : false,
				data : []
			} ]
		};
		myChart.setOption(option);
		myChart.showLoading();
	</script>


	<script>
		function loadGraph() {
			if ($("input[name='elements']:checked").length < 2) {
				alert("你必须选择两个要素");
				location.reload();
			}
			var obj = document.getElementsByName("elements");
			var lName = [];
			var message = '';
			for (var k = 0; k < obj.length; k++) {
				if (obj[k].checked) {
					message += obj[k].value + ",";
					switch (obj[k].value) {
					case "temperature":
						lName.push('温度');
						break;
					case "conduct":
						lName.push('电导率');
						break;
					case "depth":
						lName.push('深度');
						break;
					case "volts1":
						lName.push('第一外部电压');
						break;
					case "volts2":
						lName.push('第二外部电压');
						break;
					case "NTU":
						lName.push('浊度');
						break;
					case "oxy":
						lName.push('溶解氧');
						break;
					}
				}
			}
			var xmlRequest = null;
			if (window.XMLHttpRequest) {// code for all new browsers
				xmlRequest = new XMLHttpRequest();
			} else if (window.ActiveXObject) {// code for IE5 and IE6
				xmlRequest = new ActiveXObject("Microsoft.XMLHTTP");
			}
			if (xmlRequest != null) {
				xmlRequest.open("GET",
						"${pageContext.request.contextPath}/LineGraphServlet?input="
								+ message, true);
				xmlRequest.send();
			} else {
				alert("Your brower doesn't support XMLHTTP; You'd better change to another brower");
				location.reload();
			}
			xmlRequest.onreadystatechange = function() {
				if (xmlRequest.readyState == 4 && xmlRequest.status == 200) {
					var result = eval('(' + xmlRequest.responseText + ')');
					var dataset1 = [];
					var dataset2 = [];
					var unit = [];
					var now = [];
					for ( var i in result) {
						if (lName[0] == '温度') {
							dataset1.push(result[i].temperature);
							unit.push('摄氏度');
						} else if (lName[0] == '电导率') {
							dataset1.push(result[i].conduct);
							unit.push('S/m');
						} else if (lName[0] == '深度') {
							dataset1.push(result[i].depth);
							unit.push('米');
						} else if (lName[0] == '第一外部电压') {
							dataset1.push(result[i].volts1);
							unit.push('volts');
						} else if (lName[0] == '第二外部电压') {
							dataset1.push(result[i].volts2);
							unit.push('volts');
						} else if (lName[0] == '浊度') {
							dataset1.push(result[i].NTU);
							unit.push('NTU');
						} else if (lName[0] == "溶解氧") {
							dataset1.push(result[i].oxy);
							unit.push('umol/kg');
						}
						if (lName[1] == '温度') {
							dataset2.push(result[i].temperature);
							unit.push('摄氏度');
						} else if (lName[1] == '电导率') {
							dataset2.push(result[i].conduct);
							unit.push('S/m');
						} else if (lName[1] == '深度') {
							dataset2.push(result[i].depth);
							unit.push('米');
						} else if (lName[1] == '第一外部电压') {
							dataset2.push(result[i].volts1);
							unit.push('volts');
						} else if (lName[1] == '第二外部电压') {
							dataset2.push(result[i].volts2);
							unit.push('volts');
						} else if (lName[1] == '浊度') {
							dataset2.push(result[i].NTU);
							unit.push('NTU');
						} else if (lName[1] == "溶解氧") {
							dataset2.push(result[i].oxy);
							unit.push('umol/kg');
						}
						now.push(result[i].date);
					}
					myChart.hideLoading();
					myChart.setOption({
						title : {
							text : lName[0] + '与' + lName[1] + "关系图"
						},
						legend : {
							data : lName
						},
						xAxis : [ {
							data : now
						}, {
							data : now,
						} ],
						yAxis : [ {
							name : lName[0] + ' (' + unit[0] + ')',
						}, {

							name : lName[1] + ' (' + unit[1] + ')',
						} ],
						series : [ {
							name : lName[0],
							data : dataset1
						}, {
							name : lName[1],
							data : dataset2
						} ]
					});

				}
			};
		};
		//<!-- jquery to trace the number of checked checkbox-->
		$(document).ready(function() {
			$('input[type=checkbox]').click(function() {
				$(this).attr('disabled', 'disabled');
				if ($("input[name='elements']:checked").length >= 2) {
					$("input[name='elements']").attr('disabled', 'disabled');
				}
			});
		});
	</script>
</body>
</html>
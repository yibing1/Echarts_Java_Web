<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>格式化数据</title>
<script type="text/javascript" src="getUrlParam.js"></script>
<link rel="stylesheet" type="text/css" href="jquery.dataTables.min.css">

<!--引入JavaScript-->
<script type="text/javascript" src="jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="jquery.dataTables.js"></script>
<style>
.align{ 
	text-align: center;
	vertical-align: middle!important;
}</style>
</head>
<body>
	<table id="myTable" class="display align" style="width: 100%">
	</table>
	<script>
		var fileName=UrlParm.parm("fileName");
		var dataset=[];
		var xmlRequest = null;
		if (window.XMLHttpRequest) {// code for all new browsers
			xmlRequest = new XMLHttpRequest();
		} else if (window.ActiveXObject) {// code for IE5 and IE6
			xmlRequest = new ActiveXObject("Microsoft.XMLHTTP");
		}
		if (xmlRequest != null) {
			xmlRequest.open("GET",
					"${pageContext.request.contextPath}/ReadServlet?input="
							+ fileName, true);
			xmlRequest.send();
		} else {
			alert("Your brower doesn't support XMLHTTP; You'd better change to another brower");
			location.reload();
		}
		xmlRequest.onreadystatechange = function() {
			if (xmlRequest.readyState == 4 && xmlRequest.status == 200) {
				var result = eval('(' + xmlRequest.responseText + ')');
				for ( var i=0;i<result.length;i++) {
					var dataEntry=[];
					dataEntry.push(result[i].name);
					dataEntry.push(result[i].id);
					dataEntry.push(result[i].temperature);
					dataEntry.push(result[i].conduct);
					dataEntry.push(result[i].depth);
					dataEntry.push(result[i].volts1);
					dataEntry.push(result[i].volts2);
					dataEntry.push(result[i].NTU);
					dataEntry.push(result[i].oxy);
					dataEntry.push(result[i].date);
					dataset.push(dataEntry);
				}
				
			    $('#myTable').DataTable( {
			        data: dataset,
			        columns: [
			            { title: "接驳盒编号" },
			            { title: "仪器编号" }, 
			            { title: "温度 (℃) " }, 
			            { title: "电导率 (S/m)" }, 
			            { title: "深度 (米)" },
			            { title: "第一外部电压 (volts)" },
			            { title: "第二外部电压 (volts)" },
			            { title: "浊度 (NTU)" },
			            { title: "溶解氧 (umol/kg)" },
			            { title: "采集时间" }

			        ]
			    } );	
			}
		}
	</script>
</body>
</html>
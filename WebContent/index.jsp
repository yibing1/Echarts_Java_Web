<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home Page</title>
<script src="jquery-3.3.1.min.js"></script>
</head>
<body>
	<!-- 第一个功能 查看所有数据-->
	<p style="font-weight:bold;">功能1：读取文件并查看所有数据</p>
	<div>
		<form id="form">
			选择想要的文件来查看数据<br /> <select id="input" name="selection"><option
					value="data.dat">data.dat</option>
			</select> 
			<input type="button" id="but" value='查看格式化数据'></input>
		</form>
	</div>
	<script>
	$("#but").click(function () {
	var p1 = $("#input").children('option:selected').val(); //这就是selected的值
	window.open("table.jsp?fileName="+p1) ;
	});
	</script>
	<!-- 第二个功能  动态查询-->
	<div>
		<h2>
			<a href="dynamicGraph.jsp" target="_blank">功能2：观测要素动态展示</a>
		</h2>
	</div>
	<!-- 第三个功能 选择两个要素观测 -->
	<div>
		<h2>
			<a href="graph.jsp" target="_blank">功能3：观测要素之间的关系图 </a>
		</h2>
	</div>
	<!-- 第四个功能 各个元素与时间关系 -->
	<div>
		<h2>
			<a href="multipleGraph.jsp" target="_blank">功能4：观测要素和时间的关系图</a>
		</h2>
	</div>
	<div>
		<h2>
			<a href="report.pdf" target="_blank">查看报告</a>
		</h2>
	</div>
</body>
</html>
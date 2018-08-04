<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home Page</title>
</head>
<body>
	<!-- 第一个功能 查看所有数据-->
	<h2>功能1：读取文件并查看所有数据</h2>
	<div class="div1">
		<form id="form" action="DataServlet">
			选择想要的文件来查看数据<br /> <select name="selection"><option
					value="data.dat">data.dat</option>
			</select> <input type="submit" value="Submit" />
		</form>
	</div>
	<!-- 第二个功能  动态查询-->
	<div>
		<h2>
			<a href="dynamicGraph.jsp">功能2：观测要素动态展示</a>
		</h2>
	</div>
	<!-- 第三个功能 选择两个要素观测 -->
	<div>
		<h2>
			<a href="staticGraph.jsp">功能3：选择两个要素进行观测(单图像) </a>
		</h2>
	</div>
		<!-- 第四个功能 选择两个要素观测 -->
	<div>
		<h2>
			<a href="multipleGraph.jsp">功能4：选择两个要素进行观测(多图像)</a>
		</h2>
	</div>

</body>
</html>
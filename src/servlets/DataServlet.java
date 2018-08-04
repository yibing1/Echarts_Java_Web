package servlets;


import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import data.DataDemo;
import data.Reader;

/**
 * Servlet implementation class SimpleServlet
 */
@WebServlet("/DataServlet")
public class DataServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DataServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		response.setCharacterEncoding("utf-8");
		request.setCharacterEncoding("utf-8");
		PrintWriter writer=response.getWriter();
		String fileName = request.getParameter("selection");
		Reader read=new Reader();
		List<DataDemo> list = read.readList(fileName);
		String message=writeToHTML(list);
		writer.println(message);
		writer.flush();
		writer.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	/**
	 * private helper method to generate inner HTML string
	 * @param list is a list of information
	 * @return html string
	 */
	private String writeToHTML(List<DataDemo> list) {
		String message = "<table border='1' style='text-align:center;text-family:Times New Roman,Times,serif;width:196px;'><th>�Ӳ��б��</th><th>�������</th><th>�¶�(���϶�)</th><th>�絼��(S/m)</th><th>���(m)</th><th>��һ�ⲿ��ѹ(volts)</th><th>�ڶ��ⲿ��ѹ(volts)</th><th>�Ƕ�(NTU)</th><th>�ܽ���(umol/kg)</th><th>�ɼ�ʱ��</th></tr>";
		for (DataDemo t : list) {
			message += "<tr><td>" + t.getName() + "</td>";
			message += "<td>" + t.getId() + "</td>";
			message += "<td>" + t.getTemperature() + "</td>";
			message += "<td>" + t.getConduct() + "</td>";
			message += "<td>" + t.getDepth() + "</td>";
			message += "<td>" + t.getVolts1() + "</td>";
			message += "<td>" + t.getVolts2() + "</td>";
			message += "<td>" + t.getNTU() + "</td>";
			message += "<td>" + t.getOxy() + "</td>";
			message += "<td>" + t.getDate() + "</td></tr>";
		}
		message += "</table>";
		return message;
	}
}

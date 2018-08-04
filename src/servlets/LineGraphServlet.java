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
import net.sf.json.JSONArray;

/**
 * Servlet implementation class LineGraphServlet
 */
@WebServlet("/LineGraphServlet")
public class LineGraphServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public LineGraphServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/json");
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		String input = request.getParameter("input");
		String []inputs=input.split(",");
		if(inputs.length>=2) {
		    String input1 = inputs[0];
	        String input2 = inputs[1];
	        PrintWriter printWriter = response.getWriter();

	        Reader read = new Reader();
	        List<DataDemo> list = read.readList("data.dat");
	        String jsonString="[";
	        for (int i=0;i<list.size();i++) {
	            jsonString+="{\"";
	            switch (input1) {
	            case "temperature":
	                jsonString+="temperature\":\""+list.get(i).getTemperature()+"\",";
	                break;
	            case "conduct":
	                jsonString+="conduct\":\""+list.get(i).getConduct()+"\",";
	                break;
	            case "depth":
	                jsonString+="depth\":\""+list.get(i).getDepth()+"\",";
	                break;
	            case "volts1":
	                jsonString+="volts1\":\""+list.get(i).getVolts1()+"\",";
	                break;
	            case "volts2":
	                jsonString+="volts2\":\""+list.get(i).getVolts2()+"\",";
	                break;
	            case "NTU":
	                jsonString+="NTU\":\""+list.get(i).getNTU()+"\",";
	                break;
	            case "oxy":
	                jsonString+="oxy\":\""+list.get(i).getOxy()+"\",";
	                break;
	            }
	            switch (input2) {
	            case "temperature":
	                jsonString+="\"temperature\":\""+list.get(i).getTemperature()+"\",";
	                break;
	            case "conduct":
	                jsonString+="\"conduct\":\""+list.get(i).getConduct()+"\",";
	                break;
	            case "depth":
	                jsonString+="\"depth\":\""+list.get(i).getDepth()+"\",";
	                break;
	            case "volts1":
	                jsonString+="\"volts1\":\""+list.get(i).getVolts1()+"\",";
	                break;
	            case "volts2":
	                jsonString+="\"volts2\":\""+list.get(i).getVolts2()+"\",";
	                break;
	            case "NTU":
	                jsonString+="\"NTU\":\""+list.get(i).getNTU()+"\",";
	                break;
	            case "oxy":
	                jsonString+="\"oxy\":\""+list.get(i).getOxy()+"\",";
	                break;
	            }
	            jsonString+="\"date\":\""+list.get(i).getDate()+"\"}";
	            //System.out.println(list.get(i).getVolts1()+" "+list.get(i).getVolts2());
	            if(i!=list.size()-1) {
	                jsonString+=",";
	            }
	        }
	        jsonString+="]";
	        JSONArray array = JSONArray.fromObject(jsonString);;
	        //System.out.println(array);
	        printWriter.write(array.toString());
	        printWriter.flush();
	        printWriter.close(); 
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}

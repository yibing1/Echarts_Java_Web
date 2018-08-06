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
 * Servlet implementation class ReadServlet
 */
@WebServlet("/ReadServlet")
public class ReadServlet extends HttpServlet
{
    private static final long serialVersionUID = 1L;


    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReadServlet()
    {
        super();
        // TODO Auto-generated constructor stub
    }


    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     *      response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("utf-8");
        request.setCharacterEncoding("utf-8");
        PrintWriter writer = response.getWriter();
        String fileName = request.getParameter("input");
        if (fileName != null)
        {
            Reader read = new Reader();
            String savePath = this.getServletContext().getRealPath("/WEB-INF/files");
            List<DataDemo> list = read.readList(savePath + "/" + fileName);
            String jsonString = "[";
            for (int i = 0; i < list.size(); i++)
            {
                jsonString += "{\"name\":\"" + list.get(i).getName() + "\",";
                jsonString += "\"id\":\"" + list.get(i).getId() + "\",";
                jsonString += "\"temperature\":\"" + list.get(i).getTemperature() + "\",";
                jsonString += "\"conduct\":\"" + list.get(i).getConduct() + "\",";
                jsonString += "\"depth\":\"" + list.get(i).getDepth() + "\",";
                jsonString += "\"volts1\":\"" + list.get(i).getVolts1() + "\",";
                jsonString += "\"volts2\":\"" + list.get(i).getVolts2() + "\",";
                jsonString += "\"NTU\":\"" + list.get(i).getNTU() + "\",";
                jsonString += "\"oxy\":\"" + list.get(i).getOxy() + "\",";
                jsonString += "\"date\":\"" + list.get(i).getDate() + "\"}";
                // System.out.println(list.get(i).getVolts1()+"
                // "+list.get(i).getVolts2());
                if (i != list.size() - 1)
                {
                    jsonString += ",";
                }
            }
            jsonString += "]";
            JSONArray array = JSONArray.fromObject(jsonString);
            writer.write(array.toString());
            writer.flush();
            writer.close();
        }

    }


    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     *      response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        // TODO Auto-generated method stub
        doGet(request, response);
    }

}

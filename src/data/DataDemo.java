package data;
/**
 * Model Class to mock raw data as
 * 
 * @author Yibing Zhang
 */
public class DataDemo
{
    private String name;//接驳盒编号
    private String id;//仪器编号
    private double temperature;//温度
    private double conduct;//电导率
    private double depth;//深度
    private double volts1;//第一外部电压
    private double volts2;//第二外部电压
    private double NTU;//浊度
    private double oxy;//溶解氧
    private String date;//观测日期


    public DataDemo(
        String name,
        String id,
        String temperature,
        String conduct,
        String depth,
        String volts1,
        String volts2,
        String NTU,
        String oxy,
        String date)
    {
        this.name = name;
        this.id = id;
        this.temperature = Double.parseDouble(temperature);
        this.conduct = Double.parseDouble(conduct);
        this.depth = Double.parseDouble(depth);
        this.volts1 = Double.parseDouble(volts1);
        this.volts2 = Double.parseDouble(volts2);
        this.NTU = Double.parseDouble(NTU);
        this.oxy = Double.parseDouble(oxy);
        this.date = date;
    }

/**
 * 获得接驳盒编号
 * @return name
 */
    public String getName()
    {
        return name;
    }

/**
 * 设置接驳盒编号
 * @param name
 * 			is the name of junction box
 */
    public void setName(String name)
    {
        this.name = name;
    }

/**
 * 获得仪器编号
 * @return the id
 */
    public String getId()
    {
        return id;
    }

/**
 * 设置仪器编号
 * @param id
 */
    public void setId(String id)
    {
        this.id = id;
    }

/**
 * 获得温度
 * @return
 */
    public double getTemperature()
    {
        return temperature;
    }

/**
 * 设置温度
 * @param temperature
 */
    public void setTemperature(double temperature)
    {
        this.temperature = temperature;
    }

/**
 * 获得导电率
 * @return
 */
    public double getConduct()
    {
        return conduct;
    }

/**
 * 设置导电率
 * @param conduct
 */
    public void setConduct(double conduct)
    {
        this.conduct = conduct;
    }

/**
 * 获取深度
 * @return
 */
    public double getDepth()
    {
        return depth;
    }

/**
 * 设置深度
 * @param depth
 */
    public void setDepth(double depth)
    {
        this.depth = depth;
    }

/**
 * 获得第一外部电压
 * @return
 */
    public double getVolts1()
    {
        return volts1;
    }
/**
 * 设置第一外部电压
 * @param volts1
 */
    public void setVolts1(double volts1)
    {
        this.volts1 = volts1;
    }

    /**
     * 获得第二外部电压
     * @param volts1
     */
    public double getVolts2()
    {
        return volts2;
    }

/**
 * 获得第二外部电压
 * @param volts2
 */
    public void setVolts2(double volts2)
    {
        this.volts2 = volts2;
    }

/**
 * 获得浊度
 * @return
 */
    public double getNTU()
    {
        return NTU;
    }

/**
 * 设置浊度
 * @param nTU
 */
    public void setNTU(double nTU)
    {
        NTU = nTU;
    }

/**
 * 获得溶解氧
 * @return
 */
    public double getOxy()
    {
        return oxy;
    }

/**
 * 设置溶解氧
 * @param oxy
 */
    public void setOxy(double oxy)
    {
        this.oxy = oxy;
    }

/**
 * 获得时间
 * @return
 */
    public String getDate()
    {
        return date;
    }

/**
 * 设置时间
 * @param date
 */
    public void setDate(String date)
    {
        this.date = date;
    }

/**
 * toString method
 * 
 */
    @Override
    public String toString()
    {
        return name + ", " + id + ", " + temperature + "," + conduct + ", "
            + depth + ", " + volts1 + ", " + volts2 + "," + NTU + ", " + oxy
            + ", " + date;
    }

}

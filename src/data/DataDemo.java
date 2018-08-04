package data;
/**
 * Model Class to mock raw data as
 * 
 * @author Yibing Zhang
 */
public class DataDemo
{
    private String name;//�Ӳ��б��
    private String id;//�������
    private double temperature;//�¶�
    private double conduct;//�絼��
    private double depth;//���
    private double volts1;//��һ�ⲿ��ѹ
    private double volts2;//�ڶ��ⲿ��ѹ
    private double NTU;//�Ƕ�
    private double oxy;//�ܽ���
    private String date;//�۲�����


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
 * ��ýӲ��б��
 * @return name
 */
    public String getName()
    {
        return name;
    }

/**
 * ���ýӲ��б��
 * @param name
 * 			is the name of junction box
 */
    public void setName(String name)
    {
        this.name = name;
    }

/**
 * ����������
 * @return the id
 */
    public String getId()
    {
        return id;
    }

/**
 * �����������
 * @param id
 */
    public void setId(String id)
    {
        this.id = id;
    }

/**
 * ����¶�
 * @return
 */
    public double getTemperature()
    {
        return temperature;
    }

/**
 * �����¶�
 * @param temperature
 */
    public void setTemperature(double temperature)
    {
        this.temperature = temperature;
    }

/**
 * ��õ�����
 * @return
 */
    public double getConduct()
    {
        return conduct;
    }

/**
 * ���õ�����
 * @param conduct
 */
    public void setConduct(double conduct)
    {
        this.conduct = conduct;
    }

/**
 * ��ȡ���
 * @return
 */
    public double getDepth()
    {
        return depth;
    }

/**
 * �������
 * @param depth
 */
    public void setDepth(double depth)
    {
        this.depth = depth;
    }

/**
 * ��õ�һ�ⲿ��ѹ
 * @return
 */
    public double getVolts1()
    {
        return volts1;
    }
/**
 * ���õ�һ�ⲿ��ѹ
 * @param volts1
 */
    public void setVolts1(double volts1)
    {
        this.volts1 = volts1;
    }

    /**
     * ��õڶ��ⲿ��ѹ
     * @param volts1
     */
    public double getVolts2()
    {
        return volts2;
    }

/**
 * ��õڶ��ⲿ��ѹ
 * @param volts2
 */
    public void setVolts2(double volts2)
    {
        this.volts2 = volts2;
    }

/**
 * ����Ƕ�
 * @return
 */
    public double getNTU()
    {
        return NTU;
    }

/**
 * �����Ƕ�
 * @param nTU
 */
    public void setNTU(double nTU)
    {
        NTU = nTU;
    }

/**
 * ����ܽ���
 * @return
 */
    public double getOxy()
    {
        return oxy;
    }

/**
 * �����ܽ���
 * @param oxy
 */
    public void setOxy(double oxy)
    {
        this.oxy = oxy;
    }

/**
 * ���ʱ��
 * @return
 */
    public String getDate()
    {
        return date;
    }

/**
 * ����ʱ��
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

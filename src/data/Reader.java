package data;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

/**
 * Reader class to read file
 * @author Yibing Zhang
 *
 */
public class Reader {
    public Reader() {
        
    }
	public List<DataDemo> readList(String fileName) throws FileNotFoundException {
	    File file=new File(fileName);
		Scanner scan=new Scanner(file);
		List<DataDemo> lists=new ArrayList<DataDemo>();
        while (scan.hasNextLine())
        {
        	
            String line = scan.nextLine();
            String temp2[] = line.split("}");
            if (temp2.length > 2)
            {
                String[] t = temp2[0].split(",");
                String name = t[0].substring(1);
                String[] t2 = temp2[temp2.length - 1].split(",");
                DataDemo d = new DataDemo(name, t[1], t2[0], t2[1], t2[2],
                    t2[3], t2[4], t2[5], t2[6], t2[7]);
                lists.add(d);
            }
        }
		scan.close();
		return lists;
	}
}
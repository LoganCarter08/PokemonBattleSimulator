import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.RandomAccessFile;
import java.util.*;
/**
* reads moves file and makes xml database
*/
public class MoveWriter
{
    RandomAccessFile com; // holds the commands to execute
    FileWriter out; // log file
    String dataFile;
	List<String> list;
    public MoveWriter() throws IOException
    {
        com = new RandomAccessFile("move.txt", "r");
        out = new FileWriter("Moves.xml");
		list = new ArrayList<String>();
        // output header to log file with important info
        out.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
        out.write("<moves>\n");
        String line = com.readLine(); // read first line in
        // pokemon number
        int count = 1;
        int damageCheck = 0;
        out.write("\t<move>\n");
		// while not at the end of the file
        while (line != null)
        {
            String split[] = line.split("\\s+");
            // get the name listed
            if (split[0].equals("Move:"))
            {
                String name = "";
                for (int i = 1; i < split.length; i++)
                {
                    name = name + split[i];
                }
				// create list of moves
				list.add(list.size(), name.replaceAll(" ", ""));
                out.write("\t\t<name>" + name.replaceAll(" ", "") + "</name>\n");
            }
			// read the damage, it is dice based, need to parse it
            else if (split[0].equals("Damage:"))
            {
                String d[] = split[1].split("d|\\+");
                if (d.length > 1)
                {
                    out.write("\t\t<damage>" + d[1] + "</damage>\n");
                    damageCheck = 1;
                }
                else
                {
                    out.write("\t\t<damage>" + d[0] + "</damage>\n");
                    damageCheck = 1;
                }
            }
			// get move type
            else if (split[0].equals("Type:"))
            {
                out.write("\t\t<type>" + split[1] + "</type>\n");
            }
            // if next move is found
            else if (split[0].equals("&&"))
            {
                if (damageCheck == 0)
                {
                    out.write("\t\t<damage>" + 0 + "</damage>\n");
                }
                damageCheck = 0;
                out.write("\t</move>\n\t<move>\n");
				count++;
            }
            line = com.readLine();
        }
        out.write("</moves>");
        out.close();
		System.out.println(count + " Number of moves.\n");
		PokemonWriter poke = new PokemonWriter(list);
    }
}

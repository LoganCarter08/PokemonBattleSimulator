import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.RandomAccessFile;
import java.util.*;
import java.io.FileInputStream;
import java.io.InputStream;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
/**
* class to pull pokemon from text file and create xml database
*/
public class PokemonWriter
{
    RandomAccessFile com; // holds the commands to execute
    FileWriter out; // log file
    String dataFile;
    public PokemonWriter(List<String> list) throws IOException
    {
		//System.out.println(list);
        com = new RandomAccessFile("poke2.txt", "r");
        out = new FileWriter("Pokemon.xml");
		
        // output header to log file with important info
        out.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
        out.write("<pokemon>\n");
        String line = com.readLine(); // read first line in

        // pokemon number
        int count = 1;
		int moves = 0;
        out.write("\t<poke>\n");
        while (line != null)
        {
            String split[] = line.split("\\s+");
            // get the name listed
            if (split[0].equals("Name:"))
            {
                String name = "";
				// if name had spaces
                for (int i = 1; i < split.length; i++)
                {
                    name = name + split[i];
                }
				
				// manipulate name to search it
				String tempName;
				// remove unwanted chars and make lower case
				tempName = name.toLowerCase();
				tempName = tempName.replaceAll(" |\\.", "\\-");
				tempName = tempName.replaceAll("\\'", "");
				// mime jr doesn't not follow naming consistencies on site
				if (tempName.equals("mimejr-"))
				{
					tempName = "mime-jr";
				}
				// create request url and retrieve and download sprites
				String url = "http://www.pokestadium.com/sprites/black-white/back/" + tempName + ".png";
				saveImage(url, "sprites/" + name + " back.png");
				
				

				// remove unwanted chars and make lower case
				tempName = name.toLowerCase();
				tempName = tempName.replaceAll(" |\\.", "\\-");
				tempName = tempName.replaceAll("\\'", "");
				// mime jr doesn't not follow naming consistencies on site
				if (tempName.equals("mimejr-"))
				{
					tempName = "mime-jr";
				}
				// create request url and retrieve and download sprites
				url = "http://www.pokestadium.com/sprites/black-white/" + tempName + ".png";
				saveImage(url, "sprites/" + name + " front.png");
				
                out.write("\t\t<name>" + name + "</name>\n");
            }
			// store number, useful later
			else if (split[0].equals("Nat_Num:"))
            {
                out.write("\t\t<num>" + Integer.parseInt(split[1]) + "</num>\n");
            }
			// damage contains dice values, remove these
            else if (split[0].equals("Damage:"))
            {
                String d[] = split[1].split("d|\\+");
                if (d.length > 1)
                {
                    out.write("\t\t<damage>" + d[1] + "</damage>\n");
                }
                else
                {
                    out.write("\t\t<damage>" + d[0] + "</damage>\n");
                }
            }
			// pokemon types
            else if (split[0].equals("Type_1:"))
            {
                out.write("\t\t<type1>" + split[1] + "</type1>\n");
            }
			else if (split[0].equals("Type_2:"))
            {
                out.write("\t\t<type2>" + split[1] + "</type2>\n");
            }
			
			
			// stats are listed in row, parse them
			else if (split[0].equals("Base_Stats:"))
            {
				String newLine[] = line.split(", ");
				int hp = Integer.parseInt(newLine[1].replaceAll(",| ", "")) * 10;
				int attack = Integer.parseInt(newLine[2]) * 10;
                out.write("\t\t<hp>" + hp + "</hp>\n");
				out.write("\t\t<attack>" + attack + "</attack>\n");
            }
			// another type of moves
			else if(split[0].equals("High_Abilities:"))
			{
				String newLine[] = line.split(":|,|/");
				// make sure the move is one we have record of
				if (list.contains(split[1].replaceAll(",| ", "")))
				{
					out.write("\t\t<moves3>" + split[1].replaceAll(",| ", "") + ",");
				}
				else 
				{
					out.write("\t\t<moves3>");
				}
				// if more than one move on line
				if (newLine.length > 2)
				{
					for (int i = 2; i < newLine.length; i++)
					{
						if (list.contains(newLine[i].replaceAll(",| ", "")))
						{
							out.write(newLine[i].replaceAll(",| ", "") + ",");
						}
					}
				}
				// read until next data entry type
				line = com.readLine();
				while (!line.split("\\s+")[0].equals("TM_List:") && !line.split("\\s+")[0].equals("Tutor_Moves:") && !line.split("\\s+")[0].equals("Capture_Rate:") && !line.split("\\s+")[0].equals("Moves:"))
				{
					if (list.contains(line.split(":")[1].replaceAll(",| ", "")))
					{
						out.write(line.split(":")[1].replaceAll(",| ", "") + ",");
					}
					line = com.readLine();
				}
				out.write("</moves3>\n");
			}
			// read in moves
			else if(split[0].equals("Moves:"))
			{
				String newLine[] = line.split(":|,");
				if (list.contains(split[1].replaceAll(",| ", "")))
				{
					out.write("\t\t<moves>" + split[1].replaceAll(",| ", "") + ",");
				}
				else 
				{
					out.write("\t\t<moves>");
				}
				if (newLine.length > 2)
				{
					for (int i = 2; i < newLine.length; i++)
					{
						if (list.contains(newLine[i].replaceAll(",| ", "")))
						{
							out.write(newLine[i].replaceAll(",| ", "") + ",");
						}
					}
				}
				line = com.readLine();
				while (!line.split("\\s+")[0].equals("TM_List:") && !line.split("\\s+")[0].equals("Tutor_Moves:") && !line.split("\\s+")[0].equals("Capture_Rate:") && !line.split("\\s+")[0].equals("Moves:"))
				{
					if (list.contains(line.split(":")[1].replaceAll(",| ", "")))
					{
						out.write(line.split(":")[1].replaceAll(",| ", "") + ",");
					}
					line = com.readLine();
				}
				out.write("</moves>\n");
			}
			// read in another type of moves
			else if(split[0].equals("Tutor_Moves:"))
			{
				String newSplit[] = line.split(":|,");
				if (list.contains(newSplit[1].replaceAll(",| ", "")))
				{
					out.write("\t\t<moves2>" + newSplit[1].replaceAll(",| ", "") + ",");
				}
				else 
				{
					out.write("\t\t<moves2>");
				}
				
				for (int i = 2; i < newSplit.length; i++)
				{
					if (list.contains(newSplit[i].replaceAll(",| ", "")))
					{
						out.write(newSplit[i].replaceAll(",| ", "") + ",");
					}
				}
				out.write("</moves2>\n");
			}
			
			// next pokemon is listed
            else if (split[0].equals("&&"))
            {
                out.write("\t</poke>\n\t<poke>\n");
				moves = 0;
				count++;
            }
            line = com.readLine();
        }
		out.write("\t</poke>\n");
        out.write("</pokemon>");
        out.close();
		System.out.println(count + " Number of Pokemon.\n");
    }
	
	
	// this came from here: https://gist.github.com/gitchandu/4678746 I did not write it
	public void saveImage(String imageUrl, String destinationFile) throws IOException {
		try
		{
			URL url = new URL(imageUrl);
			InputStream is = url.openStream();
			OutputStream os = new FileOutputStream(destinationFile);

			byte[] b = new byte[2048];
			int length;

			while ((length = is.read(b)) != -1) {
				os.write(b, 0, length);
			}

			is.close();
			os.close();
		} catch (Exception c)
		{
			System.out.println("did not find " + imageUrl);
		}
	}
}

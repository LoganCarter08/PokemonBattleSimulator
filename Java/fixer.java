import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.RandomAccessFile;
import java.util.*;
/**
* adds another line to text file, helps with PokemonWriter logic.
*/
public class fixer
{
    static RandomAccessFile com; // holds the commands to execute
    static FileWriter out; // log file

    public fixer() throws IOException
    {
		com = new RandomAccessFile("poke.txt", "r");
        out = new FileWriter("poke2.txt");
		
		String line = com.readLine(); // read first line in

        while (line != null)
		{
			line = line.replaceAll("Moves", line + "\nMoves");
			out.write(line + "\n");
			line = com.readLine();
		}
	}
}
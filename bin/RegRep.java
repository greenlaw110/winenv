import java.io.*;
import java.util.*;
import java.net.*;
import java.util.regex.*;

public class RegRep
{
	public static final PrintStream out = System.out;
	public static void main(String[] args)
	{
		String reg = args[1];
		String rep = args[2];
		String s = args[0];
		out.println("string: " + s);
		out.println("regexp: " + reg);
		out.println("replaced: " + s.replaceAll(reg, rep));
	}
}

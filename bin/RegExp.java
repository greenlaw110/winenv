import java.io.*;
import java.util.*;
import java.net.*;
import java.util.regex.*;

public class RegExp
{
	public static final PrintStream out = System.out;
	public static void main(String[] args)
	{
		String s = args[0];
		String reg = args[1];
		out.println("string: " + s);
		out.println("regexp: " + reg);
		Pattern p = Pattern.compile(reg);
		Matcher m = p.matcher(s);
		out.println("pattern matches?" + m.matches());
		out.println("group count:" + m.groupCount());
		for (int i = 0; i < m.groupCount(); ++i)
		{
			out.println("group#" + i + ": " + m.group(i));
		}
	}
}

import java.util.*;

public class JavaString
{
	public static void main(String[] args)
	{
		String s = args[0];
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < s.length(); ++i)
		{
			char c = s.charAt(i);
			sb.append(c);
			if (c == '\\')
			{
				sb.append(c);
			}
		}

		System.out.println(sb.toString());
	}
}

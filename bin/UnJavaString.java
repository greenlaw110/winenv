import java.util.*;

public class UnJavaString
{
	public static void main(String[] args)
	{
		String s = args[0];
		StringBuffer sb = new StringBuffer();
		boolean f = false;
		for (int i = 0; i < s.length(); ++i)
		{
			char c = s.charAt(i);
			if (f)
			{
				if (c == '\\')
				{
					f = false;
					/* skip second time '\' */
					continue;
				}
			}
			if (c == '\\')
			{
				f = true;
			}
			else
			{
				f = false;
			}
			sb.append(c);
		}

		System.out.println(sb.toString());
	}
}

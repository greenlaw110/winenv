import java.text.SimpleDateFormat;
import java.util.Date;

public class Today {
	public static void main(String[] args) {
		Date today = new Date();
		
		SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
		System.out.print(fmt.format(today));
	}
}

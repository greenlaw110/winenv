import java.util.*;
import java.text.*;

public class TsDate {
  public static void main(String[] args) {
    long ts = Long.parseLong(args[0]);
    Date d = new Date(ts);
    System.out.println(new SimpleDateFormat("yyyy-MM-dd").format(d));
  }
}
package util;

public class Utils {

    public static final String LF = "\n";

    public static void puts_e(Object... os) {
        for (Object o : os) {
            System.err.print(o + LF);
        }
    }

    public static void putskv_e(Object k, Object v) {
        putsf_e("%s (%s)", k, v);
    }

    public static void putsf_e(String format, Object... args) {
        puts_e(fmt(format, args));
    }

    public static String fmt(String format, Object... args) {
        return String.format(format, args);
    }

}

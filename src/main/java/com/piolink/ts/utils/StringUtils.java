package com.piolink.ts.utils;

import java.text.DecimalFormat;

/**
 * 
 * commons-lang3 의 StringUtils 상속 및 기본 Utils 의 추가 
 * 
 * @author jini
 *
 */
public class StringUtils extends org.apache.commons.lang3.StringUtils {

    public static int getInt(Object value) {
        return getInt(value, 0);
    }
    
    public static int getInt(Object value, int defaultValue) {
        String str = get(value);
        if (str.equals("") == false) {
            return Integer.parseInt(str.trim());
        }
        return defaultValue;
    }
    
    public static long getLong(Object value) {
        return getLong(value, 0L);
    }
    
    public static long getLong(Object value, long defaultValue) {
        String str = get(value);
        if (str.equals("") == false) {
            return Long.parseLong(str.trim());
        }
        return defaultValue;
    }
    
    public static Long getLongObj(Object value) {
        String str = get(value);
        if (str.equals("") == false) {
            return Long.parseLong(str.trim());
        }
        return null;
    }
    
    public static double getDouble(Object value) {
        return getDouble(value, 0d);
    }

    public static double getDouble(Object value, double defaultValue) {
        String str = get(value);
        if (str.equals("") == false) {
            return Double.parseDouble(str.trim());
        }
        return defaultValue;
    }
    
    public static float getFloat(Object value) {
        return getFloat(value, 0f);
    }
    
    public static float getFloat(Object value, float defaultValue) {
        String str = get(value);
        if (str.equals("") == false) {
            return Float.parseFloat(str.trim());
        }
        return defaultValue;
    }
    
    public static boolean getBoolean(Object value) {
        String str = get(value);
        if (str.equals("") == false) {
            if (str.trim().equals("true")) {
                return true;
            }
        }
        return false;
    }
    
    public static String get(Object value) {
        String str = null;
        if (value != null) {
            if( value instanceof String ) {
                str = ((String) value).trim();
            } else {
                str = value.toString();
            }
        } else {
            str = "";
        }
        return str;
    }
    
    public static String get(Object value, String defaultValue) {
        String str = null;
        if (value != null) {
            if( value instanceof String ) {
                str = ((String) value).trim();
            } else {
                str = value.toString();
            }
        } else {
            str = defaultValue;
        }
        return str;
    }    
    
    public static Integer getInteger(Object value) {
        String str = get(value);
        if (str.equals("") == false) {
            try {
                return new Integer(str);
            } catch (NumberFormatException e) {
                return null;
            }
        }
        return null;
    }
    
    public static Long getLongObject(Object value) {
        String str = get(value);
        if (str.equals("") == false) {
            try {
                return new Long(str);
            } catch (NumberFormatException e) {
                return null;
            }
        }
        return null;
    }
    
    public static Float getFloatObject(Object value) {
        String str = get(value);
        if (str.equals("") == false) {
            try {
                return new Float(str);
            } catch (NumberFormatException e) {
                return null;
            }
        }
        return null;
    }
    
    public static String format(Number number, String format) {
        DecimalFormat df = new DecimalFormat(format);
        return df.format(number);
    }
}
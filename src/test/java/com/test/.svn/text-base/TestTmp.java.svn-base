package com.test;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import com.tyyd.configkeeper.utils.MD5;

public class TestTmp {

	public static void main(String[] args) throws IOException {
		System.out.println(MD5.getInstance().getMD5String("acws123"));
        
	}
	
	static void testEncode() throws UnsupportedEncodingException{
		String str = "ab中文12";
		System.out.println(str);
		 
        System.out.println(str.getBytes());
 
        System.out.println(str.getBytes("GB2312"));
 
        System.out.println(str.getBytes("ISO8859_1"));
 
        System.out.println(new String(str.getBytes()));
 
        System.out.println(new String(str.getBytes(), "GB2312"));
 
        System.out.println(new String(str.getBytes(), "ISO8859_1"));
 
        System.out.println(new String(str.getBytes("GB2312")));
 
        System.out.println(new String(str.getBytes("GB2312"), "GB2312"));
 
        System.out.println(new String(str.getBytes("GB2312"), "ISO8859_1"));
 
        System.out.println(new String(str.getBytes("ISO8859_1")));
 
        System.out.println(new String(str.getBytes("ISO8859_1"), "GB2312"));
 
        System.out.println(new String(str.getBytes("ISO8859_1"), "ISO8859_1"));
        System.out.println(new String(str.getBytes("utf-8"), "utf-8"));
	}

}

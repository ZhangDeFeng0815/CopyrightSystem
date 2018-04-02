package com.tyyd.util;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.io.IOUtils;

import com.tyyd.framework.core.util.ExceptionUtils;
import com.tyyd.framework.log.Logger;
import com.tyyd.framework.log.LoggerFactory;

public class CrpsFileUtils {
	
	private static final Logger logger = LoggerFactory.getLogger(CrpsFileUtils.class);
	
	public static final String ENCODE_UTF8 = "UTF-8";
	public static final String ENCODE_GBK = "GBK";
	public static final String ENCODE_ISO8859 = "ISO8859-1";

	/**
	 * 创建文件夹，如果文件夹不存在
	 * @param dir
	 * @return
	 * @throws IOException 
	 */
	public static boolean mkdirIfNotExists(String dir) throws IOException {
		File dirFile = new  File(dir);
		if (!dirFile.exists()) {
			try {
				org.apache.commons.io.FileUtils.forceMkdir(dirFile);
				return true;
			} catch (Throwable e) {
				logger.error(e.getMessage());
				ExceptionUtils.throwAcwsException(e);
			}
		}
		return true;
	}
	
	public static String encodeOutputFileName(String fileName) throws UnsupportedEncodingException {
		String encodeDirName = null;
		try {
			if (existZH(fileName)) {
				encodeDirName = new String(fileName.getBytes(ENCODE_GBK), ENCODE_ISO8859);
			} else {
				encodeDirName = new String(fileName.getBytes(ENCODE_UTF8), ENCODE_ISO8859);
			}
		} catch (Throwable e) {
			ExceptionUtils.throwAcwsException(e);
		}
		return encodeDirName;
	}
	
	/**
	 * 
	 * @Title:       existZH 
	 * @Description: 判断文件名是否包含中文
	 * @param:       @param str
	 * @param:       @return
	 *
	 * @return:      boolean
	 */
	public static boolean existZH(String str) {
		String regEx = "[\\u4e00-\\u9fa5]";
		Pattern p = Pattern.compile(regEx);
		Matcher m = p.matcher(str);
		while (m.find()) {
			return true;
		}
		return false;
	}
	
	/**
	 * 下载单个文件
	 * @param out
	 * @param entity
	 * @throws IOException 
	 * @throws FileNotFoundException
	 */
	public static void outputSingleFile(OutputStream out,
			String filePath) throws IOException {
		InputStream is = null;
		try {
			File file = new File(filePath);
			if (file.isFile()) {
				is = new BufferedInputStream(new FileInputStream(file));
				IOUtils.copy(is, out);
			} else {
				logger.error("下载的文件不存在！" + "文件路径=" + filePath);
			}
		} catch (Throwable e) {
			logger.error(e.getMessage());
			ExceptionUtils.throwAcwsException(e);
		} finally {
			IOUtils.closeQuietly(is);
		}
	}
}

package com.tyyd.common;

import java.io.File;

import org.apache.commons.lang3.StringUtils;

import com.tyyd.framework.core.util.DateUtil;

public class CrpsCommonConstant {
	
	public static final String PATH_RFILE_CONTRACT=(isWindows()?"D:/upload/contract":"")+"/ytxt/rfile/contract/";
	
	/**
	 * 判断当前操作系统是不是window
	 * 
	 * @return boolean
	 */
	public static boolean isWindows() {
		boolean flag = false;
		if (System.getProperties().getProperty("os.name").toUpperCase()
				.indexOf("WINDOWS") != -1) {
			flag = true;
		}
		return flag;
	}
	
	/**
	 * 合同附件文件目录，以年月日为单位新建文件夹
	 * @return
	 */
	public static String getRfileContractPathWithYMD() {
		return PATH_RFILE_CONTRACT + StringUtils.replace(DateUtil.getCurrentDate_(), "-", File.separator)
				+ File.separator;
	}

}

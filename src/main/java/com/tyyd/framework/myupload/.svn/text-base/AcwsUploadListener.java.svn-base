package com.tyyd.framework.myupload;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.ProgressListener;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.StringUtils;

import com.tyyd.framework.core.BusinessException;

public class AcwsUploadListener implements ProgressListener {
	public static final String SHOW_TOTAL="TOTAL";
	public static final String SHOW_CURRENT="CURRENT";
	public static final String SHOW_SPEED="SPEED";

	public static final String KEY_TOTAL="V_TOTAL";
	public static final String KEY_CURRENT="V_CURRENT";
	public static final String KEY_SPEED="V_SPEED";
	public static final String KEY_INDEX="INDEX";
	public static final String KEY_MSG="MSG";
	public static final String KEY_TYPE="TYPE";
	public static final String KEY_HAS_PROGRESS="HAS_PROGRESS";
	public static final String KEY_PERCENT="PERCENT";
	public static final String KEY_IS_END="IS_END";
	public static final String KEY_LASTTIME="LAST_TIME";
	public static final String KEY_CANCEL="CANCEL";
	
	private static final String SESSION_ID_PREFIX = "PROGRESS_";
	private static final String REQUEST_ID_UPLOADID = "uploadId";
	
	HashMap<String, Object> progressInfo = null;
	
	public AcwsUploadListener(HttpServletRequest request){
		
		progressInfo = initProgressInfo(request);
	}
	
	@Override
	public void update(long pBytesRead, long pContentLength, int pItems) {
		if(progressInfo==null){
			return;
		}
		String cancelMsg = (String)progressInfo.get(KEY_CANCEL);
		if(StringUtils.isNotBlank(cancelMsg)){
			progressInfo.put(KEY_IS_END, "1");
			throw new BusinessException(cancelMsg);
		}

		
		Long lastTime = (Long)progressInfo.get(KEY_LASTTIME);
		if(lastTime==null)lastTime=0L;
		long now = System.currentTimeMillis();
		progressInfo.put(KEY_LASTTIME, now);
		long time = System.currentTimeMillis() - lastTime;
		if(time!=0){
			Long lastBytes = (Long)progressInfo.get(KEY_CURRENT);
			if(lastBytes==null)lastBytes=0L;
			long speed = (pBytesRead - lastBytes)*1000;
 			progressInfo.put(KEY_SPEED, speed);
		}

		progressInfo.put(KEY_MSG, "文件正在上传中...");
		progressInfo.put(KEY_TOTAL, pContentLength);
		progressInfo.put(KEY_CURRENT, pBytesRead);
		progressInfo.put(KEY_INDEX, pItems);
		if(pContentLength!=0){
			progressInfo.put(KEY_PERCENT, pBytesRead*100/pContentLength);
		} else {
			progressInfo.put(KEY_PERCENT, 0);
		}
		progressInfo.put(KEY_LASTTIME, System.currentTimeMillis());
	}
	
	public static HashMap<String, Object> getProgressInfo(HttpServletRequest request){
		String sessionId = SESSION_ID_PREFIX+request.getParameter(REQUEST_ID_UPLOADID);
		
		HttpSession session = request.getSession();
		HashMap<String, Object> progressInfo = (HashMap<String, Object>)session.getAttribute(sessionId);
		if(progressInfo == null){
			progressInfo = initProgressInfo(request);
		}

		long pBytesRead = (Long)progressInfo.get(KEY_CURRENT);
		long pContentLength = (Long)progressInfo.get(KEY_TOTAL);
		long speed = (Long)progressInfo.get(KEY_SPEED);
		String type = (String)progressInfo.get(KEY_TYPE);
		if("BYTES".equals(type)){
			if(pContentLength!=0){
				progressInfo.put(SHOW_TOTAL, FileUtils.byteCountToDisplaySize(pContentLength));
			} else {
				progressInfo.put(SHOW_TOTAL, "(总大小计算中)");
			}
			progressInfo.put(SHOW_TOTAL, FileUtils.byteCountToDisplaySize(pContentLength));
			progressInfo.put(SHOW_CURRENT, FileUtils.byteCountToDisplaySize(pBytesRead));
			progressInfo.put(SHOW_SPEED, FileUtils.byteCountToDisplaySize(speed)+"/S");
		}


		return progressInfo;
	}
	public static void setProgreceeInfo(HttpServletRequest request, String key, Object val){
		HashMap<String, Object> progressInfo = getProgressInfo(request);
		if(progressInfo == null){
			return;
		}
		String cancelMsg = (String)progressInfo.get(KEY_CANCEL);
		if(StringUtils.isNotBlank(cancelMsg)){
			String sessionId = SESSION_ID_PREFIX+request.getParameter(REQUEST_ID_UPLOADID);
			
			HttpSession session = request.getSession();
			session.removeAttribute(sessionId);
			throw new BusinessException(cancelMsg);
		}
		progressInfo.put(key, val);
	}
	
	public static void cancelProgrecee(HttpServletRequest request, String msg){
		HashMap<String, Object> progressInfo = getProgressInfo(request);
		if(progressInfo == null){
			return;
		}
		if(StringUtils.isBlank(msg)){
			msg="您已经成功取消上传。";
		}
		progressInfo.put(KEY_CANCEL,msg);
		progressInfo.put(KEY_IS_END, "1");
	}
	
	public static void endProgrecee(HttpServletRequest request){
		setProgreceeInfo(request, KEY_IS_END, "1");
	}
	
	public static void distroyIfend(HttpServletRequest request){
		String sessionId = SESSION_ID_PREFIX+request.getParameter(REQUEST_ID_UPLOADID);
		
		
		HttpSession session = request.getSession();
		HashMap<String, Object> progressInfo = getProgressInfo(request);
		if("1".equals(progressInfo.get("IS_END"))){
			session.removeAttribute(sessionId);
		}
	}

	public static HashMap<String, Object> initProgressInfo(HttpServletRequest request){
		String sessionId = SESSION_ID_PREFIX+request.getParameter(REQUEST_ID_UPLOADID);
		
		HttpSession session = request.getSession();
		HashMap<String, Object> progressInfo = new HashMap<String, Object>();
		progressInfo.put(KEY_TYPE, "BYTES");
		progressInfo.put(KEY_HAS_PROGRESS, "1");
		progressInfo.put(KEY_MSG, "文件正在上传中...");
		progressInfo.put(KEY_TOTAL, 0L);
		progressInfo.put(KEY_CURRENT, 0L);
		progressInfo.put(KEY_PERCENT, 0L);
		progressInfo.put(KEY_SPEED, 0L);
		progressInfo.put(KEY_INDEX, 0);
		progressInfo.put(KEY_LASTTIME, System.currentTimeMillis());
		
		
		progressInfo.put(SHOW_TOTAL, "总大小计算中");
		progressInfo.put(SHOW_CURRENT, "0 KB");
		progressInfo.put(SHOW_SPEED, "0　KB/S");
		
		session.setAttribute(sessionId, progressInfo);
		return progressInfo;
	}

}

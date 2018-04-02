package com.tyyd.framework.myupload;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUpload;
import org.springframework.web.multipart.MultipartException;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

public class AcwsMultipartResolver extends CommonsMultipartResolver {
	private HttpServletRequest request;
	@Override
	public MultipartHttpServletRequest resolveMultipart(HttpServletRequest request) throws MultipartException {
	       this.request=request;//获取到request,要用到session
	       return super.resolveMultipart(request);
	 }
	
	@Override
	protected  FileUpload newFileUpload(FileItemFactory fileItemFactory){
		FileUpload upload = super.newFileUpload(fileItemFactory); 
		if(request!=null){
			AcwsUploadListener uploadProgressListener = new AcwsUploadListener(request);
			upload.setProgressListener(uploadProgressListener);
		}
		return upload;
	}
}

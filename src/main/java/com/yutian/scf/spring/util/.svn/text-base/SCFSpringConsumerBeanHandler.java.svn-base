package com.yutian.scf.spring.util;

import com.fiber.remoting.Client;
import com.fiber.remoting.impl.DefaultConnectionManager;
import com.fiber.remoting.serialize.SerializationUtil;
import com.yutian.scf.consumer.impl.SCFServiceConsumerInvocationHandler;
import com.yutian.scf.domain.SCFRequest;
import com.yutian.scf.domain.SCFResponse;
import com.yutian.scf.exception.SCFException;
import com.yutian.scf.serialize.OldSCFSerialization;
import com.yutian.scf.serialize.SCFSerialization;
import com.yutian.scf.util.SCFServiceTargetUtil;

import java.io.File;
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;

public class SCFSpringConsumerBeanHandler
  implements InvocationHandler
{
  private static final String DEFAULT_VERSION = "1.0.0";
  private static final boolean IS_WIN = File.separatorChar == '\\'?true:false;
  private InvocationHandler targetHandler;
  private String target;
  private final String serviceInterface;
  private final String version;
  

  public SCFSpringConsumerBeanHandler(String target, String serviceInterface, String version)
  {
	  if(IS_WIN){
		  this.target = target;
	  }
    this.serviceInterface = serviceInterface;
    if ((version != null) && (!"".equals(version.trim())))
      this.version = version;
    else {
      this.version = "1.0.0";
    }
    SerializationUtil.addCustom(SCFRequest.class.getName(), new SCFSerialization());
    SerializationUtil.setOldVersionSerialization(new OldSCFSerialization());
  }

  public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
    if ("toString".equals(method.getName()))
      return SCFSpringConsumerBeanHandler.class.toString();
    if ("_setSCFHandler".equals(method.getName())) {
      this.targetHandler = ((InvocationHandler)args[0]);
      return null;
    }

    if (this.target != null) {
      SCFRequest request = new SCFRequest();
      request.setMethodArgs(args);
      request.setMethodName(method.getName());
      request.setTargetServiceUniqueName(this.serviceInterface + ":" + this.version);
      request.setMethodArgSigs(createParamSignature(method.getParameterTypes()));

      Client serviceConsumer = DefaultConnectionManager.getInstance().get("_SCF", SCFServiceTargetUtil.formatTargetURL(this.target));

      SCFResponse scfResp = (SCFResponse)serviceConsumer.invoke(request);
      Object appResp = scfResp.getAppResponse();

      SCFServiceConsumerInvocationHandler.checkAppRespForException(appResp, method);
      return appResp;
    }

    if (this.targetHandler != null) {
      return this.targetHandler.invoke(proxy, method, args);
    }

    throw new SCFException("SCF-6005");
  }

  private String[] createParamSignature(Class<?>[] args)
  {
    if ((args == null) || (args.length == 0)) {
      return new String[0];
    }
    String[] paramSig = new String[args.length];
    for (int x = 0; x < args.length; x++) {
      paramSig[x] = args[x].getName();
    }
    return paramSig;
  }

  protected String targetIP(String targetURL) {
    int idx = targetURL.indexOf(":");
    return targetURL.substring(0, idx);
  }

  protected boolean isOldProtocol(String url) {
    return !url.contains("_");
  }
}
package com.test;

import com.tyyd.framework.core.soa.EjbAdapter;
import com.yutian.common.CodeConstants.OperationType;

import ejbModule.operation.operation_log.OperationsLogMgr;

public class TestEjb {

	public static void main(String[] args) {
		OperationsLogMgr mgr = (OperationsLogMgr)EjbAdapter.getInstance("ejbModule.operation.operation_log.OperationsLogMgr");
		try {
			mgr.createOperationLog(1l, "1", "2", "3", "4", OperationType.ADD, "5", "6");
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}

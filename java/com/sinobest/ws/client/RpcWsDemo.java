package com.sinobest.ws.client;

import com.sinobest.framework.util.webservice.RPCInvokingWebServiceUtil;

/**
 * @author liulv
 * @date 2018/7/12
 */
public class RpcWsDemo {

    public static void main(String[] args) {
        String address = "http://localhost:8081/services/test?wsdl";
        String namespaceURI = "http://impl.test.servers.webservice.framework.sinobest.com/";
        String localName = "sayHello";
        Object[] opAddEntryArgs = {"liulv"};
        String result = RPCInvokingWebServiceUtil.invokingWebService(address, namespaceURI, localName, opAddEntryArgs);
        System.out.println(result);
    }

}

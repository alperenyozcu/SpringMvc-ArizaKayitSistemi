package com.ileriJava.log;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.Method;
import java.util.Enumeration;

/**
 * @author furkancelik
 **/
public class RequestLogger {

    private HttpServletRequest request;
    private HttpServletResponse response;
    private Method method;
    private String logMessage;

    public RequestLogger(HttpServletRequest request, HttpServletResponse response, Method method) {
        this.request = request;
        this.response = response;
        this.method = method;
    }

    public String logPreHandle(){

        logMessage = "";

        String uri = request.getRequestURI();

        Enumeration<String> parameterNames = request.getParameterNames();

        logMessage += "Request Method: " + request.getMethod();
        logMessage += "\nURI: " + uri;
        logMessage += "\nMethod: " + method.getName();
        logMessage += "\nMethod Return Type: " + method.getReturnType().getSimpleName();
        logMessage += "\nRequest Parameters: ";

        while (parameterNames.hasMoreElements()) {
            String key = (String) parameterNames.nextElement();
            String val = request.getParameter(key);
            logMessage += "\n\tKey: " + key + "\tValue: " + val;
        }

        return logMessage;
    }
}

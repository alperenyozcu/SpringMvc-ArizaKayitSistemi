package com.ileriJava.config;

import com.ileriJava.log.RequestLogger;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.lang.reflect.Method;

@Component
public class RequestInterceptor extends HandlerInterceptorAdapter {

    private static Logger logger = LoggerFactory.getLogger(RequestInterceptor.class);

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HandlerMethod hm = (HandlerMethod) handler;
        Method method = hm.getMethod();

        RequestLogger requestLogger = new RequestLogger(request, response, method);

        String logRequest = requestLogger.logPreHandle();

        logger.info(logRequest);

        return super.preHandle(request, response, handler);
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        logger.info("Response Status: " + response.getStatus());

        super.postHandle(request, response, handler, modelAndView);
    }
}

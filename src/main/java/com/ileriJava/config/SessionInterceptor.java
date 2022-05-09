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
import javax.servlet.http.HttpSession;

@Component
public class SessionInterceptor extends HandlerInterceptorAdapter {

    private static Logger logger = LoggerFactory.getLogger(SessionInterceptor.class);

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        HandlerMethod hm = (HandlerMethod) handler;

        RequestLogger requestLogger = new RequestLogger(request, response, hm.getMethod());

        logger.info(requestLogger.logPreHandle());

        Object user = session.getAttribute("user");
        if (user == null){
            response.sendRedirect("/bitirme/login");
            return false;
        }
        return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

        logger.info("Response Status: " + response.getStatus());

        super.postHandle(request, response, handler, modelAndView);
    }
}

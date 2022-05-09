package com.ileriJava.config;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

import javax.servlet.http.HttpServletRequest;

@ControllerAdvice
public class AppExceptionHandler {

    @ExceptionHandler(value = RuntimeException.class)
    @ResponseStatus(value = HttpStatus.INTERNAL_SERVER_ERROR)
    public String handleInternalServerError(HttpServletRequest request, Exception exception){
        System.err.println(request.getRequestURI() + " istegi gerceklestirilirken bir hata olustu." +
                " Hata mesajı: " + exception.getMessage());
        return "errors/error";
    }

    @ExceptionHandler(value = NoHandlerFoundException.class)
    @ResponseStatus(value = HttpStatus.NOT_FOUND)
    public String handleNotFound(HttpServletRequest request,
                                 Exception e) {
        System.err.println(request.getRequestURL() + " istegine karsilik karsilayici bulunamadi. " +
                "Hata mesaji: " + e.getMessage());
        return "errors/404"; // 404.jsp örnek kaynak bulunamadı sayfası döndürülüyor
    }
}

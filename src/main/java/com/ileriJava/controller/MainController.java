package com.ileriJava.controller;

import com.ileriJava.model.User;
import com.ileriJava.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

@Controller
public class MainController {




    @RequestMapping({"", "/"})
    public String main(){
        // Burada kullanıcı var ise anasayfaya yok ise logine yönlendirilecek
        return "index";
    }


}

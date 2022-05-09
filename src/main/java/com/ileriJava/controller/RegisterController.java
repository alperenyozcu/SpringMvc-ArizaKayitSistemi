package com.ileriJava.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.ileriJava.model.User;
import com.ileriJava.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/register")
public class RegisterController {

    @Autowired
    private UserService userService;

    @GetMapping({"/", ""})
    public String register(){
        return "register";
    }

    @PostMapping({"/registered"})
    public @ResponseBody String registered(@RequestParam String kullaniciadi, @RequestParam String ad,
                                   @RequestParam String soyad, @RequestParam String email, @RequestParam String sifre)
    {

        User user = userService.registerUser(kullaniciadi, ad, soyad, email, sifre);
        Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
        Map<String, Object> map = new HashMap<>();
        map.put("success", true);
        map.put("data", user);

        String json = gson.toJson(map);
        return json;
    }
}

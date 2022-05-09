package com.ileriJava.controller;

import com.google.gson.Gson;
import com.ileriJava.model.User;
import com.ileriJava.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/login")
public class LoginController {


    private final UserService userService;

    public LoginController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping(value = {"", "/"})
    public String login(){
        return "login";
    }

    @PostMapping
    public @ResponseBody String isExist(@RequestParam String email, @RequestParam String password, Model model, HttpServletRequest request, HttpServletResponse response){
        boolean isExist = userService.getByEmailAndSifre(email, password);

        Gson gson = new Gson();
        Map<String, Object> map = new HashMap<>();
        map.put("success", isExist);
        if (isExist){
            User user = userService.getByEmail(email);
            map.put("message", "Giriş başarılı");
            map.put("role",user.getRole());
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
        }

        else {
            map.put("message", "Kullanıcı adı veya şifre yanlış");
        }

        return gson.toJson(map);
    }

}

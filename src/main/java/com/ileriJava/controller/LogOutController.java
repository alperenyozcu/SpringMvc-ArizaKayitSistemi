package com.ileriJava.controller;

import com.google.gson.Gson;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping(value = "/logout")
public class LogOutController {

    @PostMapping
    public @ResponseBody String logout(HttpServletRequest request, HttpServletResponse response){
        HttpSession session = request.getSession();
        session.setAttribute("user", null);

        Gson gson = new Gson();
        Map<String, Object> map = new HashMap<>();
        map.put("success", true);
        String json = gson.toJson(map);
        return json;
    }
}

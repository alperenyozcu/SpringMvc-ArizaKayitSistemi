package com.ileriJava.controller;

import com.google.gson.Gson;
import com.ileriJava.model.Category;
import com.ileriJava.model.Personel;
import com.ileriJava.service.CategoryService;
import com.ileriJava.service.PersonelService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author furkancelik
 **/
@RequiredArgsConstructor
@Controller
@RequestMapping(value = "/personel/*")
public class PersonelController {

    private final PersonelService personelService;
    private final CategoryService categoryService;

    @GetMapping(value = "/home")
    public String home(){
        return "personel/personelHome";
    }

    @PostMapping(value = "/create")
    public @ResponseBody String create(@RequestParam String kullaniciAdi, @RequestParam String name,
                                       @RequestParam String surname, @RequestParam String email,
                                       @RequestParam String password, @RequestParam String categories){

        String[] categoryIDs = categories.split(",");
        boolean success = personelService.create(kullaniciAdi, name, surname, email, password, categoryIDs);
        Map<String, Object> map = new HashMap<>();
        map.put("success", success);
        Gson gson = new Gson();
        return gson.toJson(map);
    }

    @GetMapping(value = "/getAll")
    public @ResponseBody String getAll(@RequestParam Integer start, @RequestParam Integer limit){
        List<Personel> personelList = personelService.getAllPagination(start, limit);
        Integer totalCount = personelService.getAll().size();
        Gson gson = new Gson();
        Map<String, Object> map = new HashMap<>();
        map.put("success", true);
        map.put("data", personelList);
        map.put("totalCount", totalCount);
        return gson.toJson(map);
    }

    @PostMapping(value = "/delete/{personelID}")
    public @ResponseBody String deleteByID(@PathVariable("personelID") Long personelID){
        Map<String, Object> map = new HashMap<>();
        Gson gson = new Gson();

        boolean success = personelService.deleteByID(personelID);
        map.put("success", success);

        return gson.toJson(map);
    }

    @GetMapping(value = "/detay/{personelID}")
    public String detay(@PathVariable("personelID") Long personelID, Model model){
        Personel personel = personelService.getByID(personelID);
        Gson gson = new Gson();
        String strPersonel = gson.toJson(personel);
        model.addAttribute("personel", strPersonel);
        return "personel/detayPersonel";
    }

    @PostMapping(value = "update")
    public @ResponseBody String update(@RequestParam String strPersonel){
        Map<String, Object> map = new HashMap<>();
        Gson gson = new Gson();

        try {
            Personel personel = gson.fromJson(strPersonel, Personel.class);
            personelService.update(personel);
            map.put("success", true);
        }catch (Exception e){
            map.put("success", false);
        }

        return gson.toJson(map);
    }

    @GetMapping(value = "/getByUserID/{userID}")
    public @ResponseBody String getByUserID(@PathVariable("userID") Long userID){
        Map<String, Object> map = new HashMap<>();
        Gson gson = new Gson();

        Personel personel = personelService.getByUserID(userID);

        if (personel != null){
            map.put("success", true);
            map.put("data", personel);
        }else {
            map.put("success", false);
        }

        return gson.toJson(map);
    }

    @GetMapping(value = "/category")
    public String personelCategoryPage(@RequestParam Long categoryID, Model model){
        Category category = categoryService.getByID(categoryID);
        model.addAttribute("category", category);
        return "personel/personelCategory";
    }
}

package com.ileriJava.service;

import com.google.gson.Gson;
import com.ileriJava.dao.MainDAO;
import com.ileriJava.dao.PersonelRepository;
import com.ileriJava.enums.UserRole;
import com.ileriJava.model.Category;
import com.ileriJava.model.Comments;
import com.ileriJava.model.Personel;
import com.ileriJava.model.User;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * @author furkancelik
 **/
@RequiredArgsConstructor
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class PersonelService {

    private final MainDAO mainDAO;
    private final PersonelRepository personelRepository;
    private final CommentService commentService;

    @Transactional
    public boolean create(String kullaniciAdi, String name, String surname, String email, String password, String[] categoryIDs) {

        Personel personel = new Personel();
        User user = new User();

        user.setAd(name);
        user.setSoyad(surname);
        user.setRole(UserRole.PERSONNEL);
        user.setSifre(password);
        user.setKullaniciAdi(kullaniciAdi);
        user.setEmail(email);

        personel.setUser(user);

        List<Category> categoryList = new ArrayList<>();
        try {
            for (String strID: categoryIDs) {
                Category category = (Category) mainDAO.loadObject(Category.class, Long.parseLong(strID));
                categoryList.add(category);
            }
            personel.setCategories(categoryList);
            mainDAO.saveObject(personel);
            return true;
        }catch (Exception e){
            System.out.println(e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public List<Personel> getAll() {
        return personelRepository.findAll();
    }

    public List<Personel> getAllPagination(Integer start, Integer limit) {
        return personelRepository.findAllPagination(start, limit);
    }

    @Transactional
    public void update(Personel personel) {
        mainDAO.updateObject(personel);
    }

    @Transactional
    public boolean deleteByID(Long personelID) {
        try {
            Personel personel = (Personel) mainDAO.loadObject(Personel.class, personelID);
            List<Comments> commentsList = commentService.getByUserID(personel.getUser().getId());
            for (Comments comment: commentsList) {
                commentService.deleteByID(comment.getId());
            }
            mainDAO.delete(personel);
            return true;
        }catch (Exception e){
            System.out.println(e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    public Personel getByID(Long personelID) {
        Personel personel = (Personel) mainDAO.loadObject(Personel.class, personelID);
        return personel;
    }

    public Personel getByUserID(Long userID) {
        Personel personel = new Personel();
        try {
            personel = personelRepository.getByUserID(userID);
        }catch (Exception e){
            personel = null;
        }
        return personel;
    }
}

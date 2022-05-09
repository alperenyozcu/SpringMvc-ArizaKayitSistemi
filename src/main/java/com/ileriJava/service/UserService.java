package com.ileriJava.service;

import com.ileriJava.dao.MainDAO;
import com.ileriJava.dao.UserRepository;
import com.ileriJava.enums.UserRole;
import com.ileriJava.model.User;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class UserService {

    private final MainDAO mainDAO;
    private final UserRepository userRepository;

    public UserService(MainDAO mainDAO, UserRepository userRepository) {
        this.mainDAO = mainDAO;
        this.userRepository = userRepository;
    }

    public Boolean isExist(String email, String password) {
        if (email.indexOf("furkan") > -1)
            return true;
        return false;
    }

    @Transactional(readOnly = false)
    public Long addUser(User user) {
        Long id = (Long) mainDAO.saveObject(user);
        return id;
    }

    @Transactional(readOnly = false)
    public List<User> getAll() {
        return userRepository.getUser();
    }

    @Transactional(readOnly = false)
    public boolean getByEmailAndSifre(String email, String sifre) {
        return userRepository.getByEmailAndSifre(email, sifre);
    }

    public User getByEmail(String email) {
        return userRepository.getByEmail(email);
    }


    @Transactional
    public User registerUser(String kullaniciadi, String ad, String soyad, String email, String sifre) {
        User user = new User();
        user.setKullaniciAdi(kullaniciadi);
        user.setAd(ad);
        user.setSoyad(soyad);
        user.setSifre(sifre);
        user.setEmail(email);
        user.setRole(UserRole.USER);
        addUser(user);
        return user;
    }
}

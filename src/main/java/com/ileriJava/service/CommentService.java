package com.ileriJava.service;

import com.ileriJava.dao.CommentRepository;
import com.ileriJava.dao.MainDAO;
import com.ileriJava.model.Comments;
import com.ileriJava.model.FaultRecords;
import com.ileriJava.model.User;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

/**
 * @author furkancelik
 **/

@RequiredArgsConstructor
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class CommentService {

    private final MainDAO mainDAO;
    private final CommentRepository commentRepository;


    @Transactional
    public Comments save(String commentContext, Long faultRecordID, HttpServletRequest request, HttpServletResponse response){

        FaultRecords faultRecord = (FaultRecords) mainDAO.loadObject(FaultRecords.class, faultRecordID);
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        Comments comment = new Comments();
        comment.setFaultRecord(faultRecord);
        comment.setUser(user);
        comment.setContext(commentContext);
        comment.setCreationTime(new Date());

        Object savedComment = mainDAO.saveObject(comment);
        return comment;
    }

    public List<Comments> getByPostIDPagination(Long postID, Integer start, Integer limit) {
        List<Comments> commentsList = commentRepository.findByPostIDPagination(postID, start, limit);
        return commentsList;
    }

    public List<Comments> getByUserID(Long userID) {
        List<Comments> commentsList = commentRepository.getByUserID(userID);
        return commentsList;
    }

    @Transactional
    public boolean deleteByID(Long id) {
        try {
            Comments comment = (Comments) mainDAO.loadObject(Comments.class, id);
            mainDAO.delete(comment);
            return true;
        }catch (Exception e){
            return false;
        }
    }

    public List<Comments> getAllByPostID(Long postID){
        return commentRepository.getAllByPostID(postID);
    }
}

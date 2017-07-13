package com.piolink.ts.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mysema.query.types.Predicate;
import com.piolink.ts.domain.QUserDashboard;
import com.piolink.ts.domain.UserDashboard;
import com.piolink.ts.repository.UserDashboardRepository;

@Transactional
@Service
public class UserDashboardService {

    @Autowired
    private UserDashboardRepository repository;

    public UserDashboardService() {
    }

    public Iterable<UserDashboard> findAll() {
        return repository.findAll();
    }

    public UserDashboard findOne(Long id) {
        return repository.findOne(id);
    }

    public UserDashboard save(UserDashboard entity) {
        return repository.save(entity);
    }

    public void delete(Long id) {
        repository.delete(id);
    }

    public Iterable<UserDashboard> findByUserId(Long userId) {
        QUserDashboard userDashboard = QUserDashboard.userDashboard;
        Predicate predicate = userDashboard.userId.eq(userId)
                .and(userDashboard.isUse.eq("Y"));
        return repository.findAll(predicate);
    }
}
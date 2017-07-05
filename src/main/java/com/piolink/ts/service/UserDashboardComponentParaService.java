package com.piolink.ts.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.piolink.ts.domain.UserDashboardComponentPara;
import com.piolink.ts.repository.UserDashboardComponentParaRepository;

@Transactional
@Service
public class UserDashboardComponentParaService {

    @Autowired private UserDashboardComponentParaRepository repository;
    
    public UserDashboardComponentParaService() {
    }
    
    public Iterable<UserDashboardComponentPara> findAll() {
        return repository.findAll();
    }
    
    public UserDashboardComponentPara findOne(Long id) {
        return repository.findOne(id);
    }
    
    public UserDashboardComponentPara save(UserDashboardComponentPara entity) {
        return repository.save(entity);
    }
    
    public void delete(Long id) {
        repository.delete(id);
    }
}

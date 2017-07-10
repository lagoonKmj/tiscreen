package com.piolink.ts.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.piolink.ts.domain.UserDashboardComponent;
import com.piolink.ts.repository.UserDashboardComponentRepository;

@Transactional
@Service
public class UserDashboardComponentService {

    @Autowired private UserDashboardComponentRepository repository;
    
    public UserDashboardComponentService() {
    }
    
    public Iterable<UserDashboardComponent> findAll() {
        return repository.findAll();
    }
    
    public UserDashboardComponent findOne(Long id) {
        return repository.findOne(id);
    }
    
    public UserDashboardComponent save(UserDashboardComponent entity) {
        return repository.save(entity);
    }
    
    public void delete(Long id) {
        repository.delete(id);
    }
    
    public List<UserDashboardComponent> findByDashboardId(Long dashboardId) {
        return repository.findByDashboardId(dashboardId);
    }
    
    public void deleteByDashboardId(Long dashboardId){
        this.repository.deleteByDashboardId(dashboardId);
    }
}

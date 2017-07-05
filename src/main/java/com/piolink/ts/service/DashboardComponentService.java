package com.piolink.ts.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.piolink.ts.domain.DashboardComponent;
import com.piolink.ts.repository.DashboardComponentRepository;

@Transactional
@Service
public class DashboardComponentService {

    @Autowired private DashboardComponentRepository repository;
    
    public DashboardComponentService() {
    }
    
    public Iterable<DashboardComponent> findAll() {
        return repository.findAll();
    }
    
    public DashboardComponent findOne(Long id) {
        return repository.findOne(id);
    }
    
    public DashboardComponent save(DashboardComponent entity) {
        return repository.save(entity);
    }
    
    public void delete(Long id) {
        repository.delete(id);
    }
}

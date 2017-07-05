package com.piolink.ts.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.piolink.ts.domain.DashboardComponentPara;
import com.piolink.ts.repository.DashboardComponentParaRepository;

@Transactional
@Service
public class DashboardComponentParaService {

    @Autowired private DashboardComponentParaRepository repository;
    
    public DashboardComponentParaService() {
    }
    
    public Iterable<DashboardComponentPara> findAll() {
        return repository.findAll();
    }
    
    public DashboardComponentPara findOne(Long id) {
        return repository.findOne(id);
    }
    
    public DashboardComponentPara save(DashboardComponentPara entity) {
        return repository.save(entity);
    }
    
    public void delete(Long id) {
        repository.delete(id);
    }
}

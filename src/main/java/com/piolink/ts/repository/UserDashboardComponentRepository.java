package com.piolink.ts.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.piolink.ts.domain.UserDashboardComponent;

public interface UserDashboardComponentRepository extends CrudRepository<UserDashboardComponent, Long> {

    public List<UserDashboardComponent> findByDashboardId(Long dashboardId);

    public Long deleteByDashboardId(Long dashboardId);
    
}
package com.piolink.ts.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.piolink.ts.domain.UserDashboard;

public interface UserDashboardRepository extends CrudRepository<UserDashboard, Long> {

    public List<UserDashboard> findByUserId(Long userId);
}
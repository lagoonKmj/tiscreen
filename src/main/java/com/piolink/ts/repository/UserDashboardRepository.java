package com.piolink.ts.repository;

import org.springframework.data.querydsl.QueryDslPredicateExecutor;
import org.springframework.data.repository.CrudRepository;

import com.piolink.ts.domain.UserDashboard;

public interface UserDashboardRepository
        extends CrudRepository<UserDashboard, Long>, QueryDslPredicateExecutor<UserDashboard> {

}
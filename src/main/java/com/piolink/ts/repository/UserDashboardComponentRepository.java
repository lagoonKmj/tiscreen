package com.piolink.ts.repository;

import org.springframework.data.querydsl.QueryDslPredicateExecutor;
import org.springframework.data.repository.CrudRepository;

import com.piolink.ts.domain.UserDashboardComponent;

public interface UserDashboardComponentRepository
        extends CrudRepository<UserDashboardComponent, Long>, QueryDslPredicateExecutor<UserDashboardComponent> {

}
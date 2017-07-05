package com.piolink.ts.repository;

import org.springframework.data.querydsl.QueryDslPredicateExecutor;
import org.springframework.data.repository.CrudRepository;

import com.piolink.ts.domain.DashboardComponent;

public interface DashboardComponentRepository
        extends CrudRepository<DashboardComponent, Long>, QueryDslPredicateExecutor<DashboardComponent> {

}
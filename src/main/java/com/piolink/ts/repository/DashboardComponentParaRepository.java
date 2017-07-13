package com.piolink.ts.repository;

import org.springframework.data.querydsl.QueryDslPredicateExecutor;
import org.springframework.data.repository.CrudRepository;

import com.piolink.ts.domain.DashboardComponentPara;

public interface DashboardComponentParaRepository
        extends CrudRepository<DashboardComponentPara, Long>,
        QueryDslPredicateExecutor<DashboardComponentPara> {

}
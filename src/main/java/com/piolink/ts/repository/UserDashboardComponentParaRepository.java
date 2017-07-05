package com.piolink.ts.repository;

import org.springframework.data.querydsl.QueryDslPredicateExecutor;
import org.springframework.data.repository.CrudRepository;

import com.piolink.ts.domain.UserDashboardComponentPara;

public interface UserDashboardComponentParaRepository
        extends CrudRepository<UserDashboardComponentPara, Long>, QueryDslPredicateExecutor<UserDashboardComponentPara> {

}
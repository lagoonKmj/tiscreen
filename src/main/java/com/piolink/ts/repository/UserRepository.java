package com.piolink.ts.repository;

import org.springframework.data.repository.CrudRepository;

import com.piolink.ts.domain.User;

public interface UserRepository extends CrudRepository<User, Long> {

}
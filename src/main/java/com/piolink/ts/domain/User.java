package com.piolink.ts.domain;

import javax.persistence.Entity;

import com.piolink.ts.dbproxy.AbstractEntity;


@Entity(name = "com_user")
public class User extends AbstractEntity {

    public String userIdentifier;
    
    public User() {
    }
    
    public String getUserIdentifier() {
        return userIdentifier;
    }
    public void setUserIdentifier(String userIdentifier) {
        this.userIdentifier = userIdentifier;
    }
}
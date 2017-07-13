package com.piolink.ts.domain;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Transient;

import com.piolink.ts.dbproxy.AbstractEntity;


@Entity(name = "conf_user_dashboard")
public class UserDashboard extends AbstractEntity  {

    private Long userId;
    private String name;
    @Transient
    private String isShare;
    @Transient
    private Date regDate;
    @Transient
    private Date updDate;
    @Transient
    private String description;
    private String isUse;

    public UserDashboard() {
        super();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getIsShare() {
        return isShare;
    }

    public void setIsShare(String isShare) {
        this.isShare = isShare;
    }

    public Date getRegDate() {
        return regDate;
    }

    public void setRegDate(Date regDate) {
        this.regDate = regDate;
    }

    public Date getUpdDate() {
        return updDate;
    }

    public void setUpdDate(Date updDate) {
        this.updDate = updDate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getIsUse() {
        return isUse;
    }

    public void setIsUse(String isUse) {
        this.isUse = isUse;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

}
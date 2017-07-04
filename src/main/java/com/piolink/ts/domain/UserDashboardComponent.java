package com.piolink.ts.domain;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import com.piolink.ts.dbproxy.AbstractEntity;

@Entity(name = "conf_user_dashboard_component")
public class UserDashboardComponent extends AbstractEntity  {

    @ManyToOne(optional = false)
    @JoinColumn(name = "dashboard_id", referencedColumnName = "id")
    private UserDashboard userDashboard;

    private Integer posX;
    private Integer posY;
    private Integer width;
    private Integer height;
    private Integer orderby;
    private String isUse;

    public UserDashboardComponent() {
        super();
    }

    public UserDashboard getUserDashboard() {
        return userDashboard;
    }

    public Integer getPosX() {
        return posX;
    }

    public void setPosX(Integer posX) {
        this.posX = posX;
    }

    public Integer getPosY() {
        return posY;
    }

    public void setPosY(Integer posY) {
        this.posY = posY;
    }

    public Integer getWidth() {
        return width;
    }

    public void setWidth(Integer width) {
        this.width = width;
    }

    public Integer getHeight() {
        return height;
    }

    public void setHeight(Integer height) {
        this.height = height;
    }

    public Integer getOrderby() {
        return orderby;
    }

    public void setOrderby(Integer orderby) {
        this.orderby = orderby;
    }

    public String getIsUse() {
        return isUse;
    }

    public void setIsUse(String isUse) {
        this.isUse = isUse;
    }
}
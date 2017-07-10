package com.piolink.ts.domain;

import javax.persistence.Entity;

import com.piolink.ts.dbproxy.AbstractEntity;

@Entity(name = "conf_user_dashboard_component")
public class UserDashboardComponent extends AbstractEntity  {

    private Long dashboardId;
    private Long componentId;
    private Integer pos_x;
    private Integer pos_y;
    private Integer width;
    private Integer height;
    private Integer orderby;
    private String isUse;

    public UserDashboardComponent() {
        super();
    }

    public Integer getPosX() {
        return pos_x;
    }

    public void setPosX(Integer posX) {
        this.pos_x = posX;
    }

    public Integer getPosY() {
        return pos_y;
    }

    public void setPosY(Integer posY) {
        this.pos_y = posY;
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

    public Long getDashboardId() {
        return dashboardId;
    }

    public void setDashboardId(Long dashboardId) {
        this.dashboardId = dashboardId;
    }

    public Long getComponentId() {
        return componentId;
    }

    public void setComponentId(Long componentId) {
        this.componentId = componentId;
    }

}
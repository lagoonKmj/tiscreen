package com.piolink.ts.domain;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;

import com.piolink.ts.dbproxy.AbstractEntity;

@Entity(name = "conf_dashboard_component")
public class DashboardComponent extends AbstractEntity  {
    
    @OneToOne(fetch = FetchType.LAZY, cascade=CascadeType.PERSIST)
    @JoinColumn(name = "id", referencedColumnName = "component_id")
    private DashboardComponentPara dashboardComponentPara;

    private String name;
    private String description;
    private Integer minWidth;
    private Integer minHeight;
    private Integer maxWidth;
    private Integer maxHeight;
    private Integer defWidth;
    private Integer defHeight;
    private String isConfig;
    private String isUse;
    private String className;
    private String division;

    public DashboardComponent() {
        super();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getMinWidth() {
        return minWidth;
    }

    public void setMinWidth(Integer minWidth) {
        this.minWidth = minWidth;
    }

    public Integer getMinHeight() {
        return minHeight;
    }

    public void setMinHeight(Integer minHeight) {
        this.minHeight = minHeight;
    }

    public Integer getMaxWidth() {
        return maxWidth;
    }

    public void setMaxWidth(Integer maxWidth) {
        this.maxWidth = maxWidth;
    }

    public Integer getMaxHeight() {
        return maxHeight;
    }

    public void setMaxHeight(Integer maxHeight) {
        this.maxHeight = maxHeight;
    }

    public Integer getDefWidth() {
        return defWidth;
    }

    public void setDefWidth(Integer defWidth) {
        this.defWidth = defWidth;
    }

    public Integer getDefHeight() {
        return defHeight;
    }

    public void setDefHeight(Integer defHeight) {
        this.defHeight = defHeight;
    }

    public String getIsConfig() {
        return isConfig;
    }

    public void setIsConfig(String isConfig) {
        this.isConfig = isConfig;
    }

    public String getIsUse() {
        return isUse;
    }

    public void setIsUse(String isUse) {
        this.isUse = isUse;
    }

    public DashboardComponentPara getDashboardComponentPara() {
        return dashboardComponentPara;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getDivision() {
        return division;
    }

    public void setDivision(String division) {
        this.division = division;
    }
}
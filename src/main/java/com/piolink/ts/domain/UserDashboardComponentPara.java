package com.piolink.ts.domain;

import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import com.piolink.ts.dbproxy.AbstractEntity;

@Entity(name = "conf_user_dashboard_component_para")
public class UserDashboardComponentPara extends AbstractEntity  {

    @ManyToOne(optional = false)
    @JoinColumn(name = "component_id", referencedColumnName = "id")
    private UserDashboardComponent userDashboardComponent;

    private Integer componentId;
    private String paraValue1;
    private String paraValue2;
    private String paraValue3;
    private String paraValue4;
    private String paraValue5;
    private String paraValue6;

    public UserDashboardComponentPara() {
        super();
    }

    public UserDashboardComponent getUserDashboardComponent() {
        return userDashboardComponent;
    }

    public Integer getComponentId() {
        return componentId;
    }

    public void setComponentId(Integer componentId) {
        this.componentId = componentId;
    }

    public String getParaValue1() {
        return paraValue1;
    }

    public void setParaValue1(String paraValue1) {
        this.paraValue1 = paraValue1;
    }

    public String getParaValue2() {
        return paraValue2;
    }

    public void setParaValue2(String paraValue2) {
        this.paraValue2 = paraValue2;
    }

    public String getParaValue3() {
        return paraValue3;
    }

    public void setParaValue3(String paraValue3) {
        this.paraValue3 = paraValue3;
    }

    public String getParaValue4() {
        return paraValue4;
    }

    public void setParaValue4(String paraValue4) {
        this.paraValue4 = paraValue4;
    }

    public String getParaValue5() {
        return paraValue5;
    }

    public void setParaValue5(String paraValue5) {
        this.paraValue5 = paraValue5;
    }

    public String getParaValue6() {
        return paraValue6;
    }

    public void setParaValue6(String paraValue6) {
        this.paraValue6 = paraValue6;
    }
}
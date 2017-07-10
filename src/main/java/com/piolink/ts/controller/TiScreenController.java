package com.piolink.ts.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.piolink.ts.domain.DashboardComponent;
import com.piolink.ts.domain.UserDashboardComponent;
import com.piolink.ts.service.DashboardComponentService;
import com.piolink.ts.service.UserDashboardComponentService;
import com.piolink.ts.service.UserDashboardService;
import com.piolink.ts.utils.JsonUtils;
import com.piolink.ts.utils.StringUtils;

/**
 * @author lagoon
 *
 */
@Controller
public class TiScreenController {

    @Autowired private UserDashboardService userDashboardService;
    @Autowired private DashboardComponentService dashboardComponentService;
    @Autowired private UserDashboardComponentService userDashboardComponentService; 
    
    @RequestMapping(value = "/tiscreen.do", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView tiscreen(@RequestParam Map<String, Object> map) {
        
        //컴포넌트 가져오기
        Iterable<DashboardComponent> dashboardComponents = dashboardComponentService.findAll();
        ModelAndView mv = new ModelAndView("/tiscreen");
        mv.addObject("dashboardComponents", JsonUtils.toJson(dashboardComponents));
        return mv;
    }

    @RequestMapping(value = "/load.do", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView load(@RequestParam Map<String, Object> map) {
        ModelAndView mv = new ModelAndView("/components/" + map.get("className"));
        map.put("tiContainerId", "container_" + map.get("numTiComponent"));
        mv.addAllObjects(map);
        return mv;
    }
    
    @RequestMapping(value = "/getData.json", method = {RequestMethod.GET, RequestMethod.POST})
    public @ResponseBody String getData(@RequestParam Map<String, Object> map) {
        
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("total_elements", 1);
        resultMap.put("content", "lagoon");
        return JsonUtils.toJson(resultMap);
    }

    @RequestMapping(value = "/getNodata.json", method = {RequestMethod.GET, RequestMethod.POST})
    public @ResponseBody String getNodata(@RequestParam Map<String, Object> map) {
        
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("total_elements", 0);
        resultMap.put("content", "");
        return JsonUtils.toJson(resultMap);
    }
    
    @RequestMapping(value = "/getDashboardComponent.json", method = {RequestMethod.GET, RequestMethod.POST})
    public @ResponseBody String getDashboardComponent(@RequestParam Map<String, Object> map) {
        
        Iterable<DashboardComponent> dashboardComponents = dashboardComponentService.findAll();
        return JsonUtils.toJson(dashboardComponents);
    }
    
    @RequestMapping(value = "/addUserDashboard.json", method = {RequestMethod.GET, RequestMethod.POST})
    public @ResponseBody String addUserDashboard(@RequestParam Map<String, Object> map) {
        
        Long dashboardId = StringUtils.getLong(map.get("dashboard_id"));
        String jsonComponents = StringUtils.get(map.get("components"));
        List<Map<String, Object>> componentsList = JsonUtils.fromJson(jsonComponents, List.class);
        for (Map<String, Object> component : componentsList) {
            UserDashboardComponent userDashboardComponent = new UserDashboardComponent();
            DashboardComponent dashboardComponent = dashboardComponentService.findOne(StringUtils.getLong(component.get("id")));
            userDashboardComponent.setDashboardId(dashboardId);
            userDashboardComponent.setComponentId(StringUtils.getLong(component.get("id")));
            userDashboardComponent.setHeight(StringUtils.getInteger(component.get("height")));
            userDashboardComponent.setWidth(StringUtils.getInteger(component.get("width")));
            userDashboardComponent.setPosX(StringUtils.getInteger(component.get("x")));
            userDashboardComponent.setPosY(StringUtils.getInteger(component.get("y")));
            userDashboardComponent.setIsUse("Y");
            userDashboardComponent.setOrderby(1);
            userDashboardComponentService.save(userDashboardComponent);
            System.out.println("9");
        }
        return "OK";
    }
    
}
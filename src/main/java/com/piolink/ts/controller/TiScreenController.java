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
import com.piolink.ts.domain.Result;
import com.piolink.ts.domain.UserDashboard;
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
        
        ModelAndView mv = new ModelAndView("/tiscreen");
        //컴포넌트 가져오기
        Iterable<DashboardComponent> dashboardComponents = dashboardComponentService.findAll();
        mv.addObject("dashboardComponents", JsonUtils.toJson(dashboardComponents));
        //기본 대시보드 가져오기
        Iterable<UserDashboard> basicDashboards = userDashboardService.findByUserId(-1L);
        mv.addObject("basicDashboards", JsonUtils.toJson(basicDashboards));
        //사용자 대시보드 가져오기
        Iterable<UserDashboard> userDashboards = userDashboardService.findByUserId(36L);
        mv.addObject("userDashboards", JsonUtils.toJson(userDashboards));
        return mv;
    }

    @RequestMapping(value = "/tiscreen/load.do", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView load(@RequestParam Map<String, Object> map) {
        ModelAndView mv = new ModelAndView("/components/" + map.get("className"));
        map.put("tiContainerId", "container_" + map.get("numTiComponent"));
        mv.addAllObjects(map);
        return mv;
    }
    
    @RequestMapping(value = "/tiscreen/getData.json", method = {RequestMethod.GET, RequestMethod.POST})
    public @ResponseBody String getData(@RequestParam Map<String, Object> map) {
        
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("test", 1);
        resultMap.put("test_1", "lagoon");
        Result result = new Result();
        result.setTotalElements(1);
        result.setContent(resultMap);
        return JsonUtils.toJson(result);
    }

    @RequestMapping(value = "/tiscreen/getNodata.json", method = {RequestMethod.GET, RequestMethod.POST})
    public @ResponseBody String getNodata(@RequestParam Map<String, Object> map) {
        
        Map<String, Object> resultMap = new HashMap<>();
        Result result = new Result();
        result.setTotalElements(0);
        result.setContent(resultMap);
        return JsonUtils.toJson(result);
    }
    
    @RequestMapping(value = "/tiscreen/getDashboardComponent.json", method = {RequestMethod.GET, RequestMethod.POST})
    public @ResponseBody String getDashboardComponent(@RequestParam Map<String, Object> map) {
        
        Iterable<DashboardComponent> dashboardComponents = dashboardComponentService.findAll();
        return JsonUtils.toJson(dashboardComponents);
    }
    
    @RequestMapping(value = "/tiscreen/addUserDashboard.json", method = {RequestMethod.GET, RequestMethod.POST})
    public @ResponseBody String addUserDashboard(@RequestParam Map<String, Object> map) {

        String name = StringUtils.get(map.get("name"));
        int add_dashboard_type = StringUtils.getInt(map.get("add_dashboard_type"));
        
        UserDashboard userDashboard = new UserDashboard();
        userDashboard.setName(name);
        userDashboard.setUserId(36L);
        userDashboard.setIsUse("Y");
        UserDashboard resultUserDashboard = userDashboardService.save(userDashboard);
        //기본 대시보드(0) 에서 (대시보드)저장은 컴포넌트 까지 Copy 합니다.
        if (add_dashboard_type == 0) {
            map.put("dashboard_id", resultUserDashboard.getId());
            addUserDashboardComponents(map);
        }
        
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("result", "success");
        resultMap.put("content", resultUserDashboard);
        return JsonUtils.toJson(resultMap);
    }
    
    @RequestMapping(value = "/tiscreen/deleteUserDashboard.json", method = {RequestMethod.GET, RequestMethod.POST})
    public @ResponseBody String deleteUserDashboard(@RequestParam Map<String, Object> map) {

        Long dashboardId = StringUtils.getLong(map.get("dashboard_id"));
        
        UserDashboard userDashboard = userDashboardService.findOne(dashboardId);
        userDashboard.setIsUse("N");
        userDashboardService.save(userDashboard);
        //사용자 대시보드 다시 가져오기
        Iterable<UserDashboard> userDashboards = userDashboardService.findByUserId(36L);
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("result", "success");
        resultMap.put("content", userDashboards);
        return JsonUtils.toJson(resultMap);
    }
    
    @RequestMapping(value = "/tiscreen/addUserDashboardComponents.json", method = {RequestMethod.GET, RequestMethod.POST})
    public @ResponseBody String addUserDashboardComponents(@RequestParam Map<String, Object> map) {
        
        Long dashboardId = StringUtils.getLong(map.get("dashboard_id"));
        String jsonComponents = StringUtils.get(map.get("components"));
        List<Map<String, Object>> componentsList = JsonUtils.fromJson(jsonComponents, List.class);
        userDashboardComponentService.deleteByDashboardId(dashboardId);
        for (Map<String, Object> component : componentsList) {
            UserDashboardComponent userDashboardComponent = new UserDashboardComponent();
            userDashboardComponent.setDashboardId(dashboardId);
            userDashboardComponent.setComponentId(StringUtils.getLong(component.get("id")));
            userDashboardComponent.setHeight(StringUtils.getInteger(component.get("height")));
            userDashboardComponent.setWidth(StringUtils.getInteger(component.get("width")));
            userDashboardComponent.setPosX(StringUtils.getInteger(component.get("x")));
            userDashboardComponent.setPosY(StringUtils.getInteger(component.get("y")));
            userDashboardComponent.setIsUse("Y");
            userDashboardComponent.setOrderby(1);
            userDashboardComponentService.save(userDashboardComponent);
        }
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("result", "success");
        return JsonUtils.toJson(resultMap);
    }
    
    @RequestMapping(value = "/tiscreen/getUserDashboardComponent.json", method = {RequestMethod.GET, RequestMethod.POST})
    public @ResponseBody String getUserDashboardComponent(@RequestParam Map<String, Object> map) {
        
        Long dashboardId = StringUtils.getLong(map.get("dashboard_id"));
        List<UserDashboardComponent> userDashboardComponents = userDashboardComponentService.findByDashboardId(dashboardId);
        return JsonUtils.toJson(userDashboardComponents);
    }
}
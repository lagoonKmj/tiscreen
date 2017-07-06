package com.piolink.ts.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.piolink.ts.domain.DashboardComponent;
import com.piolink.ts.service.DashboardComponentService;
import com.piolink.ts.utils.JsonUtils;

/**
 * @author lagoon
 *
 */
@Controller
public class TiScreenController {

    @Autowired private DashboardComponentService dashboardComponentService;
    
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
        ModelAndView mv = new ModelAndView("/components/" + map.get("name"));
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
}

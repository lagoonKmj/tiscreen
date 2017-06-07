package com.piolink.ts.controller;

import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

/**
 * @author kmj
 *
 */
@Controller
public class TiScreenController {

    /**
     * <p>페이지 이동</p>
     * 
     * @param model
     * @return
     */
    @RequestMapping(value = "/tiscreen.do", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView tiscreen(@RequestParam Map<String, Object> map) {
        ModelAndView mv = new ModelAndView("/tiscreen");
        return mv;
    }

    @RequestMapping(value = "/load.do", method = {RequestMethod.GET, RequestMethod.POST})
    public ModelAndView load(@RequestParam Map<String, Object> map) {
        ModelAndView mv = new ModelAndView("/components/" + map.get("name"));
        mv.addAllObjects(map);
        return mv;
    }
}

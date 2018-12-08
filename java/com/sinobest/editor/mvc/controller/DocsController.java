package com.sinobest.editor.mvc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * @author liulv
 * @date 2018/6/10
 */
@Controller
@RequestMapping("/docs")
public class DocsController {
    @RequestMapping(value = "", method = RequestMethod.GET)
    public String home() throws Exception {
        //重定向
        //return "redirect:/editor/docs/list";
        //转发
        return "forward:/editor/docs/list";
    }
}

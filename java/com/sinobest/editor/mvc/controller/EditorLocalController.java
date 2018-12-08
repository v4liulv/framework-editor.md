package com.sinobest.editor.mvc.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;

/**
 * @author liulv
 * @date 2018/12/6
 *
 * 编辑器 控制器
 * 读取本地文件MD读取写入操作
 */
@Controller
@RequestMapping("/editor_local")
public class EditorLocalController {

    private Logger LOG = LoggerFactory.getLogger(EditorLocalController.class);

    /**
     * 编辑文章
     *
     * @param file 文件内容
     */
    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    public String editor(@RequestParam("file") CommonsMultipartFile file, HttpServletRequest request) throws Exception {
        request.setAttribute("fileName", file.getOriginalFilename());
        request.setAttribute("fileContent",  file.getFileItem().getString());
        return "editor/editor-editlocal";
    }
}

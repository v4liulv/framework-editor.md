package com.sinobest.editor.mvc.controller;

import com.alibaba.fastjson.JSONObject;
import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.InputStream;
import java.io.StringWriter;
import java.nio.charset.StandardCharsets;

/**
 * @author liulv
 * @date 2018/12/6
 * <p>
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
    public String editor(@RequestParam("file") CommonsMultipartFile file,
                         HttpServletRequest request) throws Exception {

        //用来检测程序运行时间
        String fileName = file.getOriginalFilename();
        InputStream inputStream = file.getInputStream();

        StringWriter writer = new StringWriter();
        IOUtils.copy(inputStream, writer, StandardCharsets.UTF_8.name());
        String fileContent = writer.toString();

        //LOG.info("file context :{}", fileContent);
        request.setAttribute("fileName", fileName);
        request.setAttribute("fileContent", fileContent);
        return "editor/editor-editlocal";
    }

    /**
     * @param fileContent 文件类型
     * @param fileName    文章类别对应的dictionaries字典表KIND=ARTICLE_TYPE
     * @return 返回保存文章到后台数据库的结果信息
     */
    @RequestMapping(value = "/save")
    @ResponseBody
    public JSONObject editorSave(@RequestParam(value = "fileName") String fileName, @RequestParam(value = "fileContent") String fileContent) {
        JSONObject res = new JSONObject();
        try {
            //异常处理
            //正常数据保存
            res.put("name", fileName);
            res.put("data", fileContent);
            res.put("status", 1);
        } catch (Exception e) {
            e.printStackTrace();
            res.put("status", 0);
            res.put("message", "保存失败，异常信息如下\n " + e.getMessage());
        }
        return res;
    }
}

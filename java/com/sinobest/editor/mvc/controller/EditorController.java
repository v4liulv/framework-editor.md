package com.sinobest.editor.mvc.controller;

import com.alibaba.fastjson.JSONObject;
import com.sinobest.editor.dictionaries.domain.BEditorDictionaries;
import com.sinobest.editor.dictionaries.service.EditorDictionariesService;
import com.sinobest.editor.mvc.domain.BEditorAbstract;
import com.sinobest.editor.mvc.service.BEditorAbstractService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Random;

/**
 * @author liulv
 * @date 2018/1/1
 * <p>
 * 编辑器 控制器
 * <p>
 * 通过Web的 http://localhost:8080/editor 进行访问
 * <p>
 * Editor.md DOC 的Controller
 */
@Controller
@RequestMapping("/editor")
public class EditorController {

    private Logger logger = LoggerFactory.getLogger(EditorController.class);

    @Resource(name = "BEditorAbstractService")
    private BEditorAbstractService bEditorAbstractService;

    @Resource(name = "EditorDictionariesService")
    private EditorDictionariesService editorDictionariesService;

    @RequestMapping(value = "", method = RequestMethod.GET)
    public String home() throws Exception {
        return "redirect:/editor/docs/list";
    }

    /**
     * /editor 请求转发主界面展示的jsp
     *
     * @return 返回对应Spring MVC配置的jsp editor/editor/editor-edit
     * @throws Exception 抛出异常
     */
    @RequestMapping(value = "add", method = RequestMethod.GET)
    public String add(HttpServletRequest request) throws Exception {
        editor("", request);
        return "editor/editor-edit";
    }

    /**
     * 编辑文章
     *
     * @param title 标题
     */
    @RequestMapping(value = "/edit", method = RequestMethod.GET)
    public String editor(@RequestParam(value = "title") String title, HttpServletRequest request) throws Exception {
        List<BEditorAbstract> list = bEditorAbstractService.getByField("BEditorAbstract", "ARTICLE_TITLE", title);
        BEditorAbstract bEditorAbstract = null;
        if (list != null && list.size() > 0) {
            bEditorAbstract = list.get(0);
        }

        //Dictionaries的配置信息EDITOR_TYPE
        List<BEditorDictionaries> bEDITOREDITList = editorDictionariesService.getByField("BEditorDictionaries", "KIND", "ARTICLE_TYPE", "order by CODE");
        if (bEDITOREDITList != null && bEDITOREDITList.size() > 0) {
            request.setAttribute("dictionariesList", bEDITOREDITList);
        }

        //Dictionaries的配置信息EDITOR_TYPE
        List<BEditorDictionaries> bEDITOREDITList_DOCUMENT_TYPE = editorDictionariesService.getByField("BEditorDictionaries", "KIND", "DOCUMENT_TYPE", "order by CODE");
        if (bEDITOREDITList_DOCUMENT_TYPE != null && bEDITOREDITList_DOCUMENT_TYPE.size() > 0) {
            request.setAttribute("bEDITOREDITList_DOCUMENT_TYPE", bEDITOREDITList_DOCUMENT_TYPE);
        }
        request.setAttribute("bEditorAbstract", bEditorAbstract);
        return "editor/editor-edit";
    }

    /**
     * 提供Spring Mvc的传递editor.md的文章标题，
     * 读取数据库信息，传递md数据内容给前端并转换为HTML前端展示
     *
     * @param title   editor文章标题
     * @param request HttpServletRequest 用于request.setAttribute进行数据传递到JSP
     * @return 返回对应Spring MVC配置的jsp editor/editor-to-html
     * @throws Exception 抛出异常
     */
    @RequestMapping(value = "/docs", method = RequestMethod.GET)
    public String docs(@RequestParam(value = "title") String title, HttpServletRequest request) throws Exception {
        System.out.println("title = " + title);
        List<BEditorAbstract> list = bEditorAbstractService.getByField("BEditorAbstract", "ARTICLE_TITLE", title);
        BEditorAbstract bEditorAbstract = null;
        if (list != null && list.size() > 0) {
            bEditorAbstract = list.get(0);
        }
        request.setAttribute("bEditorAbstract", bEditorAbstract);
        return "editor/editor-to-html";
    }

    /**
     * 文章列表
     * 通过动态读取配置库文章信息表，分类别进行全部文章列表展示
     *
     * @param request HttpServletRequest
     * @return 返回editor/editor-md-docs.jsp
     * @throws Exception 抛出异常
     */
    @RequestMapping(value = "/docs/list", method = RequestMethod.GET)
    public String docsList(HttpServletRequest request) throws Exception {

        //BEditorDictionaries的配置信息EDITOR_TYPE
        List<BEditorDictionaries> bEditorDictionaries = editorDictionariesService.getByField(
                "BEditorDictionaries",
                "KIND",
                "ARTICLE_TYPE",
                "order by CODE");
        if (bEditorDictionaries != null && bEditorDictionaries.size() > 0) {
            request.setAttribute("dictionariesList", bEditorDictionaries);
        }

        List<BEditorAbstract> bEditorAbstractsList = bEditorAbstractService.getAllEntity("BEditorAbstract");
        if (bEditorAbstractsList != null && bEditorAbstractsList.size() > 0) {
            request.setAttribute("bEditorAbstractsList", bEditorAbstractsList);
        }

        return "editor/editor_md_docs";
    }

    /**
     * Editor.md 图片上传
     * 保存到对应工程/assets/msg/upload/目录下，并提供Editor.md的图片展示编辑
     * <p>
     * 返回图片上传的后成功的结果
     */
    @RequestMapping(value = "/upload/editormdPic")
    @ResponseBody
    public JSONObject editormdPic(@RequestParam(value = "editormd-image-file", required = true) MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws Exception {

        String trueFileName = file.getOriginalFilename();

        assert trueFileName != null;
        String suffix = trueFileName.substring(trueFileName.lastIndexOf("."));

        String fileName = System.currentTimeMillis() + "_" + (new Random().nextInt(100) % (100 - 10 + 1) + 10) + suffix;

        String path = request.getSession().getServletContext().getRealPath("/assets/msg/upload/");
        System.out.println(path);

        File targetFile = new File(path, fileName);
        if (!targetFile.exists()) {
            //noinspection ResultOfMethodCallIgnored
            targetFile.mkdirs();
        }

        //保存
        try {
            file.transferTo(targetFile);
        } catch (Exception e) {
            e.printStackTrace();
        }

        JSONObject res = new JSONObject();
        System.setProperty("sun.jnu.encoding", "utf-8");
        //使用Web的全路径
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
        res.put("url", basePath + "/assets/msg/upload/" + fileName);
        res.put("success", 1);
        res.put("message", "upload success!");

        return res;
    }

    /**
     * editor/editor-edit.jsp的editor.md编辑文章，点击保存文章后的后台数据处理，保存到B_EDITOR_EDIT表并返回保存成功结果
     *
     * @param document_type   文档类别对应的dictionaries字典表KIND=DOCUMENT_TYPE
     * @param article_type    文章类别对应的dictionaries字典表KIND=ARTICLE_TYPE
     * @param article_title   文章标题
     * @param article_content 文章内容
     * @param article_pdf     文章PDF的URL地址
     * @return 返回保存文章到后台数据库的结果信息
     */
    @RequestMapping(value = "/save")
    @ResponseBody
    public JSONObject editorSave(@RequestParam(value = "systemid", required = false) String systemid,
                                 @RequestParam(value = "document_type") Long document_type,
                                 @RequestParam(value = "article_type") Long article_type,
                                 @RequestParam(value = "article_title") String article_title,
                                 @RequestParam(value = "article_content") String article_content,
                                 @RequestParam(value = "article_pdf", required = false) String article_pdf) {

        JSONObject res = new JSONObject();
        try {
            //异常处理
            if (article_type == 0L || document_type == 0L) {
                res.put("data", "save error!");
                res.put("status", 0);
                res.put("message", "save error, 请选择文章的类型!");
                return res;
            }
            if (null == article_title || "".equals(article_title.trim())) {
                res.put("data", "save error!");
                res.put("status", 0);
                res.put("message", "save error, 文章标题为空！！!");
                return res;
            }
            /*if (null == article_content || "".equals(article_content.trim())) {
                res.put("data", "save error!");
                res.put("status", 0);
                res.put("message", "save error, 文章内容为空！！！");
                return res;
            }*/
            //正常数据保存
            BEditorAbstract bEditorAbstract = new BEditorAbstract();
            bEditorAbstract.setCreateTime(LocalDateTime.now());
            bEditorAbstract.setCreateUser("SYS");
            bEditorAbstract.setScbz(0L);
            bEditorAbstract.setDocumentType(document_type);
            bEditorAbstract.setArticleType(article_type);
            bEditorAbstract.setArticleTitle(article_title);
            if(article_content != null )
            bEditorAbstract.setArticleContent(article_content);
            logger.warn("{} save article_pdf = {}", article_title, article_pdf);

            if (null != article_pdf) {
                bEditorAbstract.setArticlePdf(article_pdf);
            }
            //如果标题存在则更新其标题的文章内容
            //List<BEditorAbstract> list = bEditorAbstractService.getByField("BEditorAbstract", "SYSTEMID", systemid);
            if (systemid != null && !"".equals(systemid.trim())) {
                bEditorAbstract.setSystemid(systemid);
                bEditorAbstract.setUpdateTime(LocalDateTime.now());
                bEditorAbstractService.update(bEditorAbstract);
            } else {
                bEditorAbstractService.save(bEditorAbstract);
            }
            logger.info("{} Save Succession. ", article_title);
            res.put("data", "保存成功!");
            res.put("status", 1);
        } catch (Exception e) {
            e.printStackTrace();
            res.put("status", 0);
            res.put("message", "保存失败，异常信息如下\n " + e.getMessage());
        }
        return res;
    }

    /**
     * 删除文章
     *
     * @param systemid 主键
     */
    @RequestMapping(value = "/delete", method = RequestMethod.GET)
    public String delete(@RequestParam(value = "systemid") String systemid,
                         HttpServletRequest request,
                         HttpServletResponse response) throws Exception {
        logger.info("Delete doc start of systemid:[{}] ", systemid);
        if (systemid != null && !"".equals(systemid.trim())) {
            bEditorAbstractService.delete(bEditorAbstractService.getByField("BEditorAbstract", "SYSTEMID", systemid).get(0));
        }

        response.setContentType("text/xml;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("删除成功");

        logger.info("Delete Doc Success of systemid:[{}]  ", systemid);
        //return docsList(request);

        return null;
    }
}

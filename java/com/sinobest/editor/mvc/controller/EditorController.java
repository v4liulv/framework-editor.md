package com.sinobest.editor.mvc.controller;

import com.alibaba.fastjson.JSONObject;
import com.sinobest.editor.dictionaries.domain.BEditorDictionaries;
import com.sinobest.editor.dictionaries.service.EditorDictionariesService;
import com.sinobest.editor.mvc.domain.BEditorAbstract;
import com.sinobest.editor.mvc.service.BEditorAbstractService;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.Date;
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
     * @param systemid 文章主键
     */
    @RequestMapping(value = "/edit", method = RequestMethod.GET)
    public String editor(@RequestParam(value = "systemid") String systemid, HttpServletRequest request) throws Exception {
        List<BEditorAbstract> list = bEditorAbstractService.getByField("BEditorAbstract", "SYSTEMID", systemid);
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
     * @param systemid   editor文章id
     * @param request HttpServletRequest 用于request.setAttribute进行数据传递到JSP
     * @return 返回对应Spring MVC配置的jsp editor/editor-to-html
     * @throws Exception 抛出异常
     */
    @RequestMapping(value = "/docs", method = RequestMethod.GET)
    public String docs(@RequestParam(value = "systemid") String systemid, HttpServletRequest request) throws Exception {
        logger.info("打开文章 systemid ：{} \n", systemid);
        List<BEditorAbstract> list = bEditorAbstractService.getByField("BEditorAbstract", "SYSTEMID", systemid);
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
     * @return 返回editor/editor-list.jsp
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

        //Dictionaries的配置信息EDITOR_TYPE
        List<BEditorDictionaries> bEditorDictionariesBytype = editorDictionariesService.getByField(
                "BEditorDictionaries", "KIND", "DOCUMENT_TYPE", "order by CODE");
        if (bEditorDictionariesBytype != null && bEditorDictionariesBytype.size() > 0) {
            request.setAttribute("dictionariesByTypeList", bEditorDictionariesBytype);
        }

        List<BEditorAbstract> bEditorAbstractsList = bEditorAbstractService.getAllEntity("BEditorAbstract");
        if (bEditorAbstractsList != null && bEditorAbstractsList.size() > 0) {
            request.setAttribute("bEditorAbstractsList", bEditorAbstractsList);
        }

        return "editor/editor-list";
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
                                 @RequestParam(value = "article_type") int article_type,
                                 @RequestParam(value = "article_value") String article_value,
                                 @RequestParam(value = "article_title") String article_title,
                                 @RequestParam(value = "article_content") String article_content,
                                 @RequestParam(value = "article_pdf", required = false) String article_pdf) {

        JSONObject res = new JSONObject();
        try {
            //异常处理
           /* if (article_type == 0L || document_type == 0L) {
                res.put("data", "save error!");
                res.put("status", 0);
                res.put("message", "save error, 请选择文章的类型!");
                return res;
            }*/
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

            //判断article_title在字段是否存在，不存在则创建
            article_type = documentTypeSave(article_value);

            //正常数据保存
            BEditorAbstract bEditorAbstract = new BEditorAbstract();
            bEditorAbstract.setCreateTime(new Date());
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
                bEditorAbstract.setUpdateTime(new Date());
                bEditorAbstractService.update(bEditorAbstract);
            } else {
                bEditorAbstractService.save(bEditorAbstract);
            }
            logger.info("systemid：{}", bEditorAbstract.getSystemid());
            logger.info("{}-{} Save Succession. ", systemid, article_title);
            logger.info("{}-{} Save Succession. ", systemid, article_title);
            res.put("data", "保存成功");
            res.put("systemid", bEditorAbstract.getSystemid());
            res.put("status", 1);
        } catch (Exception e) {
            e.printStackTrace();
            res.put("status", 0);
            res.put("message", "保存失败，异常信息如下\n " + e.getMessage());
        }
        return res;
    }

    /**
     * 如果文章类别不存在，则保存
     *
     * @param article_value 文章值
     * @return true
     */
    public int documentTypeSave(String article_value){
        BEditorDictionaries editorDictionaries;
        int article_type;
        List<BEditorDictionaries> list = editorDictionariesService.getByField("BEditorDictionaries","value", article_value);
        if(list!= null && list.size()>0 && list.get(0)!=null){
            article_type = Integer.parseInt(list.get(0).getCode());
            return article_type;
        }
        BEditorDictionaries maxBD = editorDictionariesService.getByHQL("from BEditorDictionaries where " +
                "code = (select MAX(CAST(code as integer)) from BEditorDictionaries where code <> '9999')").get(0);
        article_type = Integer.parseInt(maxBD.getCode()) + 1;
        editorDictionaries = new BEditorDictionaries();
        editorDictionaries.setKind("ARTICLE_TYPE");
        editorDictionaries.setKindDel("文章类型");
        editorDictionaries.setCode(String.valueOf(article_type));
        editorDictionaries.setValue(String.valueOf(article_value));
        editorDictionaries.setCreateTime(new Date());
        editorDictionaries.setCreateUser("sys");


        editorDictionariesService.save(editorDictionaries);
       return article_type;
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

    @RequestMapping(value = "/query", method = RequestMethod.POST)
    public ModelAndView queryList(BEditorAbstract bEditorAbstract, HttpServletRequest request) throws Exception {
        ModelAndView mav = new ModelAndView();
        //BEditorDictionaries的配置信息EDITOR_TYPE
        List<BEditorDictionaries> bEditorDictionaries = editorDictionariesService.getByField(
                "BEditorDictionaries",
                "KIND",
                "ARTICLE_TYPE",
                "order by CODE");

        //Dictionaries的配置信息EDITOR_TYPE
        List<BEditorDictionaries> bEditorDictionariesBytype = editorDictionariesService.getByField(
                "BEditorDictionaries", "KIND", "DOCUMENT_TYPE", "order by CODE");

        String ArticleTitle = bEditorAbstract.getArticleTitle();
        long documentType = bEditorAbstract.getDocumentType();
        long articleType = bEditorAbstract.getArticleType();

        StringBuilder sqlSB = new StringBuilder();
        sqlSB.append("select * from B_EDITOR_ABSTRACT");
        if(documentType != 0 && articleType != 0){
            sqlSB.append(" where document_type = ").append(documentType).append(" and article_Type = ").append(articleType);
        }else if(documentType == 0 && articleType != 0){
            sqlSB.append(" where article_Type = ").append(articleType);
        }else if(documentType != 0){
            sqlSB.append(" where document_Type = ").append(documentType);
        }

        if((documentType != 0 || articleType != 0) && StringUtils.isNotBlank(ArticleTitle)){
            sqlSB.append(" and").append(" Article_Title like '%").append(ArticleTitle).append("%'");
        }else if(StringUtils.isNotBlank(ArticleTitle)){
            sqlSB.append(" where Article_Title like '%").append(ArticleTitle).append("%'");
        }

        System.out.println("==============================");
        System.out.println(sqlSB);

        List<BEditorAbstract> bEditorAbstractsList = bEditorAbstractService.findByHQLNative(sqlSB.toString() ,BEditorAbstract.class);

        mav.addObject("modeName", "文档");
        if (bEditorDictionaries != null && bEditorDictionaries.size() > 0) {
            mav.addObject("dictionariesList", bEditorDictionaries);
        }
        if (bEditorDictionariesBytype != null && bEditorDictionariesBytype.size() > 0) {
            mav.addObject("dictionariesByTypeList", bEditorDictionariesBytype);
        }
        if (bEditorAbstractsList != null && bEditorAbstractsList.size() > 0) {
            mav.addObject("bEditorAbstractsList", bEditorAbstractsList);
        }
        mav.setViewName("editor/editor-list-item");
        return mav;
    }
}

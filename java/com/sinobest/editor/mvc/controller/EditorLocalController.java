package com.sinobest.editor.mvc.controller;

import com.alibaba.fastjson.JSONObject;
import com.sinobest.editor.mvc.domain.BEditorAbstract;
import com.sinobest.editor.mvc.service.BEditorAbstractService;
import oracle.sql.BLOB;
import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.StringWriter;
import java.nio.charset.StandardCharsets;
import java.util.Date;
import java.util.Objects;

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

    @Resource(name = "BEditorAbstractService")
    private BEditorAbstractService bEditorAbstractService;

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
           /* if (article_type == 0L || document_type == 0L) {
                res.put("data", "save error!");
                res.put("status", 0);
                res.put("message", "save error, 请选择文章的类型!");
                return res;
            }*/
            if (null == fileName || "".equals(fileName.trim())) {
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
            String article_type = "本地导入";
            String document_type = "markdown";

            //正常数据保存
            BEditorAbstract bEditorAbstract = new BEditorAbstract();
            bEditorAbstract.setCreateTime(new Date());
            bEditorAbstract.setCreateUser("SYS");
            bEditorAbstract.setScbz(0L);
            bEditorAbstract.setDocumentType(1L);
            bEditorAbstract.setArticleType(3);
            bEditorAbstract.setArticleTitle(fileName);


            if(fileContent != null )
                bEditorAbstract.setArticleContent(fileContent);

            //如果标题存在则更新其标题的文章内容
            //List<BEditorAbstract> list = bEditorAbstractService.getByField("BEditorAbstract", "SYSTEMID", systemid);

            bEditorAbstractService.save(bEditorAbstract);
            LOG.info("add doc {} , save Succession. ", fileName);


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

    private byte[] blobToBytes(BLOB blob) {
        BufferedInputStream is = null;
        try {
            is = new BufferedInputStream(blob.getBinaryStream());
            byte[] bytes = new byte[(int) blob.length()];
            int len = bytes.length;
            int offset = 0;
            int read = 0;

            while (offset < len && (read = is.read(bytes, offset, len - offset)) >= 0) {
                offset += read;
            }
            return bytes;
        } catch (Exception e) {
            return null;
        } finally {
            try {
                assert is != null;
                is.close();
                is = null;
            } catch (IOException e) {
                return null;
            }
        }
    }

}

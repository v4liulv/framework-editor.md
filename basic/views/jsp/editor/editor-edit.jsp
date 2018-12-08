<%@ page import="com.sinobest.editor.dictionaries.domain.BEditorDictionaries" %>
<%@ page import="com.sinobest.editor.mvc.domain.BEditorAbstract" %>
<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: liulv
  Date: 2018/1/2
  Time: 1:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8"/>
    <%
        System.setProperty("sun.jnu.encoding", "utf-8");
        String path = request.getContextPath();
        //使用绝对地址，避免神奇的路径BUG
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;

        BEditorAbstract bEditorAbstract = (BEditorAbstract) request.getAttribute("bEditorAbstract");
        String systemid = "";
        String articleContent = "";
        String articleTitle = "";
        String documentType = "1";
        String articleType = "1";
        String abstractPdf = "";

        if (bEditorAbstract != null){
            systemid = bEditorAbstract.getSystemid();
            articleContent = bEditorAbstract.getArticleContent();
            articleTitle = bEditorAbstract.getArticleTitle();
            documentType =  bEditorAbstract.getDocumentType() + "";
            articleType =  bEditorAbstract.getArticleType() + "";
            if(bEditorAbstract.getArticlePdf() != null)
            abstractPdf = bEditorAbstract.getArticlePdf() + "";
        }

        //Dictionaries List Kind = ARTICLE_TYPE
        List<BEditorDictionaries> dictionariesList = (List<BEditorDictionaries>) request.getAttribute("dictionariesList");

        List<BEditorDictionaries> bEDITOREDITList_DOCUMENT_TYPE = (List<BEditorDictionaries>) request.getAttribute("bEDITOREDITList_DOCUMENT_TYPE");

    %>
    <title>MarkDown Editor --- <%=articleTitle%></title>

    <!--引入样式文件-->
    <link rel="stylesheet" href="<%=basePath%>/plug/EditorMD/css/editormd.css"/>
    <%--<link rel="stylesheet" href="<%=basePath%>/plug/EditorMD/css/editormd.preview.css"/>--%>
    <link rel="shortcut icon" href="<%=basePath%>/images/logo/editor/favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="<%=basePath%>/css/editor/editor-edit.css"/>
    <!--引入js文件-->
    <script src="<%=basePath%>/js/jquery/jquery-1.9.1.js"></script>
    <script src="<%=basePath%>/plug/EditorMD/editormd.js"></script>
    <script src="<%=basePath%>/plug/EditorMD/lib/marked.min.js"></script>
    <script src="<%=basePath%>/plug/EditorMD/lib/prettify.min.js"></script>
    <script src="<%=basePath%>/plug/EditorMD/lib/raphael.min.js"></script>
    <script src="<%=basePath%>/plug/EditorMD/lib/underscore.min.js"></script>
    <script src="<%=basePath%>/plug/EditorMD/lib/sequence-diagram.min.js"></script>
    <script src="<%=basePath%>/plug/EditorMD/lib/flowchart.min.js"></script>
    <script src="<%=basePath%>/plug/EditorMD/lib/jquery.flowchart.min.js"></script>

    <script src="<%=basePath%>/js/editor/editor-edit.js"></script>
    <!--js开始-->
    <script type="text/javascript">
        $(function () {
            $("#document_type").val(<%=documentType%>);
            $("#selType").val(<%=articleType%>);
        });
    </script>
    <!--js结束-->
</head>

<body>
<div class="header"></div>
<div class="centre">
    <!-- 标题 -->
    <div class="editormd_essay_title">
        <p id="systemid" class="systemid"><%=systemid%></p>
        <div class="title">
            <p class="subtit">类型:</p>
            <select id="document_type" title="">
                <%
                    //循环editor 类型
                    if (bEDITOREDITList_DOCUMENT_TYPE != null && bEDITOREDITList_DOCUMENT_TYPE.size() > 0) {
                        //循环editor 类型
                        for (BEditorDictionaries editorDictionaries : bEDITOREDITList_DOCUMENT_TYPE) {
                            String editorType = editorDictionaries.getCode();
                            String editorTypeValue = editorDictionaries.getValue();
                %>
                <option value="<%=editorType%>"><%=editorTypeValue%></option>
                <%
                        }
                    }
                %>
            </select>
        </div>

        <div class="title">
            <p class="subtit">标题:</p>
            <select id="selType" title="">
                <%
                    if (dictionariesList != null && dictionariesList.size() > 0) {
                        //循环editor 类型
                        for (BEditorDictionaries bEditorDictionaries : dictionariesList) {
                            String editorType = bEditorDictionaries.getCode();
                            String editorTypeValue = bEditorDictionaries.getValue();
                %>
                <option value="<%=editorType%>"><%=editorTypeValue%>
                </option>
                <%
                        }
                    }
                %>
            </select>
            <input id="txtTitle" style="" maxlength="100" type="text" value="<%=articleTitle %>" title=""/>
        </div>

        <div class="title_pdf">
            <p class="subtit">PDF路径(可选):</p>
            <input id="txtPDF" style="" maxlength="100" type="text" value="<%=abstractPdf %>" title=""/>
        </div>
    </div>

    <!-- 内容 -->
    <div class="editor_content">
        <p class="subtit">文章内容</p>
        <div id="my-editormd">
            <textarea id="my-editormd-markdown-doc" name="my-editormd-markdown-doc" title=""><%=articleContent%></textarea>
            <!-- 注意：name属性的值-->
            <textarea id="my-editormd-html-code" name="my-editormd-html-code" title=""></textarea>
        </div>
    </div>


    <!-- 提交按钮 -->
    <div class="editormd_submit" style="">
        <div class="center">
            <button id="submit" type="submit" style="">保存</button>
            <button id="submit_close" type="submit" style="">保存并关闭</button>
            <button id="close" type="submit" style="">关闭</button>
        </div>
    </div>

</div>
<div class="footer">
</div>
</body>
</html>

<%@ page import="java.util.List" %>
<%--
  Created by IntelliJ IDEA.
  User: liulv
  Date: 2018/1/2
  Time: 1:12

  Description: 编辑本地文件jsp
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
        String fileName = (String) request.getAttribute("fileName");
        String fileContent = (String) request.getAttribute("fileContent");
    %>

    <title>MarkDown Editor LocalFile --- <%=fileName%></title>

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

    <script src="<%=basePath%>/js/file/FileSaver.js"></script>
    <script src="<%=basePath%>/js/editor/editor-editlocal.js"></script>
    <!--js开始-->
    <script type="text/javascript">

    </script>
    <!--js结束-->
</head>

<body>
<div class="header"></div>
<div class="centre">
    <!-- 标题 -->
    <div class="editormd_essay_title">
        <div class="title">
            <p class="subtit">标题:</p>
            <input id="txtTitle" style="" maxlength="100" type="text" value="<%=fileName%>" title=""/>
        </div>

    </div>

    <!-- 内容 -->
    <div class="editor_content">
        <p class="subtit">文章内容</p>
        <div id="my-editormd">
            <textarea id="my-editormd-markdown-doc" name="my-editormd-markdown-doc" title=""><%=fileContent%></textarea>
            <!-- 注意：name属性的值-->
            <textarea id="my-editormd-html-code" name="my-editormd-html-code" title=""></textarea>
        </div>
    </div>

    <!-- 提交按钮 -->
    <div class="editormd_submit" style="">
        <div class="center">
            <button id="submit" type="submit" style="">保存</button>
            <button id="abort_button" type="submit" style="">终止保存</button>
            <button id="submit_close" type="submit" style="">保存并关闭</button>
            <button id="close" type="submit" style="">关闭</button>
        </div>
    </div>

</div>
<div class="footer">
</div>
</body>
</html>

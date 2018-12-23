<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.sinobest.editor.mvc.domain.BEditorAbstract" %>
<%--
  Created by IntelliJ IDEA.
  User: liulv
  Date: 2018/1/2
  Time: 1:19

  Description: editor.md转换为HTML展示，通过后端调用传递bEditorEdit数据到此JSP
--%>
<html>
<head>
    <meta charset="utf-8"/>
    <%
        System.setProperty("sun.jnu.encoding", "utf-8");
        String path = request.getContextPath();
        //使用绝对地址，避免神奇的路径BUG
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;

        BEditorAbstract bEditorAbstract = (BEditorAbstract) request.getAttribute("bEditorAbstract");
        String abstractContent = "";
        if(bEditorAbstract != null) abstractContent = bEditorAbstract.getArticleContent();
        String abstractTitle = "";
        if(bEditorAbstract != null) abstractTitle = bEditorAbstract.getArticleTitle();
    %>
    <title>EditorMDtoHtml-<%=abstractTitle%></title> <!--jsp 标题 -->
    <!--jsp 标题图标logo -->
    <link rel="shortcut icon" href="<%=basePath%>/images/logo/article/article_logo.png" type="image/x-icon"/>
    <!--引入样式文件-->
    <link rel="stylesheet" href="<%=basePath%>/plug/EditorMD/css/editormd.css"/>
    <link rel="stylesheet" href="<%=basePath%>/plug/EditorMD/css/editormd.preview.css"/>
    <link rel="stylesheet" href="<%=basePath%>/css/editor/editor-to-html.css"/>

    <!--引入js文件-->
    <script src="<%=basePath%>/js/jquery/jquery-1.9.1.js"></script>
    <script src="<%=basePath%>/plug/EditorMD/lib/marked.min.js"></script>
    <script src="<%=basePath%>/plug/EditorMD/lib/prettify.min.js"></script>
    <script src="<%=basePath%>/plug/EditorMD/lib/raphael.min.js"></script>
    <script src="<%=basePath%>/plug/EditorMD/lib/underscore.min.js"></script>
    <script src="<%=basePath%>/plug/EditorMD/lib/sequence-diagram.min.js"></script>
    <script src="<%=basePath%>/plug/EditorMD/lib/flowchart.min.js"></script>
    <script src="<%=basePath%>/plug/EditorMD/lib/jquery.flowchart.min.js"></script>
    <script src="<%=basePath%>/plug/EditorMD/editormd.js"></script>
    <script>
        /*html参数获取，并且通过的参数文件获取md文件内容*/
        window.searchMap = location.search.substr(1).split('&').reduce(function (r, it) {
            var them = it.split('=');
            r[them[0]] = them[1];
            return r;
        }, {});
        $.ajaxSetup({async: false});

    </script>
</head>

<style>

</style>

<body>

<div class="main">
    <!-- 自定义目录Toc容器Div -->
   <div id = "custom-toc-container" class="custom-toc"></div>
    <!-- MD的内容容器层DIV -->
    <div id="markdown-html" class="markdown-html" style="">
        <textarea id="appendTxt" title="md—text"><%= abstractContent %></textarea>
    </div>
</div>

<script>
    $(function () {
            //转换html开始,第一个参数是上面的div的id
            editormd.markdownToHTML("markdown-html", {
                htmlDecode: "style,script,iframe", //可以过滤标签解码
                emoji: true,
                taskList: true,
                tocm: true,              // 默认不解析
                tocContainer    : "#custom-toc-container", // 自定义 ToC 容器层
                tex: true,               // 默认不解析
                flowChart: true,         // 默认不解析
                sequenceDiagram: true,  // 默认不解析
                markdownSourceCode: true,  // 默认不解析
                previewCodeHighlight: true,  // 默认不解析
            });
        }
    );

</script>

</body>
</html>

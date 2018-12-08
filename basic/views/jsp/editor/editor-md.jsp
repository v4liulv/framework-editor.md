<%--
  Created by IntelliJ IDEA.
  User: liulv
  Date: 2018/1/2
  Time: 1:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8"/>
    <title>EditorMDtoHtml</title>
    <%
        System.setProperty("sun.jnu.encoding", "utf-8");
        String path = request.getContextPath();
        //使用绝对地址，避免神奇的路径BUG
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
        String name = (String) request.getAttribute("name");
        if (name == null) name = "";
    %>
    <!--引入样式文件-->
    <link rel="stylesheet" href="<%=basePath%>/plug/EditorMD/css/editormd.css"/>
    <link rel="stylesheet" href="<%=basePath%>/plug/EditorMD/css/editormd.preview.css"/>

    <!--引入js文件-->
    <!--<script src="/js/jquery/jquery-1.9.1.js"></script>-->
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

<body>

<div id="markdown-html" style="margin:0 auto; width: 60%">
    <textarea id="appendTxt" style="display:none;" title="md—text"></textarea>
</div>

<script>
    $.get(searchMap.md, function (text) {
            /*初始化appendTxt*/
            $("#markdown-html").html('<textarea id="appendTxt" style="display:none;"></textarea>');
            //将需要转换的内容加到转换后展示容器的textarea隐藏标签中
            $("#appendTxt").val(text);
            //转换html开始,第一个参数是上面的div的id
            editormd.markdownToHTML("markdown-html", {
                htmlDecode: "style,script,iframe", //可以过滤标签解码
                emoji: true,
                taskList: true,
                tocm: true,              // 默认不解析
                tex: true,               // 默认不解析
                flowChart: true,         // 默认不解析
                sequenceDiagram: true ,  // 默认不解析
                markdownSourceCode: true ,  // 默认不解析
                previewCodeHighlight: true ,  // 默认不解析
            });
        }
    );
</script>

</body>
</html>

<%@ page import="java.util.List" %>
<%@ page import="com.sinobest.framework.dictionaries.mvc.domain.Dictionaries" %>
<%@ page import="com.sinobest.editor.mvc.domain.BEditorAbstract" %>
<%--
  Created by IntelliJ IDEA.
  User: liulv
  Date: 2018/1/2
  Time: 16:19

  editor.md的doces文章汇总的JSP
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="" xml:lang="">
<head>
    <meta charset="utf-8"/>
    <meta name="generator" content="pandoc"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes"/>
    <title>doc-概要汇总</title>
    <%
        System.setProperty("sun.jnu.encoding", "utf-8");
        //使用绝对地址，避免神奇的路径BUG
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
        //BEditorAbstract List
        List<BEditorAbstract> bEditorAbstractsList = (List<BEditorAbstract>) request.getAttribute("bEditorAbstractsList");
        //Dictionaries List Kind = ARTICLE_TYPE
        List<Dictionaries> dictionariesList = (List<Dictionaries>) request.getAttribute("dictionariesList");
    %>

    <style type="text/css">
        body {
            width: 50%;
            margin: 0 auto;
        }

        code {
            white-space: pre-wrap;
        }

        span.smallcaps {
            font-variant: small-caps;
        }

        span.underline {
            text-decoration: underline;
        }

        div.column {
            display: inline-block;
            vertical-align: top;
            width: 50%;
        }

        ul {
            margin-bottom: 30px;
        }

        ul li {
            margin-bottom: 10px;
            font: "YaHei Consolas Hybrid", Consolas, "微软雅黑", "Meiryo UI", "Malgun Gothic", "Segoe UI", "Trebuchet MS", Helvetica, "Monaco", courier, monospace;
            font-size: 17px;
        }

        a {
            color: #4183c4;
            text-decoration: none;
        }

        a:hover {
            font-family: "宋体";
            color: #FF0000;
        }

        hr {
            color: #bfcace;
        }
    </style>
    <script src="<%=basePath%>/js/jquery/jquery-1.9.1.js"></script>
    <!--[if lt IE 9]>
    <script src="//cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv-printshiv.min.js">
    </script>
    <![endif]-->
    <script type="text/javascript">
        $(function () {
            $(".delete").click(function (data) {   //点击按钮访问后台servlet
                var systemid = $("#systemid").html().trim();
                var r = confirm("确定删除吗？");
                if (r == true) {
                    var xhr = createXmlHttpRequest();
                    xhr.onreadystatechange = function () {
                        if (xhr.readyState == 4) {
                            if (xhr.status == 200 || xhr.status == 304) {
                            }
                        }
                    };
                    xhr.open("GET", "/editor/delete?systemid=" + systemid);
                    xhr.send(null);
                } else {

                }
            });

            function createXmlHttpRequest() {
                var xmlHttp;
                try {    //Firefox, Opera 8.0+, Safari
                    xmlHttp = new XMLHttpRequest();
                } catch (e) {
                    try {    //Internet Explorer
                        xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
                    } catch (e) {
                        try {
                            xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
                        } catch (e) {
                        }
                    }
                }
                return xmlHttp;
            }

        });
    </script>
</head>
<body>
<h1>
    可视化分析
</h1>
<%--<h2 id="doc文件-概要汇总">DOC文件-概要汇总</h2>--%>
<%--<h2 id="目录">目录</h2>
<p>[TOCM]</p>
<p>[TOC]</p>--%>
<h2 id="kshfx">可视化分析项目文档汇总 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <a href="<%=basePath%>/editor/add" title="" style="color: #bfcace">新增文档</a></h2>
<%
    if (dictionariesList != null && dictionariesList.size() > 0) {
        //循环editor 类型
        for (Dictionaries dictionaries : dictionariesList) {
            String editorType = dictionaries.getCode();
            String editorTypeValue = dictionaries.getValue();
%>
<h3 id="<%= editorType%>"><%= editorTypeValue%>
</h3>

<%
    if (bEditorAbstractsList != null && bEditorAbstractsList.size() > 0) {
%>
<hr/>
<blockquote>
    <ul>
        <%
            //循环类型对应的文章
            for (BEditorAbstract bEditorAbstract : bEditorAbstractsList) {
                if (editorType.equals(bEditorAbstract.getArticleType() + "")) {
                    String systemid = bEditorAbstract.getSystemid();
                    String editTitle = bEditorAbstract.getArticleTitle();
                    Long documentType = bEditorAbstract.getDocumentType();
                    String abstractContent = bEditorAbstract.getArticleContent();
                    String abstractPDF = bEditorAbstract.getArticlePdf();


                    if (documentType.equals(1L)) {
        %>
        <li>
            <a href="<%=basePath%>/editor/docs?title=<%=editTitle %>" title="<%=editTitle %>"><%=editTitle %>
            </a>
                <%
                    }else if(documentType.equals(4L)){
        %>
        <li>
            <a href="<%=basePath%><%=abstractContent%>" title="<%=editTitle %>" class=""><%=editTitle %>
            </a>
                <%
                    }else{
                        %>
        <li>
            <%=editTitle %>
            <%
                }

                if(null == abstractPDF || "".equals(abstractPDF)){
            %>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="javascript:volid(0);" title="<%=abstractPDF %>" style="color: #bfcace">PDF</a>
            <%
                }else{
            %>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="<%=basePath%><%=abstractPDF%>" title="<%=abstractPDF %>" >PDF</a>
            <%
                }
            %>


            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="<%=basePath%>/editor/edit?title=<%=editTitle %>" title="<%=editTitle %>"
               style="color: #bfcace">编辑</a>
            &nbsp;
            <p id="systemid" style="display: none"><%=systemid %>
            </p>
            <a href="" class="delete" title="<%=systemid %>" style="color: #bfcace">删除</a>
        </li>
        <%
                }
            }
        %>
    </ul>
</blockquote>
<%

            }
        }


    }
%>
</body>
</html>
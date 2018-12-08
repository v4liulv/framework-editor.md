<%@ page import="com.sinobest.editor.dictionaries.domain.BEditorDictionaries" %>
<%@ page import="com.sinobest.editor.mvc.domain.BEditorAbstract" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Set" %>
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
    <title>DOC-概要汇总</title>
    <%
        System.setProperty("sun.jnu.encoding", "utf-8");
        String path = request.getContextPath();
        //使用绝对地址，避免神奇的路径BUG
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
        //BEditorAbstract List
        List<BEditorAbstract> bEditorAbstractsList = (List<BEditorAbstract>) request.getAttribute("bEditorAbstractsList");
        //Dictionaries List Kind = ARTICLE_TYPE
        List<BEditorDictionaries> dictionariesList = (List<BEditorDictionaries>) request.getAttribute("dictionariesList");
    %>


    <link rel="shortcut icon" href="<%=basePath%>/images/logo/editor/favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="<%=basePath%>/css/editor/editor-md-docs.css"/>
    <script src="<%=basePath%>/js/jquery/jquery-1.9.1.js"></script>
    <script src="<%=basePath%>/js/editor/editor-list.js"></script>
    <script src="<%=basePath%>/js/file/FileSaver.js"></script>
    <!--[if lt IE 9]>
    <script src="//cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv-printshiv.min.js"></script>
    <![endif]-->
    <script type="text/javascript">
    </script>
</head>
<body>
<h1>
    MD文章管理
</h1>
<%--<h2 id="doc文件-概要汇总">DOC文件-概要汇总</h2>--%>
<%--<h2 id="目录">目录</h2>
<p>[TOCM]</p>
<p>[TOC]</p>--%>
<h2 id="kshfx">项目文档汇总 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <a href="<%=basePath%>/editor/add" title="" style="color: #bfcace">新增文档</a>
    <form action="<%=basePath%>/editor_local/edit" method="post" enctype="multipart/form-data">
        <input type="file"  name="file"  id="files" style="display:none"/>
        <input type="button" id="open" value="打开"/>
        <input type="submit" id="submit" value="submit" style="display:none"/>
    </form>

    <input type="button" id="export" value="另存为"/>
</h2>
<script type="text/javascript">

</script>

<%
    if (dictionariesList != null && dictionariesList.size() > 0) {
        //循环editor 类型
        for (BEditorDictionaries bEditorDictionaries : dictionariesList) {
            String editorType = bEditorDictionaries.getCode();
            String editorTypeValue = bEditorDictionaries.getValue();

            if (bEditorAbstractsList != null && bEditorAbstractsList.size() > 0) {

                Set<String> abstractEditorTypeSet = new HashSet<>();
                for (BEditorAbstract bEditorAbstract : bEditorAbstractsList) {
                    abstractEditorTypeSet.add(bEditorAbstract.getArticleType() + "");
                }

                //判断editor 类型是否存在文章
                if (abstractEditorTypeSet.contains(editorType)) {
%>
<h3 id="<%= editorType%>"><%= editorTypeValue%>
</h3>
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
            <a href="<%=basePath%>/editor/docs?title=<%=editTitle %>" title="<%=editTitle %>"
               target="_Blank"><%=editTitle %>
            </a>
                <%
                    }else if(documentType.equals(4L)){
        %>
        <li>
            <a href="<%=basePath%><%=abstractContent%>" title="<%=editTitle %>" class="" target="_Blank"><%=editTitle %>
            </a>
                <%
                    }else{
                        %>
        <li>
            <%=editTitle %>
            <%
                }

                if (null == abstractPDF || "".equals(abstractPDF)) {
            %>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="javascript:volid(0);" title="<%=abstractPDF %>" style="color: #bfcace" target="_Blank">PDF</a>
            <%
            } else {
            %>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="<%=basePath%><%=abstractPDF%>" title="<%=abstractPDF %>" target="_Blank">PDF</a>
            <%
                }
            %>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <a href="<%=basePath%>/editor/edit?title=<%=editTitle %>" title="<%=editTitle %>"
               style="color: #bfcace" target="_Blank">编辑</a>
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
    }
%>
</body>
</html>
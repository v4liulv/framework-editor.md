//监控快捷键Ctrl S 保存，但是其他按键都没法进行编辑器编辑

/*function keyDown(e){
    e.preventDefault();
    var currKey=0, e=e||event||window.event;
    currKey = e.keyCode||e.which||e.charCode;
    if(currKey === 83 && (e.ctrlKey||e.metaKey)){
        $('#submit').click();
        return false;
    }
}
document.onkeydown = keyDown;*/


$(function () {
    var testEditor = editormd("my-editormd", {//注意1：这里的就是上面的DIV的id属性值
        width: "100%",
        height: 650,
        htmlDecode: "style,script,iframe",
        syncScrolling: "single",
        path: "/plug/EditorMD/lib/",//注意2：你的路径
        saveHTMLToTextarea: true,//注意3：这个配置，方便post提交表单 开启保存HTML文件

        emoji: true,//emoji表情，默认关闭
        taskList: true,
        tocm: true, // Using [TOCM]
        tex: true,// 开启科学公式TeX语言支持，默认关闭
        flowChart: true,//开启流程图支持，默认关闭
        sequenceDiagram: true,//开启时序/序列图支持，默认关闭,

        dialogLockScreen: false,//设置弹出层对话框不锁屏，全局通用，默认为true
        dialogShowMask: false,//设置弹出层对话框显示透明遮罩层，全局通用，默认为true
        dialogDraggable: false,//设置弹出层对话框不可拖动，全局通用，默认为true
        dialogMaskOpacity: 0.4, //设置透明遮罩层的透明度，全局通用，默认值为0.1
        dialogMaskBgColor: "#000",//设置透明遮罩层的背景颜色，全局通用，默认为#fff

        codeFold: true,

        /**上传图片相关配置如下*/
        imageUpload: true,
        imageFormats: ["jpg", "jpeg", "gif", "png", "bmp", "webp"],
        imageUploadURL: "/editor/upload/editormdPic", //注意你后端的上传图片服务地址

        /*上传图片成功后可以做一些自己的处理*/
        /* onload: function () {
             console.log('onload', this);
             this.fullscreen();
             this.unwatch();
             this.watch().fullscreen();
             this.width("100%");
             this.height(480);
             this.resize("100%", 640);
         },*/

        /**设置主题颜色*/
        //editorTheme: "pastel-on-dark",
        theme: "gray",
        //previewTheme: "dark"
    });

    //testEditor.getMarkdown();//获取 Markdown 源码
    //testEditor.getHTML();// 获取 Textarea 保存的 HTML 源码
    //testEditor.getPreviewedHTML();// 获取预览窗口里的 HTML，在开启 watch 且没有开启 saveHTMLToTextarea 时使用

    /**
     * 点击submit通过ajax提交editor编辑的内容提交到后台处理
     */
    $("#submit").click(
        function () {
            var systemid = $("#systemid").html().trim();
            var document_type = $("#document_type").val().trim();
            var article_type = $("#selType").val().trim();
            var article_title = $("#txtTitle").val().trim();
            var my_editormd_markdown_doc = testEditor.getMarkdown();
            var article_pdf = $("#txtPDF").val().trim();
            var data = {
                systemid: systemid,
                document_type: document_type,
                article_type: article_type,
                article_title: article_title,
                article_content: my_editormd_markdown_doc,
                article_pdf: article_pdf
            };

            $.ajax({
                url: "/editor/save",
                type: "post",
                dataType: "json",
                data: data,
                success: function (result) {
                    //result是服务器返回的json结果
                    if (result.status) {
                        alert(result.data);
                        //window.location.href = "/editor/docs/list";
                        //window.location.href = "/editor/edit?title=" + article_title;
                    } else {
                        alert(result.message);
                    }
                },
                error: function () {
                    alert("submit发生异常，请重试！");
                }
            });

        }
    );


    $("#close").click(
        function () {
            window.location.href = "/editor/docs/list";
        }
    );

    $("#submit_close").click(
        function () {
            var systemid = $("#systemid").html().trim();
            var document_type = $("#document_type").val().trim();
            var article_type = $("#selType").val().trim();
            var article_title = $("#txtTitle").val().trim();
            var my_editormd_markdown_doc = testEditor.getMarkdown();
            var article_pdf = $("#txtPDF").val().trim();
            var data = {
                systemid: systemid,
                document_type: document_type,
                article_type: article_type,
                article_title: article_title,
                article_content: my_editormd_markdown_doc,
                article_pdf: article_pdf
            };

            $.ajax({
                url: "/editor/save",
                type: "post",
                dataType: "json",
                data: data,
                success: function (result) {
                    //result是服务器返回的json结果
                    if (result.status) {
                        alert(result.data);
                        window.location.href = "/editor/docs/list";
                    } else {
                        alert(result.message);
                    }
                },
                error: function () {
                    alert("save调用发生异常，请重试！");
                }
            });

        });
});


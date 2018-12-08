var testEditor;
$(function () {
    testEditor = editormd("my-editormd",//注意1：这里的就是上面的DIV的id属性值
        {
        width: "100%",
        height: 750,
        path: "/plug/EditorMD/lib/",//注意2：你的路径
        /**设置主题颜色*/
        theme: "gray",
        //previewTheme: "dark",
        //editorTheme: "pastel-on-dark",
        codeFold: true, //代码折叠
        //syncScrolling : false,
        syncScrolling: "single",
        saveHTMLToTextarea: true,//保存 HTML 到 Textarea，注意3：这个配置，方便post提交表单 开启保存HTML文件
        searchReplace: true, //查询替换
        watch: false, // 关闭实时预览
        htmlDecode: "style,script,iframe|on*",// 开启 HTML 标签解析，为了安全性，默认不开启
        //toolbar  : false,             //关闭工具栏
        //previewCodeHighlight : false, // 关闭预览 HTML 的代码块高亮，默认开启
        emoji: true,//emoji表情，默认关闭
        taskList: true,
        //autoHeight : true,//自动高度
        tocm: true, // Using [TOCM]
        tex: true,// 开启科学公式TeX语言支持，默认关闭
        flowChart: true,//开启流程图支持，默认关闭
        sequenceDiagram: true,//开启时序/序列图支持，默认关闭,
        //dialogLockScreen: false,//设置弹出层对话框不锁屏，全局通用，默认为true
        //dialogShowMask: true,//设置弹出层对话框显示透明遮罩层，全局通用，默认为true
        //dialogDraggable: false,//设置弹出层对话框不可拖动，全局通用，默认为true
        //dialogMaskOpacity: 0.4, //设置透明遮罩层的透明度，全局通用，默认值为0.1
        //dialogMaskBgColor: "#000",//设置透明遮罩层的背景颜色，全局通用，默认为#fff

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

        /**快捷键设置**/
        disabledKeyMaps: [
            "Ctrl-B", "F11", "F10"  // 禁用一些默认的键盘快捷键
        ],
        onload: function () {
            var keyMap = {
                "Ctrl-S": function (cm) {
                    save(false);
                },
                "Ctrl-A": function (cm) { // default Ctrl-A selectAll
                    // custom
                    //alert("Ctrl+A");
                    cm.execCommand("selectAll");
                }
            };

            // setting signle key
            var keyMap2 = {
                "Ctrl-T": function (cm) {
                    alert("Ctrl+T");
                }
            };

            this.addKeyMap(keyMap);
            this.addKeyMap(keyMap2);
            this.removeKeyMap(keyMap2);  // remove signle key
        },
    });

    //testEditor.getMarkdown();//获取 Markdown 源码
    //testEditor.getHTML();// 获取 Textarea 保存的 HTML 源码
    //testEditor.getPreviewedHTML();// 获取预览窗口里的 HTML，在开启 watch 且没有开启 saveHTMLToTextarea 时使用
    /**
     * 点击submit通过ajax提交editor编辑的内容提交到后台处理
     */
    $("#submit").click(
        function () {
            save(false);
        }
    );


    $("#close").click(
        function () {
            window.location.href = "/editor/docs/list";
        }
    );

    $("#submit_close").click(
        function () {
            save(true);
        }
    );

    function save(isClose) {
        //读取界面参数
        var systemid = $("#systemid").html().trim();
        var document_type = $("#document_type").val().trim();
        var article_type = $("#selType").val().trim();
        var article_title = $("#txtTitle").val().trim();
        var my_editormd_markdown_doc = testEditor.getMarkdown();
        var article_pdf = $("#txtPDF").val().trim();
        //ajax的url调用参数data准备
        var data = {
            systemid: systemid,
            document_type: document_type,
            article_type: article_type,
            article_title: article_title,
            article_content: my_editormd_markdown_doc,
            article_pdf: article_pdf
        };

        $.ajax({
            url: "/editorlocal/save",
            type: "post",
            //async:false, 设置同步，默认为true为异步
            //cache:false,  设置是否缓存，默认为true为缓存
            dataType: "json",
            data: data,
            success: function (result) {
                //result是服务器返回的json结果
                if (result.status) {
                    alert(result.data);
                    if (isClose) {
                        window.location.href = "/editor/docs/list";
                    }
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
});


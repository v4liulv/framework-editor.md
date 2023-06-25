$(function () {
    /**
     * 导航点击后选择变色
     */
    $(".nav li").removeClass("title_colo");
    $(".nav .incr_doc").addClass("title_colo");

    var xhr;

    $(".delete").click(function () {   //点击按钮访问后台servlet
        var systemid = this.title.toString();
        var r = confirm("确定删除吗？");
        if (r) {
            xhr = createXmlHttpRequest();
            //xhr.timeout = 3000; //异步才能设置超时
            //设置响应返回的数据格式
            //xhr.responseType = "text";

            //创建一个 get 请求，第二个参数 true采用异步, false代表同步
            //open()方法并不会真正发送请求，而只是启动一个请求以备发送。通过send()方法进行发送请求
            xhr.open("GET", "/editor/delete?systemid=" + systemid, false);

            xhr.onreadystatechange = showInfo;

            xhr.ontimeout = onTimeout;

            xhr.onerror = onError;

            //xhr.upload.onprogress = onProgress;

            //GET方式,发送数据,执行send()方法之后，请求就会发送到服务器。
            xhr.send(null);
        }
    });

    function createXmlHttpRequest() {
        var xmlHttp;
        try {    //Firefox, Opera 8.0+, Safari
            //XMLHttpRequest XHR 提供了向服务器发送请求和解析服务器响应提供了流畅的接口,能够以异步方式从服务器获取更多的信息，
            // 这就是说，用户只要触发某一事件，在不刷新网页的情况下，更新服务器最新数据
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

    //设置发送的数据，開始和server端交互
    //注册相关事件回调处理函数
    function showInfo() {
        if (xhr.readyState === 4) {
            if (xhr.status === 200 || xhr.status === 304) {
                tempAlert(xhr.responseText);
            } else {
                alert("数据返回失败! 状态代码为:" + xhr.status + ", 状态信息:" + xhr.statusText);
            }
        }
    }

    function onTimeout() {
        alert("请求超时了");
    }

    function onError(e) {
        alert("请求onError调用了，出现异常:" + e.toString());
    }

    function onProgress() {
    }

    var txtdata;

    function fileRead() {
        var selectedFile = document.getElementById("files").files[0];//获取读取的File对象
        var name = selectedFile.name;//读取选中文件的文件名
        var size = selectedFile.size;//读取选中文件的大小
        console.log("文件名:" + name + "大小：" + size);

        var reader = new FileReader();//这里是核心！！！读取操作就是由它完成的。
        reader.readAsText(selectedFile, 'UTF-8');//读取文件的内容，注意编码方式

        reader.onload = function () {
            txtdata = this.result;
            console.log(txtdata);//当读取完成之后会回调这个函数，然后此时文件的内容存储到了result中。直接操作即可。
            $('<pre>' + this.result + '</pre>').appendTo('body');
            self.location.href = "/editor_local/edit?fileContext=" + txtdata + "?fileName=" + name;
        };
    }

    $("#open").click(function () {//点击导入按钮，使files触发点击事件，然后完成读取文件的操作。
        $("#files").click();
    });

    $("#files").change(function () {
        $("#submit").click();
    });

    //条件过滤输入框， 点击下拉切换
    //unbind("click") 清除之前的事件绑定
    $('.search_input').unbind("click").on("click", ".classify,.type", function (e) {
        var ul = $(this).find('ul');
        ul.toggle();
        e.stopPropagation();

        var input = $(this).find('input');
        var button = $(this).find('button');
        ul.show();

        $(this).find('ul a').unbind("click").one('click', function () {

            button.html($(this).text());
            button.css("color", "#333");
            input.val($(this).parent().val());
            $(this).parent().addClass('active');
            $(this).parent().siblings().removeClass('active')
            $(this).closest('ul').slideUp(200);
            return false;
        });
        /*  $(this).find('ul a').click(function () {
            alert(code);

            button.html($(this).text());
            button.css("color", "#333");
            input.val($(this).text());
            $(this).parent().addClass('active');
            $(this).parent().siblings().removeClass('active')
            $(this).closest('ul').slideUp(200);
            return false;
        });*/

        window.event ? e.cancelBubble = true : e.stopPropagation();
    });

    //点击其他地方，隐藏下拉ul
    $(document).click(function () {
        $(".dropdown").find('ul').hide();
    });

    $('.btn-mp-search').click(function () {
        var $wrapper = $('#article-list');
        //查询参数
        var type = $(".type input").val();
        var classify = $(".classify input").val();
        var title = $("#search-input").val();
        var param = {};
        if (type !== '0' && type !== "" && type !== "全部" ) param.documentType = type;
        if (classify !== '0' && classify !== "" && classify !== "全部") param.articleType = classify;
        if (title !== null) param.articleTitle = title;
        $wrapper.spinModal(true);

        $.ajax({
            url: "/editor/query",
            type: "post",
            async: true,
            cache: false,    //不允许缓存
            /*dataType: "json",*/
            data: /* $("#form-add").serialize(),*/param,
            success: function (result) {
                $("#article-list").html("");
                $("#article-list").html(result);
                $wrapper.spinModal(false);
            },
            error: function () {
                alert("查询 error");
                $wrapper.spinModal(false);
            }
        });
    });

});





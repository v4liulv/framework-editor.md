$(function () {
    var xhr;

    $(".delete").click(function () {   //点击按钮访问后台servlet
        var systemid = $("#systemid").html().trim();
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
        if(xhr.readyState === 4){
            if(xhr.status === 200 || xhr.status === 304){
                alert(xhr.responseText);
            }else{
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


});
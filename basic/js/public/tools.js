function tempAlert(msg)
{
    let duration = 1500;
    let el = document.createElement("div");
    el.setAttribute("style","position: absolute;top:15%;z-index: 10;left: 45%;right:40%;background-color:#23A8F0FF;color:#ffffff;height:75px;width:150px;font-size:145%;text-align:center;line-height:75px;box-shadow:0px 0px 5px #FF7F50;border-radius: 15px 20px");
    el.innerHTML = msg;
    setTimeout(function(){
        el.parentNode.removeChild(el);
    },duration);
    document.body.append(el);
}

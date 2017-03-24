<%--
  Created by IntelliJ IDEA.
  User: Lsr
  Date: 10/20/14
  Time: 2:30 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <aside class="left-side sidebar-offcanvas">
        <!-- sidebar: style can be found in sidebar.less -->
        <section class="sidebar">
            <!-- Sidebar user panel -->
            <div class="user-panel">
                <%--<div class="pull-left image">--%>
                    <%--<img id="leftProfile" src="${imageRoot}${user.profile}" class="img-circle" alt="User Image" />--%>
                <%--</div>--%>
                <div class="pull-left info">
                    <p>お疲れ様, ${user.username}</p>
                    <input type="hidden" id="userKengen" value="${user.kengen}" />
                    <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
                </div>
                </br> </br> </br>
            </div>
            <!-- search form -->
            <form action="/QRTest/search" method="post" class="sidebar-form" name="searchForm">
                <div class="input-group">
                    <input type="text" name="keyword" id="keyword-input" class="form-control" placeholder="Search..." onkeypress="return check(event.keyCode)">
                            <span class="input-group-btn">
                                <button type='button'  id='keyword-btn' class="btn btn-flat btn-default" onclick="check(13);"><i class="fa fa-search"></i></button>
                            </span>
                </div>
            </form>
            <!-- /.search form -->
            <!-- sidebar menu: : style can be found in sidebar.less -->
            <ul class="sidebar-menu">
                <li id="left-menu-search">
                    <a href="/QRTest/item/valveLocation">
                        <i class="fa fa-edit"></i> <span>弁検索</span>
                    </a>
                </li>
                <li id="left-menu-new" class="kengen-operation">
                    <a href="/QRTest/item/add">
                        <i class="fa fa-paste"></i> <span>新規登録</span>
                    </a>
                </li>
                <li id="left-menu-edit">
                    <a href="/QRTest/item">
                        <i class="fa fa-edit"></i> <span>アイテム検索</span>
                    </a>
                </li>
                <li id="left-menu-master" class="kengen-operation">
                    <a href="/QRTest/location/getAllLocation">
                        <i class="fa fa-cog"></i> <span>マスタ</span>
                    </a>
                </li>
                <li id="left-menu-ics" class="kengen-operation">
                    <a href="/QRTest/ics/getAllIcs">
                        <i class="fa fa-cog"></i> <span>ICS</span>
                    </a>
                </li>
                <li id="left-menu-hv" class="kengen-operation">
                    <a href="/QRTest/HistoryValve/getHisotryForToday">
                        <i class="fa fa-cog"></i> <span>操作履歴</span>
                    </a>
                </li>
                <li id="left-menu-logout">
                    <a href="/QRTest/logout">
                        <i class="fa fa-power-off"></i> <span>ログアウト</span>
                    </a>
                </li>
            </ul>
        </section>
        <!-- /.sidebar -->
    </aside>

<script type="text/javascript">
    $(document).ready(function(){
        //ユーザ権限
        var userKengen=$("#userKengen").val();
        if(userKengen=="6"){
            $(".kengen-operation").show();
        }else if(userKengen.length>0){
            $(".kengen-operation").hide();
        }else{
        }
     });
    //検索キーワードにEnterキーを押す場合チェック
    function check(code){
        if(code==13){
            var keywords = new String($("#keyword-input").val());
            keywords = keywords.toLowerCase();
            if(keywords.length<1){
                alert("キーワードを入力してください");
                return false;
            } else {
                var ills = new Array();
                ills = ['+', '&&', '||', '!', '(', ')' ,'{' ,'}', '[', ']', '^', '"', '~', '*', '?', ':','/'];
                for(var i = 0;i<ills.length;i++){
                    if(keywords.indexOf(ills[i]) > -1){
                        alert("キーワードは正しくありません,下記の記号を入力しないでください。'+', '&&', '||', '!', '(', ')' ,'{' ,'}', '[', ']', '^','*', '?', ':','/'");
                        return false;
                    }
                }

            }

            $("#keyword-input").val(keywords);
            document.searchForm.submit();
        }
    }

    //Logout 関数
    function logoutFun(){
        var href = window.location.href ;
        console.log("href="+href);
        var tmp=href.split("QRTest");
        var newURL="";
//        for(i=0;i<tmp.length;i++){
//            console.log("tmp="+i+""    +tmp[i]);
//        }
        if(tmp.length>=1){
            newURL= tmp[0]+"QRTest";
        }else{
            newURL="https://valdac.power-science.com/QRTest/";
        }
        console.log("newURL="+newURL);
        window.location.href =newURL;
    }
</script>
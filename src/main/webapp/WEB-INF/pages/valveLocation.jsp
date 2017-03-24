<%--
  Created by IntelliJ IDEA.
  User: Lsr
  Date: 10/20/14
  Time: 4:30 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="htmlframe/headFrame.jsp" />
<link rel="stylesheet" type="text/css" href="/QRTest/css/main.css" />
<body class="skin-blue">
<!-- header logo: style can be found in header.less -->
<c:import url="htmlframe/headerFrame.jsp"/>
<div class="wrapper row-offcanvas row-offcanvas-left">
<!-- Left side column. contains the logo and sidebar -->
<c:import url="htmlframe/leftFrame.jsp" />

<!-- Right side column. Contains the navbar and content of the page -->
<aside class="right-side">
<!-- Content Header (Page header) -->
<section class="content-header">
</section>

<!-- Main content -->
<section class="content">

    <div class="row">
        <div class="col-md-12 col-xs-12">
            <div class="box box-solid">
                <div class="box-body no-padding">
                    <div class="form-group" style="margin-bottom:0px">
                        <div class="row">
                            <div class="col-md-6 col-xs-6">
                                <select id="currentLocation" style="font-size:12pt">
                                    <option>全部会社名</option>
                                    <c:forEach items="${nameList}" var="name">
                                        <option>${name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6 col-xs-6">
                                <select id="koujiList" style="font-size:12pt">
                                    <c:forEach items="${koujiList}" var="kouji">
                                        <option>${kouji.id}  ${kouji.kjMeisyo}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%--//locading--%>
            <div  class="row">
                <div class="col-md-10">
                    <div hidden id="loading" align="center"><img src="/QRTest/img/loading.gif"></div>
                </div>
            </div></br>
            <!-- data tables -->
            <!--rgba(60, 141, 188, 0.94)-->
            <div class="box box-primary result-box">

                <div class="box-body no-padding">
                    <div class="list-group valve-list select-list">
                        <table class="table table-hover select-table">
                            <thead>
                            <tr>
                                <th>弁番号</th>
                                <th>弁名称</th>
                            </tr>
                            </thead>
                            <tbody id="valveList">
                            <c:forEach items="${locationValveSelectedForValve}" var="tempvalve">
                                <tr class="valve-item" id="select-${tempvalve.kikiSysId}">
                                    <td>${tempvalve.vNo}</td>
                                    <td>${tempvalve.benMeisyo}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
       </div>
    </div>


</section><!-- /.content -->
</aside><!-- /.right-side -->
</div><!-- ./wrapper -->

<!-- add new calendar event modal -->

<script type="text/javascript">
    $(document).ready(function() {
        // location selected に設定する設定
        var locationFirst = "${locationNameSelectedForValve}";
        var objname = document.getElementById("currentLocation");
        checkSelect(objname, locationFirst);
        //filter関数
        <%--filter("${filterValve}");--%>
    })
    function checkSelect(obj,val){
        for(var i=0;i<obj.length;i++){
            if(obj[i].value==val){
                obj[i].selected=true;
                break;
            }
        }
    }


    //Filter
    function filterPage(){
        //Filter  keyword
        var FilterValveKey = $("#table_search").val();
        //会社名
        var location = $("#currentLocation").val();
        if(location == "全部会社名"){
//            location = "";
            alert("設置プラントを選択してください");
            return false;
        }
        console.log("filter");
        $.post("/QRTest/item/filterValveByKeyword",{"FilterValveKey":FilterValveKey,"location":location},function(data){
            var items = JSON.parse(data);
            if(data=="login"){
                logoutFun();
            }else{
                makeUpTable(items);
            }
        });


    };
    //locationにより弁情報を取得
    $("#currentLocation").change(function(){
        var location = $("#currentLocation").val();
        if(location == "全部会社名"){
            location = "";
        }
        document.getElementById("table_search").value="";
        $.post("/QRTest/item/getValveByLocation",{"location":location},function(data){
            if(data=="login"){
                logoutFun();
            }else{
                var items = JSON.parse(data);
                makeUpTable(items);
            }
        });
    });
    function makeUpTable(items){
        $("#valveList").html("");
        var htmlContent = "";

        if(!items){
            $('#valve_num').html("(0)");
        }else{
            //ユーザ権限
            var userKengen=$("#userKengen").val();
                for(var i = 0;i<items.length;i++){
                    var tmp="";
                    if(items[i].kenanFlg=="1"){
                        tmp="〇"
                    }
                    var tmpGPFLG="";
                    if(items[i].gpFlg=="1"){
                        tmpGPFLG="〇"
                    }
                    htmlContent =
                            htmlContent + '' +
                            '<tr>' +
                            '<td>'+tmp+'</td>' +
                            '<td>'+tmpGPFLG+'</td>' +
                            '<td>'+items[i].vNo+'</td>' +
                            '<td>'+items[i].locationName+'</td>' +
                            '<td>'+items[i].benMeisyo+'</td>' +
                            '<td>'+items[i].keisikiRyaku+'</td>' +
                            '<td>'+items[i].sousaRyaku+'</td>' +
                            '<td>'+items[i].updDate+'</td>' +
                            '<td>' +
                            '<a class="btn btn-primary btn-sm operation-button-btn" href="/QRTest/item/filterValue/'+items[i].kikiSysId+'"><i class="fa fa-pencil">編集</i></a>' +
                            '&nbsp;&nbsp;&nbsp; <c:if test="${(user.kengen eq '6')}"><button  id="indicator" class="btn btn-primary kengen-operation" onclick="copyForValve('+items[i].kikiSysId+')">コピー</button></c:if>'+
                            '</td>' +
                            '</tr>';
                }
            //弁件数
            $('#valve_num').html("("+items.length+")");
        }

        $("#valveList").html(htmlContent);
    }

    function copyForValve(val){
        //処理待ち中にアニメーション表示する
        document.getElementById('loading').style.display = 'block';
        $("#loading").fadeIn();
        var kikiSysId=val;
        $.post("/QRTest/item/copy/",{"kikiSysId":kikiSysId},function(data){
            if(data=="login"){
                logoutFun();
            }else{
                var items = JSON.parse(data);
                makeUpTable(items);
                //ページの読み込みが完了したのでアニメーションはフェードアウトさせる
                $("#loading").fadeOut();
                document.getElementById('loading').style.display = 'none';
            }
        });

    }

    //弁詳細ページへ遷移
    function editForValve(val){
        var keyword = $("#table_search").val();
        if(keyword.length<1){
            keyword="keyword"
        }
        console.log("keyword="+keyword);
        location.href = "/QRTest/item/filterValue/"+val+"/"+keyword;
    }


</script>

<c:import url="htmlframe/footerFrame.jsp" />

</body>

</html>

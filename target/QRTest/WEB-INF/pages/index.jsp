<%--
  Created by IntelliJ IDEA.
  User: Lsr
  Date: 10/15/14
  Time: 10:09 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="htmlframe/headFrame.jsp" />

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
                <h1>
                    Valdac
                </h1>
                <ol class="breadcrumb">
                    <li><i class="fa fa-dashboard"></i> Index</li>
                </ol>
            </section>

    <!-- Main content -->
            <section class="content">

                <div class="row kengen-operation">
                    <div class="col-lg-6 col-xs-6">
                        <!-- small box -->
                        <div class="small-box bg-aqua">
                            <div class="inner">
                                <h3>
                                    新規
                                </h3>
                                <p>
                                    バルブ情報登録
                                </p>
                            </div>
                            <div class="icon">
                                <i class="ion ion-bag"></i>
                            </div>
                            <a href="/QRTest/item/add" class="small-box-footer">
                                入る <i class="fa fa-arrow-circle-right"></i>
                            </a>
                        </div>
                    </div><!-- ./col -->

                    <div class="col-lg-6 col-xs-6">
                        <!-- small box -->
                        <div class="small-box bg-red">
                            <div class="inner">
                                <h3>
                                    一覧
                                </h3>
                                <p>
                                    アイテム情報一覧
                                </p>
                            </div>
                            <div class="icon">
                                <i class="ion ion-pie-graph"></i>
                            </div>
                            <a href="/QRTest/item" class="small-box-footer">
                                入る <i class="fa fa-arrow-circle-right"></i>
                            </a>
                        </div>
                    </div><!-- ./col -->

                </div>

                    <div class="row">
                        <!-- collection -->
                        <div class="col-xs-12">

                            <div class="nav-tabs-custom">
                                <ul class="nav nav-tabs">
                                    <li class="active"><a href="#tab_1" data-toggle="tab">最新バルブ</a></li>
                                    <li class=""><a href="#tab_2" data-toggle="tab">編集履歴</a></li>

                                    <div class="box-tools">
                                        <div class="input-group">
                                            <input type="text" name="table_search" id="table_search" class="form-control input-sm pull-right" style="width: 150px;" placeholder="Filter">
                                            <div class="input-group-btn">
                                                <button class="btn btn-sm btn-default" id="table_search_btn"><i class="fa fa-search"></i></button>
                                            </div>
                                        </div>
                                    </div>
                                </ul>
                                <div class="tab-content">
                                    <div class="tab-pane active" id="tab_1">
                                        <table class="table table-hover valve-table">
                                            <thead><tr>
                                                <th>弁番号</th>
                                                <th>設置プラント</th>
                                                <th>弁名称</th>
                                                <th>型式</th>
                                                <th>駆動方式</th>
                                                <th>更新日付</th>
                                                <th>操作</th>
                                            </tr></thead>
                                            <tbody>
                                            <c:forEach items="${newValveList}" var="newValve">
                                                <tr>
                                                    <td>${newValve.vNo}</td>
                                                    <td>${newValve.locationName}</td>
                                                    <td>${newValve.benMeisyo}</td>
                                                    <td>${newValve.keisikiRyaku}</td>
                                                    <td>${newValve.sousaRyaku}</td>
                                                    <td>${newValve.updDate}</td>
                                                    <td>
                                                        <div class="operation-button">
                                                            <a class="btn btn-primary btn-sm operation-button-btn" href="/QRTest/item/${newValve.kikiSysId}"><i class="fa fa-pencil"></i></a>
                                                            </div>
                                                    </td>
                                                </tr>

                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div><!-- /.tab-pane -->
                                    <div class="tab-pane" id="tab_2">
                                        <table class="table table-hover valve-table">
                                            <thead><tr>
                                                <th>弁番号</th>
                                                <th>設置プラント</th>
                                                <th>弁名称</th>
                                                <th>型式</th>
                                                <th>駆動方式</th>
                                                <th>更新日付</th>
                                                <th>操作</th>
                                            </tr></thead>
                                            <tbody>
                                            <c:forEach items="${updateValveList}" var="updateValve">
                                                <tr>
                                                    <td>${updateValve.vNo}</td>
                                                    <td>${updateValve.locationName}</td>
                                                    <td>${updateValve.benMeisyo}</td>
                                                    <td>${updateValve.keisiki}</td>
                                                    <td>${updateValve.sousa}</td>
                                                    <td>${updateValve.updDate}</td>
                                                    <td>
                                                        <div class="operation-button">
                                                            <a class="btn btn-primary btn-sm operation-button-btn" href="/QRTest/item/${updateValve.kikiSysId}"><i class="fa fa-pencil"></i></a>
                                                             </div>
                                                    </td>
                                                </tr>

                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div><!-- /.tab-pane -->
                                </div><!-- /.tab-content -->
                            </div>
                        </div>

                    </div>
            </section><!-- /.content -->
    </aside><!-- /.right-side -->
</div><!-- ./wrapper -->

<!-- add new calendar event modal -->

<script type="text/javascript">
    $(document).ready(function(){

        //ユーザ権限
        var userKengen=${user.kengen};
        if(userKengen=="6"){
            $(".kengen-operation").show();
        }else{
            $(".kengen-operation").hide();
        }

        $(".box-panel").click(function(){
            $(this).next().toggle();
        });

        $(".valve-table tr").mouseover(function(obj){
            var tr = $(obj.currentTarget)[0];
            $(tr).find(".operation-button").css("opacity","1");
        });
        $(".valve-table tr").mouseout(function(obj){
            var tr = $(obj.currentTarget)[0];
            $(tr).find(".operation-button").css("opacity","0");
        });

        $("#table_search").keyup(function(){
            var keyword = $("#table_search").val();
            keyword = keyword.toLowerCase();
            keyword=keyword.trim();

            var trs = $(".active .valve-table tbody tr");
            for(var i = 0;i<trs.length;i++){
                $(trs[i]).hide();
                var tds = $(trs[i]).find("td");

                for(var j = 0;j<tds.length;j++){
                    var tmpHtml = new String(tds[j].innerHTML);
                    tmpHtml=tmpHtml.toLowerCase();
                    if(tmpHtml.match(keyword)){
                        $(trs[i]).show();
                        break;
                    }
                }
            }
        });

    });
</script>

<c:import url="htmlframe/footerFrame.jsp" />

</body>
</html>
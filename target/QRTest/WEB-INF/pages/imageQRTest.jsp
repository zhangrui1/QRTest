<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="htmlframe/headFrame.jsp" />

<link type="text/css" rel="stylesheet" href="/QRTest/css/kiki.css"/>
<html>
<style type="text/css">
    div.centerdiv { text-align: center; }
    /* loading */
    #image-box-base #loading {
        display:none;
        position:absolute;
        top:0;left:0;
        width:100%;height:100%;
        background:url("/QRTest/img/loading.gif") no-repeat center center;
        border-style: none;
    }
</style>
<head>
    <title>工事支援</title>
</head>
<body class="skin-blue">
<!-- header logo: style can be found in header.less -->

<c:import url="htmlframe/headerFrame.jsp" />

<div class="wrapper row-offcanvas row-offcanvas-left">
<!-- Left side column. contains the logo and sidebar -->
<%--<c:import url="htmlframe/leftFrame.jsp" />--%>

<!-- Right side column. Contains the navbar and content of the page -->
<aside>
<!-- Content Header (Page header) -->
<section class="content-header">
    <h1>
        図面
    </h1>

</section>
<!-- Main content -->
<section class="content">
    <div class="row">
<!-- collection -->
        <div class="col-lg-12">
            <div class="box box-solid">
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
                                    <form name="myForm">
                                    <select id="koujiList" style="font-size:12pt">
                                        <%--<c:forEach items="${koujiList}" var="kouji">--%>
                                            <%--<option>${kouji.id}  ${kouji.kjMeisyo}</option>--%>
                                        <%--</c:forEach>--%>
                                    </select>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="box-body">
                    <div class="form-group">
                        <div class="row">
                            <div class="col-md-3" style="text-align: center">
                                <!-- left frame -->
                                <div class="row">
                                    <div class="col-md-12 kengen-operation">
                                        <!-- new image -->
                                        <div class="btn btn-block btn-primary btn-file-block">
                                            <span class="glyphicon glyphicon-picture"></span>
                                            <span class="glyphicon-class">図面アップロード</span>
                                            <input type="file" id="filePicker" name="attachment[]" multiple="multiple" style="height: 40px !important;">
                                        </div><br>
                                        <!--Add a button for the user to click to initiate auth sequence -->
                                        <%--<button type="button" class="btn btn-danger" onclick="reloadForImage()"/>ページ更新</button>--%>
                                        <button id="authorize-button" style="visibility: hidden">メール認証</button><br>
                                        <span class="authorize-message" id="authorize-message" style="color:#ff0000;visibility: hidden ">「メール認証」ボタンを押してから、図面をアップロードしてください</span>
                                    </div>
                                </div>

                            </div>
                            <div class="col-md-8">
                                <div class="progress">
                                    <div id="totalProgressbar" class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="300" style="width: 0%">
                                        <span id="totalProgress"></span>
                                    </div>
                                </div>
                                <div class="progress  progress-striped active">
                                    <div id="progressbar" class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%">
                                        <span id="currentProgress"></span>
                                    </div>
                                </div>
                            </div>
                        </div><br>
                        <%--図面種類--%>
                        <div class="form-group">
                            <div class="row col-md-12">
                                <div class="btn-group" role="group">
                                    <button type="button" id="typeImage0" class="btn btn-default" onclick="turnToImagesyu(0)"/>全部</button>
                                    <button type="button" id="typeImage1" class="btn btn-default" onclick="turnToImagesyu(1)"/>図面仕様書</button>
                                    <button type="button" id="typeImage2" class="btn btn-default" onclick="turnToImagesyu(2)"/>点検報告書</button>
                                    <button type="button" id="typeImage3" class="btn btn-default" onclick="turnToImagesyu(3)"/>懸案事項一覧</button>
                                    <button type="button" id="typeImage4" class="btn btn-default" onclick="turnToImagesyu(4)"/>完成図面</button>
                                    <button type="button" id="typeImage5" class="btn btn-default" onclick="turnToImagesyu(5)"/>作業指示書</button>
                                    <button type="button" id="typeImage6" class="btn btn-default" onclick="turnToImagesyu(6)"/>弁棒ねじ検索記録</button>
                                    <button type="button" id="typeImage7" class="btn btn-default" onclick="turnToImagesyu(7)"/>GP</button>
                                    <button type="button" id="typeImage8" class="btn btn-default" onclick="turnToImagesyu(8)"/>空</button>
                                </div>
                            </div>
                        </div><br><br>

                        <div class="row centerdiv">
                                <button type="button" class="btn btn-default" onclick="printImage()" value=""/>印刷</button>

                                <button type="button" id="firstButton" class="btn btn-default" onclick="turnToFirstPage()" value=""/>先頭へ</button>

                                <button type="button" id="previousButton" class="btn btn-default" onclick="turnToPreviousPage()" value=""/>前ページ</button>

                                <span id="valueCurrent">${QRfirstImageNum}</span>/<span id="valueTotal">${QRimageListSize}</span>

                                <button type="button" id="NextButton" class="btn btn-default" onclick="turnToNextPage()" value=""/>次ページ</button>

                                <button type="button" id="lastButton" class="btn btn-default" onclick="turnToLastPage()" value=""/>最終へ</button>

                                <input type="text"  name="jump_page_num" id="jump_page_num" style="width: 50px;" value=""/>&nbsp; &nbsp;&nbsp; &nbsp;

                                <button type="button" class="btn btn-default" onclick="turnToNumPage()" value=""/>ページに遷移</button>
                        </div></br></br>
                        <%--//管理者ユーザ用--%>
                        <div class="row" hidden id="imageForAdmin"  class="imageForAdmin">
                            <%--<div class="col-md-1"></div>--%>
                            <div class="col-md-2">
                                <select class="form-control input-sm imagesyu" id="currentSyu" onchange="saveChangeToDatabase(this)">
                                    <option <c:if test="${not empty QRfirstImageValve}"></c:if><c:if test="${(QRfirstImageValve.imagesyu eq '')}"> selected</c:if>></option>
                                    <option <c:if test="${not empty QRfirstImageValve}"></c:if><c:if test="${(QRfirstImageValve.imagesyu eq 'GP装填明細書')}"> selected</c:if>>GP装填明細書</option>
                                    <option <c:if test="${not empty QRfirstImageValve}"></c:if><c:if test="${(QRfirstImageValve.imagesyu eq '図面仕様書')}">selected</c:if>>図面仕様書</option>
                                    <option <c:if test="${not empty QRfirstImageValve}"></c:if><c:if test="${(QRfirstImageValve.imagesyu eq '点検報告書')}">selected</c:if>>点検報告書</option>
                                    <option <c:if test="${not empty QRfirstImageValve}"></c:if><c:if test="${(QRfirstImageValve.imagesyu eq '懸案事項一覧')}">selected</c:if>>懸案事項一覧</option>
                                    <option <c:if test="${not empty QRfirstImageValve}"></c:if><c:if test="${(QRfirstImageValve.imagesyu eq '完成図面')}">selected</c:if>>完成図面</option>
                                    <option <c:if test="${not empty QRfirstImageValve}"></c:if><c:if test="${(QRfirstImageValve.imagesyu eq '作業指示書')}">selected</c:if>>作業指示書</option>
                                    <option <c:if test="${not empty QRfirstImageValve}"></c:if><c:if test="${(QRfirstImageValve.imagesyu eq '弁棒ねじ検索記録')}">selected</c:if>>弁棒ねじ検索記録</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <input type="text" id="imagebikou" class="form-control" onblur="saveBikouChangeToDatabase(this)" value="<c:if test="${not empty QRfirstImageValve}">${QRfirstImageValve.bikou}</c:if>" >
                            </div>
                            <div class="col-md-2">
                                <input type="button" class="btn btn-danger btn-xs" value="削除" onclick="removeImage(this)">
                            </div>
                        </div></br></br>
                        <%--//管理者ユーザ以外用--%>
                        <div class="row" hidden id="imageForOthers" class="imageForOthers">
                            <div class="col-md-2">
                                <input type="text" id="imageSyuForOther" readonly="true" class="form-control"  value="<c:if test="${not empty QRfirstImageValve}">${QRfirstImageValve.imagesyu}</c:if>" >
                            </div>
                            <div class="col-md-4">
                                <input type="text" id="imagebikouForOther" readonly="true" class="form-control"  value="<c:if test="${not empty QRfirstImageValve}">${QRfirstImageValve.bikou}</c:if>" >
                            </div>
                        </div>
                        <div class="row">
                            <div class="row previewDiv">
                                <button type="button" class="btn btn-default" onclick="routeImageForValve(1)" value=""/>右90度</button>
                                <button type="button" class="btn btn-default" onclick="routeImageForValve(0)" value=""/>左90度</button>
                                &nbsp;&nbsp;&nbsp;<input type="text"   name="index_page_num" id="index_page_num" style="width: 50px;" value=""/>
                                <button type="button" id="index_num" class="btn btn-default" onclick="changeNumPage()" value=""/>インデックス変更</button>
                                <span style="color:#ff0000;">「全部」タグを選択された状態に「インデックス変更」が可能です。</span>
                            </div>
                        </div>
                        <div class="row">

                            <div class="col-md-9" id="image-box-base">
                                <div class="row previewDiv" id="valveImg">
                                    <!-- image -->
                                    <img  id="previewImage" class="previewImage"  style="border:solid 1px silver" width="65%"  src="" width="600" value="" />
                                </div>
                                <div id="loading"> </div>
                                <div id="previewImageName" style="display: none"></div>
                            </div>
                            <div class="col-md-3">
                                <table id="Allben" class="table table-hover">
                                    <thead>
                                    <tr>
                                        <th><input id="allCheckbox" type="checkbox" onmouseup="checkAll(this)" /></th>
                                        <th>弁番号</th>
                                        <th>弁名称</th>
                                    </tr>
                                    </thead>
                                    <tbody id="valve-tbody">
                                    <c:forEach items="${valveList}" var="valve">
                                        <tr class="valve-item">
                                            <td id="${valve.kikiSysId}"><input type="checkbox" class="select-ben" style="opacity: 10" value="${valve.kikiSysId}" id="select-${valve.kikiSysId}" /></td>
                                            <td>${valve.vNo}</td>
                                            <td>${valve.benMeisyo}</td>
                                        </tr>
                                    </c:forEach>

                                    </tbody>
                                </table>

                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div><!-- insert -->

<!-- add content modal -->
</section><!-- /.content -->
</aside><!-- /.right-side -->
</div><!-- ./wrapper -->

<script type="text/javascript">
//図面回転用
valueBen=0;//valve 用
function routeImageForValve(type){
    var type=type;
    var tmpAngle;

    if(type==1){//右回り
        valueBen=(valueBen+90)%360;
        tmpAngle=valueBen-90;
    }else{//左回り
        valueBen=(valueBen-90)%360;
        tmpAngle=valueBen+90;
    }
    //クリックして回す
    $("#valveImg img").rotate({
        angle:tmpAngle,
        animateTo: valueBen,
        easing: $.easing.easeInOutExpo
    });
};
function routeImage(value) {
    $("#valveImg img").rotate({
        angle: 0,
        animateTo: value,
        easing: $.easing.easeInOutExpo
    });
};

//関連弁　一括選択
function checkAll(obj){
    if(!obj.checked){
        //be selected
        $('.select-ben').prop('checked', true);
        $('.selected-ben').show();
        $('.valve-item').addClass("bg-light-blue-gradient");
    } else {
        $('.select-ben').prop('checked', false);
        $('.selected-ben').hide();
        $('.valve-item').removeClass("bg-light-blue-gradient");
    }
}
//selected 会社名
function checkSelect(obj,val){
    for(var i=0;i<obj.length;i++){
        if(obj[i].value==val){
            obj[i].selected=true;
            break;
        }
    }
}

//locationにより工事情報を取得
$("#currentLocation").change(function(){
    var location = $("#currentLocation").val();
    if(location == "全部会社名"){
        location = "";
    }
    console.log("location="+location);

    $.post("/QRTest/kouji/getKoujiByLocation",{"location":location},function(data){
        console.log("data="+data);
        if(data=="login"){
            logoutFun();
        }else{
            var items = JSON.parse(data);
            makeUpTable(items);
        }
    });
});

//工事により弁情報を取得
$("#koujiList").change(function(){
    var koujiId = document.myForm.koujiList.value

    console.log("koujiId="+koujiId);

    $.post("/QRTest/kouji/getValvesByKoujiId",{"koujiId":koujiId},function(data){
        console.log("valve data="+data);
        if(data=="login"){
            logoutFun();
        }else{
            var items = JSON.parse(data);
            makeUpValveTable(items);
        }
    });


});

//Kouji　リスト設定
function makeUpValveTable(items){
    var htmlContent = "";

    if(!items){
    }else{
        for(var i = 0;i<items.length;i++){
        //current-select-ben
                htmlContent = htmlContent +
                        "<tr>" +
                        "<td id="+items[i].kikiSysId+"><input type='checkbox' class='select-ben' style='opacity: 10'/></td>"+
                        "<td>" + items[i].vNo + "</td>" +
                        "<td>" + items[i].benMeisyo + "</td>" +
                        "</tr>";
            }
            $("#valve-tbody").html(htmlContent);
    }
}

//Kouji　リスト設定
function makeUpTable(items){
    // <select id="select"> を取得
    var select = document.getElementById('koujiList');
    $('#koujiList').children().remove();


    if(!items){
    }else{
        for(var i = 0;i<items.length;i++){
            // <option> 要素を宣言
            var option = document.createElement('option');
            option.setAttribute('value',items[i].id);
            option.innerHTML = items[i].kjNo+"     "+items[i].kjMeisyo;
            // <select> 内に追加する
            select.appendChild(option);
        }
    }
}

$(document).ready(function(){

    var locationFirst = "${locationNameSelectedForValve}";
    var objname = document.getElementById("currentLocation");
    checkSelect(objname, locationFirst);


    //left menu end -------

    $(".box-panel").click(function(){
        $(this).next().toggle();
    });

});

function removeImage(obj){
    //get image name
    var currentObject = document.getElementById("previewImageName").value;
    currentObject=currentObject.replace("http://storage.googleapis.com/valdac/","")

    var kikiSysId = $("#kikiSysId").val();
    var imageId=document.getElementById('imageId').value;

    $.post("/QRTest/imageQR/deleteByImagenameAndKikiSysId",
            {"object":currentObject,"kikiSysId":kikiSysId,"imageId":imageId},
            function(data){
                if(data=="login"){
                    logoutFun();
                }else{
                    object = currentObject;
                    var request = gapi.client.storage.objects.delete({
                        'bucket': BUCKET,
                        'object': object
                    });
                    request.execute(function(resp) {

                        //index　図面数を更新
                        var setNum = parseInt(document.getElementById("valueCurrent").innerHTML);
                        var totalNum = parseInt(document.getElementById("valueTotal").innerHTML);
                        setNum=setNum-1;
                        totalNum=totalNum-1;
                        if(totalNum>0&&setNum==0){
                            setNum=1;
                            var tmpNum=setNum-1;
                            turnToSet(tmpNum);
                        }else if(totalNum>0&&setNum>0){
                            var tmpNum=setNum-1;
                            turnToSet(tmpNum);
                        }else if(totalNum==0){
                            document.getElementById('previewImage').src="";
                            document.getElementById("imagebikou").value = "";
                            //図面種類表示
                            $("#currentSyu").html("");
                            //図面種類を定義する
                            var array1 = new Array('GP装填明細書','図面仕様書','点検報告書','懸案事項一覧','完成図面','作業指示書','弁棒ねじ検索記録','空');
                            var htmlitem="<option></option>";
                            Array
                            for(var i=0;i<array1.length;i++){
                                htmlitem=htmlitem+"<option>"+array1[i]+"</option>"
                            }
                            $("#currentSyu").html(htmlitem);
                            $("#imageSyuForOther").val("");
                            $("#imagebikouForOther").val("");
                        }
                        document.getElementById("valueCurrent").innerHTML=setNum;
                        document.getElementById("valueTotal").innerHTML=totalNum;
                        turnToSet(setNum);
                    });
                }
                });
}

function progressBarController(num){
    $("#progressbar").attr({"aria-valuenow":num});
    $("#progressbar").css({"width":num+"%"});
}
function totalProgressBarController(numStr,totalStr){
    var num = parseInt(numStr);
    var totalNum = parseInt(totalStr);
    var p = parseFloat(num/totalNum);
    p = p * 100;
    $("#totalProgressbar").attr({"aria-valuenow":p});
    $("#totalProgressbar").css({"width":p+"%"});
}

//update imagesyu
function saveChangeToDatabase(obj){
    //画像名を取得
    var imageUrl=document.getElementById("previewImageName").value;
    var imageName=imageUrl.replace("http://storage.googleapis.com/valdac/","");
    var imageId=document.getElementById('imageId').value;
    var kikiSysId = $("#kikiSysId").val();

    if(imageName.length < 1){
        return false;
    } else {
        $.post("/QRTest/imageQR/updateSyuByImagenameForQR",
                {"imagesyu":$(obj).val(),"object":imageName,"kikiSysId":kikiSysId,"imageId":imageId},
                function(data){
//                    console.log(data);
                    if(data=="login"){
                        logoutFun();
                    }
                });
    }
}
//update bikou
function saveBikouChangeToDatabase(){
    //画像名を取得
    var imageUrl=document.getElementById("previewImageName").value;
    var imageName=imageUrl.replace("http://storage.googleapis.com/valdac/","");
    var kikiSysId = $("#kikiSysId").val();
    var imageId=document.getElementById('imageId').value;

    //bikouを取得
    var bikou=document.getElementById("imagebikou").value;
    if(imageName.length < 1){
        return false;
    } else {
        $.post("/QRTest/imageQR/updateBikouByImagename",
                {"bikou":bikou,"object":imageName,"kikiSysId":kikiSysId,"imageId":imageId},
                function(data){
                    console.log(data);
                    if(data=="login"){
                        logoutFun();
                    }
                });
    }
}


function printImage(obj){
    var imageUrl=document.getElementById("previewImage").src;
    //画像名を取得
    imageUrl=imageUrl.replace("http://storage.googleapis.com/","");
    if(imageUrl.length>10){
        window.open("https://valdac.power-science.com/print.html?"+imageUrl);
    }
}

//set image for valve
function setImage(items,flg) {
    if(flg){
        //図面描画
        var tmpImgUrl=items.imagename;
        document.getElementById('previewImageName').value=tmpImgUrl;
        loadImg(tmpImgUrl);
//        document.getElementById('previewImage').src="http://storage.googleapis.com/valdac/"+items.imagename;
        document.getElementById('imagebikou').value=items.bikou;
        document.getElementById('imageId').value=items.id;
        //図面種類表示
        $("#currentSyu").html("");
        //図面種類を定義する
        var array1 = new Array('GP装填明細書','図面仕様書','点検報告書','懸案事項一覧','完成図面','作業指示書','弁棒ねじ検索記録','空');
        var htmlitem="<option></option>";
        for(var i=0;i<array1.length;i++){
            if(array1[i]==items.imagesyu){
                htmlitem=htmlitem+"<option selected>"+array1[i]+"</option>"
            }else{
                htmlitem=htmlitem+"<option>"+array1[i]+"</option>"
            }
        }

        $("#currentSyu").html(htmlitem);
        $("#imageSyuForOther").val(items.imagesyu);
        $("#imagebikouForOther").val(items.bikou);
    }else{
        document.getElementById("valueCurrent").innerHTML ="0";
        document.getElementById("valueTotal").innerHTML="0";
        document.getElementById('previewImage').src="http://storage.googleapis.com/valdac/";
        document.getElementById('imagebikou').value="";
        document.getElementById('imageId').value="";
        //図面種類表示
        $("#currentSyu").html("");
        //図面種類を定義する
        var array1 = new Array('GP装填明細書','図面仕様書','点検報告書','懸案事項一覧','完成図面','作業指示書','弁棒ねじ検索記録','空');
        var htmlitem="<option></option>";
        Array
        for(var i=0;i<array1.length;i++){
            htmlitem=htmlitem+"<option>"+array1[i]+"</option>"
        }
        $("#currentSyu").html(htmlitem);
        $("#imageSyuForOther").val("");
        $("#imagebikouForOther").val("");


    }
    //図面を元の向けにする
    valueBen=0;//valve 用
    routeImage(0);
}
//種別毎に表示

function turnToImagesyu(type){

    var indexPageNumButton=document.getElementById("index_page_num");
    var indexNumButton=document.getElementById("index_num");
    console.log("type="+type);
    if(0==type){
        console.log("0");
        //全種類の図面が表示される場合のみ、インデックスを修正できる
        indexPageNumButton.disabled=false;
        indexNumButton.disabled=false;
    }else{
        console.log("0以外");
        indexPageNumButton.disabled=true;
        indexNumButton.disabled=true;
    }
    //図面種類選択された場合、ボタン色を修正
    for(var i=0;i<9;i++){
        var tmp="typeImage"+i;
        if(i==type){
            console.log("type="+type);
            document.getElementById(tmp).style.background="#eeeeff";
        }else{
            console.log("type no color="+type);
            document.getElementById(tmp).style.background="";
        }
    }
    //該種類のデータを設定
    $.post("/QRTest/imageQR/setImagesyuSession", {"type": type}, function (data) {
        if(data=="login"){
            logoutFun();
        }else{
            var items = JSON.parse(data);
            if(items.length>0){
                document.getElementById("valueCurrent").innerHTML = "1";
                document.getElementById("valueTotal").innerHTML = items.length + "";
                setImage(items[0], true);
            }else{
                setImage(null, false);
            }
        }
    });
}

//turn to first page
function turnToFirstPage(){
    var setNum = 1;
    if(setNum > 0) {
        turnToSet(setNum);
    }
}

//turn to last page
function turnToLastPage(){
    var setNum = parseInt(document.getElementById("valueTotal").innerHTML);
    if(setNum > 0) {
        turnToSet(setNum);
    }
}
//turn to num page
function turnToNumPage(){
    var valueTotal = parseInt(document.getElementById("valueTotal").innerHTML);
    var valueCurrent = parseInt(document.getElementById("jump_page_num").value);
    //ページ数以内場合遷移する
    if(valueCurrent > 0 && valueCurrent<=valueTotal) {
        turnToSet(valueCurrent);
    }else{
        alert("ページ数以内に半角数字を入力ください");
    }
}

//turn to previous page
function turnToPreviousPage(){
    var setNum = parseInt(document.getElementById("valueCurrent").innerHTML);
    setNum = setNum - 1;
    if(setNum > 0) {
        turnToSet(setNum);
//            document.getElementById("valueCurrent").innerHTML = setNum+"";
    }
}

//turn to next page
function turnToNextPage(){
    var setNum = parseInt(document.getElementById("valueCurrent").innerHTML);
    var totalNum = parseInt(document.getElementById("valueTotal").innerHTML);
    setNum = setNum + 1;
    if(setNum <= totalNum) {
        turnToSet(setNum);
//            document.getElementById("valueCurrent").value = setNum + "";
    }
}

function turnToSet(setNumStr){
    //インデックス入力のinputを空にする
    document.getElementById("index_page_num").value="";
    var totalNum = parseInt(document.getElementById("valueTotal").innerHTML);
    var setNum = parseInt(setNumStr);
    //先頭、最終へボタン設定
    firstAndLastButton(setNum,totalNum,"firstButton","previousButton","NextButton","lastButton");

    if(setNum >= 1 && setNum <= totalNum){
        setNum = setNum - 1;
        $.post("/QRTest/imageQR/getimageForChangePage", {"setNum": setNum}, function (data) {
            console.log("getimageForChangePage");
            console.log(data);
            if(data=="login"){
                logoutFun();
            }else{
                var items = JSON.parse(data);
//            document.getElementById('previewImage').src="http://storage.googleapis.com/valdac/"+items.imagename;
            document.getElementById("valueCurrent").innerHTML = setNum+1;
            document.getElementById("imagebikou").value = items.bikou;
            document.getElementById('imageId').value=items.id;
            //図面描画
            var tmpImgUrl=items.imagename;
            document.getElementById('previewImageName').value=tmpImgUrl;
            loadImg(tmpImgUrl);
            console.log("over");

            //図面種類表示
            $("#currentSyu").html("");
            //図面種類を定義する
            var array1 = new Array('GP装填明細書','図面仕様書','点検報告書','懸案事項一覧','完成図面','作業指示書','弁棒ねじ検索記録','空');
            var htmlitem="<option></option>";
            for(var i=0;i<array1.length;i++){
                if(array1[i]==items.imagesyu){
                    htmlitem=htmlitem+"<option selected>"+array1[i]+"</option>"
                }else{
                    htmlitem=htmlitem+"<option>"+array1[i]+"</option>"
                }
            }


            $("#currentSyu").html(htmlitem);
            $("#imageSyuForOther").val(items.imagesyu);
            $("#imagebikouForOther").val(items.bikou);

            //図面を元の向けにする
            valueBen=0;//valve 用
            routeImage(0);
        }
     });
    }
}
//先頭、最終へボタン設定
function firstAndLastButton(firstNum,lastNum,firstButton,previousButton,NextButton,lastButton){
    var firstButtonName=document.getElementById(firstButton);
    var previousButtonName=document.getElementById(previousButton);
    var NextButtonName=document.getElementById(NextButton);
    var lastButtonName=document.getElementById(lastButton);
    console.log("firstNum="+firstNum+"      lastNum="+lastNum);
    if(firstNum<=1 && lastNum<=1){
        firstButtonName.disabled =true;
        previousButtonName.disabled =true;
        NextButtonName.disabled =true;
        lastButtonName.disabled =true;
    }else if((firstNum==1 && lastNum>1)){
        firstButtonName.disabled =true;
        previousButtonName.disabled =true;
        NextButtonName.disabled =false;
        lastButtonName.disabled =false;
    }else if(firstNum>1 && firstNum==lastNum){
        firstButtonName.disabled =false;
        previousButtonName.disabled =false;
        NextButtonName.disabled =true;
        lastButtonName.disabled =true;
    }else{
        firstButtonName.disabled =false;
        previousButtonName.disabled =false;
        NextButtonName.disabled =false;
        lastButtonName.disabled =false;
    }
}

//関連弁追加画面の検索
function changeNumPage(){

    //arrayの中の番号　pageではない
    var setImageNumNew = parseInt(document.getElementById("index_page_num").value);
    var setImageNumOld=parseInt(document.getElementById("valueCurrent").innerHTML);
    if(isNaN(setImageNumNew)){
        alert("数字を入力してください");
        document.getElementById("index_page_num").value="";
        return false;
    }
    var kikiSysId = $("#kikiSysId").val();
    //page番号を修正されたかどうか
    if(setImageNumNew==setImageNumOld){
        console.log("setImageNumNew="+setImageNumNew+"; setImageNumOld"+setImageNumOld);
        return false;
    }
    //page番号を有効値かどうか
    if(setImageNumNew>"${QRimageListSize}" || setImageNumNew<1){
        console.log("範囲外　setImageNumNew="+setImageNumNew);
        alert("図面件数以内の数字を入力してください");
        return false;
    }

    var imagename= document.getElementById('previewImageName').value;

    //imagename により、page番号を修正する
    $.post("/QRTest/imageQR/changeValveImagePage",{"kikiSysId":kikiSysId,"imagename":imagename,"pageNew":setImageNumNew,"pageOld":setImageNumOld},function(data){
        console.log("data="+data);
        if(data=="login"){
            logoutFun();
        }else{
            document.getElementById("valueCurrent").innerHTML=setImageNumNew;
            //first ボタン設定
            firstAndLastButton(setImageNumNew,"${QRimageListSize}","firstButton","previousButton","NextButton","lastButton");
            alert("更新しました");
        }
    });


}
////図面情報更新後　画面をreloadし、情報を更新する
//function reloadForImage(){
//    location.reload();
//}

//imgPreloaderを作成
var imgPreloader=new Image();
function loadImg(imgUrl) {
    document.getElementById('previewImage').src="/QRTest/img/black.png";
    var OBJECT_NAME=imgUrl;
    var totalSet = parseInt(document.getElementById("valueTotal").innerHTML);
    console.log("imgUrl="+imgUrl+"   totalSet="+totalSet);
    if(totalSet>0){
        //javaにて　signUrlを取得する
        $.post("/QRTest/SingImageUrl/SignTest",{"OBJECT_NAME":OBJECT_NAME,"BUCKET_NAME":BUCKET},function(data){
            console.log("data222222="+data);
            console.log((data=="login"));
            if(data=="login"){
//                logoutFun();
                console.log("logout =");
            }else{
                //画像読み込みの直前にLoading画像を表示する
                $("#loading").css({'display':'block'});
                console.log("1=");
                //onloadイベントハンドラ
                console.log("2=");
                imgPreloader.onload=function() {
                    console.log("3=");
                    $("#loading").css({'display':'none'});
                    //img 設定
                    document.getElementById('previewImage').src=data;
                    console.log("4=");
                }
                imgPreloader.onerror=function(){
                    $("#loading").css({'display':'none'});
                    //エラー画像設定
                    document.getElementById('previewImage').src="/QRTest/img/error.jpg";
                }
                console.log("5=");
                //url-Set
                imgPreloader.src=data;
            }
        });
    }else{
        document.getElementById('previewImage').src="";
    }
};
</script>

<!-- Google Sotrage -->
<script type="text/javascript">
/**
 * The Project ID of your Google Cloud Storage Project.
 */
var PROJECT = 'power-science-20140719001';

//サーバー用 clientId
//var clientId = '13771198627-plrtfkpr8r96ccev7n6ip1f1ublte6n1.apps.googleusercontent.com';
//開発用 clientId
var clientId = '13771198627-bpo57i2unf6dkbna2jo7ehljin6aseoa.apps.googleusercontent.com';
//サーバー用 api key
//var apiKey = 'AIzaSyAG-h3cIM_SsO0fE_gA8lAIl2x71zdC6NA';
//開発用 api key
var apiKey = 'AIzaSyCnoDTW4BQB-DKKf9YWd9AaoEFYKeN6Esw';

var scopes = 'https://www.googleapis.com/auth/devstorage.full_control';
/**
 * Constants for request parameters. Fill these values in with your custom
 * information.
 */
var API_VERSION = 'v1';
var BUCKET = 'icsmaster';//テスト用

/**
 * The name of the object inserted via insertObject method.
 */
var object = "";

var GROUP =
        'group-00b4903a9744bffac3b0196718449ddbaf5cbc5a1ebfff7783546ad6f13e63f6';
/**
 * Valid values are user-userId, user-email, group-groupId, group-email,
 * allUsers, allAuthenticatedUsers
 */
var ENTITY = 'allUsers';
/**
 * Valid values are READER, OWNER
 */
var ROLE = 'OWNER';
/**
 * Valid values are READER, OWNER
 */
var ROLE_OBJECT = 'OWNER';



//multiple file upload control flag
var uploadLoopStatus = 0;
var fileCount = 0;
var timer;
function insertObject(event) {

    progressBarController(0);
    var errorCount=0;//アップできなかった図面数
    var errorFileName="";//アップできなかった図面名
    timer = setInterval(function(){
        if(fileCount < event.target.files.length){
            var Imagenum=fileCount+1;
            $("#totalProgress").html(event.target.files.length+"枚画像をアップロード中です。。。"+"   第"+Imagenum+"枚目です");
            if(uploadLoopStatus == 0){
                uploadLoopStatus = 1;

                try {
                    var fileData = event.target.files[fileCount];
                }
                catch (e) {
                    console.log(e);
                }
                //image type
                var imagetype=["jpg","jpeg","pdf","gif","png","bmp"];
                var fileTypeOld = new String(fileData.name);
                var fileType = fileTypeOld.split('.');
                var  fileTypeName=fileType[fileType.length - 1]
                console.log("fileTypeName="+fileTypeName);
                if(imagetype.indexOf(fileTypeName.toLowerCase())>=0){
                    console.log("存在する");
                    // progressbar
                    progressBarController(10);
                    const boundary = '-------314159265358979323846';
                    const delimiter = "\r\n--" + boundary + "\r\n";
                    const close_delim = "\r\n--" + boundary + "--";
                    var reader = new FileReader();
                    reader.readAsBinaryString(fileData);
                    reader.onload = function (e) {
                        var fileTypeOld = new String(fileData.name);
                        var fileType = fileTypeOld.split('.');

                        //make file name
                        var d = new Date();
                        var vYear = d.getFullYear();
                        var vMon = d.getMonth() + 1;
                        var vDay = d.getDate();
                        if(vMon < 10){
                            vMon = "0" + vMon;
                        }
                        if (vDay < 10) {
                            vDay = "0" + vDay;
                        }
                        var todayDate = vYear + "" + vMon + "" + vDay;
                        var oldfilename= fileType[0].replace(/\s|　/g,"");
                        var objectAndName = "QRTest"+todayDate + "/" + oldfilename +"_"+ d.getTime() + "." + fileType[fileType.length - 1];
//                    var objectAndName="20150501/"+fileTypeOld;
                        //make parameters
                        progressBarController(30);
                        var contentType = fileData.type || 'application/octet-stream';
                        var metadata = {
                            'name': objectAndName,
                            'mimeType': contentType
                        };
                        var base64Data = btoa(reader.result);
                        var multipartRequestBody =
                                delimiter +
                                'Content-Type: application/json\r\n\r\n' +
                                JSON.stringify(metadata) +
                                delimiter +
                                'Content-Type: ' + contentType + '\r\n' +
                                'Content-Transfer-Encoding: base64\r\n' +
                                '\r\n' +
                                base64Data +
                                close_delim;
                        //Note: gapi.client.storage.objects.insert() can only insert
                        //small objects (under 64k) so to support larger file sizes
                        //we're using the generic HTTP request method gapi.client.request()
                        var request = gapi.client.request({
                            'path': '/upload/storage/v1/b/' + BUCKET + '/o',
                            'method': 'POST',
                            'params': {'uploadType': 'multipart'},
                            'headers': {
                                'Content-Type': 'multipart/mixed; boundary="' + boundary + '"'
                            },
                            'body': multipartRequestBody});
                        progressBarController(60);
                        try {
                            //Execute the insert object request
                            executeRequest(request, 'insertObject');
                            //Store the name of the inserted object
                            object = objectAndName;
                        }
                        catch (e) {
                            alert('An error has occurred: ' + e.message);
                        }
                    }
                }else{
                    errorFileName=errorFileName+fileTypeOld+";\n";
                    errorCount=errorCount+1;
                    progressBarController(0);
                    uploadLoopStatus = 2;
                }

            } else if(uploadLoopStatus == 1){
            } else if(uploadLoopStatus == 2){
                fileCount++;
                totalProgressBarController(fileCount,event.target.files.length);
                uploadLoopStatus = 0;
            }
        } else {
            console.log('over');
            if(errorCount>0){
                console.log('下記の拡張子の図面がアップできませんでした\n'+errorFileName);
                alert("下記の拡張子の図面がアップできませんでした\n"+errorFileName);
            }else{
                alert("図面全部アップしました");
            }

            //全て画像アップ後、データ初期化
            uploadLoopStatus = 0;
            fileCount = 0;
            clearInterval(timer);
            location.reload(true);
        }
    },1000);

}
/**
 * Google Cloud Storage API request to insert an Access Control List into
 * your Google Cloud Storage object.
 */
function insertObjectAccessControls() {
    resource = {
        'entity': ENTITY,
        'role': ROLE_OBJECT
    };
    var request = gapi.client.storage.objectAccessControls.insert({
        'bucket': BUCKET,
        'object': object,
        'resource': resource
    });
//    executeRequest(request, 'insertObjectAccessControls');
    executeRequestInsert(object);
}
/**
 * Google Cloud Storage API request to delete a Google Cloud Storage object.
 */
function deleteObject() {
    var request = gapi.client.storage.objects.delete({
        'bucket': BUCKET,
        'object': object
    });
    executeRequest(request, 'deleteObject');
}
function updateApiResultEntry(apiRequestName) {
    listChildren = document.getElementById('main-content')
            .childNodes;
    if (listChildren.length > 1) {
        listChildren[1].parentNode.removeChild(listChildren[1]);
    }
    if (apiRequestName != 'null') {
        window[apiRequestName].apply(this);
    }
}

function executeRequestInsert(objectName) {

//    document.getElementById('previewImage').src="http://storage.googleapis.com/valdac/"+resp.object;
    var kikiSysId = $("#kikiSysId").val();
    progressBarController(100);
    var imageURL=document.getElementById('previewImage').src;
    console.log("imageURL="+imageURL);
    //update database
    $.post("/QRTest/imageQR/saveImageByImagePathForQR",{"object":objectName,"kikiSysId":kikiSysId,"imageURL":imageURL},function(data){
        console.log("data="+data);
        if(data=="login"){
            logoutFun();
        }else{
            progressBarController(0);
            uploadLoopStatus = 2;
            object = objectName;
            //アップした図面を表示する
            loadImg(objectName);
            document.getElementById('previewImageName').value=objectName;
        }
    });
}

function executeRequest(request, apiRequestName) {
    request.execute(function(resp) {
        console.log(resp);
        if (apiRequestName != 'insertObject') {
        } else {
            progressBarController(80);
            insertObjectAccessControls();
        }
    });
}
/**
 * Set required API keys and check authentication status.
 */
function handleClientLoad() {
    gapi.client.setApiKey(apiKey);
    window.setTimeout(checkAuth, 1);
}
/**
 * Authorize Google Cloud Storage API.
 */
function checkAuth() {
    gapi.auth.authorize({
        client_id: clientId,
        scope: scopes,
        immediate: true
    }, handleAuthResult);
}
/**
 * Handle authorization.
 */
function handleAuthResult(authResult) {
    var authorizeButton = document.getElementById('authorize-button');
    var authorizeMessage=document.getElementById('authorize-message');
    if (authResult && !authResult.error) {
        authorizeButton.style.visibility = 'hidden';
        authorizeMessage.style.visibility="hidden";
        initializeApi();
        filePicker.onchange = insertObject;
    } else {
        authorizeButton.style.visibility = '';
        authorizeMessage.style.visibility='';
        authorizeButton.onclick = handleAuthClick;
    }
}
/**
 * Handle authorization click event.
 */
function handleAuthClick(event) {
    gapi.auth.authorize({
        client_id: clientId,
        scope: scopes,
        immediate: false
    }, handleAuthResult);
    return false;
}
/**
 * Load Google Cloud Storage API v1beta12.
 */
function initializeApi() {
    gapi.client.load('storage', API_VERSION);
}
/**
 * Driver for sample application.
 */
$(window)
        .bind('load', function() {
//            addSelectionSwitchingListeners();
            handleClientLoad();
        });

</script>
</body>
</html>

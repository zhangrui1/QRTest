<%--
  Created by IntelliJ IDEA.
  User: Lsr
  Date: 10/20/14
  Time: 2:33 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<header class="header">
    <a href="/QRTest/" class="logo">
        <!-- Add the class icon to your logo image or logo icon to add the margining -->
        Image Upload
    </a>
    <!-- Header Navbar: style can be found in header.less -->
    <nav class="navbar navbar-static-top" role="navigation">
    </nav>
</header>
<script type="text/javascript">
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
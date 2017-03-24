package com.qr.mvc.controller;

import com.google.gson.Gson;
import com.google.zxing.*;
import com.google.zxing.client.j2se.BufferedImageLuminanceSource;
import com.google.zxing.common.HybridBinarizer;
import com.qr.mvc.entity.User;
import com.qr.mvc.entity.Valve;
import com.qr.mvc.entity.Image;
import com.qr.mvc.service.ImageQRService;
import com.qr.mvc.service.ValveService;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.FSDirectory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.*;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URL;
import java.net.URLEncoder;
import java.security.KeyStore;
import java.security.PrivateKey;
import java.security.Signature;
import java.util.*;
import java.util.List;

/**
 * Created by Lsr on 11/5/14.
 */
@Controller
@RequestMapping("/imageQR")
public class ImageQRController {

    @Autowired
    ImageQRService imageQRService;

    @Autowired
    ValveService valveService;
    /**
     * 弁IDにより、図面情報を取得
     *
     * @param kikiSysId 弁ID
     *
     * @return String　画面取得
     * */
    @RequestMapping(value = "/{kikiSysId}", method = RequestMethod.POST)
    public String getImageByKikiSysIdForQR(@PathVariable String kikiSysId,
                                      ModelMap modelMap,
                                      HttpSession session,HttpServletRequest request) throws IOException {
        User user=(User)session.getAttribute("user");
        Valve valve=valveService.getValveByKikiSysId(kikiSysId);
        if(user != null){
            //種別により、image取得
            List<Image> imageList=new ArrayList<Image>();
            ArrayList<Image> allKikisysImageList01 =new ArrayList<Image>();
            ArrayList<Image> allKikisysImageList02 =new ArrayList<Image>();
            ArrayList<Image> allKikisysImageList03 =new ArrayList<Image>();
            ArrayList<Image> allKikisysImageList04 =new ArrayList<Image>();
            ArrayList<Image> allKikisysImageList05 =new ArrayList<Image>();
            ArrayList<Image> allKikisysImageList06 =new ArrayList<Image>();
            ArrayList<Image> allKikisysImageList07 =new ArrayList<Image>();
            ArrayList<Image> allKikisysImageList08 =new ArrayList<Image>();

            imageList = imageQRService.getImagesByKikiSysId(kikiSysId);

            allKikisysImageList01=getImageListForType(imageList,Config.ImageTypeValve01);
            allKikisysImageList02=getImageListForType(imageList,Config.ImageTypeValve02);
            allKikisysImageList03=getImageListForType(imageList,Config.ImageTypeValve03);
            allKikisysImageList04=getImageListForType(imageList,Config.ImageTypeValve04);
            allKikisysImageList05=getImageListForType(imageList,Config.ImageTypeValve05);
            allKikisysImageList06=getImageListForType(imageList,Config.ImageTypeValve06);
            allKikisysImageList07=getImageListForType(imageList,Config.ImageTypeGP);
            allKikisysImageList08=getImageListForType(imageList,"");

            //type 図面　list
            session.setAttribute("QRallKikisysImageList01",allKikisysImageList01);
            session.setAttribute("QRallKikisysImageList02",allKikisysImageList02);
            session.setAttribute("QRallKikisysImageList03",allKikisysImageList03);
            session.setAttribute("QRallKikisysImageList04",allKikisysImageList04);
            session.setAttribute("QRallKikisysImageList05",allKikisysImageList05);
            session.setAttribute("QRallKikisysImageList06",allKikisysImageList06);
            session.setAttribute("QRallKikisysImageList07",allKikisysImageList07);
            session.setAttribute("QRallKikisysImageList08",allKikisysImageList08);
            session.setAttribute("QRallKikisysImageList",imageList);//ALL

            Image firstImageValve=new Image();
            String firstImageNum="0";
            String imageListSize="0";
            if(imageList.size()>0){
                firstImageValve=imageList.get(0);
                firstImageNum="1";
                imageListSize=imageList.size()+"";
            }

            modelMap.addAttribute("QRvalve",valve);
            modelMap.addAttribute("QRimageList",imageList);
            session.setAttribute("QRimageListKikisys",imageList);
            session.setAttribute("QRvalve",valve);
            session.setAttribute("QRimageList",imageList);
            session.setAttribute("QRimageListSize",imageListSize);
            session.setAttribute("QRfirstImageNum",firstImageNum);
            session.setAttribute("QRfirstImageValve",firstImageValve);

            return "valve/imageQRTest";
        }else{
            modelMap.addAttribute("message",Config.TUserNull);
            return Config.LoginSession;
        }

    }

    /**
     * 画像をimageテーブルに追加
     *
     * @param object 画像名
     *
     * @return imageid imageテーブル中の該データのID
     * */
    @RequestMapping(value = "/saveImageByImagePathForQR", method = RequestMethod.POST, produces = "html/text;charset=UTF-8")
    @ResponseBody
    public String saveImageByImagePathForQR(@RequestParam("object")String object,@RequestParam("kikiSysId")String kikiSysId,@RequestParam("imageURL")String imageURL,
                                       HttpSession session,
                                       ModelMap modelMap,HttpServletRequest request) throws Exception {
        User user=(User)session.getAttribute("user");
        if(user != null){
            Image image = new Image();

            image.setImagename(object);
//            image.setImagesyu("");
            image.setBikou("");
            image.setKaiteino("");
            image.setPapersize("A4");
            image.setImagekikiSysId(kikiSysId);
            image.setImagePartId("");
            String QRtext ="";
            //qrコード認識
//            String filename = "D:\\tmp\\sample2.png";

            //図面Pathを取得
            String path=getImagePath(object,"icsmaster");
            URL url = new URL(path);
            System.out.println("url="+url);
            try{
                //. 画像読み込み
                BufferedImage imageQR1 = ImageIO.read(url);
                int totalheight =imageQR1.getHeight();
                int totalwidth =imageQR1.getWidth();
                //図面の右下1/8エリアを取得
                BufferedImage imageQR = imageQR1.getSubimage(3*totalwidth/4, 3*totalheight/4, totalwidth/4, totalheight/4);
                //image保存
//                Graphics g = imageQR.getGraphics();
//                g.drawImage(imageQR, 0, 0, null);
//                ImageIO.write(imageQR,"jpg",new File("D:\\tmp\\gray11.jpg"));



                LuminanceSource source = new BufferedImageLuminanceSource( imageQR );
                BinaryBitmap bitmap = new BinaryBitmap( new HybridBinarizer( source ) );
                Hashtable<DecodeHintType, Object> hints = new Hashtable<DecodeHintType, Object>();
                hints.put(DecodeHintType.CHARACTER_SET, "UTF-8");

                //. デコード
                Reader reader = new MultiFormatReader();
//                Result result = reader.decode( bitmap );
                //. バーコードフォーマット
//                BarcodeFormat format = result.getBarcodeFormat();


                Result result = reader.decode(bitmap,hints);


                //. バーコードコンテンツ（読み取り結果）
                QRtext = result.getText();
                System.out.println("QR コード1= "+QRtext);

                //図面の左下1/8エリアを取得
                if(QRtext==""){
                    imageQR = imageQR1.getSubimage(0, 3*totalheight/4, totalwidth/4, totalheight/4);
                    source = new BufferedImageLuminanceSource( imageQR );
                    bitmap = new BinaryBitmap( new HybridBinarizer( source ) );
                    hints.put(DecodeHintType.CHARACTER_SET, "UTF-8");
                    result = reader.decode(bitmap,hints);
                    //. バーコードコンテンツ（読み取り結果）
                    QRtext = result.getText();
                    System.out.println("QR コード2= "+QRtext);
                }

                System.out.println("QR コード end= "+QRtext);
                //日本語に変更
                QRtext=ImageSyuMap.get(QRtext);
                if(QRtext==null){
                    QRtext="";
                }

            }catch( Exception e ){
                e.printStackTrace();
            }
            //図面種別設定
            image.setImagesyu(QRtext);
            System.out.println("QR コード= "+QRtext);
            String imageid = imageQRService.addImageByImage(image);


            return imageid;
        }else{
            modelMap.addAttribute("message",Config.TUserNull);
            return Config.LoginSession;
        }

    }
    /**
     * 画像を削除
     *
     * @param object 画像名
     *
     * @return object 画像名
     * */
    @RequestMapping(value = "/deleteByImagenameAndKikiSysId", method = RequestMethod.POST, produces = "html/text;charset=UTF-8")
    @ResponseBody
    public String deleteByImagenameAndKikiSysId(@RequestParam("object")String object,@RequestParam("kikiSysId")String kikiSysId,@RequestParam("imageId")String imageId,HttpSession session, ModelMap modelMap,HttpServletRequest request) throws IOException {
        //履歴　記録する
        User user=(User)session.getAttribute("user");
        if(user != null){
            //DBから削除
            Image image=new Image();
            image=imageQRService.getImageByImageId(Integer.parseInt(imageId));

            imageQRService.deleteImageByImagenameAndKikiSysId(image);
            //page番号修正
            //image.getPage より大きいページ⇒小さいページに修正
            List<Image> allImageList = (List<Image>) session.getAttribute("QRimageListKikisys");
            //sessionにデータがない場合、DBから取得する
            if(allImageList==null){
                allImageList = imageQRService.getImagesByKikiSysId(kikiSysId);
            }
            for (int i = image.getPage(); i < allImageList.size(); i++) {
                int tmp=allImageList.get(i).getPage();
                allImageList.get(i).setPage(tmp-1);
                imageQRService.updatePageByImagename(allImageList.get(i));
            }

            allImageList = imageQRService.getImagesByKikiSysId(kikiSysId);
            session.setAttribute("QRimageList",allImageList);
            session.setAttribute("QRimageListKikisys",allImageList);
            return object;

        }else{
            modelMap.addAttribute("message",Config.TUserNull);
            return Config.LoginSession;
        }

    }
    /**
     * 画像種別を更新 Kiki
     *
     * @param imagesyu 更新後の画像種別
     * @param object 画像名
     *
     * @return "" 空文字
     * */
    @RequestMapping(value = "/updateSyuByImagenameForQR", method = RequestMethod.POST, produces = "html/text;charset=UTF-8")
    @ResponseBody
    public String updateSyuByImagenameForQR(@RequestParam("imagesyu")String imagesyu,
                                       @RequestParam("object")String object,@RequestParam("kikiSysId")String kikiSysId,@RequestParam("imageId")String imageId,HttpSession session, ModelMap modelMap,HttpServletRequest request) throws IOException {
        //履歴　記録する
        User user=(User)session.getAttribute("user");
        if(user != null){
            //image
            Image image=new Image();
            image.setId(Integer.parseInt(imageId));
            image.setImagename(object);
            image.setImagesyu(imagesyu);
            image.setImagekikiSysId(kikiSysId);
            imageQRService.updateSyuByImagenameForQR(image);




            //session update
            List<Image> imageList=(ArrayList<Image>)session.getAttribute("QRimageList");
            if(imageList==null){
                imageList = imageQRService.getImagesByKikiSysId(kikiSysId);
            }else{
                for(int i=0;i<imageList.size();i++){
                    if(object.equals(imageList.get(i).getImagename())){
                        imageList.get(i).setImagesyu(imagesyu);
                    }
                }
            }
            //session 各type更新
            List<Image> imageListKikisys =(ArrayList<Image>)session.getAttribute("QRimageListKikisys");
            if(imageListKikisys==null){
            }else{
                for(int i=0;i<imageListKikisys.size();i++){
                    if(object.equals(imageListKikisys.get(i).getImagename())){
                        imageListKikisys.get(i).setImagesyu(imagesyu);
                    }
                }
            }

            session.setAttribute("QRimageList",imageList);
            session.setAttribute("QRimageListKikisys",imageListKikisys);


            return "true";

        }else{
            modelMap.addAttribute("message",Config.TUserNull);
            return Config.LoginSession;
        }


    }
    /**
     * 画像備考データをimageテーブルに更新
     *
     * @param bikou 画像の備考
     * @param object 画像名
     *
     * @return "" 空文字
     * */
    @RequestMapping(value = "/updateBikouByImagename", method = RequestMethod.POST, produces = "html/text;charset=UTF-8")
    @ResponseBody
    public String submitBikouById(@RequestParam("bikou")String bikou,
                                  @RequestParam("object")String object,@RequestParam("kikiSysId")String kikiSysId,@RequestParam("imageId")String imageId,HttpSession session, ModelMap modelMap,HttpServletRequest request){


        //履歴　記録する
        User user=(User)session.getAttribute("user");
        if(user != null){
            Image image=new Image();
            image.setId(Integer.parseInt(imageId));
            image.setImagename(object);
            image.setBikou(bikou);
            image.setImagekikiSysId(kikiSysId);
            imageQRService.updateBikouByObject(image);



            //session update
            List<Image> imageList=(ArrayList<Image>)session.getAttribute("QRimageList");
            if(CollectionUtils.isEmpty(imageList)){
                imageList = imageQRService.getImagesByKikiSysId(kikiSysId);
            }else{
                for(int i=0;i<imageList.size();i++){
                    if(object.equals(imageList.get(i).getImagename())){
                        imageList.get(i).setBikou(bikou);
                    }
                }
            }
            //session 各type更新
            List<Image> imageListKikisys =(ArrayList<Image>)session.getAttribute("QRimageListKikisys");
            if(CollectionUtils.isEmpty(imageListKikisys)){
            }else{
                for(int i=0;i<imageListKikisys.size();i++){
                    if(object.equals(imageListKikisys.get(i).getImagename())){
                        imageListKikisys.get(i).setBikou(bikou);
                    }
                }
            }

            session.setAttribute("QRimageList",imageList);
            session.setAttribute("QRimageListKikisys",imageListKikisys);


            return "true";
        }else{
            modelMap.addAttribute("message",Config.TUserNull);
            return Config.LoginSession;
        }
    }

    /**
     * 画像種別データをsession に設定 kiki
     *@param type  図面種別番号
     * @return String
     * */
    @RequestMapping(value = "/setImagesyuSession", method = RequestMethod.POST, produces = "html/text;charset=UTF-8")
    @ResponseBody
    public String setImagesyuSession(@RequestParam("type")String type,
                                     HttpSession session,ModelMap modelMap,HttpServletRequest request){
        User user=(User)session.getAttribute("user");
        Gson gson = new Gson();
        if(user != null){
            //get all image
            List<Image> imageList=(ArrayList<Image>)session.getAttribute("QRimageList");
            List<Image> imageListKikisys =new ArrayList<Image>();

            if("1".equals(type)||type.equals(Config.ImageTypeValve01)){
                imageListKikisys=getImageListForType(imageList,Config.ImageTypeValve01);
                session.setAttribute("QRallKikisysImageList01",imageListKikisys);
            }else if("2".equals(type)||type.equals(Config.ImageTypeValve02)){
                imageListKikisys=getImageListForType(imageList,Config.ImageTypeValve02);
                session.setAttribute("QRallKikisysImageList02",imageListKikisys);
            }else if("3".equals(type)||type.equals(Config.ImageTypeValve03)){
                imageListKikisys=getImageListForType(imageList,Config.ImageTypeValve03);
                session.setAttribute("QRallKikisysImageList03",imageListKikisys);
            }else if("4".equals(type)||type.equals(Config.ImageTypeValve04)){
                imageListKikisys=getImageListForType(imageList,Config.ImageTypeValve04);
                session.setAttribute("QRallKikisysImageList04",imageListKikisys);
            }else if("5".equals(type)||type.equals(Config.ImageTypeValve05)){
                imageListKikisys=getImageListForType(imageList,Config.ImageTypeValve05);
                session.setAttribute("QRallKikisysImageList05",imageListKikisys);
            }else if("6".equals(type)||type.equals(Config.ImageTypeValve06)){
                imageListKikisys=getImageListForType(imageList,Config.ImageTypeValve06);
                session.setAttribute("QRallKikisysImageList06",imageListKikisys);
            }else if("7".equals(type)||type.equals(Config.ImageTypeGP)){
                imageListKikisys=getImageListForType(imageList,Config.ImageTypeGP);
                session.setAttribute("QRallKikisysImageList07",imageListKikisys);
            }else if("8".equals(type)||type.equals("")){
                imageListKikisys=getImageListForType(imageList,"");
                session.setAttribute("QRallKikisysImageList08",imageListKikisys);
            }else {//全部画像
                imageListKikisys = imageList;
            }

            session.setAttribute("QRimageListKikisys",imageListKikisys);
            session.setAttribute("QRimageListSize",imageListKikisys.size());
            return gson.toJson(imageListKikisys);
        }else{
            modelMap.addAttribute("message",Config.TUserNull);
            return Config.LoginSession;
        }


    }
    /**
     * 画像種別を更新する
     *
     *
     * @return String
     * */
    @RequestMapping(value = "/changeValveImagePage", method = RequestMethod.POST, produces = "html/text;charset=UTF-8")
    @ResponseBody
    public String changeValveImagePage(@RequestParam("kikiSysId")String kikiSysId,@RequestParam("imagename")String imagename,@RequestParam("pageNew")String pageNew,@RequestParam("pageOld")String pageOld,
                                       HttpSession session,ModelMap modelMap,HttpServletRequest request){
        User user=(User)session.getAttribute("user");
        if(user != null){
            Image reportImage=new Image();
            List<Image> allImageList = (List<Image>) session.getAttribute("QRimageListKikisys");
            //sessionにデータがない場合、DBから取得する
            if(allImageList==null){
                allImageList = imageQRService.getImagesByKikiSysId(kikiSysId);
            }
            //DBからもデータがない場合、処理しないです
            if(allImageList==null){
                return "nodate";
            }else{
                reportImage = allImageList.get(Integer.valueOf(pageOld)-1);
                //index数字からpageを取得
                int newPageNum=allImageList.get(Integer.valueOf(pageNew)-1).getPage();
                int oldPageNum=allImageList.get(Integer.valueOf(pageOld)-1).getPage();
                //imagename により、update page　pageNew and pageOld　間のimageは対象です。
                if(newPageNum>oldPageNum){
                    //小さいページ⇒大きいページに修正
                    for (int i = 0; i < allImageList.size(); i++) {
                        Integer tmpPage=allImageList.get(i).getPage();
                        if(tmpPage<=newPageNum && tmpPage>oldPageNum){
                            allImageList.get(i).setPage(tmpPage-1);
                            //対象imageの後のpage 修正
                            Image ImageTmp =allImageList.get(i);
                            ImageTmp.setPage(tmpPage-1);
                            imageQRService.updatePageByImagename(ImageTmp);
                        }
                    }
                }else{
                    //大きいページ⇒小さいページに修正
                    for (int i = 0; i < allImageList.size(); i++) {
                        Integer tmpPage=allImageList.get(i).getPage();
                        if(tmpPage>=newPageNum && tmpPage<oldPageNum){
                            allImageList.get(i).setPage(tmpPage+1);
                            //対象imageの後のpage 修正
                            Image reportImageTmp =allImageList.get(i);
                            reportImageTmp.setPage(tmpPage+1);
                            imageQRService.updatePageByImagename(reportImageTmp);
                        }
                    }
                }

                //対象データ修正
                reportImage.setPage(newPageNum);
                imageQRService.updatePageByImagename(reportImage);

                //imagename により、update page　
                allImageList = imageQRService.getImagesByKikiSysId(kikiSysId);
                session.setAttribute("QRimageListKikisys",allImageList);
                return "ok";
            }

        }else{
            modelMap.addAttribute("message",Config.TUserNull);
            return "login";
        }


    }
    /**
     * ページ遷移時の画像リストを取る
     *
     * @param setNum セットナンバー
     *
     * @return String 画像List
     * */
    @RequestMapping(value = "/getimageForChangePage", method = RequestMethod.POST, produces = "html/text;charset=UTF-8")
    @ResponseBody
    public String getimageForChangePage(@RequestParam("setNum")String setNum,
                                        HttpSession session,ModelMap modelMap){
        List<Image> imageListKikisys = (List<Image>) session.getAttribute("QRimageListKikisys");//valve
        User user=(User)session.getAttribute("user");
        Gson gson = new Gson();
        if(user!=null){
            return gson.toJson(imageListKikisys.get(Integer.valueOf(setNum)));
        }else{
            modelMap.addAttribute("message",Config.TUserNull);
            return Config.LoginSession;
        }

    }
    /**
     * 画像種別により、図面リストを取得
     * @param type  図面種別番号
     * @return List
     * */
    public ArrayList<Image>  getImageListForType(List<Image> src,String type){
        ArrayList<Image> tmp =new ArrayList<Image>();
        if(!CollectionUtils.isEmpty(src)){
            for(int i=0;i<src.size();i++){
                if(type.equals(src.get(i).getImagesyu())){
                    tmp.add(src.get(i));
                }
            }
        }
        return  tmp;
    }


    //Image Pathを取得する
    final String SERVICE_ACCOUNT_EMAIL = "13771198627-1rlqtf8o7v4531gp3fo65kd5k5h7f3eo@developer.gserviceaccount.com";
    final String SERVICE_ACCOUNT_PKCS12_FILE_PATH = "power-science-20140719001-7025cff7beb0.p12";
    PrivateKey key;
    public String getImagePath(String OBJECT_NAME,String BUCKET_NAME) throws Exception {
        long expiration = System.currentTimeMillis()/1000 + 600;
        key = loadKeyFromPkcs12(SERVICE_ACCOUNT_PKCS12_FILE_PATH, "notasecret".toCharArray());
        System.out.println("======= GET File =========");
        String get_url = this.getSigningURL("GET",OBJECT_NAME,expiration,BUCKET_NAME);
        return get_url;
    }

    private String getSigningURL(String verb,String OBJECT_NAME,long expiration,String BUCKET_NAME) throws Exception {
        String url_signature = this.signString(verb + "\n\n\n" + expiration + "\n" + "/" + BUCKET_NAME + "/" + OBJECT_NAME  );
        String signed_url = "http://storage.googleapis.com/" + BUCKET_NAME + "/" + OBJECT_NAME +
                "?GoogleAccessId=" + SERVICE_ACCOUNT_EMAIL +
                "&Expires=" + expiration +
                "&Signature=" + URLEncoder.encode(url_signature, "UTF-8");
        return signed_url;
    }

    private static PrivateKey loadKeyFromPkcs12(String filename, char[] password) throws Exception {
        FileInputStream fis = new FileInputStream(filename);
        KeyStore ks = KeyStore.getInstance("PKCS12");
        ks.load(fis, password);
        return (PrivateKey) ks.getKey("privatekey", password);
    }

    private String signString(String stringToSign) throws Exception {
        if (key == null)
            throw new Exception("Private Key not initalized");
        Signature signer = Signature.getInstance("SHA256withRSA");
        signer.initSign(key);
        signer.update(stringToSign.getBytes("UTF-8"));
        byte[] rawSignature = signer.sign();
        return new String(com.google.api.client.repackaged.org.apache.commons.codec.binary.Base64.encodeBase64(rawSignature, false), "UTF-8");
    }

    /**画像DL　種別*/
    public static final String ImageTypeGP = "GP装填明細書";
    public static final String ImageTypeValve01="図面仕様書";
    public static final String ImageTypeValve02="点検報告書";
    public static final String ImageTypeValve03="懸案事項一覧";
    public static final String ImageTypeValve04="完成図面";
    public static final String ImageTypeValve05="作業指示書";
    public static final String ImageTypeValve06="弁棒ねじ検索記録";

    //図面種別
    public static final Map<String, String> ImageSyuMap =
            new HashMap<String, String>() {{
                put("TV-IS-001", ImageTypeValve01);
                put("TV-IS-002", ImageTypeValve01);
                put("TV-IS-003", ImageTypeValve01);
                put("TV-IS-004", ImageTypeValve01);
                put("TV-IS-005", ImageTypeValve01);
                put("TV-IS-006", ImageTypeValve01);

                put("TV-IR-007", ImageTypeValve02);
                put("TV-IR-008", ImageTypeValve02);
                put("TV-IR-009", ImageTypeValve02);
                put("TV-IR-010", ImageTypeValve02);
                put("TV-IR-011", ImageTypeValve02);
                put("TV-IR-012", ImageTypeValve02);

                put("TV-PP-013", ImageTypeValve03);
                put("TV-PP-014", ImageTypeValve03);
                put("TV-PP-015", ImageTypeValve03);
                put("TV-PP-016", ImageTypeValve03);
                put("TV-PP-017", ImageTypeValve03);
                put("TV-PP-018", ImageTypeValve03);
                put("TV-PP-019", ImageTypeValve03);

                put("TV-CI-020", ImageTypeValve04);
                put("TV-CI-021", ImageTypeValve04);
                put("TV-CI-022", ImageTypeValve04);
                put("TV-CI-023", ImageTypeValve04);
                put("TV-CI-024", ImageTypeValve04);
                put("TV-CI-025", ImageTypeValve04);
                put("TV-CI-026", ImageTypeValve04);

                put("TV-WI-027", ImageTypeValve05);
                put("TV-WI-028", ImageTypeValve05);
                put("TV-WI-029", ImageTypeValve05);
                put("TV-WI-030", ImageTypeValve05);

                put("", "");
            }};


}

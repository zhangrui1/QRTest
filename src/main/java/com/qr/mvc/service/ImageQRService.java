package com.qr.mvc.service;

import com.qr.mvc.dao.ImageQRMapper;
import com.qr.mvc.entity.Image;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by Lsr on 11/5/14.
 */

@Service
public class ImageQRService {

    @Resource
    ImageQRMapper imageQRMapper;

    public List<Image> imageList = new ArrayList<Image>();

    public Image getImageByImageId(Integer imageId){
        Image image=new Image();
        image=imageQRMapper.findImageByImageId(imageId);
        return  image;
    }
    /**imageテーブルにInsert*/
    public String addImageByImage(Image image){

        //kikisysIdにより、弁図面の件数を取得する
        List<Image> allImageList = getImagesByKikiSysId(image.getImagekikiSysId());
        if(allImageList==null){
            image.setPage(1);
        }else{
            image.setPage(allImageList.size()+1);
        }

        //append Date
        Date date = new Date();
        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        image.setTrkDate(sdf1.format(date));
        image.setUpdDate(sdf1.format(date));

        imageQRMapper.addImageByImage(image);
        int id = imageQRMapper.findIdByObject(image.getImagename());

        return ""+id;
    }

    /**画像名により、画像種別を更新*/
    public void updateSyuByImagename(Image image) {
        //append Date
        Date date = new Date();
        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        image.setUpdDate(sdf1.format(date));
        imageQRMapper.updateSyuByImagename(image);

    }

    /**画像名により、画像Pageを更新*/
    public void updatePageByImagename(Image image) {
        //append Date
        Date date = new Date();
        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        image.setUpdDate(sdf1.format(date));

        imageQRMapper.updatePageByImagename(image);

    }

    /**画像名により、画像データを削除*/
    public void deleteImageByImagenameAndKikiSysId(Image image) {
        imageQRMapper.deleteImageByImagenameAndKikiSysId(image);
    }

    /**弁IDにより、画像リストを取得*/
    public List<Image> getImagesByKikiSysId(String kikiSysID) {

        return imageQRMapper.findImagesByKikiSysId(kikiSysID);
    }

    /**弁IDにより、画像リストを取得*/
    public List<Image> getImagesByKikiSysIdForQR(String kikiSysID) {

        return imageQRMapper.findImagesByKikiSysIdForQR(kikiSysID);
    }
    /**画像名により、画像種別を更新*/
    public void updateSyuByImagenameForQR(Image image) {
        //append Date
        Date date = new Date();
        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        image.setUpdDate(sdf1.format(date));
        imageQRMapper.updateSyuByImagenameForQR(image);

    }

    /**弁IDにより、画像タイプは　GP の画像リストを取得*/
    public List<Image> getGPImagesByKikisysId(String kikiSysID) {
        Image image=new Image();
        image.setImagesyu("GP装填明細書");
        image.setImagekikiSysId(kikiSysID);

        //append Date
        Date date = new Date();
        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        image.setUpdDate(sdf1.format(date));

        return imageQRMapper.findGPImagesByImage(image);
    }


    public void updateBikouByObject(Image image) {
        //append Date
        Date date = new Date();
        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        image.setUpdDate(sdf1.format(date));

        imageQRMapper.updateBikouByObject(image);
    }
}

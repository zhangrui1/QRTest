package com.qr.mvc.dao;


import com.qr.mvc.entity.Image;

import java.util.List;

/**
 * Created by Lsr on 11/5/14.
 */
public interface ImageQRMapper {

    /**画像名により、image　IDを取得*/
    int findIdByObject(String object);

    /**画像名により、image　IDを取得*/
    Image findImageByImageId(Integer imageId);

    /**imageテーブルにInsert*/
    void addImageByImage(Image image);

    /**画像名により、画像種別を更新*/
    void updateSyuByImagename(Image image);

    /**画像名により、画像Pageを更新*/
    void updatePageByImagename(Image image);

    /**画像名により、備考情報を更新*/
    void updateBikouByObject(Image image);

    /**画像名により、画像データを削除*/
    void deleteImageByImagenameAndKikiSysId(Image image);

    /**弁IDにより、画像リストを取得*/
    List<Image> findImagesByKikiSysId(String kikiSysID);

    /**弁IDにより、画像リストを取得*/
    List<Image> findImagesByKikiSysIdForQR(String kikiSysID);

    /**画像名により、画像種別を更新*/
    void updateSyuByImagenameForQR(Image image);

    /**弁IDにより、画像リストを取得*/
    List<Image> findGPImagesByImage(Image image);
}

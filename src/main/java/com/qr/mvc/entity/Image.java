package com.qr.mvc.entity;

/**
 * Created by Lsr on 11/5/14.
 * 画像エンティティ
 */
public class Image {

    public int id;
    public String imagekikiSysId;
    public String imagePartId;
    public String imagesyu;
    public int page;
    public String kaiteino;
    public String imagename;
    public String papersize;
    public String trkDate;
    public String updDate;
    public String bikou;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getImagekikiSysId() {
        return imagekikiSysId;
    }

    public void setImagekikiSysId(String imagekikiSysId) {
        this.imagekikiSysId = imagekikiSysId;
    }

    public String getImagePartId() {
        return imagePartId;
    }

    public void setImagePartId(String imagePartId) {
        this.imagePartId = imagePartId;
    }

    public String getImagesyu() {
        return imagesyu;
    }

    public void setImagesyu(String imagesyu) {
        this.imagesyu = imagesyu;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public String getKaiteino() {
        return kaiteino;
    }

    public void setKaiteino(String kaiteino) {
        this.kaiteino = kaiteino;
    }

    public String getImagename() {
        return imagename;
    }

    public void setImagename(String imagename) {
        this.imagename = imagename;
    }

    public String getPapersize() {
        return papersize;
    }

    public void setPapersize(String papersize) {
        this.papersize = papersize;
    }

    public String getTrkDate() {
        return trkDate;
    }

    public void setTrkDate(String trkDate) {
        this.trkDate = trkDate;
    }

    public String getUpdDate() {
        return updDate;
    }

    public void setUpdDate(String updDate) {
        this.updDate = updDate;
    }

    public String getBikou() {
        return bikou;
    }

    public void setBikou(String bikou) {
        this.bikou = bikou;
    }
}

package com.qr.mvc.entity;

/**
 * Created by Lsr on 2/2/15.
 */
public class ReportimageKikiSystem {
    public int id;
    public int koujiId;
    public String imagename;
    public int kikiSysId;
    public int kikiSysPage;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getKoujiId() {
        return koujiId;
    }

    public void setKoujiId(int koujiId) {
        this.koujiId = koujiId;
    }

    public String getImagename() {
        return imagename;
    }

    public void setImagename(String imagename) {
        this.imagename = imagename;
    }

    public int getKikiSysId() {
        return kikiSysId;
    }

    public void setKikiSysId(int kikiSysId) {
        this.kikiSysId = kikiSysId;
    }

    public int getKikiSysPage() {
        return kikiSysPage;
    }

    public void setKikiSysPage(int kikiSysPage) {
        this.kikiSysPage = kikiSysPage;
    }
}

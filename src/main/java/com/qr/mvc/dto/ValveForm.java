package com.qr.mvc.dto;


/**
 * Created by Lsr on 10/14/14.
 * 弁新規登録/編集用
 */
public class ValveForm {
    public int kikiSysId;
    public String locationName;
    public String vNo;
    public String benMeisyo;

    public int getKikiSysId() {
        return kikiSysId;
    }

    public void setKikiSysId(int kikiSysId) {
        this.kikiSysId = kikiSysId;
    }

    public String getLocationName() {
        return locationName;
    }

    public void setLocationName(String locationName) {
        this.locationName = locationName;
    }

    public String getvNo() {
        return vNo;
    }

    public void setvNo(String vNo) {
        this.vNo = vNo;
    }

    public String getBenMeisyo() {
        return benMeisyo;
    }

    public void setBenMeisyo(String benMeisyo) {
        this.benMeisyo = benMeisyo;
    }


}

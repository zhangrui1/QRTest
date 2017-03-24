package com.qr.mvc.entity;

/**
 * Created by zhangrui on 14/11/14.
 * 工事エンティティ
 */
public class Kouji {

    public int id;
    public String kjNo;
    public String kjMeisyo;
    public String kjKbn;
    public String location;
    public String delFlgkouji;


    public int getId(){return  id;}

    public void setId(int id){this.id=id;}

    public String getKjNo(){return  kjNo;}

    public void setKjNo(String kjNo){this.kjNo=kjNo;}

    public String getKjMeisyo(){return  kjMeisyo;}

    public void setKjMeisyo(String kjMeisyo){this.kjMeisyo=kjMeisyo;}

    public String getKjKbn(){return  kjKbn;}

    public void setKjKbn(String kjkbn){this.kjKbn=kjkbn;}

    public String getLocation(){return location;}

    public void setLocation(String location){this.location=location;}

    public String getDelFlgkouji(){return delFlgkouji;}

    public void setDelFlgkouji(String delFlgkouji){this.delFlgkouji=delFlgkouji;}

}

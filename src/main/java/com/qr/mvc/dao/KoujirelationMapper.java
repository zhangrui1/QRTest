package com.qr.mvc.dao;

import com.qr.mvc.entity.Koujirelation;
import com.qr.mvc.entity.Valve;

import java.util.List;

/**
 * Created by zhangrui on 14/11/14.
 */
public interface KoujirelationMapper {


    /**IDから工事、弁、機器の関連データを取得*/
    public List<Koujirelation> findAllKoujirelationByKoujiid(String id);

    /**koujiidから関連の弁IDリストを取得*/
    public List<Valve> findKikisysListByKoujiid(String koujiid);


}

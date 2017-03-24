package com.qr.mvc.dao;

import com.qr.mvc.entity.Kouji;
import com.qr.mvc.entity.Valve;

import java.util.List;

/**
 * Created by zhangrui on 14/11/14.
 */
public interface KoujiMapper {

    /**該ユーザが担当している工事リストを取得*/
    public Kouji findKoujiById(String id);

    /**locationにより　工事を取得　状態と開始日付でソート*/
    public List<Kouji> findKoujiByLocation(String location);

    /**工事IDにより、弁リストを取得*/
    public List<Valve> findKikisysByKoujiId(String koujiid);

}

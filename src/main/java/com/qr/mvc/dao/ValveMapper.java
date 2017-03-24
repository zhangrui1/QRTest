package com.qr.mvc.dao;


import com.qr.mvc.entity.Valve;

import java.util.List;

/**
 * Created by Lsr on 10/14/14.
 */
public interface ValveMapper {
    /**全部の弁を取得*/
    public List<Valve> findAllValve();

    /**弁場所により、弁リストを取得*/
    public List<Valve> findByLocationName(String locationName);

    /**弁IDにより、弁を取得*/
    public Valve findValveByKikiSysId(int kikiSysId);

}

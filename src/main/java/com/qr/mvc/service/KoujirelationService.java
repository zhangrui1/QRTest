package com.qr.mvc.service;

import com.qr.mvc.dao.KoujirelationMapper;
import com.qr.mvc.entity.Koujirelation;
import com.qr.mvc.entity.Valve;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by zhangrui on 14/11/14.
 */
@Service
public class KoujirelationService {

    @Resource
    KoujirelationMapper koujirelationMapper;

    /**KoujiIDにより　工事関係表データを所得する*/
    public List<Koujirelation> getAllKoujirelationByKoujiid(String koujiId){
        List<Koujirelation> koujirelations=koujirelationMapper.findAllKoujirelationByKoujiid(koujiId);
        return koujirelations;
    }

    /**KoujiIDにより、関連弁リストを所得する*/
    public List<Valve> getKikisysListByKoujiid(String koujiId){
        List<Valve> valveList=koujirelationMapper.findKikisysListByKoujiid(koujiId);
        return valveList;
    }


}

package com.qr.mvc.service;

import com.qr.mvc.dao.ValveMapper;
import com.qr.mvc.entity.Valve;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by Lsr on 10/14/14.
 */

@Service
public class ValveService {

    @Resource
    ValveMapper valveMapper;

    /**全部の弁を取得*/
    public List<Valve> getAllValves() {
        List<Valve> valveList = valveMapper.findAllValve();
        return valveList;
    }

    /**弁IDにより、弁を取得*/
    public Valve getValveByKikiSysId(String kikiSysId) {
        return valveMapper.findValveByKikiSysId(Integer.valueOf(kikiSysId));
    }
}

package com.qr.mvc.service;

import com.qr.mvc.dao.KoujiMapper;
import com.qr.mvc.entity.Kouji;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by zhangrui on 14/11/14.
 */
@Service
public class KoujiService {

    @Resource
    KoujiMapper koujiMapper;
    /**工事IDから工事情報を取得*/
    public Kouji getKoujiById(String id){

        Kouji kouji=koujiMapper.findKoujiById(id);
        return  kouji;
    }


}

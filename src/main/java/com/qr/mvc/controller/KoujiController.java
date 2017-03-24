package com.qr.mvc.controller;

import com.google.gson.Gson;
import com.qr.mvc.dao.KoujiMapper;
import com.qr.mvc.entity.*;
import com.qr.mvc.service.ImageQRService;
import com.qr.mvc.service.KoujiService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.*;

/**
 * Created by Lsr on 11/14/14.
 */

@Controller
@RequestMapping("/kouji")
public class KoujiController {

    @Autowired
    KoujiService koujiService;


    @Autowired
    ImageQRService imageQRService;

    @Resource
    KoujiMapper koujiMapper;


    @RequestMapping(method = RequestMethod.GET)
    public String index(HttpSession session){

        return "/kouji/index";
    }

    /**
     * 工事IDにより、工事及び点検機器リストを取得
     * @param id 工事ID
     *
     * @return String 点検機器リストパス
     *
     * */
    @RequestMapping(value = "/{id}", method = RequestMethod.GET)
    public String getKoujiById(@PathVariable("id")String id, ModelMap modelMap,HttpSession session,HttpServletRequest request) throws IOException {
        //session　check
        User user=(User)session.getAttribute("user");
        //kouji
        Kouji kouji=new Kouji();
        List<Valve> valveList=new ArrayList<Valve>();
        if(user != null){
            kouji=koujiService.getKoujiById(id);

        }else{
            modelMap.addAttribute("message",Config.TUserNull);
            return Config.LoginSession;
        }

        // 弁番号で valveList 昇順ソート
        Collections.sort(valveList,
                new Comparator<Valve>() {
                    @Override
                    public int compare(Valve entry1,
                                       Valve entry2) {
                        return ( entry1.getvNo())
                                .compareTo(entry2.getvNo());
                    }
                });

        modelMap.addAttribute("valveList",valveList);
        modelMap.addAttribute("valveSize",valveList.size());
        session.setAttribute("valveList",valveList);
        //make cache
        session.setAttribute("kouji", kouji);
        modelMap.addAttribute("kouji", kouji);


        return "/kouji/index";
    }


    /**
     * 会社名により、工事を取得
     *
     * @param location 会社名
     *
     * @return String　工事リスト
     * */
    @RequestMapping(value = "/getKoujiByLocation", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public  String getKoujiByLocation(@RequestParam("location")String location,ModelMap modelMap,HttpSession session){
        //session　check
        User user=(User)session.getAttribute("user");
        if(user == null){
            modelMap.addAttribute("message",Config.TUserNull);
            return Config.LoginSession;
        }

        Gson gson=new Gson();

        List<Kouji> koujiresult=new ArrayList<Kouji>();
        //location文字列のスペースを削除
        location=location.trim();
        koujiresult=koujiMapper.findKoujiByLocation(location);

        //location情報を保存
        modelMap.addAttribute("locationNameSelectedForKouji",location);
        modelMap.addAttribute("locationKoujiSelectedForKouji",koujiresult);
        session.setAttribute("locationNameSelectedForKouji",location);
        session.setAttribute("locationKoujiSelectedForKouji",koujiresult);
        return  gson.toJson(koujiresult);
    }

    /**
     * 工事IDにより、弁リストを取得
     *
     * @param koujiId 工事ID
     *
     * @return String　工事リスト
     * */
    @RequestMapping(value = "/getValvesByKoujiId", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    @ResponseBody
    public  String getValvesByKoujiId(@RequestParam("koujiId")String koujiId,ModelMap modelMap,HttpSession session){
        //session　check
        User user=(User)session.getAttribute("user");
        if(user == null){
            modelMap.addAttribute("message",Config.TUserNull);
            return Config.LoginSession;
        }

        Gson gson=new Gson();

        List<Valve> valveList=new ArrayList<Valve>();
        valveList=koujiMapper.findKikisysByKoujiId(koujiId);

        return  gson.toJson(valveList);
    }
}

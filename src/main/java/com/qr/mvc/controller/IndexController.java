package com.qr.mvc.controller;

import com.qr.mvc.controller.utilities.StringUtil;
import com.qr.mvc.entity.Kouji;
import com.qr.mvc.entity.Location;
import com.qr.mvc.entity.User;
import com.qr.mvc.service.LocationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 * Created by Lsr on 10/10/14.
 */

@Controller
@RequestMapping("/")
public class IndexController {

    @Autowired
    LocationService locationService;

    /**
     * 最新作成,更新された弁情報を取得し、
     * ログイン後のIndex画面情報へ遷移
     *
     * @return String ログイン後画面パス
     * */
    @RequestMapping(method = RequestMethod.GET)
    public String index(HttpSession session,ModelMap modelMap){
        User user = (User)session.getAttribute("user");
        //ユーザはnull場合はlogin画面へ戻る、存在場合はindex画面へ遷移
        if(user == null){
            System.out.println("user is null");
            return  "login";
        }else{
            //get location
            List<Location> locationList = locationService.getAllLocation();
            List<String> nameList = new LinkedList<String>();
            for (int i = 0; i < locationList.size(); i++) {
                String tmpLocation= StringUtil.concatWithDelimit(" ", locationList.get(i).getkCodeL(), locationList.get(i).getkCodeM(), locationList.get(i).getkCodeS());
                if(!nameList.contains(tmpLocation)){
                    nameList.add(tmpLocation);
                }
            }

            List<Kouji> koujiList=new ArrayList<Kouji>();
            session.setAttribute("nameList",nameList);
            session.setAttribute("user",user);

            System.out.println("user ="+user.getUserid());
            return "imageQRTest";
        }
    }

    /**
     * ログアウトし、ログイン画面へ遷移
     * */
    @RequestMapping(value="/logout", method= RequestMethod.GET)
    public String logout(HttpSession session,HttpServletRequest request){
        User user = (User)session.getAttribute("user");
        session.removeAttribute("user");

        return "login";
    }
}

package com.qr.mvc.controller;

import com.qr.mvc.entity.User;
import com.qr.mvc.service.UserService;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.pool.impl.GenericKeyedObjectPool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/login")
public class LoginController {

    @Autowired
    private UserService userService;

    /**
     * ユーザ名とパスワードにより、ログイン
     *
     * @param userid ユーザ名
     * @param password パスワード
     *
     * @return String　ユーザ名とパスワードは正しい場合はIndex画面へ遷移、
     * 　　　　　　　　　間違えた場合は、ログイン画面に戻す
     * */
    @RequestMapping(method = RequestMethod.POST)
    public String login(@RequestParam(value = "userid") String userid,
                        @RequestParam(value = "password") String password,
                        HttpSession session,
                        ModelMap modelMap,HttpServletRequest request){
        //password暗号化 SHA256でハッシュ
        String passwordSHA= DigestUtils.sha256Hex(password);

        User user = userService.getUserByUseridAndPassword(userid,passwordSHA);
        session.setAttribute("imageRoot","http://storage.googleapis.com/valdac/");



        if(user != null){
            modelMap.clear();
            session.setAttribute("user",user);
            modelMap.addAttribute("user",user);
            return "redirect:/";
        } else {
            modelMap.addAttribute("message","ユーザ名またはパスワードは間違えました。");
            return "Logout";
        }


    }

}

package com.qr.mvc.controller;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by zhangrui on 15/01/29.
 * 共有部分を定義する
 */
public class Config {

    /**機器分類　種別*/
    public static final String KikiBunRuiA = "弁本体";
    public static final String KikiBunRuiB = "駆動部";
    public static final String KikiBunRuiC = "補助部";
    public static final String KikiBunRuiD = "付属部";

    /**画像DL　種別*/
    public static final String ImageTypeGP = "GP装填明細書";
    public static final String ImageTypeValve01="図面仕様書";
    public static final String ImageTypeValve02="点検報告書";
    public static final String ImageTypeValve03="懸案事項一覧";
    public static final String ImageTypeValve04="完成図面";
    public static final String ImageTypeValve05="作業指示書";
    public static final String ImageTypeValve06="弁棒ねじ検索記録";

    /**テーブル名*/
    public static final String Tkikisystem="kikisystem";
    public static final String Tkiki = "kiki";
    public static final String Tbuhin = "buhin";
    public static final String Timage = "image";
    public static final String TimageKouji = "Reportimage";
    public static final String Tmaster = "master";
    public static final String TICS = "ics";
    public static final String TLocation = "location";
    public static final String TUser = "user";

    public static final String TNamekikisystem="弁";
    public static final String TNamekiki = "機器";
    public static final String TNamebuhin = "部品";
    public static final String TNameimage = "図面";
    public static final String TNamemaster = "マスタ";
    public static final String TNameICS = "ICS";
    public static final String TNameLocation = "会社名";
    public static final String TNameUser = "ユーザ";

    /**テーブル 操作内容*/
    public static final String TInsert = "新規追加";
    public static final String TEdit = "編集";
    public static final String TDelete = "削除";
    public static final String TKikisysDetail = "弁詳細へ";
    public static final String TKikiDetail = "機器詳細へ";
    public static final String TBuhinDetail = "部品詳細へ";
    public static final String TImageDetail = "弁図面リストへ";
    public static final String TCopy="弁コピー";
    public static final String TLogin="ログイン";
    public static final String TLogout="ログアウト";
    public static final String TSearch="検索";
    public static final String TSearchLeft="左の検索";
    public static final String TUserNull = "サーバーへの接続がタイムアウトしました。 もう一度ログインしてください。";

    public static final String LoginSession="login";

    public static final Map<String, String> TableMap =
            new HashMap<String, String>() {{
                put(TNamekikisystem, Tkikisystem);
                put(TNamekiki, Tkiki);
                put(TNamebuhin, Tbuhin);
                put(TNameimage, Timage);
                put(TNamemaster, Tmaster);
                put(TNameICS, TICS);
                put(TNameLocation, TLocation);
                put(TNameUser, TUser);
            }};

    //guest　IP 取得
    public static String getIpAddr(HttpServletRequest request) {

        String ip = request.getHeader("x-forwarded-for");

        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {

            ip = request.getHeader("Proxy-Client-IP");

        }

        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {

            ip = request.getHeader("WL-Proxy-Client-IP");

        }

        if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {

            ip = request.getRemoteAddr();

        }

        return ip;

    }
}

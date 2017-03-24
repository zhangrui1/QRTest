package com.qr.mvc.service;


import com.qr.mvc.dao.ReportimageKikiSystemMapper;
import com.qr.mvc.entity.ReportimageKikiSystem;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Lsr on 2/2/15.
 */

@Service
public class ReportimageKikiSystemService {

    @Resource
    public ReportimageKikiSystemMapper reportimageKikiSystemMapper;

    public void addReportimageKikisystem(String koujiId,String imagename, List<String> selectIdList){

        List<ReportimageKikiSystem> reportimageKikiSystemList = new ArrayList<ReportimageKikiSystem>();
        for (int i = 0; i < selectIdList.size(); i++) {

            ReportimageKikiSystem reportimageKikiSystem = new ReportimageKikiSystem();
            reportimageKikiSystem.setKikiSysId(Integer.valueOf(selectIdList.get(i)));
            reportimageKikiSystem.setKoujiId(Integer.valueOf(koujiId));
            reportimageKikiSystem.setImagename(imagename);
            reportimageKikiSystemMapper.insertReportimageKikisystem(reportimageKikiSystem);
        }
    }

    public void addReportimageKikisystemByReportimageKikiSystem(ReportimageKikiSystem reportimageKikiSystem){
            reportimageKikiSystemMapper.insertReportimageKikisystem(reportimageKikiSystem);
    }

    public List<ReportimageKikiSystem> makeReportimageKikiSystemListByIdList(String koujiId, String imagename, List<String> selecteIdList){
        List<ReportimageKikiSystem> reportimageKikiSystemList = new ArrayList<ReportimageKikiSystem>();
        for (int i = 0; i < selecteIdList.size(); i++) {
            ReportimageKikiSystem reportimageKikiSystem = new ReportimageKikiSystem();
            reportimageKikiSystem.setKoujiId(Integer.valueOf(koujiId));
            reportimageKikiSystem.setImagename(imagename);
            reportimageKikiSystem.setKikiSysId(Integer.valueOf(selecteIdList.get(i)));
            reportimageKikiSystemList.add(reportimageKikiSystem);
        }

        return reportimageKikiSystemList;
    }

    public List<ReportimageKikiSystem> getListByReportimageKikiSystem(String koujiId, String imagename){
        ReportimageKikiSystem reportimageKikiSystem = new ReportimageKikiSystem();
        reportimageKikiSystem.setImagename(imagename);
        reportimageKikiSystem.setKoujiId(Integer.valueOf(koujiId));
        return reportimageKikiSystemMapper.getListByReportimageKikiSystem(reportimageKikiSystem);
    }

    public List<ReportimageKikiSystem> getKikisysIDListByReportimageKikiSystem(Integer kikisysID){
        ReportimageKikiSystem reportimageKikiSystem = new ReportimageKikiSystem();
        reportimageKikiSystem.setKikiSysId(kikisysID);
       return reportimageKikiSystemMapper.getKikisysIDListByReportimageKikiSystemID(reportimageKikiSystem);
    }

    public List<Integer> getKikisysIDListByReportimageKikiSystem(String koujiId, String imagename){
        ReportimageKikiSystem reportimageKikiSystem = new ReportimageKikiSystem();
        reportimageKikiSystem.setImagename(imagename);
        reportimageKikiSystem.setKoujiId(Integer.valueOf(koujiId));
        return reportimageKikiSystemMapper.getKikisysIDByReportimageKikiSystemID(reportimageKikiSystem);
    }


    public void deleteByKoujiIdAndImagename(String koujiId, String imagename) {
        ReportimageKikiSystem reportimageKikiSystem = new ReportimageKikiSystem();
        reportimageKikiSystem.setImagename(imagename);
        reportimageKikiSystem.setKoujiId(Integer.valueOf(koujiId));
        reportimageKikiSystemMapper.deleteByReportimageKikiSystem(reportimageKikiSystem);
    }

    public List<ReportimageKikiSystem> getListByKoujiId(String id) {
        return reportimageKikiSystemMapper.getListByKoujiId(Integer.valueOf(id));
    }

    public void deleteByKoujiIdAndKikisysId(String id, String s) {
        ReportimageKikiSystem reportimageKikiSystem = new ReportimageKikiSystem();
        reportimageKikiSystem.setKoujiId(Integer.valueOf(id));
        reportimageKikiSystem.setKikiSysId(Integer.valueOf(s));
        reportimageKikiSystemMapper.deleteByKoujiIdAndKikisysId(reportimageKikiSystem);
    }

    public void deleteByImagenameAndKikisysId(String imagename, Integer kikisysId) {
        ReportimageKikiSystem reportimageKikiSystem = new ReportimageKikiSystem();
        reportimageKikiSystem.setImagename(imagename);
        reportimageKikiSystem.setKikiSysId(kikisysId);
        reportimageKikiSystemMapper.deleteByImagenameAndKikisysId(reportimageKikiSystem);
    }

    /**画像名により、画像Pageを更新*/
    public void updateKikiSysPageByReportImage(ReportimageKikiSystem reportimageKikiSystem) {

        reportimageKikiSystemMapper.updatePageByImagename(reportimageKikiSystem);

    }
}

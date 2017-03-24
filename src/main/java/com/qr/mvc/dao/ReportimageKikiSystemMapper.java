package com.qr.mvc.dao;

import com.qr.mvc.entity.ReportimageKikiSystem;

import java.util.List;

/**
 * Created by Lsr on 2/2/15.
 */
public interface ReportimageKikiSystemMapper {

    public void addReportimageKikisystem(List<ReportimageKikiSystem> reportimageKikiSystemList);

    public void insertReportimageKikisystem(ReportimageKikiSystem reportimageKikiSystem);

    public List<ReportimageKikiSystem> getListByReportimageKikiSystem(ReportimageKikiSystem reportimageKikiSystem);

    public List<ReportimageKikiSystem> getKikisysIDListByReportimageKikiSystemID(ReportimageKikiSystem reportimageKikiSystem);

    public List<Integer> getKikisysIDByReportimageKikiSystemID(ReportimageKikiSystem reportimageKikiSystem);

    void deleteByReportimageKikiSystem(ReportimageKikiSystem reportimageKikiSystem);

    List<ReportimageKikiSystem> getListByKoujiId(Integer koujiId);

    void deleteByKoujiIdAndKikisysId(ReportimageKikiSystem reportimageKikiSystem);

    void deleteByImagenameAndKikisysId(ReportimageKikiSystem reportimageKikiSystem);

    /**画像名により、画像Pageを更新*/
    void updatePageByImagename(ReportimageKikiSystem reportimageKikiSystem);
}

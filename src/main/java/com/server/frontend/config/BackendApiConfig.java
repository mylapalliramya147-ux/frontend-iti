package com.server.frontend.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Component
@ConfigurationProperties(prefix = "backend.api")
public class BackendApiConfig {

    private String baseUrl;
    private String itiPath;
    private String districtPath;
    private String designationPath;
    private String shiftUnitPath;


    public String getBaseUrl() {
        return baseUrl;
    }

    public void setBaseUrl(String baseUrl) {
        this.baseUrl = baseUrl;
    }


    public String getItiPath() {
        return itiPath;
    }

    public void setItiPath(String itiPath) {
        this.itiPath = itiPath;
    }

<<<<<<< HEAD

    public String getDistrictPath() {
        return districtPath;
=======
    public String getFullReportsUrl() {
        if (baseUrl.endsWith("/") && reportsPath.startsWith("/")) {
            return baseUrl + reportsPath.substring(1);
        }
        return baseUrl + reportsPath;
>>>>>>> a317127a22e142bf3652103f7718e164c052c2f7
    }

    public void setDistrictPath(String districtPath) {
        this.districtPath = districtPath;
    }


    public String getDesignationPath() {
        return designationPath;
    }

    public void setDesignationPath(String designationPath) {
        this.designationPath = designationPath;
    }


    public String getShiftUnitPath() {
        return shiftUnitPath;
    }

    public void setShiftUnitPath(String shiftUnitPath) {
        this.shiftUnitPath = shiftUnitPath;
    }


    // Full API URLs

    public String getFullitiUrl() {
        return baseUrl + itiPath;
    }


    public String getFullDistrictUrl() {
        return baseUrl + districtPath;
    }


    public String getFullDesignationUrl() {
        return baseUrl + designationPath;
    }


    public String getFullShiftUnitUrl() {
        return baseUrl + shiftUnitPath;
    }

  
   
}
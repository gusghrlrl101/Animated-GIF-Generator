package com.gifwebfront.Form;

import java.util.List;

public class RequestForm {
    private String requestId;
    private List<FileForm> fileList;

    public String getRequestId() {
        return requestId;
    }

    public void setRequestId(String requestId) {
        this.requestId = requestId;
    }

    public List<FileForm> getFileList() {
        return fileList;
    }

    public void setFileList(List<FileForm> fileList) {
        this.fileList = fileList;
    }
}

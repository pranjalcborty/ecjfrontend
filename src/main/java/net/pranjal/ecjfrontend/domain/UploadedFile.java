package net.pranjal.ecjfrontend.domain;

import org.springframework.web.multipart.MultipartFile;

public class UploadedFile {

    private MultipartFile file;
    private boolean hasColumnHeaders;

    private DatasetModel datasetModel;

    public MultipartFile getFile() {
        return file;
    }

    public void setFile(MultipartFile file) {
        this.file = file;
    }

    public boolean isHasColumnHeaders() {
        return hasColumnHeaders;
    }

    public void setHasColumnHeaders(boolean hasColumnHeaders) {
        this.hasColumnHeaders = hasColumnHeaders;
    }

    public DatasetModel getData() {
        return datasetModel;
    }

    public void setData(DatasetModel datasetModel) {
        this.datasetModel = datasetModel;
    }
}

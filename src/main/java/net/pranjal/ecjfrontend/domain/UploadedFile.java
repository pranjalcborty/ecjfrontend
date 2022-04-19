package net.pranjal.ecjfrontend.domain;

import org.springframework.web.multipart.MultipartFile;

public class UploadedFile {

    private MultipartFile file;
    private boolean hasColumnHeaders;

    private Data data;

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

    public Data getData() {
        return data;
    }

    public void setData(Data data) {
        this.data = data;
    }
}

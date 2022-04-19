package net.pranjal.ecjfrontend.domain;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Objects;

@Entity
@Table(name = "dataset")
public class Dataset extends CommonParent implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String fileName;

    public Dataset() {
    }

    public Dataset(String fileName, String uuid, String jsonData) {
        this.fileName = fileName;
        this.uuid = uuid;
        this.jsonData = jsonData;
        this.status = Status.PENDING;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Dataset)) return false;
        Dataset dataset = (Dataset) o;
        return getId() == dataset.getId();
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId());
    }
}

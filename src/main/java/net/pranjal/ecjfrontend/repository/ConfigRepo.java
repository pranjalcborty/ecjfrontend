package net.pranjal.ecjfrontend.repository;

import net.pranjal.ecjfrontend.domain.Config;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ConfigRepo extends CrudRepository<Config, Long> {

    @Query("  SELECT c.uuid, d.fileName, c.status FROM Config c" +
            " JOIN Dataset d ON c.uuid = d.uuid" +
            " ORDER BY c.uploadedOn ASC")
    List<Config> getTaskList();
}

package net.pranjal.ecjfrontend.repository;

import net.pranjal.ecjfrontend.domain.Config;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ConfigRepo extends CrudRepository<Config, Long> {

    @Query("  FROM Config c" +
            " ORDER BY c.uploadedOn ASC")
    List<Config> getTaskList();

    Config findConfigByUuid(String uuid);
}

package net.pranjal.ecjfrontend.repository;

import net.pranjal.ecjfrontend.domain.Dataset;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DatasetRepo extends CrudRepository<Dataset, Long> {

    Dataset findDatasetByUuid(String uuid);
}

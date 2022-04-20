package net.pranjal.ecjfrontend.repository;

import net.pranjal.ecjfrontend.domain.Result;
import org.springframework.data.repository.CrudRepository;

public interface ResultRepo extends CrudRepository<Result, Long> {

    Result findResultByUuid(String uuid);
}

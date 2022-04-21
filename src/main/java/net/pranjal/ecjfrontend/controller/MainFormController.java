package net.pranjal.ecjfrontend.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import net.pranjal.ecjfrontend.domain.*;
import net.pranjal.ecjfrontend.helper.Utility;
import net.pranjal.ecjfrontend.repository.ConfigRepo;
import net.pranjal.ecjfrontend.repository.DatasetRepo;
import net.pranjal.ecjfrontend.repository.ResultRepo;
import net.pranjal.ecjfrontend.web.validator.FileValidator;
import net.pranjal.ecjfrontend.web.validator.ParamsValidator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.NoSuchElementException;
import java.util.Objects;

import static java.util.UUID.randomUUID;

@Controller
public class MainFormController {

    private final FileValidator fileValidator;
    private final ParamsValidator paramsValidator;
    private final ConfigRepo configRepo;
    private final DatasetRepo dsRepo;
    private final ResultRepo resultRepo;

    public MainFormController(FileValidator fileValidator, ParamsValidator paramsValidator,
                              ConfigRepo configRepo, DatasetRepo dsRepo, ResultRepo resultRepo) {

        this.fileValidator = fileValidator;
        this.paramsValidator = paramsValidator;
        this.configRepo = configRepo;
        this.dsRepo = dsRepo;
        this.resultRepo = resultRepo;
    }

    @InitBinder("file")
    public void fileBinder(WebDataBinder binder) {
        binder.addValidators(fileValidator);
        binder.setDisallowedFields("datasetModel");
    }

    @InitBinder("config")
    public void paramsBinder(WebDataBinder binder) {
        binder.addValidators(paramsValidator);
    }

    @GetMapping("/")
    public String home(ModelMap model) {
        model.put("jobs", configRepo.findAll());

        return "home";
    }

    @GetMapping("/upload")
    public String dataUpload(ModelMap model) {
        model.put("file", new UploadedFile());

        return "upload";
    }

    @PostMapping("/upload")
    public String file(@Validated @ModelAttribute("file") UploadedFile file,
                       BindingResult result,
                       ModelMap model) throws JsonProcessingException {

        if (result.hasErrors()) {
            model.put("file", file);
            return "upload";
        }

        String uuid = randomUUID().toString();
        String jsonData = new ObjectMapper().writeValueAsString(file.getData());
        Dataset ds = new Dataset(file.getFile().getOriginalFilename(), uuid, jsonData);
        dsRepo.save(ds);

        return "redirect:/params?uuid=" + uuid;
    }

    @GetMapping("/params")
    public String chooseParams(ModelMap model) {
        setParamsReferenceData(model, new ConfigModel());

        return "selectParams";
    }

    @PostMapping("/params")
    public String saveConfig(@Validated @ModelAttribute("config") ConfigModel config,
                             BindingResult result,
                             @RequestParam("uuid") String uuid,
                             ModelMap model) throws JsonProcessingException {

        if (result.hasErrors()) {
            setParamsReferenceData(model, config);
            return "selectParams";
        }

        String jsonData = new ObjectMapper().writeValueAsString(config);
        Config conf = new Config(uuid, jsonData);
        configRepo.save(conf);

        return "redirect:/";
    }

    @GetMapping("/task")
    public String task(@RequestParam String uuid, ModelMap model) throws JsonProcessingException {
        ObjectMapper mapper = new ObjectMapper();

        Config config = configRepo.findConfigByUuid(uuid);
        ConfigModel configModel = mapper.readValue(config.getJsonData(), ConfigModel.class);

        Dataset dataset = dsRepo.findDatasetByUuid(uuid);
        Result result = resultRepo.findResultByUuid(uuid);

        if (Objects.nonNull(result)) {
            ResultModel allRunInfo = mapper.readValue(result.getJsonData(), ResultModel.class);

            int maxGen = allRunInfo.getAllRunInfoMap()
                    .values().stream()
                    .mapToInt(List::size)
                    .max().orElseThrow(NoSuchElementException::new);


            model.put("result", allRunInfo);
            model.put("resultJson", result.getJsonData());
            model.put("maxGen", maxGen);
        }

        model.put("conf", config);
        model.put("confModel", configModel);
        model.put("dataset", dataset);

        return "task";
    }

    @GetMapping("/error")
    public String error() {
        return "error";
    }

    private void setParamsReferenceData(ModelMap model, ConfigModel configModel) {
        model.put("functionMap", Utility.FUNCTION_CHOICES);
        model.put("paramMap", Utility.GP_PARAM_CHOICES);
        model.put("problemMap", Utility.PROBLEM_CHOICES);
        model.put("defaultMap", Utility.GP_PARAM_DEFAULT_VALUES);
        model.put("config", configModel);
    }
}

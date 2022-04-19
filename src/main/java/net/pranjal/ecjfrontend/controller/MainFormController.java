package net.pranjal.ecjfrontend.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import net.pranjal.ecjfrontend.domain.Configuration;
import net.pranjal.ecjfrontend.domain.Dataset;
import net.pranjal.ecjfrontend.domain.UploadedFile;
import net.pranjal.ecjfrontend.helper.Utility;
import net.pranjal.ecjfrontend.repository.ConfigRepo;
import net.pranjal.ecjfrontend.repository.DatasetRepo;
import net.pranjal.ecjfrontend.web.validator.FileValidator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import java.util.Date;
import java.util.Map;

import static java.util.UUID.randomUUID;

@Controller
public class MainFormController {

    private final FileValidator fileValidator;
    private final ConfigRepo configRepo;
    private final DatasetRepo dsRepo;

    public MainFormController(FileValidator fileValidator, ConfigRepo configRepo, DatasetRepo dsRepo) {
        this.fileValidator = fileValidator;
        this.configRepo = configRepo;
        this.dsRepo = dsRepo;
    }

    @InitBinder("/upload")
    public void fileBinder(WebDataBinder binder) {
        binder.addValidators(fileValidator);
        binder.setDisallowedFields("data");
    }

    @GetMapping("/")
    public String home(ModelMap model) {
        model.put("jobs", configRepo.getTaskList());

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

        ds.setUploadedOn(new Date());
        dsRepo.save(ds);

        return "redirect:/params?uuid=" + uuid;
    }

    @GetMapping("/params")
    public String chooseParams(ModelMap model) {
        model.put("functionMap", Utility.FUNCTION_CHOICES);
        model.put("paramMap", Utility.GP_PARAM_CHOICES);
        model.put("config", new Configuration());

        return "selectParams";
    }

    @PostMapping("/params")
    public String saveConfig(@ModelAttribute Configuration config, BindingResult result) {
        for (int a : config.getFunctionChoices()) {
            System.out.println(a);
        }

        for (Map.Entry<Integer, Integer> entry : config.getParamChoices().entrySet()) {
            System.out.println(entry.getKey() + ": " + entry.getValue());
        }

        return "redirect:/";
    }

    @GetMapping("/error")
    public String error() {
        return "error";
    }
}

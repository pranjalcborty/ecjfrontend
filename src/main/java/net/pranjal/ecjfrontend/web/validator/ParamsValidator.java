package net.pranjal.ecjfrontend.web.validator;

import net.pranjal.ecjfrontend.domain.ConfigModel;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import java.util.Map;

@Component
public class ParamsValidator implements Validator {

    @Override
    public boolean supports(Class<?> clazz) {
        return ConfigModel.class.isAssignableFrom(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        ConfigModel config = (ConfigModel) target;

        if (config.getFunctionChoices().isEmpty()) {
            errors.rejectValue("functionChoices", "error.functions.empty");
        }

        for (Map.Entry<Integer, String> entry: config.getParamChoices().entrySet()) {
            if (entry.getValue().isEmpty()) {
                continue;
            }

            double value;
            try {
                value = Double.parseDouble(entry.getValue());
            } catch (NumberFormatException ne) {
                errors.rejectValue("paramChoices[" + entry.getKey() + "]", "typeMismatch");
                continue;
            }

            if (value < 0) {
                errors.rejectValue("paramChoices[" + entry.getKey() + "]", "typeMismatch");
            }
        }
    }
}

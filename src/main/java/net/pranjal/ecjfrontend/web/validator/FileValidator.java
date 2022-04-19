package net.pranjal.ecjfrontend.web.validator;

import net.pranjal.ecjfrontend.domain.UploadedFile;
import net.pranjal.ecjfrontend.helper.Utility;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@Component
public class FileValidator implements Validator {

    private static final String ALLOWED_FILE_TYPE = "text/csv";
    private static final long MB_SIZE = 1048576L;

    @Override
    public boolean supports(Class<?> clazz) {
        return UploadedFile.class.isAssignableFrom(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        UploadedFile wrappedFile = (UploadedFile) target;
        MultipartFile file = wrappedFile.getFile();

        if (file.isEmpty()) {
            errors.rejectValue("file", "error.file.empty");
        }

        if (!ALLOWED_FILE_TYPE.equals(file.getContentType())) {
            errors.rejectValue("file", "error.file.notCsv");
        }

        if (file.getSize() > 5 * MB_SIZE) {
            errors.rejectValue("file", "error.file.tooLarge");
        }

        try {
            Utility utility = new Utility();
            wrappedFile.setData(utility.constructDataset(file, wrappedFile.isHasColumnHeaders()));

        } catch (IOException e) {
            errors.rejectValue("file", "error.file.dataNotFormattedProperly");
        }
    }
}

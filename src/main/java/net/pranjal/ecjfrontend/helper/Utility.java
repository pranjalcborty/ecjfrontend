package net.pranjal.ecjfrontend.helper;

import net.pranjal.ecjfrontend.domain.DatasetModel;
import org.springframework.web.multipart.MultipartFile;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.*;

import static java.util.Arrays.asList;
import static org.springframework.util.StringUtils.isEmpty;

public class Utility {

    public static Map<Integer, String> FUNCTION_CHOICES = new HashMap<>();
    public static Map<Integer, String> GP_PARAM_CHOICES = new HashMap<>();
    public static Map<Integer, Object> GP_PARAM_DEFAULT_VALUES = new HashMap<>();

    static {
        FUNCTION_CHOICES.put(0, "Add (Addition): 2");
        FUNCTION_CHOICES.put(1, "Sub (Subtraction): 2");
        FUNCTION_CHOICES.put(2, "Mul (Multiplication): 2");
        FUNCTION_CHOICES.put(3, "Div (Safe Division): 2");
        FUNCTION_CHOICES.put(4, "Sin (Sine): 1");
        FUNCTION_CHOICES.put(5, "Cos (Cosine): 1");
        FUNCTION_CHOICES.put(6, "Max (Minimum): 2");
        FUNCTION_CHOICES.put(7, "Min (Maximum): 2");
        FUNCTION_CHOICES = Collections.unmodifiableMap(FUNCTION_CHOICES);

        GP_PARAM_CHOICES.put(0, "Population Size");
        GP_PARAM_CHOICES.put(1, "Crossover");
        GP_PARAM_CHOICES.put(2, "Mutation");
        GP_PARAM_CHOICES.put(3, "Generations");
        GP_PARAM_CHOICES.put(4, "Tournament Size");
        GP_PARAM_CHOICES.put(5, "Elitism");
        GP_PARAM_CHOICES.put(6, "Jobs");
        GP_PARAM_CHOICES = Collections.unmodifiableMap(GP_PARAM_CHOICES);

        GP_PARAM_DEFAULT_VALUES.put(0, 512);
        GP_PARAM_DEFAULT_VALUES.put(1, 0.9);
        GP_PARAM_DEFAULT_VALUES.put(2, 0.1);
        GP_PARAM_DEFAULT_VALUES.put(3, 51);
        GP_PARAM_DEFAULT_VALUES.put(4, 1);
        GP_PARAM_DEFAULT_VALUES.put(5, 0);
        GP_PARAM_DEFAULT_VALUES.put(6, 5);
        GP_PARAM_DEFAULT_VALUES = Collections.unmodifiableMap(GP_PARAM_DEFAULT_VALUES);
    }

    public DatasetModel constructDataset(MultipartFile file, boolean hasColumnHeaders) throws IOException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(file.getInputStream()));
        DatasetModel datasetModel = new DatasetModel();

        if (hasColumnHeaders) {
            datasetModel.setColumns(asList(reader.readLine().split(",")));
        }

        List<List<Double>> x = new ArrayList<>();
        List<Double> y = new ArrayList<>();

        for (String s = reader.readLine(); !isEmpty(s); s = reader.readLine()) {
            String[] tokens = s.split(",");
            List<Double> row = new ArrayList<>();

            for (int i = 0; i < tokens.length - 1; i++) {
                try {
                    row.add(Double.valueOf(tokens[i]));
                } catch (Exception e) {
                    throw new IOException("error.file.dataNotFormattedProperly");
                }
            }

            x.add(row);

            try {
                y.add(Double.valueOf(tokens[tokens.length - 1]));
            } catch (Exception e) {
                throw new IOException("error.file.dataNotFormattedProperly");
            }
        }

        if (!hasColumnHeaders) {
            List<String> columnHeaders = new ArrayList<>();

            for (int i = 0; i < x.get(0).size() + 1; i++) {
                columnHeaders.add("" + i);
            }

            datasetModel.setColumns(columnHeaders);
        }

        if (datasetModel.getColumns().size() != x.get(0).size() + 1) {
            throw new IOException("error.file.dataNotFormattedProperly");
        }

        if ((x.stream().anyMatch(row -> row.size() != x.get(0).size()))) {
            throw new IOException("error.file.dataNotFormattedProperly");
        }

        datasetModel.setX(x);
        datasetModel.setY(y);

        return datasetModel;
    }
}

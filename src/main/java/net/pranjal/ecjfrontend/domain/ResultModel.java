package net.pranjal.ecjfrontend.domain;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

public class ResultModel implements Serializable {

    private static final long serialVersionUID = 1L;

    private Map<String, List<Double>> allRunInfoMap;
    private Map<String, Double> bestIndividualFitnessMap;
    private Map<String, String> bestIndividualMap;

    public Map<String, List<Double>> getAllRunInfoMap() {
        return allRunInfoMap;
    }

    public void setAllRunInfoMap(Map<String, List<Double>> allRunInfoMap) {
        this.allRunInfoMap = allRunInfoMap;
    }

    public Map<String, Double> getBestIndividualFitnessMap() {
        return bestIndividualFitnessMap;
    }

    public void setBestIndividualFitnessMap(Map<String, Double> bestIndividualFitnessMap) {
        this.bestIndividualFitnessMap = bestIndividualFitnessMap;
    }

    public Map<String, String> getBestIndividualMap() {
        return bestIndividualMap;
    }

    public void setBestIndividualMap(Map<String, String> bestIndividualMap) {
        this.bestIndividualMap = bestIndividualMap;
    }
}

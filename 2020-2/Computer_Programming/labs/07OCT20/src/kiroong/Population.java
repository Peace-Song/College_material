package kiroong;

import java.util.ArrayList;
import java.util.Comparator;

public class Population {

    private ArrayList<Individual> individuals;

    public Population() {
        individuals = new ArrayList<>();
    }

    public int size() {
        return individuals.size();
    }

    public void addIndividual(Individual newIndividual) {
        individuals.add(newIndividual);
    }

    private boolean sorted() {
        for(int i=1;i<individuals.size();i++) {
            if (individuals.get(i-1).sortKey() > individuals.get(i).sortKey()) {
                return false;
            }
        }
        return true;
    }

    public void toNextGeneration(int numReplace) {
        if (!sorted()) {
            individuals.sort(Comparator.comparingInt(Individual::sortKey));
        }
        int n = individuals.size(), k = numReplace;
        if (n < 2 * k) {
            throw new Error("Population is too small for the required number of replacement");
        }
        for (int i = k; i < n; i++) {
            individuals.set(i - k, individuals.get(i));
        }
        for (int i = n - k; i < n; i++) {
            individuals.set(i, individuals.get(i).clone());
        }
    }

    public Individual[] getIndividuals() {
        if (!sorted()) {
            individuals.sort(Comparator.comparingInt(Individual::sortKey));
        }
        Individual[] result = new Individual[individuals.size()];
        return individuals.toArray(result);
    }

}
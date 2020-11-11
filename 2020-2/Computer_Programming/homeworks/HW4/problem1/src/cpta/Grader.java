package cpta;

import cpta.environment.Compiler;
import cpta.environment.Executer;
import cpta.exam.ExamSpec;

import java.util.*;

public class Grader {
    Compiler compiler;
    Executer executer;

    public Grader(Compiler compiler, Executer executer) {
        this.compiler = compiler;
        this.executer = executer;
    }

    public Map<String,Map<String, List<Double>>> gradeSimple(ExamSpec examSpec, String submissionDirPath) {
        // TODO Problem 1-1
        return null;
    }

    public Map<String,Map<String, List<Double>>> gradeRobust(ExamSpec examSpec, String submissionDirPath) {
        // TODO Problem 1-2
        return null;
    }

}


package cpta.exam;

import java.util.List;
import java.util.Set;

public class Problem {
    public String id;
    public String testCasesDirPath;
    public List<TestCase> testCases;
    public String targetFileName;
    public String wrappersDirPath;
    public Set<String> judgingTypes;

    public static String TRAILING_WHITESPACES = "trailing-whitespaces";
    public static String IGNORE_WHITESPACES = "ignore-whitespaces";
    public static String CASE_INSENSITIVE = "case-insensitive";

    public Problem(
            String id, String testCasesDirPath, List<TestCase> testCases,
            String targetFileName, String wrappersDirPath, Set<String> judgingTypes
    ) {
        this.id = id;
        this.testCasesDirPath = testCasesDirPath;
        this.testCases = testCases;
        this.targetFileName = targetFileName;
        this.wrappersDirPath = wrappersDirPath;
        this.judgingTypes = judgingTypes;
    }
}


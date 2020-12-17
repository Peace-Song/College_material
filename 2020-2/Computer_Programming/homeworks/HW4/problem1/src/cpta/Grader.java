package cpta;

import cpta.environment.Compiler;
import cpta.environment.Executer;
import cpta.exam.ExamSpec;
import cpta.exam.Problem;
import cpta.exam.Student;
import cpta.exam.TestCase;
import cpta.exceptions.*;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.*;

public class Grader {
    Compiler compiler;
    Executer executer;

    public Grader(Compiler compiler, Executer executer) {
        this.compiler = compiler;
        this.executer = executer;
    }

    private Problem getProblem(List<Problem> problems, String problemId) {
        for (Problem problem : problems) {
            if (problem.id.equals(problemId)) return problem;
        }
        
        return null;
    }

    private Student getStudent(List<Student> students, String studentId) {
        for (Student student : students) {
            if (student.id.equals(studentId)) return student;
        }

        return null;
    }

    private Student getStudentStartsWith(List<Student> students, String studentId) {
        for (Student student : students) {
            if (studentId.startsWith(student.id)) return student;
        }

        return null;
    }

    public Map<String,Map<String, List<Double>>> gradeSimple(ExamSpec examSpec, String submissionDirPath) {
        // TODO Problem 1-1
        return this.gradeRobust(examSpec, submissionDirPath);
        // List<Problem> problems = examSpec.problems;
        // List<Student> students = examSpec.students;
        // Map<String, Map<String, List<Double>>> result = new HashMap<String, Map<String, List<Double>>>();
        // File submissionDir = new File(submissionDirPath);
        // // System.out.println("[DEBUG] " + submissionDir.getPath() + ": isDirectory? " + submissionDir.isDirectory());
        
        // try {
        //     for (File studentDir : submissionDir.listFiles()) {
        //         Map<String, List<Double>> problemToTestCases = new HashMap<String, List<Double>>();

        //         for (File problemDir : studentDir.listFiles()) {
        //             File sourceFile = null;
        //             for (File problemFile : problemDir.listFiles()) {
        //                 if (problemFile.getName().split("\\.")[problemFile.getName().split("\\.").length - 1].equals("sugo")) {
        //                     sourceFile = problemFile;
        //                 }
        //             }

        //             // System.out.println("[DEBUG] name of code: " + problemFile.getName());

        //             String problemId = problemDir.getName();
        //             Problem problem = this.getProblem(problems, problemId);
        //             List<Double> scoreList = new ArrayList<Double>();

        //             this.compiler.compile(sourceFile.getPath());
        //             if (problem == null) {
        //                 throw new FileSystemRelatedException();
        //             }

        //             problem.testCases.sort(
        //                 (TestCase tc1, TestCase tc2) -> tc1.id.compareTo(tc2.id)
        //             );    

        //             for (TestCase testcase : problem.testCases) {
        //                 this.executer.execute(problemDir.getPath() + "/" + sourceFile.getName().split("\\.")[0] + ".yo", 
        //                                       problem.testCasesDirPath + testcase.inputFileName, 
        //                                       problemDir.getPath() + "/" + testcase.outputFileName);

        //                 Scanner outputScanner = new Scanner(new File(problemDir.getPath() + "/" + testcase.outputFileName));
        //                 Scanner referenceScanner = new Scanner(new File(problem.testCasesDirPath + testcase.outputFileName));
        //                 String outputString = "";
        //                 String referenceString = "";
                        
        //                 while (outputScanner.hasNext()) {
        //                     outputString += outputScanner.nextLine();
        //                 }
        //                 while (referenceScanner.hasNext()) {
        //                     referenceString += referenceScanner.nextLine();
        //                 }
        //                 scoreList.add(outputString.equals(referenceString) ? testcase.score : 0);
        //             }

        //             problemToTestCases.put(problemId, scoreList);
        //         }
        //         result.put(studentDir.getName(), problemToTestCases);
        //     }
                
        // } catch (CompileErrorException cee) {
        //     System.out.println(cee.getMessage());
        // } catch (InvalidFileTypeException ifte) {
        //     System.out.println(ifte.getMessage());
        // } catch (FileSystemRelatedException fsre) {
        //     System.out.println(fsre.getMessage());
        // } catch (Exception e) {
        //     e.printStackTrace();
        //     System.out.println("Unknown error encountered.");
        // }
        
        // return result;
    }

    public Map<String,Map<String, List<Double>>> gradeRobust(ExamSpec examSpec, String submissionDirPath) {
        // TODO Problem 1-2

        List<Problem> problems = examSpec.problems;
        List<Student> students = examSpec.students;
        File submissionDir = new File(submissionDirPath);
        Map<String, Map<String, List<Double>>> result = new HashMap<String, Map<String, List<Double>>>();
        
        // initialize studentsExist
        Map<Student, Boolean> studentsExist = new HashMap<Student, Boolean>();
        for (Student student : students) {
            studentsExist.put(student, false);
        }

        // do for every student directories
        for (File studentDir : submissionDir.listFiles()) {

            // mark the student with the directory as true
            String studentId = studentDir.getName();
            Student student = this.getStudent(students, studentId);
            if (student == null) {
                student = this.getStudentStartsWith(students, studentId); // allow directory names starting with id
                if (student == null) continue;
                studentId = student.id;
            }
            studentsExist.put(student, true);

            // initialize problemsExist
            Map<Problem, Boolean> problemsExist = new HashMap<Problem, Boolean>();
            for (Problem problem : problems) {
                problemsExist.put(problem, false);
            }

            // this student's list of testcase scores w.r.t. problems
            Map<String, List<Double>> problemsToTestCaseScores = new HashMap<String, List<Double>>();


            // do for every problem directories
            for (File problemDir : studentDir.listFiles()) {
                ArrayList<Double> testCaseScores = new ArrayList<Double>();
                ArrayList<String> wrapperFileNames = new ArrayList<String>();

                // mark the problem with the directory as true
                String problemId = problemDir.getName();
                Problem problem = this.getProblem(problems, problemId);
                if (problem == null) continue;
                problemsExist.put(problem, true);

                // move all files in the wrong directory outside if it is the case
                if (this.hasSubdirectory(problemDir.getPath())) {
                    this.moveFilesToOutside(problemDir.getPath());
                }

                // has wrapper codes
                if (problem.wrappersDirPath != null) {
                    File wrapperDir = new File(problem.wrappersDirPath);

                    for (File wrapperSourceFile : wrapperDir.listFiles()) {
                        File dstFile = new File(problemDir.getPath() + "/" + wrapperSourceFile.getName());
                        try {
                            Files.copy(wrapperSourceFile.toPath(), dstFile.toPath(), StandardCopyOption.REPLACE_EXISTING);
                        } catch (IOException ioe) {
                            // System.out.println("[DEBUG] " + ioe.getMessage());
                        }
                        wrapperFileNames.add(dstFile.getName());
                    }
                }

                // sort test cases
                problem.testCases.sort(
                    (TestCase tc1, TestCase tc2) -> tc1.id.compareTo(tc2.id)
                );


                // this problem directory has yo files without corresponding sugo files
                if (this.hasYoFileWithOutCorrespondingSugoFile(problemDir.getPath())) {
                    boolean wrapperCompilationErrorFlag = false;

                    // compile wrappers if this is the case
                    if (problem.wrappersDirPath != null) {
                        for (File wrapperFile : problemDir.listFiles()) {
                            if (wrapperFile.getName().endsWith(".sugo")) {
                                try {
                                    this.compiler.compile(wrapperFile.getPath());
                                } catch (CompileErrorException cee) {
                                    wrapperCompilationErrorFlag = true;
                                    break;
                                } catch (InvalidFileTypeException ifte) {

                                    wrapperCompilationErrorFlag = true;
                                    break;
                                } catch (FileSystemRelatedException fsre) {
                                    wrapperCompilationErrorFlag = true;
                                    break;
                                } catch (Exception e) {
                                    // System.out.println("[DEBUG] " + e.getMessage());
                                }
                            }
                        }
                    }

                    // wrapper compilation error
                    if (wrapperCompilationErrorFlag) {
                        for (int idx = 0; idx < problem.testCases.size(); idx++) {
                            testCaseScores.add((double) 0);
                        }
                        problemsToTestCaseScores.put(problemId, testCaseScores);
                        continue;
                    }

                    // exceute .yo with testcases
                    for (TestCase testCase : problem.testCases) {
                        boolean executionErrorFlag = false;

                        try {
                            this.executer.execute(
                                problemDir.getPath() + "/" + this.getYoFileName(problem.targetFileName),
                                problem.testCasesDirPath + testCase.inputFileName,
                                problemDir.getPath() + "/" + testCase.outputFileName
                            );
                        } catch (RunTimeErrorException rtee) {
                            executionErrorFlag = true;
                        } catch (InvalidFileTypeException ifte) {
                            executionErrorFlag = true;
                        } catch (FileSystemRelatedException fsre) {
                            executionErrorFlag = true;
                        } catch (Exception e) {
                            // System.out.println("[DEBUG] " + e.getMessage());
                        }

                        // execution error
                        if (executionErrorFlag) {
                            testCaseScores.add((double) 0);
                            continue;
                        }

                        // compare outputs
                        try {
                            Scanner outputScanner = new Scanner(new File(problemDir.getPath() + "/" + testCase.outputFileName));
                            Scanner referenceScanner = new Scanner(new File(problem.testCasesDirPath + testCase.outputFileName));
                            String outputString = "";
                            String referenceString = "";
                            
                            while (outputScanner.hasNext()) {
                                outputString += outputScanner.nextLine();
                            }
                            while (referenceScanner.hasNext()) {
                                referenceString += referenceScanner.nextLine();
                            }
                            // reduce half the score as the student didn't submit the code
                            testCaseScores.add(this.compareStrings(outputString, referenceString, problem.judgingTypes) ? testCase.score / 2 : 0);
    
                        } catch (FileNotFoundException fnfe) { 
                            // System.out.println("[DEBUG] " + fnfe.getMessage());
                        }
                    }

                    // save to the map
                    problemsToTestCaseScores.put(problemId, testCaseScores);
                }

                // this problem directory has sugo files
                else {
                    boolean compilationErrorFlag = false;

                    // compile sugo files
                    for (File sugoFile : problemDir.listFiles()) {
                        if (sugoFile.getName().endsWith(".sugo")) {
                            try {
                                this.compiler.compile(sugoFile.getPath());
                            } catch (CompileErrorException cee) {            
                                compilationErrorFlag = true;
                                break;
                            } catch (InvalidFileTypeException ifte) {
                                compilationErrorFlag = true;
                                break;
                            } catch (FileSystemRelatedException fsre) {
                                compilationErrorFlag = true;
                                break;
                            } catch (Exception e) {
                                // System.out.println("[DEBUG] " + e.getMessage());
                            }
                        }
                    }

                    // compilation error
                    if (compilationErrorFlag) {
                        for (int idx = 0; idx < problem.testCases.size(); idx++) {
                            testCaseScores.add((double) 0);
                        }
                        problemsToTestCaseScores.put(problemId, testCaseScores);
                        continue;
                    }

                    // exceute .yo with testcases
                    for (TestCase testCase : problem.testCases) {
                        boolean executionErrorFlag = false;

                        try {
                            this.executer.execute(
                                problemDir.getPath() + "/" + this.getYoFileName(problem.targetFileName),
                                problem.testCasesDirPath + testCase.inputFileName,
                                problemDir.getPath() + "/" + testCase.outputFileName
                            );
                        } catch (RunTimeErrorException rtee) {
                            executionErrorFlag = true;
                        } catch (InvalidFileTypeException ifte) {
                            executionErrorFlag = true;
                        } catch (FileSystemRelatedException fsre) {
                            executionErrorFlag = true;
                        } catch (Exception e) {
                            executionErrorFlag = true;
                        }

                        // execution error
                        if (executionErrorFlag) {
                            testCaseScores.add((double) 0);
                            continue;
                        }

                        // compare outputs
                        try {
                            Scanner outputScanner = new Scanner(new File(problemDir.getPath() + "/" + testCase.outputFileName));
                            Scanner referenceScanner = new Scanner(new File(problem.testCasesDirPath + testCase.outputFileName));
                            String outputString = "";
                            String referenceString = "";
                            
                            while (outputScanner.hasNext()) {
                                outputString += outputScanner.nextLine();
                            }
                            while (referenceScanner.hasNext()) {
                                referenceString += referenceScanner.nextLine();
                            }
                            testCaseScores.add(this.compareStrings(outputString, referenceString, problem.judgingTypes) ? testCase.score : 0);
    
                        } catch (FileNotFoundException fnfe) { 
                            // System.out.println("[DEBUG] " + fnfe.getMessage()); 
                        }
                    }

                    // save to the map
                    problemsToTestCaseScores.put(problemId, testCaseScores);
                }
                
            }

            // score 0 for problems which do not have problem directories
            for (Problem problem : problemsExist.keySet()) {
                if (!problemsExist.get(problem)) {
                    ArrayList<Double> testCaseScores = new ArrayList<Double>();
                    
                    for (int idx = 0; idx < problem.testCases.size(); idx++) {
                        testCaseScores.add((double) 0);
                    }

                    problemsToTestCaseScores.put(problem.id, testCaseScores);
                }
            }

            result.put(studentId, problemsToTestCaseScores);
        }

        // score 0 for students who do not have student directories
        for (Student student : studentsExist.keySet()) {
            if (!studentsExist.get(student)) {
                Map<String, List<Double>> problemsToTestCaseScores = new HashMap<String, List<Double>>();
                for (Problem problem : problems) {
                    ArrayList<Double> testCaseScores = new ArrayList<Double>();
                    
                    for (int idx = 0; idx < problem.testCases.size(); idx++) {
                        testCaseScores.add((double) 0);
                    }

                    problemsToTestCaseScores.put(problem.id, testCaseScores);
                }

                result.put(student.id, problemsToTestCaseScores);
            }
        }

        return result;
    }

    private boolean compareStrings(String outputString, String referenceString, Set<String> judgingTypes) {
        if (judgingTypes == null || judgingTypes.size() == 0) {
            if (outputString.equals(referenceString)) return true;
            else return false;
        }

        if (judgingTypes.contains(Problem.TRAILING_WHITESPACES)) {
            outputString = outputString.stripTrailing();
            referenceString = referenceString.stripTrailing();
        }

        if (judgingTypes.contains(Problem.IGNORE_WHITESPACES)) {
            outputString = outputString.replaceAll(" ", "");
            referenceString = referenceString.replaceAll(" ", "");
            outputString = outputString.replaceAll("\n", "");
            referenceString = referenceString.replaceAll("\n", "");
            outputString = outputString.replaceAll("\t", "");
            referenceString = referenceString.replaceAll("\t", "");
        }

        if (judgingTypes.contains(Problem.CASE_INSENSITIVE)) {
            if (outputString.equalsIgnoreCase(referenceString)) return true;
            else return false;
        }
        else {
            if (outputString.equals(referenceString)) return true;
            else return false;
        }        
    }

    private boolean hasYoFileWithOutCorrespondingSugoFile(String directoryPath) {
        File directory = new File(directoryPath);

        for (File yoFile : directory.listFiles()) {
            if (yoFile.getName().endsWith(".yo")) {
                boolean hasSugoFile = false;

                for (File sugoFile : directory.listFiles()) {
                    if (sugoFile.getName().endsWith("sugo") && sugoFile.getName().split("\\.")[0].equals(yoFile.getName().split("\\.")[0])) {
                        hasSugoFile = true;
                        break;
                    } 
                }

                if (!hasSugoFile) return true;
            }
        }

        return false;
    }

    private boolean hasSubdirectory(String directoryPath) {
        File directory = new File(directoryPath);

        for (File file : directory.listFiles()) {
            if (file.isDirectory()) return true;
        }

        return false;
    }

    private void moveFilesToOutside(String directoryPath) {
        File directory = new File(directoryPath);

        for (File file : directory.listFiles()) {
            if (file.isDirectory()) {
                for (File fileInside : file.listFiles()) {
                    File dstFile = new File(directory.getPath() + "/" + fileInside.getName());

                    try {
                        Files.move(fileInside.toPath(), dstFile.toPath());
                    } catch (IOException ioe) {
                        // System.out.println("[DEBUG] " + ioe.getMessage());
                    }
                }
            }
        }
    }

    private String getYoFileName(String sugoFileName) {
        return sugoFileName.split("\\.")[0] + ".yo";
    }
}


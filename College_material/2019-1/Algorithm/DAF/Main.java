import java.util.*;
import java.lang.*;
import java.io.*;

//  Name        : Main.java
//  Author      : PeaceSong, Irene, KKW
//  Version     : 1.000
//  Copyright   : Apache License 2.0

public class Main{// Q. Why public? A. Why assignment?
	public int numQueryNode;
	public int numDataNode = 0;
	public int numLabel = 0;
	public int[] labelData = null; //labelData[i] contains label of vertex i
	public int[] degreeData = null; //degreeData[i] contains degree of vertex i
	public int[] sortedData = null; //sortedData contains V in sorted order first by label frequency and second by degree
	public int[] idxSortedData = null; //idxSortedData[l] contains the last index in sortedData such that labelData[sortedData[index]] is l
	public int[] labelFrequency = null; //labelFrequency[l] contains the number of vertices having label l
	public int[] renamedLabel = null; //labels are renamed as consecutive numbers

	//Variables for query graph
	public int root = -1;
	public int numQueryNode = 0;
	public int sumQueryDegree = 0;
	public int[] labelQuery = null;
	public int[] degreeQuery = null;
	public int[] adjListQuery = null;
	public int[] adjIndexQuery = null;

	//Variables for query DAG
	public int[][] dagChildQuery = null; //dagChildQuery[i]: children of node i
	public int[][] dagParentQuery = null; //dagParentQuery[i]: parent of node i
	public int[] dagChildQuerySize = null; //dagChildQuerySize[i]: the number of children of node i
	public int[] dagParentQuerySize = null; //dagParentQuerySize[i]: the number of parent on node i
	public static Comparator<Integer> degreeDataComparator = new Comparator<Integer>(){
		public int compare(int o1, int o2){
			return degreeQuery[o2]-degreeQuery[o1];
		}
	};
	public static Comparator<Integer> labelComparator = new Comparator<Integer>(){
		public int compare(int o1, int o2){
			return labelQuery[o2]-labelQuery[o1];
		}
	};
	public static Comparator<Integer> degreeQueryComparator = new Comparator<Integer>(){
		public int compare(int o1, int o2){
			return degreeQuery[o1]-degreeQuery[o2];
		}
	};
	public static Comparator<Integer> labelFrequencyComparator = new Comparator<Integer>(){
		public int compare(int l1, int l2){
			int o1 = labelQuery[l1];
			int o2 = labelQuery[l2];
			return labelFrequency[o2]-labelFrequency[o1];
		}
	};

	private void bulidDAG(){
		if( dagChildQuery == null ) {
			dagChildQuery = new int[numQueryNode][];
			for(int i = 0; i < numQueryNode; ++i)
				dagChildQuery[i] = null;
		}
		if( dagParentQuery == null ) {
			dagParentQuery = new int[numQueryNode][];
			for(int i = 0; i < numQueryNode; ++i)
				dagParentQuery[i] = null;
		}
		if( dagChildQuerySize == null )
			dagChildQuerySize = new int[numQueryNode];
		if( dagParentQuerySize == null )
			dagParentQuerySize = new int[numQueryNode];

		Arrays.fill(dagChildQuerySize, 0);
		Arrays.fill(dagParentQuerySize, 0);

		//memset(dagChildQuerySize, 0, sizeof(int) * numQueryNode);
		//memset(dagParentQuerySize, 0, sizeof(int) * numQueryNode);

		for(int i = 0; i < numQueryNode; ++i) {
			if( dagChildQuery[i] != null) {
				dagChildQuery[i] = null;
			}
			dagChildQuery[i] = new int[degreeQuery[i]];

			if( dagParentQuery[i] != null ) {
				dagParentQuery[i] = null;
			}
			dagParentQuery[i] = new int[degreeQuery[i]];
		}
		//////////////////
		//construct dag data structure
		char[] popped = new char[numQueryNode];
		Arrays.fill(popped, 0);
		//memset(popped, 0, sizeof(char) * numQueryNode);
		char[] visited = new char[numQueryNode];
		Arrays.fill(visited, 0);
		//memset(visited, 0, sizeof(char) * numQueryNode);
		int[] queue = new int[numQueryNode];
		int currQueueStart = 0;
		int currQueueEnd = 1;
		int nextQueueStart = 1;
		int nextQueueEnd = 1;

		//visit root
		root = selectRoot();
		visited[ root ] = 1;
		queue[0] = root;

		//BFS traversal using queue
		while(true) {
			Arrays.sort(queue, currQueueStart, currQueueEnd, degreeQueryComparator);
			//stable_sort(queue + currQueueStart, queue + currQueueEnd, sortByDegreeQuery);
			Arrays.sort(queue, currQueueStart, currQueueEnd, labelFrequencyComparator);
			//stable_sort(queue + currQueueStart, queue + currQueueEnd, sortByLabelFreqQuery);
			while( currQueueStart != currQueueEnd ) {
				int currNode = queue[ currQueueStart ];
				++currQueueStart;
				popped[currNode] = 1;
				//cout << currNode << " ";
				System.out.print(currNode + " ");

				for(int i = adjIndexQuery[currNode]; i < adjIndexQuery[currNode + 1]; ++i) {
					int childNode = adjListQuery[i];
					if(popped[childNode] == 0) {
						dagChildQuery[currNode][ dagChildQuerySize[currNode] ] = childNode;
						dagParentQuery[childNode][ dagParentQuerySize[childNode] ] = currNode;

						++dagChildQuerySize[currNode];
						++dagParentQuerySize[childNode];
					}
					if(visited[childNode] == 0) {
						visited[childNode] = 1;
						queue[nextQueueEnd] = childNode;
						++nextQueueEnd;
					}
				}
			}

			if(currQueueEnd == nextQueueEnd) //no nodes have been pushed in
				break;

			currQueueStart = currQueueEnd;
			currQueueEnd = nextQueueEnd;
		}
	}

	public void readDataGraph(string aFileName){
		/////////////////
		//1st read: set degreeData, and calculate the largest label and the number of labels

		try{
			File queryFile = new File(aFileName);
			FileReader reader = new FileReader(queryFile);
			BufferedReader inFile = new BufferedReader(reader);
		}catch(exception e){System.out.println("Exception raised in readDataGraph");}

		//ifstream inFile(aFileName);

		int largestLabel = -1;
		Set<int> labelSet = new HashSet<>();
		String line;
		while( (line = inFile.readLine()) != null ) {
			if( line.charAt(0) == 't' ) {
				//istringstream iss(line);
				char tag;
				int id;
				//iss >> tag >> id >> numDataNode;
				tag = (char)line.split(" ")[0];
				id = Integer.parseInt(line.split(" ")[1]);
				numDataNode = Integer.parseInt(line.split(" ")[2]);

				if( labelData != null) {
					labelData = null;
				}
				if( degreeData != null ) {
					degreeData = null;
				}
				labelData = new int[numDataNode];
				degreeData = new int[numDataNode];
				//memset(degreeData, 0, sizeof(int) * (numDataNode));
				Arrays.fill(degreeData, 0);
			}
			else if( line.charAt(0) == 'v' ) {
				//istringstream iss(line);
				char tag;
				int id;
				int label;
				//iss >> tag >> id >> label;
				tag = (char)line.split(" ")[0];
				id = Integer.parseInt(line.split(" ")[1]);
				label = Integer.parseInt(line.split(" ")[2]);

				if( labelData == null || numDataNode < id ) {
					System.out.println("ERROR: in readDataGraph, vertex id out of range");
					return;//originally exit(-1);
				}
				//labelData[id] = label;
				if( largestLabel < label )
					largestLabel = label;
				labelSet.add(label);
			}
			else if( line[0] == 'e' ) {
				//istringstream iss(line);
				char tag;
				int left;
				int right;
				int label;
				//iss >> tag >> left >> right >> label;
				tag = (char)line.split(" ")[0];
				left = Integer.parseInt(line.split(" ")[1]);
				right = Integer.parseInt(line.split(" ")[2]);
				label = Integer.parseInt(line.split(" ")[3]);

				if( degreeData == null || numDataNode < left || numDataNode < right ) {
					System.out.println("ERROR: in readDataGraph, vertex id out of range");
					return;//originally exit(-1);
				}
				//Make sure not to increase two times
				++degreeData[left];
				++degreeData[right];
			}
		}

		numLabel = labelSet.size();

		//////////////////
		//2nd read: rename label, set labelData, and set labelFrequency
		int labelId = 0;

		if( renamedLabel != null ) {
			renamedLabel = null;
		}
		renamedLabel = new int[largestLabel + 1];
		//memset(renamedLabel, -1, sizeof(int) * (largestLabel + 1) );
		Arrays.fill(renamedLabel, -1);

		if( labelFrequency != null ) {
			labelFrequency = null;
		}
		labelFrequency = new int[numLabel];
		//memset(labelFrequency, 0, sizeof(int) * (numLabel));
		Arrays.fill(renamedFrequency, 0);

		//inFile.close();
		//inFile.seekg(0, ios::beg);
		inFile.reset()
			/*
			   try{
			   queryFile = new File(aFileName);
			   reader = new FileReader(queryFile);
			   inFile = new BufferedReader(reader);
			   }catch(exception e){System.out.println("Exception raised in readDataGraph");}
			   */

			while( (line = inFile.readLine()) != null ) {
				if( line.charAt(0) == 't' ) {
				}
				else if( line.charAt(0) == 'v' ) {
					//istringstream iss(line);
					char tag;
					int id;
					int label;
					//iss >> tag >> id >> label;
					tag = (char)line.split(" ")[0];
					id = Integer.parseInt(line.split(" ")[1]);
					label = Integer.parseInt(line.split(" ")[2]);

					if( renamedLabel[label] == -1 ) {
						renamedLabel[label] = labelId;
						++labelId;
					}

					labelData[id] = renamedLabel[label];

					++labelFrequency[ renamedLabel[label] ];
				}
				else if( line.charAt(0) == 'e' ) {
				}
			}

		inFile.close();
		//////////////////
		//sort data vertices by label name.
		//Then, sort by degree for each label group
		if(sortedData != null ) {
			sortedData = null;
		}
		sortedData = new int[numDataNode];
		for(int i = 0; i < numDataNode; ++i)
			sortedData[i] = i;

		//stable_sort(sortedData, sortedData + numDataNode, sortByDegreeData);
		//stable_sort(sortedData, sortedData + numDataNode, sortByLabel);
		Arrays.sort(sortedData, 0, numDataNode, degreeDataComparator);
		Arrays.sort(sortedData, 0, numDataNode, labelComparator);

		if( idxSortedData != null ) {
			idxSortedData = null;
		}
		idxSortedData = new int[numLabel + 1];

		if( numDataNode < 1 ) {
			System.out.println("ERROR: in readDataGraph, 0 vertices");
			return; //originally exit(-1);
		}

		idxSortedData[ labelData[sortedData[0]] ] = 0;
		for(int i = 1; i < numDataNode; ++i) {
			if( labelData[sortedData[i - 1]] != labelData[sortedData[i]] )
				idxSortedData[ labelData[sortedData[i]] ] = i;
		}
		idxSortedData[ numLabel ] = numDataNode;
	}

	//read one query graph
	public void readQueryGraph(BufferedReader aInFile, int aSumDegree){
		//////////////////
		//allocate memory
		if( labelQuery == null )
			labelQuery = new int[numQueryNode];
		if( degreeQuery == null )
			degreeQuery = new int[numQueryNode];
		if( adjIndexQuery == null )
			adjIndexQuery = new int[numQueryNode + 1];
		if( adjListQuery == null ) {
			adjListQuery = new int[aSumDegree];
			sumQueryDegree = aSumDegree;
		}

		//(re)allocate memory for adjacency list of query graph
		if( sumQueryDegree < aSumDegree ) {
			if( adjListQuery != null ) {
				adjListQuery = null;
			}

			adjListQuery = new int[aSumDegree];
			sumQueryDegree = aSumDegree;
		}
		//////////////////
		//read query graph
		int index = 0;
		adjIndexQuery[0] = index;
		for(int i = 0; i < numQueryNode; ++i) {
			int id;
			int label;
			int degree;
			//aInFile >> id >> label >> degree;
			String line = b_reader.readLine();

			id = Integer.parseInt(line.split(" ")[0]);
			label = Integer.parseInt(line.split(" ")[1]);
			degree = Integer.pasreInt(line.split(" ")[2]);

			labelQuery[i] = renamedLabel[label];
			degreeQuery[i] = degree;
			for(int j = 0; j < degree; ++j) {
				adjListQuery[index] = Integer.parseInt(line.split(" ")[3 + j];
						++index;
			}
			adjIndexQuery[i + 1] = index;
		}
	}

	public int selectRoot(){
		int root = -1;
		int label;
		int degree;
		double rank;
		double rootRank = 99999;

		for (int i = 0; i < numQueryNode; ++i) {
			label = labelQuery[i];
			degree = degreeQuery[i];

			int start = idxSortedData[label];
			int end = idxSortedData[label + 1];
			int mid = binaryLowerBound(start, end - 1, degree);

			int numInitCand = end - mid;

			rank = numInitCand/(double)degree;

			if( rank < rootRank ) {
				root = i;
				rootRank = rank;
			}
		}

		return root;
	}

	public int binaryLowerBound(int aLeft, int aRight, int aDegree)
	{
		int left = aLeft;
		int right = aRight;
		while( left < right ) {
			int mid = left + (right - left) / 2;

			if( degreeData[ sortedData[mid] ] < aDegree )
				left = mid + 1;
			else
				right = mid;
		}
		return left;
	}


	public static void main(String[] args) {
		//args[1] : name of data query file
		//args[2] : name of query graph file
		//args[3] : the number of query in query graph file

		//read data graph file
		//read the query grap file
		//find the dag for each query graph

		try{
			File queryFile = new File(args[2]);
			FileReader reader = new FileReader(queryFile);
			BufferedReader b_reader = new BufferedReader(reader);
		}catch(exception e){System.out.println("Exception raised.");}

		if(args.length != 4){
			System.out.println("usage: ./program dataFile queryFile numQuery");
			return;
		}

		int numQuery = Integer.parseInt(args[3]);

		readDataGraph(args[1]);

		for(int i = 0; i < numQuery; ++i){
			char tag;
			int id;
			int num;
			int sumDegree;

			String line = b_reader.readLine();

			tag = (char)line.split(" ")[0];
			id = Integer.parseInt(line.split(" ")[1]);
			num = Integer.parseInt(line.split(" ")[2]);
			sumDegree = Integer.pasreInt(line.split(" ")[3]);

			//queryFile >> tag >> id >> num >> sumDegree;
			this.numQueryNode = num;

			readQueryGraph(b_reader, sumDegree);//originally sent off queryFile as 1st operand
			buildDAG();
		}
		queryFile.close();

		return;
	}
=======
    public int numQueryNode;
    public int numDataNode = 0;
    public int numLabel = 0;
    public int[] labelData = null; //labelData[i] contains label of vertex i
    public int[] degreeData = null; //degreeData[i] contains degree of vertex i
    public int[] sortedData = null; //sortedData contains V in sorted order first by label frequency and second by degree
    public int[] idxSortedData = null; //idxSortedData[l] contains the last index in sortedData such that labelData[sortedData[index]] is l
    public int[] labelFrequency = null; //labelFrequency[l] contains the number of vertices having label l
    public int[] renamedLabel = null; //labels are renamed as consecutive numbers

    //Variables for query graph
    public int root = -1;
    public int numQueryNode = 0;
    public int sumQueryDegree = 0;
    public int[] labelQuery = null;
    public int[] degreeQuery = null;
    public int[] adjListQuery = null;
    public int[] adjIndexQuery = null;

    //Variables for query DAG
    public int[][] dagChildQuery = null; //dagChildQuery[i]: children of node i
    public int[][] dagParentQuery = null; //dagParentQuery[i]: parent of node i
    public int[] dagChildQuerySize = null; //dagChildQuerySize[i]: the number of children of node i
    public int[] dagParentQuerySize = null; //dagParentQuerySize[i]: the number of parent on node i
    public static Comparator<Integer> degreeDataComparator = new Comparator<Integer>(){
        public int compare(int o1, int o2){
            return degreeQuery[o2]-degreeQuery[o1];
        }
    };
    public static Comparator<Integer> labelComparator = new Comparator<Integer>(){
        public int compare(int o1, int o2){
            return labelQuery[o2]-labelQuery[o1];
        }
    };
    public static Comparator<Integer> degreeQueryComparator = new Comparator<Integer>(){
        public int compare(int o1, int o2){
            return degreeQuery[o1]-degreeQuery[o2];
        }
    };
    public static Comparator<Integer> labelFrequencyComparator = new Comparator<Integer>(){
        public int compare(int l1, int l2){
            int o1 = labelQuery[l1];
            int o2 = labelQuery[l2];
            return labelFrequency[o2]-labelFrequency[o1];
        }
    };

    private void bulidDAG(){
        if( dagChildQuery == null ) {
            dagChildQuery = new int[numQueryNode][];
            for(int i = 0; i < numQueryNode; ++i)
                dagChildQuery[i] = null;
        }
        if( dagParentQuery == null ) {
            dagParentQuery = new int[numQueryNode][];
            for(int i = 0; i < numQueryNode; ++i)
                dagParentQuery[i] = null;
        }
        if( dagChildQuerySize == null )
            dagChildQuerySize = new int[numQueryNode];
        if( dagParentQuerySize == null )
            dagParentQuerySize = new int[numQueryNode];

        Arrays.fill(dagChildQuerySize, 0);
        Arrays.fill(dagParentQuerySize, 0);

        //memset(dagChildQuerySize, 0, sizeof(int) * numQueryNode);
        //memset(dagParentQuerySize, 0, sizeof(int) * numQueryNode);

        for(int i = 0; i < numQueryNode; ++i) {
            if( dagChildQuery[i] != null) {
                dagChildQuery[i] = null;
            }
            dagChildQuery[i] = new int[degreeQuery[i]];

            if( dagParentQuery[i] != null ) {
                dagParentQuery[i] = null;
            }
            dagParentQuery[i] = new int[degreeQuery[i]];
        }
        //////////////////
        //construct dag data structure
        char[] popped = new char[numQueryNode];
        Arrays.fill(popped, 0);
        //memset(popped, 0, sizeof(char) * numQueryNode);
        char[] visited = new char[numQueryNode];
        Arrays.fill(visited, 0);
        //memset(visited, 0, sizeof(char) * numQueryNode);
        int[] queue = new int[numQueryNode];
        int currQueueStart = 0;
        int currQueueEnd = 1;
        int nextQueueStart = 1;
        int nextQueueEnd = 1;

        //visit root
        root = selectRoot();
        visited[ root ] = 1;
        queue[0] = root;

        //BFS traversal using queue
        while(true) {
            Arrays.sort(queue, currQueueStart, currQueueEnd, degreeQueryComparator);
            //stable_sort(queue + currQueueStart, queue + currQueueEnd, sortByDegreeQuery);
            Arrays.sort(queue, currQueueStart, currQueueEnd, labelFrequencyComparator);
            //stable_sort(queue + currQueueStart, queue + currQueueEnd, sortByLabelFreqQuery);
            while( currQueueStart != currQueueEnd ) {
                int currNode = queue[ currQueueStart ];
                ++currQueueStart;
                popped[currNode] = 1;
                //cout << currNode << " ";
                System.out.print(currNode + " ");

                for(int i = adjIndexQuery[currNode]; i < adjIndexQuery[currNode + 1]; ++i) {
                    int childNode = adjListQuery[i];
                    if(popped[childNode] == 0) {
                        dagChildQuery[currNode][ dagChildQuerySize[currNode] ] = childNode;
                        dagParentQuery[childNode][ dagParentQuerySize[childNode] ] = currNode;

                        ++dagChildQuerySize[currNode];
                        ++dagParentQuerySize[childNode];
                    }
                    if(visited[childNode] == 0) {
                        visited[childNode] = 1;
                        queue[nextQueueEnd] = childNode;
                        ++nextQueueEnd;
                    }
                }
            }

            if(currQueueEnd == nextQueueEnd) //no nodes have been pushed in
                break;

            currQueueStart = currQueueEnd;
            currQueueEnd = nextQueueEnd;
        }
    }

    public void readDataGraph(string aFileName){
        /////////////////
        //1st read: set degreeData, and calculate the largest label and the number of labels

        try{
            File queryFile = new File(aFileName);
            FileReader reader = new FileReader(queryFile);
            BufferedReader inFile = new BufferedReader(reader);
        }catch(exception e){System.out.println("Exception raised in readDataGraph");}

        //ifstream inFile(aFileName);

        int largestLabel = -1;
        Set<int> labelSet = new HashSet<>();
        String line;
        while( (line = inFile.readLine()) != null ) {
            if( line.charAt(0) == 't' ) {
                //istringstream iss(line);
                char tag;
                int id;
                //iss >> tag >> id >> numDataNode;
                tag = (char)line.split(" ")[0];
                id = Integer.parseInt(line.split(" ")[1]);
                numDataNode = Integer.parseInt(line.split(" ")[2]);

                if( labelData != null) {
                    labelData = null;
                }
                if( degreeData != null ) {
                    degreeData = null;
                }
                labelData = new int[numDataNode];
                degreeData = new int[numDataNode];
                //memset(degreeData, 0, sizeof(int) * (numDataNode));
                Arrays.fill(degreeData, 0);
            }
            else if( line.charAt(0) == 'v' ) {
                //istringstream iss(line);
                char tag;
                int id;
                int label;
                //iss >> tag >> id >> label;
                tag = (char)line.split(" ")[0];
                id = Integer.parseInt(line.split(" ")[1]);
                label = Integer.parseInt(line.split(" ")[2]);

                if( labelData == null || numDataNode < id ) {
                    System.out.println("ERROR: in readDataGraph, vertex id out of range");
                    return;//originally exit(-1);
                }
                //labelData[id] = label;
                if( largestLabel < label )
                    largestLabel = label;
                labelSet.add(label);
            }
            else if( line[0] == 'e' ) {
                //istringstream iss(line);
                char tag;
                int left;
                int right;
                int label;
                //iss >> tag >> left >> right >> label;
                tag = (char)line.split(" ")[0];
                left = Integer.parseInt(line.split(" ")[1]);
                right = Integer.parseInt(line.split(" ")[2]);
                label = Integer.parseInt(line.split(" ")[3]);

                if( degreeData == NULL || numDataNode < left || numDataNode < right ) {
                    System.out.println("ERROR: in readDataGraph, vertex id out of range");
                    return;//originally exit(-1);
                }
                //Make sure not to increase two times
                ++degreeData[left];
                ++degreeData[right];
            }
        }

        numLabel = labelSet.size();

        //////////////////
        //2nd read: rename label, set labelData, and set labelFrequency
        int labelId = 0;

        if( renamedLabel != null ) {
            renamedLabel = null;
        }
        renamedLabel = new int[largestLabel + 1];
        //memset(renamedLabel, -1, sizeof(int) * (largestLabel + 1) );
        Arrays.fill(renamedLabel, -1);

        if( labelFrequency != null ) {
            labelFrequency = null;
        }
        labelFrequency = new int[numLabel];
        //memset(labelFrequency, 0, sizeof(int) * (numLabel));
        Arrays.fill(renamedFrequency, 0);

        //inFile.close();
        //inFile.seekg(0, ios::beg);
        inFile.reset()
            /*
               try{
               queryFile = new File(aFileName);
               reader = new FileReader(queryFile);
               inFile = new BufferedReader(reader);
               }catch(exception e){System.out.println("Exception raised in readDataGraph");}
             */

            while( (line = inFile.readLine()) != null ) {
                if( line.charAt(0) == 't' ) {
                }
                else if( line.charAt(0) == 'v' ) {
                    //istringstream iss(line);
                    char tag;
                    int id;
                    int label;
                    //iss >> tag >> id >> label;
                    tag = (char)line.split(" ")[0];
                    id = Integer.parseInt(line.split(" ")[1]);
                    label = Integer.parseInt(line.split(" ")[2]);

                    if( renamedLabel[label] == -1 ) {
                        renamedLabel[label] = labelId;
                        ++labelId;
                    }

                    labelData[id] = renamedLabel[label];

                    ++labelFrequency[ renamedLabel[label] ];
                }
                else if( line.charAt(0) == 'e' ) {
                }
            }

        inFile.close();
        //////////////////
        //sort data vertices by label name.
        //Then, sort by degree for each label group
        if(sortedData != null ) {
            sortedData = null;
        }
        sortedData = new int[numDataNode];
        for(int i = 0; i < numDataNode; ++i)
            sortedData[i] = i;

        //stable_sort(sortedData, sortedData + numDataNode, sortByDegreeData);
        //stable_sort(sortedData, sortedData + numDataNode, sortByLabel);
        Arrays.sort(sortedData, 0, numDataNode, degreeDataComparator);
        Arrays.sort(sortedData, 0, numDataNode, labelComparator);

        if( idxSortedData != null ) {
            idxSortedData = null;
        }
        idxSortedData = new int[numLabel + 1];

        if( numDataNode < 1 ) {
            System.out.println("ERROR: in readDataGraph, 0 vertices");
            return; //originally exit(-1);
        }

        idxSortedData[ labelData[sortedData[0]] ] = 0;
        for(int i = 1; i < numDataNode; ++i) {
            if( labelData[sortedData[i - 1]] != labelData[sortedData[i]] )
                idxSortedData[ labelData[sortedData[i]] ] = i;
        }
        idxSortedData[ numLabel ] = numDataNode;
    }

    //read one query graph
    public void readQueryGraph(BufferedReader aInFile, int aSumDegree){
        //////////////////
        //allocate memory
        if( labelQuery == null )
            labelQuery = new int[numQueryNode];
        if( degreeQuery == null )
            degreeQuery = new int[numQueryNode];
        if( adjIndexQuery == null )
            adjIndexQuery = new int[numQueryNode + 1];
        if( adjListQuery == null ) {
            adjListQuery = new int[aSumDegree];
            sumQueryDegree = aSumDegree;
        }

        //(re)allocate memory for adjacency list of query graph
        if( sumQueryDegree < aSumDegree ) {
            if( adjListQuery != null ) {
                adjListQuery = null;
            }

            adjListQuery = new int[aSumDegree];
            sumQueryDegree = aSumDegree;
        }
        //////////////////
        //read query graph
        int index = 0;
        adjIndexQuery[0] = index;
        for(int i = 0; i < numQueryNode; ++i) {
            int id;
            int label;
            int degree;
            //aInFile >> id >> label >> degree;
            String line = b_reader.readLine();

            id = Integer.parseInt(line.split(" ")[0]);
            label = Integer.parseInt(line.split(" ")[1]);
            degree = Integer.pasreInt(line.split(" ")[2]);

            labelQuery[i] = renamedLabel[label];
            degreeQuery[i] = degree;
            for(int j = 0; j < degree; ++j) {
                adjListQuery[index] = Integer.parseInt(line.split(" ")[3 + j];
                ++index;
            }
            adjIndexQuery[i + 1] = index;
        }
    }

    public static void main(String[] args) {
        //args[1] : name of data query file
        //args[2] : name of query graph file
        //args[3] : the number of query in query graph file

        //read data graph file
        //read the query grap file
        //find the dag for each query graph

        try{
            File queryFile = new File(args[2]);
            FileReader reader = new FileReader(queryFile);
            BufferedReader b_reader = new BufferedReader(reader);
        }catch(exception e){System.out.println("Exception raised.");}

        if(args.length != 4){
            System.out.println("usage: ./program dataFile queryFile numQuery");
            return;
        }

        int numQuery = Integer.parseInt(args[3]);

        readDataGraph(args[1]);

        for(int i = 0; i < numQuery; ++i){
            char tag;
            int id;
            int num;
            int sumDegree;

            String line = b_reader.readLine();

            tag = (char)line.split(" ")[0];
            id = Integer.parseInt(line.split(" ")[1]);
            num = Integer.parseInt(line.split(" ")[2]);
            sumDegree = Integer.pasreInt(line.split(" ")[3]);

            //queryFile >> tag >> id >> num >> sumDegree;
            this.numQueryNode = num;

            readQueryGraph(b_reader, sumDegree);//originally sent off queryFile as 1st operand
            buildDAG();
        }
        queryFile.close();

        return;
    }
>>>>>>> 4e7f27692742a6694232e04ee95ab398a3c5944f
}

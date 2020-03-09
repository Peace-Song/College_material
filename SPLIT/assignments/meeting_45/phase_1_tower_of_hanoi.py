def render(A, B, C):
  # NOTE: DO NOT MODIFY THIS FUNCTION.
	print("A:	", end="")
	for i in range(len(A)):
		print(A[i], end="")
	print("")

	print("B:	", end="")
	for i in range(len(B)):
		print(B[i], end="")
	print("")

	print("C:	", end="")
	for i in range(len(C)):
		print(C[i], end="")
	print("\n")

	return


def do_hanoi(A, B, C, n):
  # TODO: IMPLEMENT THIS FUNCTION.
  """ Moves n disks from A to C.

  Args:
    A (list): The tower from which disks will be moved.
    B (list): The tower whose disks will remain the same.
    C (list): The tower to which disks will be moved.
    n (int): The number of disks that will be moved from tower A to B.
    
  """
  
  if n == 1:
    # TODO: 1. Initial case - only one disk will be moved from A to C.
    pass


  else:
    # TODO: 2. General case - All disks must be moved from A to C.
    pass




###################################################################################
#                            NOTE: DO NOT MODIFY BELOW.                           #
###################################################################################
print("Meeting 4&5, Phase 1: Tower of Hanoi")
print("")

# Take input from the user.
print("How many disks does the Tower have?")
num_disks = int(input(">>> "))

# Initialize the towers.
tower_A = ["|{level}|".format(level=num_disks-level) for level in range(num_disks)]
tower_B = []
tower_C = []

# Print the towers before moving.
print("Before:")
render(tower_A, tower_B, tower_C)

# Move the disks.
do_hanoi(tower_A, tower_B, tower_C, num_disks)

# Print the towers after moving.
print("After:")
render(tower_A, tower_B, tower_C)

###################################################################################
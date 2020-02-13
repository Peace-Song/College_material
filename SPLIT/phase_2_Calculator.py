print("Meeting 2, phase 2: Calculator")

while True:
  calc_str = input("Enter an express to calculate, with a space in between operands and operator. (e.g. 3 + 2)\n")

  #### Part 1. Parse calc_str and assign proper values to operand_1, operand_2, and operator. ####
  operand_1 = 0
  operator = '+'
  operand_2 = 0
  ################################################################################################


  #### Part 2. Only the logic for "+" is implemented. Fix it to support -, *, /, //, %, ** operators. ####
  if operator == '+':
    result = operand_1 + operand_2
  #####################################################################################################


  #### Part 3. Format the following string to show the two operands and the operator in between them, and the result of the calculation. ####
  print("0 + 0 == 0")
  ###########################################################################################################################################
  
  
  #### Part 4. Implement escaping the infinite loop, when DONE is entered in this stage. ####
  term_str = input("Do you wish to continue? If so, enter anything but DONE. If not, enter DONE.\n")
  ###########################################################################################

print("Calculator successfully terminated.")

import os.path

def main(*args, **kwargs): 
  dictionary = dict()
  filename = "dictionary.txt"
 
  if not os.path.isfile(filename):
    f = open(filename, "w")
    f.close()
  else:
    load_from_file(filename, dictionary)

  while True:  
    print("----------------------------------------------------------------")
    print("Enter a command from the below.\n")
    print("ADD  : Adds to the Dictionary an entry and description of a word.")
    print("DEL  : Deletes from the Dictionary an entry and description of a word.")
    print("SAVE : Saves the current status of the Dictionary to your computer.")
    print("CLR  : Deletes all entries from the Dictionary.")
    print("SHOW : Show all entries of the Dictionary.")
    print("EXIT : Exit the Dictionary without saving.")
    print("----------------------------------------------------------------")

    command = input(">>> ")
    
    ########################################################################
    # NOTE: Fill in the conditions below.

    dictionary = dict(sorted(dictionary.items()))

    if command == "ADD":
      add_dict(dictionary)
    
    elif command == "DEL":
      del_dict(dictionary)

    elif command == "SAVE":
      save_to_file(filename, dictionary)

    elif command == "CLR":
      clr_dict(dictionary)

    elif command == "SHOW":
      print_dict(dictionary)

    elif command == "EXIT":
      break

    else:
      print("Invalid command. Try again.")
    ########################################################################

  print("The Dictionary successfully terminated.")

  return


def add_dict(dictionary):
  # TODO: Fill in the function.

  print("Enter an entry you want to put in the Dictionary.")
  entry = input(">>> ")
  print("Enter a description of the entry.")
  description = input(">>> ")

  dictionary[entry] = description
  print("Added entry:")
  print("{entry}: {description}".format(entry=entry, description=description))

  return


def del_dict(dictionary):
  # TODO: Fill in the function.

  print("Enter an entry you want to delete from the Dictionary.")
  entry = input(">>> ")
  description = dictionary[entry]

  del dictionary[entry]
  print("Deleted entry:")
  print("{entry}: {description}".format(entry=entry, description=description))
  
  return


def clr_dict(dictionary):
  # TODO: Fill in the function.

  dictionary.clear()
  
  return


def load_from_file(filename, dictionary):
  # NOTE: DO NOT MODIFY THIS FUNCTION.
  try:
    f = open(filename, "r")
  except FileNotFoundError as fnfe:
    print(fnfe)

  line = f.readline()
  while line != "":
    entry = line.split(":")[0]
    description = line.split(":")[1].rstrip()

    dictionary[entry] = description

    line = f.readline()

  f.close()

  return


def save_to_file(filename, dictionary):
  # NOTE: DO NOT MODIFY THIS FUNCTION.
  try:
    f = open(filename, "w")
  except FileNotFoundError as fnfe:
    print(fnfe)

  for entry, description in dictionary.items():
    f.write("{entry}:{description}\n".format(entry=entry, description=description))
 
  
  f.close()
  
  return


def print_dict(dictionary):
  print("----------------------------------------------------------------")
  print("|                        The Dictionary                        |")
  print("----------------------------------------------------------------")

  ################################################################################
  # TODO: Fill in this place.
  if len(dictionary) == 0:
    print("There currently is no entry in the Dictionary.")

  for entry, description in dictionary.items():
    print("{entry}: {description}".format(entry=entry, description=description))

  ################################################################################
  print("----------------------------------------------------------------")

  return


if __name__ == "__main__":
  # NOTE: DO NOT MODIFY HERE.
  print("Meeting 3, Phase 2: Dictionary")
  main()

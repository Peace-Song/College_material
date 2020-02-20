print("Meeting 3, Phase 1: Harry Potter")

def count_words(sentences):
  # NOTE: Implement this function. 
  word_count = 0
  for sentence in sentences:
    word_count += len(sentence.split())

  return word_count

def count_keyword(sentences, keyword):
  # NOTE: Implement this function.
  keyword_count = 0
  for sentence in sentences:
    split_sentence = sentence.split()
    
    for word in split_sentence:
      if keyword == word:
        keyword_count += 1

  return keyword_count


##########################################################################################
#                                     NOTE: DO NOT MODIFY                                #
##########################################################################################
try:
  f = open("hp_1.txt", "r")
except FileNotFoundError as fnfe:
  print(fnfe)

sentences = f.readlines()
keyword = input("Enter a word you want to know how many they appear in the text: ")

word_count = count_words(sentences)

keyword_count = count_keyword(sentences, keyword)

print("The text has {num_words} words.".format(num_words=word_count))
print("Keyword {keyword} appears {num_keyword} times in the text.".format(keyword=keyword, num_keyword=keyword_count))
#########################################################################################3

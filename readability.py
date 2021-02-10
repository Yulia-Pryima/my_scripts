# Readability
# A program that computes the approximate grade level needed to comprehend some text, per the below.

# Ask for text input
text = input("Text: ")

# Count the number of letters in the text.
count_letters = 0
for char in text:
    if char.isalpha():
        count_letters += 1

# Count the number of words in the text.
count_words = 1
for char in text:
    if char == ' ':
        count_words += 1

# Count the number of sentences in the text.
count_sentences = 0
for char in text:
    if char == '.' or char == '!' or char == '?':
        count_sentences += 1

# Output the grade level for the text, according to the Coleman-Liau formula
L = count_letters / count_words * 100
S = count_sentences / count_words * 100
index = round(0.0588 * L - 0.296 * S - 15.8)

if index >= 16:
    print('Grade 16+')

elif index < 1:
    print('Before Grade 1')

else:
    print(f'Grade {index}')


# Text example: Congratulations! Today is your day. You're off to Great Places! You're off and away!
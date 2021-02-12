# DNA
# Program that take a sequence of DNA (in .txt) and a CSV file containing a list of individuals and then output to whom the DNA belongs.
import csv
import sys


def main():
    # Ensure correct usage
    if len(sys.argv) != 3:
        sys.exit('Usage: python dna.py data.csv sequence.txt')

    persons = []
    # CSV file
    database = sys.argv[1]
    # Text file
    sequence = sys.argv[2]

    # Open the CSV file and read its contents into memory
    with open(database, newline='') as csvfile:
        csv_read = csv.reader(csvfile)
        for row in csv_read:
            # Store each person as a dictionary in a list of "persons"
            persons.append(row)

    # List of all STRs
    STRs_list = persons[0][1:len(persons[0])]
    # print(STRs_list)

    # Open the DNA sequence in txt file and read its contents into memory
    with open(sequence) as txtfile:
        txt_read = txtfile.read()

    # Call a function that returns the maximum number of times that the STR repeats.

    max_STR_count = calc_dna_sequence(txt_read, STRs_list)

    # Call a function that print out the name of the individual matching with STR counts.
    matching_name(max_STR_count, persons)


# For each of the STRs computes the longest run of consecutive repeats of the STR in the DNA sequence
def calc_dna_sequence(DNA, STRs_list):
    '''Find longest dna sequence.'''
    max_STR_count = []
    for i in range(len(STRs_list)):
        STR = STRs_list[i]
        max_STR_count.append(0)

        # Compare STR from STRs_list to DNA in .txt and find matching
        for j in range(len(DNA)):
            STR_count = 0

            # If matching STR found, finds out how many consecutive repeats in the sequence
            if DNA[j:j + len(STR)] == STR:
                k = 0
                while DNA[j + k:j + k + len(STR)] == STR:
                    STR_count += 1
                    k += len(STR)

                # Compare STR count and max STR count
                if STR_count > max_STR_count[i]:
                    max_STR_count[i] = STR_count
    return max_STR_count


# If the STR counts match exactly with any of the individuals in the CSV file, prints out the name of the matching individual, else prints "No match".
def matching_name(max_STR_count, persons):
    for i in range(1, len(persons)):
        # Convert list of strings into list of integers
        persons[i][1:len(persons[i])] = [int(i) for i in persons[i][1:len(persons[i])]]
        if max_STR_count == persons[i][1:len(persons[i])]:
            name = persons[i][0]
            print(name)
            exit(0)
    print('No match')


if __name__ == '__main__':
    main()

# Test: python dna.py databases/large.csv sequences/15.txt

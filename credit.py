# Credit
# A program that prompts the user for a credit card number and then reports whether it is a valid American Express, MasterCard, or Visa.
import math

# Prompt for input
credit_card = input("Number: ")

# Luhn’s Algorithm


def num_1(credit_card):
    i = len(credit_card) - 2
    summary = 0
    while i >= 0:
        sec_dig = credit_card[i]
        mult = int(sec_dig) * 2
        x = len(str(mult))
        if x == 2:
            num_1 = math.floor((mult % 100) / 10)
            num_2 = mult % 10

            summary += num_1 + num_2
        else:
            mult = int(sec_dig) * 2
            summary += mult
        i -= 2
    return summary


def num_2(credit_card):
    i = len(credit_card) - 1
    summary = 0
    while i >= 0:
        sec_dig = credit_card[i]
        summary += int(sec_dig)
        i -= 2
    return summary


checksum = num_1(credit_card) + num_2(credit_card)

# Calculate checksum (last number = 0)
if checksum % 10 == 0:
    # Check for card length and starting digits (is it American Express or MasterCared or a Visa)

    # Print AMEX
    f_num = int(credit_card[0]+credit_card[1])
    if len(credit_card) == 15 and f_num == 34 or f_num == 37:
        print('AMEX\n')

    # Print MASTERCARD
    elif len(credit_card) == 16 and f_num in range(51, 56):
        print('MASTERCARD\n')

    # Print VISA
    elif len(credit_card) == 13 or len(credit_card) == 16 and int(credit_card[0]) == 4:
        print('VISA\n')

# Print INVALID
else:
    print('INVALID\n')


# Credit card number example: 378282246310005

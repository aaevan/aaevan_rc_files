'''
an incomplete (but hopefully useful) tool for printing what different indices
point to at any given point in time in an algorithms execution.
'''
def array_debug(arr, index_tuples):
    """
    takes an array and a series of (index, label_str) pairs
    """
    for tuple_index, (check_index, _) in enumerate(index_tuples):
        if check_index >= len(arr):
            whitespace = ' ' * (len(str(index_tuples[:tuple_index])) + 2)
            raise ValueError("\n{}\n{}|\n{}outside of range!".format(
                index_tuples, whitespace, whitespace
            ))
    output = [str(arr)] + [''] * (len(index_tuples) + 1)
    for offset, (index, label) in enumerate(index_tuples):
        if index == 0:
            whitespace = ' '
        else:
            whitespace = ' ' * (len(str(arr[:index])) + 1)
        splice_in = []
        splice_in.append("{}|".format(whitespace))
        for i in range(offset):
            splice_in.append("{}|".format(whitespace))
        splice_in.append("{}{} ({})".format(whitespace, label, index))
        for index, line in enumerate(splice_in):
            output[index + 1] = merge_strings(output[index + 1], line)
    for line in output:
        print(line)

def merge_strings(str1, str2):
    output = []
    #st1 overwrites any non-whitespace values of str2
    maxlength = max(len(str1), len(str2))
    str1 = '{0:<{1}}'.format(str1, maxlength)
    str2 = '{0:<{1}}'.format(str2, maxlength)
    for char_pair in zip(str1, str2):
        if char_pair[0] != ' ':
            output.append(char_pair[0])
        else:
            output.append(char_pair[1])
    return ''.join(output)

def main():
    example = [6, 20, 23, 28, 37, 38, 39, 46, 51, 52, 55, 59, 73, 80, 81]
    array_debug(example, ((0, 'beginning'), (5, 'middle'), (6, 'neighbor'), (-1, 'end')))
    array_debug(example, ((0, 'beginning'), (5, 'middle'), (99, 'neighbor'), (-1, 'end')))

if __name__ == "__main__":
    main()


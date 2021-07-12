import os
import os.path

file = open(r"fib.txt", "r")
lines_in = file.readlines()
file.close()

# List to store lines of assembly code to be parsed
lines = []

# Remove comments from lines read in assembly code
for line in lines_in:
    split_string = line.split('#', 1)
    lines.append(split_string[0])

# List of instructions in binary
BinCode_list = []

# Dictionary to store labels and their memory addresses
label_holder = {}

# Store the addresses of the labels in a dictionary
address = 0
for line in lines:
    if (':' in line):
        label = line.split(':')[0]
        label_holder.update({label:address})
        #address = address + 4
    else:
        address = address + 4

print(label_holder)

# Translate instructions into binary format
for line in lines:

    # Translate the ADI instruction
    if (line[0:3] == 'ADI' or line[0:3] == 'adi'):
        #opcode     4-bit
        #src1       6-bit
        #dest       6-bit
        #imm        16-bit

        opcode_bin = bin(0)[2:].zfill(4)

        split_line = line.split('$')

        dest = line.split("$",2)[1]
        dest_bin = bin(int(dest))[2:].zfill(6)

        src1_bin = bin(int(split_line[1]))[2:].zfill(6)
        imm_bin = bin(int(split_line[2].split()[1]))[2:].zfill(16)

        instr_bin = opcode_bin + dest_bin + src1_bin + imm_bin
        BinCode_list.append(instr_bin)

    # Translate the BEQ instruction
    elif (line[0:3] == 'BEQ' or line[0:3] == 'beq'):
        #opcode     4-bits
        #src1       6-bits
        #src2       6-bits
        #imm        16-bits

        opcode_bin = bin(5)[2:].zfill(4)

        split_line = line.split('$')

        src1_bin = bin(int(split_line[1]))[2:].zfill(6)

        src2_bin = bin(int(split_line[2].split()[0]))[2:].zfill(6)
        
        offset = bin(int(split_line[2].split()[1]))[2:].zfill(16)

        instr_bin = opcode_bin + src1_bin + src2_bin + offset
        BinCode_list.append(instr_bin)

    # Translate the JMP instruction
    elif (line[0:3] == 'JMP' or line[0:3] == 'jmp'):
        #opcode     4-bits
        #address    28-bits
        opcode_bin = bin(6)[2:].zfill(4)

        split_line = line.split()
        lbl = split_line[1]

        address_bin = bin(label_holder[lbl])[2:].zfill(28)

        instr_bin = opcode_bin + address_bin
        BinCode_list.append(instr_bin)

    # Translate the ADD instruction
    elif (line[0:3] == 'ADD' or line[0:3] == 'add'):
        #opcode     4-bit
        #dest       6-bit
        #src1       6-bit
        #src2       6-bit
        #shamt      10-bit

        opcode_bin = bin(1)[2:].zfill(4)

        split_line = line.split('$')

        dest_bin = bin(int(split_line[1]))[2:].zfill(6)
        src1_bin = bin(int(split_line[2]))[2:].zfill(6)
        src2_bin = bin(int(split_line[3]))[2:].zfill(6)
        shamt_bin = bin(0)[2:].zfill(10)

        instr_bin = opcode_bin + dest_bin + src1_bin + src2_bin + shamt_bin
        BinCode_list.append(instr_bin)

    # Translate the AND instruction
    elif (line[0:3] == 'AND' or line[0:3] == 'and'):
        #opcode     4-bit
        #dest       6-bit
        #src1       6-bit
        #src2       6-bit
        #shamt      10-bit

        opcode_bin = bin(2)[2:].zfill(4)

        split_line = line.split('$')

        dest_bin = bin(int(split_line[1]))[2:].zfill(6)        
        src1_bin = bin(int(split_line[2]))[2:].zfill(6)
        src2_bin = bin(int(split_line[3]))[2:].zfill(6)
        shamt_bin = bin(0)[2:].zfill(10)

        instr_bin = opcode_bin + dest_bin + src1_bin + src2_bin + shamt_bin
        BinCode_list.append(instr_bin)

    # Translate the ORR instruction
    elif (line[0:3] == 'ORR' or line[0:3] == 'orr'):
        #opcode     4-bit
        #dest       6-bit
        #src1       6-bit
        #src2       6-bit
        #shamt      10-bit

        opcode_bin = bin(3)[2:].zfill(4)

        split_line = line.split('$')

        dest_bin = bin(int(split_line[1].split()[0]))[2:].zfill(6)
        src1_bin = bin(int(split_line[2].split()[0]))[2:].zfill(6)
        src2_bin = bin(int(split_line[3].split()[0]))[2:].zfill(6)
        shamt_bin = bin(0)[2:].zfill(10)

        instr_bin = opcode_bin + dest_bin + src1_bin + src2_bin + shamt_bin
        BinCode_list.append(instr_bin)

    # Translate the XOR instruction
    elif (line[0:3] == 'XOR' or line[0:3] == 'orr'):
        #opcode     4-bit
        #dest       6-bit
        #src1       6-bit
        #src2       6-bit
        #shamt      10-bit

        opcode_bin = bin(4)[2:].zfill(4)

        split_line = line.split('$')

        dest_bin = bin(int(split_line[1]))[2:].zfill(6)
        src1_bin = bin(int(split_line[2]))[2:].zfill(6)
        src2_bin = bin(int(split_line[3]))[2:].zfill(6)
        shamt_bin = bin(0)[2:].zfill(10)

        instr_bin = opcode_bin + dest_bin + src1_bin + src2_bin + shamt_bin
        BinCode_list.append(instr_bin)

    # Translate the SLL instruction
    elif (line[0:3] == 'SLL' or line[0:3] == 'sll'):
        #opcode     4-bit
        #dest       6-bit
        #src1       6-bit
        #shamt      16-bit

        opcode_bin = bin(7)[2:].zfill(4)

        split_line = line.split('$')

        dest_bin = bin(int(split_line[1]))[2:].zfill(6)
        src1_bin = bin(int(split_line[2].split()[0]))[2:].zfill(6)
        shamt_bin = bin(int(split_line[2].split()[1]))[2:].zfill(16)

        instr_bin = opcode_bin + dest_bin + src1_bin + shamt_bin
        BinCode_list.append(instr_bin)

    # Translate the SRL instruction
    elif (line[0:3] == 'SRL' or line[0:3] == 'srl'):
        opcode_bin = bin(8)[2:].zfill(4)

        split_line = line.split('$')

        dest_bin = bin(int(split_line[1]))[2:].zfill(6)
        src1_bin = bin(int(split_line[2].split()[0]))[2:].zfill(6)
        shamt_bin = bin(int(split_line[2].split()[1]))[2:].zfill(16)

        instr_bin = opcode_bin + dest_bin + src1_bin + shamt_bin
        BinCode_list.append(instr_bin)

    # Translate the SUB instruction
    elif (line[0:3] == 'SUB' or line[0:3] == 'sub'):
        #opcode     4-bit
        #dest       6-bit
        #src1       6-bit
        #src2       6-bit
        #shamt      10-bit

        opcode_bin = bin(9)[2:].zfill(4)

        split_line = line.split('$')

        dest_bin = bin(int(split_line[1]))[2:].zfill(6)        
        src1_bin = bin(int(split_line[2]))[2:].zfill(6)
        src2_bin = bin(int(split_line[3]))[2:].zfill(6)
        shamt_bin = bin(0)[2:].zfill(10)

        instr_bin = opcode_bin + dest_bin + src1_bin + src2_bin + shamt_bin
        BinCode_list.append(instr_bin)

    # Translate the ILT instruction
    elif (line[0:3] == 'ILT' or line[0:3] == 'ilt'):
        #opcotde    4-bit
        #dest       6-bit
        #src1       6-bit
        #src2       6-bit
        #shamt      10-bit

        opcode_bin = bin(10)[2:].zfill(4)

        split_line = line.split('$')

        dest_bin = bin(int(split_line[1]))[2:].zfill(6)  

        src1_bin = bin(int(split_line[2]))[2:].zfill(6)
        src2_bin = bin(int(split_line[3]))[2:].zfill(6)
        
        shamt_bin = bin(0)[2:].zfill(10)

        instr_bin = opcode_bin + dest_bin + src1_bin + src2_bin + shamt_bin
        BinCode_list.append(instr_bin)


HexCode_list = []
# Translate binary to hex
for line in BinCode_list:
    temp = hex(int(line, 2))[2:].zfill(8)
    HexCode_list.append(temp)


# Write the binary to a file
binary = open('hexCode.dat', 'w')

filesize = os.path.getsize('hexCode.dat')
if (filesize == 0):
    with open('hexCode.dat', 'w') as f:
        for bin in HexCode_list:
            f.write("%s\n" % bin)
else:
    f.truncate(0)
    for bin in HexCode_list:
            f.write("%s\n" % bin)
            
f.close()
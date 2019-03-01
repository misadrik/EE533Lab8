'''rtype-v1 support Rtype lw sw
31-25 24-20 19-15 14-12 11-7 6-0
FUNC7 RS2   RS1   FUNC3 RD  OP

'''
Rtype = ['add', 'sub', 'sll', 'xor', 'srl', 'or', 'and']
load_word = 'lw'
store_word = 'sw'
IMMEDIATE = ['addi', 'slti', 'sltiu', 'xori', 'ori', 'andi']
Branch = ['beq', 'bne', 'blt', 'bge']
Jump = 'j'
JAL = 'jal'
JALR = 'jalr'
register_map = {'x0': '0', 'ra': '1', 'sp': '2', 'gp': '3', 'tp': '4', 't0': '5', 't1': '6',
                't2': '7', 's0': '8', 's1': '9', 'a0': '10', 'a1': '11', 'a2': '12',
                'a3': '13', 'a4': '14', 'a5': '15', 'a6': '16', 'a7': '17', 's2': '18', 's3': '19',
                's4': '20', 's5': '21', 's6': '22', 's7': '23', 's8': '24', 's9': '25', 's10': '26',
                's11': '27', 't3': '28', 't4': '29', 't5': '30', 't6': '31'}


def mini_compiler2(assembly):
# assembly = input('Operation: ').split()
    if assembly[0] in Rtype:
        #print(Rtype_Decoder(assembly[0], register_map[assembly[1]], register_map[assembly[2]], register_map[assembly[3]]))
        machine_code = Rtype_Decoder(assembly[0], register_map[assembly[1]], register_map[assembly[2]], register_map[assembly[3]])

    if assembly[0] == load_word:
        # print(LW_Decoder(assembly[0], register_map[assembly[1]], register_map[assembly[2]], assembly[3]))
        machine_code =  LW_Decoder(assembly[0], register_map[assembly[1]], register_map[assembly[2]], assembly[3])

    if assembly[0] == store_word:
        # print(SW_Decoder(
        #     assembly[0], register_map[assembly[1]], register_map[assembly[2]], assembly[3]))
        machine_code = SW_Decoder(assembly[0], register_map[assembly[1]], register_map[assembly[2]], assembly[3])
    
    if assembly[0] in IMMEDIATE:
        # print(IMMEDIATE_Decoder(assembly[0], register_map[assembly[1]],
        #                  register_map[assembly[2]], assembly[3]))
        machine_code = IMMEDIATE_Decoder(assembly[0], register_map[assembly[1]], register_map[assembly[2]], assembly[3])
    
    if assembly[0] in Branch:
        # print(Branch_Decoder(assembly[0], register_map[assembly[1]],
        #                 register_map[assembly[2]], assembly[3]))
        machine_code = Branch_Decoder(assembly[0], register_map[assembly[1]],
                             register_map[assembly[2]], assembly[3])
    
    if assembly[0] == Jump:
        machine_code = Jump_Decoder(assembly[0], assembly[1])

    if assembly[0] == JAL:
        machine_code = JAL_Decoder(assembly[0], register_map[assembly[1]], assembly[2])

    if assembly[0] == JALR:
        machine_code = JALR_Decoder(assembly[0], register_map[assembly[1]],
                           register_map[assembly[2]], assembly[3])

    if assembly[0] == 'nop':
        machine_code = '0xB'

    return machine_code
    

def Rtype_Decoder(opcode,rd,rs,rt):
    rs_bin = dec_to_bin(int(rs), 5)
    rt_bin = dec_to_bin(int(rt), 5)
    rd_bin = dec_to_bin(int(rd), 5)

    if opcode == 'add':
        Instruction ='0000000'+ rt_bin + rs_bin +'000'+ rd_bin + '0110011'
    
    if opcode == 'sub':
        Instruction = '0100000' + rt_bin + rs_bin + '000' + rd_bin + '0110011'
    
    if opcode == 'sll':
        Instruction = '0000000' + rt_bin + rs_bin + '001' + rd_bin + '0110011'
    
    if opcode == 'xor':
        Instruction = '0000000' + rt_bin + rs_bin + '100' + rd_bin + '0110011'
    
    if opcode == 'srl':
        Instruction = '0000000' + rt_bin + rs_bin + '101' + rd_bin + '0110011'
    
    if opcode == 'or':
        Instruction = '0000000' + rt_bin + rs_bin + '110' + rd_bin + '0110011'

    if opcode == 'and':
        Instruction = '0000000' + rt_bin + rs_bin + '111' + rd_bin + '0110011'

    print(Instruction[0:8], Instruction[8:16], Instruction[16:24], Instruction[24:32])
    return hex(int(Instruction,2))


def LW_Decoder(opcode, rd, rs, offset):
    rd_bin = dec_to_bin(int(rd), 5)
    rs_bin = dec_to_bin(int(rs), 5)
    offset_bin = dec_to_bin(int(offset), 12)
    
    Instruction = offset_bin + rs_bin + '010' + rd_bin + '0000011'


    print(Instruction[0:8], Instruction[8:16],
      Instruction[16:24], Instruction[24:32])
    return hex(int(Instruction,2))

def SW_Decoder(opcode, rt, rs, offset):
    rt_bin=dec_to_bin(int(rt), 5)
    rs_bin=dec_to_bin(int(rs), 5)
    offset_bin=dec_to_bin(int(offset), 12)
    
    Instruction = offset_bin[0:7] + rt_bin + rs_bin + '010' + offset_bin[7:] + '0100011'
    
    print(Instruction[0:8], Instruction[8:16],
          Instruction[16:24], Instruction[24:32])
    return hex(int(Instruction,2))

def IMMEDIATE_Decoder(opcode,rd,rs,offset):
    rs_bin = dec_to_bin(int(rs), 5)
    offset_bin = dec_to_bin(int(offset), 12)
    rd_bin = dec_to_bin(int(rd), 5)

    if opcode == 'addi':
        Instruction = offset_bin + rs_bin + '000' + rd_bin + '0010011'

    if opcode == 'slti':
        Instruction = offset_bin + rs_bin + '001' + rd_bin + '0010011'
    
    if opcode == 'sltiu':
        Instruction = offset_bin + rs_bin + '011' + rd_bin + '0010011'

    if opcode == 'xori':
        Instruction = offset_bin + rs_bin + '100' + rd_bin + '0010011'

    if opcode == 'ori':
        Instruction = offset_bin + rs_bin + '110' + rd_bin + '0010011'
    
    if opcode == 'andi':
        Instruction = offset_bin + rs_bin + '111' + rd_bin + '0010011'

    print(Instruction[0:8], Instruction[8:16],
          Instruction[16:24], Instruction[24:32])
    return hex(int(Instruction, 2))


def Branch_Decoder(opcode, rs, rt, offset):
    rs_bin = dec_to_bin(int(rs), 5)
    offset_bin = dec_to_bin(int(offset), 12)
    rt_bin = dec_to_bin(int(rt), 5)

    if opcode == 'beq':
        Instruction = offset_bin[0] + offset_bin[2:8] + rt_bin + rs_bin + '000' + offset_bin[8:12] + offset_bin[1] + '1100011'

    if opcode == 'bne':
        Instruction = offset_bin[0] + offset_bin[2:8] + rt_bin + rs_bin + '001' + offset_bin[8:12] + offset_bin[1] + '1100011'

    if opcode == 'blt':
        Instruction = offset_bin[0] + offset_bin[2:8] + rt_bin + rs_bin + '100' + offset_bin[8:12] + offset_bin[1] + '1100011'

    if opcode == 'bge':  #convert to blt
        Instruction = offset_bin[0] + offset_bin[2:8] + rs_bin + rt_bin + '100' + offset_bin[8:12] + offset_bin[1] + '1100011'

    print(Instruction[0:8], Instruction[8:16],
          Instruction[16:24], Instruction[24:32])
    return hex(int(Instruction, 2))

def Jump_Decoder(opcode,offset):
    offset_bin = dec_to_bin(int(offset), 20)

    if opcode == 'j':
        Instruction = offset_bin[0] + offset_bin[10:] + \
            offset_bin[9] + offset_bin[1:9] + '00000' + '1101111'


    print(Instruction[0:8], Instruction[8:16],
          Instruction[16:24], Instruction[24:32])
    return hex(int(Instruction, 2))

def JAL_Decoder(opcode, rd, offset):
    offset_bin = dec_to_bin(int(offset), 20)
    rd_bin = dec_to_bin(int(rd), 5)
    
    if opcode == 'jal':
        Instruction = offset_bin[0] + offset_bin[10:] + \
            offset_bin[9] + offset_bin[1:9] + rd_bin + '1101111'

    print(Instruction[0:8], Instruction[8:16],
          Instruction[16:24], Instruction[24:32])
    return hex(int(Instruction, 2))

def JALR_Decoder(opcode, rd, rs, offset):
    rs_bin=dec_to_bin(int(rs), 5)
    offset_bin=dec_to_bin(int(offset), 12)
    rd_bin=dec_to_bin(int(rd), 5)

    Instruction= offset_bin + rs_bin + '000' + rd_bin + '1100111'
    
    print(Instruction[0:8], Instruction[8:16],
          Instruction[16:24], Instruction[24:32])
    
    return hex(int(Instruction, 2))

def dec_to_bin(dec_num,digit):
    if dec_num<0:
        return format(2**digit+dec_num,'b')
    else:
        return ('{:0'+str(digit)+'b}').format(dec_num,10)


def print_machinecode():
    fin = open('./assemblycode.txt', 'r')
    fout = open('./machinecode.txt', 'w')

    for instructions in fin.readlines():
        print(repr(instructions))
        print(mini_compiler2(instructions.split()), file=fout)
#        print('0xB', file=fout)
#        print('0xB', file=fout)
#        print('0xB', file=fout)

if __name__ == "__main__":
    #function_grammer()
    print_machinecode()
    
    


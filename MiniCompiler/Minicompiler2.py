'''rtype-v1 support Rtype lw sw
31-25 24-20 19-15 14-12 11-7 6-0
FUNC7 RS2   RS1   FUNC3 RD  OP

'''
def mini_compiler2():
    Rtype = ['add', 'sub', 'sll', 'xor', 'srl', 'or', 'and']
    load_word = 'lw'
    store_word = 'sw'
    assembly = input('Operation: ').split()
    print(assembly[0])
    if assembly[0] in Rtype:
        print(Rtype_Decoder(assembly[0], assembly[1], assembly[2], assembly[3]))
    
    if assembly[0] == load_word:
        print(LW_Decoder(assembly[0],assembly[1],assembly[2],assembly[3]))
    
    if assembly[0] == store_word:
        print(SW_Decoder(assembly[0],assembly[1],assembly[2],assembly[3]))
    
    if assembly[0] == 'nop':
        print('0xB')

def Rtype_Decoder(opcode,rd,rs,rt):
    rs_bin = dec_to_bin(int(rs),5)
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

    return hex(int(Instruction,2))


def LW_Decoder(opcode, rd, rs, offset):
    rd_bin = dec_to_bin(int(rd), 5)
    rs_bin = dec_to_bin(int(rs), 5)
    offset = dec_to_bin(int(offset), 12)
    
    Instruction = offset + rs_bin + '010' + rd_bin + '0000011'

    return hex(int(Instruction,2))

def SW_Decoder(opcode, rt, rs, offset):
    rt_bin=dec_to_bin(int(rt), 5)
    rs_bin=dec_to_bin(int(rs), 5)
    offset=dec_to_bin(int(offset), 12)
    Instruction = offset[0:7] + rt_bin + rs_bin + '010' + offset[7:] + '0100011'
    print(Instruction)
    return hex(int(Instruction,2))

def dec_to_bin(dec_num,digit):
    if dec_num<0:
        return format(2**digit+dec_num,'b')
    else:
        return ('{:0'+str(digit)+'b}').format(dec_num,10)

def function_grammer():
    print('Rtype: add rd, rs, rt')
    print('LW: lw rd, rs, offset')
    print('SW: sw rt, rs, offset')
if __name__ == "__main__":
    function_grammer()
    mini_compiler2()


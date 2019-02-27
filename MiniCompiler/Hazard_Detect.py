import Minicompiler_v2 

Rtype = ['add', 'sub', 'sll', 'xor', 'srl', 'or', 'and']
load_word = 'lw'
store_word = 'sw'
IMMEDIATE = ['addi', 'slti', 'sltiu', 'xori', 'ori', 'andi']
Branch = ['beq', 'bne', 'blt', 'bge']
Jump = 'j'
JAL = 'jal'
JALR = 'jalr'

def BJ_detect(opcode):
    if opcode in Branch:
        return True
    
    if opcode in Jump or opcode in JAL:
        return True

    if opcode in JALR:
        return True

    return False

def hazard_detect(instruction,rd):
    print('hazard_detect_function')
    if instruction[0] in Rtype:
        if rd == instruction[2] or rd == instruction[3]: #rd match Rtype source
            return True
    
    if instruction[0] == load_word: # rd match lw base
        if rd == instruction[2]:
            return True
    
    if instruction[0] == store_word: 
        if rd == instruction[2] or rd == instruction[3]: #rd match Sw source or base
            return True
    
    if instruction[0] in IMMEDIATE: # rd matches with source
        if rd == instruction[2]:
            return True

    if instruction[0] in Branch:
        print('dect_branch')
        print(instruction)
        print(repr(rd))
        print(repr(instruction[1]))
        print(rd == instruction[1])
        if rd == instruction[1] or rd == instruction[2]:
            print('2')
            return True
    
    if instruction[0] in Jump or instruction[0] in JAL:
        return False

    if instruction[0] in JALR:
        if rd == instruction[2]:
            return True

    return False

if __name__ == "__main__":
    function_grammer()
    hazard_detect()

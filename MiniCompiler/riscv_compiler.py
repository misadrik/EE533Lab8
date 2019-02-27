import Minicompiler_v2 
import Hazard_Detect

def riscv_compiler():
    fin = open('./assemblycode.txt','r')
    fout = open('./machinecode.txt', 'w')
    foutlog = open('./compilerlog','w')

    INSTR = []

    for instruction in fin.readlines(): #get all the instructions
        INSTR.append(instruction.split())
    
    instr_count = INSTR.__len__()
    
    for num,instr in enumerate(INSTR):
        print(Minicompiler_v2.mini_compiler2(instr), file=fout)
        # print(Minicompiler_v2.mini_compiler2(instr))  # test
        # print(bin(int(Minicompiler_v2.mini_compiler2(instr),16)))
        
        if Hazard_Detect.BJ_detect(instr[0]) and (num != (instr_count-1)):
            print('0xB', file=fout)
            print('0xB', file=fout)
            print('0xB', file=fout)
        
        elif instr[0] == 'nop':
            pass
        else:
            # print('hazard_detect')
            if(num + 1 < instr_count):
                if Hazard_Detect.hazard_detect(INSTR[num+1], instr[1]):
                    print('0xB', file=fout)
                    print('0xB', file=fout)
                    print('0xB', file=fout)
                    continue;

            if(num + 2 < instr_count):
                if Hazard_Detect.hazard_detect(INSTR[num+2], instr[1]):
                    print('0xB', file=fout)
                    print('0xB', file=fout)
                    continue;

            if(num + 3 < instr_count):
                if Hazard_Detect.hazard_detect(INSTR[num+3], instr[1]):
                    print('0xB', file=fout)
                    continue;


if __name__ == "__main__":
    riscv_compiler()

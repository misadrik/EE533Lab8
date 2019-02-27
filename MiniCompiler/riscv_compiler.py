import Minicompiler_v2 
import Hazard_Detect

def riscv_compiler():
    fin = open('./assemblycode.txt','r')
    fout = open('./machinecode.txt', 'w')
    foutlog = open('./compilerlog.txt','w')

    INSTR = []

    for instruction in fin.readlines(): #get all the instructions
        INSTR.append(instruction.split())
    
    instr_count = INSTR.__len__()
    
    for num,instr in enumerate(INSTR):
        print(' ', file = foutlog)
        print(Minicompiler_v2.mini_compiler2(instr), file=fout)

        print(instr, file=foutlog)
        print(Minicompiler_v2.mini_compiler2(instr), file = foutlog)
        print(bin(int(Minicompiler_v2.mini_compiler2(instr),16)),file = foutlog)

        print('Examing instruction: ' + str(num+1),file = foutlog)

        if Hazard_Detect.BJ_detect(instr[0]) and (num != (instr_count-1)):
            print('instruction: '+ str(num+1)+ ' is a branch/Jump type',file = foutlog)
            print('0xB', file=fout)
            print('0xB', file=fout)
            print('0xB', file=fout)
        
        elif instr[0] == 'nop':
            pass
        elif instr[0] == 'sw':
            print('sw detected it has no influence to others',file = foutlog)
            pass
        else:
            # print('hazard_detect')
            if(num + 1 < instr_count):
                print('Inspect instruction: ' + str(num+1) + ' Senior 1',file = foutlog)
                if Hazard_Detect.hazard_detect(INSTR[num+1], instr[1]):
                    print('Senior 1 is related',file = foutlog)
                    print('0xB', file=fout)
                    print('0xB', file=fout)
                    print('0xB', file=fout)
                    continue;

            if(num + 2 < instr_count):
                print('Inspect instruction: ' + str(num+1) + ' Senior 2',file = foutlog)
                if Hazard_Detect.hazard_detect(INSTR[num+2], instr[1]):
                    print('Senior 2 is related',file = foutlog)
                    print('0xB', file=fout)
                    print('0xB', file=fout)
                    continue;

            if(num + 3 < instr_count):
                print('Inspect instruction: ' + str(num+1) + ' Senior 1',file = foutlog)
                if Hazard_Detect.hazard_detect(INSTR[num+3], instr[1]):
                    print('Senior 3 is related', file=foutlog)
                    print('0xB', file=fout)
                    continue;


if __name__ == "__main__":
    riscv_compiler()

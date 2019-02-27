import Minicompiler_v2 
import Hazard_Detect

def assembly_imput():
    fin = open('./assemblycode.txt','r')
    fout = open('./machinecode.txt', 'w')

    INSTR = []

    for instruction in fin.readlines(): #get all the instructions
        INSTR.append(instruction.split())
    instr_count = INSTR.__len__()
    
    for num,instr in enumerate(INSTR):
        
        print(Minicompiler_v2.mini_compiler2(instr.split()), file=fout)

        if BJ_detect(instr[0]):
            print('0xB', file=fout)
            print('0xB', file=fout)
            print('0xB', file=fout)
        
        else if instr[0] == 'nop':
            pass
        else:
            if(num + 1 < instr_count):
                if hazard_detect(INSTR[num+1]):
                    print('0xB', file=fout)
                    print('0xB', file=fout)
                    print('0xB', file=fout)
                    continue;

            if(num + 2 < instr_count):
                if hazard_detect(INSTR[num+2]):
                    print('0xB', file=fout)
                    print('0xB', file=fout)
                    continue;

            if(num + 3 < instr_count):
                if hazard_detect(INSTR[num+3]):
                    print('0xB', file=fout)
                    continue;

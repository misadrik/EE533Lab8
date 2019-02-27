import os

ADDRESS_Interface = '0x200031c'
INSTR_Interface = '0x2000318'

foutlog = open('./instr_load.log', 'w')

def instr_load():
    fin = open('./machinecode.txt','r')

    print('loading instructions', file=foutlog)
    
    for num, instr in enumerate(fin.readlines()):
        # os.system('regwrite ' + ADDRESS_Interface + ' ' + hex(num))
        # os.system('regwrite ' + INSTR_Interface + ' ' + instr.strip())

        print('regwrite ' + ADDRESS_Interface + ' ' + hex(num), file = foutlog)
        print('regwrite ' + INSTR_Interface +
              ' ' + instr.strip(), file=foutlog)
        print(' ',file = foutlog)
    
def pipeline_disable():
    print('disabling pipeline',file = foutlog)
    pipeline_disable = '0x0000000'
    # os.system('regwrite ' + ADDRESS_Interface + pipeline_disable)
    print('regwrite ' + ADDRESS_Interface +' '+ pipeline_disable, file=foutlog)

if __name__ == "__main__":
    pipeline_disable()
    instr_load()

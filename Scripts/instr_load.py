import os

ADDRESS_Interface = '0x200031c'
INSTR_Interface = '0x2000318'
DATA_ADDR_Interface = '0x2000300'
DATA_LOW_Interface = '0x2000308'
DATA_HIGH_Interface = '0x2000304'

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
    os.system('regwrite ' + ADDRESS_Interface + pipeline_disable)
    print('regwrite ' + ADDRESS_Interface +' '+ pipeline_disable, file=foutlog)

def data_write():
    data_wr_en = 0x100
    data_high = ['0x0','0x0','0x0','0x0','0x0']
    data_low = ['0x2', '0x2000', '4000','0x0','0x0']
    
    # number should be less than 256
    number = data_high.__len__() < data_low.__len__() ?data_high.__len__(): data_low.__len__()

    for num in range(number):
        os.system('regwrite' + DATA_ADDR_Interface + str(data_wr_en +num))
        os.system('regwrite' + DATA_HIGH_Interface + data_high[num])
        os.system('regwrite' + DATA_LOW_Interface + data_low[num])
        # print('regwrite' + DATA_ADDR_Interface +
        #                   str(data_wr_en + num))
        # print('regwrite' + DATA_HIGH_Interface + data_high[num])
        # print('regwrite' + DATA_LOW_Interface + data_low[num])

def data_write_disable():
    data_wr_disable = '0x000'
    os.system('regwrite' + DATA_ADDR_Interface + data_wr_disable)
    
if __name__ == "__main__":
    pipeline_disable()
    instr_load()
    data_write()
    data_write_disable()

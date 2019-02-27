import Minicompiler_v2 

def BJ_detect():
    if instruction[0] in Branch:
        return True
    
    if instruction[0] in Jump or instruction[0] in JAL:
        return True

    if instruction[0] in JALR:
        return True

    return True
def hazard_detect(instruction,rd):
    print(instruction[0])
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
        if rd == instruction[2] or rd == instruction[3]:
            return True
    
    if instruction[0] in Jump or instruction[0] in JAL:
        return False

    if instruction[0] in JALR:
        if rd == instruction[2]:
            return True

    return True

if __name__ == "__main__":
    function_grammer()
    hazard_detect()